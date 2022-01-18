Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E6F86491E97
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jan 2022 05:44:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235572AbiAREoN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Jan 2022 23:44:13 -0500
Received: from drummond.us ([74.95.14.229]:57827 "EHLO
        talisker.home.drummond.us" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S233953AbiAREoM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jan 2022 23:44:12 -0500
Received: from talisker.home.drummond.us (localhost [127.0.0.1])
        by talisker.home.drummond.us (8.15.2/8.15.2/Debian-20) with ESMTP id 20I4hRV3765137;
        Mon, 17 Jan 2022 20:43:27 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=home.drummond.us;
        s=default; t=1642481007;
        bh=C33vN6CPT/HEDKGEmqoVQ0LAeaGikWH7tPLrUQBywK4=;
        h=From:To:Cc:Subject:Date:From;
        b=lA+NJRvQJz0KbtKF54vr+Na96vSKNY7Zy+qcXAx1VCsw6NFeI8HbMnvdJzS5e4pqk
         te64TKikVYBVLHpjzCJJ3w1mKk24u4JHiiz/W4lwZ3koUEfbgdatmDdGPI/U8zxvCU
         AbTxAxEduEu81b9hYbTZjexjyKacrXZwiFwg649Mz73z3OyASwKSAz1L8WviGJlZD2
         MPliaNTMUTJmkpoJmQ96ydhAlwmMquzUi4sJ4i4cYNZmCD/okmYWI0Ufjyg/wnEudm
         qP5wEV7CKr5tBwYaZZwizH/X/i9YeMQ9HRv+fToU49BQxOh7Yioi+o7MY1tF9/ZemO
         A0Duf2D9EuJiA==
Received: (from walt@localhost)
        by talisker.home.drummond.us (8.15.2/8.15.2/Submit) id 20I4hRLI765136;
        Mon, 17 Jan 2022 20:43:27 -0800
From:   Walt Drummond <walt@drummond.us>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>
Cc:     ar@cs.msu.ru, linux-kernel@vger.kernel.org, walt@drummond.us
Subject: [PATCH 1/3] vstatus: Allow the n_tty line dicipline to write to a user tty
Date:   Mon, 17 Jan 2022 20:43:21 -0800
Message-Id: <20220118044323.765038-1-walt@drummond.us>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Refactor the implementation of n_tty_write() into do_n_tty_write(), and
change n_tty_write() to call do_n_tty_write() after acquiring
tty.termios_rwsem.

This allows the n_tty line dicipline to write to a user tty via
do_n_tty_write() when already holding tty.termios_rwsem.

Signed-off-by: Walt Drummond <walt@drummond.us>
---
 drivers/tty/n_tty.c | 76 ++++++++++++++++++++++++++-------------------
 1 file changed, 44 insertions(+), 32 deletions(-)

diff --git a/drivers/tty/n_tty.c b/drivers/tty/n_tty.c
index 5be6d02dc690..6a6e7da80095 100644
--- a/drivers/tty/n_tty.c
+++ b/drivers/tty/n_tty.c
@@ -2231,29 +2231,7 @@ static ssize_t n_tty_read(struct tty_struct *tty, struct file *file,
 	return retval;
 }
 
-/**
- *	n_tty_write		-	write function for tty
- *	@tty: tty device
- *	@file: file object
- *	@buf: userspace buffer pointer
- *	@nr: size of I/O
- *
- *	Write function of the terminal device.  This is serialized with
- *	respect to other write callers but not to termios changes, reads
- *	and other such events.  Since the receive code will echo characters,
- *	thus calling driver write methods, the output_lock is used in
- *	the output processing functions called here as well as in the
- *	echo processing function to protect the column state and space
- *	left in the buffer.
- *
- *	This code must be sure never to sleep through a hangup.
- *
- *	Locking: output_lock to protect column state and space left
- *		 (note that the process_output*() functions take this
- *		  lock themselves)
- */
-
-static ssize_t n_tty_write(struct tty_struct *tty, struct file *file,
+static ssize_t do_n_tty_write(struct tty_struct *tty, struct file *file,
 			   const unsigned char *buf, size_t nr)
 {
 	const unsigned char *b = buf;
@@ -2261,14 +2239,7 @@ static ssize_t n_tty_write(struct tty_struct *tty, struct file *file,
 	int c;
 	ssize_t retval = 0;
 
-	/* Job control check -- must be done at start (POSIX.1 7.1.1.4). */
-	if (L_TOSTOP(tty) && file->f_op->write_iter != redirected_tty_write) {
-		retval = tty_check_change(tty);
-		if (retval)
-			return retval;
-	}
-
-	down_read(&tty->termios_rwsem);
+	lockdep_assert_held_read(&tty->termios_rwsem);
 
 	/* Write out any echoed characters that are still pending */
 	process_echoes(tty);
@@ -2336,10 +2307,51 @@ static ssize_t n_tty_write(struct tty_struct *tty, struct file *file,
 	remove_wait_queue(&tty->write_wait, &wait);
 	if (nr && tty->fasync)
 		set_bit(TTY_DO_WRITE_WAKEUP, &tty->flags);
-	up_read(&tty->termios_rwsem);
+
 	return (b - buf) ? b - buf : retval;
 }
 
+/**
+ *	n_tty_write		-	write function for tty
+ *	@tty: tty device
+ *	@file: file object
+ *	@buf: userspace buffer pointer
+ *	@nr: size of I/O
+ *
+ *	Write function of the terminal device.  This is serialized with
+ *	respect to other write callers but not to termios changes, reads
+ *	and other such events.  Since the receive code will echo characters,
+ *	thus calling driver write methods, the output_lock is used in
+ *	the output processing functions called here as well as in the
+ *	echo processing function to protect the column state and space
+ *	left in the buffer.
+ *
+ *	This code must be sure never to sleep through a hangup.
+ *
+ *	Locking: output_lock to protect column state and space left
+ *		 (note that the process_output*() functions take this
+ *		  lock themselves)
+ */
+
+static ssize_t n_tty_write(struct tty_struct *tty, struct file *file,
+			   const unsigned char *buf, size_t nr)
+{
+	ssize_t retval = 0;
+
+	/* Job control check -- must be done at start (POSIX.1 7.1.1.4). */
+	if (L_TOSTOP(tty) && file->f_op->write_iter != redirected_tty_write) {
+		retval = tty_check_change(tty);
+		if (retval)
+			return retval;
+	}
+
+	down_read(&tty->termios_rwsem);
+	retval = do_n_tty_write(tty, file, buf, nr);
+	up_read(&tty->termios_rwsem);
+
+	return retval;
+}
+
 /**
  *	n_tty_poll		-	poll method for N_TTY
  *	@tty: terminal device
-- 
2.30.2

