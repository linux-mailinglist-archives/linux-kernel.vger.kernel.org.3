Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DF416544A99
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Jun 2022 13:41:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242867AbiFILkm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Jun 2022 07:40:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39410 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243978AbiFILkW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Jun 2022 07:40:22 -0400
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com [IPv6:2a00:1450:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE4EB1DE2F1
        for <linux-kernel@vger.kernel.org>; Thu,  9 Jun 2022 04:39:54 -0700 (PDT)
Received: by mail-ed1-x532.google.com with SMTP id v19so30804712edd.4
        for <linux-kernel@vger.kernel.org>; Thu, 09 Jun 2022 04:39:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Z0YNwH3n6PjIeqiCRdH4f7yYwMmdAgLu9xDerffdwL8=;
        b=kUR17GG84q6hCQJUB3Jwk7nEUm/YD6k+5F5oA1dajOpFX2gnQphROOBTGkRYxdjURL
         OFOYOfaNVInw8o9IL17hk9oRB+mbFJae6xn2ecIgiOlQLZ4JyTmh80Mdq9540Tp4Kvsj
         Kztvjfkt7qBMH61B1yi0VsVXE5tjPVo6Si++gUGxTdipP660vjgVZ7esQ5SXNuepKkvh
         jq3PbGD1R/hntODKPc+j7kwx/Jhj+pma/x+KWUQj15ORmsvt5BoxDOfcC4cXsb1b+ncd
         XAENwI7ChLHPRMhikZBohdOW/iFrQpOqSeaD1v7+ZmrCHuvrrebEwr2D15AD/yb3QDFd
         EyJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Z0YNwH3n6PjIeqiCRdH4f7yYwMmdAgLu9xDerffdwL8=;
        b=iihtVXipSjsUMc1rlLSDj9wa0ePQAxTRo9y6qistZiLWouj6uIZ9IhsrIYr+h8zVjf
         ZQd5UDve2g6kF2G4XafD1hLN0gVnoxKLyW0LkA4lxuZ/CGLenI18AatZ5ClC0K2mstEi
         SjWJdSZ6wjLHAE82/Sjk3SHmPONVexAjF41Xyg4fL7me0+js9Es235bVDFwF1SgJa9rD
         FTA4UY7Buwd3dfAN6LQ8Bgy2e4go0hmsyWlooKyNIy9RxBQn965XUph4ewIyR5Kc60NU
         lQqnC3lHtCRDb0xpuBJmfpRsZfRb2lDUuo8J7fGojxB9N6OKgHFOdnMqvOg8Qbx23UUn
         9SAw==
X-Gm-Message-State: AOAM530a6y/IDuXHyEdfzo8VKIR8kE7jeC1mUV1G/dCOC4RrsR0TPAcV
        yrvDtPhQ3KDHHiQQ+IYpbArrMQ==
X-Google-Smtp-Source: ABdhPJxuTqXWn9jMw8LX1nHZdeLpAzHoL0VJNRNgcmvZQR7MtWIU8k75RnzFOriBcJ7nj7Txl/gTVw==
X-Received: by 2002:a05:6402:369b:b0:431:665e:f91a with SMTP id ej27-20020a056402369b00b00431665ef91amr22678275edb.350.1654774793234;
        Thu, 09 Jun 2022 04:39:53 -0700 (PDT)
Received: from localhost.localdomain (xdsl-188-155-176-92.adslplus.ch. [188.155.176.92])
        by smtp.gmail.com with ESMTPSA id c10-20020a170906528a00b0070a80f03a44sm9460415ejm.119.2022.06.09.04.39.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Jun 2022 04:39:52 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Arnd Bergmann <arnd@arndb.de>, Olof Johansson <olof@lixom.net>,
        arm@kernel.org, soc@kernel.org, Andrew Lunn <andrew@lunn.ch>,
        Gregory Clement <gregory.clement@bootlin.com>,
        Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH v2 17/48] arm64: dts: marvell: align gpio-key node names with dtschema
Date:   Thu,  9 Jun 2022 13:39:36 +0200
Message-Id: <20220609113938.380466-8-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220609113721.379932-1-krzysztof.kozlowski@linaro.org>
References: <20220609113721.379932-1-krzysztof.kozlowski@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The node names should be generic and DT schema expects certain pattern
(e.g. with key/button/switch).

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 arch/arm64/boot/dts/marvell/armada-3720-turris-mox.dts     | 2 +-
 arch/arm64/boot/dts/marvell/armada-8040-clearfog-gt-8k.dts | 4 ++--
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/arm64/boot/dts/marvell/armada-3720-turris-mox.dts b/arch/arm64/boot/dts/marvell/armada-3720-turris-mox.dts
index caf9c8529fca..6721b9b4cf5c 100644
--- a/arch/arm64/boot/dts/marvell/armada-3720-turris-mox.dts
+++ b/arch/arm64/boot/dts/marvell/armada-3720-turris-mox.dts
@@ -45,7 +45,7 @@ red {
 	gpio-keys {
 		compatible = "gpio-keys";
 
-		reset {
+		key-reset {
 			label = "reset";
 			linux,code = <KEY_RESTART>;
 			gpios = <&gpiosb 20 GPIO_ACTIVE_LOW>;
diff --git a/arch/arm64/boot/dts/marvell/armada-8040-clearfog-gt-8k.dts b/arch/arm64/boot/dts/marvell/armada-8040-clearfog-gt-8k.dts
index 871f84b4a6ed..15f6ca4df121 100644
--- a/arch/arm64/boot/dts/marvell/armada-8040-clearfog-gt-8k.dts
+++ b/arch/arm64/boot/dts/marvell/armada-8040-clearfog-gt-8k.dts
@@ -94,7 +94,7 @@ keys {
 		pinctrl-0 = <&cp0_gpio_reset_pins &cp1_wps_button_pins>;
 		pinctrl-names = "default";
 
-		button_0 {
+		button-0 {
 			/* The rear button */
 			label = "Rear Button";
 			gpios = <&cp0_gpio2 7 GPIO_ACTIVE_LOW>;
@@ -102,7 +102,7 @@ button_0 {
 			linux,code = <BTN_0>;
 		};
 
-		button_1 {
+		button-1 {
 			/* The wps button */
 			label = "WPS Button";
 			gpios = <&cp1_gpio1 30 GPIO_ACTIVE_LOW>;
-- 
2.34.1

