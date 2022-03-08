Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E35DA4D2101
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Mar 2022 20:09:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349887AbiCHTKU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Mar 2022 14:10:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53358 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349867AbiCHTKN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Mar 2022 14:10:13 -0500
Received: from mail-pj1-x1035.google.com (mail-pj1-x1035.google.com [IPv6:2607:f8b0:4864:20::1035])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B9CBC3ED00
        for <linux-kernel@vger.kernel.org>; Tue,  8 Mar 2022 11:09:14 -0800 (PST)
Received: by mail-pj1-x1035.google.com with SMTP id e3so64482pjm.5
        for <linux-kernel@vger.kernel.org>; Tue, 08 Mar 2022 11:09:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=CsGRPn1RTvkupGAAJEbEsdTdGlxfOIkdU/en60yl6Co=;
        b=mgKXAFQ4DcX/1a7r7bAFsAYVjmDeEYTBoAMpZcn4yHQM8Eu18Wh6lmYhxEaccbaoyd
         zDqG6Es6KwnA1pQ3nHaWSEos12P648q6kj0hQ9rKLK7ulUl8sOI3npn4FI9GaxXRCP1i
         +Ild/F0DO1/IEUtd0iHaE+xPc8G6iu5h8SPp4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=CsGRPn1RTvkupGAAJEbEsdTdGlxfOIkdU/en60yl6Co=;
        b=yxv1CFB/4CZ0Q08ygJ9Qhew6WrNUiwJXtb47I58EK+eOcIVV/8NQ2Xzq4I7/6i8jtF
         KEiKZEN3DvytmqhvRwKACkUhD3svl0hOrFiloUYlyOchZL0cXUyFFeVdOrZOp/254ceL
         ZCjNjQvUXfIsRFnOVwPSqF7X4myDmCAKARU7BU7devvEA6kPmnnsKhAqj7ERvsL4nAzj
         tTcrYGjVeUM9wHSYFME8PpOH1tVRmFzSpTnVnP22kZrGO8a1KxgWAdgNuA9AolhOXUK5
         OdElzCPspzJYCFQbg5+hTtf+eLu2m0yvvPf392KYNnlR/dN+rvKVFS4YPJp7mfN+Nm/8
         M0MA==
X-Gm-Message-State: AOAM5332y4s49EX406AIv0hz10tXXoEtfTchzyG5wWnpg51LZlhuoWbm
        KB+MFCUGBTcWSJ2iXOdASsVYs9dZru582A==
X-Google-Smtp-Source: ABdhPJyQMWbvyaoH9dnDNrSe6aUqS9YI8RXfNjJHhLN2GiKD9PD9XY8LA+1ceJRCLl41SZLbongVtg==
X-Received: by 2002:a17:902:6a88:b0:151:f21d:b03e with SMTP id n8-20020a1709026a8800b00151f21db03emr9635642plk.33.1646766554234;
        Tue, 08 Mar 2022 11:09:14 -0800 (PST)
Received: from localhost ([2620:15c:202:201:b3e3:a188:cbfc:3a0e])
        by smtp.gmail.com with UTF8SMTPSA id p16-20020a056a000b5000b004f669806cd9sm21407488pfo.87.2022.03.08.11.09.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 08 Mar 2022 11:09:13 -0800 (PST)
From:   Brian Norris <briannorris@chromium.org>
To:     MyungJoo Ham <myungjoo.ham@samsung.com>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Rob Herring <robh+dt@kernel.org>,
        Heiko Stuebner <heiko@sntech.de>
Cc:     Derek Basehore <dbasehore@chromium.org>,
        devicetree@vger.kernel.org, linux-rockchip@lists.infradead.org,
        linux-kernel@vger.kernel.org, Lin Huang <hl@rock-chips.com>,
        linux-arm-kernel@lists.infradead.org, linux-pm@vger.kernel.org,
        Brian Norris <briannorris@chromium.org>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
Subject: [PATCH v4 02/15] dt-bindings: devfreq: rk3399_dmc: Deprecate unused/redundant properties
Date:   Tue,  8 Mar 2022 11:08:48 -0800
Message-Id: <20220308110825.v4.2.I5ba582cd678d34c03d647e5500db8e33b7524d66@changeid>
X-Mailer: git-send-email 2.35.1.616.g0bdcbb4464-goog
In-Reply-To: <20220308190901.3144566-1-briannorris@chromium.org>
References: <20220308190901.3144566-1-briannorris@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

These DRAM configuration properties are all handled in ARM Trusted
Firmware (and have been since the early days of this SoC), and there are
no in-tree users of the DMC binding yet. It's better to just defer to
firmware instead of maintaining this large list of properties.

