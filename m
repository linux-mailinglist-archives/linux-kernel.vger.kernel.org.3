Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5008C51F833
	for <lists+linux-kernel@lfdr.de>; Mon,  9 May 2022 11:30:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237207AbiEIJdT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 May 2022 05:33:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45796 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237084AbiEIJaX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 May 2022 05:30:23 -0400
Received: from inva021.nxp.com (inva021.nxp.com [92.121.34.21])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 60C6A1C345D;
        Mon,  9 May 2022 02:26:28 -0700 (PDT)
Received: from inva021.nxp.com (localhost [127.0.0.1])
        by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id 3248F200E75;
        Mon,  9 May 2022 11:26:27 +0200 (CEST)
Received: from aprdc01srsp001v.ap-rdc01.nxp.com (aprdc01srsp001v.ap-rdc01.nxp.com [165.114.16.16])
        by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id F09C3200E74;
        Mon,  9 May 2022 11:26:26 +0200 (CEST)
Received: from localhost.localdomain (shlinux2.ap.freescale.net [10.192.224.44])
        by aprdc01srsp001v.ap-rdc01.nxp.com (Postfix) with ESMTP id 510B9180031C;
        Mon,  9 May 2022 17:26:25 +0800 (+08)
From:   Shengjiu Wang <shengjiu.wang@nxp.com>
To:     nicoleotsuka@gmail.com, Xiubo.Lee@gmail.com, festevam@gmail.com,
        shengjiu.wang@gmail.com, lgirdwood@gmail.com, broonie@kernel.org,
        perex@perex.cz, tiwai@suse.com, alsa-devel@alsa-project.org,
        robh+dt@kernel.org, krzk+dt@kernel.org, devicetree@vger.kernel.org
Cc:     linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: [PATCH 1/2] ASoC: fsl_micfil: Add support for i.MX8MPlus
Date:   Mon,  9 May 2022 17:14:22 +0800
Message-Id: <1652087663-1908-1-git-send-email-shengjiu.wang@nxp.com>
X-Mailer: git-send-email 2.7.4
X-Virus-Scanned: ClamAV using ClamSMTP
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On i.MX8Plus there are two updates for micfil module.

One is that the output format is S32_LE, only the 24 more
significative bits have information, the other bits are always
zero. Add 'formats' variable in soc data to distinguish the
format on different platform.
Another is that the fifo depth is 32 entries.

Signed-off-by: Shengjiu Wang <shengjiu.wang@nxp.com>
---
 sound/soc/fsl/fsl_micfil.c | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/sound/soc/fsl/fsl_micfil.c b/sound/soc/fsl/fsl_micfil.c
index e4d1da55293e..25c647ae080a 100644
--- a/sound/soc/fsl/fsl_micfil.c
+++ b/sound/soc/fsl/fsl_micfil.c
@@ -55,6 +55,7 @@ struct fsl_micfil_soc_data {
 	unsigned int fifo_depth;
 	unsigned int dataline;
 	bool imx;
+	u64  formats;
 };
 
 static struct fsl_micfil_soc_data fsl_micfil_imx8mm = {
@@ -62,10 +63,20 @@ static struct fsl_micfil_soc_data fsl_micfil_imx8mm = {
 	.fifos = 8,
 	.fifo_depth = 8,
 	.dataline =  0xf,
+	.formats = SNDRV_PCM_FMTBIT_S16_LE,
+};
+
+static struct fsl_micfil_soc_data fsl_micfil_imx8mp = {
+	.imx = true,
+	.fifos = 8,
+	.fifo_depth = 32,
+	.dataline =  0xf,
+	.formats = SNDRV_PCM_FMTBIT_S32_LE,
 };
 
 static const struct of_device_id fsl_micfil_dt_ids[] = {
 	{ .compatible = "fsl,imx8mm-micfil", .data = &fsl_micfil_imx8mm },
+	{ .compatible = "fsl,imx8mp-micfil", .data = &fsl_micfil_imx8mp },
 	{}
 };
 MODULE_DEVICE_TABLE(of, fsl_micfil_dt_ids);
@@ -659,6 +670,8 @@ static int fsl_micfil_probe(struct platform_device *pdev)
 		return ret;
 	}
 
+	fsl_micfil_dai.capture.formats = micfil->soc->formats;
+
 	ret = devm_snd_soc_register_component(&pdev->dev, &fsl_micfil_component,
 					      &fsl_micfil_dai, 1);
 	if (ret) {
-- 
2.17.1

