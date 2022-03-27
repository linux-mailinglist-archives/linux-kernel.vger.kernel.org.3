Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B43814E8AC3
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Mar 2022 00:43:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237101AbiC0WoB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 27 Mar 2022 18:44:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45566 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236998AbiC0Wmq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 27 Mar 2022 18:42:46 -0400
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com [IPv6:2a00:1450:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 69F0B32EE0
        for <linux-kernel@vger.kernel.org>; Sun, 27 Mar 2022 15:41:07 -0700 (PDT)
Received: by mail-wr1-x42e.google.com with SMTP id a1so17889404wrh.10
        for <linux-kernel@vger.kernel.org>; Sun, 27 Mar 2022 15:41:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=FFfw8+AcCO+oGSsE3C0mLYlgKyVPXn65QX6gJCkZYQ8=;
        b=PtCrAZqRN/HnmjJXDVwdcrFJ09HL3kht6yfTyoxnzNMjZQpba9EJRCFkFBuQ0na9il
         0AqPgXohm4+Yzcfg7GXzOd8EJiS2oq6Ig2G4UAbcnTZdxHHVrm/jD1K2ru9K3Uy6T8Rm
         mrLa0VB1LLDeiRDpAULWfxSEPbFvHERKjcVUm/mXGTyFOufpo/UdrGL1K6zUBc6DkcjN
         0IQ3DxKSTimhZEoDS2N4PLCnhaplQVWY4dkT3xxpwK2WU0dgonXi261cZBrPrfPmfuWg
         NGZO4bwiUNdsGmxL1vH/cTsH67jElytW5Qro3oWtF5mb0W1ape333kLElvu8jSdqF6Jv
         MG9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=FFfw8+AcCO+oGSsE3C0mLYlgKyVPXn65QX6gJCkZYQ8=;
        b=wna9lSiZHosgUzEPRbVALkuz8cAKoCOCJLsvmHTP1g+8de8HRFqx0I1ofuCsrS7qyM
         Ed33k+vguDXo69/wIqI8HBEe/rvAU4NR4D+vCidja9FXWK5+21OaXuKeH2ySLnOippSZ
         kL2AXJYcnosXU1lxzGmtJNJyTk3C9VayLUcbTRhHFSdL57SiP++I3XdyBl6DtA2tGF0f
         pmzHFZGpUGF0s86NYScEnQXu3Q6TTojzMzITopMBohUHb7O/AC1scxN/mZjV2WFDCYE8
         /NcS0gStLIwA3zu6QdeOsgSoBcCUS7+CZl/zdBhmeLLdZ3sZDWmt85yIsLsR1BE/FyKf
         x/XQ==
X-Gm-Message-State: AOAM532jmxt/axT+JSBZiX1Qqx7gC3iEcvhX70rmUl1bu9iiBrB76WfP
        4eSZyMQepqisk8A2YFkeHYuniA==
X-Google-Smtp-Source: ABdhPJz6lVJWhj+/V8WiEX6cNk9H8uTXpPe8YFLNErcslI7n6gUFl/aIC510T7p6adIYgaXEn/pjQw==
X-Received: by 2002:a5d:4101:0:b0:205:86cb:dd1b with SMTP id l1-20020a5d4101000000b0020586cbdd1bmr19210023wrp.480.1648420865910;
        Sun, 27 Mar 2022 15:41:05 -0700 (PDT)
Received: from localhost.localdomain (2a02-8440-6341-357e-3074-96af-9642-0002.rev.sfr.net. [2a02:8440:6341:357e:3074:96af:9642:2])
        by smtp.gmail.com with ESMTPSA id v5-20020adfe4c5000000b001edc1e5053esm10400867wrm.82.2022.03.27.15.41.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 27 Mar 2022 15:41:05 -0700 (PDT)
From:   Guillaume Ranquet <granquet@baylibre.com>
To:     airlied@linux.ie, angelogioacchino.delregno@collabora.com,
        chunfeng.yun@mediatek.com, chunkuang.hu@kernel.org,
        ck.hu@mediatek.com, daniel@ffwll.ch, deller@gmx.de,
        jitao.shi@mediatek.com, kishon@ti.com, krzk+dt@kernel.org,
        maarten.lankhorst@linux.intel.com, matthias.bgg@gmail.com,
        mripard@kernel.org, p.zabel@pengutronix.de, robh+dt@kernel.org,
        tzimmermann@suse.de, vkoul@kernel.org
Cc:     devicetree@vger.kernel.org, dri-devel@lists.freedesktop.org,
        linux-arm-kernel@lists.infradead.org, linux-fbdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mediatek@lists.infradead.org,
        linux-phy@lists.infradead.org, markyacoub@google.com,
        Markus Schneider-Pargmann <msp@baylibre.com>
Subject: [PATCH v9 05/22] drm/edid: Add cea_sad helpers for freq/length
Date:   Mon, 28 Mar 2022 00:39:10 +0200
Message-Id: <20220327223927.20848-6-granquet@baylibre.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220327223927.20848-1-granquet@baylibre.com>
References: <20220327223927.20848-1-granquet@baylibre.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch adds two helper functions that extract the frequency and word
length from a struct cea_sad.

For these helper functions new defines are added that help translate the
'freq' and 'byte2' fields into real numbers.

Signed-off-by: Markus Schneider-Pargmann <msp@baylibre.com>
Signed-off-by: Guillaume Ranquet <granquet@baylibre.com>
---
 drivers/gpu/drm/drm_edid.c | 74 ++++++++++++++++++++++++++++++++++++++
 include/drm/drm_edid.h     | 14 ++++++++
 2 files changed, 88 insertions(+)

diff --git a/drivers/gpu/drm/drm_edid.c b/drivers/gpu/drm/drm_edid.c
index cc7bd58369df..eeceae4411ba 100644
--- a/drivers/gpu/drm/drm_edid.c
+++ b/drivers/gpu/drm/drm_edid.c
@@ -4758,6 +4758,80 @@ int drm_edid_to_speaker_allocation(struct edid *edid, u8 **sadb)
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
index 5d4d840b9904..ebd00ecae205 100644
--- a/include/drm/drm_edid.h
+++ b/include/drm/drm_edid.h
@@ -372,6 +372,18 @@ struct cea_sad {
 	u8 byte2;
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
@@ -379,6 +391,8 @@ struct drm_display_mode;
 
 int drm_edid_to_sad(struct edid *edid, struct cea_sad **sads);
 int drm_edid_to_speaker_allocation(struct edid *edid, u8 **sadb);
+int drm_cea_sad_get_sample_rate(const struct cea_sad *sad);
+int drm_cea_sad_get_uncompressed_word_length(const struct cea_sad *sad);
 int drm_av_sync_delay(struct drm_connector *connector,
 		      const struct drm_display_mode *mode);
 
-- 
2.34.1

