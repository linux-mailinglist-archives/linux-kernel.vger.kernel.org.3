Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 52F104BB2E6
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Feb 2022 08:08:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231827AbiBRHIN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Feb 2022 02:08:13 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:43034 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231778AbiBRHII (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Feb 2022 02:08:08 -0500
Received: from mail-lj1-x232.google.com (mail-lj1-x232.google.com [IPv6:2a00:1450:4864:20::232])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BCED31BB715;
        Thu, 17 Feb 2022 23:07:50 -0800 (PST)
Received: by mail-lj1-x232.google.com with SMTP id c15so2915556ljf.11;
        Thu, 17 Feb 2022 23:07:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=IWDJ487yLqJMH2R9nX25geZJE4tvSDIiR8xa0l3wTz0=;
        b=IlUrs1RVK2LtAIx0K8FKunjdCr8qaBX4BhLfEYD1cCBATkF5gNTEO5aV7XLepcZngT
         5xvmeytA/gzHC7V3X2nPXsV4pFX77uEGlVZbJSOnIN9ERh24nUyI6U1w20I77lwNLk3T
         YlewxLcYhoMWB0zHtnKLq1JaTd893WrE9ZFOjCRjeJBpPeRNDtgkZ3o+nKqQbX8NYVGG
         UQ040lm1calR6iOJOW+PHnP+cISn94xgQVBK27t6rACckUPZFd9mAokgv79qLo8YqwSL
         jcHfZcNH6DafyXoUSt3kpr5PBDWbz0aMI3lFx3XP2x11SkHkyg0IPgd7GUGj+y7hriwX
         PhaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=IWDJ487yLqJMH2R9nX25geZJE4tvSDIiR8xa0l3wTz0=;
        b=uZfL+hVb3bJTBYuZiaHoGKB+QrEuQB63Wy7W5Z+/TZSpO0DYlQD++9ZodROFOxh50C
         7rCl9X1xYWTaLjWmkiu1d/1QHgfG/2ZtYNCzG3T6Xo5vniW8fT8JdzeQhxy3l0xLnJkG
         Ii+YD4mfPmgzhTMm2M5x2T3DejeXOQ3Dlhn//azt7NqNTTKWbhSfT1u6yyWLPp6lG0DM
         hG0gLdZgr2PHaAysIIqvZuG5TZimtH0/fkzT754hG33M4R/+UtlIpr9/ByTudSv9Pzug
         sohTvrMH2b1S9ELfCBPPNS6jQP+ELa+JtUSLl5jSs/WVD9G2BXL/yDfDdFhuT10dGIm5
         QnBw==
X-Gm-Message-State: AOAM530D5YKpqjCE/gaAMpCuySTALXKIaDb/rVapDGUom6SLnyXeibku
        LciZ8UWeYUPqLn5F48wuPjI=
X-Google-Smtp-Source: ABdhPJyG4PhqQCB3tkP0I48RQhI08avuz/CEw5sI25p72beCNJ/SSg79592K5goUTi3gS47psMDsHA==
X-Received: by 2002:a2e:9043:0:b0:246:1afb:1436 with SMTP id n3-20020a2e9043000000b002461afb1436mr3638607ljg.215.1645168069084;
        Thu, 17 Feb 2022 23:07:49 -0800 (PST)
Received: from localhost.lan (ip-194-187-74-233.konfederacka.maverick.com.pl. [194.187.74.233])
        by smtp.gmail.com with ESMTPSA id f2sm216321ljn.11.2022.02.17.23.07.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Feb 2022 23:07:48 -0800 (PST)
From:   =?UTF-8?q?Rafa=C5=82=20Mi=C5=82ecki?= <zajec5@gmail.com>
To:     Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Rob Herring <robh+dt@kernel.org>
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Hauke Mehrtens <hauke@hauke-m.de>,
        bcm-kernel-feedback-list@broadcom.com, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        =?UTF-8?q?Rafa=C5=82=20Mi=C5=82ecki?= <rafal@milecki.pl>
Subject: [PATCH V3 2/3] dt-bindings: nvmem: brcm,nvram: add basic NVMEM cells
Date:   Fri, 18 Feb 2022 08:07:28 +0100
Message-Id: <20220218070729.3256-3-zajec5@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220218070729.3256-1-zajec5@gmail.com>
References: <20220124160300.25131-1-zajec5@gmail.com>
 <20220218070729.3256-1-zajec5@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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

From: Rafał Miłecki <rafal@milecki.pl>

NVRAM doesn't have cells at hardcoded addresses. They are stored in
internal struct (custom & dynamic format). It's still important to
define relevant cells in DT so NVMEM consumers can reference them.

Update binding to allow including basic cells as NVMEM device subnodes.

Signed-off-by: Rafał Miłecki <rafal@milecki.pl>
---
V2: Add children nodes description per Rob's request
V3: Document NVMEM cells as properties
---
 .../devicetree/bindings/nvmem/brcm,nvram.yaml | 25 +++++++++++++++++--
 1 file changed, 23 insertions(+), 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/nvmem/brcm,nvram.yaml b/Documentation/devicetree/bindings/nvmem/brcm,nvram.yaml
index 8c3f0cd22821..25033de3ef6b 100644
--- a/Documentation/devicetree/bindings/nvmem/brcm,nvram.yaml
+++ b/Documentation/devicetree/bindings/nvmem/brcm,nvram.yaml
@@ -14,6 +14,8 @@ description: |
   NVRAM can be accessed on Broadcom BCM47xx MIPS and Northstar ARM Cortex-A9
   devices usiong I/O mapped memory.
 
+  NVRAM variables can be defined as NVMEM device subnodes.
+
 maintainers:
   - Rafał Miłecki <rafal@milecki.pl>
 
@@ -27,11 +29,30 @@ properties:
   reg:
     maxItems: 1
 
+  board_id:
+    type: object
+    description: Board identification name
+
+  et0macaddr:
+    type: object
+    description: First Ethernet interface's MAC address
+
+  et1macaddr:
+    type: object
+    description: Second Ethernet interface's MAC address
+
+  et2macaddr:
+    type: object
+    description: Third Ethernet interface's MAC address
+
 unevaluatedProperties: false
 
 examples:
   - |
     nvram@1eff0000 {
-            compatible = "brcm,nvram";
-            reg = <0x1eff0000 0x10000>;
+        compatible = "brcm,nvram";
+        reg = <0x1eff0000 0x10000>;
+
+        mac: et0macaddr {
+        };
     };
-- 
2.34.1

