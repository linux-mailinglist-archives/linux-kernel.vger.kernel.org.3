Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D70945215E1
	for <lists+linux-kernel@lfdr.de>; Tue, 10 May 2022 14:50:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241979AbiEJMyG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 May 2022 08:54:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39682 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242005AbiEJMxu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 May 2022 08:53:50 -0400
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com [IPv6:2a00:1450:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 70F151C5E31
        for <linux-kernel@vger.kernel.org>; Tue, 10 May 2022 05:49:44 -0700 (PDT)
Received: by mail-ej1-x633.google.com with SMTP id n10so32724855ejk.5
        for <linux-kernel@vger.kernel.org>; Tue, 10 May 2022 05:49:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sartura-hr.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Ko9Su/75NK6EGUguCwaBtbcpvuAyD9W5527i5Vs8bj8=;
        b=vkHRuM8Glfb6j9kbNCUNjjMXs7byxOP6NGjLv6c5s+ySY+xZ7B4V9fEGEEVsVP7Sfi
         fs9CIACslyJ/DMfXvHVkXx4angd6aCBz63yhdCqeHyOYn1e/li/BRWLDuRY5lN2XRiGa
         HekaWiNf3L9IspMmFzRRpKdiKsblsaGCLUNpUnDGyRBqtqBsjgC3K+Ck9N2aRowoaHkx
         1eeUxDHKXF41q0UQR3livAhH36D3kFcHE3fqY0gqVcVjTZVQy7c1h3gNFGusOLsdyLGu
         FYmiyEypGT6lvgh/yarCeCEP/Bl5OVPx3gYPSfphZqBhnLQzG/fB5h77XGMMa7JBRJl2
         aXNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Ko9Su/75NK6EGUguCwaBtbcpvuAyD9W5527i5Vs8bj8=;
        b=yejGAbww9oX6slbj5vIeMF/tQNDXs7wEGe7hfBep4owfo3k3/Puhn+wL0NxKnK4tfY
         VGXgdwZk1cw9TzxJpUhLVLi9jtlQG3mwTCRQJuLVGvQp6nsmvVtG3YciKqyfbxqy2V1p
         W6QoobDf3YKDm6p8V2d7/0rf0q7Z/Tq/OyBiSqo0wKR1V/AT5pDV5NPA/yzNOW0LMyey
         DIq1cLGtkiOzqT3rbYqLlyv71SibSSNY+TrnS1SbZVkTH8dGfPrC9zMlPpPPt/XXJlLB
         OHpv+xW78ngdvwCHKs4mFu/QYpXo/jlmO6Tn2AsIdu6xdJrMVu+ZG1Pj06fe1Lbo4hpe
         NuWQ==
X-Gm-Message-State: AOAM531O4YhO/KVLC0MRTLGJesphOI7lqw1EOVwCkOKIF+JC9UZeVn34
        aQlePTH7pQ85B8JUde0jm2IF9A==
X-Google-Smtp-Source: ABdhPJwOdo/C2PWDmt7clorHbZF3P4R0cZxx+vQ0G4a0Si/UIuCHrhVMXLwA1FJ1dTNoGCgBPFa1Tg==
X-Received: by 2002:a17:906:2989:b0:6f3:a215:8426 with SMTP id x9-20020a170906298900b006f3a2158426mr19522277eje.725.1652186982908;
        Tue, 10 May 2022 05:49:42 -0700 (PDT)
Received: from fedora.robimarko.hr (cpezg-94-253-144-75-cbl.xnet.hr. [94.253.144.75])
        by smtp.googlemail.com with ESMTPSA id gz14-20020a170907a04e00b006f3ef214e62sm6094290ejc.200.2022.05.10.05.49.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 May 2022 05:49:42 -0700 (PDT)
From:   Robert Marko <robert.marko@sartura.hr>
To:     robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        andrew@lunn.ch, gregory.clement@bootlin.com,
        sebastian.hesselbarth@gmail.com, kostap@marvell.com,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, pali@kernel.org,
        marek.behun@nic.cz
Cc:     Robert Marko <robert.marko@sartura.hr>
Subject: [PATCH v2 06/11] arm64: dts: marvell: uDPU: align LED-s with bindings
Date:   Tue, 10 May 2022 14:49:24 +0200
Message-Id: <20220510124929.91000-6-robert.marko@sartura.hr>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20220510124929.91000-1-robert.marko@sartura.hr>
References: <20220510124929.91000-1-robert.marko@sartura.hr>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

According to bindings they LED-s should be prefixed with "led" in this
use case, so fix accordingly.

Signed-off-by: Robert Marko <robert.marko@sartura.hr>
---
 arch/arm64/boot/dts/marvell/armada-3720-uDPU.dts | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/arch/arm64/boot/dts/marvell/armada-3720-uDPU.dts b/arch/arm64/boot/dts/marvell/armada-3720-uDPU.dts
index 4ae1688e6627..f216777acacc 100644
--- a/arch/arm64/boot/dts/marvell/armada-3720-uDPU.dts
+++ b/arch/arm64/boot/dts/marvell/armada-3720-uDPU.dts
@@ -31,32 +31,32 @@ leds {
 		pinctrl-names = "default";
 		compatible = "gpio-leds";
 
-		power1 {
+		led-power1 {
 			label = "udpu:green:power";
 			gpios = <&gpionb 11 GPIO_ACTIVE_LOW>;
 		};
 
-		power2 {
+		led-power2 {
 			label = "udpu:red:power";
 			gpios = <&gpionb 12 GPIO_ACTIVE_LOW>;
 		};
 
-		network1 {
+		led-network1 {
 			label = "udpu:green:network";
 			gpios = <&gpionb 13 GPIO_ACTIVE_LOW>;
 		};
 
-		network2 {
+		led-network2 {
 			label = "udpu:red:network";
 			gpios = <&gpionb 14 GPIO_ACTIVE_LOW>;
 		};
 
-		alarm1 {
+		led-alarm1 {
 			label = "udpu:green:alarm";
 			gpios = <&gpionb 15 GPIO_ACTIVE_LOW>;
 		};
 
-		alarm2 {
+		led-alarm2 {
 			label = "udpu:red:alarm";
 			gpios = <&gpionb 16 GPIO_ACTIVE_LOW>;
 		};
-- 
2.36.1

