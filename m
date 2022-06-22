Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6422E553FEB
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Jun 2022 03:12:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236380AbiFVBLN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Jun 2022 21:11:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33850 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354552AbiFVBLG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Jun 2022 21:11:06 -0400
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com [IPv6:2a00:1450:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6AADD3151F;
        Tue, 21 Jun 2022 18:11:05 -0700 (PDT)
Received: by mail-wr1-x431.google.com with SMTP id w17so21183350wrg.7;
        Tue, 21 Jun 2022 18:11:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=YC/BC0ut4zFCpXZBrPnkhMqs1FiO6H+QzVtgFYbz5nU=;
        b=GvYFWsppXKJZ2uIo+QFSC7fjqDtt18IMKsg0aScb6ff04JS2hKbjmefTxEgOGHM9OL
         sRnrg7Ks8/0zgG4fiH/iC0j6FhVoDi+rI0CpD5L3stBpqsIvoZw/vX49Tw6NGPYvry2z
         EUlh0DgLtjSehF+050c5bG/0QsXwphOaZOi+0lRC0cs/khAm1XkV2SE5jOphomRJ47FW
         sUFJebvmlWt3zIOkHaGYoaxvKuJEtLV8fGS9VYNCpHR6BwYQAhU6Y/iGUVWlX9C/OE0C
         JBmTEFBznGUbYTQyWwBLRSsffCOECWJfgYNSnt/hYcVnCDHP9+bLNRRZ7h9RABTWl2W1
         AiWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=YC/BC0ut4zFCpXZBrPnkhMqs1FiO6H+QzVtgFYbz5nU=;
        b=sH4YUSZXKXsj3qCb1EuKH0T62F74Z/H15C5A6LeU8wVcIAgQ6FF0VMR1HSUSSeNae7
         FY+88dXXDWEvzuRF9tP/JMJ6P64a+2QxHD5i2Bg4UFD3SP6WH4Kearmf2NjGYYKzog0x
         SA+FYaDh2Twr9ELooGOY6t7GVoXSaWSoElvYfH9J2+Uz6wddQ1KrSCDFUkjMHOYPqNyq
         tt16OR6/d1fl/F0/AybrPRLOOMC2ug4pG+zZ3/cJ1MBh4m0Y3tOLwRNIM6ojujubuW1I
         14oQz6wCCMOH6GJ5WKZwU8Bmw60Yr+3ZbKPEFtwyR1Ir4Efc3Q588wOAqYyDfn0CMUy4
         mxGQ==
X-Gm-Message-State: AJIora9Yu1UXt4DY8FofgweU8zwBg5auAlhnhUcIqd42wcR5Fr3aIDxv
        eug/ZTPq1kQqNlPA2uSYfh4=
X-Google-Smtp-Source: AGRyM1tyijALZnxpm5d/xI5wzVlJ8yVf04+msGCD9rlWW03RO2oTzb/ITlZlh57VeVaFdApA4JYt0g==
X-Received: by 2002:adf:e6d2:0:b0:21b:9580:8d8b with SMTP id y18-20020adfe6d2000000b0021b95808d8bmr670736wrm.120.1655860263863;
        Tue, 21 Jun 2022 18:11:03 -0700 (PDT)
Received: from localhost.localdomain (93-42-70-190.ip85.fastwebnet.it. [93.42.70.190])
        by smtp.googlemail.com with ESMTPSA id x13-20020adfdd8d000000b0021b81855c1csm16560086wrl.27.2022.06.21.18.11.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Jun 2022 18:11:02 -0700 (PDT)
From:   Christian Marangi <ansuelsmth@gmail.com>
To:     Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Jens Axboe <axboe@kernel.dk>, Stephen Boyd <sboyd@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Christian Marangi <ansuelsmth@gmail.com>,
        =?UTF-8?q?=EF=BF=BDecki?= <rafal@milecki.pl>,
        Manivannan Sadhasivam <mani@kernel.org>,
        linux-mtd@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Rob Herring <robh@kernel.org>
Subject: [PATCH v6 2/3] dt-bindings: mtd: partitions: add additional example for qcom,smem-part
Date:   Wed, 22 Jun 2022 03:06:27 +0200
Message-Id: <20220622010628.30414-3-ansuelsmth@gmail.com>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20220622010628.30414-1-ansuelsmth@gmail.com>
References: <20220622010628.30414-1-ansuelsmth@gmail.com>
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

Add additional example for qcom,smem-part to declare a dynamic
partition to provide NVMEM cells for the commonly ART partition
provided by this parser.

Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>
Reviewed-by: Rob Herring <robh@kernel.org>
---
 .../mtd/partitions/qcom,smem-part.yaml        | 27 +++++++++++++++++++
 1 file changed, 27 insertions(+)

diff --git a/Documentation/devicetree/bindings/mtd/partitions/qcom,smem-part.yaml b/Documentation/devicetree/bindings/mtd/partitions/qcom,smem-part.yaml
index cf3f8c1e035d..dc07909af023 100644
--- a/Documentation/devicetree/bindings/mtd/partitions/qcom,smem-part.yaml
+++ b/Documentation/devicetree/bindings/mtd/partitions/qcom,smem-part.yaml
@@ -19,6 +19,10 @@ properties:
   compatible:
     const: qcom,smem-part
 
+patternProperties:
+  "^partition-[0-9a-z]+$":
+    $ref: partition.yaml#
+
 required:
   - compatible
 
@@ -31,3 +35,26 @@ examples:
             compatible = "qcom,smem-part";
         };
     };
+
+  - |
+    /* Example declaring dynamic partition */
+    flash {
+      partitions {
+        compatible = "qcom,smem-part";
+
+        partition-art {
+          compatible = "nvmem-cells";
+          #address-cells = <1>;
+          #size-cells = <1>;
+          label = "0:art";
+
+          macaddr_art_0: macaddr@0 {
+            reg = <0x0 0x6>;
+          };
+
+          macaddr_art_6: macaddr@6 {
+            reg = <0x6 0x6>;
+          };
+        };
+      };
+    };
-- 
2.36.1

