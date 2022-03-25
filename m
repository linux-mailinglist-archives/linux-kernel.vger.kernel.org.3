Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 146684E79EE
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Mar 2022 18:18:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243729AbiCYRSz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Mar 2022 13:18:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33946 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346121AbiCYRSi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Mar 2022 13:18:38 -0400
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com [IPv6:2a00:1450:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C4E2EA35D
        for <linux-kernel@vger.kernel.org>; Fri, 25 Mar 2022 10:16:57 -0700 (PDT)
Received: by mail-wm1-x336.google.com with SMTP id bg31-20020a05600c3c9f00b00381590dbb33so4783357wmb.3
        for <linux-kernel@vger.kernel.org>; Fri, 25 Mar 2022 10:16:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Z/mBHvQzSlohdP6Aa3Rj5t3X9njBtjqppDVlQdCmxfc=;
        b=CMCqbAh0GFvsrtP1GnjamxjxLt3ShQ9z+tBofeKGr8FEt6IcISaj1/EUIc4TPQ0dDs
         It5/pCw1UbCyRnw9pPfA8wMSTTS0ujad+p2Z2gIHB0SK926nfHoSLOBm+648xsGoRdhR
         D8FIcp4iacK78GLrVSaOAeyLrqUnpYQdnke2UBs55310FjbTfxvhzBj0RbHMKF4PqlIx
         QK8utNP9KWUyyk+3+WFlgmH9rR9pEQkAUOqfPCqKD4HMhIT21fPVY+BC0Bhy0H5fn+6E
         gq9Yj7W8HIOW3BL7aIza0HgAfPf7FAD25GHKHb7KgPRRyLFz3gr16UvXch8myCtwbkWl
         vC7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Z/mBHvQzSlohdP6Aa3Rj5t3X9njBtjqppDVlQdCmxfc=;
        b=BZuYR4d6RLyi8ew4YzwvI44z+4zyoCDE1YvRBiXzNtTo4/VMxHs2GgtgeRsW8xPJ7w
         +VmWpYBQceu054XDtfXUra7Zy7nmOcA1a3xXGF7TClyrgHsm7hHMWMlFFldtm282uaDX
         dpQtO8ZFvKHe2RnshN+4YXSjtaG4GnePbJ6z+IMFY8D2J5ioXY6s1kTGO7XGvMSdIAsQ
         iH5lCEz7/mjVbMwP+RHXkkii/i7IVP7E+xeoR5rfInUwKF3lK/ZnlY4qrHPDR1qzuhZJ
         Seo9KYAAW3U3UJgN+UZsM4z86giq5n/vSUNdlbpt79i7PgEJsozPxY2FL/eDOKzgoGWz
         pitw==
X-Gm-Message-State: AOAM53171MRdjiLGl8bA6D/e0LO2nYMaO/ouz1PFqqZFRGbJxabb7Bzs
        43zgJPnbD7dGjEyWvliHkZm7NA==
X-Google-Smtp-Source: ABdhPJyvZ/k55zhU10mtIK0wONv/TKKWA0CmFCXHaji7F5TXyrUt7tKZI9zQvezv/kkOb7K8utYMPg==
X-Received: by 2002:a1c:f719:0:b0:381:ba:5247 with SMTP id v25-20020a1cf719000000b0038100ba5247mr10918177wmh.183.1648228615783;
        Fri, 25 Mar 2022 10:16:55 -0700 (PDT)
Received: from localhost.localdomain (2a02-8440-6240-cc41-3074-96af-9642-0003.rev.sfr.net. [2a02:8440:6240:cc41:3074:96af:9642:3])
        by smtp.gmail.com with ESMTPSA id p16-20020a5d6390000000b00203ffebddf3sm7547464wru.99.2022.03.25.10.16.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Mar 2022 10:16:55 -0700 (PDT)
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
        markyacoub@google.com, Markus Schneider-Pargmann <msp@baylibre.com>
Subject: [PATCH 06/22] video/hdmi: Add audio_infoframe packing for DP
Date:   Fri, 25 Mar 2022 18:14:55 +0100
Message-Id: <20220325171511.23493-7-granquet@baylibre.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220325171511.23493-1-granquet@baylibre.com>
References: <20220325171511.23493-1-granquet@baylibre.com>
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

Similar to HDMI, DP uses audio infoframes as well which are structured
very similar to the HDMI ones.

This patch adds a helper function to pack the HDMI audio infoframe for
DP, called hdmi_audio_infoframe_pack_for_dp().
hdmi_audio_infoframe_pack_only() is split into two parts. One of them
packs the payload only and can be used for HDMI and DP.

Signed-off-by: Markus Schneider-Pargmann <msp@baylibre.com>
Signed-off-by: Guillaume Ranquet <granquet@baylibre.com>
---
 drivers/video/hdmi.c           | 82 ++++++++++++++++++++++++++--------
 include/drm/dp/drm_dp_helper.h |  2 +
 include/linux/hdmi.h           |  7 ++-
 3 files changed, 71 insertions(+), 20 deletions(-)

diff --git a/drivers/video/hdmi.c b/drivers/video/hdmi.c
index 947be761dfa4..5f50237554ed 100644
--- a/drivers/video/hdmi.c
+++ b/drivers/video/hdmi.c
@@ -21,6 +21,7 @@
  * DEALINGS IN THE SOFTWARE.
  */
 
+#include <drm/dp/drm_dp_helper.h>
 #include <linux/bitops.h>
 #include <linux/bug.h>
 #include <linux/errno.h>
@@ -381,12 +382,34 @@ static int hdmi_audio_infoframe_check_only(const struct hdmi_audio_infoframe *fr
  *
  * Returns 0 on success or a negative error code on failure.
  */
-int hdmi_audio_infoframe_check(struct hdmi_audio_infoframe *frame)
+int hdmi_audio_infoframe_check(const struct hdmi_audio_infoframe *frame)
 {
 	return hdmi_audio_infoframe_check_only(frame);
 }
 EXPORT_SYMBOL(hdmi_audio_infoframe_check);
 
+static void
+hdmi_audio_infoframe_pack_payload(const struct hdmi_audio_infoframe *frame,
+				  u8 *buffer)
+{
+	u8 channels;
+
+	if (frame->channels >= 2)
+		channels = frame->channels - 1;
+	else
+		channels = 0;
+
+	buffer[0] = ((frame->coding_type & 0xf) << 4) | (channels & 0x7);
+	buffer[1] = ((frame->sample_frequency & 0x7) << 2) |
+		 (frame->sample_size & 0x3);
+	buffer[2] = frame->coding_type_ext & 0x1f;
+	buffer[3] = frame->channel_allocation;
+	buffer[4] = (frame->level_shift_value & 0xf) << 3;
+
+	if (frame->downmix_inhibit)
+		buffer[4] |= BIT(7);
+}
+
 /**
  * hdmi_audio_infoframe_pack_only() - write HDMI audio infoframe to binary buffer
  * @frame: HDMI audio infoframe
@@ -404,7 +427,6 @@ EXPORT_SYMBOL(hdmi_audio_infoframe_check);
 ssize_t hdmi_audio_infoframe_pack_only(const struct hdmi_audio_infoframe *frame,
 				       void *buffer, size_t size)
 {
-	unsigned char channels;
 	u8 *ptr = buffer;
 	size_t length;
 	int ret;
@@ -420,28 +442,13 @@ ssize_t hdmi_audio_infoframe_pack_only(const struct hdmi_audio_infoframe *frame,
 
 	memset(buffer, 0, size);
 
-	if (frame->channels >= 2)
-		channels = frame->channels - 1;
-	else
-		channels = 0;
-
 	ptr[0] = frame->type;
 	ptr[1] = frame->version;
 	ptr[2] = frame->length;
 	ptr[3] = 0; /* checksum */
 
-	/* start infoframe payload */
-	ptr += HDMI_INFOFRAME_HEADER_SIZE;
-
-	ptr[0] = ((frame->coding_type & 0xf) << 4) | (channels & 0x7);
-	ptr[1] = ((frame->sample_frequency & 0x7) << 2) |
-		 (frame->sample_size & 0x3);
-	ptr[2] = frame->coding_type_ext & 0x1f;
-	ptr[3] = frame->channel_allocation;
-	ptr[4] = (frame->level_shift_value & 0xf) << 3;
-
-	if (frame->downmix_inhibit)
-		ptr[4] |= BIT(7);
+	hdmi_audio_infoframe_pack_payload(frame,
+					  ptr + HDMI_INFOFRAME_HEADER_SIZE);
 
 	hdmi_infoframe_set_checksum(buffer, length);
 
@@ -479,6 +486,43 @@ ssize_t hdmi_audio_infoframe_pack(struct hdmi_audio_infoframe *frame,
 }
 EXPORT_SYMBOL(hdmi_audio_infoframe_pack);
 
+/**
+ * hdmi_audio_infoframe_pack_for_dp - Pack a HDMI Audio infoframe for DisplayPort
+ *
+ * @frame:      HDMI Audio infoframe
+ * @sdp:        secondary data packet for display port. This is filled with the
+ * appropriate: data
+ * @dp_version: Display Port version to be encoded in the header
+ *
+ * Packs a HDMI Audio Infoframe to be sent over Display Port. This function
+ * fills the secondary data packet to be used for Display Port.
+ *
+ * Return: Number of total written bytes or a negative errno on failure.
+ */
+ssize_t
+hdmi_audio_infoframe_pack_for_dp(const struct hdmi_audio_infoframe *frame,
+				 struct dp_sdp *sdp, u8 dp_version)
+{
+	int ret;
+
+	ret = hdmi_audio_infoframe_check(frame);
+	if (ret)
+		return ret;
+
+	memset(sdp->db, 0, sizeof(sdp->db));
+
+	/* Secondary-data packet header */
+	sdp->sdp_header.HB0 = 0;
+	sdp->sdp_header.HB1 = frame->type;
+	sdp->sdp_header.HB2 = DP_SDP_AUDIO_INFOFRAME_HB2;
+	sdp->sdp_header.HB3 = (dp_version & 0x3f) << 2;
+
+	hdmi_audio_infoframe_pack_payload(frame, sdp->db);
+
+	return frame->length + 4;
+}
+EXPORT_SYMBOL(hdmi_audio_infoframe_pack_for_dp);
+
 /**
  * hdmi_vendor_infoframe_init() - initialize an HDMI vendor infoframe
  * @frame: HDMI vendor infoframe
diff --git a/include/drm/dp/drm_dp_helper.h b/include/drm/dp/drm_dp_helper.h
index 51e02cf75277..d4adb479263e 100644
--- a/include/drm/dp/drm_dp_helper.h
+++ b/include/drm/dp/drm_dp_helper.h
@@ -1576,6 +1576,8 @@ int drm_dp_bw_code_to_link_rate(u8 link_bw);
 #define DP_SDP_VSC_EXT_CEA		0x21 /* DP 1.4 */
 /* 0x80+ CEA-861 infoframe types */
 
+#define DP_SDP_AUDIO_INFOFRAME_HB2	0x1b
+
 /**
  * struct dp_sdp_header - DP secondary data packet header
  * @HB0: Secondary Data Packet ID
diff --git a/include/linux/hdmi.h b/include/linux/hdmi.h
index c8ec982ff498..2f4dcc8d060e 100644
--- a/include/linux/hdmi.h
+++ b/include/linux/hdmi.h
@@ -336,7 +336,12 @@ ssize_t hdmi_audio_infoframe_pack(struct hdmi_audio_infoframe *frame,
 				  void *buffer, size_t size);
 ssize_t hdmi_audio_infoframe_pack_only(const struct hdmi_audio_infoframe *frame,
 				       void *buffer, size_t size);
-int hdmi_audio_infoframe_check(struct hdmi_audio_infoframe *frame);
+int hdmi_audio_infoframe_check(const struct hdmi_audio_infoframe *frame);
+
+struct dp_sdp;
+ssize_t
+hdmi_audio_infoframe_pack_for_dp(const struct hdmi_audio_infoframe *frame,
+				 struct dp_sdp *sdp, u8 dp_version);
 
 enum hdmi_3d_structure {
 	HDMI_3D_STRUCTURE_INVALID = -1,
-- 
2.34.1

