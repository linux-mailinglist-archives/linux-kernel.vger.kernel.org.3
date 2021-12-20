Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EB2EF47AA68
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Dec 2021 14:33:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232942AbhLTNdI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Dec 2021 08:33:08 -0500
Received: from mga01.intel.com ([192.55.52.88]:2146 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230176AbhLTNdH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Dec 2021 08:33:07 -0500
X-IronPort-AV: E=McAfee;i="6200,9189,10203"; a="264348002"
X-IronPort-AV: E=Sophos;i="5.88,220,1635231600"; 
   d="scan'208";a="264348002"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Dec 2021 05:33:07 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,220,1635231600"; 
   d="scan'208";a="547332616"
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga001.jf.intel.com with ESMTP; 20 Dec 2021 05:33:05 -0800
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id 91449190; Mon, 20 Dec 2021 15:33:13 +0200 (EET)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org
Cc:     Jiri Slaby <jirislaby@kernel.org>,
        Oliver Neukum <oneukum@suse.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH v1 1/1] tty: tty_io: Switch to vmalloc() fallback in case of TTY_NO_WRITE_SPLIT
Date:   Mon, 20 Dec 2021 15:32:50 +0200
Message-Id: <20211220133250.3070-1-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When TTY_NO_WRITE_SPLIT is set and 64 KiB chunks are used, allow
vmalloc() fallback. Supply __GFP_RETRY_MAYFAIL to make kmalloc()
preferable over vmalloc() since we may want a better performance.

Note, both current users copy data to another buffer anyway, so
the type of our allocation doesn't affect their expectations.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/tty/tty_io.c        | 9 +++------
 drivers/usb/class/cdc-acm.c | 4 ----
 2 files changed, 3 insertions(+), 10 deletions(-)

diff --git a/drivers/tty/tty_io.c b/drivers/tty/tty_io.c
index 6616d4a0d41d..8fedfe88dff7 100644
--- a/drivers/tty/tty_io.c
+++ b/drivers/tty/tty_io.c
@@ -170,7 +170,7 @@ static void free_tty_struct(struct tty_struct *tty)
 {
 	tty_ldisc_deinit(tty);
 	put_device(tty->dev);
-	kfree(tty->write_buf);
+	kvfree(tty->write_buf);
 	tty->magic = 0xDEADDEAD;
 	kfree(tty);
 }
@@ -997,9 +997,6 @@ static inline ssize_t do_tty_write(
 	 * layer has problems with bigger chunks. It will
 	 * claim to be able to handle more characters than
 	 * it actually does.
-	 *
-	 * FIXME: This can probably go away now except that 64K chunks
-	 * are too likely to fail unless switched to vmalloc...
 	 */
 	chunk = 2048;
 	if (test_bit(TTY_NO_WRITE_SPLIT, &tty->flags))
@@ -1014,12 +1011,12 @@ static inline ssize_t do_tty_write(
 		if (chunk < 1024)
 			chunk = 1024;
 
-		buf_chunk = kmalloc(chunk, GFP_KERNEL);
+		buf_chunk = kvmalloc(chunk, GFP_KERNEL | __GFP_RETRY_MAYFAIL);
 		if (!buf_chunk) {
 			ret = -ENOMEM;
 			goto out;
 		}
-		kfree(tty->write_buf);
+		kvfree(tty->write_buf);
 		tty->write_cnt = chunk;
 		tty->write_buf = buf_chunk;
 	}
diff --git a/drivers/usb/class/cdc-acm.c b/drivers/usb/class/cdc-acm.c
index b3ce7338cb6b..9b9aea24d58c 100644
--- a/drivers/usb/class/cdc-acm.c
+++ b/drivers/usb/class/cdc-acm.c
@@ -685,10 +685,6 @@ static int acm_port_activate(struct tty_port *port, struct tty_struct *tty)
 	if (retval)
 		goto error_get_interface;
 
-	/*
-	 * FIXME: Why do we need this? Allocating 64K of physically contiguous
-	 * memory is really nasty...
-	 */
 	set_bit(TTY_NO_WRITE_SPLIT, &tty->flags);
 	acm->control->needs_remote_wakeup = 1;
 
-- 
2.34.1

