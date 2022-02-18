Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9F61C4BBB23
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Feb 2022 15:56:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236457AbiBRO4k (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Feb 2022 09:56:40 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:50272 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232520AbiBRO42 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Feb 2022 09:56:28 -0500
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com [IPv6:2a00:1450:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F9E557B1A
        for <linux-kernel@vger.kernel.org>; Fri, 18 Feb 2022 06:56:04 -0800 (PST)
Received: by mail-wr1-x431.google.com with SMTP id i14so14999406wrc.10
        for <linux-kernel@vger.kernel.org>; Fri, 18 Feb 2022 06:56:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=nJkHxY5AR6xqJWj38hKMvv+Z6LskhPZHMXhRMUaTZBg=;
        b=d4/A7tapqhoj+nKQknbI9myUskve33mE681HrsO26zPtt277c7xD5xX1OUlmAVlFMM
         GazLRWwYi7bBKTz0B+bjiXXoNTZPLzZ6xgpE/oHg8wA+lSQYCx4M33ob2H0UmVjv7HyZ
         Hv3bJhIlhPfm0Yo9043I6dnA8OZ4xd38JXmZwzeziS7hSM8e6qmSv8n0s81VklGSqHX9
         vadFGHdH+6mdVgHOCY8KY/dF7owTVl4GJTmNe+rdf+deBJWkw2N9SlRpAwhVHJ1I87H6
         ExctPr4MqPcB5h6o47uN6YRYlXtxsK3BPfBQpkMbqDG3w12PaIbJTsy1tUCEImY8HjP1
         GaHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=nJkHxY5AR6xqJWj38hKMvv+Z6LskhPZHMXhRMUaTZBg=;
        b=AdJekj9/D8YV5IiAsLj41gWGhqoEuiyUcDbPijEfIppvAgjuRUz9WpuEmBpHAYE1LE
         Zt3mpzhM06pzrc6VffAfXjDW8kfyIB7s/J6KxkQ51abUAvCZesEeetBGYTT6bepC9crb
         nFMX2+Rt5GuluZPqLlBgQf0r09n4yS42+BiEdEQczNG4Isft1+HG0DLPiqC3oJiPpvw2
         wWurQ1GoxEI8Q39HHYNDnG80QS7HSWFcgR5WKV645qpQ/U2M9vFqdsXKUH8Ri8m3c3N5
         cS1zG8KoBPQ6Kji7+d00hEv2fJa9oqkRUnHBdaPNN3Q8/8az9oKciWeaCAiNbOIhWSJR
         WjBA==
X-Gm-Message-State: AOAM53313n5X5HTnH0PwqmOOppIaFNI5gm6fnT8UsCpagpmVchpUVBm6
        W/eF9RQBEE4hUgeN7IcFX+3ZuQ==
X-Google-Smtp-Source: ABdhPJzKg+0QXkil1m7jx6gI2ctEKlAP5e/CL5A6ueJGTjphI0RFc7JztgkWPfSY1UibxXF5qSrFxg==
X-Received: by 2002:adf:8170:0:b0:1e0:6087:9d42 with SMTP id 103-20020adf8170000000b001e060879d42mr6297395wrm.217.1645196163141;
        Fri, 18 Feb 2022 06:56:03 -0800 (PST)
Received: from localhost.localdomain (2a02-8440-6241-3b28-3074-96af-9642-0002.rev.sfr.net. [2a02:8440:6241:3b28:3074:96af:9642:2])
        by smtp.gmail.com with ESMTPSA id b10sm47431454wrd.8.2022.02.18.06.56.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Feb 2022 06:56:02 -0800 (PST)
From:   Guillaume Ranquet <granquet@baylibre.com>
To:     chunkuang.hu@kernel.org, p.zabel@pengutronix.de, airlied@linux.ie,
        daniel@ffwll.ch, robh+dt@kernel.org,
        maarten.lankhorst@linux.intel.com, mripard@kernel.org,
        tzimmermann@suse.de, matthias.bgg@gmail.com,
        chunfeng.yun@mediatek.com, kishon@ti.com, vkoul@kernel.org,
        deller@gmx.de, ck.hu@mediatek.com, jitao.shi@mediatek.com,
        angelogioacchino.delregno@collabora.com
Cc:     dri-devel@lists.freedesktop.org,
        linux-mediatek@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-phy@lists.infradead.org, linux-fbdev@vger.kernel.org,
        Markus Schneider-Pargmann <msp@baylibre.com>
Subject: [PATCH v8 03/19] drm/edid: Add cea_sad helpers for freq/length
Date:   Fri, 18 Feb 2022 15:54:21 +0100
Message-Id: <20220218145437.18563-4-granquet@baylibre.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220218145437.18563-1-granquet@baylibre.com>
References: <20220218145437.18563-1-granquet@baylibre.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Markus Schneider-Pargmann <msp@baylibre.com>

This patch adds two helper functions that extract the frequency and word
length from a struct cea_sad.

For these helper functions new defines are added that help translate the
'freq' and 'byte2' fields into real numbers.

Signed-off-by: Markus Schneider-Pargmann <msp@baylibre.com>
Signed-off-by: Guillaume Ranquet <granquet@baylibre.com>
---
 drivers/gpu/drm/drm_edid.c | 74 ++++++++++++++++++++++++++++++++++++++
 include/drm/drm_edid.h     | 18 ++++++++--
 2 files changed, 90 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/drm_edid.c b/drivers/gpu/drm/drm_edid.c
index 12893e7be89bb..500279a82167a 100644
--- a/drivers/gpu/drm/drm_edid.c
+++ b/drivers/gpu/drm/drm_edid.c
@@ -4747,6 +4747,80 @@ int drm_edid_to_speaker_allocation(struct edid *edid, u8 **sadb)
 }
 EXPORT_SYMBOL(drm_edid_to_speaker_allocation);
 
+/**
+ * drm_cea_sad_get_sample_rate - Extract the sample rate from cea_sad
+ * @sad: Pointer to the cea_sad struct
+ *
+ * Extracts the cea_sad frequency field and returns the sample rate in Hz.
+ *
+ * Return: Sample rate in Hz or a negative errno if parsing failed.
+ */
+int drm_cea_sad_get_sample_rate(const struct cea_sad *sad)
+{
+	switch (sad->freq) {
+	case DRM_CEA_SAD_FREQ_32KHZ:
+		return 32000;
+	case DRM_CEA_SAD_FREQ_44KHZ:
+		return 44100;
+	case DRM_CEA_SAD_FREQ_48KHZ:
+		return 48000;
+	case DRM_CEA_SAD_FREQ_88KHZ:
+		return 88200;
+	case DRM_CEA_SAD_FREQ_96KHZ:
+		return 96000;
+	case DRM_CEA_SAD_FREQ_176KHZ:
+		return 176400;
+	case DRM_CEA_SAD_FREQ_192KHZ:
+		return 192000;
+	default:
+		return -EINVAL;
+	}
+}
+EXPORT_SYMBOL(drm_cea_sad_get_sample_rate);
+
+static bool drm_cea_sad_is_uncompressed(const struct cea_sad *sad)
+{
+	switch (sad->format) {
+	case HDMI_AUDIO_CODING_TYPE_STREAM:
+	case HDMI_AUDIO_CODING_TYPE_PCM:
+		return true;
+	default:
+		return false;
+	}
+}
+
+/**
+ * drm_cea_sad_get_uncompressed_word_length - Extract word length
+ * @sad: Pointer to the cea_sad struct
+ *
+ * Extracts the cea_sad byte2 field and returns the word length for an
+ * uncompressed stream.
+ *
+ * Note: This function may only be called for uncompressed audio.
+ *
+ * Return: Word length in bits or a negative errno if parsing failed.
+ */
+int drm_cea_sad_get_uncompressed_word_length(const struct cea_sad *sad)
+{
+	if (!drm_cea_sad_is_uncompressed(sad)) {
+		DRM_WARN("Unable to get the uncompressed word length for a compressed format: %u\n",
+			 sad->format);
+		return -EINVAL;
+	}
+
+	switch (sad->byte2) {
+	case DRM_CEA_SAD_UNCOMPRESSED_WORD_16BIT:
+		return 16;
+	case DRM_CEA_SAD_UNCOMPRESSED_WORD_20BIT:
+		return 20;
+	case DRM_CEA_SAD_UNCOMPRESSED_WORD_24BIT:
+		return 24;
+	default:
+		return -EINVAL;
+	}
+}
+EXPORT_SYMBOL(drm_cea_sad_get_uncompressed_word_length);
+
 /**
  * drm_av_sync_delay - compute the HDMI/DP sink audio-video sync delay
  * @connector: connector associated with the HDMI/DP sink
diff --git a/include/drm/drm_edid.h b/include/drm/drm_edid.h
index 18f6c700f6d02..a30452b313979 100644
--- a/include/drm/drm_edid.h
+++ b/include/drm/drm_edid.h
@@ -361,12 +361,24 @@ struct edid {
 
 /* Short Audio Descriptor */
 struct cea_sad {
-	u8 format;
+	u8 format; /* See HDMI_AUDIO_CODING_TYPE_* */
 	u8 channels; /* max number of channels - 1 */
-	u8 freq;
+	u8 freq; /* See CEA_SAD_FREQ_* */
 	u8 byte2; /* meaning depends on format */
 };
 
+#define DRM_CEA_SAD_FREQ_32KHZ  BIT(0)
+#define DRM_CEA_SAD_FREQ_44KHZ  BIT(1)
+#define DRM_CEA_SAD_FREQ_48KHZ  BIT(2)
+#define DRM_CEA_SAD_FREQ_88KHZ  BIT(3)
+#define DRM_CEA_SAD_FREQ_96KHZ  BIT(4)
+#define DRM_CEA_SAD_FREQ_176KHZ BIT(5)
+#define DRM_CEA_SAD_FREQ_192KHZ BIT(6)
+
+#define DRM_CEA_SAD_UNCOMPRESSED_WORD_16BIT BIT(0)
+#define DRM_CEA_SAD_UNCOMPRESSED_WORD_20BIT BIT(1)
+#define DRM_CEA_SAD_UNCOMPRESSED_WORD_24BIT BIT(2)
+
 struct drm_encoder;
 struct drm_connector;
 struct drm_connector_state;
@@ -374,6 +386,8 @@ struct drm_display_mode;
 
 int drm_edid_to_sad(struct edid *edid, struct cea_sad **sads);
 int drm_edid_to_speaker_allocation(struct edid *edid, u8 **sadb);
+int drm_cea_sad_get_sample_rate(const struct cea_sad *sad);
+int drm_cea_sad_get_uncompressed_word_length(const struct cea_sad *sad);
 int drm_av_sync_delay(struct drm_connector *connector,
 		      const struct drm_display_mode *mode);
 
-- 
2.34.1

