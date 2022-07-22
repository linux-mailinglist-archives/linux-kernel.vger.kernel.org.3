Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1A99C57E47B
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Jul 2022 18:33:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235772AbiGVQdC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Jul 2022 12:33:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32946 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235752AbiGVQc7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Jul 2022 12:32:59 -0400
Received: from mail-pg1-x532.google.com (mail-pg1-x532.google.com [IPv6:2607:f8b0:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8D7F69965A
        for <linux-kernel@vger.kernel.org>; Fri, 22 Jul 2022 09:32:56 -0700 (PDT)
Received: by mail-pg1-x532.google.com with SMTP id bf13so4811977pgb.11
        for <linux-kernel@vger.kernel.org>; Fri, 22 Jul 2022 09:32:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=IusqkAi12UkDRpxOqe5d+steBgvYPF1P177Hc5F7MjQ=;
        b=DpCEW4VfqPFdfl/zi4G3wiRIJC5E6AT1Fp15VyxrdjVkV7k/smBEKKfZPOBrN5xL2y
         R0kWUB7XgPKpG1gklBR1k/B12m3qGBj4vQljirixvhrVKxbmUj9gniiCQcdaMHa9PBSi
         6YZPQjh76JQ6pzsHyTGOUsznK2sx9R/6IZ+zE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=IusqkAi12UkDRpxOqe5d+steBgvYPF1P177Hc5F7MjQ=;
        b=rEhQiZhb7eWVmWSCr8yoYW9zIdIO1teTK08mmrntRTwn7D6zsdGS4GeorVrrb6Evjh
         MY4PEY0edJ3w1FngY6/eOArJ3rtfYpQ8VgmY2JKE4XxYY+pyUS6dL2hhzi6UlD8Xd1Ua
         jr4+a2GzNqQ2w4IeW1CBoGhSsqSiLgNSaZbbC92qWb8tW8qH5fXdMzPVnBDgT5WMkpVd
         M5N0qqp82RryPp7OzdLSu1qmyuKqwYtDNcFbo2Pgsr0RxGz1sn9zbBAv2piMaNmKlHOg
         pckz6WouzdcrGgaBTNaLT/+e/mlFFYzqRcIy6yVepocrQJ7PWDgCj3AkNevnN/+4Dktw
         dLlQ==
X-Gm-Message-State: AJIora8Xq+U+eXRhHilfiRwkCkQMTii7NIftTWHDwdjmhYs+1QxTtS5f
        oo/s0Qi+b947i3aSQ+g/jwxdNQ==
X-Google-Smtp-Source: AGRyM1tQGj7yROA244zt5l+vYLlHTkva9Qxq523ok9iT1yZ78hqApGuetIH3LfAEimjd/KI2mMzayQ==
X-Received: by 2002:a63:164d:0:b0:416:4bc:1c28 with SMTP id 13-20020a63164d000000b0041604bc1c28mr532460pgw.302.1658507571832;
        Fri, 22 Jul 2022 09:32:51 -0700 (PDT)
Received: from localhost ([2620:15c:11a:202:42b0:2897:3725:985a])
        by smtp.gmail.com with UTF8SMTPSA id u12-20020a170902e80c00b0016a11b7472csm3987832plg.166.2022.07.22.09.32.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 22 Jul 2022 09:32:50 -0700 (PDT)
From:   Matthias Kaehlcke <mka@chromium.org>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Douglas Anderson <dianders@chromium.org>,
        Stephen Boyd <swboyd@chromium.org>
Cc:     Matthias Kaehlcke <mka@chromium.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Subject: [PATCH v24 2/2] arm64: dts: qcom: sc7280-herobrine: Add nodes for onboard USB hub
Date:   Fri, 22 Jul 2022 09:32:45 -0700
Message-Id: <20220722093238.v24.2.I18481b296484eec47bdc292a31fa46fa8c655ca9@changeid>
X-Mailer: git-send-email 2.37.1.359.gd136c6c3e2-goog
In-Reply-To: <20220722093238.v24.1.I7a1a6448d50bdd38e6082204a9818c59cc7a9bfd@changeid>
References: <20220722093238.v24.1.I7a1a6448d50bdd38e6082204a9818c59cc7a9bfd@changeid>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
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

This requires "CONFIG_USB_ONBOARD_HUB=y".

Signed-off-by: Matthias Kaehlcke <mka@chromium.org>
Reviewed-by: Stephen Boyd <swboyd@chromium.org>
Reviewed-by: Douglas Anderson <dianders@chromium.org>
---

Changes in v24:
- renamed 'companion-hub' to 'peer-hub' according to the change
  in the binding

Changes in v23:
- added note about CONFIG_USB_ONBOARD_HUB to the commit message
- added 'Reviewed-by' tags from Stephen and Doug

Changes in v22:
- patch added to the series

 .../arm64/boot/dts/qcom/sc7280-herobrine.dtsi | 21 ++++++++++++++++++-
 1 file changed, 20 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/qcom/sc7280-herobrine.dtsi b/arch/arm64/boot/dts/qcom/sc7280-herobrine.dtsi
index 3f8996c00b05..1fd381a903de 100644
--- a/arch/arm64/boot/dts/qcom/sc7280-herobrine.dtsi
+++ b/arch/arm64/boot/dts/qcom/sc7280-herobrine.dtsi
@@ -144,8 +144,8 @@ pp3300_hub: pp3300-hub-regulator {
 		regulator-min-microvolt = <3300000>;
 		regulator-max-microvolt = <3300000>;
 
+		/* The BIOS leaves this regulator on */
 		regulator-boot-on;
-		regulator-always-on;
 
 		gpio = <&tlmm 157 GPIO_ACTIVE_HIGH>;
 		enable-active-high;
@@ -596,6 +596,25 @@ &usb_1 {
 
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
+		peer-hub = <&usb_hub_3_x>;
+	};
+
+	/* 3.x hub on port 2 */
+	usb_hub_3_x: hub@2 {
+		compatible = "usbbda,411";
+		reg = <2>;
+		vdd-supply = <&pp3300_hub>;
+		peer-hub = <&usb_hub_2_x>;
+	};
 };
 
 &usb_1_hsphy {
-- 
2.37.1.359.gd136c6c3e2-goog

