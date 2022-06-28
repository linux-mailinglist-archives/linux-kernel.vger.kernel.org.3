Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 42D1255C4CA
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Jun 2022 14:50:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243454AbiF1H6N (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Jun 2022 03:58:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52946 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243365AbiF1H5n (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Jun 2022 03:57:43 -0400
Received: from mail-pj1-x102c.google.com (mail-pj1-x102c.google.com [IPv6:2607:f8b0:4864:20::102c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E8D215FE3;
        Tue, 28 Jun 2022 00:57:43 -0700 (PDT)
Received: by mail-pj1-x102c.google.com with SMTP id dw10-20020a17090b094a00b001ed00a16eb4so11850386pjb.2;
        Tue, 28 Jun 2022 00:57:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Stsk2/bOU7vOuNWE32xaiTWPsuWgFOSh1G81qAcroFs=;
        b=efvDGc/ev+4cijhfPBF4Nvzs0ZZXbPwU0xQNMKkm4gKXuxNXfvFsypMVj9enPRWDqi
         PAVEbSmWuTTvrK+kuBK9YqUjKTCVa2LFiyIPiuFg5BxhukouXY1SX9WVZrNJYo27/Mbg
         oiJ9y2eoiqadbtnV2Y0wNyNmFSizMGZx4OjZBx2tJ2QgiCI+rqoIzOHfWwfyZU76EerD
         CVG36y/FRvuye/I9qEQ6n7eCTMm/+87SaWW1VippGe/xUZncXJz4eohEo31TzBSNrrvH
         CM74J7TPDHLRy0/Y+tTrgxuJqGZKQkztz+drwsES06Y0GR+KLgPxvj2I9D0I32t+1LjF
         V6PQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Stsk2/bOU7vOuNWE32xaiTWPsuWgFOSh1G81qAcroFs=;
        b=ewuwpE0x6d1JV3QV6pchvYnfPVEmr/LdRWEaq9ejMdZagF0fSgW4wLlWTPpQAWxC62
         3KuMyCIe1T58V2ZMr2WexPFmi7ZAHtCONgegA8f5y/FtU5O81dGvR8bI9uVYRV29Gj1F
         rebfS3XXySc/c0wJRLpFM9t8Anm/0p0EIe6I2VmfNj9fH/YcqdvhNbATI8iW8Y8GMMf6
         3uoYfiAd9Kwgz4KAiCCGWhb0AEbm07Nqz9mRyUiEHtLz10QDq0LOaJU6ujpxO5lo7wom
         4cJLkhby5LOSoaSMzFaZVYPLLWvEnJL2w+6ABoV5ecosRIrf82ozO/I6wEPAihysw79w
         bg8g==
X-Gm-Message-State: AJIora8G9fctiAcfLeMyxERIYuDtJfM3VtHBH6y/juhibI5HN+se4soX
        Pdn4UR4bEonWq18MqCOJ5a8=
X-Google-Smtp-Source: AGRyM1uJlUVe1iOIyNUKGWDPgE10yf8e8d2ulYavyVmHfDTzgRpQbDfQXTH5ef6GSc7P2RmMP/oaMA==
X-Received: by 2002:a17:90b:38cc:b0:1ed:474a:a675 with SMTP id nn12-20020a17090b38cc00b001ed474aa675mr18224216pjb.149.1656403062615;
        Tue, 28 Jun 2022 00:57:42 -0700 (PDT)
Received: from chrome.huaqin.com ([101.78.151.222])
        by smtp.gmail.com with ESMTPSA id p31-20020a056a000a1f00b0051bdb735647sm8681944pfh.159.2022.06.28.00.57.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Jun 2022 00:57:42 -0700 (PDT)
From:   Rex Nie <rexnie3@gmail.com>
To:     linux-arm-kernel@lists.infradead.org
Cc:     Thierry Reding <thierry.reding@gmail.com>,
        Sam Ravnborg <sam@ravnborg.org>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        robh+dt@kernel.org, spanda@codeaurora.org, dianders@chromium.org,
        devicetree@vger.kernel.org, Hsin-Yi Wang <hsinyi@chromium.org>,
        Rex Nie <rexnie3@gmail.com>
Subject: [PATCH 1/2] drm/panel-edp: Add eDP innolux panel support
Date:   Tue, 28 Jun 2022 15:57:35 +0800
Message-Id: <20220628075735.2142949-1-rexnie3@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add support for the 14" innolux,n140hca-eac eDP panel.

Signed-off-by: Rex Nie <rexnie3@gmail.com>
---
 drivers/gpu/drm/panel/panel-edp.c | 26 ++++++++++++++++++++++++++
 1 file changed, 26 insertions(+)

diff --git a/drivers/gpu/drm/panel/panel-edp.c b/drivers/gpu/drm/panel/panel-edp.c
index 3626469c4cc2..2a8fcdffe80c 100644
--- a/drivers/gpu/drm/panel/panel-edp.c
+++ b/drivers/gpu/drm/panel/panel-edp.c
@@ -1355,6 +1355,29 @@ static const struct panel_desc innolux_n125hce_gn1 = {
 	},
 };
 
+static const struct display_timing innolux_n140hca_eac_timing = {
+	.pixelclock = { 72600000, 76420000, 80240000 },
+	.hactive = { 1920, 1920, 1920 },
+	.hfront_porch = { 80, 80, 80 },
+	.hback_porch = { 190, 190, 190 },
+	.hsync_len = { 60, 60, 60 },
+	.vactive = { 1080, 1080, 1080 },
+	.vfront_porch = { 6, 6, 6 },
+	.vback_porch = { 38, 38, 38 },
+	.vsync_len = { 8, 8, 8 },
+	.flags = DISPLAY_FLAGS_VSYNC_LOW | DISPLAY_FLAGS_HSYNC_LOW,
+};
+
+static const struct panel_desc innolux_n140hca_eac = {
+	.timings = &innolux_n140hca_eac_timing,
+	.num_timings = 1,
+	.bpc = 6,
+	.size = {
+		.width = 309,
+		.height = 174,
+	},
+};
+
 static const struct drm_display_mode innolux_p120zdg_bf1_mode = {
 	.clock = 206016,
 	.hdisplay = 2160,
@@ -1775,6 +1798,9 @@ static const struct of_device_id platform_of_match[] = {
 	}, {
 		.compatible = "innolux,n125hce-gn1",
 		.data = &innolux_n125hce_gn1,
+	}, {
+		.compatible = "innolux,n140hca-eac",
+		.data = &innolux_n140hca_eac,
 	}, {
 		.compatible = "innolux,p120zdg-bf1",
 		.data = &innolux_p120zdg_bf1,
-- 
2.25.1

