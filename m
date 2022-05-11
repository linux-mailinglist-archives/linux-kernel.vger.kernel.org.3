Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4E6625237C9
	for <lists+linux-kernel@lfdr.de>; Wed, 11 May 2022 17:53:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344064AbiEKPxj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 May 2022 11:53:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34874 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344047AbiEKPxf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 May 2022 11:53:35 -0400
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com [IPv6:2a00:1450:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9202979832;
        Wed, 11 May 2022 08:53:34 -0700 (PDT)
Received: by mail-ej1-x62a.google.com with SMTP id ks9so4978267ejb.2;
        Wed, 11 May 2022 08:53:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=yjOB8oqEwj9sflBfsTrbSM5ZU+W2PCPtGpyHnXQbiBE=;
        b=DEe5lwmx+2gl2/ljAQlEQrJ1PN8mf3JLE2GLEOI8Pc10Qd60sdbvlnNgdIjftPFcXU
         DjMiBmrvgwzcqgEkOqHilryRors0zI0ldL3Yrz9TqPC/H0ia7astUlcXSIkhwqLsOKX8
         ydamXn4CY3Wq5lQyHaXMsRP/r+dRITClHBqwhXbAPBuz5M0m4JEs3VQq+KS0cr/in9Z5
         yrwtOrC8B5SzGtAcs75Ng6wkqTfkEqnOQRrlrgqKbX/IR2ngEwu30fa+NPrd2iowUIoA
         PwMFHrGVXoaQMgmu3pxfqseLOSfk1dX9ay2Gfm8VKHB8Rfhf41cAX2yYbe9EgU7EB4tq
         BwYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=yjOB8oqEwj9sflBfsTrbSM5ZU+W2PCPtGpyHnXQbiBE=;
        b=oNdxLIeJmncuxCoHMoWdWyrUxR0fep54Ql91Qa9CosJr5db1YBGA1Tbda5TT1W/t/y
         MXNT1OgSbvjTegpi3MXmVkuDnzNqtee2IC1/HciroJPnxiz4ISfpknEAm6WwnTac3jMl
         JXJX3vnRWnjez0Uk7pUslXF1mMvfEZERICKDo16s6wjZTUioqFz3POikG4qbLqIEMSh8
         9SIpVvWNviCJBh7k8jZe/6ybCeBBmV9Wl+eUQvGMIGFusrly9wZJNRfjZXAW/zwwEYkb
         hxHL2+tlyL/tnm8MWIO6YSsouzDqH7BsYj1Jfi6dw7LXgYyJvwdRuHfzMy+Ur1HYthRK
         2Zpw==
X-Gm-Message-State: AOAM532uh6gv0XAIayUF+55HDE/lWsIiZ/HNRwNnglU5iJ7L8N5y8l3X
        3Y4iirYV0QhL7xQ9noLgwH8=
X-Google-Smtp-Source: ABdhPJyWSUkwh8FQB0XXOTQIraeUsjzWhAMctVfXQSgsFRY6m2slte57mkSqtEgbc+2cMTXMJL4F1A==
X-Received: by 2002:a17:907:1623:b0:6f6:e9ce:9926 with SMTP id hb35-20020a170907162300b006f6e9ce9926mr21965119ejc.360.1652284413040;
        Wed, 11 May 2022 08:53:33 -0700 (PDT)
Received: from localhost.localdomain (84-72-105-84.dclient.hispeed.ch. [84.72.105.84])
        by smtp.gmail.com with ESMTPSA id fb21-20020a1709073a1500b006f3ef214e1fsm1072458ejc.133.2022.05.11.08.53.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 May 2022 08:53:32 -0700 (PDT)
From:   Nicolas Frattaroli <frattaroli.nicolas@gmail.com>
To:     Ezequiel Garcia <ezequiel@vanguardiasur.com.ar>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Heiko Stuebner <heiko@sntech.de>
Cc:     Nicolas Frattaroli <frattaroli.nicolas@gmail.com>,
        Ezequiel Garcia <ezequiel@collabora.com>,
        linux-media@vger.kernel.org, linux-rockchip@lists.infradead.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v3 1/3] dt-bindings: media: rockchip-vpu: Add RK3568 VEPU compatible
Date:   Wed, 11 May 2022 17:53:06 +0200
Message-Id: <20220511155309.2637-2-frattaroli.nicolas@gmail.com>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20220511155309.2637-1-frattaroli.nicolas@gmail.com>
References: <20220511155309.2637-1-frattaroli.nicolas@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The RK3568 and RK3566 have a Hantro VPU node solely dedicated to
encoding. This patch adds a compatible for it, and also allows
the bindings to only come with a vepu interrupt.

Signed-off-by: Nicolas Frattaroli <frattaroli.nicolas@gmail.com>
---
 .../devicetree/bindings/media/rockchip-vpu.yaml | 17 ++++++++++++++++-
 1 file changed, 16 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/media/rockchip-vpu.yaml b/Documentation/devicetree/bindings/media/rockchip-vpu.yaml
index bacb60a34989..965ca80b5cea 100644
--- a/Documentation/devicetree/bindings/media/rockchip-vpu.yaml
+++ b/Documentation/devicetree/bindings/media/rockchip-vpu.yaml
@@ -22,6 +22,7 @@ properties:
           - rockchip,rk3288-vpu
           - rockchip,rk3328-vpu
           - rockchip,rk3399-vpu
+          - rockchip,rk3568-vepu
           - rockchip,px30-vpu
       - items:
           - const: rockchip,rk3188-vpu
@@ -39,7 +40,9 @@ properties:
 
   interrupt-names:
     oneOf:
-      - const: vdpu
+      - enum:
+          - vdpu
+          - vepu
       - items:
           - const: vepu
           - const: vdpu
@@ -76,6 +79,18 @@ required:
 
 additionalProperties: false
 
+allOf:
+  # compatibles that end in -vepu should only have the vepu interrupt
+  - if:
+      properties:
+        compatible:
+          contains:
+            pattern: "^[a-zA-Z0-9\\-,_.]+\\-vepu$"
+    then:
+      properties:
+        interrupt-names:
+          const: vepu
+
 examples:
   - |
         #include <dt-bindings/clock/rk3288-cru.h>
-- 
2.36.1

