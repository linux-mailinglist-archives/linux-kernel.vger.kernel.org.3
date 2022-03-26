Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DFCBD4E806A
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Mar 2022 11:27:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232517AbiCZK3E (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 26 Mar 2022 06:29:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53828 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231652AbiCZK3C (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 26 Mar 2022 06:29:02 -0400
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com [IPv6:2a00:1450:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 872CA1C931;
        Sat, 26 Mar 2022 03:27:22 -0700 (PDT)
Received: by mail-ej1-x632.google.com with SMTP id r13so19720966ejd.5;
        Sat, 26 Mar 2022 03:27:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=4ITgASCxQT302s/bxx026+0Ar86LJl3YrM5DNTNIgaE=;
        b=jt8a90MHRmQFxGOT55vbTf2XBG6bFQdgQIY7EKDh26oCbD4mz0R6q7O6c54f3wSMBt
         ZOETBacl+LJVn3iZgrMJag45qz1D4pjkaiaLA9ZBWcFhVw6/mschnZli2N8gWlZDjLpE
         tQDf7+xbQ3eqrY/VnWuYJTyljlB98Zb7anxDqrZgICBqDqBvIhz43M2N3kELtHDjhnsR
         NRwm0eqHcI2uKQgHQ+n73eww9MwUhKMXBDMcmbm9B7lzHZKUVA+qwwPsJfqk3IfnFUO1
         h5YnaS6H0SBSirwr/quKGcuPEEhHrMyptC5d+xR5jNX5emf5btowYivK5gQ3Sy5bzKpC
         4tvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=4ITgASCxQT302s/bxx026+0Ar86LJl3YrM5DNTNIgaE=;
        b=EyDso+NQgwqnrvQqVcnuyPLdfLVkGgGrnBFrLDjQ5STP3Yz85+ZUgo2g82FgRNiN0d
         QzR2pIGXv2ZWJG22wj+zNUabaHNXtZuwXx1M9S3xebHGUuGnmUB7KeDgT3w3a+yyopSM
         NOEJ7kugIkolCQs6B2zDfcmvbbVRUkEhwJH2UG6j5HnLQbSi/nGZTkPW+MWMa/qrekIP
         6ber4lBKicbgUTZgG5HC9iztvkYPihhBuRkjMvs4In89EATe1zdt8Djg56y3YUsgAQXW
         tHF4fcMwjtoW4Klfhza2s4RUTb5uFLISeTZvSvdNRRrr3g99SU76v52a2edcrVQ2m3z+
         GGzg==
X-Gm-Message-State: AOAM531Y2NfFiO1UyYjspmYygI0kUtAPHY4E19xP3/8dj7Zk2oRsh4y4
        ZsG+uxH7iNR+G4hcrkVtDYGu1v/Ss48=
X-Google-Smtp-Source: ABdhPJzq1WkwqLO43pcA+a6Qy/zbc6SmIkwV1rMZxHyewHF9VYllCXVeOkt+feagcqO6aUnS+kH2sA==
X-Received: by 2002:a17:907:b590:b0:6c1:c061:d945 with SMTP id qx16-20020a170907b59000b006c1c061d945mr16549763ejc.768.1648290441056;
        Sat, 26 Mar 2022 03:27:21 -0700 (PDT)
Received: from debian.home (81-204-249-205.fixed.kpn.net. [81.204.249.205])
        by smtp.gmail.com with ESMTPSA id g23-20020a17090670d700b006ccfd4163f7sm3209021ejk.206.2022.03.26.03.27.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 26 Mar 2022 03:27:20 -0700 (PDT)
From:   Johan Jonker <jbx6244@gmail.com>
To:     heiko@sntech.de
Cc:     robh+dt@kernel.org, krzk+dt@kernel.org, mturquette@baylibre.com,
        sboyd@kernel.org, linux-clk@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH v1 1/3] dt-bindings: clock: fix some conversion issues for rockchip,rk3399-cru.yaml
Date:   Sat, 26 Mar 2022 11:27:10 +0100
Message-Id: <20220326102712.20906-1-jbx6244@gmail.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

With the conversion of rockchip,rk3399-cru.txt some issues were added,
so fix them:

Changed:
  Align the table with external clocks.
  Remove the original author in 2016 as maintainer.
  Change clocks maxItems.
  Add clock-names.
  Use clock-controller node name in example.
  Remove assigned-xxx.
  Remove ">" from description.

Signed-off-by: Johan Jonker <jbx6244@gmail.com>
---
 .../bindings/clock/rockchip,rk3399-cru.yaml   | 32 +++++++------------
 1 file changed, 11 insertions(+), 21 deletions(-)

diff --git a/Documentation/devicetree/bindings/clock/rockchip,rk3399-cru.yaml b/Documentation/devicetree/bindings/clock/rockchip,rk3399-cru.yaml
index 72b286a1b..c2763e694 100644
--- a/Documentation/devicetree/bindings/clock/rockchip,rk3399-cru.yaml
+++ b/Documentation/devicetree/bindings/clock/rockchip,rk3399-cru.yaml
@@ -7,7 +7,6 @@ $schema: http://devicetree.org/meta-schemas/core.yaml#
 title: Rockchip RK3399 Clock and Reset Unit
 
 maintainers:
-  - Xing Zheng <zhengxing@rock-chips.com>
   - Heiko Stuebner <heiko@sntech.de>
 
 description: |
@@ -22,11 +21,11 @@ description: |
   There are several clocks that are generated outside the SoC. It is expected
   that they are defined using standard clock bindings with following
   clock-output-names:
-    - "xin24m" - crystal input - required,
-    - "xin32k" - rtc clock - optional,
-    - "clkin_gmac" - external GMAC clock - optional,
-    - "clkin_i2s" - external I2S clock - optional,
-    - "pclkin_cif" - external ISP clock - optional,
+    - "xin24m"           - crystal input                          - required,
+    - "xin32k"           - rtc clock                              - optional,
+    - "clkin_gmac"       - external GMAC clock                    - optional,
+    - "clkin_i2s"        - external I2S clock                     - optional,
+    - "pclkin_cif"       - external ISP clock                     - optional,
     - "clk_usbphy0_480m" - output clock of the pll in the usbphy0
     - "clk_usbphy1_480m" - output clock of the pll in the usbphy1
 
@@ -46,24 +45,15 @@ properties:
     const: 1
 
   clocks:
-    minItems: 1
-
-  assigned-clocks:
-    minItems: 1
-    maxItems: 64
-
-  assigned-clock-parents:
-    minItems: 1
-    maxItems: 64
+    maxItems: 1
 
-  assigned-clock-rates:
-    minItems: 1
-    maxItems: 64
+  clock-names:
+    const: xin24m
 
   rockchip,grf:
     $ref: /schemas/types.yaml#/definitions/phandle
-    description: >
-      phandle to the syscon managing the "general register files". It is used
+    description:
+      Phandle to the syscon managing the "general register files". It is used
       for GRF muxes, if missing any muxes present in the GRF will not be
       available.
 
@@ -77,7 +67,7 @@ additionalProperties: false
 
 examples:
   - |
-    pmucru: pmu-clock-controller@ff750000 {
+    pmucru: clock-controller@ff750000 {
       compatible = "rockchip,rk3399-pmucru";
       reg = <0xff750000 0x1000>;
       #clock-cells = <1>;
-- 
2.20.1

