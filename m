Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 407994F6123
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Apr 2022 16:15:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234101AbiDFOGu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Apr 2022 10:06:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37588 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234414AbiDFOGN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Apr 2022 10:06:13 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D4A95E1617;
        Wed,  6 Apr 2022 02:41:36 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 6BAB3B81FB7;
        Wed,  6 Apr 2022 09:40:59 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9C5C3C385A5;
        Wed,  6 Apr 2022 09:40:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1649238058;
        bh=RpvkJ8U0VEvDlnAfPxDQLxtSZdt5YWgvrhTLE0lWbvU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=JWoiR9184jsH+018F/xTLXks9hYr+DwGOb/3kbRSY3qXBG5V717+8zDckA3v0GUKY
         oPGiAwSj8RQRaiaFqzXlMuA3gSWSQ+dSQW/XxkGFTWVCF/Yt5vTl9BxhhiPhHc8fjo
         vRV91lO/omFbgt2J8Ww5r7tmgRDBKlOtug7JdVNE9ZGkXKbxdvoTMaBoLvrEdvPpDB
         u05jh0tayZEHaJrfiNf7m5qHkQ8cCNfJ4JXpnCrmLHGun/VlnaUesn4stzhtULhBoY
         xs1lVMMmUH3MLmxQrm/9OAhn/baFvtzO+frytZqoL/c4tHYyiqo4cGbjUxQfTOtGgm
         H6wFAzL/IdODw==
From:   Vinod Koul <vkoul@kernel.org>
To:     Rob Clark <robdclark@gmail.com>
Cc:     linux-arm-msm@vger.kernel.org,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Vinod Koul <vkoul@kernel.org>, David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Jonathan Marek <jonathan@marek.ca>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Abhinav Kumar <quic_abhinavk@quicinc.com>,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
        freedreno@lists.freedesktop.org
Subject: [PATCH v7 04/14] drm/msm/disp/dpu1: Add support for DSC in pingpong block
Date:   Wed,  6 Apr 2022 15:10:21 +0530
Message-Id: <20220406094031.1027376-5-vkoul@kernel.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220406094031.1027376-1-vkoul@kernel.org>
References: <20220406094031.1027376-1-vkoul@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In SDM845, DSC can be enabled by writing to pingpong block registers, so
add support for DSC in hw_pp

Reviewed-by: Abhinav Kumar <quic_abhinavk@quicinc.com>
Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Signed-off-by: Vinod Koul <vkoul@kernel.org>
---
 .../gpu/drm/msm/disp/dpu1/dpu_hw_pingpong.c   | 32 +++++++++++++++++++
 .../gpu/drm/msm/disp/dpu1/dpu_hw_pingpong.h   | 14 ++++++++
 2 files changed, 46 insertions(+)

diff --git a/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_pingpong.c b/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_pingpong.c
index 55766c97c4c8..47c6ab6caf95 100644
--- a/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_pingpong.c
+++ b/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_pingpong.c
@@ -28,6 +28,9 @@
 #define PP_FBC_MODE                     0x034
 #define PP_FBC_BUDGET_CTL               0x038
 #define PP_FBC_LOSSY_MODE               0x03C
+#define PP_DSC_MODE                     0x0a0
+#define PP_DCE_DATA_IN_SWAP             0x0ac
+#define PP_DCE_DATA_OUT_SWAP            0x0c8
 
 #define PP_DITHER_EN			0x000
 #define PP_DITHER_BITDEPTH		0x004
@@ -245,6 +248,32 @@ static u32 dpu_hw_pp_get_line_count(struct dpu_hw_pingpong *pp)
 	return line;
 }
 
+static int dpu_hw_pp_dsc_enable(struct dpu_hw_pingpong *pp)
+{
+	struct dpu_hw_blk_reg_map *c = &pp->hw;
+
+	DPU_REG_WRITE(c, PP_DSC_MODE, 1);
+	return 0;
+}
+
+static void dpu_hw_pp_dsc_disable(struct dpu_hw_pingpong *pp)
+{
+	struct dpu_hw_blk_reg_map *c = &pp->hw;
+
+	DPU_REG_WRITE(c, PP_DSC_MODE, 0);
+}
+
+static int dpu_hw_pp_setup_dsc(struct dpu_hw_pingpong *pp)
+{
+	struct dpu_hw_blk_reg_map *pp_c = &pp->hw;
+	int data;
+
+	data = DPU_REG_READ(pp_c, PP_DCE_DATA_OUT_SWAP);
+	data |= BIT(18); /* endian flip */
+	DPU_REG_WRITE(pp_c, PP_DCE_DATA_OUT_SWAP, data);
+	return 0;
+}
+
 static void _setup_pingpong_ops(struct dpu_hw_pingpong *c,
 				unsigned long features)
 {
@@ -256,6 +285,9 @@ static void _setup_pingpong_ops(struct dpu_hw_pingpong *c,
 	c->ops.get_autorefresh = dpu_hw_pp_get_autorefresh_config;
 	c->ops.poll_timeout_wr_ptr = dpu_hw_pp_poll_timeout_wr_ptr;
 	c->ops.get_line_count = dpu_hw_pp_get_line_count;
+	c->ops.setup_dsc = dpu_hw_pp_setup_dsc;
+	c->ops.enable_dsc = dpu_hw_pp_dsc_enable;
+	c->ops.disable_dsc = dpu_hw_pp_dsc_disable;
 
 	if (test_bit(DPU_PINGPONG_DITHER, &features))
 		c->ops.setup_dither = dpu_hw_pp_setup_dither;
diff --git a/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_pingpong.h b/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_pingpong.h
index 89d08a715c16..12758468d9ca 100644
--- a/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_pingpong.h
+++ b/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_pingpong.h
@@ -124,6 +124,20 @@ struct dpu_hw_pingpong_ops {
 	 */
 	void (*setup_dither)(struct dpu_hw_pingpong *pp,
 			struct dpu_hw_dither_cfg *cfg);
+	/**
+	 * Enable DSC
+	 */
+	int (*enable_dsc)(struct dpu_hw_pingpong *pp);
+
+	/**
+	 * Disable DSC
+	 */
+	void (*disable_dsc)(struct dpu_hw_pingpong *pp);
+
+	/**
+	 * Setup DSC
+	 */
+	int (*setup_dsc)(struct dpu_hw_pingpong *pp);
 };
 
 struct dpu_hw_merge_3d;
-- 
2.34.1

