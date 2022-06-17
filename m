Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D0864550100
	for <lists+linux-kernel@lfdr.de>; Sat, 18 Jun 2022 01:57:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1383273AbiFQX4e (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Jun 2022 19:56:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50998 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237557AbiFQX4Q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Jun 2022 19:56:16 -0400
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com [IPv6:2a00:1450:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 35A6E4BBA5
        for <linux-kernel@vger.kernel.org>; Fri, 17 Jun 2022 16:56:15 -0700 (PDT)
Received: by mail-ej1-x62c.google.com with SMTP id v1so11323959ejg.13
        for <linux-kernel@vger.kernel.org>; Fri, 17 Jun 2022 16:56:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=cTvpiA1ZR8U86goCmlr+HfJiNGZOCmT5oj2favFUYLQ=;
        b=mmZtlQMGzNCjNQcv1eiLgD4N0okaAEzkDLg2T816Ydsp/aqrt1gynFn9IbR10J0kMK
         ZoKHJuJqwJvu/rKGd2qhUtN/kEtd0v6DRVKf7SIHAGsfzA5XdOPfUmtK9a68uBKB30kO
         nhS15u+yddeKPuOaAZd8sPI/m9mK5nJbw//7U=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=cTvpiA1ZR8U86goCmlr+HfJiNGZOCmT5oj2favFUYLQ=;
        b=7MvYaGiFsTJB1ChK3z2MqFlYTYCU7krAhQCFVu3R4WGw59cr6mnQhQnHZ4i5sR/puG
         i3bipd5jLHaWXGSIouse04eZkhZINKlX4KfB9YygyVuXsRErTcE8LqAT0aZNtiUdtyxd
         Dkpes7sAGc+cfHaO+pjgXIFqeGtVyecxhbK7USksAW/W0q9iNJ+SoweQtT9iX8Ho2e9d
         FftY8R0fHvoHoeairXZdgcjl67NrtXLjn53PkP5WKokLSBvpBUnoPHx0MJiTYR5zDY3n
         76pnOccfYHKEAyKdArNtpEnJFgxfOxLy9f74Q5Ex00uT2r6NC02KLuWl2PU1kBTuWAqE
         vKXQ==
X-Gm-Message-State: AJIora/1XrooXV9DLI83p/1VSdNoVpKVUc2ldQ2Bgb4K14HbaRQcklms
        8YTFEo2jDWdmtn/eNg7ZyNbOgw==
X-Google-Smtp-Source: AGRyM1vse0uGK1yWxGhb3BsOpxdtQXZjfNnlbuQsl4ZsUJZ7mUmiQA7UCBYBt+R7/6rjeT2czFMlDw==
X-Received: by 2002:a17:907:9005:b0:715:76ce:4476 with SMTP id ay5-20020a170907900500b0071576ce4476mr11643302ejc.560.1655510173781;
        Fri, 17 Jun 2022 16:56:13 -0700 (PDT)
Received: from alco.lan (80.71.134.83.ipv4.parknet.dk. [80.71.134.83])
        by smtp.gmail.com with ESMTPSA id z21-20020aa7d415000000b0043566884333sm1452538edq.63.2022.06.17.16.56.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Jun 2022 16:56:13 -0700 (PDT)
From:   Ricardo Ribalda <ribalda@chromium.org>
To:     Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        tfiga@chromium.org, senozhatsky@chromium.org, yunkec@google.com
Cc:     Ricardo Ribalda <ribalda@chromium.org>
Subject: [PATCH v8 2/9] media: uvcvideo: Add support for per-device control mapping overrides
Date:   Sat, 18 Jun 2022 01:56:03 +0200
Message-Id: <20220617235610.321917-3-ribalda@chromium.org>
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

Some devices do not implement all their controls in a way that complies
with the UVC specification. This is for instance the case for several
devices that do not support the disabled mode for the power line
frequency control. Add a mechanism to allow per-device control mapping
overrides to avoid errors when accessing non-compliant controls.

Signed-off-by: Ricardo Ribalda <ribalda@chromium.org>
Signed-off-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
---
 drivers/media/usb/uvc/uvc_ctrl.c | 34 +++++++++++++++++++++++++++-----
 drivers/media/usb/uvc/uvcvideo.h |  1 +
 2 files changed, 30 insertions(+), 5 deletions(-)

diff --git a/drivers/media/usb/uvc/uvc_ctrl.c b/drivers/media/usb/uvc/uvc_ctrl.c
index a709ebbb4d69..38e35e369ddf 100644
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
@@ -2433,14 +2432,39 @@ static void uvc_ctrl_init_ctrl(struct uvc_video_chain *chain,
 	if (!ctrl->initialized)
 		return;
 
-	/* Process common mappings first. */
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
+	mapping = uvc_ctrl_mappings;
+	mend = mapping + ARRAY_SIZE(uvc_ctrl_mappings);
 	for (; mapping < mend; ++mapping) {
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
2.37.0.rc0.104.g0611611a94-goog

