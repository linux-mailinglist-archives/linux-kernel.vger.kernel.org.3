Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9A4D14D6B32
	for <lists+linux-kernel@lfdr.de>; Sat, 12 Mar 2022 00:56:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229975AbiCKXtX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Mar 2022 18:49:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55270 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229606AbiCKXtV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Mar 2022 18:49:21 -0500
Received: from mail-oi1-f177.google.com (mail-oi1-f177.google.com [209.85.167.177])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9FE642E0;
        Fri, 11 Mar 2022 15:48:17 -0800 (PST)
Received: by mail-oi1-f177.google.com with SMTP id j83so11118148oih.6;
        Fri, 11 Mar 2022 15:48:17 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=x6lwOUs0d65LCqBi3QipuhYyxDJ9eIewRF/1SecNNVk=;
        b=yffyoz8VzCntSreC5fdhKB/KhtzaN3vp3KJDDSQVe1EJlWtKF0liID182gW2Mg0H7h
         GT6m8U9FmUUZm1kWhrr3esZODmRauWH9NERPQkfwhDy7V6n7bOPZQ0mKps0LMDMcnoNH
         9Tm2CMmtw1ZXLd+F1wrwqEMOBot/6CAiXX/pPlyjLmb4NUCxX5dDZ5cFX5epVosRe2rX
         1RGgXpDX9qUhmT4jVQ/BCpALhGtl9JsdtMHPZelyL/K+sJ42gwF4t6EoNnVkstQaFGq+
         Haf9o+d08O6EyONCCLlrKt+tJ+qHod5Lc+dq8+Lg2cK99pC18WvF2ZjHct0fDzCrTvnB
         2Ypg==
X-Gm-Message-State: AOAM531VtS2Lh6zAmJOj1zzmHZp/c1X3exqVqjay2IMPJ5UPJQG58ORh
        zB3PPD21MVX1RYy/daVIo94XPibe+Q==
X-Google-Smtp-Source: ABdhPJyvZ0r+1P93joNo0ptbuIsXbm7FYq3d7tYAdY68/bzI93gYnyJbwvMNDQDUCKsJKaNoyhXoNg==
X-Received: by 2002:a05:6808:2013:b0:2d9:dbed:6999 with SMTP id q19-20020a056808201300b002d9dbed6999mr14493688oiw.30.1647042496534;
        Fri, 11 Mar 2022 15:48:16 -0800 (PST)
Received: from xps15.. (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.googlemail.com with ESMTPSA id o21-20020a056870e81500b000d9b2ba714asm3942423oan.21.2022.03.11.15.48.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Mar 2022 15:48:15 -0800 (PST)
From:   Rob Herring <robh@kernel.org>
To:     Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Cc:     alsa-devel@alsa-project.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] ASoC: dt-bindings: Fix patternProperties with fixed strings
Date:   Fri, 11 Mar 2022 17:48:01 -0600
Message-Id: <20220311234802.417610-1-robh@kernel.org>
X-Mailer: git-send-email 2.32.0
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

The simple-audio-card and renesas,rsnd bindings used 'patternProperties'
with fixed strings to work-around a dtschema meta-schema limitation. This
is now fixed and the schemas can be fixed to use 'properties' instead.

Signed-off-by: Rob Herring <robh@kernel.org>
---
 .../bindings/sound/renesas,rsnd.yaml          | 16 ++++---
 .../bindings/sound/simple-card.yaml           | 42 +++++++++----------
 2 files changed, 28 insertions(+), 30 deletions(-)

diff --git a/Documentation/devicetree/bindings/sound/renesas,rsnd.yaml b/Documentation/devicetree/bindings/sound/renesas,rsnd.yaml
index c2930d65728e..e17c0245f77a 100644
--- a/Documentation/devicetree/bindings/sound/renesas,rsnd.yaml
+++ b/Documentation/devicetree/bindings/sound/renesas,rsnd.yaml
@@ -123,9 +123,7 @@ properties:
     $ref: audio-graph-port.yaml#
     unevaluatedProperties: false
 
-# use patternProperties to avoid naming "xxx,yyy" issue
-patternProperties:
-  "^rcar_sound,dvc$":
+  rcar_sound,dvc:
     description: DVC subnode.
     type: object
     patternProperties:
@@ -141,7 +139,7 @@ patternProperties:
           - dma-names
     additionalProperties: false
 
-  "^rcar_sound,mix$":
+  rcar_sound,mix:
     description: MIX subnode.
     type: object
     patternProperties:
