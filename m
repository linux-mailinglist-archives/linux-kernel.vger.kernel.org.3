Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0AF284E74D6
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Mar 2022 15:09:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1359309AbiCYOKx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Mar 2022 10:10:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60788 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1357880AbiCYOKq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Mar 2022 10:10:46 -0400
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com [IPv6:2a00:1450:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 76930D8F69
        for <linux-kernel@vger.kernel.org>; Fri, 25 Mar 2022 07:09:11 -0700 (PDT)
Received: by mail-ej1-x635.google.com with SMTP id o10so15654118ejd.1
        for <linux-kernel@vger.kernel.org>; Fri, 25 Mar 2022 07:09:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=7Y8Ke4EKJ+n0sWG8HfMTEQMTwBxHtm/aFE+FUw2Eq8I=;
        b=QTkG7yzE0VA3tbHnhVo79rmLtyvMtgtPYvmp6iOr44D+sx3bfReMFLwxq2nCuKe96j
         8mkk6oHj/B/yiFiuZ4E1cAyeeKJdY9uPKzpddu+F1rUF9EIOq7re8ZayVHSH/XgVHsM3
         0P1bykV/XRv6wrvpXrOEBr1jKLBJnKVzzy1jM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=7Y8Ke4EKJ+n0sWG8HfMTEQMTwBxHtm/aFE+FUw2Eq8I=;
        b=t82QZXh0ZEbvsTbhla/ymViP8QXXvtqf9q3NcuZqxznWvSWJQQaJ1VHvKljXRqy3EN
         8Ka0MD1C3KOMzfcrn2R4PDnKVtaoZr3Gfm6BwQsUEY+nV4A9QwHvyCDrKQDDQAU5KnhS
         eooizJgaWPWiZ5Ag6gQH1viJvebIEFL7rCZdWwtsueJXOGu7IkUAuY2X5Go0AOBbPQ9a
         CnhFFuJAiDXhNyCnbi54wrMK+VPfOaw3yMXJsXSqTA+X4HeiV8Lupo+UMglbE32iqFiy
         lxbIjdPF3AG5KhV+4c9FlWONRLDs2+y8i5OpTNLGxyaM3rraSEZzirua7smqQqmTpVEY
         anlA==
X-Gm-Message-State: AOAM531eKWjjK9gtxOJL9TaO/NmLHsEx8aWcWQ4YOean2ra24zNeuwJe
        MiFuRgWRlm+kmqeZgCOHf+E7SA==
X-Google-Smtp-Source: ABdhPJw1ItfY2GTfb7uKZb4wsLq5O6JtCDzlBoW9axGKsiN8kntiG06xG5p/w1ZtWRXklpS5iUODlw==
X-Received: by 2002:a17:906:c307:b0:6df:c7d0:90e8 with SMTP id s7-20020a170906c30700b006dfc7d090e8mr11541350ejz.421.1648217349950;
        Fri, 25 Mar 2022 07:09:09 -0700 (PDT)
Received: from alco.corp.google.com ([2620:0:1059:10:c825:3420:d3ca:fdf1])
        by smtp.gmail.com with ESMTPSA id u19-20020a17090617d300b006cea86ca384sm2328667eje.40.2022.03.25.07.09.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Mar 2022 07:09:09 -0700 (PDT)
From:   Ricardo Ribalda <ribalda@chromium.org>
To:     Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        senozhatsky@chromium.org, tfiga@chromium.org
Cc:     Ricardo Ribalda <ribalda@chromium.org>
Subject: [PATCH v3] media: uvcvideo: Fix handling on Bitmask controls
Date:   Fri, 25 Mar 2022 15:09:06 +0100
Message-Id: <20220325140906.482970-1-ribalda@chromium.org>
X-Mailer: git-send-email 2.35.1.1021.g381101b075-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Minimum and step values for V4L2_CTRL_TYPE_BITMASK controls should be 0.
There is no need to query the camera firmware about this and maybe get
invalid results.

Also value should be masked to the max value advertised by the
hardware.

Finally, handle uvc 1.5 mask controls that use MAX instead of RES to
describe the valid bits.

Fixes v4l2-compliane:
Control ioctls (Input 0):
                fail: v4l2-test-controls.cpp(97): minimum must be 0 for a bitmask control
	test VIDIOC_QUERY_EXT_CTRL/QUERYMENU: FAIL

Signed-off-by: Ricardo Ribalda <ribalda@chromium.org>
---
v3: Changes requested by Laurent

Support controls that use GET_RES for describing the valid bits.

 drivers/media/usb/uvc/uvc_ctrl.c | 53 ++++++++++++++++++++++++--------
 1 file changed, 41 insertions(+), 12 deletions(-)

diff --git a/drivers/media/usb/uvc/uvc_ctrl.c b/drivers/media/usb/uvc/uvc_ctrl.c
index b4f6edf968bc..d474fe07de84 100644
--- a/drivers/media/usb/uvc/uvc_ctrl.c
+++ b/drivers/media/usb/uvc/uvc_ctrl.c
@@ -1078,6 +1078,25 @@ static const char *uvc_map_get_name(const struct uvc_control_mapping *map)
 	return "Unknown Control";
 }
 
