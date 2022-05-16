Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 48DAE527F6E
	for <lists+linux-kernel@lfdr.de>; Mon, 16 May 2022 10:19:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241591AbiEPISu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 May 2022 04:18:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56370 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241581AbiEPISt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 May 2022 04:18:49 -0400
Received: from inva020.nxp.com (inva020.nxp.com [92.121.34.13])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B9C0A36E2B
        for <linux-kernel@vger.kernel.org>; Mon, 16 May 2022 01:18:45 -0700 (PDT)
Received: from inva020.nxp.com (localhost [127.0.0.1])
        by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id 6FCD01A0475;
        Mon, 16 May 2022 10:18:44 +0200 (CEST)
Received: from aprdc01srsp001v.ap-rdc01.nxp.com (aprdc01srsp001v.ap-rdc01.nxp.com [165.114.16.16])
        by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id 38D331A0474;
        Mon, 16 May 2022 10:18:44 +0200 (CEST)
Received: from localhost.localdomain (shlinux2.ap.freescale.net [10.192.224.44])
        by aprdc01srsp001v.ap-rdc01.nxp.com (Postfix) with ESMTP id B841F180031D;
        Mon, 16 May 2022 16:18:42 +0800 (+08)
From:   Shengjiu Wang <shengjiu.wang@nxp.com>
To:     nicoleotsuka@gmail.com, Xiubo.Lee@gmail.com, festevam@gmail.com,
        shengjiu.wang@gmail.com, lgirdwood@gmail.com, broonie@kernel.org,
        perex@perex.cz, tiwai@suse.com, alsa-devel@alsa-project.org
Cc:     linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: [PATCH 1/3] ASoC: fsl_sai: Add support for i.MX8MM
Date:   Mon, 16 May 2022 16:06:10 +0800
Message-Id: <1652688372-10274-2-git-send-email-shengjiu.wang@nxp.com>
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

On i.MX8MM the max register is FSL_SAI_MCTL, which is
different with previous platform, so add max_register in
soc data to distinguish platforms.
And add specific soc data for i.MX8MM

Signed-off-by: Shengjiu Wang <shengjiu.wang@nxp.com>
---
 sound/soc/fsl/fsl_sai.c | 17 +++++++++++++++++
 sound/soc/fsl/fsl_sai.h |  1 +
 2 files changed, 18 insertions(+)

diff --git a/sound/soc/fsl/fsl_sai.c b/sound/soc/fsl/fsl_sai.c
index ffc24afb5a7a..1ac65de094b9 100644
--- a/sound/soc/fsl/fsl_sai.c
+++ b/sound/soc/fsl/fsl_sai.c
@@ -1203,6 +1203,7 @@ static const struct fsl_sai_soc_data fsl_sai_vf610_data = {
 	.reg_offset = 0,
 	.mclk0_is_mclk1 = false,
 	.flags = 0,
+	.max_register = FSL_SAI_RMR,
 };
 
 static const struct fsl_sai_soc_data fsl_sai_imx6sx_data = {
@@ -1213,6 +1214,7 @@ static const struct fsl_sai_soc_data fsl_sai_imx6sx_data = {
 	.reg_offset = 0,
 	.mclk0_is_mclk1 = true,
 	.flags = 0,
+	.max_register = FSL_SAI_RMR,
 };
 
 static const struct fsl_sai_soc_data fsl_sai_imx7ulp_data = {
@@ -1223,6 +1225,7 @@ static const struct fsl_sai_soc_data fsl_sai_imx7ulp_data = {
 	.reg_offset = 8,
 	.mclk0_is_mclk1 = false,
 	.flags = PMQOS_CPU_LATENCY,
+	.max_register = FSL_SAI_RMR,
 };
 
 static const struct fsl_sai_soc_data fsl_sai_imx8mq_data = {
@@ -1233,6 +1236,7 @@ static const struct fsl_sai_soc_data fsl_sai_imx8mq_data = {
 	.reg_offset = 8,
 	.mclk0_is_mclk1 = false,
 	.flags = 0,
+	.max_register = FSL_SAI_RMR,
 };
 
 static const struct fsl_sai_soc_data fsl_sai_imx8qm_data = {
@@ -1243,6 +1247,18 @@ static const struct fsl_sai_soc_data fsl_sai_imx8qm_data = {
 	.reg_offset = 0,
 	.mclk0_is_mclk1 = false,
 	.flags = 0,
+	.max_register = FSL_SAI_RMR,
+};
+
+static const struct fsl_sai_soc_data fsl_sai_imx8mm_data = {
+	.use_imx_pcm = true,
+	.use_edma = false,
+	.fifo_depth = 128,
+	.reg_offset = 8,
+	.mclk0_is_mclk1 = false,
+	.pins = 8,
+	.flags = 0,
+	.max_register = FSL_SAI_MCTL,
 };
 
 static const struct of_device_id fsl_sai_ids[] = {
@@ -1252,6 +1268,7 @@ static const struct of_device_id fsl_sai_ids[] = {
 	{ .compatible = "fsl,imx7ulp-sai", .data = &fsl_sai_imx7ulp_data },
 	{ .compatible = "fsl,imx8mq-sai", .data = &fsl_sai_imx8mq_data },
 	{ .compatible = "fsl,imx8qm-sai", .data = &fsl_sai_imx8qm_data },
+	{ .compatible = "fsl,imx8mm-sai", .data = &fsl_sai_imx8mm_data },
 	{ /* sentinel */ }
 };
 MODULE_DEVICE_TABLE(of, fsl_sai_ids);
diff --git a/sound/soc/fsl/fsl_sai.h b/sound/soc/fsl/fsl_sai.h
index 7310fd02cc3c..e4965efe6102 100644
--- a/sound/soc/fsl/fsl_sai.h
+++ b/sound/soc/fsl/fsl_sai.h
@@ -223,6 +223,7 @@ struct fsl_sai_soc_data {
 	unsigned int pins;
 	unsigned int reg_offset;
 	unsigned int flags;
+	unsigned int max_register;
 };
 
 /**
-- 
2.17.1

