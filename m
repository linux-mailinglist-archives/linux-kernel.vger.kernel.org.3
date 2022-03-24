Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1BAD84E6877
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Mar 2022 19:14:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352560AbiCXSPf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Mar 2022 14:15:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51604 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352552AbiCXSPb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Mar 2022 14:15:31 -0400
Received: from mail-pl1-x631.google.com (mail-pl1-x631.google.com [IPv6:2607:f8b0:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CB9666D4DA
        for <linux-kernel@vger.kernel.org>; Thu, 24 Mar 2022 11:13:59 -0700 (PDT)
Received: by mail-pl1-x631.google.com with SMTP id e5so5592498pls.4
        for <linux-kernel@vger.kernel.org>; Thu, 24 Mar 2022 11:13:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=DqE74bYvnQjtQl1h8zT8Qxi0bYFi9X6KwVw8BvoUs9k=;
        b=iqvGHLpjcwYMzNRonyEnyQfKAXmVSknoFJsSf8mHI6KfwPUUubkVp6+0N3uICMLNn+
         XJnADWqioKWUsis+Apv5BoLNBqh0Bz+q5LBYru9hEvx+XbYZIMxOPmjiBh7QuJkCEXYu
         rgutDgqGlwMxI/K5n3MOLZxT0Cg0ulMtf9tCI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=DqE74bYvnQjtQl1h8zT8Qxi0bYFi9X6KwVw8BvoUs9k=;
        b=JhlgkxfoG2mU8D5WgwGwUthaYospvmxbE8bbHdP3kKqFpEaW/bqMehJ8JIn9rc3TWH
         5n514caXkYPR99JRoYDZrv53uy/iVlVOAQJsHUrfxpKeKGgbiX523Ukd+qhYlzr7rDBx
         ALLVI2KSKi3JGN9yBSjvFHEiID9mejJuY+T6/5Xbdn5D1cxyqO4Y64X4Dsbl4ETGs+ge
         3rN+JMaspwLnJ9sq98LM3UEwG4EgC3CaGmPnKgAxQhEk1UoqowwMg+OkXsxNC6sohp2l
         R5th+Xxk05h7xFJx+7ePPIlzNk4b1oB3Rbvx8B8DZg3/UWtEa44USihifKYgUC7cwzoa
         sIvQ==
X-Gm-Message-State: AOAM531w/ETu00bLt8+h3Cgdo3/OZldDrzoT2s4goj6WtMXwl3lueA07
        OeGQ75/s1a7nKSQgRmXsVjSDUA==
X-Google-Smtp-Source: ABdhPJwl+9iizA/7VS4py19ZQQL8nOVQwIVPAuANK2tocHeAj34TUxxoGKjGWlVQY/2sXBkUbWacjw==
X-Received: by 2002:a17:902:7204:b0:153:bffb:f348 with SMTP id ba4-20020a170902720400b00153bffbf348mr7156564plb.147.1648145639356;
        Thu, 24 Mar 2022 11:13:59 -0700 (PDT)
Received: from localhost ([2620:15c:202:201:690f:642:3ebe:c89d])
        by smtp.gmail.com with UTF8SMTPSA id z12-20020a17090a398c00b001c5f926f293sm3698261pjb.3.2022.03.24.11.13.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 24 Mar 2022 11:13:59 -0700 (PDT)
From:   Matthias Kaehlcke <mka@chromium.org>
To:     Thierry Reding <thierry.reding@gmail.com>,
        Sam Ravnborg <sam@ravnborg.org>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Rob Herring <robh+dt@kernel.org>
Cc:     Douglas Anderson <dianders@chromium.org>,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
        devicetree@vger.kernel.org, Matthias Kaehlcke <mka@chromium.org>
Subject: [PATCH 2/2] drm/panel-edp: Add AUO B133UAN01
Date:   Thu, 24 Mar 2022 11:13:52 -0700
Message-Id: <20220324111335.2.I816014b6c62da5a33af5021f3cc35cea66552c00@changeid>
X-Mailer: git-send-email 2.35.1.1021.g381101b075-goog
In-Reply-To: <20220324111335.1.I1131d63cbefbfa9ff107a284e2e51f880c5bf7c8@changeid>
References: <20220324111335.1.I1131d63cbefbfa9ff107a284e2e51f880c5bf7c8@changeid>
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

Add support for the AUO B133UAN01 13.3" WUXGA panel.

Signed-off-by: Matthias Kaehlcke <mka@chromium.org>
---
output of edid-decode:

  Block 0, Base EDID:
    EDID Structure Version & Revision: 1.4
    Vendor & Product Identification:
      Manufacturer: AUO
      Model: 34196
      Made in: 2020
    Basic Display Parameters & Features:
      Digital display
      Bits per primary color channel: 8
      DisplayPort interface
      Maximum image size: 29 cm x 18 cm
      Gamma: 2.20
      Supported color formats: RGB 4:4:4
      First detailed timing includes the native pixel format and preferred refresh rate
    Color Characteristics:
      Red  : 0.6513, 0.3271
      Green: 0.2900, 0.6279
      Blue : 0.1503, 0.0517
      White: 0.3134, 0.3291
    Established Timings I & II: none
    Standard Timings: none
    Detailed Timing Descriptors:
      DTD 1:  1920x1200   60.026 Hz   8:5    74.192 kHz 156.100 MHz (286 mm x 178 mm)
                   Hfront   16 Hsync  16 Hback 152 Hpol N
                   Vfront    3 Vsync  14 Vback  19 Vpol N
      Manufacturer-Specified Display Descriptor (0x0f): 00 0f 00 00 00 00 00 00 00 00 00 00 00 00 00 20 '............... '
      Alphanumeric Data String: 'AUO'
      Alphanumeric Data String: 'B133UAN01.0 '

 drivers/gpu/drm/panel/panel-edp.c | 32 +++++++++++++++++++++++++++++++
 1 file changed, 32 insertions(+)

diff --git a/drivers/gpu/drm/panel/panel-edp.c b/drivers/gpu/drm/panel/panel-edp.c
index e15e62f235d8..2e71dcb734aa 100644
--- a/drivers/gpu/drm/panel/panel-edp.c
+++ b/drivers/gpu/drm/panel/panel-edp.c
@@ -1043,6 +1043,35 @@ static const struct panel_desc auo_b133htn01 = {
 	},
 };
 
+static const struct drm_display_mode auo_b133uan01_mode = {
+	.clock = 156100,
+	.hdisplay = 1920,
+	.hsync_start = 1920 + 16,
+	.hsync_end = 1920 + 16 + 16,
+	.htotal = 1920 + 16 + 16 + 152,
+	.vdisplay = 1200,
+	.vsync_start = 1200 + 3,
+	.vsync_end = 1200 + 3 + 14,
+	.vtotal = 1200 + 3 + 14 + 19,
+	.flags = DISPLAY_FLAGS_VSYNC_LOW | DISPLAY_FLAGS_HSYNC_LOW,
+};
+
+static const struct panel_desc auo_b133uan01 = {
+	.modes = &auo_b133uan01_mode,
+	.num_modes = 1,
+	.bpc = 8,
+	.size = {
+		.width = 291,
+		.height = 195,
+	},
+
+	.delay = {
+		.hpd_reliable = 200,
+		.enable = 50,
+		.unprepare = 500,
+	},
+};
+
 static const struct drm_display_mode auo_b133xtn01_mode = {
 	.clock = 69500,
 	.hdisplay = 1366,
@@ -1720,6 +1749,9 @@ static const struct of_device_id platform_of_match[] = {
 	}, {
 		.compatible = "auo,b133htn01",
 		.data = &auo_b133htn01,
+	}, {
+		.compatible = "auo,b133uan01",
+		.data = &auo_b133uan01,
 	}, {
 		.compatible = "auo,b133xtn01",
 		.data = &auo_b133xtn01,
-- 
2.35.1.1021.g381101b075-goog

