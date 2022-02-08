Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CA5404AD3C6
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Feb 2022 09:43:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351393AbiBHInU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Feb 2022 03:43:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39516 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351081AbiBHIms (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Feb 2022 03:42:48 -0500
Received: from mail-pf1-x42c.google.com (mail-pf1-x42c.google.com [IPv6:2607:f8b0:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F22F5C0401F6
        for <linux-kernel@vger.kernel.org>; Tue,  8 Feb 2022 00:42:46 -0800 (PST)
Received: by mail-pf1-x42c.google.com with SMTP id g8so7815051pfq.9
        for <linux-kernel@vger.kernel.org>; Tue, 08 Feb 2022 00:42:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=RKltf19DtHiRc15a3iaZ/NnDb+6ppKujiVxWZQto3YU=;
        b=O2UDOpBeBJRbX3+DaQG7mIxxaEO05L1HTD48WquGaDuYWsSttm9JTTNF7a+lc8KdMj
         tJRuDchff9o48V7UXFNQVgoxZ/rNJPLVl8KQxtPWFS7zVK0sOis64KFrKb3J8stVpjkN
         Pk7y7Sj69FXDSqgG4hJ/qiPJrJRpnz6L6YEME=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=RKltf19DtHiRc15a3iaZ/NnDb+6ppKujiVxWZQto3YU=;
        b=aEtUVs54xvOMR9LReIHQng1490nssXpSKyKEaBE31Siehl0kpe8aa7SA1TdHKbYxsG
         I4oth3lOB55vKWzw1MCzRvB23RxXgzEwjEyJWJerUu1I2isttxRWRDrkylBa6lryh0eV
         pUAneUeGvc/azfGgXqSpg1tKAFd7Z+EMzh556Ev+81luEGytgpEDgfHMnlZ83B1PKDTC
         BZdjQlhS2/0tIsT7/SqFPjsOpo9OGJ6b5Me/c66mIhuf+3V1Ztj33+s1XP1UNZAwXhMa
         FXSLvqtMm1kNP3WFx635sTys2IuEijqtu8wQxqQ8+xyhrvq9X3lqZ+H26qgb/ercLEO3
         MAKA==
X-Gm-Message-State: AOAM530++vD4wehyt3oWeIurn65cUINYOXicpEDzJWnLKpCDppzMdYAi
        /EmQnoEXoRaggX0pQUHudCyYhw==
X-Google-Smtp-Source: ABdhPJxJuhyNGgn/8M1tkfbfnImy5ANlW87FCMT9C5ygmikEd8cwYFifi2WHJ+zYaY+iMKeTEIBo9Q==
X-Received: by 2002:a63:2ad6:: with SMTP id q205mr2651010pgq.46.1644309766435;
        Tue, 08 Feb 2022 00:42:46 -0800 (PST)
Received: from hsinyi-z840.tpe.corp.google.com ([2401:fa00:1:10:7d9a:166e:9d34:ff4f])
        by smtp.gmail.com with ESMTPSA id m14sm15362390pfc.170.2022.02.08.00.42.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Feb 2022 00:42:46 -0800 (PST)
From:   Hsin-Yi Wang <hsinyi@chromium.org>
To:     dri-devel@lists.freedesktop.org, David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>, amd-gfx@lists.freedesktop.org,
        intel-gfx@lists.freedesktop.org
Cc:     Chun-Kuang Hu <chunkuang.hu@kernel.org>,
        Sean Paul <sean@poorly.run>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        linux-kernel@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org,
        Simon Ser <contact@emersion.fr>,
        Harry Wentland <harry.wentland@amd.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        Jani Nikula <jani.nikula@linux.intel.com>
Subject: [PATCH v8 3/3] arm64: dts: mt8183: Add panel rotation
Date:   Tue,  8 Feb 2022 16:42:34 +0800
Message-Id: <20220208084234.1684930-3-hsinyi@chromium.org>
X-Mailer: git-send-email 2.35.0.263.gb82422642f-goog
In-Reply-To: <20220208084234.1684930-1-hsinyi@chromium.org>
References: <20220208084234.1684930-1-hsinyi@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

krane, kakadu, and kodama boards have a default panel rotation.

Signed-off-by: Hsin-Yi Wang <hsinyi@chromium.org>
Reviewed-by: Enric Balletbo i Serra <enric.balletbo@collabora.com>
Tested-by: Enric Balletbo i Serra <enric.balletbo@collabora.com>
---
 arch/arm64/boot/dts/mediatek/mt8183-kukui.dtsi | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm64/boot/dts/mediatek/mt8183-kukui.dtsi b/arch/arm64/boot/dts/mediatek/mt8183-kukui.dtsi
index b42d81d26d7211..d29d4378170971 100644
--- a/arch/arm64/boot/dts/mediatek/mt8183-kukui.dtsi
+++ b/arch/arm64/boot/dts/mediatek/mt8183-kukui.dtsi
@@ -276,6 +276,7 @@ panel: panel@0 {
 		avee-supply = <&ppvarp_lcd>;
 		pp1800-supply = <&pp1800_lcd>;
 		backlight = <&backlight_lcd0>;
+		rotation = <270>;
 		port {
 			panel_in: endpoint {
 				remote-endpoint = <&dsi_out>;
-- 
2.35.0.263.gb82422642f-goog

