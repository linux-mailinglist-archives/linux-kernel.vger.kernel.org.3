Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A65B252DD5D
	for <lists+linux-kernel@lfdr.de>; Thu, 19 May 2022 21:01:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244350AbiESTBu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 May 2022 15:01:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58600 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244275AbiESTBd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 May 2022 15:01:33 -0400
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com [IPv6:2a00:1450:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A5F93532FC;
        Thu, 19 May 2022 12:01:29 -0700 (PDT)
Received: by mail-wm1-x334.google.com with SMTP id k126so3387738wme.2;
        Thu, 19 May 2022 12:01:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=iFLnLP7/OEuz4wdRDIn1ORAc4gGIzikzoEkwYYDgvJg=;
        b=pEKTjR6x27IA9qHOPQmR8lGbD+qmD1MFFfvO5Fo2WxWCMdjGvVNsnGfhtxeJcJwavw
         2Jz75TW+zFV8/MyE+XkuDCk7JgfbjfYB1AJpPOKrtIvURmna+8dfDA39Vl3zlLuGJ1tu
         JITeyYoywHsvh0ZvySVoVcT3K6evGfCgd9unj85iqx9Hy3xNA9muKVgOxiF3qiKngM0R
         hBbQEn+BU8I1fOOxTxaTeYNoi/XU/ZkZ6sm21AJ+HepoxwlOW8BGoeU1T04FROIesBYw
         eaafM4qQsE/o6eXy8FpLrQib86NqfEDu0mFlKe6Jci0UWjYPEiFo+DpcU+CX2d9NZ4rc
         zjqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=iFLnLP7/OEuz4wdRDIn1ORAc4gGIzikzoEkwYYDgvJg=;
        b=SUjjqaKDvaGw8CCxsPpeEWtaVgeJDM5VQN1jkaCGfxf334fpRenENArx79X7CXzsT7
         zZMmwnh0/tkmLN8AKt/Df7wT7njQ9tQxYovdLOAHUOV8//LZRuxYni3v1/PNp88Y5aS0
         kPXj2gmkDokuaXc/aMKSDajNnOy0LOtJrSQV6rgWnrMdq73n75nCC4pfAwOYiH57uLbs
         OyEyVOpKpylBJldAL9V/QbZQyPa9bl3YnmTvcG8ycouZe25W45z1TTfTdjXwzON00qnL
         MAJmu9NqdM2iKTE6lNOG4SEhLrexElc+unm+Ik7hogcTeJa9Qbuk1ODyMEbChfSon0XT
         TJLA==
X-Gm-Message-State: AOAM531aZa6rcI+O/gyLWSBY8cyG6LN0T6xsBSF8xyVlS+kDq3ro8Igx
        xgdf/xY73xDkoMlZY9Y8jfw=
X-Google-Smtp-Source: ABdhPJzBDLRZjlSbYLz0uYv/HMjZXBE35+YIa6k2BqBn3h6pAKwLPh6Ct9EGeA+dXiOIsb3a3+w+qg==
X-Received: by 2002:a05:600c:acf:b0:397:345f:fe10 with SMTP id c15-20020a05600c0acf00b00397345ffe10mr2022718wmr.15.1652986887545;
        Thu, 19 May 2022 12:01:27 -0700 (PDT)
Received: from localhost.localdomain (93-42-70-190.ip85.fastwebnet.it. [93.42.70.190])
        by smtp.googlemail.com with ESMTPSA id h11-20020a05600c414b00b00395b809dfd3sm333767wmm.12.2022.05.19.12.01.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 May 2022 12:01:27 -0700 (PDT)
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
Subject: [PATCH v4 2/2] dt-bindings: mtd: qcom_nandc: document qcom,boot-pages binding
Date:   Thu, 19 May 2022 21:01:12 +0200
Message-Id: <20220519190112.6344-3-ansuelsmth@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220519190112.6344-1-ansuelsmth@gmail.com>
References: <20220519190112.6344-1-ansuelsmth@gmail.com>
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
index 84ad7ff30121..a59ae9525f4e 100644
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
+              - qcom,ipq806x-nand
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

