Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C3E894F1E85
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Apr 2022 00:25:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346755AbiDDVvq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Apr 2022 17:51:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51452 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1379984AbiDDScQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Apr 2022 14:32:16 -0400
Received: from mail-pg1-x52d.google.com (mail-pg1-x52d.google.com [IPv6:2607:f8b0:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C1A728E28;
        Mon,  4 Apr 2022 11:30:20 -0700 (PDT)
Received: by mail-pg1-x52d.google.com with SMTP id k14so9088490pga.0;
        Mon, 04 Apr 2022 11:30:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=yU/npQkA3tjufXIoz/2Bj10BQJGtOZiLPnmEjB7l/dM=;
        b=ICgAi3qviwX7vleQkAxB61BLj3mLfdEss7OzH78FZDGf35Cpga1E+CqY+p2e1zQDcw
         qeKn0CA1rU6pnk8CoQVs3hfU2TUpj7aUCHEKopnGWEetguKqcmY3xd5c6f1mPnp/5jmx
         FZkEMskFvUsZzr6WU19y/XWgAQZ0cF2gRDCaa3Zoj29RrPgdtayt+STm9jzxLes6Retk
         5XnMiWmPxSsOjOEYekNdacc7aQiXcDSss807fWkZ8oIGDjJ/pS0M5zphnN+KvWYiUnd9
         olDzikcWwL1XQK5ek0xaidSf+q+62l0IrsXO5Lgm3S+CucHteoVTrw4+ecxQjY6biyFl
         cvZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=yU/npQkA3tjufXIoz/2Bj10BQJGtOZiLPnmEjB7l/dM=;
        b=unRFdMMJp6GocyvLGLfai4fPSCYLr0h2TwBYC5Da7qwMbTcqcyn0GRb61ryrOI1CUy
         0q9pYdnrA547WdkSiZ67MYPdktJYuRju0nbfUn2pFuwZKO1uQG7MisMpL8RSnTA/JKrN
         B4t7U4ui6sbGbpR2w8S2FqyuLUWZVmgm6XOOyjJL09fYx15/+M7h13/c1iiTvdTivLO/
         vMVKfWVOs3l93WToZAWjObr649stbaiJw459cfv0IWPwNnsq46463ffIE3mQaRT+QUwP
         iVtHZ8rJUvlsnwh2lsnoYWUcHjqz/sxkqAJuLmYHozeHCNJDzSGeTO9JtLYbDaCVw5UV
         2ywA==
X-Gm-Message-State: AOAM53137IF1LRkGzmib7acQ8HGTWM0HAt69wgPsYPosu7zyxTmuxpOc
        ThWZjcK1/2Vy1KvnLrLeFFk=
X-Google-Smtp-Source: ABdhPJxWF7mQvPZJfqXvzCtthm6voXtsVkttbFSl2dJZgRQnAFhQWVCu0L0KurK5VHKVI0UQ4LOOJg==
X-Received: by 2002:a63:5317:0:b0:399:58e9:882b with SMTP id h23-20020a635317000000b0039958e9882bmr165065pgb.306.1649097019502;
        Mon, 04 Apr 2022 11:30:19 -0700 (PDT)
Received: from localhost.localdomain ([122.161.51.18])
        by smtp.gmail.com with ESMTPSA id kk11-20020a17090b4a0b00b001c73933d803sm162656pjb.10.2022.04.04.11.30.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Apr 2022 11:30:19 -0700 (PDT)
From:   Kuldeep Singh <singh.kuldeep87k@gmail.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Mukesh Savaliya <msavaliy@codeaurora.org>,
        Akash Asthana <akashast@codeaurora.org>
Cc:     linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        Kuldeep Singh <singh.kuldeep87k@gmail.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        linux-arm-msm@vger.kernel.org
Subject: [PATCH v2 4/4] dt-bindings: qcom: geni-se: Update UART schema reference
Date:   Mon,  4 Apr 2022 23:59:37 +0530
Message-Id: <20220404182938.29492-5-singh.kuldeep87k@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220404182938.29492-1-singh.kuldeep87k@gmail.com>
References: <20220404182938.29492-1-singh.kuldeep87k@gmail.com>
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

We now have geni based QUP UART controller individual binding, update
reference in parent schema and remove properties from common wrapper.

With removal of last child node schema, remove common properties of all
the controllers as they have become obsolete now.

Signed-off-by: Kuldeep Singh <singh.kuldeep87k@gmail.com>
Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
v2:
- s/uart/UART
- Reword commit description
- Add Krzysztof's Rb tag
- Merge patch 5/5 of v1 series to this one:
  https://lore.kernel.org/lkml/20220402051206.6115-6-singh.kuldeep87k@gmail.com/
---
 .../bindings/soc/qcom/qcom,geni-se.yaml       | 51 +------------------
 1 file changed, 1 insertion(+), 50 deletions(-)

diff --git a/Documentation/devicetree/bindings/soc/qcom/qcom,geni-se.yaml b/Documentation/devicetree/bindings/soc/qcom/qcom,geni-se.yaml
index e6073923e03a..c8e1a4a87ba8 100644
--- a/Documentation/devicetree/bindings/soc/qcom/qcom,geni-se.yaml
+++ b/Documentation/devicetree/bindings/soc/qcom/qcom,geni-se.yaml
@@ -64,39 +64,6 @@ required:
   - ranges
 
 patternProperties:
-  "^.*@[0-9a-f]+$":
-    type: object
-    description: Common properties for GENI Serial Engine based I2C, SPI and
-                 UART controller.
-
-    properties:
-      reg:
-        description: GENI Serial Engine register address and length.
-        maxItems: 1
-
-      clock-names:
-        const: se
-
-      clocks:
-        description: Serial engine core clock needed by the device.
-        maxItems: 1
-
-      interconnects:
-        minItems: 2
-        maxItems: 3
-
-      interconnect-names:
-        minItems: 2
-        items:
-          - const: qup-core
-          - const: qup-config
-          - const: qup-memory
-
-    required:
-      - reg
-      - clock-names
-      - clocks
-
   "spi@[0-9a-f]+$":
     type: object
     description: GENI serial engine based SPI controller. SPI in master mode
@@ -133,23 +100,7 @@ patternProperties:
   "serial@[0-9a-f]+$":
     type: object
     description: GENI Serial Engine based UART Controller.
-    $ref: /schemas/serial.yaml#
-
-    properties:
-      compatible:
-        enum:
-          - qcom,geni-uart
-          - qcom,geni-debug-uart
-
-      interrupts:
-        minItems: 1
-        items:
-          - description: UART core irq
-          - description: Wakeup irq (RX GPIO)
-
-    required:
-      - compatible
-      - interrupts
+    $ref: /schemas/serial/qcom,serial-geni-qcom.yaml#
 
 additionalProperties: false
 
-- 
2.25.1

