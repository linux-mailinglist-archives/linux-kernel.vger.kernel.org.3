Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B1D0F4B6EB5
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Feb 2022 15:18:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238565AbiBOOSb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Feb 2022 09:18:31 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:41576 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235378AbiBOOSa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Feb 2022 09:18:30 -0500
Received: from smtp1.axis.com (smtp1.axis.com [195.60.68.17])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 26B53B109F
        for <linux-kernel@vger.kernel.org>; Tue, 15 Feb 2022 06:18:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=axis.com; q=dns/txt; s=axis-central1; t=1644934697;
  x=1676470697;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=ABQC/ZHMK1zK6Pl+rj02snzZsvn6jYTS+6l3WtOK+RM=;
  b=jTAHNGmr5pvmnHEOmr1rbZsSzwkxdeckVZq9MIcOgcjAYgIX0MIbmZqc
   c4znv59AZfVUfC1CeGGU7qfJX2GYa9VpjKV2IDAkKTbyogYhSG6sPJ7vx
   Tn5bIPvl8/oD4keReiUkh07xK+drUV9rQgGZA7mutQHcbPOnBmofSzylb
   AddrVC9q0JKTs3ASNegDm2BZzBnlxKpih9b0E1i53BeFe0lbASAElBzeI
   GxLmcE1IKjhROMDa4d+y3keqRcBqkR12O0VOuAKkGLR02f5LAWZkrryd1
   5iV8AFShH3+5to1oCA/lPvGZFSueh1FfZemm9QFtuZOk9GWEh5QvswY4F
   Q==;
From:   Vincent Whitchurch <vincent.whitchurch@axis.com>
To:     Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
CC:     <kernel@axis.com>,
        Vincent Whitchurch <vincent.whitchurch@axis.com>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH] char: ttyprintk: register console
Date:   Tue, 15 Feb 2022 15:17:49 +0100
Message-ID: <20220215141750.92808-1-vincent.whitchurch@axis.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Register a console in the ttyprintk driver so that it can be selected
for /dev/console with console=ttyprintk on the kernel command line,
similar to other console drivers.

Signed-off-by: Vincent Whitchurch <vincent.whitchurch@axis.com>
---
 drivers/char/Kconfig     |  3 ++-
 drivers/char/ttyprintk.c | 16 ++++++++++++++++
 2 files changed, 18 insertions(+), 1 deletion(-)

diff --git a/drivers/char/Kconfig b/drivers/char/Kconfig
index 740811893c57..c553a8a50d03 100644
--- a/drivers/char/Kconfig
+++ b/drivers/char/Kconfig
@@ -18,7 +18,8 @@ config TTY_PRINTK
 	  The feature is useful to inline user messages with kernel
 	  messages.
 	  In order to use this feature, you should output user messages
-	  to /dev/ttyprintk or redirect console to this TTY.
+	  to /dev/ttyprintk or redirect console to this TTY, or boot
+	  the kernel with console=ttyprintk.
 
 	  If unsure, say N.
 
diff --git a/drivers/char/ttyprintk.c b/drivers/char/ttyprintk.c
index adf941c47506..ed45d04905c2 100644
--- a/drivers/char/ttyprintk.c
+++ b/drivers/char/ttyprintk.c
@@ -11,6 +11,7 @@
  * of the boot process, for example.
  */
 
+#include <linux/console.h>
 #include <linux/device.h>
 #include <linux/serial.h>
 #include <linux/tty.h>
@@ -163,6 +164,18 @@ static const struct tty_port_operations tpk_port_ops = {
 
 static struct tty_driver *ttyprintk_driver;
 
+static struct tty_driver *ttyprintk_console_device(struct console *c,
+						   int *index)
+{
+	*index = 0;
+	return ttyprintk_driver;
+}
+
+static struct console ttyprintk_console = {
+	.name = "ttyprintk",
+	.device = ttyprintk_console_device,
+};
+
 static int __init ttyprintk_init(void)
 {
 	int ret;
@@ -195,6 +208,8 @@ static int __init ttyprintk_init(void)
 		goto error;
 	}
 
+	register_console(&ttyprintk_console);
+
 	return 0;
 
 error:
@@ -205,6 +220,7 @@ static int __init ttyprintk_init(void)
 
 static void __exit ttyprintk_exit(void)
 {
+	unregister_console(&ttyprintk_console);
 	tty_unregister_driver(ttyprintk_driver);
 	tty_driver_kref_put(ttyprintk_driver);
 	tty_port_destroy(&tpk_port.port);
-- 
2.34.1

