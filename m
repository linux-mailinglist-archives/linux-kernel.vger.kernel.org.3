Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6AB2C47FB5A
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Dec 2021 10:34:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235816AbhL0JeA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Dec 2021 04:34:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40650 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229652AbhL0Jd7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Dec 2021 04:33:59 -0500
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com [IPv6:2a00:1450:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A821C06173E
        for <linux-kernel@vger.kernel.org>; Mon, 27 Dec 2021 01:33:59 -0800 (PST)
Received: by mail-ed1-x536.google.com with SMTP id x15so59674332edv.1
        for <linux-kernel@vger.kernel.org>; Mon, 27 Dec 2021 01:33:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=DPDBPrmR0Iq3ngKw0EvBqQA5UwN0K6nnYMPRbJ4cDDg=;
        b=gf/KumjXPSM0dv4bFPhfqhpqPjbxaDyNvzOfiu/gbp7F++KzoH4/+MMJV7B9Fn1kJ3
         E3m8ZeuTmFOlI6LiGjOzv4ABqVBJZQcmHcgeIJnd45pZ/tF5MDs8LoFN0h6c69dtoByp
         Yu8kYKBO2uZ8cQhxgtAiDKULBExcIUp6eTNfH3hugD1d/QygQ0n14zGrsg5+enMgVjll
         2GxS/7Qy1/qkxog3f9KRCgmC49oNPYb8hrWtM6DvsT+1JVOPDNPQaOTLBi7AH2V612/p
         ZelIGyzu6UQgBNhBSlptWS+86tWaWCSPUiVmtRwYk39f9yC5jmBctjLNdbdR9VqWr1hm
         Vcfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=DPDBPrmR0Iq3ngKw0EvBqQA5UwN0K6nnYMPRbJ4cDDg=;
        b=vbmHTfjyMAO8jrEAjoIEpL9PcOkm2M8GzJAnFcLvhKGj85fVczm3qwkLZHsxt3DDpA
         MvNeaO1GgCzAjzJyF1v+VQkqyMep8f+W9rkQVtShwK/LqIA7CJ7CbBaYV+30ov3HW7SO
         rVPJT8xJAZ3GFOVk2pVj3AD4Q7Yz+Hj7ftBrUwsr0qUhKBKCsSL1Nt/sE5m5EiEW/FVf
         27Sqk87B5Ao/08VeJYG6nQ8sbpHXbJM9ZIwC5g6Xvsyga74HrkT8Nml+fk7Lksb80u0O
         inFgIiEyPSaIdjkNmNJnsCJ1NQKyOwwwXglW6VDRRktbZ0iH5VGGD4kB4VMyoqWkAfK8
         BwZQ==
X-Gm-Message-State: AOAM531Lp7+c0wqxDM+HG7gSGa3VGBTeJrjjmbhR0CvCZiPb0MbJieEl
        HFkxU5sqklyzQm1t4l7zOls6yA==
X-Google-Smtp-Source: ABdhPJyzG3F596+LDFlD5eCYFkrk+Tg/ro+9uoAis4ZQJVCmYhq1uG3Jp2KSwG1AQVNOg1wpzvd46g==
X-Received: by 2002:a05:6402:12ce:: with SMTP id k14mr15888321edx.314.1640597637915;
        Mon, 27 Dec 2021 01:33:57 -0800 (PST)
Received: from localhost.localdomain (2a02-8440-6140-7e07-3074-96af-9642-0003.rev.sfr.net. [2a02:8440:6140:7e07:3074:96af:9642:3])
        by smtp.gmail.com with ESMTPSA id qf14sm4287568ejc.18.2021.12.27.01.33.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Dec 2021 01:33:57 -0800 (PST)
From:   Guillaume Ranquet <granquet@baylibre.com>
To:     Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>
Cc:     Markus Schneider-Pargmann <msp@baylibre.com>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: [PATCH v7 3/8] drm/edid: Add cea_sad helpers for freq/length
Date:   Mon, 27 Dec 2021 10:33:27 +0100
Message-Id: <20211227093329.5589-1-granquet@baylibre.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20211217150854.2081-1-granquet@baylibre.com>
References: <20211217150854.2081-1-granquet@baylibre.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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
2.32.0

