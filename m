Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7088D527F74
	for <lists+linux-kernel@lfdr.de>; Mon, 16 May 2022 10:19:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241602AbiEPITI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 May 2022 04:19:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56378 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236381AbiEPISt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 May 2022 04:18:49 -0400
Received: from inva020.nxp.com (inva020.nxp.com [92.121.34.13])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D5B9C36E24
        for <linux-kernel@vger.kernel.org>; Mon, 16 May 2022 01:18:46 -0700 (PDT)
Received: from inva020.nxp.com (localhost [127.0.0.1])
        by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id 6F68F1A0490;
        Mon, 16 May 2022 10:18:45 +0200 (CEST)
Received: from aprdc01srsp001v.ap-rdc01.nxp.com (aprdc01srsp001v.ap-rdc01.nxp.com [165.114.16.16])
        by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id 37F1D1A0474;
        Mon, 16 May 2022 10:18:45 +0200 (CEST)
Received: from localhost.localdomain (shlinux2.ap.freescale.net [10.192.224.44])
        by aprdc01srsp001v.ap-rdc01.nxp.com (Postfix) with ESMTP id B7995180219B;
        Mon, 16 May 2022 16:18:43 +0800 (+08)
From:   Shengjiu Wang <shengjiu.wang@nxp.com>
To:     nicoleotsuka@gmail.com, Xiubo.Lee@gmail.com, festevam@gmail.com,
        shengjiu.wang@gmail.com, lgirdwood@gmail.com, broonie@kernel.org,
        perex@perex.cz, tiwai@suse.com, alsa-devel@alsa-project.org
Cc:     linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: [PATCH 2/3] ASoC: fsl_sai: Add support for i.MX8M Plus
Date:   Mon, 16 May 2022 16:06:11 +0800
Message-Id: <1652688372-10274-3-git-send-email-shengjiu.wang@nxp.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1652688372-10274-1-git-send-email-shengjiu.wang@nxp.com>
References: <1652688372-10274-1-git-send-email-shengjiu.wang@nxp.com>
X-Virus-Scanned: ClamAV using ClamSMTP
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add i.MX8M Plus specific soc data, the max register is FSL_SAI_MDIV.

Signed-off-by: Shengjiu Wang <shengjiu.wang@nxp.com>
---
 sound/soc/fsl/fsl_sai.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/sound/soc/fsl/fsl_sai.c b/sound/soc/fsl/fsl_sai.c
index 1ac65de094b9..b528722acd65 100644
--- a/sound/soc/fsl/fsl_sai.c
+++ b/sound/soc/fsl/fsl_sai.c
@@ -1261,6 +1261,17 @@ static const struct fsl_sai_soc_data fsl_sai_imx8mm_data = {
 	.max_register = FSL_SAI_MCTL,
 };
 
+static const struct fsl_sai_soc_data fsl_sai_imx8mp_data = {
+	.use_imx_pcm = true,
+	.use_edma = false,
+	.fifo_depth = 128,
+	.reg_offset = 8,
+	.mclk0_is_mclk1 = false,
+	.pins = 8,
+	.flags = 0,
+	.max_register = FSL_SAI_MDIV,
+};
+
 static const struct of_device_id fsl_sai_ids[] = {
 	{ .compatible = "fsl,vf610-sai", .data = &fsl_sai_vf610_data },
 	{ .compatible = "fsl,imx6sx-sai", .data = &fsl_sai_imx6sx_data },
@@ -1269,6 +1280,7 @@ static const struct of_device_id fsl_sai_ids[] = {
 	{ .compatible = "fsl,imx8mq-sai", .data = &fsl_sai_imx8mq_data },
 	{ .compatible = "fsl,imx8qm-sai", .data = &fsl_sai_imx8qm_data },
 	{ .compatible = "fsl,imx8mm-sai", .data = &fsl_sai_imx8mm_data },
+	{ .compatible = "fsl,imx8mp-sai", .data = &fsl_sai_imx8mp_data },
 	{ /* sentinel */ }
 };
 MODULE_DEVICE_TABLE(of, fsl_sai_ids);
-- 
2.17.1

