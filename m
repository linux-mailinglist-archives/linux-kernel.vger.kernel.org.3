Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D2BFF58D7FD
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Aug 2022 13:22:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241145AbiHILW1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 Aug 2022 07:22:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48226 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240188AbiHILWU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Aug 2022 07:22:20 -0400
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com [IPv6:2a00:1450:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1BA3F1FCDD
        for <linux-kernel@vger.kernel.org>; Tue,  9 Aug 2022 04:22:19 -0700 (PDT)
Received: by mail-ed1-x529.google.com with SMTP id x21so14692507edd.3
        for <linux-kernel@vger.kernel.org>; Tue, 09 Aug 2022 04:22:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sartura-hr.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=pOc3Bz12pMayO94jwlOggCztVRhbn75rrJuEq+4iDRs=;
        b=5nanClqC7gUGBRKJRyyMG18QqI95z4Gf6/LlUYQBrhTiIWMxnbDYTfqUri3vFf2aP7
         c38UBafW7cy8UtpEilMVcJ/GzYRI4s2DwD7csWAYMF13Z2PIf4op3Zhq5rqLJEIqps/w
         aPXczj8EKwBpBHfDPH+yKAmMtwifXhRwajVGpKNVtDMMLR7dT/d0b0wra+JRhMRxCMrc
         Yyxa2cwKe1g1vqb4kApbYuQxiRtBnSprDT9WhC10dEZ//huH4mKYIMR6xLDeQnNZrriO
         iw/pkIm1RfABTPXduw06gYBtvQZDlH0wB9gU0um8bSruNWPSqvsfo/FIaTYTTwd7VeEb
         pnFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=pOc3Bz12pMayO94jwlOggCztVRhbn75rrJuEq+4iDRs=;
        b=r32d8CPtJsEM+rZ08i0qwr5VqTj8eTEkPg+VGk47aIgWTT0DUztknjkvIlR5t4vcvW
         2i0rhXX+hahnmkgeNq6Cbbz4cYKO8k9w+3FKZzt/kk6oDh747V2GD1duUYbt8sB2whBh
         oV8XAPyGzoaDxOb7QMcViU0s3KY859ehSLF9u5n49+uzlmiuitx1Ew1s/rAFeID59AFz
         GrUNuxLO+uQFoQ+O4sj4QTRR7XIziAcwfHiVnTZgjEtSwLE4XfGw7XYWMarDII1D/hab
         9QTlMdiMFzcw3M2Pt6YkOLBkMuw7PqtXizMiH/5YbeweVeaQgILNQw9AUHCUAy88/kUV
         M//g==
X-Gm-Message-State: ACgBeo3RsRmNLlGgpLtc/ZNW5bVi6urT6vd4hcbt6SW6vXDNjxNphkj+
        6g8U7iOZzGTWCGA5xTybkEBOUg==
X-Google-Smtp-Source: AA6agR7vtXurWB1a07/O+GNYr9tc4q9IST9idRSP6HWjaX2/KN7WGXZ7PlkRaaKef32KAQSZH/eAvw==
X-Received: by 2002:a05:6402:424d:b0:43e:95d8:eb46 with SMTP id g13-20020a056402424d00b0043e95d8eb46mr21158481edb.306.1660044137704;
        Tue, 09 Aug 2022 04:22:17 -0700 (PDT)
Received: from fedora.robimarko.hr (cpe-188-129-118-148.dynamic.amis.hr. [188.129.118.148])
        by smtp.googlemail.com with ESMTPSA id me25-20020a170906aed900b007317f017e64sm1007581ejb.134.2022.08.09.04.22.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Aug 2022 04:22:17 -0700 (PDT)
From:   Robert Marko <robert.marko@sartura.hr>
To:     jdelvare@suse.com, linux@roeck-us.net, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, lars.povlsen@microchip.com,
        Steen.Hegelund@microchip.com, UNGLinuxDriver@microchip.com,
        linux-hwmon@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     luka.perkov@sartura.hr, Robert Marko <robert.marko@sartura.hr>
Subject: [PATCH 2/2] arm64: dts: microchip: sparx5: use correct clock for tmon
Date:   Tue,  9 Aug 2022 13:22:09 +0200
Message-Id: <20220809112209.241045-2-robert.marko@sartura.hr>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20220809112209.241045-1-robert.marko@sartura.hr>
References: <20220809112209.241045-1-robert.marko@sartura.hr>
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

SparX-5 temperature sensor uses system reference clock and not the AHB bus
clock as indicated by the register information [1].

Configured number of system clock cycles in one 1us is now almost spot on
to the default register value.

[1] https://microchip-ung.github.io/sparx-5_reginfo/reginfo_sparx-5.html?select=hsiowrap,temp_sensor,temp_sensor_cfg,clk_cycles_1us

Fixes: d14f6a1ae07f ("arm64: dts: sparx5: Add hwmon temperature sensor")
Signed-off-by: Robert Marko <robert.marko@sartura.hr>
---
 arch/arm64/boot/dts/microchip/sparx5.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/microchip/sparx5.dtsi b/arch/arm64/boot/dts/microchip/sparx5.dtsi
index 6f6aab48516e..c9367127670b 100644
--- a/arch/arm64/boot/dts/microchip/sparx5.dtsi
+++ b/arch/arm64/boot/dts/microchip/sparx5.dtsi
@@ -421,7 +421,7 @@ tmon0: tmon@610508110 {
 			compatible = "microchip,sparx5-temp";
 			reg = <0x6 0x10508110 0xc>;
 			#thermal-sensor-cells = <0>;
-			clocks = <&ahb_clk>;
+			clocks = <&sys_clk>;
 		};
 
 		mdio0: mdio@6110102b0 {
-- 
2.37.1

