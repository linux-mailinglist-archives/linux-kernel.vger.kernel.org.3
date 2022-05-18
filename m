Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 99E8652C28D
	for <lists+linux-kernel@lfdr.de>; Wed, 18 May 2022 20:45:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241560AbiERSnY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 May 2022 14:43:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45068 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241545AbiERSnM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 May 2022 14:43:12 -0400
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com [IPv6:2a00:1450:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CEB3B20E088;
        Wed, 18 May 2022 11:43:10 -0700 (PDT)
Received: by mail-wr1-x42d.google.com with SMTP id w4so3864752wrg.12;
        Wed, 18 May 2022 11:43:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=LCQt9dF5/Nd3/Isv+mV5CnUwo5R82LECwM2pguJb50A=;
        b=TuTrW85JBFEdq12t36v4JPlKIQEDeS4N4Lzp1EDwAnp0onOMiAlex7/6IuElJsKadP
         gahiCwCQWh0sM8QKcPWWfmkkR56YLM1fxMY2gnC2S8wX7vm5LMuH5I2/f9XfQpHph0nW
         APsPKBb8sEH8EDy0Pmactr13MFtbH3caebPj7d0SuvcyX0w4u5vIEhNu3Wyq3vAvk3/k
         WvoHuRdh6YbMW7M0SeRbVcsJx0xbwgEe+vs8ScrMA77KZPm5rG26RHz0BUHds2QJ4D2Y
         5HCKVaIhA87kaVw1BD29F96jTmHlQenfAh3LiibCfsvrzTW0fjNEbgaKb34BQ+bFJuUz
         IwSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=LCQt9dF5/Nd3/Isv+mV5CnUwo5R82LECwM2pguJb50A=;
        b=VCJadBT9V5fylPBvoYVv2Ld4E6iX1DyrY8b2RI7CtfoEy9YlV8tAjNPV2vM6muHsYY
         djqlK+iXog3A24OhTRm/VVPdhDOLDsC5ExTBJvfEPTuDtEgV/i39ZpCpLNENqV3vSpVN
         gpixpybAqfkkgkzw+b1ev7A/LekGO5Cps2J0VJfQQ81XNjiT+rN0KDdGg9JJa6CoZv5B
         ytOg8ucEZQrH2tyDW6kGDLCpmpcqHijprKnnFQgPcZG8evGXst2uKCv+g99wepxiQH2Y
         AnB+NxdrKSIQkZSHZhinrLZsuWffXknpaoBeSyNV2Z/CLhhAsfISBGOxfiQBCf42C4W2
         sSKA==
X-Gm-Message-State: AOAM531fmZDiXNsoeBIjgeqpHnNbTIzqDgpSty3vrOi5x4vK8e78U/Ls
        lKCc8UZus0PQlh1y5l/+5Eg=
X-Google-Smtp-Source: ABdhPJykuWKJkrm3GbrAy+7CPM02+KOldHkPFjK+XnhxsXrzR3KDbLz3l0Czbn2VBW47MNOD8mj5aA==
X-Received: by 2002:adf:ee4a:0:b0:20e:5884:5c72 with SMTP id w10-20020adfee4a000000b0020e58845c72mr895738wro.314.1652899388895;
        Wed, 18 May 2022 11:43:08 -0700 (PDT)
Received: from localhost.localdomain (93-42-70-190.ip85.fastwebnet.it. [93.42.70.190])
        by smtp.googlemail.com with ESMTPSA id q9-20020adf9dc9000000b0020d02ddf4d5sm2768546wre.5.2022.05.18.11.43.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 May 2022 11:43:08 -0700 (PDT)
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
Subject: [PATCH v3 2/2] dt-bindings: mtd: qcom_nandc: document qcom,boot-pages binding
Date:   Wed, 18 May 2022 20:42:56 +0200
Message-Id: <20220518184256.21238-3-ansuelsmth@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220518184256.21238-1-ansuelsmth@gmail.com>
References: <20220518184256.21238-1-ansuelsmth@gmail.com>
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

Document new qcom,boot-pages binding used to apply special
read/write configuration to boot pages.

QCOM apply a special configuration where spare data is not protected
by ECC for some special pages (used for boot partition). Add
Documentation on how to declare these special pages.

Signed-off-by: Ansuel Smith <ansuelsmth@gmail.com>
---
 .../devicetree/bindings/mtd/qcom,nandc.yaml   | 26 +++++++++++++++++++
 1 file changed, 26 insertions(+)

diff --git a/Documentation/devicetree/bindings/mtd/qcom,nandc.yaml b/Documentation/devicetree/bindings/mtd/qcom,nandc.yaml
index 84ad7ff30121..3b8244db2ae8 100644
--- a/Documentation/devicetree/bindings/mtd/qcom,nandc.yaml
+++ b/Documentation/devicetree/bindings/mtd/qcom,nandc.yaml
@@ -102,6 +102,30 @@ allOf:
             - const: rx
             - const: cmd
 
+  - if:
+      properties:
+        compatible:
+          contains:
+            enum:
+              - qcom,ipq8074-nand
+
+    then:
+      properties:
+        qcom,boot-pages:
+          $ref: /schemas/types.yaml#/definitions/uint32-matrix
+          items:
+            items:
+              - description: offset
+              - description: size
+          description:
+            Some special page used by boot partition have spare data
+            not protected by ECC. Use this to declare these special page
+            by defining first the offset and then the size.
+
+            It's in the form of <offset1 size1 offset2 size2 offset3 ...>
+
+            Refer to the ipq8064 example on how to use this special binding.
+
 required:
   - compatible
   - reg
@@ -135,6 +159,8 @@ examples:
         nand-ecc-strength = <4>;
         nand-bus-width = <8>;
 
+        qcom,boot-pages = <0x0 0x58a0000>;
+
         partitions {
           compatible = "fixed-partitions";
           #address-cells = <1>;
-- 
2.34.1

