Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 03ADC53C76E
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Jun 2022 11:25:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243047AbiFCJZD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Jun 2022 05:25:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41998 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243031AbiFCJYg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Jun 2022 05:24:36 -0400
Received: from mail-lj1-x231.google.com (mail-lj1-x231.google.com [IPv6:2a00:1450:4864:20::231])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 820233A1B2
        for <linux-kernel@vger.kernel.org>; Fri,  3 Jun 2022 02:24:35 -0700 (PDT)
Received: by mail-lj1-x231.google.com with SMTP id r8so7267488ljp.1
        for <linux-kernel@vger.kernel.org>; Fri, 03 Jun 2022 02:24:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=semihalf.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ie7nvRY+gVcr9Te/laYvu5kQE73cxBphDPKr3kpHcM0=;
        b=EQDGw2GOIifRe0NlBx7dZ6fjPKDHwo+/2K+PxwfBzhxdkBcv3t8nUkOoQVq8N+O4zn
         SJLqcwaRX9/ZAkdnSMPrj/R/PqxKmimsfSlKFOVnwAXR4gByAGcbfOE00TZ9OSvrtS9S
         UxrlsO87HPAVX6QvjuCBqaXrhqFNzsDFUs9+/hEAOP1V/sNwgWJpTlXImdyq7Ojs6et4
         8m+b0y0ou1vgON7L2AnQ8adtJWAVfjCVvv6ed+3g+awUS8A3/LguUFVsMfvW1+nV+kRg
         4FmhtAaRHW7lkftOKp5BCAnjiMzADAm8qC1yGqOCOIvQPZR6lLpwFMg0Z5F+QU3lGAbg
         AJbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ie7nvRY+gVcr9Te/laYvu5kQE73cxBphDPKr3kpHcM0=;
        b=ynxCYeOFue2c7cwKBusUZkfg/MqItJZ+enaL45rnhqny68m1vjy5j1mug9r8pMsvH4
         UaGMRXLRJj+st3pf0p8/Zy3J8a6DOZFW8nBTmVrKUqVFyC6j2ORBIE/9ykYQ+lpg5S6x
         3kVhaEas02xgckkt9qSLsdUxfdapUPf+w1SHO6M+/XOMeTKA6Vbplbr/mlH0nJd36VRM
         xbHJAMJWk058dkrbR2ga0Lg5athwEIeWzlK5O6kTgk1L4o9NqSj0Fba0JrO7LnCRx1nY
         ucftBE6yLxHuSMn2lormPindXsgpwt9EI6Mw3CFh0XgIX/1TDDJsrpCAI2f1X75kvUoH
         6F0Q==
X-Gm-Message-State: AOAM531sugq3+S2Hi22irMUUGqJB0MsBwl77X9BmJc4JdC6vDzyf0s/s
        7LV4exVXNDVuMNjSnn8oq2u3Fg==
X-Google-Smtp-Source: ABdhPJwIjiFj/SBq07WDrHtn+WLaA7EIK4M16zPKohpIFYQV2GMGRMflajRp8jXKo6E3XooJHHYwTw==
X-Received: by 2002:a2e:9587:0:b0:255:6e01:50d with SMTP id w7-20020a2e9587000000b002556e01050dmr6482892ljh.146.1654248275057;
        Fri, 03 Jun 2022 02:24:35 -0700 (PDT)
Received: from panikiel.roam.corp.google.com (staticline-31-182-204-250.toya.net.pl. [31.182.204.250])
        by smtp.gmail.com with ESMTPSA id e10-20020a2e9e0a000000b002555dd9c20fsm1224434ljk.20.2022.06.03.02.24.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Jun 2022 02:24:34 -0700 (PDT)
From:   =?UTF-8?q?Pawe=C5=82=20Anikiel?= <pan@semihalf.com>
To:     robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        dinguyen@kernel.org
Cc:     linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, amstan@chromium.org,
        upstream@semihalf.com,
        =?UTF-8?q?Pawe=C5=82=20Anikiel?= <pan@semihalf.com>
Subject: [PATCH v4 5/5] dt-bindings: altera: Add Chameleon v3 board
Date:   Fri,  3 Jun 2022 11:23:54 +0200
Message-Id: <20220603092354.141927-6-pan@semihalf.com>
X-Mailer: git-send-email 2.36.1.255.ge46751e96f-goog
In-Reply-To: <20220603092354.141927-1-pan@semihalf.com>
References: <20220603092354.141927-1-pan@semihalf.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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

Add Mercury+ AA1 boards category, together with the Chameleon v3 board.

Signed-off-by: Paweł Anikiel <pan@semihalf.com>
---
 Documentation/devicetree/bindings/arm/altera.yaml | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/arm/altera.yaml b/Documentation/devicetree/bindings/arm/altera.yaml
index 5e2017c0a051..799ab0d2448b 100644
--- a/Documentation/devicetree/bindings/arm/altera.yaml
+++ b/Documentation/devicetree/bindings/arm/altera.yaml
@@ -25,7 +25,14 @@ properties:
         items:
           - enum:
               - altr,socfpga-arria10-socdk
-              - enclustra,mercury-aa1
+          - const: altr,socfpga-arria10
+          - const: altr,socfpga
+
+      - description: Mercury+ AA1 boards
+        items:
+          - enum:
+              - google,chameleon-v3
+          - const: enclustra,mercury-aa1
           - const: altr,socfpga-arria10
           - const: altr,socfpga
 
-- 
2.36.1.255.ge46751e96f-goog

