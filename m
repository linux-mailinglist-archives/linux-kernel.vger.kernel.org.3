Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5CE14508B92
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Apr 2022 17:07:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1380018AbiDTPKK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Apr 2022 11:10:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41222 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1379992AbiDTPKI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Apr 2022 11:10:08 -0400
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com [IPv6:2a00:1450:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B29E93B552
        for <linux-kernel@vger.kernel.org>; Wed, 20 Apr 2022 08:07:20 -0700 (PDT)
Received: by mail-ed1-x536.google.com with SMTP id v15so2654117edb.12
        for <linux-kernel@vger.kernel.org>; Wed, 20 Apr 2022 08:07:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=spUtPYnusUNlmk64AoaMk2dzOFC+AtlUcojqMYefluc=;
        b=F9dM5DXeSAhMdmEN3P/6+0vGj0AjZStpdL3ApCb66ojVwvXxz7TTv8Zqxgmek1hJcZ
         3BvfVCNoRaYa48Sd5pS8f4PG0rWgCFB+v2q2RsBjL35XHq0CXU/kC+6XEfv3tsYkJ0jT
         t2sDNuyzAbgFg9bcouCxJKpSqbd1+coIgdwoTcC4qD4EfA0SMS/n9QuKvD3LrW7JoUvI
         CPHunAJP9MpxqD/Otib8DjulO62ygnGdyyZ0g5NUbJOL6XT2O0ma5lC9XKopvS91ifog
         g9p/POc14thdgA2ptvk+2gpc2zym98/40ac+C/nPzvQy5leuWA6xlqQ8cTbAxc2tYFnU
         c5OA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=spUtPYnusUNlmk64AoaMk2dzOFC+AtlUcojqMYefluc=;
        b=df5sJOEsXb9mgakkYAyvfJe5c1dqA8C4Yhml7G4cdUwTzBmNoBKvaxiiueCJ3KffN8
         MFjb+c2KOKEoWZ1ZSO+J35UaxTTOUfHUs5JUWRnoI3TTMp+PhUgC14reHquy1HZP+4F+
         AC3l1LveN/EI8xvCfdMO6aswGHw7+1BWLPkeHkjOIqa+M4ZyxlDhYfQtR+8botPRGROC
         gUrwPWkMxpzTLInrNmP/0kaukPzuDHWO1gvC9Xlg+XUrmRXNL7XA/owW/litv3AOaxwd
         71NPI3nhxJO/3d9JbBCyrTMjtV78gvUlSfayJJGHT924DCsmEh/AxCH4xwvL6cgYmkn3
         We/A==
X-Gm-Message-State: AOAM530VO+AFM0tqT05lUForEN+FN2MzYce1MPsZ8PKh8QfRPfVI4HMm
        Vg0VCi5BmO0m/8b9XbDegCy/IaAwLBrMdiM0
X-Google-Smtp-Source: ABdhPJwh/d8VyriyjYILlz8hAh5z/6/fOEYKoh9GRoABlUNOnMtBtOLy95IGnpWQavQAw0CHuzqdOA==
X-Received: by 2002:a05:6402:190a:b0:424:890:e4e1 with SMTP id e10-20020a056402190a00b004240890e4e1mr6799548edz.169.1650467239217;
        Wed, 20 Apr 2022 08:07:19 -0700 (PDT)
Received: from localhost.localdomain (hst-208-209.medicom.bg. [84.238.208.209])
        by smtp.gmail.com with ESMTPSA id zk19-20020a17090733d300b006f00e918483sm415262ejb.84.2022.04.20.08.07.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Apr 2022 08:07:18 -0700 (PDT)
From:   Stanimir Varbanov <stanimir.varbanov@linaro.org>
To:     linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        hverkuil-cisco@xs4all.nl
Cc:     linux-arm-msm@vger.kernel.org, ezequiel@collabora.com,
        stanimir.varbanov@linaro.org, quic_vgarodia@quicinc.com,
        quic_majja@quicinc.com, quic_jdas@quicinc.com,
        Dikshita Agarwal <quic_dikshita@quicinc.com>,
        Nicolas Dufresne <nicolas.dufresne@collabora.com>
Subject: [PATCH v6 1/2] media: v4l2-ctrls: Add intra-refresh type control
Date:   Wed, 20 Apr 2022 18:07:03 +0300
Message-Id: <20220420150704.144000-2-stanimir.varbanov@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220420150704.144000-1-stanimir.varbanov@linaro.org>
References: <20220420150704.144000-1-stanimir.varbanov@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Dikshita Agarwal <quic_dikshita@quicinc.com>

Add a control to set intra-refresh type.

Signed-off-by: Dikshita Agarwal <quic_dikshita@quicinc.com>
Reviewed-by: Nicolas Dufresne <nicolas.dufresne@collabora.com>
Acked-by: Hans Verkuil <hverkuil-cisco@xs4all.nl>
Signed-off-by: Stanimir Varbanov <stanimir.varbanov@linaro.org>
---
 .../media/v4l/ext-ctrls-codec.rst             | 22 +++++++++++++++++++
 drivers/media/v4l2-core/v4l2-ctrls-defs.c     |  9 ++++++++
 include/uapi/linux/v4l2-controls.h            |  5 +++++
 3 files changed, 36 insertions(+)

diff --git a/Documentation/userspace-api/media/v4l/ext-ctrls-codec.rst b/Documentation/userspace-api/media/v4l/ext-ctrls-codec.rst
index 4cd7c541fc30..c24977fa7329 100644
--- a/Documentation/userspace-api/media/v4l/ext-ctrls-codec.rst
+++ b/Documentation/userspace-api/media/v4l/ext-ctrls-codec.rst
@@ -1180,6 +1180,28 @@ enum v4l2_mpeg_video_h264_entropy_mode -
     is set to non zero value.
     Applicable to H264, H263 and MPEG4 encoder.
 
+``V4L2_CID_MPEG_VIDEO_INTRA_REFRESH_PERIOD_TYPE (enum)``
+
+enum v4l2_mpeg_video_intra_refresh_period_type -
+    Sets the type of intra refresh. The period to refresh
+    the whole frame is specified by V4L2_CID_MPEG_VIDEO_INTRA_REFRESH_PERIOD.
+    Note that if this control is not present, then it is undefined what
+    refresh type is used and it is up to the driver to decide.
+    Applicable to H264 and HEVC encoders. Possible values are:
+
+.. tabularcolumns:: |p{9.6cm}|p{7.9cm}|
+
+.. flat-table::
+    :header-rows:  0
+    :stub-columns: 0
+
+    * - ``V4L2_MPEG_VIDEO_INTRA_REFRESH_PERIOD_TYPE_RANDOM``
+      - The whole frame is completely refreshed randomly
+      after the specified period.
+    * - ``V4L2_MPEG_VIDEO_INTRA_REFRESH_PERIOD_TYPE_CYCLIC``
+      - The whole frame MBs are completely refreshed in cyclic order
+      after the specified period.
+
 ``V4L2_CID_MPEG_VIDEO_INTRA_REFRESH_PERIOD (integer)``
     Intra macroblock refresh period. This sets the period to refresh
     the whole frame. In other words, this defines the number of frames
diff --git a/drivers/media/v4l2-core/v4l2-ctrls-defs.c b/drivers/media/v4l2-core/v4l2-ctrls-defs.c
index 54ca4e6b820b..16f42d2fd359 100644
--- a/drivers/media/v4l2-core/v4l2-ctrls-defs.c
+++ b/drivers/media/v4l2-core/v4l2-ctrls-defs.c
@@ -572,6 +572,11 @@ const char * const *v4l2_ctrl_get_menu(u32 id)
 		"VBV/CPB Limit",
 		NULL,
 	};
