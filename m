Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C2071544AC1
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Jun 2022 13:43:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244473AbiFILm7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Jun 2022 07:42:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39882 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244280AbiFILmD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Jun 2022 07:42:03 -0400
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com [IPv6:2a00:1450:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D23B1EB410
        for <linux-kernel@vger.kernel.org>; Thu,  9 Jun 2022 04:40:41 -0700 (PDT)
Received: by mail-ed1-x534.google.com with SMTP id x5so25722047edi.2
        for <linux-kernel@vger.kernel.org>; Thu, 09 Jun 2022 04:40:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Cm99/QV8MCKPId9CWvCx5513sd3/VdteWTSHrf5MAuA=;
        b=IeIXgof4B0Q/CNadsJ81xWKhW4648bm0Bmz6NNJdmGo+xJ2aE4jH5B8LYqff4TQuMY
         CEgKWbiYJieOO734SxHsakpbjawn5PaZ96gNt4ljVViOAEDB5/FjrkLRAUgcStv37kfu
         8WGyFULk4g6iNjvEreTtLxa9PaGuVK/UkroYLQ7hWQ6QTKh7oManSUqZW9TzK13pO81S
         aY5CbeDB6gMYBYZ8qo4iVI/zAqLrRN+2sbZl4wEYpsFNvIo2DrdHMu1tfCavJzw4hYiO
         PtDQmC0yocG4AGknTgXKAdk+TAzbw23Glu0p7n2gQEvAIrMMj4ErTuC1CZjCJOvIhAuW
         Rk2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Cm99/QV8MCKPId9CWvCx5513sd3/VdteWTSHrf5MAuA=;
        b=68GK+Ayf2jS+fq/rE046xmeStUjRn40BsazlMy5/d3azrO1EmZtwEiSeRu0k4P31LV
         GapBqjC5mvHX+wHmLy5rHStvFuP7fj7qF6/kfjRGBR69wIAHV4XcqBCksBpO7rT511+q
         1rHaY9Nx7sJbcyI1aBNWADl1wb7RxcxI7giXjeZtxmO2uhjt0iwAEzKiNXi2ZizdCicW
         cBzyyrXoVw3ExX4ldeMU0CMPOj7GwIT6MvxtMemnzJVbnVRbvp6HgtwzIF7NGSTV4KIi
         bsKQV0COwWe7M3T4xSMwuAaMPSjFMr5z5gUw5qlSt5BM0K0Gf2BPDmAsR5jphAcaBH9x
         bfCA==
X-Gm-Message-State: AOAM530gecP0EQBSp0/NEnOMeM+XYqKr40mwWHJKETci769snTNGktG1
        keszF1Qrl5NrypahH3gjDvHV8Q==
X-Google-Smtp-Source: ABdhPJxPnZiByIuXXyPwrss2NwpXu20D98x3DIJyrJ7lhdZcBBZCjUqfnBRx6HVhmgLyTi/3GULYkQ==
X-Received: by 2002:a05:6402:378b:b0:42a:ad8c:628f with SMTP id et11-20020a056402378b00b0042aad8c628fmr44617147edb.90.1654774839884;
        Thu, 09 Jun 2022 04:40:39 -0700 (PDT)
Received: from localhost.localdomain (xdsl-188-155-176-92.adslplus.ch. [188.155.176.92])
        by smtp.gmail.com with ESMTPSA id 10-20020a170906058a00b007101f6f0720sm7760844ejn.120.2022.06.09.04.40.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Jun 2022 04:40:39 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Arnd Bergmann <arnd@arndb.de>, Olof Johansson <olof@lixom.net>,
        arm@kernel.org, soc@kernel.org, Nishanth Menon <nm@ti.com>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Tero Kristo <kristo@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH v2 35/48] arm64: dts: ti: align gpio-key node names with dtschema
Date:   Thu,  9 Jun 2022 13:40:22 +0200
Message-Id: <20220609114026.380682-6-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220609113721.379932-1-krzysztof.kozlowski@linaro.org>
References: <20220609113721.379932-1-krzysztof.kozlowski@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The node names should be generic and DT schema expects certain pattern
(e.g. with key/button/switch).

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 arch/arm64/boot/dts/ti/k3-am654-base-board.dts        | 4 ++--
 arch/arm64/boot/dts/ti/k3-j721e-common-proc-board.dts | 4 ++--
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/arm64/boot/dts/ti/k3-am654-base-board.dts b/arch/arm64/boot/dts/ti/k3-am654-base-board.dts
index 57497cb1ed68..31039f7e36ac 100644
--- a/arch/arm64/boot/dts/ti/k3-am654-base-board.dts
+++ b/arch/arm64/boot/dts/ti/k3-am654-base-board.dts
@@ -73,13 +73,13 @@ gpio-keys {
 		pinctrl-names = "default";
 		pinctrl-0 = <&push_button_pins_default>;
 
-		sw5 {
+		switch-5 {
 			label = "GPIO Key USER1";
 			linux,code = <BTN_0>;
 			gpios = <&wkup_gpio0 24 GPIO_ACTIVE_LOW>;
 		};
 
-		sw6 {
+		switch-6 {
 			label = "GPIO Key USER2";
 			linux,code = <BTN_1>;
 			gpios = <&wkup_gpio0 27 GPIO_ACTIVE_LOW>;
diff --git a/arch/arm64/boot/dts/ti/k3-j721e-common-proc-board.dts b/arch/arm64/boot/dts/ti/k3-j721e-common-proc-board.dts
index 2bc26a296496..b1691ac3442d 100644
--- a/arch/arm64/boot/dts/ti/k3-j721e-common-proc-board.dts
+++ b/arch/arm64/boot/dts/ti/k3-j721e-common-proc-board.dts
@@ -26,13 +26,13 @@ gpio_keys: gpio-keys {
 		pinctrl-names = "default";
 		pinctrl-0 = <&sw10_button_pins_default &sw11_button_pins_default>;
 
-		sw10: sw10 {
+		sw10: switch-10 {
 			label = "GPIO Key USER1";
 			linux,code = <BTN_0>;
 			gpios = <&main_gpio0 0 GPIO_ACTIVE_LOW>;
 		};
 
-		sw11: sw11 {
+		sw11: switch-11 {
 			label = "GPIO Key USER2";
 			linux,code = <BTN_1>;
 			gpios = <&wkup_gpio0 7 GPIO_ACTIVE_LOW>;
-- 
2.34.1

