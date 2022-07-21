Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AB59257D25C
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Jul 2022 19:21:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231161AbiGURVe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Jul 2022 13:21:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49116 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229691AbiGURV1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Jul 2022 13:21:27 -0400
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com [IPv6:2a00:1450:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 07EF22B613
        for <linux-kernel@vger.kernel.org>; Thu, 21 Jul 2022 10:21:26 -0700 (PDT)
Received: by mail-wr1-x430.google.com with SMTP id k11so2760895wrx.5
        for <linux-kernel@vger.kernel.org>; Thu, 21 Jul 2022 10:21:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=conchuod.ie; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=FRltm9CBKXROfT3TUcmTyCGbNeVKq4rgRYEpJSVmOTw=;
        b=BE/cWNCZlI0Yl2QqiuxKv8xSMdjJtWyLI/XATrhxomnVoulKNVnl6BscEEGiBjoi9J
         BZOY1voXavMn91Z/eD4KGNkYrKldYtbHnOVL31JiY9igICQa28VuBFpx1hmSWvjqUBMi
         EAF89C6f9VFQib4yYUeWDY4QnawWxcEGZaqJxhodUJRAMPnLNgBM1MsV8JAH3Pm8Q/K3
         QLWhvk4FjCGQ8/NuTqbwo4jLB77Q/+7i44oo4RfpKwLjr/T9JMa90ra6huIGyOmB+4rE
         rnWdSdTKQ60CBLLWjeIuFgpJMUz3Ao57HKpHTsKgf5FKN+P/m5U1ukj43M+l8uMN9ZR0
         BWog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=FRltm9CBKXROfT3TUcmTyCGbNeVKq4rgRYEpJSVmOTw=;
        b=LRUgR+oDjvJPTVXVfKuin20CSVu55b8/7gd6npcSgucv8Ie1W1XkmBhhumyfbFEDxi
         5jkrmBqYcYfneOqytL0jQfgKcRkBKVgpjQ+o4iMn5/OKtpcL7779gATqvm9yK0bz48yU
         7Z6GbQ1ETvFnx8oBId0WinBgSqN2blvdVjvq7y8Sm4SblIQqTZOEYwh5XoQvi5V7csVE
         m0ZEHAgZHdoMNUr8exFxEtjaDTpPLrW3pEkM5685vxWxe6O6TwxEBGaU6OgjFZcFkMKs
         KpObdtAQQl5cWjSOf7uvna9AIBNc/otCFBj4xgugeVrNlXNwr3m6IZroz2nAcsuAt0iy
         nomg==
X-Gm-Message-State: AJIora/SCmY75LL+AEnIudq6qtz3yQ881XLcYyhrxjtJDvLTiUaALLWp
        Yrso/fjTYEWQpnVF2UPWUwGKVg==
X-Google-Smtp-Source: AGRyM1vbAYGz2xsyca/zeMEjF8XABXoOModC93BUJZC9+XeAjfvxiTzDa0Td1Cv679XzakodtlQW7A==
X-Received: by 2002:a05:6000:609:b0:21d:92ad:562 with SMTP id bn9-20020a056000060900b0021d92ad0562mr34175479wrb.369.1658424084463;
        Thu, 21 Jul 2022 10:21:24 -0700 (PDT)
Received: from henark71.. ([109.76.125.251])
        by smtp.gmail.com with ESMTPSA id e24-20020a05600c219800b003a2cf1535aasm2455697wme.17.2022.07.21.10.21.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Jul 2022 10:21:23 -0700 (PDT)
From:   Conor Dooley <mail@conchuod.ie>
To:     u.kleine-koenig@pengutronix.de
Cc:     conor.dooley@microchip.com, daire.mcnamara@microchip.com,
        devicetree@vger.kernel.org, krzysztof.kozlowski+dt@linaro.org,
        lee.jones@linaro.org, linux-kernel@vger.kernel.org,
        linux-pwm@vger.kernel.org, linux-riscv@lists.infradead.org,
        robh+dt@kernel.org, thierry.reding@gmail.com
Subject: [PATCH v7 2/4] riscv: dts: fix the icicle's #pwm-cells
Date:   Thu, 21 Jul 2022 18:21:08 +0100
Message-Id: <20220721172109.941900-3-mail@conchuod.ie>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20220721172109.941900-1-mail@conchuod.ie>
References: <20220721172109.941900-1-mail@conchuod.ie>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Conor Dooley <conor.dooley@microchip.com>

\#pwm-cells for the Icicle kit's fabric PWM was incorrectly set to 2 &
blindly overridden by the (out of tree) driver anyway. The core can
support inverted operation, so update the entry to correctly report its
capabilities.

Fixes: 72560c6559b8 ("riscv: dts: microchip: add fpga fabric section to icicle kit")
Signed-off-by: Conor Dooley <conor.dooley@microchip.com>
---
 arch/riscv/boot/dts/microchip/mpfs-icicle-kit-fabric.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/riscv/boot/dts/microchip/mpfs-icicle-kit-fabric.dtsi b/arch/riscv/boot/dts/microchip/mpfs-icicle-kit-fabric.dtsi
index 0d28858b83f2..e09a13aef268 100644
--- a/arch/riscv/boot/dts/microchip/mpfs-icicle-kit-fabric.dtsi
+++ b/arch/riscv/boot/dts/microchip/mpfs-icicle-kit-fabric.dtsi
@@ -8,7 +8,7 @@ core_pwm0: pwm@41000000 {
 		compatible = "microchip,corepwm-rtl-v4";
 		reg = <0x0 0x41000000 0x0 0xF0>;
 		microchip,sync-update-mask = /bits/ 32 <0>;
-		#pwm-cells = <2>;
+		#pwm-cells = <3>;
 		clocks = <&fabric_clk3>;
 		status = "disabled";
 	};
-- 
2.37.1

