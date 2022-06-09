Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B95CA544D7F
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Jun 2022 15:24:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237767AbiFINYh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Jun 2022 09:24:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46452 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343786AbiFINYV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Jun 2022 09:24:21 -0400
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com [IPv6:2a00:1450:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C4DD036B69;
        Thu,  9 Jun 2022 06:24:19 -0700 (PDT)
Received: by mail-ed1-x530.google.com with SMTP id h19so31227910edj.0;
        Thu, 09 Jun 2022 06:24:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=6jeqtgRl8bKHnXZ4AwxPt+xAQ0F0PxiC5aWs7JdMOrY=;
        b=cJVhmrHYyT63kIWknwWNHq8H3Fm9koj9Te576ocCrSOqv18WrgBUMotLdhsN3HIdgM
         /aoYBLe/1EthBKwzLMOnDMzMig7pgkcWUDz16SM9QlGmsvii3FqSwftw9IOpua1hqHWt
         25Lmz9S4wLtucB+FC0jlpNDPXt28Iw7T+JqGvOtDSU9eNPMNLImvrJ4EyIofVj3wjzF/
         NmsQbdligcS3Jl35T6bp6lduzJbYTPUS2LCFpZA5Koky7S9y1t5KWRyGqqGgjh0huMkj
         4YDSGmibIrJm/1RE4XIvWQzFiHPn6y7ILU3OChbYMf6D77+KLKMiE9opqoyC8nXEIaNw
         Emdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=6jeqtgRl8bKHnXZ4AwxPt+xAQ0F0PxiC5aWs7JdMOrY=;
        b=HBP1A7FG+fFH5bAACeWi5dsPQ/70i89IIsn+knSkWTKeF8cxYwcD1XY7rbHId2/78v
         aoJpy5ZF9LkaiiQ6eY2jfUekQRqqtgBeZfKpv7G2Q301dH0kx1Eo06zEjjMrJyffiqJe
         MoWuJ4sT11MMDqX63BZ53MQeigQhzcBPdnkbVFUSPC1VpN300LbYBn7huhb/agMABfTt
         lGvudZ4RJ6zdWYmIlVyR3DHxbv/13IKfS8xYsQ+1XYK/AFkHlNGvwGtlSG8dYpFDWk5w
         9NtgY3TqmKM6g5OHul2s7HTyHH+v91xzEMyWSbXwRXvsS6Xq40A4CTTqbw3gHqC8tIA0
         M7NA==
X-Gm-Message-State: AOAM5315kcf3rOi2Wcc2udJKQcBAjeOPyx3cZAWRV4uWWRZ55sIaxeiV
        MsNHDCSP5J49gjRRK+MhhAs=
X-Google-Smtp-Source: ABdhPJz4eKUEq7ZrMsvoEKZtpxBHOSayxyiXJ2PgF4vC9W0d68Yh4tOffD3uKBEr3qTbYLCZAaDwpA==
X-Received: by 2002:a05:6402:31fa:b0:42d:cd6d:c8fd with SMTP id dy26-20020a05640231fa00b0042dcd6dc8fdmr44609520edb.347.1654781058277;
        Thu, 09 Jun 2022 06:24:18 -0700 (PDT)
Received: from localhost.localdomain (93-42-70-190.ip85.fastwebnet.it. [93.42.70.190])
        by smtp.googlemail.com with ESMTPSA id i2-20020a056402054200b004315050d7dfsm8360263edx.81.2022.06.09.06.24.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Jun 2022 06:24:17 -0700 (PDT)
From:   Ansuel Smith <ansuelsmth@gmail.com>
To:     Manivannan Sadhasivam <mani@kernel.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-mtd@lists.infradead.org, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Ansuel Smith <ansuelsmth@gmail.com>
Subject: [PATCH v6 3/3] dt-bindings: mtd: qcom_nandc: document qcom,boot-partitions binding
Date:   Thu,  9 Jun 2022 15:23:44 +0200
Message-Id: <20220609132344.17548-4-ansuelsmth@gmail.com>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20220609132344.17548-1-ansuelsmth@gmail.com>
References: <20220609132344.17548-1-ansuelsmth@gmail.com>
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

Document new qcom,boot-partition binding used to apply special
read/write layout to boot partitions.

QCOM apply a special layout where spare data is not protected
by ECC for some special pages (used for boot partition). Add
Documentation on how to declare these special pages.

Signed-off-by: Ansuel Smith <ansuelsmth@gmail.com>
Reviewed-by: Manivannan Sadhasivam <mani@kernel.org>
---
 .../devicetree/bindings/mtd/qcom,nandc.yaml   | 27 +++++++++++++++++++
 1 file changed, 27 insertions(+)

diff --git a/Documentation/devicetree/bindings/mtd/qcom,nandc.yaml b/Documentation/devicetree/bindings/mtd/qcom,nandc.yaml
index 84ad7ff30121..482a2c068740 100644
--- a/Documentation/devicetree/bindings/mtd/qcom,nandc.yaml
+++ b/Documentation/devicetree/bindings/mtd/qcom,nandc.yaml
@@ -102,6 +102,31 @@ allOf:
             - const: rx
             - const: cmd
 
+  - if:
+      properties:
+        compatible:
+          contains:
+            enum:
+              - qcom,ipq806x-nand
+
+    then:
+      properties:
+        qcom,boot-partitions:
+          $ref: /schemas/types.yaml#/definitions/uint32-matrix
+          items:
+            items:
+              - description: offset
+              - description: size
+          description:
+            Boot partition use a different layout where the 4 bytes of spare
+            data are not protected by ECC. Use this to declare these special
+            partitions by defining first the offset and then the size.
+
+            It's in the form of <offset1 size1 offset2 size2 offset3 ...>
+            and should be declared in ascending order.
+
+            Refer to the ipq8064 example on how to use this special binding.
+
 required:
   - compatible
   - reg
@@ -135,6 +160,8 @@ examples:
         nand-ecc-strength = <4>;
         nand-bus-width = <8>;
 
+        qcom,boot-partitions = <0x0 0x58a0000>;
+
         partitions {
           compatible = "fixed-partitions";
           #address-cells = <1>;
-- 
2.36.1

