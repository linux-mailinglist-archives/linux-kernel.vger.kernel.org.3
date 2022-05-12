Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2A21D524E01
	for <lists+linux-kernel@lfdr.de>; Thu, 12 May 2022 15:15:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354091AbiELNPP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 May 2022 09:15:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52340 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1353288AbiELNPN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 May 2022 09:15:13 -0400
Received: from muru.com (muru.com [72.249.23.125])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id B619C223879;
        Thu, 12 May 2022 06:15:12 -0700 (PDT)
Received: from hillo.muru.com (localhost [127.0.0.1])
        by muru.com (Postfix) with ESMTP id A184480B3;
        Thu, 12 May 2022 13:11:35 +0000 (UTC)
From:   Tony Lindgren <tony@atomide.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Daniel Starke <daniel.starke@siemens.com>,
        Gregory CLEMENT <gregory.clement@bootlin.com>,
        Jiri Slaby <jirislaby@kernel.org>,
        Johan Hovold <johan@kernel.org>,
        Zhenguo Zhao <Zhenguo.Zhao1@unisoc.com>,
        linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org,
        Stephen Boyd <swboyd@chromium.org>
Subject: [PATCH] tty: n_gsm: Fix packet data hex dump output
Date:   Thu, 12 May 2022 16:15:06 +0300
Message-Id: <20220512131506.1216-1-tony@atomide.com>
X-Mailer: git-send-email 2.36.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The module param debug for n_gsm uses KERN_INFO level, but the hexdump
now uses KERN_DEBUG level. This started after commit 091cb0994edd
("lib/hexdump: make print_hex_dump_bytes() a nop on !DEBUG builds").
We now use dynamic_hex_dump() unless DEBUG is set.

This causes no packets to be seen with modprobe n_gsm debug=0x1f unlike
earlier. Let's fix this by adding gsm_hex_dump_bytes() that calls
print_hex_dump() with KERN_INFO to match what n_gsm is doing with the
other debug related output.

Fixes: 091cb0994edd ("lib/hexdump: make print_hex_dump_bytes() a nop on !DEBUG builds")
Cc: Stephen Boyd <swboyd@chromium.org>
Signed-off-by: Tony Lindgren <tony@atomide.com>
---
 drivers/tty/n_gsm.c | 31 +++++++++++++++++++++++--------
 1 file changed, 23 insertions(+), 8 deletions(-)

diff --git a/drivers/tty/n_gsm.c b/drivers/tty/n_gsm.c
--- a/drivers/tty/n_gsm.c
+++ b/drivers/tty/n_gsm.c
@@ -443,6 +443,25 @@ static u8 gsm_encode_modem(const struct gsm_dlci *dlci)
 	return modembits;
 }
 
+static void gsm_hex_dump_bytes(const char *fname, const u8 *data,
+			       unsigned long len)
+{
+	char *prefix;
+
+	if (!fname) {
+		print_hex_dump(KERN_INFO, "", DUMP_PREFIX_NONE, 16, 1, data, len,
+			       true);
+		return;
+	}
+
+	prefix = kasprintf(GFP_KERNEL, "%s: ", fname);
+	if (!prefix)
+		return;
+	print_hex_dump(KERN_INFO, prefix, DUMP_PREFIX_OFFSET, 16, 1, data, len,
+		       true);
+	kfree(prefix);
+}
+
 /**
  *	gsm_print_packet	-	display a frame for debug
  *	@hdr: header to print before decode
@@ -507,7 +526,7 @@ static void gsm_print_packet(const char *hdr, int addr, int cr,
 	else
 		pr_cont("(F)");
 
-	print_hex_dump_bytes("", DUMP_PREFIX_NONE, data, dlen);
+	gsm_hex_dump_bytes(NULL, data, dlen);
 }
 
 
@@ -697,9 +716,7 @@ static void gsm_data_kick(struct gsm_mux *gsm, struct gsm_dlci *dlci)
 		}
 
 		if (debug & 4)
-			print_hex_dump_bytes("gsm_data_kick: ",
-					     DUMP_PREFIX_OFFSET,
-					     gsm->txframe, len);
+			gsm_hex_dump_bytes(__func__, gsm->txframe, len);
 		if (gsmld_output(gsm, gsm->txframe, len) <= 0)
 			break;
 		/* FIXME: Can eliminate one SOF in many more cases */
@@ -2442,8 +2459,7 @@ static int gsmld_output(struct gsm_mux *gsm, u8 *data, int len)
 		return -ENOSPC;
 	}
 	if (debug & 4)
-		print_hex_dump_bytes("gsmld_output: ", DUMP_PREFIX_OFFSET,
-				     data, len);
+		gsm_hex_dump_bytes(__func__, data, len);
 	return gsm->tty->ops->write(gsm->tty, data, len);
 }
 
@@ -2519,8 +2535,7 @@ static void gsmld_receive_buf(struct tty_struct *tty, const unsigned char *cp,
 	char flags = TTY_NORMAL;
 
 	if (debug & 4)
-		print_hex_dump_bytes("gsmld_receive: ", DUMP_PREFIX_OFFSET,
-				     cp, count);
+		gsm_hex_dump_bytes(__func__, cp, count);
 
 	for (; count; count--, cp++) {
 		if (fp)
-- 
2.36.1
