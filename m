Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 15AB84FC28B
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Apr 2022 18:37:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348667AbiDKQji (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Apr 2022 12:39:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55930 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348653AbiDKQje (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Apr 2022 12:39:34 -0400
Received: from alexa-out.qualcomm.com (alexa-out.qualcomm.com [129.46.98.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B0C032068;
        Mon, 11 Apr 2022 09:37:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1649695040; x=1681231040;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references;
  bh=rwjRuGuepy//YjLHoAmcCpL2t0bvxioBp/CwXdYeLTU=;
  b=Szbp7bd2pZQfGibAoDGM3alq2dEEnBaqi/dk2qytzeOOieWk2yjob28q
   wohJh971rFI9eNeg0jmPdXtTYemgJjWJWjPlnbndavYg1Xsr87C+PWfzu
   CTcGSu4yzKwK9ZeNQ1/PIPVx2TzdSwUX4bqU3c2HQ5yMA5rP40EdJfxBA
   g=;
Received: from ironmsg09-lv.qualcomm.com ([10.47.202.153])
  by alexa-out.qualcomm.com with ESMTP; 11 Apr 2022 09:37:20 -0700
X-QCInternal: smtphost
Received: from ironmsg02-blr.qualcomm.com ([10.86.208.131])
  by ironmsg09-lv.qualcomm.com with ESMTP/TLS/AES256-SHA; 11 Apr 2022 09:37:19 -0700
X-QCInternal: smtphost
Received: from vpolimer-linux.qualcomm.com ([10.204.67.235])
  by ironmsg02-blr.qualcomm.com with ESMTP; 11 Apr 2022 22:07:04 +0530
Received: by vpolimer-linux.qualcomm.com (Postfix, from userid 463814)
        id 7B1E042C5; Mon, 11 Apr 2022 22:07:03 +0530 (IST)
From:   Vinod Polimera <quic_vpolimer@quicinc.com>
To:     dri-devel@lists.freedesktop.org, linux-arm-msm@vger.kernel.org,
        freedreno@lists.freedesktop.org, devicetree@vger.kernel.org
Cc:     Vinod Polimera <quic_vpolimer@quicinc.com>,
        linux-kernel@vger.kernel.org, robdclark@gmail.com,
        dmitry.baryshkov@linaro.org, dianders@chromium.org,
        quic_kalyant@quicinc.com
Subject: [PATCH v8 1/2] drm/msm/disp/dpu1: add inline function to validate format support
Date:   Mon, 11 Apr 2022 22:07:00 +0530
Message-Id: <1649695021-19132-2-git-send-email-quic_vpolimer@quicinc.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1649695021-19132-1-git-send-email-quic_vpolimer@quicinc.com>
References: <1649695021-19132-1-git-send-email-quic_vpolimer@quicinc.com>
X-Spam-Status: No, score=-2.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Check if the dpu format is supported or not using dpu_find_format.

Co-developed-by: Kalyan Thota <quic_kalyant@quicinc.com>
Signed-off-by: Kalyan Thota <quic_kalyant@quicinc.com>
Signed-off-by: Vinod Polimera <quic_vpolimer@quicinc.com>
---
 drivers/gpu/drm/msm/disp/dpu1/dpu_formats.h | 22 ++++++++++++++++++++++
 drivers/gpu/drm/msm/disp/dpu1/dpu_plane.c   | 10 +++-------
 2 files changed, 25 insertions(+), 7 deletions(-)

diff --git a/drivers/gpu/drm/msm/disp/dpu1/dpu_formats.h b/drivers/gpu/drm/msm/disp/dpu1/dpu_formats.h
index 418f5ae..84b8b32 100644
--- a/drivers/gpu/drm/msm/disp/dpu1/dpu_formats.h
+++ b/drivers/gpu/drm/msm/disp/dpu1/dpu_formats.h
@@ -21,6 +21,28 @@ const struct dpu_format *dpu_get_dpu_format_ext(
 #define dpu_get_dpu_format(f) dpu_get_dpu_format_ext(f, 0)
 
 /**
+ * dpu_find_format - validate if the pixel format is supported
+ * @format:		dpu format
+ * @supported_formats:	supported formats by dpu HW
+ * @num_formatss:	total number of formats
+ *
+ * Return: false if not valid format, true on success
+ */
+static inline bool dpu_find_format(u32 format, const u32 *supported_formats,
+					size_t num_formats)
+{
+	int i;
+
+	for (i = 0; i < num_formats; i++) {
+		/* check for valid formats supported */
+		if (format == supported_formats[i])
+			return true;
+	}
+
+	return false;
+}
+
+/**
  * dpu_get_msm_format - get an dpu_format by its msm_format base
  *                     callback function registers with the msm_kms layer
  * @kms:             kms driver
diff --git a/drivers/gpu/drm/msm/disp/dpu1/dpu_plane.c b/drivers/gpu/drm/msm/disp/dpu1/dpu_plane.c
index 6565682..3216cda 100644
--- a/drivers/gpu/drm/msm/disp/dpu1/dpu_plane.c
+++ b/drivers/gpu/drm/msm/disp/dpu1/dpu_plane.c
@@ -1411,13 +1411,9 @@ static bool dpu_plane_format_mod_supported(struct drm_plane *plane,
 	if (modifier == DRM_FORMAT_MOD_LINEAR)
 		return true;
 
-	if (modifier == DRM_FORMAT_MOD_QCOM_COMPRESSED) {
-		int i;
-		for (i = 0; i < ARRAY_SIZE(qcom_compressed_supported_formats); i++) {
-			if (format == qcom_compressed_supported_formats[i])
-				return true;
-		}
-	}
+	if (modifier == DRM_FORMAT_MOD_QCOM_COMPRESSED)
+		return dpu_find_format(format, qcom_compressed_supported_formats,
+				ARRAY_SIZE(qcom_compressed_supported_formats));
 
 	return false;
 }
-- 
2.7.4

