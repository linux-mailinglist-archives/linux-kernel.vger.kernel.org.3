Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 147CE4D5442
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Mar 2022 23:11:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344305AbiCJWLC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Mar 2022 17:11:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34372 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344245AbiCJWKt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Mar 2022 17:10:49 -0500
Received: from mail-io1-xd2a.google.com (mail-io1-xd2a.google.com [IPv6:2607:f8b0:4864:20::d2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C141148653;
        Thu, 10 Mar 2022 14:09:46 -0800 (PST)
Received: by mail-io1-xd2a.google.com with SMTP id z7so8187136iom.1;
        Thu, 10 Mar 2022 14:09:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=1v/g+XUsQiuGcvCnhpB+S1s02TLdasx4UAVfvGdDJK4=;
        b=kIP/iT9my8xOYPBX0FN+vUWq07UAfSc/y8T0J8Vl++12og43rxuFfmCdCdoRX03SR0
         +7Xa6+qUsTq6hyYFzpB6znt90NeXBbvowKl2/qAI7jkO+dDF8F2B9ZBX57ww9vHRqYao
         rGZ6a+MmnTRdUAyFP/xpdKp0MQGwifAbf3D7/rJ5n6WmKTiYP03Y70DUUpuG/x84F8ib
         Lh5G02rCs45U8UM5xzarAdmBx0ofS6SFK90g1tVYxasa0AmtCSwdqZG/s/Psg70+8RsY
         OHVHfNZO1LZl9x14pn3sAvr+83BniW1WRIDfaboA4JMsrAyG8v/XQS9L+jpS5AfX9Zz+
         lMsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=1v/g+XUsQiuGcvCnhpB+S1s02TLdasx4UAVfvGdDJK4=;
        b=mS/uUzEmNYknIjPpbN1tIG3GoRGS2CUEwfHp+ch4ua1xPSkQochhiZ9BMvIbsCFic4
         SJSYb+YpR37M28cPG77mUNlHjUF8OCUvWfK0OMeYY3rYDvofgNWirhunqDboxQoDusy6
         E2lVV9/5HDKvI/Wx2YPwgOw5D3eDQguOnewDI811jVIa304kiUMbEFO1VweLLSSVlNPO
         qw+4NPX4x9Ab7ZIiy5diCGHzI5Rrvhd3/I1S0djADgprLG2R07O6d6UewRzupyurssyi
         o4HKeVahFCKnoBWF8yV5JigyvWSv38M4yLuq4oKaGIYUXroIbuYTaVyfCQ7EjaPQqPJR
         ozWw==
X-Gm-Message-State: AOAM532pIkChwo+MYv3HQGWfEV+diTzcmNdcUi2x1X0h3+EqfImcIl3T
        uQTumVzE7mIGlfrgkr2UCs3fQKTDOfs=
X-Google-Smtp-Source: ABdhPJz4mn0TL2OHHFO11/EXnysHbSouq4ZhdIh0eLQKTis78PaM2zQFz0kkvqv4LZ85gFXLPPUK8A==
X-Received: by 2002:a02:7013:0:b0:317:b68a:e4d2 with SMTP id f19-20020a027013000000b00317b68ae4d2mr5844220jac.8.1646950185817;
        Thu, 10 Mar 2022 14:09:45 -0800 (PST)
Received: from james-x399.localdomain (97-118-243-247.hlrn.qwest.net. [97.118.243.247])
        by smtp.gmail.com with ESMTPSA id x15-20020a056e02194f00b002c609855ea5sm3575209ilu.34.2022.03.10.14.09.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Mar 2022 14:09:45 -0800 (PST)
From:   James Hilliard <james.hilliard1@gmail.com>
To:     linux-media@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Pawel Osciak <posciak@chromium.org>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        James Hilliard <james.hilliard1@gmail.com>
Subject: [PATCH 1/1] uvcvideo: Add support for UVC1.5 P&C control.
Date:   Thu, 10 Mar 2022 15:09:40 -0700
Message-Id: <20220310220940.2994075-1-james.hilliard1@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Pawel Osciak <posciak@chromium.org>

Add support for UVC 1.5 Probe & Commit control.

Signed-off-by: Pawel Osciak <posciak@chromium.org>
Signed-off-by: James Hilliard <james.hilliard1@gmail.com>
---
 drivers/media/usb/uvc/uvc_video.c | 34 +++++++++++++++++++++++++++++++
 include/uapi/linux/usb/video.h    |  7 +++++++
 2 files changed, 41 insertions(+)

diff --git a/drivers/media/usb/uvc/uvc_video.c b/drivers/media/usb/uvc/uvc_video.c
index 1b4cc934109e..46b8396e0d3b 100644
--- a/drivers/media/usb/uvc/uvc_video.c
+++ b/drivers/media/usb/uvc/uvc_video.c
@@ -253,6 +253,7 @@ static int uvc_get_video_ctrl(struct uvc_streaming *stream,
 	u16 size = uvc_video_ctrl_size(stream);
 	u8 *data;
 	int ret;
+	unsigned int i;
 
 	if ((stream->dev->quirks & UVC_QUIRK_PROBE_DEF) &&
 			query == UVC_GET_DEF)
@@ -322,6 +323,26 @@ static int uvc_get_video_ctrl(struct uvc_streaming *stream,
 		ctrl->bMaxVersion = 0;
 	}
 
+	if (size >= 48) {
+		ctrl->bUsage = data[34];
+		ctrl->bBitDepthLuma = data[35];
+		ctrl->bmSetting = data[36];
+		ctrl->bMaxNumberOfRefFramesPlus1 = data[37];
+		ctrl->bmRateControlModes = get_unaligned_le16(&data[38]);
+		for (i = 0; i < ARRAY_SIZE(ctrl->bmLayoutPerStream); ++i) {
+			ctrl->bmLayoutPerStream[i] =
+				get_unaligned_le16(&data[40 + i * 2]);
+		}
+	} else {
+		ctrl->bUsage = 0;
+		ctrl->bBitDepthLuma = 0;
+		ctrl->bmSetting = 0;
+		ctrl->bMaxNumberOfRefFramesPlus1 = 0;
+		ctrl->bmRateControlModes = 0;
+		for (i = 0; i < ARRAY_SIZE(ctrl->bmLayoutPerStream); ++i)
+			ctrl->bmLayoutPerStream[i] = 0;
+	}
+
 	/* Some broken devices return null or wrong dwMaxVideoFrameSize and
 	 * dwMaxPayloadTransferSize fields. Try to get the value from the
 	 * format and frame descriptors.
@@ -340,6 +361,7 @@ static int uvc_set_video_ctrl(struct uvc_streaming *stream,
 	u16 size = uvc_video_ctrl_size(stream);
 	u8 *data;
 	int ret;
+	unsigned int i;
 
 	data = kzalloc(size, GFP_KERNEL);
 	if (data == NULL)
@@ -365,6 +387,18 @@ static int uvc_set_video_ctrl(struct uvc_streaming *stream,
 		data[33] = ctrl->bMaxVersion;
 	}
 
+	if (size >= 48) {
+		data[34] = ctrl->bUsage;
+		data[35] = ctrl->bBitDepthLuma;
+		data[36] = ctrl->bmSetting;
+		data[37] = ctrl->bMaxNumberOfRefFramesPlus1;
+		*(__le16 *)&data[38] = cpu_to_le16(ctrl->bmRateControlModes);
+		for (i = 0; i < ARRAY_SIZE(ctrl->bmLayoutPerStream); ++i) {
+			*(__le16 *)&data[40 + i * 2] =
+				cpu_to_le16(ctrl->bmLayoutPerStream[i]);
+		}
+	}
+
 	ret = __uvc_query_ctrl(stream->dev, UVC_SET_CUR, 0, stream->intfnum,
 		probe ? UVC_VS_PROBE_CONTROL : UVC_VS_COMMIT_CONTROL, data,
 		size, uvc_timeout_param);
diff --git a/include/uapi/linux/usb/video.h b/include/uapi/linux/usb/video.h
index bfdae12cdacf..a0de60efd73c 100644
--- a/include/uapi/linux/usb/video.h
+++ b/include/uapi/linux/usb/video.h
@@ -435,6 +435,7 @@ struct uvc_color_matching_descriptor {
 #define UVC_DT_COLOR_MATCHING_SIZE			6
 
 /* 4.3.1.1. Video Probe and Commit Controls */
+#define UVC_NUM_SIMULCAST_STREAMS			4
 struct uvc_streaming_control {
 	__u16 bmHint;
 	__u8  bFormatIndex;
@@ -452,6 +453,12 @@ struct uvc_streaming_control {
 	__u8  bPreferedVersion;
 	__u8  bMinVersion;
 	__u8  bMaxVersion;
+	__u8  bUsage;
+	__u8  bBitDepthLuma;
+	__u8  bmSetting;
+	__u8  bMaxNumberOfRefFramesPlus1;
+	__u16 bmRateControlModes;
+	__u16 bmLayoutPerStream[UVC_NUM_SIMULCAST_STREAMS];
 } __attribute__((__packed__));
 
 /* Uncompressed Payload - 3.1.1. Uncompressed Video Format Descriptor */
-- 
2.25.1

