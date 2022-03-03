Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5970A4CC0B8
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Mar 2022 16:06:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234305AbiCCPHd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Mar 2022 10:07:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48436 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234273AbiCCPH3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Mar 2022 10:07:29 -0500
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com [IPv6:2a00:1450:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B49F71903F4
        for <linux-kernel@vger.kernel.org>; Thu,  3 Mar 2022 07:06:43 -0800 (PST)
Received: by mail-wr1-x42b.google.com with SMTP id u1so8270485wrg.11
        for <linux-kernel@vger.kernel.org>; Thu, 03 Mar 2022 07:06:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=rQ54PimOa9JA0PjxA9klTjXL5mIT6EoCvMFNlDkpoz0=;
        b=EiqkcueE7gsmrKt7OzyIXsnSf9qqkyvZ000cMatAKsHOlcK04TysYrt9+L1DDm2K9J
         uAQNKatyln8o345a/9vZuweQKIJNRuqH/oz4N53/kWYYHPusgRueY8/SoD71zdB5fTG3
         554Zkt9aPuAle+EdY64Bv4Z3GgzZtbJYgpv19c5pdGdRajdZeMBOwUGgAhYtQkqJMcsc
         0Cxrvias7rdf1c+l67rynX7TisjLnMerFwK9Z/0MlJ9H0pPdC7qkT/mWdxK8Jt61D7lR
         r7GcDzPSrPUZHyw6K+ga1CbI6+4GEpzNTObdAUXRK2zNgTz2Auum6rcsNPOXKFCCddoE
         D8VQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=rQ54PimOa9JA0PjxA9klTjXL5mIT6EoCvMFNlDkpoz0=;
        b=GzkxD8nFTc+XmEJEcUt45TG9n2ZzreLLd5Bc4DpusdDo7TirRt1gtdf+Cq2+veejgV
         ifEyMxW3mwj6y/ZYoGnDSCc4Yuo6b2Xh3XrYeM1tIUMre093Dulv7S8beDWVceRTmRwM
         MRJyXxdokVKoTKy5CnaLQXHqTXf5knf0ar8tj3zYBzCiQbKgfzmJZJ0OfiBAdT2IIu1w
         H3s2Q7bbfX1EnlicFkgUCKotd81//ykaDYLx9ZbyjUqfC2c5HB/gpx5326C9RdqF6VC2
         upfy6RDWFw3oucsURn8xBpBUpHnjucAfxNGj15lCr4b6pQM0TFN2c/a74Q21EQkmiac3
         6Ndw==
X-Gm-Message-State: AOAM531DNR/wweA/xnrUSzXS4DyiFZ+653LEvhypr5oUgHqsf0ILdas2
        RC32X9N2wkUe0jFvEPdJuvqPoQ==
X-Google-Smtp-Source: ABdhPJybx3yj8om8NebDZZaiHVbt388RYGiyXHwMMRg8WhzQotdbNH4Zh12X3DiwH1zR0c6TbZ42lw==
X-Received: by 2002:a5d:4a45:0:b0:1f0:5e70:1088 with SMTP id v5-20020a5d4a45000000b001f05e701088mr2024924wrs.258.1646320002269;
        Thu, 03 Mar 2022 07:06:42 -0800 (PST)
Received: from localhost.localdomain (hst-221-14.medicom.bg. [84.238.221.14])
        by smtp.gmail.com with ESMTPSA id o16-20020a05600c511000b0038141b4a4edsm10757072wms.38.2022.03.03.07.06.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Mar 2022 07:06:41 -0800 (PST)
From:   Stanimir Varbanov <stanimir.varbanov@linaro.org>
To:     linux-media@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-api@vger.kernel.org
Cc:     hverkuil-cisco@xs4all.nl, Nicolas Dufresne <nicolas@ndufresne.ca>,
        Stanimir Varbanov <stanimir.varbanov@linaro.org>
Subject: [PATCH v4 1/6] v4l: Add Qualcomm custom compressed pixel formats
Date:   Thu,  3 Mar 2022 17:06:31 +0200
Message-Id: <20220303150636.577063-2-stanimir.varbanov@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220303150636.577063-1-stanimir.varbanov@linaro.org>
References: <20220303150636.577063-1-stanimir.varbanov@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add custom Qualcomm raw compressed pixel formats. They are
used in Qualcomm SoCs to optimize the interconnect bandwidth.

Signed-off-by: Stanimir Varbanov <stanimir.varbanov@linaro.org>
Acked-by: Hans Verkuil <hverkuil-cisco@xs4all.nl>
---
 .../media/v4l/pixfmt-reserved.rst             | 19 +++++++++++++++++++
 drivers/media/v4l2-core/v4l2-ioctl.c          |  2 ++
 include/uapi/linux/videodev2.h                |  2 ++
 3 files changed, 23 insertions(+)

diff --git a/Documentation/userspace-api/media/v4l/pixfmt-reserved.rst b/Documentation/userspace-api/media/v4l/pixfmt-reserved.rst
index 2f2133b4cd9c..929bd0dc0ba3 100644
--- a/Documentation/userspace-api/media/v4l/pixfmt-reserved.rst
+++ b/Documentation/userspace-api/media/v4l/pixfmt-reserved.rst
@@ -245,6 +245,25 @@ please make a proposal on the linux-media mailing list.
       - Non-compressed, tiled two-planar format used by Mediatek MT8183.
 	This is an opaque intermediate format and the MDP3 hardware can be
 	used to convert it to other formats.
+    * .. _V4L2-PIX-FMT-QC08C:
+
+      - ``V4L2_PIX_FMT_QC08C``
+      - 'QC08C'
+      - Compressed Macro-tile 8-Bit YUV420 format used by Qualcomm platforms.
+        It is an opaque intermediate format. The used compression is lossless
+        and it is used by various multimedia hardware blocks like GPU, display
+        controllers, ISP and video accelerators.
+        It contains four planes for progressive video and eight planes for
+        interlaced video.
+    * .. _V4L2-PIX-FMT-QC10C:
+
+      - ``V4L2_PIX_FMT_QC10C``
+      - 'QC10C'
+      - Compressed Macro-tile 10-Bit YUV420 format used by Qualcomm platforms.
+        It is an opaque intermediate format. The used compression is lossless
+        and it is used by various multimedia hardware blocks like GPU, display
+        controllers, ISP and video accelerators.
+        It contains four planes for progressive video.
 
 .. raw:: latex
 
diff --git a/drivers/media/v4l2-core/v4l2-ioctl.c b/drivers/media/v4l2-core/v4l2-ioctl.c
index 642cb90f457c..b20ef7989ab8 100644
--- a/drivers/media/v4l2-core/v4l2-ioctl.c
+++ b/drivers/media/v4l2-core/v4l2-ioctl.c
@@ -1439,6 +1439,8 @@ static void v4l_fill_fmtdesc(struct v4l2_fmtdesc *fmt)
 		case V4L2_PIX_FMT_SE401:	descr = "GSPCA SE401"; break;
 		case V4L2_PIX_FMT_S5C_UYVY_JPG:	descr = "S5C73MX interleaved UYVY/JPEG"; break;
 		case V4L2_PIX_FMT_MT21C:	descr = "Mediatek Compressed Format"; break;
+		case V4L2_PIX_FMT_QC08C:	descr = "QCOM Compressed 8-bit Format"; break;
+		case V4L2_PIX_FMT_QC10C:	descr = "QCOM Compressed 10-bit Format"; break;
 		default:
 			if (fmt->description[0])
 				return;
diff --git a/include/uapi/linux/videodev2.h b/include/uapi/linux/videodev2.h
index df8b9c486ba1..e710903185bd 100644
--- a/include/uapi/linux/videodev2.h
+++ b/include/uapi/linux/videodev2.h
@@ -744,6 +744,8 @@ struct v4l2_pix_format {
 #define V4L2_PIX_FMT_INZI     v4l2_fourcc('I', 'N', 'Z', 'I') /* Intel Planar Greyscale 10-bit and Depth 16-bit */
 #define V4L2_PIX_FMT_CNF4     v4l2_fourcc('C', 'N', 'F', '4') /* Intel 4-bit packed depth confidence information */
 #define V4L2_PIX_FMT_HI240    v4l2_fourcc('H', 'I', '2', '4') /* BTTV 8-bit dithered RGB */
+#define V4L2_PIX_FMT_QC08C    v4l2_fourcc('Q', '0', '8', 'C') /* Qualcomm 8-bit compressed */
+#define V4L2_PIX_FMT_QC10C    v4l2_fourcc('Q', '1', '0', 'C') /* Qualcomm 10-bit compressed */
 
 /* 10bit raw bayer packed, 32 bytes for every 25 pixels, last LSB 6 bits unused */
 #define V4L2_PIX_FMT_IPU3_SBGGR10	v4l2_fourcc('i', 'p', '3', 'b') /* IPU3 packed 10-bit BGGR bayer */
-- 
2.25.1

