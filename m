Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2CEC653457B
	for <lists+linux-kernel@lfdr.de>; Wed, 25 May 2022 23:01:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344424AbiEYVBP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 May 2022 17:01:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48200 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232245AbiEYVBB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 May 2022 17:01:01 -0400
Received: from mail-oa1-f42.google.com (mail-oa1-f42.google.com [209.85.160.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B977BBA55E;
        Wed, 25 May 2022 14:01:00 -0700 (PDT)
Received: by mail-oa1-f42.google.com with SMTP id 586e51a60fabf-f2cd424b9cso1778590fac.7;
        Wed, 25 May 2022 14:01:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=V2DEce3yf8Bq8D8CEXpzcdntBLjIJseRwV+OWWl1tVA=;
        b=P589UFF6O/n6814+n9r2o91aMLQCSQbr/y27tPlrgivUUBmjHwG7JWvDYnpIKHMfCp
         +7onFl7ywJeyeQvOteB3VTvLEUqFOZtymVQnZslNpY42iGQOFwpmTLiM1vLy4LzDs3ya
         DuhBPZpp/sYS98hTfdnjudvwFTelb68hcTZVw6SXfjnO6UDC/RvT8tY2Co/aj2A/j4X1
         uDzN0En599S41aOjfPX1EanoSMTtSUYVP/S6e+b1bjYjFVf1OC/o+uSp1fudWTKe1X/m
         W68l91jDrMjQEsT/3rA5b7rNonI7NzKt8FBQHt740i9O4KClGRXuMDI4DDWo0xvoRt7C
         Nv3A==
X-Gm-Message-State: AOAM531lREKxhuRnXHHgZrJLW3b9Gqnxd4RuKNnEH3YoMr9m7kewTZo0
        hznbF8DjLdA83dCuegg2sQXE/6x0Ig==
X-Google-Smtp-Source: ABdhPJwDI6vnmIjILt2FYz6J9nEAMoufgBi+0k3uylK50VLk+6BYH3YU9OOsQ8X/Eu+Ce+MjAHVSGQ==
X-Received: by 2002:a05:6870:e991:b0:f2:cd2b:f82 with SMTP id r17-20020a056870e99100b000f2cd2b0f82mr1463756oao.81.1653512459991;
        Wed, 25 May 2022 14:00:59 -0700 (PDT)
Received: from xps15.. (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.googlemail.com with ESMTPSA id k22-20020a056870959600b000f2c0ec657asm1110201oao.0.2022.05.25.14.00.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 May 2022 14:00:59 -0700 (PDT)
From:   Rob Herring <robh@kernel.org>
To:     Serge Semin <fancer.lancer@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Pratyush Yadav <p.yadav@ti.com>
Cc:     linux-spi@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] spi: dt-bindings: Move 'rx-sample-delay-ns' to spi-peripheral-props.yaml
Date:   Wed, 25 May 2022 16:00:53 -0500
Message-Id: <20220525210053.2488756-1-robh@kernel.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SPI bus per device properties must be defined in spi-peripheral-props.yaml
for unevaluatedProperties checks to work correctly on device nodes.

This has the side effect of promoting 'rx-sample-delay-ns' to be a
common property, but functionally it's no different if it was defined in
a Synopsys specific schema file.

Signed-off-by: Rob Herring <robh@kernel.org>
---
 .../bindings/spi/snps,dw-apb-ssi.yaml          | 18 +++++++++---------
 .../bindings/spi/spi-peripheral-props.yaml     |  5 +++++
 2 files changed, 14 insertions(+), 9 deletions(-)

diff --git a/Documentation/devicetree/bindings/spi/snps,dw-apb-ssi.yaml b/Documentation/devicetree/bindings/spi/snps,dw-apb-ssi.yaml
index d7e08b03e204..e25d44c218f2 100644
--- a/Documentation/devicetree/bindings/spi/snps,dw-apb-ssi.yaml
+++ b/Documentation/devicetree/bindings/spi/snps,dw-apb-ssi.yaml
@@ -124,9 +124,16 @@ properties:
 
   rx-sample-delay-ns:
     default: 0
-    description: Default value of the rx-sample-delay-ns property.
+    description: |
+      Default value of the rx-sample-delay-ns property.
       This value will be used if the property is not explicitly defined
-      for a SPI slave device. See below.
+      for a SPI slave device.
+
+      SPI Rx sample delay offset, unit is nanoseconds.
+      The delay from the default sample time before the actual sample of the
+      rxd input signal occurs. The "rx_sample_delay" is an optional feature
+      of the designware controller, and the upper limit is also subject to
+      controller configuration.
 
 patternProperties:
   "^.*@[0-9a-f]+$":
@@ -142,13 +149,6 @@ patternProperties:
       spi-tx-bus-width:
         const: 1
 
-      rx-sample-delay-ns:
-        description: SPI Rx sample delay offset, unit is nanoseconds.
-          The delay from the default sample time before the actual
-          sample of the rxd input signal occurs. The "rx_sample_delay"
-          is an optional feature of the designware controller, and the
-          upper limit is also subject to controller configuration.
-
 unevaluatedProperties: false
 
 required:
diff --git a/Documentation/devicetree/bindings/spi/spi-peripheral-props.yaml b/Documentation/devicetree/bindings/spi/spi-peripheral-props.yaml
index 5e32928c4fc3..6ffb74352bef 100644
--- a/Documentation/devicetree/bindings/spi/spi-peripheral-props.yaml
+++ b/Documentation/devicetree/bindings/spi/spi-peripheral-props.yaml
@@ -71,6 +71,11 @@ properties:
     description:
       Delay, in microseconds, after a read transfer.
 
+  rx-sample-delay-ns:
+    description: SPI Rx sample delay offset, unit is nanoseconds.
+      The delay from the default sample time before the actual
+      sample of the rxd input signal occurs.
+
   spi-tx-bus-width:
     description:
       Bus width to the SPI bus used for write transfers.
-- 
2.34.1

