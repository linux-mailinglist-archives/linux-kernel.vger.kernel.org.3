Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 891F5510D04
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Apr 2022 02:04:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356297AbiD0AGv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Apr 2022 20:06:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43890 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1356293AbiD0AGn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Apr 2022 20:06:43 -0400
Received: from mail-pj1-x102d.google.com (mail-pj1-x102d.google.com [IPv6:2607:f8b0:4864:20::102d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A61DB177CBC
        for <linux-kernel@vger.kernel.org>; Tue, 26 Apr 2022 17:03:30 -0700 (PDT)
Received: by mail-pj1-x102d.google.com with SMTP id n33-20020a17090a5aa400b001d28f5ee3f9so374755pji.4
        for <linux-kernel@vger.kernel.org>; Tue, 26 Apr 2022 17:03:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=0GmEIX1GlLfTlvVrOCSpfIb3y6H22vbw5n+bX9zbtPk=;
        b=BpOzaqkng57OfFPssDa8a29JJ2oL8dkDDC1EEN35Qstu7ZxpLy6Erz+S533qY2Pyuv
         lQ1qbOlLL+JfJXI/mPqlFpZF3d7EJy8x4y3+AyQk9NCcnsw4Mf3muJAxIhJMH+q7fFaQ
         8LnVp0mDH1rOZ9B2yqKedwTbAeOPUPlOjK7f0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=0GmEIX1GlLfTlvVrOCSpfIb3y6H22vbw5n+bX9zbtPk=;
        b=RcZifWyj4SrNASdnIQbZ629q6OR5iEB6FzXsEfvJ6bejFV7PLWKbfxpu/4B3LX/bNK
         3Oos8wBrP4KaMtMk/sfil6B9L2+HQNdWEnmiPdL3lE0TAFIfZTA2JoTvalHQPMB8m33q
         btqOmOAJyqbB048t+Cd9LvxOmRq7Bxb5m0syrOckE+fW5I72uG4/XlQ3sy9ybywEphX3
         EUceEUPsTe51TaT8Hlg/qGAZ+T6uNF1HHzcb6zSaMkQeeZjzO6WAbRXg9CsQrDzG29hm
         OY1KzsIsWH+rGUDJnIK08oaVAs4kVnJFopXlrf9QzAxaP3eLV4YvKVBpUC1uHpozpwQ2
         7xSA==
X-Gm-Message-State: AOAM532zQ5U14m+kyQCRrcrDm8RG8J0tMRpKna+jcI4b0iyqv6OK28Wn
        twPkmwcpZrSw8vOifkasBY32nw==
X-Google-Smtp-Source: ABdhPJy8mmvU8CSUFstqZ4eSmmRZ++ZALKeAMtDS58ZkJvleqjLEopzPJg34ynBpjMxjtzlTbsYmfg==
X-Received: by 2002:a17:90a:9308:b0:1cb:a048:c140 with SMTP id p8-20020a17090a930800b001cba048c140mr30051370pjo.221.1651017810189;
        Tue, 26 Apr 2022 17:03:30 -0700 (PDT)
Received: from localhost ([2620:15c:202:201:a9a2:8a58:9d04:ba68])
        by smtp.gmail.com with UTF8SMTPSA id j1-20020a17090adc8100b001d9424e49c1sm4313819pjv.44.2022.04.26.17.03.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 26 Apr 2022 17:03:29 -0700 (PDT)
From:   Matthias Kaehlcke <mka@chromium.org>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Douglas Anderson <dianders@chromium.org>,
        Stephen Boyd <swboyd@chromium.org>
Cc:     Matthias Kaehlcke <mka@chromium.org>
Subject: [PATCH v22 2/2] arm64: dts: qcom: sc7280-herobrine: Add nodes for onboard USB hub
Date:   Tue, 26 Apr 2022 17:03:23 -0700
Message-Id: <20220426170306.v22.2.I18481b296484eec47bdc292a31fa46fa8c655ca9@changeid>
X-Mailer: git-send-email 2.36.0.rc2.479.g8af0fa9b8e-goog
In-Reply-To: <20220426170306.v22.1.I7a1a6448d50bdd38e6082204a9818c59cc7a9bfd@changeid>
References: <20220426170306.v22.1.I7a1a6448d50bdd38e6082204a9818c59cc7a9bfd@changeid>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add nodes for the onboard USB hub on herobrine devices. Remove the
'always-on' property from the hub regulator, since the regulator
is now managed by the onboard_usb_hub driver.

Signed-off-by: Matthias Kaehlcke <mka@chromium.org>
---

Changes in v22:
- patch added to the series

 .../arm64/boot/dts/qcom/sc7280-herobrine.dtsi | 21 ++++++++++++++++++-
 1 file changed, 20 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/qcom/sc7280-herobrine.dtsi b/arch/arm64/boot/dts/qcom/sc7280-herobrine.dtsi
index d58045dd7334..46937d21b229 100644
--- a/arch/arm64/boot/dts/qcom/sc7280-herobrine.dtsi
+++ b/arch/arm64/boot/dts/qcom/sc7280-herobrine.dtsi
@@ -143,8 +143,8 @@ pp3300_hub: pp3300-hub-regulator {
 		regulator-min-microvolt = <3300000>;
 		regulator-max-microvolt = <3300000>;
 
+		/* The BIOS leaves this regulator on */
 		regulator-boot-on;
-		regulator-always-on;
 
 		gpio = <&tlmm 157 GPIO_ACTIVE_HIGH>;
 		enable-active-high;
@@ -560,6 +560,25 @@ &usb_1 {
 
 &usb_1_dwc3 {
 	dr_mode = "host";
+
+	#address-cells = <1>;
+	#size-cells = <0>;
+
+	/* 2.x hub on port 1 */
+	usb_hub_2_x: hub@1 {
+		compatible = "usbbda,5411";
+		reg = <1>;
+		vdd-supply = <&pp3300_hub>;
+		companion-hub = <&usb_hub_3_x>;
+	};
+
+	/* 3.x hub on port 2 */
+	usb_hub_3_x: hub@2 {
+		compatible = "usbbda,411";
+		reg = <2>;
+		vdd-supply = <&pp3300_hub>;
+		companion-hub = <&usb_hub_2_x>;
+	};
 };
 
 &usb_1_hsphy {
-- 
2.36.0.rc2.479.g8af0fa9b8e-goog

