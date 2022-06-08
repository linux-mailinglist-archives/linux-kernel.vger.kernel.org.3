Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 512A8542624
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Jun 2022 08:56:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1381135AbiFHCYW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Jun 2022 22:24:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37662 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1445089AbiFHCLx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Jun 2022 22:11:53 -0400
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com [IPv6:2a00:1450:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 14A3C256;
        Tue,  7 Jun 2022 17:11:36 -0700 (PDT)
Received: by mail-ed1-x535.google.com with SMTP id er5so24954288edb.12;
        Tue, 07 Jun 2022 17:11:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=VT+TJ2YPzEHYu6mfTNmRiV87DaEKHXEmDZv9wBUUtRQ=;
        b=GEglJBzl8OexIR2XmXIjrv+3Sx+kxYIAVp6AdIhzFr16qtQ+Pq/e77w27Y4/CXX4kO
         WAPRijgPiY7bobSDLntH5kMszmjJ2CdgUX7lycTCp+LZ8YiZ6/KiG4O3MI+z0uaXHwM7
         Bi7pcq7N95HyMmluTB2GldmjNdFiKgIMthD3ETU1HChZ2eBi4maTmHluS5SL+qyK0mPn
         l320QhFpBMZc+HR4h0MdMt/XbROcxuW5cZaBZ3/fMSXCkG9RHR4r2DM29tN+0FQc9Sks
         R+atxDxJYOeVjagZqROXp1jtkKIN6JvcMSZJuMQ5oiTdmckizVw5BsIYC9PwOJv0HkV7
         Uw0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=VT+TJ2YPzEHYu6mfTNmRiV87DaEKHXEmDZv9wBUUtRQ=;
        b=SzzF0MqphOeBaG1RYHc4XlhJZlDdCXhQtvZjkOU4jlGYWpYQM2gln0rq4cnW6oMmHM
         Yr0TXAZrVBFaUwXrrfAqXqZLC9NgR4B+cyNxb10jFtmfRFuleqFbtWPkspOU4RkwT7Yb
         k8lZuG+P9YuJlZCDpf4xLpD1jc4aVAsXk97UyMXAk5CD9Se6Bkz/GUVu8iNQHJnUG9Hp
         h2tR8MywUzDaZRKGSCRlqTzeehKuKMHn2asuJDzC/lgTwMWXa6f9PZPtST79SaDCB6Ej
         Y4cYE2GXdUs/zQkfkDAhoBy+zW8AS0waaZYw9BsKUMFNyYk8ON8ggVkRoNrL3fuT1+NF
         E8Bg==
X-Gm-Message-State: AOAM5328eJdK4hFnr2Llt1t8E+M+SNVu+4itLNyeRcybkv5Bqwb7Txpx
        BgiEY5HIAnlA3VnNtyVA6mo=
X-Google-Smtp-Source: ABdhPJzPTDrtaU23PFJ1myspJOaO4RQMfMVyIo7KO2l7BrqW0kv/Armfp+wyKBcB7iulRGwDplacOA==
X-Received: by 2002:a05:6402:3207:b0:42d:dba6:8ef0 with SMTP id g7-20020a056402320700b0042ddba68ef0mr36944296eda.410.1654647094506;
        Tue, 07 Jun 2022 17:11:34 -0700 (PDT)
Received: from localhost.localdomain (93-42-70-190.ip85.fastwebnet.it. [93.42.70.190])
        by smtp.googlemail.com with ESMTPSA id o19-20020a1709061b1300b006fed85c1a8fsm8434947ejg.202.2022.06.07.17.11.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Jun 2022 17:11:34 -0700 (PDT)
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
Subject: [PATCH v5 2/3] dt-bindings: mtd: qcom_nandc: document qcom,boot-partitions binding
Date:   Wed,  8 Jun 2022 02:10:29 +0200
Message-Id: <20220608001030.18813-3-ansuelsmth@gmail.com>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20220608001030.18813-1-ansuelsmth@gmail.com>
References: <20220608001030.18813-1-ansuelsmth@gmail.com>
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
---
 .../devicetree/bindings/mtd/qcom,nandc.yaml   | 26 +++++++++++++++++++
 1 file changed, 26 insertions(+)

diff --git a/Documentation/devicetree/bindings/mtd/qcom,nandc.yaml b/Documentation/devicetree/bindings/mtd/qcom,nandc.yaml
index 84ad7ff30121..a0914ccb95b0 100644
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
+
+            Refer to the ipq8064 example on how to use this special binding.
+
 required:
   - compatible
   - reg
@@ -135,6 +159,8 @@ examples:
         nand-ecc-strength = <4>;
         nand-bus-width = <8>;
 
+        qcom,boot-partitions = <0x0 0x58a0000>;
+
         partitions {
           compatible = "fixed-partitions";
           #address-cells = <1>;
-- 
2.36.1

