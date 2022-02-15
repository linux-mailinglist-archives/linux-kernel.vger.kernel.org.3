Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B10FC4B779F
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Feb 2022 21:50:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243153AbiBOSmq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Feb 2022 13:42:46 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:44264 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241557AbiBOSmn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Feb 2022 13:42:43 -0500
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com [IPv6:2a00:1450:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B72B27FE5
        for <linux-kernel@vger.kernel.org>; Tue, 15 Feb 2022 10:42:32 -0800 (PST)
Received: by mail-wr1-x429.google.com with SMTP id u1so19899565wrg.11
        for <linux-kernel@vger.kernel.org>; Tue, 15 Feb 2022 10:42:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=17RfdOkFpQ0vqX6j3AbugB+kAjRG2bVcKwe0qdXZHnE=;
        b=R0NFIY6PLX5Bq2GY7wQqcv1fzjR+HqhwNljCYJLfBmHLsZkNkH5UgW4x9kBi5gvXUt
         Ss54ZIWiLGHlt9/QOiMPO7CGbXpioYIHjH9eSBDHqfbQhlFrWYzcqlbalgvqRQtDEPen
         UqB+yc+2Kr94kHm3BsC8qfB8cjPpwgXUmshMQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=17RfdOkFpQ0vqX6j3AbugB+kAjRG2bVcKwe0qdXZHnE=;
        b=CIeOKTVvit/nMjmOwZpvQ45mfFZCea3m8Ff0RVhTVlV9C6uZANBC2HqJxVqpyIKdGh
         w3NCkO+o2B69R5XFtlPBlX+fSZie/oUdETAaWUGoyGXEaoNYoZAduFwTG2wq4lWnI2Kt
         IYwLlPDaj74ClThJ83xQR4Gflvy/uQldncXu4xf6Ns0G8/iKAdQ0wpXuzNS6SHKiHBs8
         9+gVSUzs74wlDPi7Mtg1BRYqZby2ZQlHdfP3VIS7Fp+aH1sZ4meIGkHBDilRJamrzOTr
         jlAxacyJGZrl6BtSra7Bxz3y6l79iLStZU8Avks8UycLLMs+hSvjXKKwe6JtXpEkXApx
         Wm0g==
X-Gm-Message-State: AOAM532cZznRqwCJFV7nPVgpFJFocgMfCiC3GRwsY8wwknwNUXLLZSLF
        4pPHMjVDDOir6cQy5jnNZCwQxA==
X-Google-Smtp-Source: ABdhPJz54Ip87v52N6pTMY2GW3cc/euNgtBXo+zsV39RnEX7mH5FCghKMZBrBwTlkUeE9KcoPJKx/A==
X-Received: by 2002:adf:ffce:: with SMTP id x14mr253920wrs.552.1644950551214;
        Tue, 15 Feb 2022 10:42:31 -0800 (PST)
Received: from beni.c.googlers.com.com (216.131.76.34.bc.googleusercontent.com. [34.76.131.216])
        by smtp.gmail.com with ESMTPSA id a1sm14094017wri.36.2022.02.15.10.42.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Feb 2022 10:42:30 -0800 (PST)
From:   Ricardo Ribalda <ribalda@chromium.org>
To:     Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>
Cc:     Ricardo Ribalda <ribalda@chromium.org>
Subject: [PATCH v2] media: uvcvideo: Fix handling on Bitmask controls
Date:   Tue, 15 Feb 2022 18:42:28 +0000
Message-Id: <20220215184228.2531386-1-ribalda@chromium.org>
X-Mailer: git-send-email 2.35.1.265.g69c8d7142f-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
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

Also value should be clamped to the min/max value advertised by the
hardware.

Fixes v4l2-compliane:
Control ioctls (Input 0):
                fail: v4l2-test-controls.cpp(97): minimum must be 0 for a bitmask control
	test VIDIOC_QUERY_EXT_CTRL/QUERYMENU: FAIL

Signed-off-by: Ricardo Ribalda <ribalda@chromium.org>
---
 drivers/media/usb/uvc/uvc_ctrl.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/drivers/media/usb/uvc/uvc_ctrl.c b/drivers/media/usb/uvc/uvc_ctrl.c
index b4f6edf968bc0..d8b9ab5b7fb85 100644
--- a/drivers/media/usb/uvc/uvc_ctrl.c
+++ b/drivers/media/usb/uvc/uvc_ctrl.c
@@ -1156,7 +1156,8 @@ static int __uvc_query_v4l2_ctrl(struct uvc_video_chain *chain,
 		break;
 	}
 
-	if (ctrl->info.flags & UVC_CTRL_FLAG_GET_MIN)
+	if (ctrl->info.flags & UVC_CTRL_FLAG_GET_MIN &&
+	    mapping->v4l2_type != V4L2_CTRL_TYPE_BITMASK)
 		v4l2_ctrl->minimum = mapping->get(mapping, UVC_GET_MIN,
 				     uvc_ctrl_data(ctrl, UVC_CTRL_DATA_MIN));
 
@@ -1164,7 +1165,8 @@ static int __uvc_query_v4l2_ctrl(struct uvc_video_chain *chain,
 		v4l2_ctrl->maximum = mapping->get(mapping, UVC_GET_MAX,
 				     uvc_ctrl_data(ctrl, UVC_CTRL_DATA_MAX));
 
-	if (ctrl->info.flags & UVC_CTRL_FLAG_GET_RES)
+	if (ctrl->info.flags & UVC_CTRL_FLAG_GET_RES &&
+	    mapping->v4l2_type != V4L2_CTRL_TYPE_BITMASK)
 		v4l2_ctrl->step = mapping->get(mapping, UVC_GET_RES,
 				  uvc_ctrl_data(ctrl, UVC_CTRL_DATA_RES));
 
@@ -1721,6 +1723,7 @@ int uvc_ctrl_set(struct uvc_fh *handle,
 	/* Clamp out of range values. */
 	switch (mapping->v4l2_type) {
 	case V4L2_CTRL_TYPE_INTEGER:
+	case V4L2_CTRL_TYPE_BITMASK:
 		if (!ctrl->cached) {
 			ret = uvc_ctrl_populate_cache(chain, ctrl);
 			if (ret < 0)
-- 
2.35.1.265.g69c8d7142f-goog

