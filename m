Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9595854BF06
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Jun 2022 03:00:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245342AbiFOBAc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Jun 2022 21:00:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37922 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244633AbiFOBA0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Jun 2022 21:00:26 -0400
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com [IPv6:2a00:1450:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA64F34B89;
        Tue, 14 Jun 2022 18:00:19 -0700 (PDT)
Received: by mail-wr1-x42f.google.com with SMTP id k19so13283090wrd.8;
        Tue, 14 Jun 2022 18:00:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=WkTfkEtdvoDFhLpzjBZDOf9aoOpbPYXE7T/CHrXeHMg=;
        b=IGxma2NKikLDsbYCdhTSaETNNjbqTomFUuGFHKt1wFmj6T+VLPgokRIY87z4s/a1FO
         TG6MFCvgRXODC6bJa+55TLNfqooWkAN3CCFFYbNhCfH4ST4TcfDeupYU9hyrMemqZYPB
         og10GrfehnJXbj/Ru5OTYIeb0gOSXJXpYVSrrG8p1XDf6bYv0MOsVeUIwp1s8HlSo5mB
         UIVFNlhJY5/7d5b4uCEY8eu7rZ7ASHJ3NHYD9l5xOtDoR9ApPgefaFg70rmaFuBZuZRX
         OsqQvYBP7UzmsA80JSjcKP4DLEZqArOjlEw+Yv/r2vWU5Xr/N7EO/252fgom4dTuXsuP
         80fw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=WkTfkEtdvoDFhLpzjBZDOf9aoOpbPYXE7T/CHrXeHMg=;
        b=ipw8BVaWYvNJk1cirl1ug3nk04GNaxkORh5sy4haoAROy+kWE1mzlDKUSYplp1Z1ot
         2Qf8Vuj0c/bUnCLrjUqigSGsGNdK3dkmwhyx91ybSf0QABuWWPCd3vAs7tJ7Xq0UclyV
         sNsEy3/bJPeH2JL0n4OlJMAf9i88ZjUSxnYlrsodbRHE3tIRskX87zzg1FmHu/mzDhhR
         x91bwdZJgid0igrDLM775Kv/xuAu6Da1KqthuAe72eY5rd1VtPEUkN7zp1C0umiDExZ6
         PMs+J4Pi7S+xctrRr5WjPp/MfXtNp8cvBXfn4L4+7u6gsMbQhrvhElpFHNXBBeCjB6UM
         aBVQ==
X-Gm-Message-State: AJIora8PPrD5spofCE2OQrnPll0+7hVe5KBghqaxpckmMVWcxrCNKd3m
        fYIcuKiuWyQscQ9Sr5H7nFw=
X-Google-Smtp-Source: AGRyM1u8w9uNDVwTTjicqnuRA4u5EELuTRh3kWuA+S9ngbbi41XTiT5CMhb2JGf4b9wfYfqxhEX7Pg==
X-Received: by 2002:adf:f252:0:b0:210:2a67:2d9 with SMTP id b18-20020adff252000000b002102a6702d9mr6953243wrp.17.1655254818201;
        Tue, 14 Jun 2022 18:00:18 -0700 (PDT)
Received: from localhost.localdomain (93-42-70-190.ip85.fastwebnet.it. [93.42.70.190])
        by smtp.googlemail.com with ESMTPSA id g10-20020a5d698a000000b0021020517639sm12890265wru.102.2022.06.14.18.00.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Jun 2022 18:00:15 -0700 (PDT)
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
Cc:     Ansuel Smith <ansuelsmth@gmail.com>, Rob Herring <robh@kernel.org>
Subject: [PATCH v7 3/3] dt-bindings: mtd: qcom_nandc: document qcom,boot-partitions binding
Date:   Wed, 15 Jun 2022 02:06:12 +0200
Message-Id: <20220615000612.3119-4-ansuelsmth@gmail.com>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20220615000612.3119-1-ansuelsmth@gmail.com>
References: <20220615000612.3119-1-ansuelsmth@gmail.com>
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
Reviewed-by: Rob Herring <robh@kernel.org>
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

