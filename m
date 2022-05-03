Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 09C135185F6
	for <lists+linux-kernel@lfdr.de>; Tue,  3 May 2022 15:52:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236564AbiECNz1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 May 2022 09:55:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42806 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233489AbiECNzY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 May 2022 09:55:24 -0400
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [46.235.227.227])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3177B1AD91;
        Tue,  3 May 2022 06:51:52 -0700 (PDT)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: benjamin.gaignard)
        with ESMTPSA id 98BFF1F42948
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1651585911;
        bh=WDkARTQ+4pxreR4FXrF8xsJmJLEb5fDZJt1tvnaG7Qc=;
        h=From:To:Cc:Subject:Date:From;
        b=QnCXtYEf0SBqCf4KP7PkQENpsD5khfqxyONWwF+taXVSMeKZKm/+dEXb1vmGwBz13
         tsGg7nq3lm8i2aefHarZX0GjLWfaiCX4dON/ovH4dxEUZHLG4yMu/El7ulH7KeIFfJ
         hfVEMiHZT8CjxyxKlDhVC3f9R+HGpM+gFyzmBMp43VQMmp2y7cWepx/tQY14MPZogo
         0Y+oWVi6qPSzz086a+sx5hNHNWcNcIZhuSyatDsAZyYGeC1v5Qow6aiVi+9py/qCqT
         0rDaF8TERnZQBbNjfd5+DOJ3qTsowzA7gW6UmT+nHT5Sk3/WOy27ZDuvIv377pZ9Ye
         dnjE+tiAv9HVA==
From:   Benjamin Gaignard <benjamin.gaignard@collabora.com>
To:     ezequiel@vanguardiasur.com.ar, p.zabel@pengutronix.de,
        mchehab@kernel.org, gregkh@linuxfoundation.org
Cc:     linux-media@vger.kernel.org, linux-rockchip@lists.infradead.org,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        jon@nanocrew.net, aford173@gmail.com, kernel@collabora.com,
        Benjamin Gaignard <benjamin.gaignard@collabora.com>
Subject: [PATCH v2] media: hantro: HEVC: Fix reference frames management
Date:   Tue,  3 May 2022 15:51:38 +0200
Message-Id: <20220503135138.678677-1-benjamin.gaignard@collabora.com>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

PoC shall be int the range of -2^31 to 2^31 -1
(HEVC spec section 8.3.1 Decoding process for picture order count).
The current way to know if an entry in reference picture array is free
is to test if PoC = UNUSED_REF. Since UNUSED_REF is defined as '-1' that
could lead to decode issue if one PoC also equal '-1'.
PoC with value = '-1' exists in conformance test SLIST_B_Sony_9.

Change the way unused entries are managed in reference pictures array to
avoid using PoC to detect then.

This patch doesn't change fluster HEVC score.

Signed-off-by: Benjamin Gaignard <benjamin.gaignard@collabora.com>
---
 .../staging/media/hantro/hantro_g2_hevc_dec.c |  6 ++---
 drivers/staging/media/hantro/hantro_hevc.c    | 27 +++----------------
 drivers/staging/media/hantro/hantro_hw.h      |  2 +-
 3 files changed, 6 insertions(+), 29 deletions(-)

diff --git a/drivers/staging/media/hantro/hantro_g2_hevc_dec.c b/drivers/staging/media/hantro/hantro_g2_hevc_dec.c
index 0a8c01ff2fa7..b7835bbf5e98 100644
--- a/drivers/staging/media/hantro/hantro_g2_hevc_dec.c
+++ b/drivers/staging/media/hantro/hantro_g2_hevc_dec.c
@@ -473,8 +473,8 @@ static int set_ref(struct hantro_ctx *ctx)
 
 	set_ref_pic_list(ctx);
 
-	/* We will only keep the references picture that are still used */
-	ctx->hevc_dec.ref_bufs_used = 0;
+	/* We will only keep the references pictures that are still used */
+	hantro_hevc_ref_init(ctx);
 
 	/* Set up addresses of DPB buffers */
 	dpb_longterm_e = 0;
@@ -515,8 +515,6 @@ static int set_ref(struct hantro_ctx *ctx)
 	hantro_write_addr(vpu, G2_OUT_CHROMA_ADDR, chroma_addr);
 	hantro_write_addr(vpu, G2_OUT_MV_ADDR, mv_addr);
 
