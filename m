Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B5534537099
	for <lists+linux-kernel@lfdr.de>; Sun, 29 May 2022 12:51:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229917AbiE2Kva (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 29 May 2022 06:51:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36310 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229529AbiE2KvT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 29 May 2022 06:51:19 -0400
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com [IPv6:2a00:1450:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B95D54CD55
        for <linux-kernel@vger.kernel.org>; Sun, 29 May 2022 03:51:17 -0700 (PDT)
Received: by mail-ed1-x52b.google.com with SMTP id z43so5760949ede.1
        for <linux-kernel@vger.kernel.org>; Sun, 29 May 2022 03:51:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=JwnhYZYUjycAnfsQ1qpf5ovZ63Tyhe8AegM4ymwHn6U=;
        b=x6Q6EWztSl4cve6WezmNtTarzhXCIS3oCGSvW2fvoPRGJaeFboJQK0TAEp+UhJyNOP
         bLdl9Td81r8XN+aK2m0yf09YNzFQnb1QEYyVyNhN1tXuuLCYeVStqjOVKTZPHxh48Aup
         z3TyRqlXIDyHe63UXW33nfr/RXDLYr1m7Jpo8my9g13cO7LOf8PL3EzE/bnCS+Y5hz8v
         rfqJT4YZHl61yeDIMvZJbGZpQQhpSYzSDrP+wDL7FItHlIPHw0g5mxt294Ucu7lGWIBi
         xGzvW+ZnQGWwFHEWyMdbXlDJffuG/BfxmcJAmNmv2uinVk5ZohFbBUp4pA7DdZEwYNzs
         7IWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=JwnhYZYUjycAnfsQ1qpf5ovZ63Tyhe8AegM4ymwHn6U=;
        b=k5wjU9c/YzEFMDx022ynlE2NOPAupnR3z7Tg6EOa4FITRrZO4TmmEHn4fnBuzo0dLS
         jEYs+FTrrG4Jt7bQbQslCOVJjRZ5BpECYVM6KCKfFn6QbzWxj2SP77+8lrBHizj7FoCI
         g3H5Bln3dopn8c1b96eL432Ou7mHeWfxaZBqL2I9pYS8lRxIHae5oYpdsaGYw7f8a7MK
         A6aqKi3OoCT+SLjoc+gFkQb5y04kP/2Gcim/KNUXNgJ7ZLygIJFdkaDuHP4WZs64pYJy
         Fgxdfjn1bSXLnTjwPYe8PCoEWCxx32GfFCC5U3NZ3f1GqHmnMxryhj30WyAyj28GW/45
         uwWA==
X-Gm-Message-State: AOAM533epjS3c13GJVpQ20PojN4Vz2TmkFOALlHFcOOBtDH38RyCgsra
        6kAoV93Gmt9/KeNj+swHa6FfSw==
X-Google-Smtp-Source: ABdhPJwPNpC82y/irmX2R/zBK0sGSfYFVR5YbR5U9zvGw8WXhtG7gmRJUqPKZGUqRCTuXeQfx4owyQ==
X-Received: by 2002:a05:6402:c1:b0:42a:b8a5:8d5e with SMTP id i1-20020a05640200c100b0042ab8a58d5emr54048588edu.266.1653821476070;
        Sun, 29 May 2022 03:51:16 -0700 (PDT)
Received: from localhost.localdomain (xdsl-188-155-176-92.adslplus.ch. [188.155.176.92])
        by smtp.gmail.com with ESMTPSA id w25-20020a50f119000000b0042b0fcfe966sm4746991edl.37.2022.05.29.03.51.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 29 May 2022 03:51:15 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Joel Stanley <joel@jms.id.au>,
        Andrew Jeffery <andrew@aj.id.au>,
        Arnd Bergmann <arnd@arndb.de>,
        Steven Lee <steven_lee@aspeedtech.com>,
        Ken Chen <chen.kenyy@inventec.com>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-aspeed@lists.ozlabs.org, linux-kernel@vger.kernel.org
Cc:     David Wang <David_Wang6097@jabil.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH 2/7] dt-bindings: arm: aspeed: document board compatibles
Date:   Sun, 29 May 2022 12:49:23 +0200
Message-Id: <20220529104928.79636-2-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220529104928.79636-1-krzysztof.kozlowski@linaro.org>
References: <20220529104928.79636-1-krzysztof.kozlowski@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Document all compatibles used in existing upstreamed Aspeed AST2400,
AST2500 and AST2600 based boards.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 .../bindings/arm/aspeed/aspeed.yaml           | 83 +++++++++++++++++++
 MAINTAINERS                                   |  1 +
 2 files changed, 84 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/arm/aspeed/aspeed.yaml

diff --git a/Documentation/devicetree/bindings/arm/aspeed/aspeed.yaml b/Documentation/devicetree/bindings/arm/aspeed/aspeed.yaml
new file mode 100644
index 000000000000..f214b57d5ae1
--- /dev/null
+++ b/Documentation/devicetree/bindings/arm/aspeed/aspeed.yaml
@@ -0,0 +1,83 @@
+# SPDX-License-Identifier: GPL-2.0-only or BSD-2-Clause
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/arm/aspeed/aspeed.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Aspeed SoC based boards
+
+maintainers:
+  - Joel Stanley <joel@jms.id.au>
+
+properties:
+  $nodename:
+    const: '/'
+  compatible:
+    oneOf:
+      - description: AST2400 based boards
+        items:
+          - enum:
+              - facebook,galaxy100-bmc
+              - facebook,wedge100-bmc
+              - facebook,wedge40-bmc
+              - microsoft,olympus-bmc
+              - quanta,q71l-bmc
+              - tyan,palmetto-bmc
+              - yadro,vesnin-bmc
+          - const: aspeed,ast2400
+
+      - description: AST2500 based boards
+        items:
+          - enum:
+              - amd,ethanolx-bmc
+              - ampere,mtjade-bmc
+              - asrock,e3c246d4i-bmc
+              - asrock,romed8hm3-bmc
+              - bytedance,g220a-bmc
+              - facebook,cmm-bmc
+              - facebook,minipack-bmc
+              - facebook,tiogapass-bmc
+              - facebook,yamp-bmc
+              - facebook,yosemitev2-bmc
+              - facebook,wedge400-bmc
+              - hxt,stardragon4800-rep2-bmc
+              - ibm,mihawk-bmc
+              - ibm,mowgli-bmc
+              - ibm,romulus-bmc
+              - ibm,swift-bmc
+              - ibm,witherspoon-bmc
+              - ingrasys,zaius-bmc
+              - inspur,fp5280g2-bmc
+              - inspur,nf5280m6-bmc
+              - inspur,on5263m5-bmc
+              - intel,s2600wf-bmc
+              - inventec,lanyang-bmc
+              - lenovo,hr630-bmc
+              - lenovo,hr855xg2-bmc
+              - portwell,neptune-bmc
+              - qcom,centriq2400-rep-bmc
+              - supermicro,x11spi-bmc
+              - tyan,s7106-bmc
+              - tyan,s8036-bmc
+              - yadro,nicole-bmc
+              - yadro,vegman-n110-bmc
+              - yadro,vegman-rx20-bmc
+              - yadro,vegman-sx20-bmc
+          - const: aspeed,ast2500
+
+      - description: AST2600 based boards
+        items:
+          - enum:
+              - facebook,bletchley-bmc
+              - facebook,cloudripper-bmc
+              - facebook,elbert-bmc
+              - facebook,fuji-bmc
+              - ibm,everest-bmc
+              - ibm,rainier-bmc
+              - ibm,tacoma-bmc
+              - inventec,transformer-bmc
+              - nuvia,dc-scm-bmc
+              - quanta,s6q-bmc
+          - const: aspeed,ast2600
+
+additionalProperties: true
diff --git a/MAINTAINERS b/MAINTAINERS
index c71276d7752e..860017ff41a8 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1896,6 +1896,7 @@ L:	linux-aspeed@lists.ozlabs.org (moderated for non-subscribers)
 S:	Supported
 Q:	https://patchwork.ozlabs.org/project/linux-aspeed/list/
 T:	git git://git.kernel.org/pub/scm/linux/kernel/git/joel/aspeed.git
+F:	Documentation/devicetree/bindings/arm/aspeed/
 F:	arch/arm/boot/dts/aspeed-*
 F:	arch/arm/mach-aspeed/
 N:	aspeed
-- 
2.34.1

