Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B159A4DCE96
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Mar 2022 20:15:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237940AbiCQTRA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Mar 2022 15:17:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54744 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237932AbiCQTQ6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Mar 2022 15:16:58 -0400
Received: from mail-pf1-x42d.google.com (mail-pf1-x42d.google.com [IPv6:2607:f8b0:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7828820C1AA;
        Thu, 17 Mar 2022 12:15:41 -0700 (PDT)
Received: by mail-pf1-x42d.google.com with SMTP id z16so7614443pfh.3;
        Thu, 17 Mar 2022 12:15:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=8qcfcJ8VqYp/pzvC9P1aG/6ryMzoosy3vn564CYXP0I=;
        b=k53HJLZVSwlhsZ6/38p2KDs+SxMv2V2wUYoaTfXFwh3fxquypK9hSKIYbvq6bVgnRG
         K1wQSMaDrMZPAgJx3YLqmp8894S4p3ha9cfXqLcIWftKDEhKqBWJM+TZp5DBLloh9/RC
         WrXd3u+fdf0OwQ1b2npDcdHNiyMOBVvFFGtzGYe2/OYm9WQnXZ24E+FXQ2p3fbqZpbUI
         /lB7UROCE03QPD2Y44C4gWrLRM+C8lYOGPuX26Nw6ZNeNG7tpn1sPQXIAJ2UrHHo4q90
         7d9IttvIS0X+zGpMEOLjKI6gxOc6SEalDeeaH4ki1VAYXOBnNrJcdoreJDWnnImCi6HL
         6abQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=8qcfcJ8VqYp/pzvC9P1aG/6ryMzoosy3vn564CYXP0I=;
        b=I8t4+zaV18GLSu50mgs9GK0RrawO9RGGOdExq125B+qH5tZdwB2zi5+qn4CUocoiia
         nvajwYQvrAmMxK6DlhBvz3LFpYDsH+gMs8ThXwy1LibVC6IAEL6B+XdSHQs8UuGpEISw
         XB6aZckZAvzpDEA0v32fKWo7jsPvDXkvpNXtD3XCGp6jm+hc3ugd9Mlc0vTa7ka6+AbJ
         sn1optLYByqkmCJJyMjyxS8pS72LMWEyBIbkXUgtoCJf+IJKy0/z0ufKM+COiT2w0/B2
         VVsyWxGtFPjFr/7vj31YUvUv0mwQSbLdzheyt3IlI9JxwW2rup1drwK2BcWzeW1madKg
         z8DQ==
X-Gm-Message-State: AOAM53056suARWM9+UjLM4rWogKY163De7BnSBZG/Z9MvnNRD/lXzNV4
        ivkckuHmwOtn/r2Qxsvg3Sk=
X-Google-Smtp-Source: ABdhPJzCbfIzSf34lg4OfR3/J2HaDMUbW5DeGMClqawYA8j+tZ55E+Zo2hpkZw0PFkbKBMLhJgkdHA==
X-Received: by 2002:a05:6a00:1695:b0:4f7:decc:506b with SMTP id k21-20020a056a00169500b004f7decc506bmr6506263pfc.7.1647544539850;
        Thu, 17 Mar 2022 12:15:39 -0700 (PDT)
Received: from localhost.localdomain ([122.161.51.18])
        by smtp.gmail.com with ESMTPSA id d11-20020a056a0010cb00b004e1b76b09c0sm7623076pfu.74.2022.03.17.12.15.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Mar 2022 12:15:39 -0700 (PDT)
From:   Kuldeep Singh <singh.kuldeep87k@gmail.com>
To:     Marc Zyngier <maz@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Rob Herring <robh+dt@kernel.org>,
        Marc Zyngier <marc.zyngier@arm.com>,
        Mark Rutland <mark.rutland@arm.com>
Cc:     linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
Subject: [PATCH v2 1/3] dt-bindings: timer: Rearrange compatible entries of arch timer
Date:   Fri, 18 Mar 2022 00:45:24 +0530
Message-Id: <20220317191527.96237-2-singh.kuldeep87k@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220317191527.96237-1-singh.kuldeep87k@gmail.com>
References: <20220317191527.96237-1-singh.kuldeep87k@gmail.com>
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

Compatibles entries of arch timer includes few extra items and enum
pairs which are redundant and can be simplified in a more clear, concise
and readable way. Do it.

Signed-off-by: Kuldeep Singh <singh.kuldeep87k@gmail.com>
Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
---
 .../devicetree/bindings/timer/arm,arch_timer.yaml    | 12 ++++--------
 1 file changed, 4 insertions(+), 8 deletions(-)

diff --git a/Documentation/devicetree/bindings/timer/arm,arch_timer.yaml b/Documentation/devicetree/bindings/timer/arm,arch_timer.yaml
index df8ce87fd54b..ba2910f0a7b2 100644
--- a/Documentation/devicetree/bindings/timer/arm,arch_timer.yaml
+++ b/Documentation/devicetree/bindings/timer/arm,arch_timer.yaml
@@ -21,17 +21,13 @@ description: |+
 properties:
   compatible:
     oneOf:
+      - enum:
+          - arm,armv7-timer
+          - arm,armv8-timer
       - items:
           - enum:
               - arm,cortex-a15-timer
-          - enum:
-              - arm,armv7-timer
-      - items:
-          - enum:
-              - arm,armv7-timer
-      - items:
-          - enum:
-              - arm,armv8-timer
+          - const: arm,armv7-timer
 
   interrupts:
     minItems: 1
-- 
2.25.1