+	static const char * const intra_refresh_period_type[] = {
+		"Random",
+		"Cyclic",
+		NULL,
+	};
 
 	switch (id) {
 	case V4L2_CID_MPEG_AUDIO_SAMPLING_FREQ:
@@ -705,6 +710,8 @@ const char * const *v4l2_ctrl_get_menu(u32 id)
 		return hevc_start_code;
 	case V4L2_CID_CAMERA_ORIENTATION:
 		return camera_orientation;
+	case V4L2_CID_MPEG_VIDEO_INTRA_REFRESH_PERIOD_TYPE:
+		return intra_refresh_period_type;
 	default:
 		return NULL;
 	}
@@ -834,6 +841,7 @@ const char *v4l2_ctrl_get_name(u32 id)
 	case V4L2_CID_MPEG_VIDEO_DECODER_SLICE_INTERFACE:	return "Decoder Slice Interface";
 	case V4L2_CID_MPEG_VIDEO_DECODER_MPEG4_DEBLOCK_FILTER:	return "MPEG4 Loop Filter Enable";
 	case V4L2_CID_MPEG_VIDEO_CYCLIC_INTRA_REFRESH_MB:	return "Number of Intra Refresh MBs";
+	case V4L2_CID_MPEG_VIDEO_INTRA_REFRESH_PERIOD_TYPE:	return "Intra Refresh Period Type";
 	case V4L2_CID_MPEG_VIDEO_INTRA_REFRESH_PERIOD:		return "Intra Refresh Period";
 	case V4L2_CID_MPEG_VIDEO_FRAME_RC_ENABLE:		return "Frame Level Rate Control Enable";
 	case V4L2_CID_MPEG_VIDEO_MB_RC_ENABLE:			return "H264 MB Level Rate Control";
