Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C7D2C58D7FC
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Aug 2022 13:22:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241040AbiHILWX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 Aug 2022 07:22:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48222 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237496AbiHILWU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Aug 2022 07:22:20 -0400
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com [IPv6:2a00:1450:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 037BB1EEC1
        for <linux-kernel@vger.kernel.org>; Tue,  9 Aug 2022 04:22:18 -0700 (PDT)
Received: by mail-ej1-x634.google.com with SMTP id a7so21649555ejp.2
        for <linux-kernel@vger.kernel.org>; Tue, 09 Aug 2022 04:22:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sartura-hr.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=bs2fGCCkc2i9GgsvwKl491tj5ookRO+wJSTW2OEqR3M=;
        b=VJb9zJ/PZhORR9RBOkdVYOzLGPQtXBAhAx60nCXdVCdzLiU5rxjtt9t3SP68aJzPLf
         mJtLb2jPrL39bWcQUUUMs843YToAwhK13dbbbj4mugqcp+qRSO20fHbDAXmU8TRauV/F
         nSguaulCuRFKGL9hyMQm3T9Ch7pXUqseq5Wfm0Y6nIsWbf3MygTRna/8P79qNZZgePQQ
         aojxIxk4+gTbCDuFqFOZO1Yc/mR+nvQPeXNUs+71y0K5l7zEIxephLNe8A3pkvFsamuc
         dMW169eVljYxqeZ5aG/EFYGuVK7+yWIdsDuf2iKg0utAcZ7dWpAcelr9GRAmYz+bwd2M
         SupA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=bs2fGCCkc2i9GgsvwKl491tj5ookRO+wJSTW2OEqR3M=;
        b=3h61/8LNx/VLekGMdguUFPR4aIAQp1pvDAxe3KvjZ2TKEWJh8XCop7nCaFToFyR5MW
         wIaoS8hAKLd8DsY33uGtjv/CgXiKa6rerKW/VgPO4ZSYpfGotIk3EDV6oUmBv9X79Y2o
         VFax/JLS9gGqFWipG7rRwMH+g4kHSxapIBVMq+AmCp5prBaxoLVJujHwT4dfhItL8FPT
         TeqMozLd6Sf1/uoGOCPhdF0BF7xuQuM9x4/gSE3XIOnNaKwQGpHqGHxjP3bvuQxTc2si
         qAco2+xJ2mI2w3ep5/ZEHTtJnbZeOMOM5WstKeRjfjXG/6zhDhqgNrVEo5ukdn0lquDV
         SfRg==
X-Gm-Message-State: ACgBeo3+icyZtAC+9SLXEDjgEPvPMP2mOaobGyjUGz2yW8Fur3og8gK7
        /fDyiakgOg1z4YJW9kPLUr9liyfLPDzAcw==
X-Google-Smtp-Source: AA6agR78Z7HuD7og8dYS+mFbUdm3BH5S3Gw88EcrwaztVepcpvssJmeElwyEOWkYNPDlYQlEuuuWGA==
X-Received: by 2002:a17:907:9491:b0:72f:2827:37c3 with SMTP id dm17-20020a170907949100b0072f282737c3mr16629419ejc.306.1660044136529;
        Tue, 09 Aug 2022 04:22:16 -0700 (PDT)
Received: from fedora.robimarko.hr (cpe-188-129-118-148.dynamic.amis.hr. [188.129.118.148])
        by smtp.googlemail.com with ESMTPSA id me25-20020a170906aed900b007317f017e64sm1007581ejb.134.2022.08.09.04.22.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Aug 2022 04:22:16 -0700 (PDT)
From:   Robert Marko <robert.marko@sartura.hr>
To:     jdelvare@suse.com, linux@roeck-us.net, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, lars.povlsen@microchip.com,
        Steen.Hegelund@microchip.com, UNGLinuxDriver@microchip.com,
        linux-hwmon@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     luka.perkov@sartura.hr, Robert Marko <robert.marko@sartura.hr>
Subject: [PATCH 1/2] dt-bindings: hwmon: sparx5: use correct clock
Date:   Tue,  9 Aug 2022 13:22:08 +0200
Message-Id: <20220809112209.241045-1-robert.marko@sartura.hr>
X-Mailer: git-send-email 2.37.1
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

So, correct the clock description as well the included example.

[1] https://microchip-ung.github.io/sparx-5_reginfo/reginfo_sparx-5.html?select=hsiowrap,temp_sensor,temp_sensor_cfg,clk_cycles_1us

Fixes: f5520753c16f ("dt-bindings: hwmon: Add Sparx5 temperature sensor")
Signed-off-by: Robert Marko <robert.marko@sartura.hr>
---
 .../devicetree/bindings/hwmon/microchip,sparx5-temp.yaml      | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/hwmon/microchip,sparx5-temp.yaml b/Documentation/devicetree/bindings/hwmon/microchip,sparx5-temp.yaml
index 76be625d5646..51e8619dbf3c 100644
--- a/Documentation/devicetree/bindings/hwmon/microchip,sparx5-temp.yaml
+++ b/Documentation/devicetree/bindings/hwmon/microchip,sparx5-temp.yaml
@@ -22,7 +22,7 @@ properties:
 
   clocks:
     items:
-      - description: AHB reference clock
+      - description: System reference clock
 
   '#thermal-sensor-cells':
     const: 0
@@ -40,5 +40,5 @@ examples:
         compatible = "microchip,sparx5-temp";
         reg = <0x10508110 0xc>;
         #thermal-sensor-cells = <0>;
-        clocks = <&ahb_clk>;
+        clocks = <&sys_clk>;
     };
-- 
2.37.1

