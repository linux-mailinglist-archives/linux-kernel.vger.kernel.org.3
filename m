Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1BE6255DDF9
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Jun 2022 15:28:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244359AbiF1Ixt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Jun 2022 04:53:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51502 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243946AbiF1Ixr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Jun 2022 04:53:47 -0400
Received: from mail-pl1-x630.google.com (mail-pl1-x630.google.com [IPv6:2607:f8b0:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5697C2D1CF;
        Tue, 28 Jun 2022 01:53:46 -0700 (PDT)
Received: by mail-pl1-x630.google.com with SMTP id q18so10449255pld.13;
        Tue, 28 Jun 2022 01:53:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=3IiMMMDPLwz9F3UeFSzYtl7u8epQnprjfnqcTqmPDdc=;
        b=M7FwbiPTrRshJ5EgrsPP+VaYq1MR/BrHKsCNp7qXs2Gn3eknJyZQR1pI797nCEBhZ0
         4QcsntzPyK7fynPM//y8CVknu8gqk/1DTCG2yjXz9uEKfUrWboN0zRKdUeL38lKfovY4
         RNOy0ERd+CxpfopeTzXUGDbhSTg/txJXaZud9pVuSnG+gt5wP5MHVqxonqpWDQ+Br3KZ
         tncEz7nyiYSo4CEe7eXGNHADuOXhcI0FRD/H2IsDyufXgmyZBnidDmVGMtOADgSleBgD
         cHrxBvUOnuNSITpAUmbaqSKDfDIRuzJseLDwuXuXwLOkpGbLI1MEFb0tHUBAPMA1NNG4
         vSsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=3IiMMMDPLwz9F3UeFSzYtl7u8epQnprjfnqcTqmPDdc=;
        b=XT4Zah7QDOx2UiISHo1kDclV9rxCDM3rQL1SOz6xp8dS+miEP63Y7qOdU+UN3rJouu
         7uj03WulkoN3KrSc14HkG0WACIVXCGhk0hQVdgjGHBgFDQ8lwKVlLBsP6Pum3fILFcBu
         yukme+u+6qo7V3W0OUEnpWJZ9oI4qEzu6sYey4swRyYVtIUW9/ellJjRxOYVDCgvxqkK
         4ZUIz1QEdkhzdFPA3srbQXpluq9F8KDuKfRHrVxFgB9GuOdSr802UN3H4uk2biy6GNpO
         VZp+iFQXR7zFLQ34TRYKw+fAetThaiUCCbJJ2ZcntBC1ZyXj2G/8/8nqla4vs65+Pyou
         fLrQ==
X-Gm-Message-State: AJIora+yIv/iLknAYePPqMTtIWF9yc8ebZ1ZZrEHS5iGMEdwiPyDCIzI
        Xf4RP+R91J8r78luOSB1rSY=
X-Google-Smtp-Source: AGRyM1tQQaTMMPE0J7kPg5DjNRTKWH4fPNaHPbowka1suIhUb1wyYd5iyqgMSyFEIQR/Xy2Qz8J/8w==
X-Received: by 2002:a17:902:ccc4:b0:156:5d37:b42f with SMTP id z4-20020a170902ccc400b001565d37b42fmr2555328ple.157.1656406425734;
        Tue, 28 Jun 2022 01:53:45 -0700 (PDT)
Received: from chrome.huaqin.com ([101.78.151.222])
        by smtp.gmail.com with ESMTPSA id md6-20020a17090b23c600b001e305f5cd22sm8875970pjb.47.2022.06.28.01.53.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Jun 2022 01:53:45 -0700 (PDT)
From:   Rex Nie <rexnie3@gmail.com>
To:     linux-arm-kernel@lists.infradead.org
Cc:     Thierry Reding <thierry.reding@gmail.com>,
        Sam Ravnborg <sam@ravnborg.org>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        robh+dt@kernel.org, spanda@codeaurora.org, dianders@chromium.org,
        devicetree@vger.kernel.org, Hsin-Yi Wang <hsinyi@chromium.org>,
        Rob Herring <robh@kernel.org>, Rex Nie <rexnie3@gmail.com>
Subject: [PATCH 1/2] drm/panel-edp: Add eDP innolux panel support
Date:   Tue, 28 Jun 2022 16:53:37 +0800
Message-Id: <20220628085337.2147369-1-rexnie3@gmail.com>
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
Acked-by: Hsin-Yi Wang <hsinyi@chromium.org>
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

