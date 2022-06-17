Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8724B55010E
	for <lists+linux-kernel@lfdr.de>; Sat, 18 Jun 2022 01:57:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1383337AbiFQX4h (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Jun 2022 19:56:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51016 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345025AbiFQX4R (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Jun 2022 19:56:17 -0400
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com [IPv6:2a00:1450:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D61953B41
        for <linux-kernel@vger.kernel.org>; Fri, 17 Jun 2022 16:56:16 -0700 (PDT)
Received: by mail-ed1-x52e.google.com with SMTP id eo8so8105146edb.0
        for <linux-kernel@vger.kernel.org>; Fri, 17 Jun 2022 16:56:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=jzUksJeBIzpsy16UnewiZbK9lVKFqzRfDsj2A+v5TqE=;
        b=Aqcio3+OisfYLPjsZkAJKSDbmJUrEQObnag1l5b3iiryXcpoj/AzYByWjPa7XmotVb
         3Udj1arHXw5FldLsfjkY3r3XK3Tv8oHTJ/zxgHkZKS/YBBZ1jj81q+0Xj7+Xe/fz4srz
         cqgqum6vhWyih0CIe9y0AFr+DzXsP7UUFo+yc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=jzUksJeBIzpsy16UnewiZbK9lVKFqzRfDsj2A+v5TqE=;
        b=eWym11KbzMt45fz4YcQ41ZTn/y/vbFvlqTglyfhJblB5N2ymy6SCwI8thV8jzPFbF2
         Efxcp8sKuKGvs4qA3Vqda24+1zhgga9/XWa8zm3yvLXtcquFrlJT3N24FPR3YmCTetLr
         VbgmP19MsD8Cq6CxZOviZl0Kyl3A5cYMth7zY8pstfaEGn9AY46BgMfKSfP1Vz8zAth8
         9h0wTQvjrjQ1MRaVdjTuin0PttnZjUJD06R9O6a5KaykCC80pbZ/qf5MSNVkR7qRV0Jl
         lYLuL8wFBCz8GjYLznwd9OwqDe42C1zgCqwdAFFeCWOHPF5cZnxuWJxTz9JTopzItQg6
         GGiQ==
X-Gm-Message-State: AJIora+YgWHMLwA5t/k44tecNuKYJsUHHM9ThlwHxIKmsuzZ74fuFao+
        lJgMN/IHDBDmJ912i41xfQq+rQ==
X-Google-Smtp-Source: AGRyM1v1BXRQH1QU7y1eRqMlDrpZIcr1QOY200xBGU0eoON+62vb30JkTD1Vhq7N6dpOxtL8S7WF5w==
X-Received: by 2002:aa7:df19:0:b0:435:5eb7:5e31 with SMTP id c25-20020aa7df19000000b004355eb75e31mr6980994edy.418.1655510174636;
        Fri, 17 Jun 2022 16:56:14 -0700 (PDT)
Received: from alco.lan (80.71.134.83.ipv4.parknet.dk. [80.71.134.83])
        by smtp.gmail.com with ESMTPSA id z21-20020aa7d415000000b0043566884333sm1452538edq.63.2022.06.17.16.56.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Jun 2022 16:56:14 -0700 (PDT)
From:   Ricardo Ribalda <ribalda@chromium.org>
To:     Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        tfiga@chromium.org, senozhatsky@chromium.org, yunkec@google.com
Cc:     Ricardo Ribalda <ribalda@chromium.org>
Subject: [PATCH v8 3/9] media: uvcvideo: Implement mask for V4L2_CTRL_TYPE_MENU
Date:   Sat, 18 Jun 2022 01:56:04 +0200
Message-Id: <20220617235610.321917-4-ribalda@chromium.org>
X-Mailer: git-send-email 2.37.0.rc0.104.g0611611a94-goog
In-Reply-To: <20220617235610.321917-1-ribalda@chromium.org>
References: <20220617235610.321917-1-ribalda@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Replace the count with a mask field that let us choose not only the max
value, but also the minimum value and what values are valid in between.

Signed-off-by: Ricardo Ribalda <ribalda@chromium.org>
Suggested-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
---
 drivers/media/usb/uvc/uvc_ctrl.c | 32 ++++++++++++++++++++++----------
 drivers/media/usb/uvc/uvc_v4l2.c |  2 +-
 drivers/media/usb/uvc/uvcvideo.h |  2 +-
 3 files changed, 24 insertions(+), 12 deletions(-)

diff --git a/drivers/media/usb/uvc/uvc_ctrl.c b/drivers/media/usb/uvc/uvc_ctrl.c
index 38e35e369ddf..a03714c3a265 100644
--- a/drivers/media/usb/uvc/uvc_ctrl.c
+++ b/drivers/media/usb/uvc/uvc_ctrl.c
@@ -524,7 +524,8 @@ static const struct uvc_control_mapping uvc_ctrl_mappings[] = {
 		.v4l2_type	= V4L2_CTRL_TYPE_MENU,
 		.data_type	= UVC_CTRL_DATA_TYPE_BITMASK,
 		.menu_info	= exposure_auto_controls,
-		.menu_count	= ARRAY_SIZE(exposure_auto_controls),
+		.menu_mask	=
+			BIT_MASK(ARRAY_SIZE(exposure_auto_controls)),
 		.slave_ids	= { V4L2_CID_EXPOSURE_ABSOLUTE, },
 	},
 	{
@@ -730,7 +731,8 @@ static const struct uvc_control_mapping uvc_ctrl_mappings_uvc11[] = {
 		.v4l2_type	= V4L2_CTRL_TYPE_MENU,
 		.data_type	= UVC_CTRL_DATA_TYPE_ENUM,
 		.menu_info	= power_line_frequency_controls,
-		.menu_count	= ARRAY_SIZE(power_line_frequency_controls) - 1,
+		.menu_mask	=
+			BIT_MASK(ARRAY_SIZE(power_line_frequency_controls) - 1),
 	},
 };
 
@@ -744,7 +746,8 @@ static const struct uvc_control_mapping uvc_ctrl_mappings_uvc15[] = {
 		.v4l2_type	= V4L2_CTRL_TYPE_MENU,
 		.data_type	= UVC_CTRL_DATA_TYPE_ENUM,
 		.menu_info	= power_line_frequency_controls,
-		.menu_count	= ARRAY_SIZE(power_line_frequency_controls),
+		.menu_mask	=
+			BIT_MASK(ARRAY_SIZE(power_line_frequency_controls)),
 	},
 };
 
@@ -970,7 +973,9 @@ static s32 __uvc_ctrl_get_value(struct uvc_control_mapping *mapping,
 		const struct uvc_menu_info *menu = mapping->menu_info;
 		unsigned int i;
 
-		for (i = 0; i < mapping->menu_count; ++i, ++menu) {
+		for (i = 1; BIT(i) <= mapping->menu_mask; ++i, ++menu) {
+			if (!test_bit(i, &mapping->menu_mask))
+				continue;
 			if (menu->value == value) {
 				value = i;
 				break;
@@ -1144,12 +1149,14 @@ static int __uvc_query_v4l2_ctrl(struct uvc_video_chain *chain,
 
 	switch (mapping->v4l2_type) {
 	case V4L2_CTRL_TYPE_MENU:
-		v4l2_ctrl->minimum = 0;
-		v4l2_ctrl->maximum = mapping->menu_count - 1;
+		v4l2_ctrl->minimum = ffs(mapping->menu_mask) - 1;
+		v4l2_ctrl->maximum = fls(mapping->menu_mask) - 1;
 		v4l2_ctrl->step = 1;
 
 		menu = mapping->menu_info;
-		for (i = 0; i < mapping->menu_count; ++i, ++menu) {
+		for (i = 1; BIT(i) <= mapping->menu_mask; ++i, ++menu) {
+			if (!test_bit(i, &mapping->menu_mask))
+				continue;
 			if (menu->value == v4l2_ctrl->default_value) {
 				v4l2_ctrl->default_value = i;
 				break;
@@ -1264,7 +1271,7 @@ int uvc_query_v4l2_menu(struct uvc_video_chain *chain,
 		goto done;
 	}
 
-	if (query_menu->index >= mapping->menu_count) {
+	if (!test_bit(query_menu->index, &mapping->menu_mask)) {
 		ret = -EINVAL;
 		goto done;
 	}
@@ -1769,8 +1776,13 @@ int uvc_ctrl_set(struct uvc_fh *handle,
 		break;
 
 	case V4L2_CTRL_TYPE_MENU:
-		if (xctrl->value < 0 || xctrl->value >= mapping->menu_count)
+		if (xctrl->value < (ffs(mapping->menu_mask) - 1) ||
+		    xctrl->value > (fls(mapping->menu_mask) - 1))
 			return -ERANGE;
+
+		if (!test_bit(xctrl->value, &mapping->menu_mask))
+			return -EINVAL;
+
 		value = mapping->menu_info[xctrl->value].value;
 
 		/* Valid menu indices are reported by the GET_RES request for
@@ -2217,7 +2229,7 @@ static int __uvc_ctrl_add_mapping(struct uvc_video_chain *chain,
 
 	INIT_LIST_HEAD(&map->ev_subs);
 
-	size = sizeof(*mapping->menu_info) * mapping->menu_count;
+	size = sizeof(*mapping->menu_info) * fls(mapping->menu_mask);
 	map->menu_info = kmemdup(mapping->menu_info, size, GFP_KERNEL);
 	if (map->menu_info == NULL) {
 		kfree(map->name);
diff --git a/drivers/media/usb/uvc/uvc_v4l2.c b/drivers/media/usb/uvc/uvc_v4l2.c
index 648dcd579e81..85aced173daa 100644
--- a/drivers/media/usb/uvc/uvc_v4l2.c
+++ b/drivers/media/usb/uvc/uvc_v4l2.c
@@ -79,7 +79,7 @@ static int uvc_ioctl_ctrl_map(struct uvc_video_chain *chain,
 			goto free_map;
 		}
 
-		map->menu_count = xmap->menu_count;
+		map->menu_mask = BIT_MASK(xmap->menu_count);
 		break;
 
 	default:
diff --git a/drivers/media/usb/uvc/uvcvideo.h b/drivers/media/usb/uvc/uvcvideo.h
index fff5c5c99a3d..0736b8815d79 100644
--- a/drivers/media/usb/uvc/uvcvideo.h
+++ b/drivers/media/usb/uvc/uvcvideo.h
@@ -254,7 +254,7 @@ struct uvc_control_mapping {
 	u32 data_type;
 
 	const struct uvc_menu_info *menu_info;
-	u32 menu_count;
+	unsigned long menu_mask;
 
 	u32 master_id;
 	s32 master_manual;
-- 
2.37.0.rc0.104.g0611611a94-goog

