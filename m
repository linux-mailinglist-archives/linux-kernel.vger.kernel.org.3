Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5756155441C
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Jun 2022 10:11:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353998AbiFVHrZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Jun 2022 03:47:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47658 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1353835AbiFVHrQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Jun 2022 03:47:16 -0400
Received: from mx0b-001ae601.pphosted.com (mx0b-001ae601.pphosted.com [67.231.152.168])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CB22137A1E
        for <linux-kernel@vger.kernel.org>; Wed, 22 Jun 2022 00:47:13 -0700 (PDT)
Received: from pps.filterd (m0077474.ppops.net [127.0.0.1])
        by mx0b-001ae601.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 25M7Su1O003738;
        Wed, 22 Jun 2022 02:47:01 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=PODMain02222019;
 bh=yEUjvzIDkSuesN4ILaRzVOzgfN/9xKEkJ3H0pI1QULM=;
 b=NrEYe35OCbFA5K4w3y/h6iCQ33rEWbfuNmpShF8nhhQGgg0RlCVdt9Tn+Bve2J26mLLF
 GENfcg63ZJ4IBPiv0aBBEZrX3fAiQXNpHFtpszx49M9RG52ASoNkkwFWRTHbmlX9VrIx
 t2cPHlIpZByDXPm9qMapNjd8GVMXBRrTT2atCtkyj0Dbgk4zn1gAnCMxrseOn6gbAG/t
 iguSEcUEsF4wsoSRezBFIXz6HhcCR/K5FIq5Qdl7wDONSEwyN2hx5tLKffLE6hXgz1YI
 zlMhHnO4ZcRnJkTUan4aCIlhyBAaRXJyoBIpPQPaV75fsfDW9qr6bm/HLYtVWKtPiCpl ZA== 
Received: from ediex02.ad.cirrus.com ([84.19.233.68])
        by mx0b-001ae601.pphosted.com (PPS) with ESMTPS id 3gsb4p4mwq-3
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Wed, 22 Jun 2022 02:47:01 -0500
Received: from EDIEX01.ad.cirrus.com (198.61.84.80) by EDIEX02.ad.cirrus.com
 (198.61.84.81) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Wed, 22 Jun
 2022 08:46:59 +0100
Received: from ediswmail.ad.cirrus.com (198.61.86.93) by EDIEX01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server id 15.1.2375.28 via Frontend
 Transport; Wed, 22 Jun 2022 08:46:59 +0100
Received: from vitaly-Legion-7-16ACHg6.ad.cirrus.com (unknown [198.90.238.175])
        by ediswmail.ad.cirrus.com (Postfix) with ESMTP id 89FD47C;
        Wed, 22 Jun 2022 07:46:59 +0000 (UTC)
From:   Vitaly Rodionov <vitalyr@opensource.cirrus.com>
To:     Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>,
        Mark Brown <broonie@kernel.org>
CC:     <alsa-devel@alsa-project.org>, <patches@opensource.cirrus.com>,
        <linux-kernel@vger.kernel.org>,
        Stefan Binding <sbinding@opensource.cirrus.com>
Subject: [PATCH v7 12/14] ALSA: hda: cs35l41: Add defaulted values into dsp bypass config sequence
Date:   Wed, 22 Jun 2022 08:46:51 +0100
Message-ID: <20220622074653.179078-13-vitalyr@opensource.cirrus.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220622074653.179078-1-vitalyr@opensource.cirrus.com>
References: <20220622074653.179078-1-vitalyr@opensource.cirrus.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-GUID: GPYNT5VgfyCEfZnDm8cGUkg_0o_g_PpR
X-Proofpoint-ORIG-GUID: GPYNT5VgfyCEfZnDm8cGUkg_0o_g_PpR
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
index ef3dfda7b03e..e51cdf42d3dc 100644
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

