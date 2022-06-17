Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4797D550101
	for <lists+linux-kernel@lfdr.de>; Sat, 18 Jun 2022 01:57:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1382668AbiFQX4a (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Jun 2022 19:56:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50988 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235867AbiFQX4P (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Jun 2022 19:56:15 -0400
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com [IPv6:2a00:1450:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F92C54195
        for <linux-kernel@vger.kernel.org>; Fri, 17 Jun 2022 16:56:14 -0700 (PDT)
Received: by mail-ed1-x52e.google.com with SMTP id o10so8062095edi.1
        for <linux-kernel@vger.kernel.org>; Fri, 17 Jun 2022 16:56:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=XGyvgzMv/o67vUhjuadDgOPqP6bhpgbwlijxZc2E+uw=;
        b=LP7WqlQcTCQrr6X3k4GSlkNW2hhRAOd5wxFafKA1jUlJdUy1jJq6cRySyriytN2jpJ
         0eT2HeQYXGlDjosKyRxec2chetVVzCU0czgjx9jhEHPmbwOAVsEnVgVk2DW/3jaYrxoZ
         epT1EqBf7K2r4ZiLv3bVKwg6u+Lz5KiEhb2w4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=XGyvgzMv/o67vUhjuadDgOPqP6bhpgbwlijxZc2E+uw=;
        b=QIrCz47jWAnndwV7Fv1ecJ3azsRTzudQPoaic/H0UAinQN4vHEnxaKk2wR8DyNi4lE
         dBMlArhIvZGwsjtM4cwyIIEb80wCjH4yBJ3vMZLZuOzHd+b1a/jW18rdWlOCxaQswCMk
         v9w2qh+k9K2QMWdGJjVgUeOyn+rcYx5Hj0cpKm9tISU/apxPOEhWfGYB+qBC8OtxgWiY
         ShOdTImWZW0QantAwfHUPar7/OoyRvpDN4yZgLCjRncBf/5DueEQcJfm9paO8gU0ZvhA
         rKi2TYW22lJKmTopPro4HhHz6VYzb6+VN8vDcLHXgKuDQqQXxl0VDsWe407stGdUslYL
         rrdg==
X-Gm-Message-State: AJIora/GwoFi58pw67tlYPellvCC+30je78j6NqMRLAAcQMylddtof3p
        DxeX4elsVBZxSy1zO2J/gVTZPg==
X-Google-Smtp-Source: AGRyM1tJGH6oMZrjLMSMpk5XR2asvL1lPSg4xxY9zB68xl7XOrnUIZwfRaIBY/JEhCXSiXdH4cDbEw==
X-Received: by 2002:a05:6402:2211:b0:42d:cb9e:cbf with SMTP id cq17-20020a056402221100b0042dcb9e0cbfmr15566816edb.76.1655510172931;
        Fri, 17 Jun 2022 16:56:12 -0700 (PDT)
Received: from alco.lan (80.71.134.83.ipv4.parknet.dk. [80.71.134.83])
        by smtp.gmail.com with ESMTPSA id z21-20020aa7d415000000b0043566884333sm1452538edq.63.2022.06.17.16.56.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Jun 2022 16:56:12 -0700 (PDT)
From:   Ricardo Ribalda <ribalda@chromium.org>
To:     Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        tfiga@chromium.org, senozhatsky@chromium.org, yunkec@google.com
Cc:     Ricardo Ribalda <ribalda@chromium.org>
Subject: [PATCH v8 1/9] media: uvcvideo: Add missing value for power_line_frequency
Date:   Sat, 18 Jun 2022 01:56:02 +0200
Message-Id: <20220617235610.321917-2-ribalda@chromium.org>
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

UVC 1.5 class defines 4 values for this control on:
4.2.2.3.6 Power Line Frequency Control

Add the missing value when the UVC version is 1.5.

Signed-off-by: Ricardo Ribalda <ribalda@chromium.org>
Signed-off-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
---
 drivers/media/usb/uvc/uvc_ctrl.c | 56 +++++++++++++++++++++++++-------
 1 file changed, 45 insertions(+), 11 deletions(-)

diff --git a/drivers/media/usb/uvc/uvc_ctrl.c b/drivers/media/usb/uvc/uvc_ctrl.c
index 0e78233fc8a0..a709ebbb4d69 100644
--- a/drivers/media/usb/uvc/uvc_ctrl.c
+++ b/drivers/media/usb/uvc/uvc_ctrl.c
@@ -366,6 +366,7 @@ static const struct uvc_menu_info power_line_frequency_controls[] = {
 	{ 0, "Disabled" },
 	{ 1, "50 Hz" },
 	{ 2, "60 Hz" },
+	{ 3, "Auto" },
 };
 
 static const struct uvc_menu_info exposure_auto_controls[] = {
@@ -504,17 +505,6 @@ static const struct uvc_control_mapping uvc_ctrl_mappings[] = {
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
@@ -730,6 +720,34 @@ static const struct uvc_control_mapping uvc_ctrl_mappings[] = {
 	},
 };
 
+static const struct uvc_control_mapping uvc_ctrl_mappings_uvc11[] = {
+	{
+		.id		= V4L2_CID_POWER_LINE_FREQUENCY,
+		.entity		= UVC_GUID_UVC_PROCESSING,
+		.selector	= UVC_PU_POWER_LINE_FREQUENCY_CONTROL,
+		.size		= 2,
+		.offset		= 0,
+		.v4l2_type	= V4L2_CTRL_TYPE_MENU,
+		.data_type	= UVC_CTRL_DATA_TYPE_ENUM,
+		.menu_info	= power_line_frequency_controls,
+		.menu_count	= ARRAY_SIZE(power_line_frequency_controls) - 1,
+	},
+};
+
+static const struct uvc_control_mapping uvc_ctrl_mappings_uvc15[] = {
+	{
+		.id		= V4L2_CID_POWER_LINE_FREQUENCY,
+		.entity		= UVC_GUID_UVC_PROCESSING,
+		.selector	= UVC_PU_POWER_LINE_FREQUENCY_CONTROL,
+		.size		= 2,
+		.offset		= 0,
+		.v4l2_type	= V4L2_CTRL_TYPE_MENU,
+		.data_type	= UVC_CTRL_DATA_TYPE_ENUM,
+		.menu_info	= power_line_frequency_controls,
+		.menu_count	= ARRAY_SIZE(power_line_frequency_controls),
+	},
+};
+
 /* ------------------------------------------------------------------------
  * Utility functions
  */
@@ -2415,6 +2433,22 @@ static void uvc_ctrl_init_ctrl(struct uvc_video_chain *chain,
 	if (!ctrl->initialized)
 		return;
 
+	/* Process common mappings first. */
+	for (; mapping < mend; ++mapping) {
+		if (uvc_entity_match_guid(ctrl->entity, mapping->entity) &&
+		    ctrl->info.selector == mapping->selector)
+			__uvc_ctrl_add_mapping(chain, ctrl, mapping);
+	}
+
+	/* And then version-specific mappings. */
+	if (chain->dev->uvc_version < 0x0150) {
+		mapping = uvc_ctrl_mappings_uvc11;
+		mend = mapping + ARRAY_SIZE(uvc_ctrl_mappings_uvc11);
+	} else {
+		mapping = uvc_ctrl_mappings_uvc15;
+		mend = mapping + ARRAY_SIZE(uvc_ctrl_mappings_uvc15);
+	}
+
 	for (; mapping < mend; ++mapping) {
 		if (uvc_entity_match_guid(ctrl->entity, mapping->entity) &&
 		    ctrl->info.selector == mapping->selector)
-- 
2.37.0.rc0.104.g0611611a94-goog

