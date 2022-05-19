Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2C8B652DC81
	for <lists+linux-kernel@lfdr.de>; Thu, 19 May 2022 20:14:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243695AbiESSNV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 May 2022 14:13:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50994 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243678AbiESSNM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 May 2022 14:13:12 -0400
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com [IPv6:2a00:1450:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F399FE2778
        for <linux-kernel@vger.kernel.org>; Thu, 19 May 2022 11:13:10 -0700 (PDT)
Received: by mail-ej1-x62a.google.com with SMTP id tk15so11472663ejc.6
        for <linux-kernel@vger.kernel.org>; Thu, 19 May 2022 11:13:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=4oHC2UL/uT+CeC3Bhy2Sd3bfihalBiyRm6h+7MwzQhs=;
        b=esO64HJ1ztOf9o7SUzieX17ChrPrwQC/qszyG7cT5c1XJHzu01cLH65kuxHQ9x66Z5
         ofDIwsnsLmqkHAZ+SUaffj/MGZnMRRta/DRYhlsNuI5AYLd8TOk91X1hHs1usCrI/XRh
         t7ofMe59T9YSGleUKupZ1i9YWBgfEj1SWg7Rg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=4oHC2UL/uT+CeC3Bhy2Sd3bfihalBiyRm6h+7MwzQhs=;
        b=gBPhCsJrgXBWs6sZcjvdG0RzsYL7PkL+VUzY0+mc+q7LVkS1mGCaGQijX21WmUMj6J
         HHHED6aiQoUK5t5itl1HR9m8aKCAW+YjF/eOStpdpkE8o2WBQV6scKG++xjUTZ3w6XkU
         EPqikk2aF2ISXgXUC9+4cw/X/kyZTM9/MXzwtSubXW6/JL1X+lckzb/7Uc7HFhDHe1OC
         /+TitH640pY3HrfPIsatlzNAs0V4RueYJ6Wf+c2Rutokj8oa9K9hTZ/nLS+k+DIY8X4m
         qgLEyCterdvrezk9UAqhjTPQxQzq5KM5fHe6xyEYnxHDeulWQF4xX9/anKHZrXSnJgw5
         uuEA==
X-Gm-Message-State: AOAM530CPYDtMYpBz8RZ9vt+4coiAfEEfh5CVUd9lqG9CEVm+V+vKWh6
        ze40LEav/QcFx0m3op+b1gC4oA==
X-Google-Smtp-Source: ABdhPJw+dMw1Ri9Lg+71IQs66Zi8xaBRoDIzaO22Ofv9or9LGrYs9/pNFFf4hX3uk93kBzidxO1+2A==
X-Received: by 2002:a17:907:1c20:b0:6f4:639e:9400 with SMTP id nc32-20020a1709071c2000b006f4639e9400mr5542895ejc.485.1652983989519;
        Thu, 19 May 2022 11:13:09 -0700 (PDT)
Received: from alco.lan (80.71.134.83.ipv4.parknet.dk. [80.71.134.83])
        by smtp.gmail.com with ESMTPSA id hw7-20020a170907a0c700b006f3ef214e3csm1225801ejc.162.2022.05.19.11.13.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 May 2022 11:13:09 -0700 (PDT)
From:   Ricardo Ribalda <ribalda@chromium.org>
To:     Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        Tomasz Figa <tfiga@chromium.org>,
        Sergey Senozhatsky <senozhatsky@chromium.org>,
        Yunke Cao <yunkec@google.com>
Cc:     Ricardo Ribalda <ribalda@chromium.org>
Subject: [PATCH v2 1/4] media: uvcvideo: Add missing value for power_line_frequency
Date:   Thu, 19 May 2022 20:13:03 +0200
Message-Id: <20220519181306.42136-2-ribalda@chromium.org>
X-Mailer: git-send-email 2.36.1.124.g0e6072fb45-goog
In-Reply-To: <20220519181306.42136-1-ribalda@chromium.org>
References: <20220519181306.42136-1-ribalda@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
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

v2: Thanks Laurent

uvc 1.1 only has 3 values, do not break those devices.

 drivers/media/usb/uvc/uvc_ctrl.c | 67 ++++++++++++++++++++++++++------
 1 file changed, 55 insertions(+), 12 deletions(-)

diff --git a/drivers/media/usb/uvc/uvc_ctrl.c b/drivers/media/usb/uvc/uvc_ctrl.c
index b4f6edf968bc..a942021dfbe1 100644
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
@@ -2366,6 +2388,22 @@ static void uvc_ctrl_prune_entity(struct uvc_device *dev,
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
@@ -2375,6 +2413,7 @@ static void uvc_ctrl_init_ctrl(struct uvc_video_chain *chain,
 {
 	const struct uvc_control_info *info = uvc_ctrls;
 	const struct uvc_control_info *iend = info + ARRAY_SIZE(uvc_ctrls);
+	static const u8 uvc_processing_guid[16] = UVC_GUID_UVC_PROCESSING;
 	const struct uvc_control_mapping *mapping = uvc_ctrl_mappings;
 	const struct uvc_control_mapping *mend =
 		mapping + ARRAY_SIZE(uvc_ctrl_mappings);
@@ -2405,6 +2444,10 @@ static void uvc_ctrl_init_ctrl(struct uvc_video_chain *chain,
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
2.36.1.124.g0e6072fb45-goog

