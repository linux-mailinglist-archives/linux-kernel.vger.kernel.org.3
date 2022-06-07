Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7931F54005F
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Jun 2022 15:44:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244923AbiFGNon (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Jun 2022 09:44:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47694 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244896AbiFGNo1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Jun 2022 09:44:27 -0400
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com [IPv6:2a00:1450:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE7FDB0400
        for <linux-kernel@vger.kernel.org>; Tue,  7 Jun 2022 06:44:11 -0700 (PDT)
Received: by mail-ej1-x62a.google.com with SMTP id o7so2007094eja.1
        for <linux-kernel@vger.kernel.org>; Tue, 07 Jun 2022 06:44:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=81mSmxn15JtVkPz978aR9cpRDrkI+JcjBbyBqhiZujI=;
        b=JgKwyycO6K1nAZG5gXllWbL5lodh9u9YaRM+BOe9H5U9nQazybhFS8p5DbJMKHEsA7
         WrWQEd0liSXRb9uOiSEyOWtL1QsFh4UsNSC+vX3dW2J4KvUgfJe5NcrU1TFEHaW6iBVO
         hc+k523x57hBMog3+jOEI3i31MJYCWNnfjkiw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=81mSmxn15JtVkPz978aR9cpRDrkI+JcjBbyBqhiZujI=;
        b=RdSBMeQY9R7SPRYRDPA3vMsxTJtORraaaC537IzcWn/VLNh2DYuIHQEdfYdGtgq0Fs
         ViC6fvDpZ5xdk/RpwXushK7NqqmqLa4VAW+KTeDdE2AtsfbB11UKS9hZqev+WWRwE3FP
         Ve9HXa1cQQhahdCPI7ITbZ4xkC9jOOZisPxRZ7wu+vjzuqDESzZb9s3dZ7eSUP2/z41z
         7miOYtbeEquU5IsQBS6a1sCS6zd3knjASLlEeLPkG5I5koIdosicF1ROV8sM4EeMayWP
         8syPGEb3Tf4j507wXeowbGgpp/R88T4U7nm9KaYLwUeDY3K+BSsEj7fTBkJQSsOxmaur
         ctgw==
X-Gm-Message-State: AOAM532ZHBtKJbPBGE0gU5OM7zWNjrfC1xcjEL4sVU6MbW0Bj0cSATYE
        r1r0sNC3yxrcRl70+fpO6nTfcA==
X-Google-Smtp-Source: ABdhPJyL5DI94AAHTIYayLqSbNJLhgFDVPvODwS2D5wfFFejzTQ08+VSiBqqyc0v3kBzk+iWYZChzw==
X-Received: by 2002:a17:906:99c1:b0:6fe:b01d:134 with SMTP id s1-20020a17090699c100b006feb01d0134mr26619200ejn.598.1654609450293;
        Tue, 07 Jun 2022 06:44:10 -0700 (PDT)
Received: from alco.corp.google.com ([2620:0:1059:10:d185:5aaa:c33d:f136])
        by smtp.gmail.com with ESMTPSA id c10-20020a170906528a00b0070a80f03a44sm6621347ejm.119.2022.06.07.06.44.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Jun 2022 06:44:09 -0700 (PDT)
From:   Ricardo Ribalda <ribalda@chromium.org>
To:     Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        Tomasz Figa <tfiga@chromium.org>,
        Sergey Senozhatsky <senozhatsky@chromium.org>,
        Yunke Cao <yunkec@google.com>
Cc:     Ricardo Ribalda <ribalda@chromium.org>
Subject: [PATCH v3 1/7] media: uvcvideo: Add missing value for power_line_frequency
Date:   Tue,  7 Jun 2022 15:43:58 +0200
Message-Id: <20220607134405.166704-2-ribalda@chromium.org>
X-Mailer: git-send-email 2.36.1.255.ge46751e96f-goog
In-Reply-To: <20220607134405.166704-1-ribalda@chromium.org>
References: <20220607134405.166704-1-ribalda@chromium.org>
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

UVC 1.5 class defines 4 values for this control on:
4.2.2.3.6 Power Line Frequency Control

Add the missing value when the uvc version is 1.5.

Signed-off-by: Ricardo Ribalda <ribalda@chromium.org>
---
 drivers/media/usb/uvc/uvc_ctrl.c | 67 ++++++++++++++++++++++++++------
 1 file changed, 55 insertions(+), 12 deletions(-)

diff --git a/drivers/media/usb/uvc/uvc_ctrl.c b/drivers/media/usb/uvc/uvc_ctrl.c
index 0e78233fc8a0..f9d4ac81e62f 100644
--- a/drivers/media/usb/uvc/uvc_ctrl.c
+++ b/drivers/media/usb/uvc/uvc_ctrl.c
@@ -362,12 +362,19 @@ static const u32 uvc_control_classes[] = {
 	V4L2_CID_USER_CLASS,
 };
 
-static const struct uvc_menu_info power_line_frequency_controls[] = {
+static const struct uvc_menu_info power_line_frequency_controls_uvc11[] = {
 	{ 0, "Disabled" },
 	{ 1, "50 Hz" },
 	{ 2, "60 Hz" },
 };
 
+static const struct uvc_menu_info power_line_frequency_controls_uvc15[] = {
+	{ 0, "Disabled" },
+	{ 1, "50 Hz" },
+	{ 2, "60 Hz" },
+	{ 3, "Auto" },
+};
+
 static const struct uvc_menu_info exposure_auto_controls[] = {
 	{ 2, "Auto Mode" },
 	{ 1, "Manual Mode" },
@@ -504,17 +511,6 @@ static const struct uvc_control_mapping uvc_ctrl_mappings[] = {
 		.v4l2_type	= V4L2_CTRL_TYPE_INTEGER,
 		.data_type	= UVC_CTRL_DATA_TYPE_UNSIGNED,
 	},
-	{
-		.id		= V4L2_CID_POWER_LINE_FREQUENCY,
-		.entity		= UVC_GUID_UVC_PROCESSING,
-		.selector	= UVC_PU_POWER_LINE_FREQUENCY_CONTROL,
-		.size		= 2,
-		.offset		= 0,
-		.v4l2_type	= V4L2_CTRL_TYPE_MENU,
-		.data_type	= UVC_CTRL_DATA_TYPE_ENUM,
-		.menu_info	= power_line_frequency_controls,
-		.menu_count	= ARRAY_SIZE(power_line_frequency_controls),
-	},
 	{
 		.id		= V4L2_CID_HUE_AUTO,
 		.entity		= UVC_GUID_UVC_PROCESSING,
@@ -730,6 +726,32 @@ static const struct uvc_control_mapping uvc_ctrl_mappings[] = {
 	},
 };
 
+static const
+struct uvc_control_mapping power_line_mapping_uvc11 = {
+	.id		= V4L2_CID_POWER_LINE_FREQUENCY,
+	.entity		= UVC_GUID_UVC_PROCESSING,
+	.selector	= UVC_PU_POWER_LINE_FREQUENCY_CONTROL,
+	.size		= 2,
+	.offset		= 0,
+	.v4l2_type	= V4L2_CTRL_TYPE_MENU,
+	.data_type	= UVC_CTRL_DATA_TYPE_ENUM,
+	.menu_info	= power_line_frequency_controls_uvc11,
+	.menu_count	= ARRAY_SIZE(power_line_frequency_controls_uvc11),
+};
+
+static const
+struct uvc_control_mapping power_line_mapping_uvc15 = {
+	.id		= V4L2_CID_POWER_LINE_FREQUENCY,
+	.entity		= UVC_GUID_UVC_PROCESSING,
+	.selector	= UVC_PU_POWER_LINE_FREQUENCY_CONTROL,
+	.size		= 2,
+	.offset		= 0,
+	.v4l2_type	= V4L2_CTRL_TYPE_MENU,
+	.data_type	= UVC_CTRL_DATA_TYPE_ENUM,
+	.menu_info	= power_line_frequency_controls_uvc15,
+	.menu_count	= ARRAY_SIZE(power_line_frequency_controls_uvc15),
+};
+
 /* ------------------------------------------------------------------------
  * Utility functions
  */
@@ -2376,6 +2398,22 @@ static void uvc_ctrl_prune_entity(struct uvc_device *dev,
 	}
 }
 
+/*
+ * The powerline control has different valid values depending on the
+ * uvc version.
+ */
+static void uvc_ctrl_init_powerline(struct uvc_video_chain *chain,
+				    struct uvc_control *ctrl)
+{
+	if (chain->dev->uvc_version < 0x0150) {
+		__uvc_ctrl_add_mapping(chain, ctrl,
+				       &power_line_mapping_uvc11);
+		return;
+	}
+
+	__uvc_ctrl_add_mapping(chain, ctrl, &power_line_mapping_uvc15);
+}
+
 /*
  * Add control information and hardcoded stock control mappings to the given
  * device.
@@ -2385,6 +2423,7 @@ static void uvc_ctrl_init_ctrl(struct uvc_video_chain *chain,
 {
 	const struct uvc_control_info *info = uvc_ctrls;
 	const struct uvc_control_info *iend = info + ARRAY_SIZE(uvc_ctrls);
+	static const u8 uvc_processing_guid[16] = UVC_GUID_UVC_PROCESSING;
 	const struct uvc_control_mapping *mapping = uvc_ctrl_mappings;
 	const struct uvc_control_mapping *mend =
 		mapping + ARRAY_SIZE(uvc_ctrl_mappings);
@@ -2415,6 +2454,10 @@ static void uvc_ctrl_init_ctrl(struct uvc_video_chain *chain,
 	if (!ctrl->initialized)
 		return;
 
+	if (uvc_entity_match_guid(ctrl->entity, uvc_processing_guid) &&
+	    ctrl->info.selector == UVC_PU_POWER_LINE_FREQUENCY_CONTROL)
+		return uvc_ctrl_init_powerline(chain, ctrl);
+
 	for (; mapping < mend; ++mapping) {
 		if (uvc_entity_match_guid(ctrl->entity, mapping->entity) &&
 		    ctrl->info.selector == mapping->selector)
-- 
2.36.1.255.ge46751e96f-goog

