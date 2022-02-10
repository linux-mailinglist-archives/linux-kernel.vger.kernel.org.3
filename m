Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 64FEA4B0E31
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Feb 2022 14:15:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242038AbiBJNOM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Feb 2022 08:14:12 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:47002 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238484AbiBJNOK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Feb 2022 08:14:10 -0500
Received: from mail-qt1-x82b.google.com (mail-qt1-x82b.google.com [IPv6:2607:f8b0:4864:20::82b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6DDE11142
        for <linux-kernel@vger.kernel.org>; Thu, 10 Feb 2022 05:14:10 -0800 (PST)
Received: by mail-qt1-x82b.google.com with SMTP id z1so5120465qto.3
        for <linux-kernel@vger.kernel.org>; Thu, 10 Feb 2022 05:14:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=marek-ca.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Y72MSrQ/DK9eOIq9d6AGRca4dPZsVxDBVqlBoGFZ7PY=;
        b=NyLxq3vq0kHFKDhUJ3pSUKTCyqSSKWmMmkoEQQ/RaZv5k87LD+S5ayCPA9rkX12Ubb
         iO6DXi5mylYQO8chgdnOlWthGsYc/Z9G9s+TvtQdLhjHM47cEW84IPMXXpMnFFGSI9lK
         SJhsq4aJHNHEODdg/DMTQ55yYiHUG8iXGh9jS+kBzhuyFLHl0CC7y6vMD1Af1UvERi8n
         0+frDrUi1GXSTKf7/b+p/2YgygJHjIHi8srH36Oy5r4DcuOGH3CjJWiUasfGbtNHaAaF
         Bj0JDWxjJPThsPEDRVGai0fUGjwr+Hr3HT5Yvq8AsR9qCMJGMqnfxe2hbtWUmtYAC8Lr
         +QOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Y72MSrQ/DK9eOIq9d6AGRca4dPZsVxDBVqlBoGFZ7PY=;
        b=3XicEUwSqeKFmu19/WuxcX/YWA7hcAksMJ1agZx95TugFK+wuYrQubqpGEgxij5voP
         aEpcvcikKOd9s0BAwYnPwJB99BW4C3j2d7fIzkg0ph1mcLCPjIl/LX3CKrxhlYagOV5z
         fNiVpAhpHi0B+HX1GBpAXoPIBTQdOtzYui2yN/FnksFxoefVjH/VRtR3GHm/F/8eBUCp
         3E3cRbl4brc4DvVik0P//enl7mjDoTRle0w0w4wpWCmMQhQ0PK3Z6DpCb9Ny0P3DxTAi
         YxKtGZMNhL7JuotRiDdFUPlYuIHyJl3klbm7KV/GnJWnt3UGXJ8IndTSv2VlCI4ks3Fv
         n9rQ==
X-Gm-Message-State: AOAM53275yh4usRIz8F4b0+hyCBXn8F4fcXu29aRTs9EbS4N+vxtU4p3
        49Xmt24qI/K/FaXJZO7FPRVTF4PYB5Im0MATMdA=
X-Google-Smtp-Source: ABdhPJwdx3+lYvsYAW0QRWrwsSv9Oo8NwlenWMTzFZT4ukvzzUu6UZVIHv7s8/G+EUO8UBHbDWjEtA==
X-Received: by 2002:a05:622a:3d3:: with SMTP id k19mr4645920qtx.71.1644498849534;
        Thu, 10 Feb 2022 05:14:09 -0800 (PST)
Received: from localhost.localdomain (modemcable134.222-177-173.mc.videotron.ca. [173.177.222.134])
        by smtp.gmail.com with ESMTPSA id p15sm10969824qtk.56.2022.02.10.05.14.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Feb 2022 05:14:09 -0800 (PST)
From:   Jonathan Marek <jonathan@marek.ca>
To:     linux-arm-msm@vger.kernel.org
Cc:     dmitry.baryshkov@linaro.org, Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        linux-gpio@vger.kernel.org (open list:PIN CONTROL SUBSYSTEM),
        linux-kernel@vger.kernel.org (open list)
Subject: [PATCH 1/2] pinctrl: qcom: sm8450: Add egpio support
Date:   Thu, 10 Feb 2022 08:12:08 -0500
Message-Id: <20220210131210.24605-1-jonathan@marek.ca>
X-Mailer: git-send-email 2.26.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This mirrors egpio support added for sc7280. This change is necessary for
gpios 165 to 209 to be driven by APSS.

Signed-off-by: Jonathan Marek <jonathan@marek.ca>
---
 drivers/pinctrl/qcom/pinctrl-sm8450.c | 106 +++++++++++++++-----------
 1 file changed, 61 insertions(+), 45 deletions(-)

diff --git a/drivers/pinctrl/qcom/pinctrl-sm8450.c b/drivers/pinctrl/qcom/pinctrl-sm8450.c
index c6fa3dbc14a1e..3110d7bf5698a 100644
--- a/drivers/pinctrl/qcom/pinctrl-sm8450.c
+++ b/drivers/pinctrl/qcom/pinctrl-sm8450.c
@@ -46,6 +46,8 @@
 		.mux_bit = 2,			\
 		.pull_bit = 0,			\
 		.drv_bit = 6,			\
+		.egpio_enable = 12,		\
+		.egpio_present = 11,		\
 		.oe_bit = 9,			\
 		.in_bit = 0,			\
 		.out_bit = 1,			\
@@ -567,6 +569,7 @@ enum sm8450_functions {
 	msm_mux_ddr_pxi2,
 	msm_mux_ddr_pxi3,
 	msm_mux_dp_hot,
+	msm_mux_egpio,
 	msm_mux_gcc_gp1,
 	msm_mux_gcc_gp2,
 	msm_mux_gcc_gp3,
@@ -719,6 +722,17 @@ static const char * const gpio_groups[] = {
 	"gpio207", "gpio208", "gpio209",
 };
 
+static const char * const egpio_groups[] = {
+	"gpio165", "gpio166", "gpio167", "gpio168", "gpio169", "gpio170",
+	"gpio171", "gpio172", "gpio173", "gpio174", "gpio175", "gpio176",
+	"gpio177", "gpio178", "gpio179", "gpio180", "gpio181", "gpio182",
+	"gpio183", "gpio184", "gpio185", "gpio186", "gpio187", "gpio188",
+	"gpio189", "gpio190", "gpio191", "gpio192", "gpio193", "gpio194",
+	"gpio195", "gpio196", "gpio197", "gpio198", "gpio199", "gpio200",
+	"gpio201", "gpio202", "gpio203", "gpio204", "gpio205", "gpio206",
+	"gpio207", "gpio208", "gpio209",
+};
+
 static const char * const aon_cam_groups[] = {
 	"gpio108",
 };
@@ -1285,6 +1299,7 @@ static const struct msm_function sm8450_functions[] = {
 	FUNCTION(ddr_pxi2),
 	FUNCTION(ddr_pxi3),
 	FUNCTION(dp_hot),
+	FUNCTION(egpio),
 	FUNCTION(gcc_gp1),
 	FUNCTION(gcc_gp2),
 	FUNCTION(gcc_gp3),
@@ -1571,51 +1586,51 @@ static const struct msm_pingroup sm8450_groups[] = {
 	[162] = PINGROUP(162, qlink2_request, _, _, _, _, _, _, _, _),
 	[163] = PINGROUP(163, qlink2_enable, _, _, _, _, _, _, _, _),
 	[164] = PINGROUP(164, qlink2_wmss, _, _, _, _, _, _, _, _),
-	[165] = PINGROUP(165, _, _, _, _, _, _, _, _, _),
-	[166] = PINGROUP(166, _, _, _, _, _, _, _, _, _),
-	[167] = PINGROUP(167, _, _, _, _, _, _, _, _, _),
-	[168] = PINGROUP(168, _, _, _, _, _, _, _, _, _),
-	[169] = PINGROUP(169, _, _, _, _, _, _, _, _, _),
-	[170] = PINGROUP(170, _, _, _, _, _, _, _, _, _),
-	[171] = PINGROUP(171, _, _, _, _, _, _, _, _, _),
-	[172] = PINGROUP(172, _, _, _, _, _, _, _, _, _),
-	[173] = PINGROUP(173, _, _, _, _, _, _, _, _, _),
-	[174] = PINGROUP(174, _, _, _, _, _, _, _, _, _),
-	[175] = PINGROUP(175, _, _, _, _, _, _, _, _, _),
-	[176] = PINGROUP(176, _, _, _, _, _, _, _, _, _),
-	[177] = PINGROUP(177, _, _, _, _, _, _, _, _, _),
-	[178] = PINGROUP(178, _, _, _, _, _, _, _, _, _),
-	[179] = PINGROUP(179, _, _, _, _, _, _, _, _, _),
-	[180] = PINGROUP(180, _, _, _, _, _, _, _, _, _),
-	[181] = PINGROUP(181, _, _, _, _, _, _, _, _, _),
-	[182] = PINGROUP(182, _, _, _, _, _, _, _, _, _),
-	[183] = PINGROUP(183, _, _, _, _, _, _, _, _, _),
-	[184] = PINGROUP(184, _, _, _, _, _, _, _, _, _),
-	[185] = PINGROUP(185, _, _, _, _, _, _, _, _, _),
-	[186] = PINGROUP(186, _, _, _, _, _, _, _, _, _),
-	[187] = PINGROUP(187, _, _, _, _, _, _, _, _, _),
-	[188] = PINGROUP(188, _, qdss_gpio, _, _, _, _, _, _, _),
-	[189] = PINGROUP(189, _, qdss_gpio, _, _, _, _, _, _, _),
-	[190] = PINGROUP(190, qdss_gpio, _, _, _, _, _, _, _, _),
-	[191] = PINGROUP(191, qdss_gpio, _, _, _, _, _, _, _, _),
-	[192] = PINGROUP(192, _, qdss_gpio, _, _, _, _, _, _, _),
-	[193] = PINGROUP(193, _, qdss_gpio, _, _, _, _, _, _, _),
-	[194] = PINGROUP(194, _, qdss_gpio, _, _, _, _, _, _, _),
-	[195] = PINGROUP(195, _, qdss_gpio, _, _, _, _, _, _, _),
-	[196] = PINGROUP(196, _, qdss_gpio, _, _, _, _, _, _, _),
-	[197] = PINGROUP(197, _, qdss_gpio, _, _, _, _, _, _, _),
-	[198] = PINGROUP(198, _, qdss_gpio, _, _, _, _, _, _, _),
-	[199] = PINGROUP(199, _, qdss_gpio, _, _, _, _, _, _, _),
-	[200] = PINGROUP(200, _, qdss_gpio, _, _, _, _, _, _, _),
-	[201] = PINGROUP(201, _, qdss_gpio, _, _, _, _, _, _, _),
-	[202] = PINGROUP(202, qdss_gpio, _, _, _, _, _, _, _, _),
-	[203] = PINGROUP(203, qdss_gpio, _, _, _, _, _, _, _, _),
-	[204] = PINGROUP(204, qdss_gpio, _, _, _, _, _, _, _, _),
-	[205] = PINGROUP(205, qdss_gpio, _, _, _, _, _, _, _, _),
-	[206] = PINGROUP(206, qup5, _, _, _, _, _, _, _, _),
-	[207] = PINGROUP(207, qup5, _, _, _, _, _, _, _, _),
-	[208] = PINGROUP(208, cci_i2c, _, _, _, _, _, _, _, _),
-	[209] = PINGROUP(209, cci_i2c, _, _, _, _, _, _, _, _),
+	[165] = PINGROUP(165, _, _, _, _, _, _, _, _, egpio),
+	[166] = PINGROUP(166, _, _, _, _, _, _, _, _, egpio),
+	[167] = PINGROUP(167, _, _, _, _, _, _, _, _, egpio),
+	[168] = PINGROUP(168, _, _, _, _, _, _, _, _, egpio),
+	[169] = PINGROUP(169, _, _, _, _, _, _, _, _, egpio),
+	[170] = PINGROUP(170, _, _, _, _, _, _, _, _, egpio),
+	[171] = PINGROUP(171, _, _, _, _, _, _, _, _, egpio),
+	[172] = PINGROUP(172, _, _, _, _, _, _, _, _, egpio),
+	[173] = PINGROUP(173, _, _, _, _, _, _, _, _, egpio),
+	[174] = PINGROUP(174, _, _, _, _, _, _, _, _, egpio),
+	[175] = PINGROUP(175, _, _, _, _, _, _, _, _, egpio),
+	[176] = PINGROUP(176, _, _, _, _, _, _, _, _, egpio),
+	[177] = PINGROUP(177, _, _, _, _, _, _, _, _, egpio),
+	[178] = PINGROUP(178, _, _, _, _, _, _, _, _, egpio),
+	[179] = PINGROUP(179, _, _, _, _, _, _, _, _, egpio),
+	[180] = PINGROUP(180, _, _, _, _, _, _, _, _, egpio),
+	[181] = PINGROUP(181, _, _, _, _, _, _, _, _, egpio),
+	[182] = PINGROUP(182, _, _, _, _, _, _, _, _, egpio),
+	[183] = PINGROUP(183, _, _, _, _, _, _, _, _, egpio),
+	[184] = PINGROUP(184, _, _, _, _, _, _, _, _, egpio),
+	[185] = PINGROUP(185, _, _, _, _, _, _, _, _, egpio),
+	[186] = PINGROUP(186, _, _, _, _, _, _, _, _, egpio),
+	[187] = PINGROUP(187, _, _, _, _, _, _, _, _, egpio),
+	[188] = PINGROUP(188, _, qdss_gpio, _, _, _, _, _, _, egpio),
+	[189] = PINGROUP(189, _, qdss_gpio, _, _, _, _, _, _, egpio),
+	[190] = PINGROUP(190, qdss_gpio, _, _, _, _, _, _, _, egpio),
+	[191] = PINGROUP(191, qdss_gpio, _, _, _, _, _, _, _, egpio),
+	[192] = PINGROUP(192, _, qdss_gpio, _, _, _, _, _, _, egpio),
+	[193] = PINGROUP(193, _, qdss_gpio, _, _, _, _, _, _, egpio),
+	[194] = PINGROUP(194, _, qdss_gpio, _, _, _, _, _, _, egpio),
+	[195] = PINGROUP(195, _, qdss_gpio, _, _, _, _, _, _, egpio),
+	[196] = PINGROUP(196, _, qdss_gpio, _, _, _, _, _, _, egpio),
+	[197] = PINGROUP(197, _, qdss_gpio, _, _, _, _, _, _, egpio),
+	[198] = PINGROUP(198, _, qdss_gpio, _, _, _, _, _, _, egpio),
+	[199] = PINGROUP(199, _, qdss_gpio, _, _, _, _, _, _, egpio),
+	[200] = PINGROUP(200, _, qdss_gpio, _, _, _, _, _, _, egpio),
+	[201] = PINGROUP(201, _, qdss_gpio, _, _, _, _, _, _, egpio),
+	[202] = PINGROUP(202, qdss_gpio, _, _, _, _, _, _, _, egpio),
+	[203] = PINGROUP(203, qdss_gpio, _, _, _, _, _, _, _, egpio),
+	[204] = PINGROUP(204, qdss_gpio, _, _, _, _, _, _, _, egpio),
+	[205] = PINGROUP(205, qdss_gpio, _, _, _, _, _, _, _, egpio),
+	[206] = PINGROUP(206, qup5, _, _, _, _, _, _, _, egpio),
+	[207] = PINGROUP(207, qup5, _, _, _, _, _, _, _, egpio),
+	[208] = PINGROUP(208, cci_i2c, _, _, _, _, _, _, _, egpio),
+	[209] = PINGROUP(209, cci_i2c, _, _, _, _, _, _, _, egpio),
 	[210] = UFS_RESET(ufs_reset, 0xde000),
 	[211] = SDC_QDSD_PINGROUP(sdc2_clk, 0xd6000, 14, 6),
 	[212] = SDC_QDSD_PINGROUP(sdc2_cmd, 0xd6000, 11, 3),
@@ -1651,6 +1666,7 @@ static const struct msm_pinctrl_soc_data sm8450_tlmm = {
 	.ngpios = 211,
 	.wakeirq_map = sm8450_pdc_map,
 	.nwakeirq_map = ARRAY_SIZE(sm8450_pdc_map),
+	.egpio_func = 9,
 };
 
 static int sm8450_tlmm_probe(struct platform_device *pdev)
-- 
2.26.1

