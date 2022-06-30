Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D6CDD560DF2
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Jun 2022 02:26:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230274AbiF3AYX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Jun 2022 20:24:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49356 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230031AbiF3AYJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Jun 2022 20:24:09 -0400
Received: from mx0b-001ae601.pphosted.com (mx0a-001ae601.pphosted.com [67.231.149.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 40EDF1CB3F
        for <linux-kernel@vger.kernel.org>; Wed, 29 Jun 2022 17:24:09 -0700 (PDT)
Received: from pps.filterd (m0077473.ppops.net [127.0.0.1])
        by mx0a-001ae601.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 25U004kN009594;
        Wed, 29 Jun 2022 19:23:50 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=PODMain02222019;
 bh=d2eWHj969nDC+AiOnIH5VRJeuleAP2YqL7dzLJZL43M=;
 b=PX1SdcHlK4KhTcHyypkyU2Ml4qQ2D7gYqP/KawAy2v3AmlZdXav8LPWS9bY8BnSiCQb2
 nNFyFsea//J5uR0RV4AJJkJMSpjNmL7A7r2AuFa7xkhuYpsmnCHSx+xc4pbooT8bWSqK
 2OlW/IG6De0jBA96c+WinniR70q/GWHr1BoIwG+a/R7ZI/TiEuCVvDMYGnm9yA0IknQ0
 gRH4hHay4UFWAB3kqa0fhpP4y0jKaJq93H3wJL8UaCR31kR/Dmp9acSGxfyujKovpT4f
 0vp+6IsY/j+XL170ARgOQKu+TVuHohNgZiyZ7MpK5QHS850rxTpPUzLh3xEoQTP/iGgS DA== 
Received: from ediex02.ad.cirrus.com ([84.19.233.68])
        by mx0a-001ae601.pphosted.com (PPS) with ESMTPS id 3gwys2p9gn-5
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Wed, 29 Jun 2022 19:23:50 -0500
Received: from EDIEX01.ad.cirrus.com (198.61.84.80) by EDIEX02.ad.cirrus.com
 (198.61.84.81) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Thu, 30 Jun
 2022 01:23:47 +0100
Received: from ediswmail.ad.cirrus.com (198.61.86.93) by EDIEX01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server id 15.1.2375.28 via Frontend
 Transport; Thu, 30 Jun 2022 01:23:47 +0100
Received: from vitaly-Legion-7-16ACHg6.ad.cirrus.com (unknown [198.90.238.125])
        by ediswmail.ad.cirrus.com (Postfix) with ESMTP id A5ABC7C;
        Thu, 30 Jun 2022 00:23:47 +0000 (UTC)
From:   Vitaly Rodionov <vitalyr@opensource.cirrus.com>
To:     Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>,
        Mark Brown <broonie@kernel.org>
CC:     <alsa-devel@alsa-project.org>, <patches@opensource.cirrus.com>,
        <linux-kernel@vger.kernel.org>,
        Stefan Binding <sbinding@opensource.cirrus.com>
Subject: [PATCH v8 12/14] ALSA: hda: cs35l41: Add defaulted values into dsp bypass config sequence
Date:   Thu, 30 Jun 2022 01:23:33 +0100
Message-ID: <20220630002335.366545-13-vitalyr@opensource.cirrus.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220630002335.366545-1-vitalyr@opensource.cirrus.com>
References: <20220630002335.366545-1-vitalyr@opensource.cirrus.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: lFMzhL22VGV0w6KPypRkzFLg7g86yhDo
X-Proofpoint-GUID: lFMzhL22VGV0w6KPypRkzFLg7g86yhDo
X-Proofpoint-Spam-Reason: safe
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Stefan Binding <sbinding@opensource.cirrus.com>

The config sequences for running with and without firmware and DSP
are different. The original behavior assumed that we would only
run without DSP only in the case where firmware load failed.
This meant the non-firmware sequence was written with the assumtion
that various registers would be set to their default value.
However, to support the ability to unload the firmware, the
non-firmware register sequence must be updated to update all
required registers, including values that would be defaulted,
in case the firmware sequence, which could have already run,
has changed their value.

Signed-off-by: Stefan Binding <sbinding@opensource.cirrus.com>
Signed-off-by: Vitaly Rodionov <vitalyr@opensource.cirrus.com>
---
 sound/pci/hda/cs35l41_hda.c | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/sound/pci/hda/cs35l41_hda.c b/sound/pci/hda/cs35l41_hda.c
index 68f18463d829..27ed5cd0d8bb 100644
--- a/sound/pci/hda/cs35l41_hda.c
+++ b/sound/pci/hda/cs35l41_hda.c
@@ -35,11 +35,24 @@
 
 static const struct reg_sequence cs35l41_hda_config[] = {
 	{ CS35L41_PLL_CLK_CTRL,		0x00000430 }, // 3072000Hz, BCLK Input, PLL_REFCLK_EN = 1
+	{ CS35L41_DSP_CLK_CTRL,		0x00000003 }, // DSP CLK EN
 	{ CS35L41_GLOBAL_CLK_CTRL,	0x00000003 }, // GLOBAL_FS = 48 kHz
 	{ CS35L41_SP_ENABLES,		0x00010000 }, // ASP_RX1_EN = 1
 	{ CS35L41_SP_RATE_CTRL,		0x00000021 }, // ASP_BCLK_FREQ = 3.072 MHz
 	{ CS35L41_SP_FORMAT,		0x20200200 }, // 32 bits RX/TX slots, I2S, clk consumer
+	{ CS35L41_SP_HIZ_CTRL,		0x00000002 }, // Hi-Z unused
+	{ CS35L41_SP_TX_WL,		0x00000018 }, // 24 cycles/slot
+	{ CS35L41_SP_RX_WL,		0x00000018 }, // 24 cycles/slot
 	{ CS35L41_DAC_PCM1_SRC,		0x00000008 }, // DACPCM1_SRC = ASPRX1
+	{ CS35L41_ASP_TX1_SRC,		0x00000018 }, // ASPTX1 SRC = VMON
+	{ CS35L41_ASP_TX2_SRC,		0x00000019 }, // ASPTX2 SRC = IMON
+	{ CS35L41_ASP_TX3_SRC,		0x00000032 }, // ASPTX3 SRC = ERRVOL
+	{ CS35L41_ASP_TX4_SRC,		0x00000033 }, // ASPTX4 SRC = CLASSH_TGT
+	{ CS35L41_DSP1_RX1_SRC,		0x00000008 }, // DSP1RX1 SRC = ASPRX1
+	{ CS35L41_DSP1_RX2_SRC,		0x00000009 }, // DSP1RX2 SRC = ASPRX2
+	{ CS35L41_DSP1_RX3_SRC,         0x00000018 }, // DSP1RX3 SRC = VMON
+	{ CS35L41_DSP1_RX4_SRC,         0x00000019 }, // DSP1RX4 SRC = IMON
+	{ CS35L41_DSP1_RX5_SRC,         0x00000020 }, // DSP1RX5 SRC = ERRVOL
 	{ CS35L41_AMP_DIG_VOL_CTRL,	0x00000000 }, // AMP_VOL_PCM  0.0 dB
 	{ CS35L41_AMP_GAIN_CTRL,	0x00000084 }, // AMP_GAIN_PCM 4.5 dB
 };
-- 
2.34.1