@@ -1360,6 +1368,7 @@ void v4l2_ctrl_fill(u32 id, const char **name, enum v4l2_ctrl_type *type,
 	case V4L2_CID_STATELESS_H264_DECODE_MODE:
 	case V4L2_CID_STATELESS_H264_START_CODE:
 	case V4L2_CID_CAMERA_ORIENTATION:
+	case V4L2_CID_MPEG_VIDEO_INTRA_REFRESH_PERIOD_TYPE:
 		*type = V4L2_CTRL_TYPE_MENU;
 		break;
 	case V4L2_CID_LINK_FREQ:
diff --git a/include/uapi/linux/v4l2-controls.h b/include/uapi/linux/v4l2-controls.h
index bb40129446d4..dfff69ed88f7 100644
--- a/include/uapi/linux/v4l2-controls.h
+++ b/include/uapi/linux/v4l2-controls.h
@@ -449,6 +449,11 @@ enum v4l2_mpeg_video_multi_slice_mode {
 #define V4L2_CID_MPEG_VIDEO_USE_LTR_FRAMES		(V4L2_CID_CODEC_BASE+234)
 #define V4L2_CID_MPEG_VIDEO_DEC_CONCEAL_COLOR		(V4L2_CID_CODEC_BASE+235)
 #define V4L2_CID_MPEG_VIDEO_INTRA_REFRESH_PERIOD	(V4L2_CID_CODEC_BASE+236)
+#define V4L2_CID_MPEG_VIDEO_INTRA_REFRESH_PERIOD_TYPE	(V4L2_CID_CODEC_BASE+237)
+enum v4l2_mpeg_video_intra_refresh_period_type {
+	V4L2_CID_MPEG_VIDEO_INTRA_REFRESH_PERIOD_TYPE_RANDOM	= 0,
+	V4L2_CID_MPEG_VIDEO_INTRA_REFRESH_PERIOD_TYPE_CYCLIC	= 1,
+};
 
 /* CIDs for the MPEG-2 Part 2 (H.262) codec */
 #define V4L2_CID_MPEG_VIDEO_MPEG2_LEVEL			(V4L2_CID_CODEC_BASE+270)
-- 
2.25.1

