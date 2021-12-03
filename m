Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E1FE74675CD
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Dec 2021 11:58:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1380244AbhLCLB0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Dec 2021 06:01:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60948 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237898AbhLCLBY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Dec 2021 06:01:24 -0500
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com [IPv6:2a00:1450:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B9501C06173E
        for <linux-kernel@vger.kernel.org>; Fri,  3 Dec 2021 02:58:00 -0800 (PST)
Received: by mail-ed1-x52d.google.com with SMTP id l25so9721718eda.11
        for <linux-kernel@vger.kernel.org>; Fri, 03 Dec 2021 02:58:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=dL9Doftx7SsrphxuZsOqQd7wOm1YbbJk8+5XQsZLlm0=;
        b=eN8F4WnbbKtSgAFI7LGmb78vOkq7F4X85cb6co9pialUAR0d6/bogCs6k9V1C00cCb
         VcjZ+BMUBwZuy8ga0DF0XShJKY60R6h5kMhE/yokynDDT2vYa+xs1DjOit10zciPrGsB
         ZslnfT/WjLXG04OJ4jdMbSS3l6OyhXLIhaGDg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=dL9Doftx7SsrphxuZsOqQd7wOm1YbbJk8+5XQsZLlm0=;
        b=OQa0PxCw6LBM6Ov2ghfQ0F4F9HfKQq2M/r0PABgouj9RVWiiNg4rVikmcKBUgLKSXQ
         tt3QEzsvy3I/+BHLiknycc+9TVro6875l3mExOZ3G/v24pEZrVECTeK15z65aLV2QZys
         n4kQW7N+RDtX11WdXod6NIRcaScZT1m+X5Nwb0RKTa5ooAp4PIeL1xZSpk7n+wE5LYtK
         KzopaJ/FFAUiLNrj47uKMfEDUq58aUsoWDLhI5I60jeVzbVHQDXn8ZdNmRDkmWVZ0Ar8
         XMQCtN6iGyB7uIGwcLYKykWhsyFaO33qHZcLRbPfUsXr8nyK5Ireq0tQp49nGYaGrwH6
         vwjg==
X-Gm-Message-State: AOAM533hCPNKIiBSGb2PHVYBNS0k+O8BagjdhaQoNc72gdw5Iz5Y25uf
        2yXDr2MAN7Y23vekeunP1j9Z7g==
X-Google-Smtp-Source: ABdhPJyqC23S2y/KFhAVAGoa8zFNPaGUHEiQ0LFXx450o6VcXoNIld07YR+hpDXDIig7z/GjDAcg2Q==
X-Received: by 2002:a17:907:86a6:: with SMTP id qa38mr21673773ejc.286.1638529079375;
        Fri, 03 Dec 2021 02:57:59 -0800 (PST)
Received: from alco.corp.google.com ([100.104.168.197])
        by smtp.gmail.com with ESMTPSA id ar2sm1699775ejc.20.2021.12.03.02.57.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Dec 2021 02:57:59 -0800 (PST)
From:   Ricardo Ribalda <ribalda@chromium.org>
To:     Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>
Cc:     Ricardo Ribalda <ribalda@chromium.org>
Subject: [PATCH] media: uvcvideo: Fix handling on Bitmask controls
Date:   Fri,  3 Dec 2021 11:57:40 +0100
Message-Id: <20211203105740.1084689-1-ribalda@chromium.org>
X-Mailer: git-send-email 2.34.1.400.ga245620fadb-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Minimum and step values for V4L2_CTRL_TYPE_BITMASK controls should be 0.
There is no need to query the camera firmware about this and maybe get
invalid results.

Fixes v4l2-compliane:
Control ioctls (Input 0):
                fail: v4l2-test-controls.cpp(97): minimum must be 0 for a bitmask control
	test VIDIOC_QUERY_EXT_CTRL/QUERYMENU: FAIL

Signed-off-by: Ricardo Ribalda <ribalda@chromium.org>
---
 drivers/media/usb/uvc/uvc_ctrl.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/media/usb/uvc/uvc_ctrl.c b/drivers/media/usb/uvc/uvc_ctrl.c
index b4f6edf968bc..d478cfbad5bb 100644
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
 
-- 
2.34.1.400.ga245620fadb-goog

