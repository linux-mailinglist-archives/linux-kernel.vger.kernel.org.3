Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 854CE4EB753
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Mar 2022 02:05:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241364AbiC3AGs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Mar 2022 20:06:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41054 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236456AbiC3AGp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Mar 2022 20:06:45 -0400
X-Greylist: delayed 356 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Tue, 29 Mar 2022 17:05:01 PDT
Received: from mailout-pe-b.jellyfish.systems (mailout-pe-b.jellyfish.systems [63.250.43.94])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BADD83EBA3
        for <linux-kernel@vger.kernel.org>; Tue, 29 Mar 2022 17:05:00 -0700 (PDT)
Received: from NEW-01.privateemail.com (unknown [10.35.5.64])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by mailout-pe-b.jellyfish.systems (Postfix) with ESMTPSA id 4KSmkG1bT5zDqMr;
        Tue, 29 Mar 2022 23:59:02 +0000 (UTC)
Received: from MTA-15.privateemail.com (unknown [10.50.14.40])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by NEW-01.privateemail.com (Postfix) with ESMTPS id 1E75618000CD;
        Tue, 29 Mar 2022 19:59:02 -0400 (EDT)
Received: from mta-15.privateemail.com (localhost [127.0.0.1])
        by mta-15.privateemail.com (Postfix) with ESMTP id E450118000A1;
        Tue, 29 Mar 2022 19:59:01 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=gibson.sh; s=default;
        t=1648598342; bh=n7XQg0ovc2dGLvlf/P2HD8WsboW7ppR203pdepE97qA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=pKFH2H+pOAqB7Ppg8UutMWh9lZMYLR1VR9wT8TnlGEeU/8mNH4IUklrekhxwsxcl0
         yc/ZtCEA+eNNiU8CdSx80d9xsw7nqsQFgRn0h7VUDp4vYZ3g27zp/GVMvsBK3wxhbi
         1lNKN2fj5oNgJBaEV0CX2ons+P3ahQJZv3MUM7w6omBaZ0efU3CrUQU4iiZxbNZRh6
         sekfpmC8IDJffiVrj5Z3xpA7LPaAIyNuI1fQxlkRiE5gGcnIW//RZcASn8DUsCwGPs
         31kOe7lodAISBu6MLKkkcsGm5JcJCbGhMo98AurEicjSzfXMXdXTtvdvJA7j8YJy70
         Oi6VVGXXiGQPg==
Received: from spiderdemon.horst.lan (unknown [10.20.151.189])
        by mta-15.privateemail.com (Postfix) with ESMTPA id 421BE1800084;
        Tue, 29 Mar 2022 19:58:54 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=gibson.sh; s=default;
        t=1648598341; bh=n7XQg0ovc2dGLvlf/P2HD8WsboW7ppR203pdepE97qA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=i9CMuUOi54FdVNYYEtlJg66Du0rfnbLMdyLO8Kz0potECSrPHlszTrZPKiBeltDMc
         RRmoJNZ02rulxEzSfXr0KFYdjoTVC4/rnSlIf6+ZvUluTmPklHFX2MpfeSquXoBkIt
         9uzmRcfJJ6+sp8N03QI8fI7s7S9AJ5R99QoB8nvXAqnZ85zdD6xKshXVFTx+BTGI5Y
         KOGiRHiy5QVGGQ9VOAi6FY+rg4wpufRTBLUmcAPSfHMYTv5LPIDvmMSzhSulEUeQvP
         YkbPwGROhqANvtYfpzpiyjIJXtqT6WTdL8+pObBX6pa2xLUtIb20mC/kG3iw4PEZhA
         wSM0jaiCWV/pg==
From:   Daniel Gibson <daniel@gibson.sh>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>, linux-kernel@vger.kernel.org
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Peter Hurley <peter@hurleysoftware.com>,
        Daniel Gibson <daniel@gibson.sh>
Subject: [PATCH 1/1] tty: n_tty: Restore EOF push handling behavior
Date:   Wed, 30 Mar 2022 01:58:10 +0200
Message-Id: <20220329235810.452513-2-daniel@gibson.sh>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220329235810.452513-1-daniel@gibson.sh>
References: <20220329235810.452513-1-daniel@gibson.sh>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Virus-Scanned: ClamAV using ClamSMTP
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

TTYs in ICANON mode have a special case that allows "pushing" a line
without a regular EOL character (like newline), by using EOF (the EOT
character - ASCII 0x4) as a pseudo-EOL. It is silently discarded, so
the reader of the PTS will receive the line *without* EOF or any other
terminating character.