+static u32 uvc_get_ctrl_bitmap(struct uvc_control *ctrl,
+			       struct uvc_control_mapping *mapping)
+{
+	/*
+	 * Some controls, like CT_AE_MODE_CONTROL use GET_RES to
+	 * represent the number of bits supported, those controls
+	 * do not list GET_MAX as supported.
+	 */
+	if (ctrl->info.flags & UVC_CTRL_FLAG_GET_MAX)
+		return mapping->get(mapping, UVC_GET_MAX,
+				    uvc_ctrl_data(ctrl, UVC_CTRL_DATA_MAX));
+
+	if (ctrl->info.flags & UVC_CTRL_FLAG_GET_RES)
+		return mapping->get(mapping, UVC_GET_RES,
+				    uvc_ctrl_data(ctrl, UVC_CTRL_DATA_RES));
+
+	return ~0;
+}
+
 static int __uvc_query_v4l2_ctrl(struct uvc_video_chain *chain,
 	struct uvc_control *ctrl,
 	struct uvc_control_mapping *mapping,
@@ -1152,6 +1171,12 @@ static int __uvc_query_v4l2_ctrl(struct uvc_video_chain *chain,
 		v4l2_ctrl->step = 0;
 		return 0;
 
+	case V4L2_CTRL_TYPE_BITMASK:
+		v4l2_ctrl->minimum = 0;
+		v4l2_ctrl->maximum = uvc_get_ctrl_bitmap(ctrl, mapping);
+		v4l2_ctrl->step = 0;
+		return 0;
+
 	default:
 		break;
 	}
@@ -1253,19 +1278,14 @@ int uvc_query_v4l2_menu(struct uvc_video_chain *chain,
 
 	menu_info = &mapping->menu_info[query_menu->index];
 
-	if (mapping->data_type == UVC_CTRL_DATA_TYPE_BITMASK &&
-	    (ctrl->info.flags & UVC_CTRL_FLAG_GET_RES)) {
-		s32 bitmap;
-
+	if (mapping->data_type == UVC_CTRL_DATA_TYPE_BITMASK) {
 		if (!ctrl->cached) {
 			ret = uvc_ctrl_populate_cache(chain, ctrl);
 			if (ret < 0)
 				goto done;
 		}
 
-		bitmap = mapping->get(mapping, UVC_GET_RES,
-				      uvc_ctrl_data(ctrl, UVC_CTRL_DATA_RES));
-		if (!(bitmap & menu_info->value)) {
+		if (!(uvc_get_ctrl_bitmap(ctrl, mapping) & menu_info->value)) {
 			ret = -EINVAL;
 			goto done;
 		}
@@ -1745,6 +1765,18 @@ int uvc_ctrl_set(struct uvc_fh *handle,
 		value = xctrl->value;
 		break;
 
+	case V4L2_CTRL_TYPE_BITMASK:
+		if (!ctrl->cached) {
+			ret = uvc_ctrl_populate_cache(chain, ctrl);
+			if (ret < 0)
+				return ret;
+		}
+
+		xctrl->value = max(0, xctrl->value);
+		xctrl->value &= uvc_get_ctrl_bitmap(ctrl, mapping);
+		value = xctrl->value;
+		break;
+
 	case V4L2_CTRL_TYPE_BOOLEAN:
 		xctrl->value = clamp(xctrl->value, 0, 1);
 		value = xctrl->value;
@@ -1758,17 +1790,14 @@ int uvc_ctrl_set(struct uvc_fh *handle,
 		/* Valid menu indices are reported by the GET_RES request for
 		 * UVC controls that support it.
 		 */
-		if (mapping->data_type == UVC_CTRL_DATA_TYPE_BITMASK &&
-		    (ctrl->info.flags & UVC_CTRL_FLAG_GET_RES)) {
+		if (mapping->data_type == UVC_CTRL_DATA_TYPE_BITMASK) {
 			if (!ctrl->cached) {
 				ret = uvc_ctrl_populate_cache(chain, ctrl);
 				if (ret < 0)
 					return ret;
 			}
 
-			step = mapping->get(mapping, UVC_GET_RES,
-					uvc_ctrl_data(ctrl, UVC_CTRL_DATA_RES));
-			if (!(step & value))
+			if (!(uvc_get_ctrl_bitmap(ctrl, mapping) & value))
 				return -EINVAL;
 		}
 
-- 
2.35.1.1021.g381101b075-goog