There's also some confusion about units: many of these are specified in
MHz, but the downstream users and driver code are treating them as Hz, I
believe. Rather than straighten all that out, I just drop them.

Signed-off-by: Brian Norris <briannorris@chromium.org>
Reviewed-by: Rob Herring <robh@kernel.org>
Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
---

Changes in v4:
 * Add Reviewed-by

Changes in v3:
 * Add Reviewed-by

 .../rockchip,rk3399-dmc.yaml                  | 42 +++++++++----------
 1 file changed, 21 insertions(+), 21 deletions(-)

diff --git a/Documentation/devicetree/bindings/memory-controllers/rockchip,rk3399-dmc.yaml b/Documentation/devicetree/bindings/memory-controllers/rockchip,rk3399-dmc.yaml
index b32c03cb0c68..356bbe5db383 100644
--- a/Documentation/devicetree/bindings/memory-controllers/rockchip,rk3399-dmc.yaml
+++ b/Documentation/devicetree/bindings/memory-controllers/rockchip,rk3399-dmc.yaml
@@ -45,6 +45,7 @@ properties:
       finishes, a DCF interrupt is triggered.
 
   rockchip,ddr3_speed_bin:
+    deprecated: true
     $ref: /schemas/types.yaml#/definitions/uint32
     description:
       For values, reference include/dt-bindings/clock/rk3399-ddr.h. Selects the
@@ -91,6 +92,7 @@ properties:
       if bus is idle for standby_idle * DFI clock cycles.
 
   rockchip,dram_dll_dis_freq:
+    deprecated: true
     $ref: /schemas/types.yaml#/definitions/uint32
     description: |
       Defines the DDR3 DLL bypass frequency in MHz. When DDR frequency is less
@@ -98,6 +100,7 @@ properties:
       Note: if DLL was bypassed, the odt will also stop working.
 
   rockchip,phy_dll_dis_freq:
+    deprecated: true
     $ref: /schemas/types.yaml#/definitions/uint32
     description: |
       Defines the PHY dll bypass frequency in MHz (Mega Hz). When DDR frequency
@@ -105,6 +108,7 @@ properties:
       Note: PHY DLL and PHY ODT are independent.
 
   rockchip,auto_pd_dis_freq:
+    deprecated: true
     $ref: /schemas/types.yaml#/definitions/uint32
     description:
       Defines the auto PD disable frequency in MHz.
@@ -118,6 +122,7 @@ properties:
       disabled.
 
   rockchip,ddr3_drv:
+    deprecated: true
     $ref: /schemas/types.yaml#/definitions/uint32
     description:
       When the DRAM type is DDR3, this parameter defines the DRAM side drive
@@ -125,6 +130,7 @@ properties:
     default: 40
 
   rockchip,ddr3_odt:
+    deprecated: true
     $ref: /schemas/types.yaml#/definitions/uint32
     description:
       When the DRAM type is DDR3, this parameter defines the DRAM side ODT
@@ -132,6 +138,7 @@ properties:
     default: 120
 
   rockchip,phy_ddr3_ca_drv:
+    deprecated: true
     $ref: /schemas/types.yaml#/definitions/uint32
     description:
       When the DRAM type is DDR3, this parameter defines the phy side CA line
@@ -139,6 +146,7 @@ properties:
     default: 40
 
   rockchip,phy_ddr3_dq_drv:
+    deprecated: true
     $ref: /schemas/types.yaml#/definitions/uint32
     description:
       When the DRAM type is DDR3, this parameter defines the PHY side DQ line
@@ -146,6 +154,7 @@ properties:
     default: 40
 
   rockchip,phy_ddr3_odt:
+    deprecated: true
     $ref: /schemas/types.yaml#/definitions/uint32
     description:
       When the DRAM type is DDR3, this parameter defines the PHY side ODT
@@ -161,6 +170,7 @@ properties:
       disabled.
 
   rockchip,lpddr3_drv:
+    deprecated: true
     $ref: /schemas/types.yaml#/definitions/uint32
     description:
       When the DRAM type is LPDDR3, this parameter defines the DRAM side drive
@@ -168,6 +178,7 @@ properties:
     default: 34
 
   rockchip,lpddr3_odt:
+    deprecated: true
     $ref: /schemas/types.yaml#/definitions/uint32
     description:
       When the DRAM type is LPDDR3, this parameter defines the DRAM side ODT
@@ -175,6 +186,7 @@ properties:
     default: 240
 
   rockchip,phy_lpddr3_ca_drv:
+    deprecated: true
     $ref: /schemas/types.yaml#/definitions/uint32
     description:
       When the DRAM type is LPDDR3, this parameter defines the PHY side CA line
