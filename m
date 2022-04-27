Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4958A511D6D
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Apr 2022 20:35:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239181AbiD0PLS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Apr 2022 11:11:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40484 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238979AbiD0PK5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Apr 2022 11:10:57 -0400
Received: from mx0b-001ae601.pphosted.com (mx0b-001ae601.pphosted.com [67.231.152.168])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 41AC354BDB
        for <linux-kernel@vger.kernel.org>; Wed, 27 Apr 2022 08:07:46 -0700 (PDT)
Received: from pps.filterd (m0077474.ppops.net [127.0.0.1])
        by mx0b-001ae601.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 23RBg6qF022428;
        Wed, 27 Apr 2022 10:07:37 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=PODMain02222019;
 bh=zDxVSGAkKtjv3g42QnYWCUu981r8tGgcEbCI7pSZaJg=;
 b=hHfxsDltFzmEQNO1qJ9KjMXFxyGCUeqGOOoBlNREsXuAGHbbG1FwO3TtnTSiUYyg8cL8
 9YQr4X00sc/ty162nLIiF+BGeCyulUMZyiW9qdQy9IaeTCZh7zmQDjtAEY4v66ybF0d6
 kLfERri8zkqfrinmCr9AkjWrQqlLeikfgSC9nTl2So4mMi+/gio0F2njZz6joxK98flP
 jRwMjEZjGVt9hPS24yCV9A1Wl7TG2Stgki7g6yykT2+4dZMC3BIcUom2pL/oOp4z3M8Y
 qSKb8DDqkdJ4GH2NERAu3zTyugdbFANNKzWsVwfxbos/S8y6qco1BdINx1hZPMzysnIF 7A== 
Received: from ediex01.ad.cirrus.com ([84.19.233.68])
        by mx0b-001ae601.pphosted.com (PPS) with ESMTPS id 3fprt60xte-8
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Wed, 27 Apr 2022 10:07:37 -0500
Received: from EDIEX01.ad.cirrus.com (198.61.84.80) by EDIEX01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Wed, 27 Apr
 2022 16:07:25 +0100
Received: from ediswmail.ad.cirrus.com (198.61.86.93) by EDIEX01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server id 15.1.2375.24 via Frontend
 Transport; Wed, 27 Apr 2022 16:07:25 +0100
Received: from vitaly-Legion-7-16ACHg6.ad.cirrus.com (unknown [198.90.238.170])
        by ediswmail.ad.cirrus.com (Postfix) with ESMTP id 72AA5478;
        Wed, 27 Apr 2022 15:07:25 +0000 (UTC)
From:   Vitaly Rodionov <vitalyr@opensource.cirrus.com>
To:     Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>,
        Mark Brown <broonie@kernel.org>
CC:     <alsa-devel@alsa-project.org>, <patches@opensource.cirrus.com>,
        <linux-kernel@vger.kernel.org>,
        Stefan Binding <sbinding@opensource.cirrus.com>
Subject: [PATCH 08/26] ASoC: cs35l41: Move cs_dsp config struct into shared code
Date:   Wed, 27 Apr 2022 16:07:02 +0100
Message-ID: <20220427150720.9194-9-vitalyr@opensource.cirrus.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20220427150720.9194-1-vitalyr@opensource.cirrus.com>
References: <20220427150720.9194-1-vitalyr@opensource.cirrus.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-GUID: J4BoIbla7a2EjL3dpvG-BhHct41IwOgV
X-Proofpoint-ORIG-GUID: J4BoIbla7a2EjL3dpvG-BhHct41IwOgV
X-Proofpoint-Spam-Reason: safe
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Stefan Binding <sbinding@opensource.cirrus.com>

This can then be used by HDA code to configure cs_dsp.

Signed-off-by: Stefan Binding <sbinding@opensource.cirrus.com>
Signed-off-by: Vitaly Rodionov <vitalyr@opensource.cirrus.com>
---
 include/sound/cs35l41.h        |  2 ++
 sound/soc/codecs/cs35l41-lib.c | 24 ++++++++++++++++++++++++
 sound/soc/codecs/cs35l41.c     | 20 ++------------------
 3 files changed, 28 insertions(+), 18 deletions(-)

diff --git a/include/sound/cs35l41.h b/include/sound/cs35l41.h
index d0cfb41495b0..dd70fb8dd860 100644
--- a/include/sound/cs35l41.h
+++ b/include/sound/cs35l41.h
@@ -11,6 +11,7 @@
 #define __CS35L41_H
 
 #include <linux/regmap.h>
+#include <linux/firmware/cirrus/cs_dsp.h>
 
 #define CS35L41_FIRSTREG		0x00000000
 #define CS35L41_LASTREG			0x03804FE8
@@ -877,6 +878,7 @@ int cs35l41_set_channels(struct device *dev, struct regmap *reg,
 			 unsigned int tx_num, unsigned int *tx_slot,
 			 unsigned int rx_num, unsigned int *rx_slot);
 int cs35l41_gpio_config(struct regmap *regmap, struct cs35l41_hw_cfg *hw_cfg);
+void cs35l41_configure_cs_dsp(struct device *dev, struct regmap *reg, struct cs_dsp *dsp);
 int cs35l41_set_cspl_mbox_cmd(struct device *dev, struct regmap *regmap,
 			      enum cs35l41_cspl_mbox_cmd cmd);
 int cs35l41_write_fs_errata(struct device *dev, struct regmap *regmap);
