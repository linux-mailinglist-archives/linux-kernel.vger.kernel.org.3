Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 66736540065
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Jun 2022 15:45:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245046AbiFGNpP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Jun 2022 09:45:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47640 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244900AbiFGNo1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Jun 2022 09:44:27 -0400
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com [IPv6:2a00:1450:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 56AB7B040B
        for <linux-kernel@vger.kernel.org>; Tue,  7 Jun 2022 06:44:13 -0700 (PDT)
Received: by mail-ej1-x62b.google.com with SMTP id m20so35240695ejj.10
        for <linux-kernel@vger.kernel.org>; Tue, 07 Jun 2022 06:44:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=0RnT8kU7H7q3p/P8rHquQvDCE3TwnJon2uM96hlfJY0=;
        b=URYEV61L1OqQWcHFaz6HVZZw41azTKBGajmvr+oO88pXKBaaPk5gXoaz1MLPR4Hylt
         gsbg2QBhk3E2Bqdshhu0tAPQCzq179YQBJruAuANMA9qeFtoNAKkh45D7BaX5W+jjdks
         FYQvQiPkSr2+KglK5OKLx/b5OWqofHC3wD/jU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=0RnT8kU7H7q3p/P8rHquQvDCE3TwnJon2uM96hlfJY0=;
        b=0T1ENQIhtBZaVb2wRQAeWyApT4sYpSQ2bULp2PeF3G7e0s2Osk+GMjNcuhc1boVitf
         Xfuvyuq5LscMXV0LiKHIIYVJtdY13ahb1yYrFHwhW+3YvtN+786fkEU7RgzIfN8sfP2C
         EgC/f+sBprmnWPsz2J55BzXgivEH91Tr/mIfWAHuAsbXCVjRNJ9+2vBhXfOoFCRQhDit
         X19q1p2gm+cA23FgjZmmmoZssH/rHZUB98AoSyV7PKIuL3UrFBbTiZ6n2otaRdNOejns
         g+aE4EtP/Zt06YjtKa1yD3CHINIB6SZdr/wiy0FGI0WMf7wmv9KJOO8JPZWUhuPmaOAm
         hnKA==
X-Gm-Message-State: AOAM533uijFHk4irVPa28IMcY1PQAVAdiVKm0m9WWAdzYPnX83ixH7Bg
        A+rpZguTQMF8UVHyfIv1SD/log==
X-Google-Smtp-Source: ABdhPJxzNmui42lekBApvYxus0xOWG5jvi5mCObgyydzIK69TyEBj77obg6jzpnN2guzTB8U32VVhg==
X-Received: by 2002:a17:907:3f1f:b0:6fe:b40a:21f0 with SMTP id hq31-20020a1709073f1f00b006feb40a21f0mr26788778ejc.744.1654609451892;
        Tue, 07 Jun 2022 06:44:11 -0700 (PDT)
Received: from alco.corp.google.com ([2620:0:1059:10:d185:5aaa:c33d:f136])
        by smtp.gmail.com with ESMTPSA id c10-20020a170906528a00b0070a80f03a44sm6621347ejm.119.2022.06.07.06.44.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Jun 2022 06:44:11 -0700 (PDT)
From:   Ricardo Ribalda <ribalda@chromium.org>
To:     Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        Tomasz Figa <tfiga@chromium.org>,
        Sergey Senozhatsky <senozhatsky@chromium.org>,
        Yunke Cao <yunkec@google.com>
Cc:     Ricardo Ribalda <ribalda@chromium.org>
Subject: [PATCH v3 2/7] media: uvcvideo: Add UVC_QUIRK_LIMITED_POWERLINE
Date:   Tue,  7 Jun 2022 15:43:59 +0200
Message-Id: <20220607134405.166704-3-ribalda@chromium.org>
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

Add a quirk for devices that only support a limited set of Power Line
frequencies.

Signed-off-by: Ricardo Ribalda <ribalda@chromium.org>
---
 drivers/media/usb/uvc/uvc_ctrl.c | 24 ++++++++++++++++++++++++
 drivers/media/usb/uvc/uvcvideo.h |  1 +
 2 files changed, 25 insertions(+)

diff --git a/drivers/media/usb/uvc/uvc_ctrl.c b/drivers/media/usb/uvc/uvc_ctrl.c
index f9d4ac81e62f..4b06192c840e 100644
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
@@ -2405,6 +2423,12 @@ static void uvc_ctrl_prune_entity(struct uvc_device *dev,
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
index c5b4febd2d94..4ee46fc41e8d 100644
--- a/drivers/media/usb/uvc/uvcvideo.h
+++ b/drivers/media/usb/uvc/uvcvideo.h
@@ -212,6 +212,7 @@
 #define UVC_QUIRK_RESTORE_CTRLS_ON_INIT	0x00000400
 #define UVC_QUIRK_FORCE_Y8		0x00000800
 #define UVC_QUIRK_FORCE_BPP		0x00001000
+#define UVC_QUIRK_LIMITED_POWERLINE     0x00002000
 
 /* Format flags */
 #define UVC_FMT_FLAG_COMPRESSED		0x00000001
-- 
2.36.1.255.ge46751e96f-goog

