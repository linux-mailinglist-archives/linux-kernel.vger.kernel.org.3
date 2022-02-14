Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AE2E04B5CCB
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Feb 2022 22:27:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230391AbiBNVWf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Feb 2022 16:22:35 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:48758 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231126AbiBNVWT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Feb 2022 16:22:19 -0500
Received: from smtp-relay-internal-1.canonical.com (smtp-relay-internal-1.canonical.com [185.125.188.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4826513C3B1
        for <linux-kernel@vger.kernel.org>; Mon, 14 Feb 2022 13:22:11 -0800 (PST)
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com [209.85.221.72])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id 1C3EC4033E
        for <linux-kernel@vger.kernel.org>; Mon, 14 Feb 2022 21:22:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1644873730;
        bh=pHflPK+1dIKzIsgbbrg2ywYytRq8pFheQaXjxJrMqyY=;
        h=From:To:Subject:Date:Message-Id:In-Reply-To:References:
         MIME-Version;
        b=PMVAiEa9tAVg/Y+d55sfXoniZdgKDqGFnHMxTU4yEBIv/2S5cyxgqJ4Zo/kVQJSGM
         lUayYGNrLcKEfrHac9o0jv+/2lwvVROehMAK2XxqhZpQdL8kLiDDyp56j8s6FjfcbF
         9BwDS3hECD49InL3/DmH8glCQ6icvqHjmZJ4MF4FKhCJnaRraC74nAQ+JKhwXUqYfh
         1CgXHxsI/dohxNbDDFlT1VqKsqXGhFVXYYXodfKcedw/j94yHtRAFQcFNxjZP/+fn/
         Ay0BCmKgs/DM68FIAJioOmmVDJ1O1AVowkW9Zy2Sl6y8JjDdm8sae9WmosH3CJ5MBh
         V5xwonbN0f9OA==
Received: by mail-wr1-f72.google.com with SMTP id k3-20020adfb343000000b001e463e6af20so7360924wrd.8
        for <linux-kernel@vger.kernel.org>; Mon, 14 Feb 2022 13:22:10 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=pHflPK+1dIKzIsgbbrg2ywYytRq8pFheQaXjxJrMqyY=;
        b=Y2z5lcrNPSYikujQ1LlkPSiCz5Jl4iIoWEfRiQZa8NM+8O8avzX/uSwOhDS9wqqjq2
         Kigb2XMmnMP03u7WnbLKFAopE2sCv2WubCVqlD5iEvVowOlDh6UbqMSJHKNJg2icOnHV
         ++5n3amQ3wdTwsbIMugLFnX6Pk2CgEyJeIIxAoI7d4zxwtMd93awb8ffnJvabqotqCT5
         s76HLAf9bsSbwZbCR4vCq/J9NES8PfUYtOhzb8l2LySdrFrVEoLC/xpBXaxK8rEBRpFG
         dQVFC9BHWNloenPX1iQvBoAYHBPRIsVUhMvQByLy9bHfYDxnQlRncE10GkSGctSzBQRu
         mDhQ==
X-Gm-Message-State: AOAM5325WZr0FmqdpzyvD1DT+l+qSXXVO2HPxjMjvFziTK2FntI/SZzs
        5CG55Qlb5AxEJkG5DqiSpZBZrcpTKNUISkkCWHe42Lp8pkIseKan75N7j51mGG/jJqeVohjstjf
        fUD2Fm5r8IQLCj8dyyqs3lBKn/dZ+5JLCcQOUHiWuTw==
X-Received: by 2002:a17:906:d555:: with SMTP id cr21mr592315ejc.428.1644873719519;
        Mon, 14 Feb 2022 13:21:59 -0800 (PST)
X-Google-Smtp-Source: ABdhPJyXvrgHPtrdYKNQY7C7Wd9/NsvQdSUG3/eoACXgHTI31beBEFWPYpjvuWpVSYib/oyyZwbB2w==
X-Received: by 2002:a17:906:d555:: with SMTP id cr21mr592282ejc.428.1644873719273;
        Mon, 14 Feb 2022 13:21:59 -0800 (PST)
Received: from localhost.localdomain (xdsl-188-155-168-84.adslplus.ch. [188.155.168.84])
        by smtp.gmail.com with ESMTPSA id v24sm2327203ejf.7.2022.02.14.13.21.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Feb 2022 13:21:58 -0800 (PST)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
To:     Thierry Reding <thierry.reding@gmail.com>,
        =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>, Lee Jones <lee.jones@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        Maxime Ripard <mripard@kernel.org>,
        Chen-Yu Tsai <wens@csie.org>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        bcm-kernel-feedback-list@broadcom.com,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Heiko Stuebner <heiko@sntech.de>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Anson Huang <anson.huang@nxp.com>,
        Vijayakannan Ayyathurai <vijayakannan.ayyathurai@intel.com>,
        Rahul Tanwar <rtanwar@maxlinear.com>,
        Jeff LaBundy <jeff@labundy.com>,
        Yash Shah <yash.shah@sifive.com>,
        Sagar Kadam <sagar.kadam@sifive.com>,
        Vignesh R <vigneshr@ti.com>,
        Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
        Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>,
        linux-pwm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-sunxi@lists.linux.dev,
        linux-kernel@vger.kernel.org, linux-rockchip@lists.infradead.org,
        linux-riscv@lists.infradead.org
Subject: [PATCH v2 01/15] dt-bindings: pwm: allwinner,sun4i-a10: Include generic pwm schema
Date:   Mon, 14 Feb 2022 22:21:40 +0100
Message-Id: <20220214212154.8853-2-krzysztof.kozlowski@canonical.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20220214212154.8853-1-krzysztof.kozlowski@canonical.com>
References: <20220214212154.8853-1-krzysztof.kozlowski@canonical.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Include generic pwm.yaml schema, which enforces PWM node naming and
brings pwm-cells requirement.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
Acked-by: Jernej Skrabec <jernej.skrabec@gmail.com>
---
 .../bindings/pwm/allwinner,sun4i-a10-pwm.yaml | 53 ++++++++++---------
 1 file changed, 28 insertions(+), 25 deletions(-)

diff --git a/Documentation/devicetree/bindings/pwm/allwinner,sun4i-a10-pwm.yaml b/Documentation/devicetree/bindings/pwm/allwinner,sun4i-a10-pwm.yaml
index 800d511502c4..e93e935564fb 100644
--- a/Documentation/devicetree/bindings/pwm/allwinner,sun4i-a10-pwm.yaml
+++ b/Documentation/devicetree/bindings/pwm/allwinner,sun4i-a10-pwm.yaml
@@ -52,33 +52,36 @@ properties:
   resets:
     maxItems: 1
 
-if:
-  properties:
-    compatible:
-      contains:
-        const: allwinner,sun50i-h6-pwm
-
-then:
-  properties:
-    clocks:
-      maxItems: 2
-
-    clock-names:
-      items:
-        - const: mod
-        - const: bus
-
-  required:
-    - clock-names
-    - resets
-
-else:
-  properties:
-    clocks:
-      maxItems: 1
+
+allOf:
+  - $ref: pwm.yaml#
+
+  - if:
+      properties:
+        compatible:
+          contains:
+            const: allwinner,sun50i-h6-pwm
+
+    then:
+      properties:
+        clocks:
+          maxItems: 2
+
+        clock-names:
+          items:
+            - const: mod
+            - const: bus
+
+      required:
+        - clock-names
+        - resets
+
+    else:
+      properties:
+        clocks:
+          maxItems: 1
 
 required:
-  - "#pwm-cells"
   - compatible
   - reg
   - clocks
-- 
2.32.0