@@ -182,6 +194,7 @@ properties:
     default: 40
 
   rockchip,phy_lpddr3_dq_drv:
+    deprecated: true
     $ref: /schemas/types.yaml#/definitions/uint32
     description:
       When the DRAM type is LPDDR3, this parameter defines the PHY side DQ line
@@ -189,6 +202,7 @@ properties:
     default: 40
 
   rockchip,phy_lpddr3_odt:
+    deprecated: true
     $ref: /schemas/types.yaml#/definitions/uint32
     description:
       When dram type is LPDDR3, this parameter define the phy side odt
@@ -203,6 +217,7 @@ properties:
       disabled.
 
   rockchip,lpddr4_drv:
+    deprecated: true
     $ref: /schemas/types.yaml#/definitions/uint32
     description:
       When the DRAM type is LPDDR4, this parameter defines the DRAM side drive
@@ -210,6 +225,7 @@ properties:
     default: 60
 
   rockchip,lpddr4_dq_odt:
+    deprecated: true
     $ref: /schemas/types.yaml#/definitions/uint32
     description:
       When the DRAM type is LPDDR4, this parameter defines the DRAM side ODT on
@@ -217,6 +233,7 @@ properties:
     default: 40
 
   rockchip,lpddr4_ca_odt:
+    deprecated: true
     $ref: /schemas/types.yaml#/definitions/uint32
     description:
       When the DRAM type is LPDDR4, this parameter defines the DRAM side ODT on
@@ -224,6 +241,7 @@ properties:
     default: 40
 
   rockchip,phy_lpddr4_ca_drv:
+    deprecated: true
     $ref: /schemas/types.yaml#/definitions/uint32
     description:
       When the DRAM type is LPDDR4, this parameter defines the PHY side CA line
@@ -231,6 +249,7 @@ properties:
     default: 40
 
   rockchip,phy_lpddr4_ck_cs_drv:
+    deprecated: true
     $ref: /schemas/types.yaml#/definitions/uint32
     description:
       When the DRAM type is LPDDR4, this parameter defines the PHY side clock
@@ -238,6 +257,7 @@ properties:
     default: 80
 
   rockchip,phy_lpddr4_dq_drv:
+    deprecated: true
     $ref: /schemas/types.yaml#/definitions/uint32
     description:
       When the DRAM type is LPDDR4, this parameter defines the PHY side DQ line
@@ -245,6 +265,7 @@ properties:
     default: 80
 
   rockchip,phy_lpddr4_odt:
+    deprecated: true
     $ref: /schemas/types.yaml#/definitions/uint32
     description:
       When the DRAM type is LPDDR4, this parameter defines the PHY side ODT
@@ -274,33 +295,12 @@ examples:
       clock-names = "dmc_clk";
       operating-points-v2 = <&dmc_opp_table>;
       center-supply = <&ppvar_centerlogic>;
-      rockchip,ddr3_speed_bin = <21>;
       rockchip,pd_idle = <0x40>;
       rockchip,sr_idle = <0x2>;
       rockchip,sr_mc_gate_idle = <0x3>;
       rockchip,srpd_lite_idle = <0x4>;
       rockchip,standby_idle = <0x2000>;
-      rockchip,dram_dll_dis_freq = <300>;
-      rockchip,phy_dll_dis_freq = <125>;
-      rockchip,auto_pd_dis_freq = <666>;
       rockchip,ddr3_odt_dis_freq = <333>;
-      rockchip,ddr3_drv = <40>;
-      rockchip,ddr3_odt = <120>;
-      rockchip,phy_ddr3_ca_drv = <40>;
-      rockchip,phy_ddr3_dq_drv = <40>;
-      rockchip,phy_ddr3_odt = <240>;
       rockchip,lpddr3_odt_dis_freq = <333>;
-      rockchip,lpddr3_drv = <34>;
-      rockchip,lpddr3_odt = <240>;
-      rockchip,phy_lpddr3_ca_drv = <40>;
-      rockchip,phy_lpddr3_dq_drv = <40>;
-      rockchip,phy_lpddr3_odt = <240>;
       rockchip,lpddr4_odt_dis_freq = <333>;
-      rockchip,lpddr4_drv = <60>;
-      rockchip,lpddr4_dq_odt = <40>;
-      rockchip,lpddr4_ca_odt = <40>;
-      rockchip,phy_lpddr4_ca_drv = <40>;
-      rockchip,phy_lpddr4_ck_cs_drv = <80>;
-      rockchip,phy_lpddr4_dq_drv = <80>;
-      rockchip,phy_lpddr4_odt = <60>;
     };
-- 
2.35.1.616.g0bdcbb4464-goog