diff --git a/sound/soc/codecs/cs35l41-lib.c b/sound/soc/codecs/cs35l41-lib.c
index 85fe5f88d6b4..37ae8ddccac9 100644
--- a/sound/soc/codecs/cs35l41-lib.c
+++ b/sound/soc/codecs/cs35l41-lib.c
@@ -12,6 +12,7 @@
 #include <linux/regmap.h>
 #include <linux/regulator/consumer.h>
 #include <linux/slab.h>
+#include <linux/firmware/cirrus/wmfw.h>
 
 #include <sound/cs35l41.h>
 
@@ -1225,6 +1226,29 @@ int cs35l41_gpio_config(struct regmap *regmap, struct cs35l41_hw_cfg *hw_cfg)
 }
 EXPORT_SYMBOL_GPL(cs35l41_gpio_config);
 
+static const struct cs_dsp_region cs35l41_dsp1_regions[] = {
+	{ .type = WMFW_HALO_PM_PACKED,	.base = CS35L41_DSP1_PMEM_0 },
+	{ .type = WMFW_HALO_XM_PACKED,	.base = CS35L41_DSP1_XMEM_PACK_0 },
+	{ .type = WMFW_HALO_YM_PACKED,	.base = CS35L41_DSP1_YMEM_PACK_0 },
+	{. type = WMFW_ADSP2_XM,	.base = CS35L41_DSP1_XMEM_UNPACK24_0},
+	{. type = WMFW_ADSP2_YM,	.base = CS35L41_DSP1_YMEM_UNPACK24_0},
+};
+
+void cs35l41_configure_cs_dsp(struct device *dev, struct regmap *reg, struct cs_dsp *dsp)
+{
+	dsp->num = 1;
+	dsp->type = WMFW_HALO;
+	dsp->rev = 0;
+	dsp->dev = dev;
+	dsp->regmap = reg;
+	dsp->base = CS35L41_DSP1_CTRL_BASE;
+	dsp->base_sysinfo = CS35L41_DSP1_SYS_ID;
+	dsp->mem = cs35l41_dsp1_regions;
+	dsp->num_mems = ARRAY_SIZE(cs35l41_dsp1_regions);
+	dsp->lock_regions = 0xFFFFFFFF;
+}
+EXPORT_SYMBOL_GPL(cs35l41_configure_cs_dsp);
+
 static bool cs35l41_check_cspl_mbox_sts(enum cs35l41_cspl_mbox_cmd cmd,
 					enum cs35l41_cspl_mbox_status sts)
 {
diff --git a/sound/soc/codecs/cs35l41.c b/sound/soc/codecs/cs35l41.c
index 75527649bb14..5f0eca229dd3 100644
--- a/sound/soc/codecs/cs35l41.c
+++ b/sound/soc/codecs/cs35l41.c
@@ -680,14 +680,6 @@ static const struct snd_soc_dapm_route cs35l41_audio_map[] = {
 	{"CLASS H", NULL, "PCM Source"},
 };
 
-static const struct cs_dsp_region cs35l41_dsp1_regions[] = {
-	{ .type = WMFW_HALO_PM_PACKED,	.base = CS35L41_DSP1_PMEM_0 },
-	{ .type = WMFW_HALO_XM_PACKED,	.base = CS35L41_DSP1_XMEM_PACK_0 },
-	{ .type = WMFW_HALO_YM_PACKED,	.base = CS35L41_DSP1_YMEM_PACK_0 },
-	{. type = WMFW_ADSP2_XM,	.base = CS35L41_DSP1_XMEM_UNPACK24_0},
-	{. type = WMFW_ADSP2_YM,	.base = CS35L41_DSP1_YMEM_UNPACK24_0},
-};
-
 static int cs35l41_set_channel_map(struct snd_soc_dai *dai, unsigned int tx_n,
 				   unsigned int *tx_slot, unsigned int rx_n, unsigned int *rx_slot)
 {
@@ -1100,18 +1092,10 @@ static int cs35l41_dsp_init(struct cs35l41_private *cs35l41)
 
 	dsp = &cs35l41->dsp;
 	dsp->part = "cs35l41";
-	dsp->cs_dsp.num = 1;
-	dsp->cs_dsp.type = WMFW_HALO;
-	dsp->cs_dsp.rev = 0;
 	dsp->fw = 9; /* 9 is WM_ADSP_FW_SPK_PROT in wm_adsp.c */
 	dsp->toggle_preload = true;
-	dsp->cs_dsp.dev = cs35l41->dev;
-	dsp->cs_dsp.regmap = cs35l41->regmap;
-	dsp->cs_dsp.base = CS35L41_DSP1_CTRL_BASE;
-	dsp->cs_dsp.base_sysinfo = CS35L41_DSP1_SYS_ID;
-	dsp->cs_dsp.mem = cs35l41_dsp1_regions;
-	dsp->cs_dsp.num_mems = ARRAY_SIZE(cs35l41_dsp1_regions);
-	dsp->cs_dsp.lock_regions = 0xFFFFFFFF;
+
+	cs35l41_configure_cs_dsp(cs35l41->dev, cs35l41->regmap, &dsp->cs_dsp);
 
 	ret = cs35l41_write_fs_errata(cs35l41->dev, cs35l41->regmap);
 	if (ret < 0)
-- 
2.32.0