-	hantro_hevc_ref_remove_unused(ctx);
-
 	for (; i < V4L2_HEVC_DPB_ENTRIES_NUM_MAX; i++) {
 		hantro_write_addr(vpu, G2_REF_LUMA_ADDR(i), 0);
 		hantro_write_addr(vpu, G2_REF_CHROMA_ADDR(i), 0);
diff --git a/drivers/staging/media/hantro/hantro_hevc.c b/drivers/staging/media/hantro/hantro_hevc.c
index 7d4b1d72255c..7fdec50dc853 100644
--- a/drivers/staging/media/hantro/hantro_hevc.c
+++ b/drivers/staging/media/hantro/hantro_hevc.c
@@ -25,15 +25,11 @@
 #define MAX_TILE_COLS 20
 #define MAX_TILE_ROWS 22
 
-#define UNUSED_REF	-1
-
-static void hantro_hevc_ref_init(struct hantro_ctx *ctx)
+void hantro_hevc_ref_init(struct hantro_ctx *ctx)
 {
 	struct hantro_hevc_dec_hw_ctx *hevc_dec = &ctx->hevc_dec;
-	int i;
 
-	for (i = 0;  i < NUM_REF_PICTURES; i++)
-		hevc_dec->ref_bufs_poc[i] = UNUSED_REF;
+	hevc_dec->ref_bufs_used = 0;
 }
 
 dma_addr_t hantro_hevc_get_ref_buf(struct hantro_ctx *ctx,
@@ -60,7 +56,7 @@ int hantro_hevc_add_ref_buf(struct hantro_ctx *ctx, int poc, dma_addr_t addr)
 
 	/* Add a new reference buffer */
 	for (i = 0; i < NUM_REF_PICTURES; i++) {
-		if (hevc_dec->ref_bufs_poc[i] == UNUSED_REF) {
+		if (!(hevc_dec->ref_bufs_used & 1 << i)) {
 			hevc_dec->ref_bufs_used |= 1 << i;
 			hevc_dec->ref_bufs_poc[i] = poc;
 			hevc_dec->ref_bufs[i].dma = addr;
@@ -71,23 +67,6 @@ int hantro_hevc_add_ref_buf(struct hantro_ctx *ctx, int poc, dma_addr_t addr)
 	return -EINVAL;
 }
 
-void hantro_hevc_ref_remove_unused(struct hantro_ctx *ctx)
-{
-	struct hantro_hevc_dec_hw_ctx *hevc_dec = &ctx->hevc_dec;
-	int i;
-
-	/* Just tag buffer as unused, do not free them */
-	for (i = 0;  i < NUM_REF_PICTURES; i++) {
-		if (hevc_dec->ref_bufs_poc[i] == UNUSED_REF)
-			continue;
-
-		if (hevc_dec->ref_bufs_used & (1 << i))
-			continue;
-
-		hevc_dec->ref_bufs_poc[i] = UNUSED_REF;
-	}
-}
-
 static int tile_buffer_reallocate(struct hantro_ctx *ctx)
 {
 	struct hantro_dev *vpu = ctx->dev;
diff --git a/drivers/staging/media/hantro/hantro_hw.h b/drivers/staging/media/hantro/hantro_hw.h
index 9f31cce609d6..5de558386179 100644
--- a/drivers/staging/media/hantro/hantro_hw.h
+++ b/drivers/staging/media/hantro/hantro_hw.h
@@ -337,9 +337,9 @@ int hantro_hevc_dec_init(struct hantro_ctx *ctx);
 void hantro_hevc_dec_exit(struct hantro_ctx *ctx);
 int hantro_g2_hevc_dec_run(struct hantro_ctx *ctx);
 int hantro_hevc_dec_prepare_run(struct hantro_ctx *ctx);
+void hantro_hevc_ref_init(struct hantro_ctx *ctx);
 dma_addr_t hantro_hevc_get_ref_buf(struct hantro_ctx *ctx, s32 poc);
 int hantro_hevc_add_ref_buf(struct hantro_ctx *ctx, int poc, dma_addr_t addr);
-void hantro_hevc_ref_remove_unused(struct hantro_ctx *ctx);
 
 static inline unsigned short hantro_vp9_num_sbs(unsigned short dimension)
 {
-- 
2.32.0

