Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8A4D259E937
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Aug 2022 19:23:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232771AbiHWRWr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 Aug 2022 13:22:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56082 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241767AbiHWRVS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Aug 2022 13:21:18 -0400
Received: from mail-oi1-f174.google.com (mail-oi1-f174.google.com [209.85.167.174])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C266AC251;
        Tue, 23 Aug 2022 07:57:29 -0700 (PDT)
Received: by mail-oi1-f174.google.com with SMTP id s199so16320760oie.3;
        Tue, 23 Aug 2022 07:57:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc;
        bh=FAI+J/BAzIOCuYieqj21rHdsHuRaSuJ4Vj8kHpJSNAE=;
        b=Bguy5gXkBeLZqFWOQeDUzyvG2Dh1lvWQ5M1H3lAWbE8AeicHVgTcaeWv9P0JvKC750
         Gzr3ibcGK71O2EP+ihg6zRki7XD5NK6bVl0pxo8rFk7n+6xaH6pwSNLePhBalIf/j6do
         NZHLYH2uZUap4VEBxI1rnY7ImPaXe3PalgnoM984VJyXLz/9+BIINGt4RKGjkDhKvfxF
         x8BKI8XayQ3u3gHLmVSsjoI4VNW+XGbcep0j4xY9jl9tPpAfCMVwCJ7FX03Cnu+rNy46
         aLBSYCns9D1BUaU0sUG17eJgITTMZCl3mHHcGCvj11LcKoPh5Dp7fWsxraQ8W8a8E2Lj
         4ppA==
X-Gm-Message-State: ACgBeo3jpUgCtT7s9lWaZShSa36wPutKFi+YYKJxiW9ebI2VhFUFPanE
        ZYeq2R1KX23penPSt1gsYg==
X-Google-Smtp-Source: AA6agR4hSJQAGxX3KN7ayKSxhwLdWv6s8/qh4bhvrE5yHsP9wzSBH+Rc0HRRZkXNGG1/4mMLZExhJw==
X-Received: by 2002:aca:3056:0:b0:345:64e9:7435 with SMTP id w83-20020aca3056000000b0034564e97435mr1417894oiw.19.1661266648690;
        Tue, 23 Aug 2022 07:57:28 -0700 (PDT)
Received: from xps15.. (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.googlemail.com with ESMTPSA id t1-20020a056870600100b0011c65559b04sm3840637oaa.34.2022.08.23.07.57.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Aug 2022 07:57:28 -0700 (PDT)
From:   Rob Herring <robh@kernel.org>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Joel Stanley <joel@jms.id.au>,
        Andrew Jeffery <andrew@aj.id.au>,
        Xin Ji <xji@analogixsemi.com>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Amelie Delaunay <amelie.delaunay@foss.st.com>,
        Samuel Holland <samuel@sholland.org>
Cc:     linux-usb@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-aspeed@lists.ozlabs.org
Subject: [PATCH] dt-bindings: usb: Add missing (unevaluated|additional)Properties on child nodes
Date:   Tue, 23 Aug 2022 09:56:40 -0500
Message-Id: <20220823145649.3118479-9-robh@kernel.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In order to ensure only documented properties are present, node schemas
must have unevaluatedProperties or additionalProperties set to false
(typically).

Signed-off-by: Rob Herring <robh@kernel.org>
---
 .../devicetree/bindings/usb/analogix,anx7411.yaml    |  2 ++
 .../devicetree/bindings/usb/aspeed,usb-vhub.yaml     |  2 ++
 .../devicetree/bindings/usb/st,stusb160x.yaml        | 12 +++++++++---
 .../devicetree/bindings/usb/willsemi,wusb3801.yaml   |  1 +
 4 files changed, 14 insertions(+), 3 deletions(-)

diff --git a/Documentation/devicetree/bindings/usb/analogix,anx7411.yaml b/Documentation/devicetree/bindings/usb/analogix,anx7411.yaml
index ee436308e5dc..0e72c08e6566 100644
--- a/Documentation/devicetree/bindings/usb/analogix,anx7411.yaml
+++ b/Documentation/devicetree/bindings/usb/analogix,anx7411.yaml
@@ -23,6 +23,8 @@ properties:
   connector:
     type: object
     $ref: ../connector/usb-connector.yaml
+    unevaluatedProperties: false
+
     description:
       Properties for usb c connector.
 
diff --git a/Documentation/devicetree/bindings/usb/aspeed,usb-vhub.yaml b/Documentation/devicetree/bindings/usb/aspeed,usb-vhub.yaml
index 8b019ac05bbe..a86bcd95100e 100644
--- a/Documentation/devicetree/bindings/usb/aspeed,usb-vhub.yaml
+++ b/Documentation/devicetree/bindings/usb/aspeed,usb-vhub.yaml
@@ -67,6 +67,7 @@ properties:
 
   vhub-strings:
     type: object
+    additionalProperties: false
 
     properties:
       '#address-cells':
@@ -78,6 +79,7 @@ properties:
     patternProperties:
       '^string@[0-9a-f]+$':
         type: object
+        additionalProperties: false
         description: string descriptors of the specific language
 
         properties:
diff --git a/Documentation/devicetree/bindings/usb/st,stusb160x.yaml b/Documentation/devicetree/bindings/usb/st,stusb160x.yaml
index b5a8c9814dd3..b8974807b666 100644
--- a/Documentation/devicetree/bindings/usb/st,stusb160x.yaml
+++ b/Documentation/devicetree/bindings/usb/st,stusb160x.yaml
@@ -33,6 +33,7 @@ properties:
   connector:
     type: object
     $ref: /schemas/connector/usb-connector.yaml#
+    unevaluatedProperties: false
 
     properties:
       compatible:
@@ -74,9 +75,14 @@ examples:
                 data-role = "dual";
                 typec-power-opmode = "default";
 
-                port {
-                    typec_con_ep: endpoint {
-                        remote-endpoint = <&usbotg_hs_ep>;
+                ports {
+                    #address-cells = <1>;
+                    #size-cells = <0>;
+                    port@0 {
+                        reg = <0>;
+                        typec_con_ep: endpoint {
+                            remote-endpoint = <&usbotg_hs_ep>;
+                        };
                     };
                 };
             };
diff --git a/Documentation/devicetree/bindings/usb/willsemi,wusb3801.yaml b/Documentation/devicetree/bindings/usb/willsemi,wusb3801.yaml
index c2b2243c7892..5aa4ffd67119 100644
--- a/Documentation/devicetree/bindings/usb/willsemi,wusb3801.yaml
+++ b/Documentation/devicetree/bindings/usb/willsemi,wusb3801.yaml
@@ -28,6 +28,7 @@ properties:
   connector:
     type: object
     $ref: ../connector/usb-connector.yaml#
+    unevaluatedProperties: false
     description:
       The managed USB Type-C connector. Since WUSB3801 does not support
       Power Delivery, the node should have the "pd-disable" property.
-- 
2.34.1

