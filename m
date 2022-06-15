Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 220D754D2D2
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Jun 2022 22:45:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345788AbiFOUpH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Jun 2022 16:45:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39186 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346994AbiFOUo7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Jun 2022 16:44:59 -0400
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com [IPv6:2a00:1450:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1032929349;
        Wed, 15 Jun 2022 13:44:58 -0700 (PDT)
Received: by mail-ed1-x52e.google.com with SMTP id o10so17882518edi.1;
        Wed, 15 Jun 2022 13:44:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=NK4/Hf2pXq8vs+whlyiQe78XKedAQVOQEImTLUfGWOc=;
        b=OstEOMN8l+7npy77KUmPSRCg2LzLv1OR1shAiljV1nNYHy9d/m1pThZxIcx+Kjmnfj
         ZAScAe4SUfnFwWjLjeJGYAWYy59O1Ml8HXLsS7644REPqg9673p6c87WEWXW3gxlofJQ
         QrPywh6GbNd+HcWGKYidKe3NugaQbky+dvkolOrEKvd0zIKvECvUDQ6wcfPU6h3zxdko
         WeKuaGwweoEg43gUJcQwrQ+RmdCD7Nw3CEIB5XVIrOLAj8lW3mJb2Z2m9DM7WStLFEPZ
         oaqDHcxgwShOgctMEUEPva7Tup/ZeFA3cizW/ZcjNpfg0sGQUBNj6fnOVxkOMu34sUiV
         p2Hg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=NK4/Hf2pXq8vs+whlyiQe78XKedAQVOQEImTLUfGWOc=;
        b=qnHeNq6aIcnAiJB0a/sbHR/OUb1RNFFrA7YZ5VoiwrH9Uibctn3gAOKu8ArGUoJyL8
         75B7jnYaiKrz0uj13vEzJpV4A/ITViuZwujprwL4kd1IQHs/0+PQN3TZCCiNsB+kDL5b
         jDc9NsmdW8DVRY4d3G2iEiDvP5LjpZH4ZSKTT4MOyUt2npiPUqky38lftxDdsxTtz9FQ
         s3GMohaaaM35XAqXcDXWOXdjVv4JMfOWHeN7AG9WervS3dve9hzsiHlxGI3HBJQgZBAn
         gK2smtHCtBbaJ4g6eqcVWiCSEXafaXIfxQQnkXPtPKRpUB3KEnxooRAVkNlMJPb6EMfU
         JGwA==
X-Gm-Message-State: AJIora+9WokbcvQOqG3BXfYwNyxYA0qedl7ni8biBJwBoYbjUVhTePB8
        E7RnL9KklzMrc1T9mhemBvc=
X-Google-Smtp-Source: AGRyM1v+txm9b7SzlUcjBJURyyLsNCjRqLfWXvxRuKU4XIbf2Gz0hrB3Tn174dc3BSTZxOxoduxPrg==
X-Received: by 2002:aa7:d052:0:b0:42d:d114:43f7 with SMTP id n18-20020aa7d052000000b0042dd11443f7mr2046980edo.320.1655325896550;
        Wed, 15 Jun 2022 13:44:56 -0700 (PDT)
Received: from kista.localdomain (213-161-3-76.dynamic.telemach.net. [213.161.3.76])
        by smtp.gmail.com with ESMTPSA id h16-20020a1709060f5000b00711d0b41bcfsm6777291ejj.0.2022.06.15.13.44.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Jun 2022 13:44:56 -0700 (PDT)
From:   Jernej Skrabec <jernej.skrabec@gmail.com>
To:     mripard@kernel.org, paul.kocialkowski@bootlin.com
Cc:     mchehab@kernel.org, wens@csie.org, jernej.skrabec@gmail.com,
        samuel@sholland.org, hverkuil-cisco@xs4all.nl,
        benjamin.gaignard@collabora.com, nicolas.dufresne@collabora.com,
        gregkh@linuxfoundation.org, linux-media@vger.kernel.org,
        linux-staging@lists.linux.dev,
        linux-arm-kernel@lists.infradead.org, linux-sunxi@lists.linux.dev,
        linux-kernel@vger.kernel.org
Subject: [PATCH 1/2] media: cedrus: h265: Fix flag name
Date:   Wed, 15 Jun 2022 22:44:35 +0200
Message-Id: <20220615204436.137377-2-jernej.skrabec@gmail.com>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20220615204436.137377-1-jernej.skrabec@gmail.com>
References: <20220615204436.137377-1-jernej.skrabec@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Bit 21 in register 0x24 (slice header info 1) actually represents
negated version of low delay flag. This can be seen in vendor Cedar
library source code. While this flag is not part of the standard, it can
be found in reference HEVC implementation.

Fix macro name and change it to flag.

Fixes: 86caab29da78 ("media: cedrus: Add HEVC/H.265 decoding support")
Signed-off-by: Jernej Skrabec <jernej.skrabec@gmail.com>
---
 drivers/staging/media/sunxi/cedrus/cedrus_h265.c | 4 +++-
 drivers/staging/media/sunxi/cedrus/cedrus_regs.h | 3 +--
 2 files changed, 4 insertions(+), 3 deletions(-)

diff --git a/drivers/staging/media/sunxi/cedrus/cedrus_h265.c b/drivers/staging/media/sunxi/cedrus/cedrus_h265.c
index 44f385be9f6c..2febdf7a97fe 100644
--- a/drivers/staging/media/sunxi/cedrus/cedrus_h265.c
+++ b/drivers/staging/media/sunxi/cedrus/cedrus_h265.c
@@ -559,7 +559,6 @@ static void cedrus_h265_setup(struct cedrus_ctx *ctx,
 
 	reg = VE_DEC_H265_DEC_SLICE_HDR_INFO1_SLICE_TC_OFFSET_DIV2(slice_params->slice_tc_offset_div2) |
 	      VE_DEC_H265_DEC_SLICE_HDR_INFO1_SLICE_BETA_OFFSET_DIV2(slice_params->slice_beta_offset_div2) |
-	      VE_DEC_H265_DEC_SLICE_HDR_INFO1_SLICE_POC_BIGEST_IN_RPS_ST(decode_params->num_poc_st_curr_after == 0) |
 	      VE_DEC_H265_DEC_SLICE_HDR_INFO1_SLICE_CR_QP_OFFSET(slice_params->slice_cr_qp_offset) |
 	      VE_DEC_H265_DEC_SLICE_HDR_INFO1_SLICE_CB_QP_OFFSET(slice_params->slice_cb_qp_offset) |
 	      VE_DEC_H265_DEC_SLICE_HDR_INFO1_SLICE_QP_DELTA(slice_params->slice_qp_delta);
@@ -572,6 +571,9 @@ static void cedrus_h265_setup(struct cedrus_ctx *ctx,
 				V4L2_HEVC_SLICE_PARAMS_FLAG_SLICE_LOOP_FILTER_ACROSS_SLICES_ENABLED,
 				slice_params->flags);
 
+	if (decode_params->num_poc_st_curr_after == 0)
+		reg |= VE_DEC_H265_DEC_SLICE_HDR_INFO1_FLAG_SLICE_NOT_LOW_DELAY;
+
 	cedrus_write(dev, VE_DEC_H265_DEC_SLICE_HDR_INFO1, reg);
 
 	chroma_log2_weight_denom = pred_weight_table->luma_log2_weight_denom +
diff --git a/drivers/staging/media/sunxi/cedrus/cedrus_regs.h b/drivers/staging/media/sunxi/cedrus/cedrus_regs.h
index bdb062ad8682..d81f7513ade0 100644
--- a/drivers/staging/media/sunxi/cedrus/cedrus_regs.h
+++ b/drivers/staging/media/sunxi/cedrus/cedrus_regs.h
@@ -377,13 +377,12 @@
 
 #define VE_DEC_H265_DEC_SLICE_HDR_INFO1_FLAG_SLICE_DEBLOCKING_FILTER_DISABLED BIT(23)
 #define VE_DEC_H265_DEC_SLICE_HDR_INFO1_FLAG_SLICE_LOOP_FILTER_ACROSS_SLICES_ENABLED BIT(22)
+#define VE_DEC_H265_DEC_SLICE_HDR_INFO1_FLAG_SLICE_NOT_LOW_DELAY BIT(21)
 
 #define VE_DEC_H265_DEC_SLICE_HDR_INFO1_SLICE_TC_OFFSET_DIV2(v) \
 	SHIFT_AND_MASK_BITS(v, 31, 28)
 #define VE_DEC_H265_DEC_SLICE_HDR_INFO1_SLICE_BETA_OFFSET_DIV2(v) \
 	SHIFT_AND_MASK_BITS(v, 27, 24)
-#define VE_DEC_H265_DEC_SLICE_HDR_INFO1_SLICE_POC_BIGEST_IN_RPS_ST(v) \
-	((v) ? BIT(21) : 0)
 #define VE_DEC_H265_DEC_SLICE_HDR_INFO1_SLICE_CR_QP_OFFSET(v) \
 	SHIFT_AND_MASK_BITS(v, 20, 16)
 #define VE_DEC_H265_DEC_SLICE_HDR_INFO1_SLICE_CB_QP_OFFSET(v) \
-- 
2.36.1

