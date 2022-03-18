Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5FF1C4DDF04
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Mar 2022 17:30:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239303AbiCRQbe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Mar 2022 12:31:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50968 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239213AbiCRQbP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Mar 2022 12:31:15 -0400
Received: from mx0b-001ae601.pphosted.com (mx0a-001ae601.pphosted.com [67.231.149.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 52194197FA7;
        Fri, 18 Mar 2022 09:29:53 -0700 (PDT)
Received: from pps.filterd (m0077473.ppops.net [127.0.0.1])
        by mx0a-001ae601.pphosted.com (8.16.1.2/8.16.1.2) with ESMTP id 22I7cSw2022149;
        Fri, 18 Mar 2022 11:29:47 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=PODMain02222019;
 bh=E2Ca/oB4elvkgmoWONeTA/ymuvDOwmtGGZNN2Vs06l4=;
 b=gK6LEibl4YpQYcDDG50Pxr04y3AoWUWhnrDCQ9ts5+nNINsogqy6aYLgAYU5vlbBJUHi
 2ivJ8aNZxed7hQG+IxHLTM23rw2KHw3xIqn8kPtztZd7x3yM+o2B/EQzklI9ckkOMakN
 AnBNfwc7RfSOJIqHxzSj6QNLfB8jWuYfrNTpbHUVq8/u0zJyfujb0mMDF+tz2jfxPLK9
 KBJqTkwJOYG89I+/EGT8JGJ+6EAuZ1OgIXDxBVMxfZMGMOjVTJXTzYADkh42I78EVqiN
 jIWzckj20Huzw2kO+2pnZ+KSo7tDZ5TMjpMKsQYcC23tbKVtTgDxzDgqCayB+51GHMBm uA== 
Received: from ediex02.ad.cirrus.com ([84.19.233.68])
        by mx0a-001ae601.pphosted.com (PPS) with ESMTPS id 3et642efpx-3
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Fri, 18 Mar 2022 11:29:47 -0500
Received: from EDIEX01.ad.cirrus.com (198.61.84.80) by EDIEX02.ad.cirrus.com
 (198.61.84.81) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.18; Fri, 18 Mar
 2022 16:29:44 +0000
Received: from ediswmail.ad.cirrus.com (198.61.86.93) by EDIEX01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server id 15.1.2375.18 via Frontend
 Transport; Fri, 18 Mar 2022 16:29:44 +0000
Received: from debianA11184.ad.cirrus.com (debianA11184.ad.cirrus.com [198.90.251.45])
        by ediswmail.ad.cirrus.com (Postfix) with ESMTP id 6766CB1A;
        Fri, 18 Mar 2022 16:29:44 +0000 (UTC)
From:   Richard Fitzgerald <rf@opensource.cirrus.com>
To:     <broonie@kernel.org>, <robh+dt@kernel.org>
CC:     <alsa-devel@alsa-project.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <patches@opensource.cirrus.com>
Subject: [PATCH 2/5] ASoC: soc-utils: Add helper to calculate BCLK from TDM info
Date:   Fri, 18 Mar 2022 16:29:40 +0000
Message-ID: <20220318162943.1578102-3-rf@opensource.cirrus.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220318162943.1578102-1-rf@opensource.cirrus.com>
References: <20220318162943.1578102-1-rf@opensource.cirrus.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-GUID: 8YMBUqMJvoIJEkQaCMBtoYLgA0rKSGzL
X-Proofpoint-ORIG-GUID: 8YMBUqMJvoIJEkQaCMBtoYLgA0rKSGzL
X-Proofpoint-Spam-Reason: safe
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
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
index e063b1ea9634..44dba25ccf9d 100644
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

