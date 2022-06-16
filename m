Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EC13754D603
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Jun 2022 02:22:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348626AbiFPAS5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Jun 2022 20:18:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56622 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348242AbiFPASs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Jun 2022 20:18:48 -0400
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com [IPv6:2a00:1450:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 46168289B8;
        Wed, 15 Jun 2022 17:18:47 -0700 (PDT)
Received: by mail-ej1-x632.google.com with SMTP id o7so26284217eja.1;
        Wed, 15 Jun 2022 17:18:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=uWi4nF3LCftLqINeiaIVVz1nfL07lMarTNt9vrQsNMw=;
        b=PQ8nC5MVuAQT7r6QqDlFmyFHetwIZW8peR92ySiznfAD+szpx2xul39fjQAQ2Ed1m9
         +vObU6FawxJDctyqr1bXpTNoFTG3avWjYpijMddHnWck1MpAkBxSCnXsKWeEytgw4i1H
         E2WLbzluS/warij6VGMOWWl4T3JIhRoZUxNzYcpzZXB5V0JRy8Ui22PtXNG1VL8CR1bY
         ZTDNbdM1BzsNAYXzkQXS6HdMEAwx99VXLRsc9lQVatqAQpWK9k8+sS1t6n4fb+Ztydmc
         edVVwVDtjK8w8sJ90P7BesMfDBI9tOEEPhGz0bS+hMtzdNEcZ3ZZQFy4N5SK7kIMs5sI
         jIig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=uWi4nF3LCftLqINeiaIVVz1nfL07lMarTNt9vrQsNMw=;
        b=MwCthr8WYDot4jc2AG/DHiY7c9BiZObGjda9f7whkphyplU5e2UmUf44IS/GNvehiw
         Mbkg2Bk+nkyM8tSs1iKDN0/hrJ9vByiZSIHRysjF7SiWeU7Vl3gtljsUQAPfDcksxsfJ
         D5cMwO9Nl8Ce+2B//6QJ9ZCypSrwsbT+Yh0lPGKg0/4wUxqQv31qvuWo34iJOJ8eSbEl
         vkmS1f5/1DAW6WZB3bKHz44OOHeV5dl9Ru1W6bcdCcvsJnUcTj2gDL77grbfmvzZFAay
         KpRnM8mMXYZf7uxGg30Cbwi+hIz9DIufJSEB/YAZ640BiR6M1lkSSZl+AMGr65t5VdHV
         OKMQ==
X-Gm-Message-State: AJIora/ndeY3L3G+tKb7pCrStsXA7Aqomudaj/Y1yvqLXuudNHIDlmow
        Hqt16mZ0jh2F10ByIaub6XE=
X-Google-Smtp-Source: AGRyM1syMaFxhp8KJsk5hEzbDcVwz8aS0zK3BKaXWDAcVtdl18qMKw9nEQga6PpeIIGwYvmzKUqgOQ==
X-Received: by 2002:a17:907:968b:b0:70f:30b7:9324 with SMTP id hd11-20020a170907968b00b0070f30b79324mr2189545ejc.19.1655338725705;
        Wed, 15 Jun 2022 17:18:45 -0700 (PDT)
Received: from localhost.localdomain (93-42-70-190.ip85.fastwebnet.it. [93.42.70.190])
        by smtp.googlemail.com with ESMTPSA id y11-20020a056402270b00b0042e1cbc4471sm542546edd.3.2022.06.15.17.18.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Jun 2022 17:18:45 -0700 (PDT)
From:   Christian Marangi <ansuelsmth@gmail.com>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Manivannan Sadhasivam <mani@kernel.org>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-arm-msm@vger.kernel.org, linux-mtd@lists.infradead.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Christian Marangi <ansuelsmth@gmail.com>
Subject: [PATCH v8 3/3] dt-bindings: mtd: qcom_nandc: document qcom,boot-partitions binding
Date:   Thu, 16 Jun 2022 02:18:35 +0200
Message-Id: <20220616001835.24393-4-ansuelsmth@gmail.com>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20220616001835.24393-1-ansuelsmth@gmail.com>
References: <20220616001835.24393-1-ansuelsmth@gmail.com>
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

Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>
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

