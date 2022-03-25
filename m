Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 794F64E71F1
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Mar 2022 12:07:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232493AbiCYLId (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Mar 2022 07:08:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40894 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1355017AbiCYLIG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Mar 2022 07:08:06 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 19430C74B9;
        Fri, 25 Mar 2022 04:06:32 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A855F6175F;
        Fri, 25 Mar 2022 11:06:31 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6EB53C340F7;
        Fri, 25 Mar 2022 11:06:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1648206391;
        bh=HaeVvQ+iU5SjxEHXW/I2+ViEC48WyizE5aJpvqy5+cg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=QVMhd6EVr5TIVoOmrlHQSMddn1BBCln61qh6SVaDfay4DSNjwh/NYu/YPio9RN10l
         vwTdtIkXayCexBW8ksQOiFDDx0y50Q8kdxRe2+WgidNIQOTz1o6dvEsfEMiUlV/2UP
         iWksk63tyWy2yC5dLcLwqiIVpLdPi0+J1nDZHbVXgUQcwBXsIpqdlPBaTsX6MviMWu
         6j8X/eHE9nUOQ61PJ139/Y/Yw0rBZT8Ig5VpD1XN6CJ+zhAJKQV2Q5zPWp4DCg1XmX
         EwFdqbL0NmDJgdMlzEYuYdw1M/eGew/Sw6MhROUI7DscT4UqXlv3NA0eGStoJX5G1F
         dvEUjKh6o8v2g==
From:   Vinod Koul <vkoul@kernel.org>
To:     Rob Clark <robdclark@gmail.com>
Cc:     linux-arm-msm@vger.kernel.org,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Vinod Koul <vkoul@kernel.org>, David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Jonathan Marek <jonathan@marek.ca>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Abhinav Kumar <abhinavk@codeaurora.org>,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
        freedreno@lists.freedesktop.org,
        Abhinav Kumar <quic_abhinavk@quicinc.com>
Subject: [PATCH v5 05/13] drm/msm/disp/dpu1: Add DSC for SDM845 to hw_catalog
Date:   Fri, 25 Mar 2022 16:35:48 +0530
Message-Id: <20220325110556.275490-6-vkoul@kernel.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220325110556.275490-1-vkoul@kernel.org>
References: <20220325110556.275490-1-vkoul@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-8.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This adds SDM845 DSC blocks into hw_catalog

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Reviewed-by: Abhinav Kumar <quic_abhinavk@quicinc.com>
Signed-off-by: Vinod Koul <vkoul@kernel.org>
---
 .../gpu/drm/msm/disp/dpu1/dpu_hw_catalog.c    | 20 +++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_catalog.c b/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_catalog.c
index aa75991903a6..9c09cf318dfb 100644
--- a/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_catalog.c
+++ b/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_catalog.c
@@ -821,6 +821,24 @@ static const struct dpu_pingpong_cfg sc7280_pp[] = {
 	PP_BLK("pingpong_2", PINGPONG_2, 0x6b000, 0, sc7280_pp_sblk, -1, -1),
 	PP_BLK("pingpong_3", PINGPONG_3, 0x6c000, 0, sc7280_pp_sblk, -1, -1),
 };
+
+/*************************************************************
+ * DSC sub blocks config
+ *************************************************************/
+#define DSC_BLK(_name, _id, _base) \
+	{\
+	.name = _name, .id = _id, \
+	.base = _base, .len = 0x140, \
+	.features = 0, \
+	}
+
+static struct dpu_dsc_cfg sdm845_dsc[] = {
+	DSC_BLK("dsc_0", DSC_0, 0x80000),
+	DSC_BLK("dsc_1", DSC_1, 0x80400),
+	DSC_BLK("dsc_2", DSC_2, 0x80800),
+	DSC_BLK("dsc_3", DSC_3, 0x80c00),
+};
+
 /*************************************************************
  * INTF sub blocks config
  *************************************************************/
@@ -1124,6 +1142,8 @@ static void sdm845_cfg_init(struct dpu_mdss_cfg *dpu_cfg)
 		.mixer = sdm845_lm,
 		.pingpong_count = ARRAY_SIZE(sdm845_pp),
 		.pingpong = sdm845_pp,
+		.dsc_count = ARRAY_SIZE(sdm845_dsc),
+		.dsc = sdm845_dsc,
 		.intf_count = ARRAY_SIZE(sdm845_intf),
 		.intf = sdm845_intf,
 		.vbif_count = ARRAY_SIZE(sdm845_vbif),
-- 
2.34.1

