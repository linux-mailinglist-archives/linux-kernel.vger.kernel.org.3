Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9390948F2C0
	for <lists+linux-kernel@lfdr.de>; Sat, 15 Jan 2022 00:03:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231268AbiANXC3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Jan 2022 18:02:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55014 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231255AbiANXC2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Jan 2022 18:02:28 -0500
Received: from mail-pg1-x52a.google.com (mail-pg1-x52a.google.com [IPv6:2607:f8b0:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F3E9C06173E
        for <linux-kernel@vger.kernel.org>; Fri, 14 Jan 2022 15:02:28 -0800 (PST)
Received: by mail-pg1-x52a.google.com with SMTP id s1so3911751pga.5
        for <linux-kernel@vger.kernel.org>; Fri, 14 Jan 2022 15:02:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=o2h9cZxYJ3emYpUIj++uO1rilt4TStZ87q6578VwqZA=;
        b=htS6cflFJn1ZL5Y0EPBeN6hbyK7QvRLQG6rL5+hf+Wyp/p/OwvwAl+Evj2ZQ1THw8U
         UC6WEz/EhH69UAKuS4Z7gffz1k2LATR0EJgozsv2LnARXXrqxKBBQ4ABYZcLLxPDoo6k
         9jAJ1rcvLoaJTprwBOkTnDB9oHf7Sk8iuKDJE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=o2h9cZxYJ3emYpUIj++uO1rilt4TStZ87q6578VwqZA=;
        b=77IRZaOwVeGtVJtNkkkafAH15Q5H88FTiI/FY1roHqMqEh3doEkAISuhp8ZLIJKs1l
         ALvoBa4G75x+NK0Bc9irNo4G5sUYPJrsIu+1Q7YiWsNsI+u9cQc0GFQoOzq/JlWEASst
         xybBeIHdpmfgcBHetoQ6GJ0QbVofQhXqkIxKov1/GeMn3ej6uVvgl7G6fJG1R8SZ4q7x
         mGmnDnSelB4qqAkZuVSC8vtnVzw7fvueMgIoJ/DGgOsPgyNqNqQuJb3rEO/wcQVeTv6W
         kmQMFaGIRVKLjrkvjnvfGsF6bjhm18wiuQUQKLYSuy1Kgn09ktDGv0hzpZaZXuUSNIH7
         ekvA==
X-Gm-Message-State: AOAM5312FfgKuUWYy+9dKhGTGDV9zEtX7hBDlXCiLmfYPYqc7nk5JhKn
        Icw1Yc3o0oWK0/mElnVhufZRvw==
X-Google-Smtp-Source: ABdhPJyUUCEgb915ys8+J2HAqJSVrMJLFjTcoRKHgsU+KV+w14oykK1ZzYgHLlzxpYzPiETOK+okYA==
X-Received: by 2002:a05:6a00:2408:b0:4c1:e1a1:770 with SMTP id z8-20020a056a00240800b004c1e1a10770mr10548879pfh.70.1642201348060;
        Fri, 14 Jan 2022 15:02:28 -0800 (PST)
Received: from localhost ([2620:15c:202:201:76ab:ede1:503d:1c39])
        by smtp.gmail.com with UTF8SMTPSA id h11sm6161656pjs.10.2022.01.14.15.02.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 14 Jan 2022 15:02:27 -0800 (PST)
From:   Brian Norris <briannorris@chromium.org>
To:     Heiko Stuebner <heiko@sntech.de>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>
Cc:     linux-rockchip@lists.infradead.org, Lin Huang <hl@rock-chips.com>,
        linux-arm-kernel@lists.infradead.org,
        dri-devel@lists.freedesktop.org, Rob Herring <robh+dt@kernel.org>,
        Sandy Huang <hjc@rock-chips.com>, linux-kernel@vger.kernel.org,
        alsa-devel@alsa-project.org, devicetree@vger.kernel.org,
        Brian Norris <briannorris@chromium.org>
Subject: [PATCH v2 1/3] arm64: dts: rockchip: Switch RK3399-Gru DP to SPDIF output
Date:   Fri, 14 Jan 2022 15:02:07 -0800
Message-Id: <20220114150129.v2.1.I46f64b00508d9dff34abe1c3e8d2defdab4ea1e5@changeid>
X-Mailer: git-send-email 2.34.1.703.g22d0c6ccf7-goog
In-Reply-To: <20220114230209.4091727-1-briannorris@chromium.org>
References: <20220114230209.4091727-1-briannorris@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit b18c6c3c7768 ("ASoC: rockchip: cdn-dp sound output use spdif")
switched the platform to SPDIF, but we didn't fix up the device tree.

Drop the pinctrl settings, because the 'spdif_bus' pins are either:
 * unused (on kevin, bob), so the settings is ~harmless
 * used by a different function (on scarlet), which causes probe
   failures (!!)

Fixes: b18c6c3c7768 ("ASoC: rockchip: cdn-dp sound output use spdif")
Signed-off-by: Brian Norris <briannorris@chromium.org>
---

Changes in v2:
 - (Un)set pinctrl, because the default assumes we're routing out to
   external pins

 arch/arm64/boot/dts/rockchip/rk3399-gru.dtsi | 17 ++++++++++++-----
 1 file changed, 12 insertions(+), 5 deletions(-)

diff --git a/arch/arm64/boot/dts/rockchip/rk3399-gru.dtsi b/arch/arm64/boot/dts/rockchip/rk3399-gru.dtsi
index 45a5ae5d2027..162f08bca0d4 100644
--- a/arch/arm64/boot/dts/rockchip/rk3399-gru.dtsi
+++ b/arch/arm64/boot/dts/rockchip/rk3399-gru.dtsi
@@ -286,7 +286,7 @@ max98357a: max98357a {
 
 	sound: sound {
 		compatible = "rockchip,rk3399-gru-sound";
-		rockchip,cpu = <&i2s0 &i2s2>;
+		rockchip,cpu = <&i2s0 &spdif>;
 	};
 };
 
@@ -437,10 +437,6 @@ &i2s0 {
 	status = "okay";
 };
 
-&i2s2 {
-	status = "okay";
-};
-
 &io_domains {
 	status = "okay";
 
@@ -537,6 +533,17 @@ &sdmmc {
 	vqmmc-supply = <&ppvar_sd_card_io>;
 };
 
+&spdif {
+	status = "okay";
+
+	/*
+	 * SPDIF is routed internally to DP; we either don't use these pins, or
+	 * mux them to something else.
+	 */
+	/delete-property/ pinctrl-0;
+	/delete-property/ pinctrl-names;
+};
+
 &spi1 {
 	status = "okay";
 
-- 
2.34.1.703.g22d0c6ccf7-goog

