Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 47E5454CC60
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Jun 2022 17:15:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346974AbiFOPNZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Jun 2022 11:13:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33988 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242574AbiFOPNJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Jun 2022 11:13:09 -0400
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com [IPv6:2a00:1450:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA29FDFFD
        for <linux-kernel@vger.kernel.org>; Wed, 15 Jun 2022 08:13:04 -0700 (PDT)
Received: by mail-ed1-x52e.google.com with SMTP id o10so16643607edi.1
        for <linux-kernel@vger.kernel.org>; Wed, 15 Jun 2022 08:13:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=WEnoe5l63wIa1jNma1QDgL58B8nnhb1HJqhp7b+Nz/Q=;
        b=FH7EXpJoAkW3xkPL4zmOwg5JDBAmgGMx7bZjVJv8Krq1NYGjUbKI5Uf6uLb+ddzIO1
         fEc6cv6G+rdgItSTPGQYTZRNbGx62/NnxTrZVe47JqArS8MAa/xOQof9kJjPWt0LSS0D
         wLdm1yWSUh2u681JQNrKbvPIr+3iYK7TVwBJI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=WEnoe5l63wIa1jNma1QDgL58B8nnhb1HJqhp7b+Nz/Q=;
        b=gbRSwkurz9I4Q3cwwYc2xL7jJhkTMt7GT2uHXpvgajBAytUNQWRm1ruAAPe/rLb6S1
         7P9RRquaTMi3rpsYX8tABwlcZsz08SzHvxw+sj0rKul/OiX2x6bPJT/h+ZluGd9k8W/T
         EMaERnVJCEbMY6OY5ACBYAHFvojgGoIRaWSLOXVqfya326eA3ro1e3WrYg3+NiTEjXOu
         cunD9RmQBsjxc5FSnjrB8FVhfySaZt24b1ohyfGRq4JWGWUhOLZ1ujQNCdJfK6IXyfSu
         ZaZUkw7kZNu8gvim7xKmFptWhE7NUgcUDQTFElLB+xn9YYxYJqFu7EKCbgnhe9onXFpp
         ZxpA==
X-Gm-Message-State: AJIora884LMA8D1YdHjE2QHzEjuF3o0AD+xgJOm9HYGi3hDOh5b1Z9vY
        gXu80iStwR93oU9jmkzMqFUY6g==
X-Google-Smtp-Source: AGRyM1vXd7iSlTwXt1ax5Vt5GgolUdeDzGGen+bDhzvrnuHbocP+DgUF6Iq+5fzTC2HlseE+KJifjQ==
X-Received: by 2002:a05:6402:3592:b0:42d:fb03:319c with SMTP id y18-20020a056402359200b0042dfb03319cmr226511edc.137.1655305983493;
        Wed, 15 Jun 2022 08:13:03 -0700 (PDT)
Received: from alco.lan (80.71.134.83.ipv4.parknet.dk. [80.71.134.83])
        by smtp.gmail.com with ESMTPSA id b25-20020aa7cd19000000b0042bd2012196sm9610264edw.85.2022.06.15.08.13.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Jun 2022 08:13:03 -0700 (PDT)
From:   Ricardo Ribalda <ribalda@chromium.org>
To:     Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        tfiga@chromium.org, senozhatsky@chromium.org, yunkec@google.com
Cc:     Ricardo Ribalda <ribalda@chromium.org>
Subject: [PATCH v6 2/8] media: uvcvideo: Add support for per-device control mapping overrides
Date:   Wed, 15 Jun 2022 17:12:53 +0200
Message-Id: <20220615151259.77825-3-ribalda@chromium.org>
X-Mailer: git-send-email 2.36.1.476.g0c4daa206d-goog
In-Reply-To: <20220615151259.77825-1-ribalda@chromium.org>
References: <20220615151259.77825-1-ribalda@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Some devices do not implement all their controls in a way that complies
with the UVC specification. This is for instance the case for several
devices that do not support the disabled mode for the power line
frequency control. Add a mechanism to allow per-device control mapping
overrides to avoid errors when accessing non-compliant controls.

Signed-off-by: Ricardo Ribalda <ribalda@chromium.org>
Signed-off-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
---
 drivers/media/usb/uvc/uvc_ctrl.c | 35 ++++++++++++++++++++++++++------
 drivers/media/usb/uvc/uvcvideo.h |  1 +
 2 files changed, 30 insertions(+), 6 deletions(-)

diff --git a/drivers/media/usb/uvc/uvc_ctrl.c b/drivers/media/usb/uvc/uvc_ctrl.c
index a709ebbb4d69..092decfdaa62 100644
--- a/drivers/media/usb/uvc/uvc_ctrl.c
+++ b/drivers/media/usb/uvc/uvc_ctrl.c
@@ -2403,9 +2403,8 @@ static void uvc_ctrl_init_ctrl(struct uvc_video_chain *chain,
 {
 	const struct uvc_control_info *info = uvc_ctrls;
 	const struct uvc_control_info *iend = info + ARRAY_SIZE(uvc_ctrls);
-	const struct uvc_control_mapping *mapping = uvc_ctrl_mappings;
-	const struct uvc_control_mapping *mend =
-		mapping + ARRAY_SIZE(uvc_ctrl_mappings);
+	const struct uvc_control_mapping *mapping;
+	const struct uvc_control_mapping *mend;
 
 	/* XU controls initialization requires querying the device for control
 	 * information. As some buggy UVC devices will crash when queried
@@ -2433,14 +2432,38 @@ static void uvc_ctrl_init_ctrl(struct uvc_video_chain *chain,
 	if (!ctrl->initialized)
 		return;
 
-	/* Process common mappings first. */
-	for (; mapping < mend; ++mapping) {
+	/*
+	 * First check if the device provides a custom mapping for this control,
+	 * used to override standard mappings for non-conformant devices. Don't
+	 * process standard mappings if a custom mapping is found. This
+	 * mechanism doesn't support combining standard and custom mappings for
+	 * a single control.
+	 */
+	if (chain->dev->info->mappings) {
+		bool custom = false;
+		unsigned int i;
+
+		for (i = 0; (mapping = chain->dev->info->mappings[i]); ++i) {
+			if (uvc_entity_match_guid(ctrl->entity, mapping->entity) &&
+			    ctrl->info.selector == mapping->selector) {
+				__uvc_ctrl_add_mapping(chain, ctrl, mapping);
+				custom = true;
+			}
+		}
+
+		if (custom)
+			return;
+	}
+
+	/* Process common mappings next. */
+	mend = mapping + ARRAY_SIZE(uvc_ctrl_mappings);
+	for (mapping = uvc_ctrl_mappings; mapping < mend; ++mapping) {
 		if (uvc_entity_match_guid(ctrl->entity, mapping->entity) &&
 		    ctrl->info.selector == mapping->selector)
 			__uvc_ctrl_add_mapping(chain, ctrl, mapping);
 	}
 
-	/* And then version-specific mappings. */
+	/* Finally process version-specific mappings. */
 	if (chain->dev->uvc_version < 0x0150) {
 		mapping = uvc_ctrl_mappings_uvc11;
 		mend = mapping + ARRAY_SIZE(uvc_ctrl_mappings_uvc11);
diff --git a/drivers/media/usb/uvc/uvcvideo.h b/drivers/media/usb/uvc/uvcvideo.h
index c5b4febd2d94..fff5c5c99a3d 100644
--- a/drivers/media/usb/uvc/uvcvideo.h
+++ b/drivers/media/usb/uvc/uvcvideo.h
@@ -667,6 +667,7 @@ struct uvc_device_info {
 	u32	quirks;
 	u32	meta_format;
 	u16	uvc_version;
+	const struct uvc_control_mapping **mappings;
 };
 
 struct uvc_device {
-- 
2.36.1.476.g0c4daa206d-goog

