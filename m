Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AF6E9565E65
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Jul 2022 22:23:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229641AbiGDUX0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Jul 2022 16:23:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38666 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229944AbiGDUXW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Jul 2022 16:23:22 -0400
Received: from smtp.smtpout.orange.fr (smtp03.smtpout.orange.fr [80.12.242.125])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7348926A
        for <linux-kernel@vger.kernel.org>; Mon,  4 Jul 2022 13:23:21 -0700 (PDT)
Received: from pop-os.home ([90.11.190.129])
        by smtp.orange.fr with ESMTPA
        id 8SbGooXMG4Ltq8SbGotLem; Mon, 04 Jul 2022 22:23:19 +0200
X-ME-Helo: pop-os.home
X-ME-Auth: YWZlNiIxYWMyZDliZWIzOTcwYTEyYzlhMmU3ZiQ1M2U2MzfzZDfyZTMxZTBkMTYyNDBjNDJlZmQ3ZQ==
X-ME-Date: Mon, 04 Jul 2022 22:23:19 +0200
X-ME-IP: 90.11.190.129
From:   Christophe JAILLET <christophe.jaillet@wanadoo.fr>
To:     Robin Holt <robinmholt@gmail.com>, Steve Wahl <steve.wahl@hpe.com>,
        Mike Travis <mike.travis@hpe.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Subject: [PATCH] sgi-xp: Use the bitmap API to allocate bitmaps
Date:   Mon,  4 Jul 2022 22:23:17 +0200
Message-Id: <ef49726d60f6a531428609f60a2398b6c3d9a26e.1656966181.git.christophe.jaillet@wanadoo.fr>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use bitmap_zalloc()/bitmap_free() instead of hand-writing them.

It is less verbose and it improves the semantic.

While at it, remove a useless cast in a bitmap_empty() call.

Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
---
 drivers/misc/sgi-xp/xpnet.c | 13 ++++++-------
 1 file changed, 6 insertions(+), 7 deletions(-)

diff --git a/drivers/misc/sgi-xp/xpnet.c b/drivers/misc/sgi-xp/xpnet.c
index 50644f83e78c..2396ba3b03bd 100644
--- a/drivers/misc/sgi-xp/xpnet.c
+++ b/drivers/misc/sgi-xp/xpnet.c
@@ -285,7 +285,7 @@ xpnet_connection_activity(enum xp_retval reason, short partid, int channel,
 		__clear_bit(partid, xpnet_broadcast_partitions);
 		spin_unlock_bh(&xpnet_broadcast_lock);
 
-		if (bitmap_empty((unsigned long *)xpnet_broadcast_partitions,
+		if (bitmap_empty(xpnet_broadcast_partitions,
 				 xp_max_npartitions)) {
 			netif_carrier_off(xpnet_device);
 		}
@@ -522,9 +522,8 @@ xpnet_init(void)
 
 	dev_info(xpnet, "registering network device %s\n", XPNET_DEVICE_NAME);
 
-	xpnet_broadcast_partitions = kcalloc(BITS_TO_LONGS(xp_max_npartitions),
-					     sizeof(long),
-					     GFP_KERNEL);
+	xpnet_broadcast_partitions = bitmap_zalloc(xp_max_npartitions,
+						   GFP_KERNEL);
 	if (xpnet_broadcast_partitions == NULL)
 		return -ENOMEM;
 
@@ -535,7 +534,7 @@ xpnet_init(void)
 	xpnet_device = alloc_netdev(0, XPNET_DEVICE_NAME, NET_NAME_UNKNOWN,
 				    ether_setup);
 	if (xpnet_device == NULL) {
-		kfree(xpnet_broadcast_partitions);
+		bitmap_free(xpnet_broadcast_partitions);
 		return -ENOMEM;
 	}
 
@@ -574,7 +573,7 @@ xpnet_init(void)
 	result = register_netdev(xpnet_device);
 	if (result != 0) {
 		free_netdev(xpnet_device);
-		kfree(xpnet_broadcast_partitions);
+		bitmap_free(xpnet_broadcast_partitions);
 	}
 
 	return result;
@@ -590,7 +589,7 @@ xpnet_exit(void)
 
 	unregister_netdev(xpnet_device);
 	free_netdev(xpnet_device);
-	kfree(xpnet_broadcast_partitions);
+	bitmap_free(xpnet_broadcast_partitions);
 }
 
 module_exit(xpnet_exit);
-- 
2.34.1