This special case has an edge case: What happens if the readers buffer
is the same size as the line (without EOF)? Will they be able to tell
if the whole line is received, i.e. if the next read() will return more
of the same line or the next line?

There are two possibilities,  that both have (dis)advantages:

1. The next read() returns 0. FreeBSD (13.0) and OSX (10.11) do this.
   Advantage: The reader can interpret this as "the line is over".
   Disadvantage: read() returning 0 means EOF, the reader could also
   interpret it as "there's no more data" and stop reading or even
   close the PT.

2. The next read() returns the next line, the EOF is silently discarded.
   Solaris (or at least OpenIndiana 2021.10) does this, Linux has done
   do this since commit 40d5e0905a03 ("n_tty: Fix EOF push handling");
   this behavior was recently broken by commit 359303076163 ("tty:
   n_tty: do not look ahead for EOL character past the end of the buffer").
   Advantage: read() won't return 0 (EOF), reader less likely to be
   confused (and things like `while(read(..)>0)` don't break)
   Disadvantage: The reader can't really know if the read() continues
   the last line (that filled the whole read buffer) or starts a
   new line.

As both options are defensible (and are used by other Unix-likes), it's
best to stick to the "old" behavior since "n_tty: Fix EOF push handling"
of 2013, i.e. silently discard that EOF.

This patch - that I actually got from Linus for testing and only
modified slightly - restores that behavior by skipping an EOF
character if it's the next character after reading is done.

Based on a patch from Linus Torvalds.

Fixes: 359303076163 ("tty: n_tty: do not look ahead for EOL character past the end of the buffer")
Link: https://bugzilla.kernel.org/show_bug.cgi?id=215611
Signed-off-by: Daniel Gibson <daniel@gibson.sh>
Reviewed-and-tested-by: Daniel Gibson <daniel@gibson.sh>
Acked-by: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Peter Hurley <peter@hurleysoftware.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Jiri Slaby <jirislaby@kernel.org>
---
 drivers/tty/n_tty.c | 38 +++++++++++++++++++++++++++++++++++++-
 1 file changed, 37 insertions(+), 1 deletion(-)

diff --git a/drivers/tty/n_tty.c b/drivers/tty/n_tty.c
index efc72104c840..bdc314aeab88 100644
--- a/drivers/tty/n_tty.c
+++ b/drivers/tty/n_tty.c
@@ -1975,6 +1975,35 @@ static bool canon_copy_from_read_buf(struct tty_struct *tty,
 	return ldata->read_tail != canon_head;
 }
 
+/*
+ * If we finished a read at the exact location of an
+ * EOF (special EOL character that's a __DISABLED_CHAR)
+ * in the stream, silently eat the EOF.
+ */
+static void canon_skip_eof(struct tty_struct *tty)
+{
+	struct n_tty_data *ldata = tty->disc_data;
+	size_t tail, canon_head;
+
+	canon_head = smp_load_acquire(&ldata->canon_head);
+	tail = ldata->read_tail;
+
+	// No data?
+	if (tail == canon_head)
+		return;
+
+	// See if the tail position is EOF in the circular buffer
+	tail &= (N_TTY_BUF_SIZE - 1);
+	if (!test_bit(tail, ldata->read_flags))
+		return;
+	if (read_buf(ldata, tail) != __DISABLED_CHAR)
+		return;
+
+	// Clear the EOL bit, skip the EOF char.
+	clear_bit(tail, ldata->read_flags);
+	smp_store_release(&ldata->read_tail, ldata->read_tail + 1);
+}
+
 /**
  * job_control		-	check job control
  * @tty: tty
@@ -2045,7 +2074,14 @@ static ssize_t n_tty_read(struct tty_struct *tty, struct file *file,
 	 */
 	if (*cookie) {
 		if (ldata->icanon && !L_EXTPROC(tty)) {
-			if (canon_copy_from_read_buf(tty, &kb, &nr))
+			/*
+			 * If we have filled the user buffer, see
+			 * if we should skip an EOF character before
+			 * releasing the lock and returning done.
+			 */
+			if (!nr)
+				canon_skip_eof(tty);
+			else if (canon_copy_from_read_buf(tty, &kb, &nr))
 				return kb - kbuf;
 		} else {
 			if (copy_from_read_buf(tty, &kb, &nr))
-- 
2.25.1

