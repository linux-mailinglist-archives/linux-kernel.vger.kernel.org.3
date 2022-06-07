Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ED41D53FB63
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Jun 2022 12:34:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241122AbiFGKeW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Jun 2022 06:34:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35262 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241056AbiFGKeA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Jun 2022 06:34:00 -0400
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com [IPv6:2a00:1450:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3BA28633B6
        for <linux-kernel@vger.kernel.org>; Tue,  7 Jun 2022 03:33:58 -0700 (PDT)
Received: by mail-ed1-x52d.google.com with SMTP id n28so22385084edb.9
        for <linux-kernel@vger.kernel.org>; Tue, 07 Jun 2022 03:33:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Dd5lO9Nyjz5AIRsYXG5NRUO/Ey6wa6UMhXyIeGlXUg0=;
        b=eZ6zeZZ2EJE8La1tHTQRdXBqpjs9sLbmwiyFygah/R0STfz9IA9xJlM1ALwVvS0ZKM
         j+K6j0ZRInMppXB/nIrtjRlBELBn70UcO4wOgD/3Ug0va7aM0ezd4TiX+B8XCs2BPh22
         pM99RZY0ZVmvE3PDSCceaIwQnRkO6ocWzPIkP5LQR8HrrbrgUOsOMG5gfFojf91iqaIY
         EOaL1DP1KxcIUiCpdeaPUmeMx614Ug7kCj40w3htPVQwF89eNhkN6P4+AiWUD4eJH53r
         JnwPKsoXkrFUCwDBXRjWAq0+CffMfPTxeXP94JOrA4dfD/gN7R+BqLQT+rZLMVzB+NXx
         pIeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Dd5lO9Nyjz5AIRsYXG5NRUO/Ey6wa6UMhXyIeGlXUg0=;
        b=rWU2a968J9tsRWTN5NDxJtavQK4327hV8p2QON3zVXTNBqXL3LPcKOmDnbwzOE8jgO
         11rwnJ11ux6pQY/m1g/Z83rl2oTebFYPv8/+lUwsn1Wa+qpLpM+wfdylP6KlTUP3Ps5b
         v70xAj7M2y+fpenC+DH80TlT/hrDZw/F5seHfjnUWgqqlxi/Vx8H2WGZWu9vrNgDE53g
         zvlxGHA0tVATJ0736U7a26ZrOw0eMwLcqu529Bv1fzX1s3LgWLPc1ymgOyKeuo7salqM
         7ZsCr+6cJoakQgRZ31Yspi/7bWyej78QGOU9r+E0b5+6jDjVsV30hSD75ySTaVLt3Fq+
         qD8g==
X-Gm-Message-State: AOAM530E6C9cFW+YC+2EwuqhKdEVAnqd7xNamDMBorIKKzXplkbA56z2
        x1l3ucth+vLxZzy+4yNXoYnpoA==
X-Google-Smtp-Source: ABdhPJysACnYbT6jYK986UaQkNbOsugihS+ByBfYL0WLeGEzZeKBUa1usxw/dPC6ne5JQAu+AkTpvQ==
X-Received: by 2002:aa7:da10:0:b0:42d:d47e:87ad with SMTP id r16-20020aa7da10000000b0042dd47e87admr34042977eds.161.1654598037876;
        Tue, 07 Jun 2022 03:33:57 -0700 (PDT)
Received: from localhost.localdomain (xdsl-188-155-176-92.adslplus.ch. [188.155.176.92])
        by smtp.gmail.com with ESMTPSA id x4-20020a1709065ac400b00704fa2748ffsm7505359ejs.99.2022.06.07.03.33.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Jun 2022 03:33:57 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH 08/10] arm64: dts: qcom: sc7180-trogdor: add function to LED node
Date:   Tue,  7 Jun 2022 12:29:29 +0200
Message-Id: <20220607102931.102805-8-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220607102931.102805-1-krzysztof.kozlowski@linaro.org>
References: <20220607102931.102805-1-krzysztof.kozlowski@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add common LED property - the function - to LED node.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 arch/arm64/boot/dts/qcom/sc7180-trogdor.dtsi | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/sc7180-trogdor.dtsi b/arch/arm64/boot/dts/qcom/sc7180-trogdor.dtsi
index e55dbaa6dc12..fe43795f7be1 100644
--- a/arch/arm64/boot/dts/qcom/sc7180-trogdor.dtsi
+++ b/arch/arm64/boot/dts/qcom/sc7180-trogdor.dtsi
@@ -8,6 +8,7 @@
 #include <dt-bindings/gpio/gpio.h>
 #include <dt-bindings/input/gpio-keys.h>
 #include <dt-bindings/input/input.h>
+#include <dt-bindings/leds/common.h>
 #include <dt-bindings/regulator/qcom,rpmh-regulator.h>
 #include <dt-bindings/sound/sc7180-lpass.h>
 
@@ -355,6 +356,7 @@ pwmleds {
 		keyboard_backlight: keyboard-backlight {
 			status = "disabled";
 			label = "cros_ec::kbd_backlight";
+			function = LED_FUNCTION_KBD_BACKLIGHT;
 			pwms = <&cros_ec_pwm 0>;
 			max-brightness = <1023>;
 		};
-- 
2.34.1

