Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3F8F2513A0C
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Apr 2022 18:41:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350188AbiD1QoS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Apr 2022 12:44:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52510 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350180AbiD1QoQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Apr 2022 12:44:16 -0400
Received: from mail-pj1-x1036.google.com (mail-pj1-x1036.google.com [IPv6:2607:f8b0:4864:20::1036])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5AB3E712D9
        for <linux-kernel@vger.kernel.org>; Thu, 28 Apr 2022 09:41:01 -0700 (PDT)
Received: by mail-pj1-x1036.google.com with SMTP id z5-20020a17090a468500b001d2bc2743c4so4921330pjf.0
        for <linux-kernel@vger.kernel.org>; Thu, 28 Apr 2022 09:41:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=qJiuRECSnpzr/r130WpbdVNxTjo81pv/mIIp2L+c/nY=;
        b=MaxHFa7STH9vYwtHNlee8YnvBoz9jb2m71kuq/vvgUDzNkZxqniWwsHGm0s+Sgkuci
         ilOqdeDIS3tNMfqs4Dg6nLMhtlE6k9uKtP3HP0L5WkkcTECJJz0RTi7ECE5+eCigR5qL
         BZTT5e25NfiSRgivPpJ0kfv29X2BTav4VPOoU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=qJiuRECSnpzr/r130WpbdVNxTjo81pv/mIIp2L+c/nY=;
        b=etSDRDEHDQEeEAm502khg4tAvRDK+EaVvlcBS9SreLu4Lywpy2siEVeBeGxtKFllE/
         hDX2ImWOG3IxUu3i8ywCz73Y1DxSYDZCXVoGNjyUhWezzQTbghXseTxUIfrfVlRmtC9F
         v8OO6mTZL2Hjq2UNhiMA3ZEYDiIwen5TSfES2swAAi+AYq69D6gzW+6BqyiP0G9pN0jF
         IYwCXsW3S3TEeo725UAVJH9oegdVpvYaK79wp4aJh+WosM7DMiAKuwMDIPrbgA/0bC/t
         0ls+hDemiSXRTDOGw22z2yCDCE4+uX0JKOdCKkaWKlit0irSu9La/R6g2zq0dmwB3KQR
         M4Ug==
X-Gm-Message-State: AOAM533fX9XuaVmoiyspAM6GTNxpDmLv6b49fqhDMJOM0IG/QPtSELIM
        2xsO11n+pjFCTMbk+CWLAW0vtA==
X-Google-Smtp-Source: ABdhPJydUjjFGkIU3AxGc8pfjmFxnieNTpgtxKdOVoA/+bH/vovl+jh2dzUtXXG2uuMcDf+pZuKbLg==
X-Received: by 2002:a17:902:aa46:b0:159:6cb:163 with SMTP id c6-20020a170902aa4600b0015906cb0163mr34296390plr.83.1651164060892;
        Thu, 28 Apr 2022 09:41:00 -0700 (PDT)
Received: from localhost ([2620:15c:202:201:7a56:fc44:2682:8a2e])
        by smtp.gmail.com with UTF8SMTPSA id d6-20020a17090acd0600b001cd4989fed4sm11986259pju.32.2022.04.28.09.40.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 28 Apr 2022 09:41:00 -0700 (PDT)
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
Subject: [PATCH v23 2/2] arm64: dts: qcom: sc7280-herobrine: Add nodes for onboard USB hub
Date:   Thu, 28 Apr 2022 09:40:54 -0700
Message-Id: <20220428094043.v23.2.I18481b296484eec47bdc292a31fa46fa8c655ca9@changeid>
X-Mailer: git-send-email 2.36.0.464.gb9c8b46e94-goog
In-Reply-To: <20220428094043.v23.1.I7a1a6448d50bdd38e6082204a9818c59cc7a9bfd@changeid>
References: <20220428094043.v23.1.I7a1a6448d50bdd38e6082204a9818c59cc7a9bfd@changeid>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add nodes for the onboard USB hub on herobrine devices. Remove the
'always-on' property from the hub regulator, since the regulator
is now managed by the onboard_usb_hub driver.

This requires "CONFIG_USB_ONBOARD_HUB=y".

Signed-off-by: Matthias Kaehlcke <mka@chromium.org>
Reviewed-by: Stephen Boyd <swboyd@chromium.org>
Reviewed-by: Douglas Anderson <dianders@chromium.org>
---

Changes in v23:
- added note about CONFIG_USB_ONBOARD_HUB to the commit message
- added 'Reviewed-by' tags from Stephen and Doug

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
2.36.0.464.gb9c8b46e94-goog

