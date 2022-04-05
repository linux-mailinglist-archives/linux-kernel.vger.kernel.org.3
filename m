Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AD9554F49D4
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Apr 2022 02:35:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1451125AbiDEW3f (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Apr 2022 18:29:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41588 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1443103AbiDEPi5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Apr 2022 11:38:57 -0400
Received: from mx0b-001ae601.pphosted.com (mx0a-001ae601.pphosted.com [67.231.149.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B2333BBE31;
        Tue,  5 Apr 2022 06:54:39 -0700 (PDT)
Received: from pps.filterd (m0077473.ppops.net [127.0.0.1])
        by mx0a-001ae601.pphosted.com (8.16.1.2/8.16.1.2) with ESMTP id 235BpSUD025148;
        Tue, 5 Apr 2022 08:54:26 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=PODMain02222019;
 bh=4d6rWR2g05rrvgH9va5u4PzJbivisDzt5rjTsvYag0c=;
 b=Mn5mZuyzXlj2NymzhbFhc00KtzTkkm0ahpwT0N4SH1DqKDIWibBjdTV/uheKL0Cb4wm8
 Wit1TM1nUcKCt6yD+GDGhcazOLnLkP2TTmBNfgiaU5c2I4bzIC1Y/4sgROIwC3exvoNg
 Uum8ftOB0iMBnl6OEMC/vR4G72GZg7krklc+jb77+6sVD09+GLimo9sPEZSBfPgmFLNu
 j+o8Ol09ny6yfspIozkypXKsk0ykIalrYsvNlm0v1Z/6JH0gorbLx4lVGD5KnRFx+AgN
 1qavsb0GqFFcNLcUXuVxqNkM7ODnzJGEM5hM1E2eHMTqVloBmn6yNh9NMVcYcnmrUp+w PA== 
Received: from ediex02.ad.cirrus.com ([84.19.233.68])
        by mx0a-001ae601.pphosted.com (PPS) with ESMTPS id 3f6kw2brwt-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Tue, 05 Apr 2022 08:54:26 -0500
Received: from EDIEX01.ad.cirrus.com (198.61.84.80) by EDIEX02.ad.cirrus.com
 (198.61.84.81) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Tue, 5 Apr
 2022 14:54:23 +0100
Received: from ediswmail.ad.cirrus.com (198.61.86.93) by EDIEX01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server id 15.1.2375.24 via Frontend
 Transport; Tue, 5 Apr 2022 14:54:23 +0100
Received: from AUSNPC0LSNW1-debian.cirrus.com (AUSNPC0LSNW1.ad.cirrus.com [198.61.65.88])
        by ediswmail.ad.cirrus.com (Postfix) with ESMTP id 9711B475;
        Tue,  5 Apr 2022 13:54:23 +0000 (UTC)
From:   Richard Fitzgerald <rf@opensource.cirrus.com>
To:     <broonie@kernel.org>
CC:     <robh+dt@kernel.org>, <alsa-devel@alsa-project.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <patches@opensource.cirrus.com>,
        Richard Fitzgerald <rf@opensource.cirrus.com>
Subject: [PATCH v2 2/5] ASoC: soc-utils: Add helper to calculate BCLK from TDM info
Date:   Tue, 5 Apr 2022 14:54:16 +0100
Message-ID: <20220405135419.1230088-3-rf@opensource.cirrus.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220405135419.1230088-1-rf@opensource.cirrus.com>
References: <20220405135419.1230088-1-rf@opensource.cirrus.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: eT3ZaaXP_DxRzllQcsDM9-C86CHR2txL
X-Proofpoint-GUID: eT3ZaaXP_DxRzllQcsDM9-C86CHR2txL
X-Proofpoint-Spam-Reason: safe
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add a helper function snd_soc_tdm_params_to_bclk() to calculate
the bclk from params info and the tdm sots configuration.

When using a TDM frame of N slots of width W bits:

   bclk = sample_rate * N * W

As a convenience to simplify calling code, if the slot count or
slot width are 0 a value will be obtained from the params. This
allows calling code to use this one function to handle cases of
TDM where only one parameter is fixed, or I2S where the slot width
is fixed (for example to set a 32-bit slot for 24-bit samples).

Also as a convenience the slot count can optionally be rounded up
to a multiple. This is mainly useful for I2S systems, since I2S has
two phases of LRCLK the number of slots is always a multiple of 2.

Signed-off-by: Richard Fitzgerald <rf@opensource.cirrus.com>
---
 include/sound/soc.h   |  2 ++
 sound/soc/soc-utils.c | 45 +++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 47 insertions(+)

diff --git a/include/sound/soc.h b/include/sound/soc.h
index 55fb6a6d7d25..2d3261799d2c 100644
--- a/include/sound/soc.h
+++ b/include/sound/soc.h
@@ -487,6 +487,8 @@ int snd_soc_calc_frame_size(int sample_size, int channels, int tdm_slots);
 int snd_soc_params_to_frame_size(struct snd_pcm_hw_params *params);
 int snd_soc_calc_bclk(int fs, int sample_size, int channels, int tdm_slots);
 int snd_soc_params_to_bclk(struct snd_pcm_hw_params *parms);
+int snd_soc_tdm_params_to_bclk(struct snd_pcm_hw_params *params,
+			       int tdm_width, int tdm_slots, int slot_multiple);
 
 /* set runtime hw params */
 int snd_soc_set_runtime_hwparams(struct snd_pcm_substream *substream,
diff --git a/sound/soc/soc-utils.c b/sound/soc/soc-utils.c
index a4efe7e52a8b..594cb311ff30 100644
--- a/sound/soc/soc-utils.c
+++ b/sound/soc/soc-utils.c
@@ -9,6 +9,7 @@
 
 #include <linux/platform_device.h>
 #include <linux/export.h>
+#include <linux/math.h>
 #include <sound/core.h>
 #include <sound/pcm.h>
 #include <sound/pcm_params.h>
@@ -52,6 +53,50 @@ int snd_soc_params_to_bclk(struct snd_pcm_hw_params *params)
 }
 EXPORT_SYMBOL_GPL(snd_soc_params_to_bclk);
 
+/**
+ * snd_soc_tdm_params_to_bclk - calculate bclk from params and tdm slot info.
+ *
+ * Calculate the bclk from the params sample rate and the tdm slot count and
+ * tdm slot width. Either or both of tdm_width and tdm_slots can be 0.
+ *
+ * If tdm_width == 0 and tdm_slots > 0:	the params_width will be used.
+ * If tdm_width > 0 and tdm_slots == 0:	the params_channels will be used
+ *					as the slot count.
+ * Both tdm_width and tdm_slots are 0:	this is equivalent to calling
+ *					snd_soc_params_to_bclk().
+ *
+ * If slot_multiple > 1 the slot count (or params_channels if tdm_slots == 0)
+ * will be rounded up to a multiple of this value. This is mainly useful for
+ * I2S mode, which has a left and right phase so the number of slots is always
+ * a multiple of 2.
+ *
+ * @params:        Pointer to struct_pcm_hw_params.
+ * @tdm_width:     Width in bits of the tdm slots.
+ * @tdm_slots:     Number of tdm slots per frame.
+ * @slot_multiple: If >1 roundup slot count to a multiple of this value.
+ *
+ * Return: bclk frequency in Hz, else a negative error code if params format
+ *	   is invalid.
+ */
+int snd_soc_tdm_params_to_bclk(struct snd_pcm_hw_params *params,
+			       int tdm_width, int tdm_slots, int slot_multiple)
+{
+	if (!tdm_slots)
+		tdm_slots = params_channels(params);
+
+	if (slot_multiple > 1)
+		tdm_slots = roundup(tdm_slots, slot_multiple);
+
+	if (!tdm_width) {
+		tdm_width = snd_pcm_format_width(params_format(params));
+		if (tdm_width < 0)
+			return tdm_width;
+	}
+
+	return snd_soc_calc_bclk(params_rate(params), tdm_width, 1, tdm_slots);
+}
+EXPORT_SYMBOL_GPL(snd_soc_tdm_params_to_bclk);
+
 static const struct snd_pcm_hardware dummy_dma_hardware = {
 	/* Random values to keep userspace happy when checking constraints */
 	.info			= SNDRV_PCM_INFO_INTERLEAVED |
-- 
2.30.2

