Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 98CD2570A79
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Jul 2022 21:14:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231703AbiGKTOu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Jul 2022 15:14:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55080 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229740AbiGKTOr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Jul 2022 15:14:47 -0400
Received: from smtp.smtpout.orange.fr (smtp04.smtpout.orange.fr [80.12.242.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 530FC27142
        for <linux-kernel@vger.kernel.org>; Mon, 11 Jul 2022 12:14:45 -0700 (PDT)
Received: from pop-os.home ([90.11.190.129])
        by smtp.orange.fr with ESMTPA
        id AyrgoNRqsm7vsAyrhoPkTU; Mon, 11 Jul 2022 21:14:42 +0200
X-ME-Helo: pop-os.home
X-ME-Auth: YWZlNiIxYWMyZDliZWIzOTcwYTEyYzlhMmU3ZiQ1M2U2MzfzZDfyZTMxZTBkMTYyNDBjNDJlZmQ3ZQ==
X-ME-Date: Mon, 11 Jul 2022 21:14:42 +0200
X-ME-IP: 90.11.190.129
From:   Christophe JAILLET <christophe.jaillet@wanadoo.fr>
To:     Frederic Barrat <fbarrat@linux.ibm.com>,
        Andrew Donnellan <ajd@linux.ibm.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        linuxppc-dev@lists.ozlabs.org
Subject: [PATCH 1/2] cxl: Use the bitmap API to allocate bitmaps
Date:   Mon, 11 Jul 2022 21:14:38 +0200
Message-Id: <59010cc7c62443030c69cb1ce0b2b62c5d47e064.1657566849.git.christophe.jaillet@wanadoo.fr>
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

Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
---
 drivers/misc/cxl/context.c | 2 +-
 drivers/misc/cxl/guest.c   | 2 +-
 drivers/misc/cxl/irq.c     | 3 +--
 drivers/misc/cxl/of.c      | 5 ++---
 4 files changed, 5 insertions(+), 7 deletions(-)

diff --git a/drivers/misc/cxl/context.c b/drivers/misc/cxl/context.c
index e627b4056623..acaa44809c58 100644
--- a/drivers/misc/cxl/context.c
+++ b/drivers/misc/cxl/context.c
@@ -331,7 +331,7 @@ static void reclaim_ctx(struct rcu_head *rcu)
 		__free_page(ctx->ff_page);
 	ctx->sstp = NULL;
 
-	kfree(ctx->irq_bitmap);
+	bitmap_free(ctx->irq_bitmap);
 
 	/* Drop ref to the afu device taken during cxl_context_init */
 	cxl_afu_put(ctx->afu);
diff --git a/drivers/misc/cxl/guest.c b/drivers/misc/cxl/guest.c
index 3321c014913c..375f692ae9d6 100644
--- a/drivers/misc/cxl/guest.c
+++ b/drivers/misc/cxl/guest.c
@@ -1053,7 +1053,7 @@ static void free_adapter(struct cxl *adapter)
 		if (adapter->guest->irq_avail) {
 			for (i = 0; i < adapter->guest->irq_nranges; i++) {
 				cur = &adapter->guest->irq_avail[i];
-				kfree(cur->bitmap);
+				bitmap_free(cur->bitmap);
 			}
 			kfree(adapter->guest->irq_avail);
 		}
diff --git a/drivers/misc/cxl/irq.c b/drivers/misc/cxl/irq.c
index 5f0e2dcebb34..0ce91d99aead 100644
--- a/drivers/misc/cxl/irq.c
+++ b/drivers/misc/cxl/irq.c
@@ -319,8 +319,7 @@ int afu_allocate_irqs(struct cxl_context *ctx, u32 count)
 	}
 
 	ctx->irq_count = count;
-	ctx->irq_bitmap = kcalloc(BITS_TO_LONGS(count),
-				  sizeof(*ctx->irq_bitmap), GFP_KERNEL);
+	ctx->irq_bitmap = bitmap_zalloc(count, GFP_KERNEL);
 	if (!ctx->irq_bitmap)
 		goto out;
 
diff --git a/drivers/misc/cxl/of.c b/drivers/misc/cxl/of.c
index 1cfecba42d01..25ce725035e7 100644
--- a/drivers/misc/cxl/of.c
+++ b/drivers/misc/cxl/of.c
@@ -308,8 +308,7 @@ static int read_adapter_irq_config(struct cxl *adapter, struct device_node *np)
 		cur = &adapter->guest->irq_avail[i];
 		cur->offset = be32_to_cpu(ranges[i * 2]);
 		cur->range  = be32_to_cpu(ranges[i * 2 + 1]);
-		cur->bitmap = kcalloc(BITS_TO_LONGS(cur->range),
-				sizeof(*cur->bitmap), GFP_KERNEL);
+		cur->bitmap = bitmap_zalloc(cur->range, GFP_KERNEL);
 		if (cur->bitmap == NULL)
 			goto err;
 		if (cur->offset < adapter->guest->irq_base_offset)
@@ -326,7 +325,7 @@ static int read_adapter_irq_config(struct cxl *adapter, struct device_node *np)
 err:
 	for (i--; i >= 0; i--) {
 		cur = &adapter->guest->irq_avail[i];
-		kfree(cur->bitmap);
+		bitmap_free(cur->bitmap);
 	}
 	kfree(adapter->guest->irq_avail);
 	adapter->guest->irq_avail = NULL;
-- 
2.34.1

