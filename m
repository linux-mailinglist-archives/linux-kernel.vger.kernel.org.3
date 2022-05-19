Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CCCF852DC80
	for <lists+linux-kernel@lfdr.de>; Thu, 19 May 2022 20:14:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243729AbiESSNa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 May 2022 14:13:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51002 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243684AbiESSNM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 May 2022 14:13:12 -0400
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com [IPv6:2a00:1450:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AD48DE64D2
        for <linux-kernel@vger.kernel.org>; Thu, 19 May 2022 11:13:11 -0700 (PDT)
Received: by mail-ed1-x531.google.com with SMTP id i40so7962063eda.7
        for <linux-kernel@vger.kernel.org>; Thu, 19 May 2022 11:13:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=DtTkHYnKGvfKFBtPz8vNVTdKZGvi19TnjUXim2qxDgg=;
        b=f09opcdOAlUEqHlVU0oPsZr8SxaD6LkLiNyxWZGwbd6XOYWSIKIx2gtSg8hp9tJqRO
         94SjTrnx31JZ9HIJMM2Cb5opm90u8lj4A36XQ+PhK2JcC8azXJfIaEWG5f3JNPRSRMNo
         rchXp7EcNXj3zVDkkNMriSMMrpXXA5fwbRPKQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=DtTkHYnKGvfKFBtPz8vNVTdKZGvi19TnjUXim2qxDgg=;
        b=fd2WdE6lvG8XxiCVEyNTpNNSvNWRXtZUuX/JbM/nr2t5At6Cwfr5DIFhg3UpUzmv0b
         3N4wxBsPtodsVVR2oot+jcQ/PuO8KB+adkXb0jNjuq9W5nUHKaHHGjiefhGo13S1Gi3R
         6Tn2Ms9qto5COYwtHqI3qNGcI3yk9y3HvWA4ImbiaRTVANn/XTDjROCk9Y3HcGi544au
         LZfdkJQWysSARvLYXbspQaPM0upYppSAxg6+ZY8zJ+KHGkXbngYu9oYAMSXuA0nerFT2
         mSrLc9GmnLPZGdjwPFIrpaja4DC9lol/ddVcG1djs0WtM7jtVHZ6c6mWxZ36eqAUdiyR
         HMxw==
X-Gm-Message-State: AOAM532qMFzix3LGiGcaLwv0eg7C764l1/785WywWPSgNqLsnHUoXghd
        GjRfXW+ZOunDeygdHJ2U5bTtaA==
X-Google-Smtp-Source: ABdhPJzu/wX8Pl7W71+uViY10MI6X9G1LrrCAQ2e99jhivYybqwFXiTkdT0MtPPfua/lypzkMvjxBw==
X-Received: by 2002:aa7:d3c5:0:b0:42a:ab58:1e50 with SMTP id o5-20020aa7d3c5000000b0042aab581e50mr6622591edr.320.1652983990345;
        Thu, 19 May 2022 11:13:10 -0700 (PDT)
Received: from alco.lan (80.71.134.83.ipv4.parknet.dk. [80.71.134.83])
        by smtp.gmail.com with ESMTPSA id hw7-20020a170907a0c700b006f3ef214e3csm1225801ejc.162.2022.05.19.11.13.09
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
Subject: [PATCH v2 2/4] media: uvcvideo: Add UVC_QUIRK_LIMITED_POWERLINE
Date:   Thu, 19 May 2022 20:13:04 +0200
Message-Id: <20220519181306.42136-3-ribalda@chromium.org>
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

Add a quirk for devices that only support a limited set of Power Line
frequencies.

Signed-off-by: Ricardo Ribalda <ribalda@chromium.org>
---
 drivers/media/usb/uvc/uvc_ctrl.c | 24 ++++++++++++++++++++++++
 drivers/media/usb/uvc/uvcvideo.h |  1 +
 2 files changed, 25 insertions(+)

diff --git a/drivers/media/usb/uvc/uvc_ctrl.c b/drivers/media/usb/uvc/uvc_ctrl.c
index a942021dfbe1..5027fedc4f39 100644
--- a/drivers/media/usb/uvc/uvc_ctrl.c
+++ b/drivers/media/usb/uvc/uvc_ctrl.c
@@ -375,6 +375,11 @@ static const struct uvc_menu_info power_line_frequency_controls_uvc15[] = {
 	{ 3, "Auto" },
 };
 
+static const struct uvc_menu_info power_line_frequency_controls_limited[] = {
+	{ 1, "50 Hz" },
+	{ 2, "60 Hz" },
+};
+
 static const struct uvc_menu_info exposure_auto_controls[] = {
 	{ 2, "Auto Mode" },
 	{ 1, "Manual Mode" },
@@ -752,6 +757,19 @@ struct uvc_control_mapping power_line_mapping_uvc15 = {
 	.menu_count	= ARRAY_SIZE(power_line_frequency_controls_uvc15),
 };
 
+static const
+struct uvc_control_mapping power_line_mapping_limited = {
+	.id		= V4L2_CID_POWER_LINE_FREQUENCY,
+	.entity		= UVC_GUID_UVC_PROCESSING,
+	.selector	= UVC_PU_POWER_LINE_FREQUENCY_CONTROL,
+	.size		= 2,
+	.offset		= 0,
+	.v4l2_type	= V4L2_CTRL_TYPE_MENU,
+	.data_type	= UVC_CTRL_DATA_TYPE_ENUM,
+	.menu_info	= power_line_frequency_controls_limited,
+	.menu_count	= ARRAY_SIZE(power_line_frequency_controls_limited),
+};
+
 /* ------------------------------------------------------------------------
  * Utility functions
  */
@@ -2395,6 +2413,12 @@ static void uvc_ctrl_prune_entity(struct uvc_device *dev,
 static void uvc_ctrl_init_powerline(struct uvc_video_chain *chain,
 				    struct uvc_control *ctrl)
 {
+	if (chain->dev->quirks & UVC_QUIRK_LIMITED_POWERLINE) {
+		__uvc_ctrl_add_mapping(chain, ctrl,
+				       &power_line_mapping_limited);
+		return;
+	}
+
 	if (chain->dev->uvc_version < 0x0150) {
 		__uvc_ctrl_add_mapping(chain, ctrl,
 				       &power_line_mapping_uvc11);
diff --git a/drivers/media/usb/uvc/uvcvideo.h b/drivers/media/usb/uvc/uvcvideo.h
index 143230b3275b..06779eb4f5fa 100644
--- a/drivers/media/usb/uvc/uvcvideo.h
+++ b/drivers/media/usb/uvc/uvcvideo.h
@@ -209,6 +209,7 @@
 #define UVC_QUIRK_RESTORE_CTRLS_ON_INIT	0x00000400
 #define UVC_QUIRK_FORCE_Y8		0x00000800
 #define UVC_QUIRK_FORCE_BPP		0x00001000
+#define UVC_QUIRK_LIMITED_POWERLINE     0x00002000
 
 /* Format flags */
 #define UVC_FMT_FLAG_COMPRESSED		0x00000001
-- 
2.36.1.124.g0e6072fb45-goog

