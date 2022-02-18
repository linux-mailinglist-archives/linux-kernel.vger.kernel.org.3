Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 75CC44BB6E0
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Feb 2022 11:28:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234056AbiBRK13 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Feb 2022 05:27:29 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:37940 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233570AbiBRK1X (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Feb 2022 05:27:23 -0500
Received: from mail-pg1-x531.google.com (mail-pg1-x531.google.com [IPv6:2607:f8b0:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 27163193CB;
        Fri, 18 Feb 2022 02:27:06 -0800 (PST)
Received: by mail-pg1-x531.google.com with SMTP id 75so7453980pgb.4;
        Fri, 18 Feb 2022 02:27:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=WRUQ/0ItbuB8Qd5eXwqs349lFDwlCtd3M661qIRr/M4=;
        b=mD47QKPrM8oJIUo+2zfGME4E/z+r0q6UB4rPJC0A6e/1sP61wyq8JjzZTfaYqLg4rz
         zd65wHk4j7xCrbUkA63r2cUWBIhpqDDoGnOSTYKw5oCCoagzg4Uqi3nupCr01pI8Hhoe
         dnkIkfcyAq1Jw/P3GfeRMAcg0qcIt4iMYFk5U5lhfPwHO9PIeCFqCoIZZGEkVGK6/9M2
         2lm/NmFLQZnk3UxhW0e/e6IpSFLR3fmpMbpq119M4eDA+HiVSWB/mJq4c22JzFXSYBfE
         FPSBE8ECWtRW1t1C/IJEqg7WBygiBLKNvhJfFnvQKMarWipClLIx9u8HmQJr60EbcD7H
         JP4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=WRUQ/0ItbuB8Qd5eXwqs349lFDwlCtd3M661qIRr/M4=;
        b=HFZ7Qf6JXv6XrbXP5cRa2Crntx/7SCG1DUdgHI0p32Ego75w2fNUWtWl3IB9WUehuF
         FkPsqnkhD27qsWvs4pGjVjtqXjjDrSh4h/oD041GihdVeMHv1a6UGlZjPtgtSHZ+RTp/
         9ToeJbMEaI3qkMu6dl0a7v9T+5xt4hV2EDealo772Ukzf8JR+YubyLOQuHlvURPM8pS5
         cnKLW6OBCiUvszbyNDjIssr27Q5oQMVd1bapCTKLhuAps7dDzsLhllGVcMRHSpY7V7pc
         Frv5tFLY3hkiC2qwmVUUit89J1J8yCcS5ZwcjAfchdeFY3vUZX0Z7Pe+4o8Iber0CDUJ
         kpCQ==
X-Gm-Message-State: AOAM532aj9U4QiKT1LtGpX2k5RynwVwngSMDYr063gWXzvrh8JJCs4qs
        hoBZujS0P6ENz9+FIqXS0Sc=
X-Google-Smtp-Source: ABdhPJzspd9NuP5bL32rgfy620IWs+rzFnjNv77U9r9eEoNmSQhxtq+FlWo92HmBLKkzXmlR4I4Wcg==
X-Received: by 2002:a63:a501:0:b0:372:f7dc:6ced with SMTP id n1-20020a63a501000000b00372f7dc6cedmr5871183pgf.26.1645180025700;
        Fri, 18 Feb 2022 02:27:05 -0800 (PST)
Received: from localhost.localdomain ([101.78.151.222])
        by smtp.gmail.com with ESMTPSA id r14sm2411481pfl.62.2022.02.18.02.27.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Feb 2022 02:27:05 -0800 (PST)
From:   Rex Nie <rexnie3@gmail.com>
To:     linux-arm-kernel@lists.infradead.org
Cc:     Thierry Reding <thierry.reding@gmail.com>,
        Sam Ravnborg <sam@ravnborg.org>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Rob Herring <robh+dt@kernel.org>,
        dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, hsinyi@chromium.org,
        Rex Nie <rexnie3@gmail.com>
Subject: [PATCH 1/2] drm/panel-edp: Add eDP innolux panel support
Date:   Fri, 18 Feb 2022 18:26:47 +0800
Message-Id: <20220218102647.1634329-1-rexnie3@gmail.com>
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
index f7bfcf63d48e..f5f9c9cb26ba 100644
--- a/drivers/gpu/drm/panel/panel-edp.c
+++ b/drivers/gpu/drm/panel/panel-edp.c
@@ -1330,6 +1330,29 @@ static const struct panel_desc innolux_n125hce_gn1 = {
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
@@ -1750,6 +1773,9 @@ static const struct of_device_id platform_of_match[] = {
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