@@ -150,7 +148,7 @@ patternProperties:
         # no properties
     additionalProperties: false
 
-  "^rcar_sound,ctu$":
+  rcar_sound,ctu:
     description: CTU subnode.
     type: object
     patternProperties:
@@ -159,7 +157,7 @@ patternProperties:
         # no properties
     additionalProperties: false
 
-  "^rcar_sound,src$":
+  rcar_sound,src:
     description: SRC subnode.
     type: object
     patternProperties:
@@ -182,7 +180,7 @@ patternProperties:
           - dma-names
     additionalProperties: false
 
-  "^rcar_sound,ssiu$":
+  rcar_sound,ssiu:
     description: SSIU subnode.
     type: object
     patternProperties:
@@ -202,7 +200,7 @@ patternProperties:
           - dma-names
     additionalProperties: false
 
-  "^rcar_sound,ssi$":
+  rcar_sound,ssi:
     description: SSI subnode.
     type: object
     patternProperties:
@@ -239,7 +237,7 @@ patternProperties:
     additionalProperties: false
 
   # For DAI base
-  "^rcar_sound,dai$":
+  rcar_sound,dai:
     description: DAI subnode.
     type: object
     patternProperties:
diff --git a/Documentation/devicetree/bindings/sound/simple-card.yaml b/Documentation/devicetree/bindings/sound/simple-card.yaml
index 45fd9fd9eb54..103044bd32eb 100644
--- a/Documentation/devicetree/bindings/sound/simple-card.yaml
+++ b/Documentation/devicetree/bindings/sound/simple-card.yaml
@@ -156,45 +156,45 @@ properties:
     description: User specified audio sound card name.
     $ref: /schemas/types.yaml#/definitions/string
 
-# use patternProperties to avoid naming "xxx,yyy" issue
-patternProperties:
-  "^simple-audio-card,widgets$":
+  simple-audio-card,widgets:
     $ref: "#/definitions/widgets"
-  "^simple-audio-card,routing$":
+  simple-audio-card,routing:
     $ref: "#/definitions/routing"
-  "^simple-audio-card,cpu(@[0-9a-f]+)?":
-    $ref: "#/definitions/dai"
-  "^simple-audio-card,codec(@[0-9a-f]+)?":
-    $ref: "#/definitions/dai"
 
   # common properties
-  "^simple-audio-card,frame-master$":
+  simple-audio-card,frame-master:
     $ref: "#/definitions/frame-master"
-  "^simple-audio-card,bitclock-master$":
+  simple-audio-card,bitclock-master:
     $ref: "#/definitions/bitclock-master"
-  "^simple-audio-card,frame-inversion$":
+  simple-audio-card,frame-inversion:
     $ref: "#/definitions/frame-inversion"
-  "^simple-audio-card,bitclock-inversion$":
+  simple-audio-card,bitclock-inversion:
     $ref: "#/definitions/bitclock-inversion"
-  "^simple-audio-card,format$":
+  simple-audio-card,format:
     $ref: "#/definitions/format"
-  "^simple-audio-card,mclk-fs$":
+  simple-audio-card,mclk-fs:
     $ref: "#/definitions/mclk-fs"
-  "^simple-audio-card,aux-devs$":
+  simple-audio-card,aux-devs:
     $ref: "#/definitions/aux-devs"
-  "^simple-audio-card,convert-rate$":
+  simple-audio-card,convert-rate:
     $ref: "#/definitions/convert-rate"
-  "^simple-audio-card,convert-channels$":
+  simple-audio-card,convert-channels:
     $ref: "#/definitions/convert-channels"
-  "^simple-audio-card,prefix$":
+  simple-audio-card,prefix:
     $ref: "#/definitions/prefix"
-  "^simple-audio-card,pin-switches$":
+  simple-audio-card,pin-switches:
     $ref: "#/definitions/pin-switches"
-  "^simple-audio-card,hp-det-gpio$":
+  simple-audio-card,hp-det-gpio:
     maxItems: 1
-  "^simple-audio-card,mic-det-gpio$":
+  simple-audio-card,mic-det-gpio:
     maxItems: 1
 
+patternProperties:
+  "^simple-audio-card,cpu(@[0-9a-f]+)?$":
+    $ref: "#/definitions/dai"
+  "^simple-audio-card,codec(@[0-9a-f]+)?$":
+    $ref: "#/definitions/dai"
+
   "^simple-audio-card,dai-link(@[0-9a-f]+)?$":
     description: |
       Container for dai-link level properties and the CPU and CODEC sub-nodes.
-- 
2.32.0

