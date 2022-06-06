Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 70AE753E75A
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Jun 2022 19:07:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240398AbiFFPO5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Jun 2022 11:14:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48062 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240363AbiFFPOp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Jun 2022 11:14:45 -0400
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com [IPv6:2a00:1450:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EFCCABE14E;
        Mon,  6 Jun 2022 08:14:43 -0700 (PDT)
Received: by mail-ed1-x532.google.com with SMTP id fd25so19277467edb.3;
        Mon, 06 Jun 2022 08:14:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=IvilBWGAnBlRQU+9jyrl5Is4xvOjLGN9x8U2mNdKUuA=;
        b=bi9r+qtN/YEFgZKvHG34WS3p/giaGxSArRaYglAT7nz4PQ/VsYlL8SUk7w1Io9htm/
         muhxQTp2qWsVdZiCnQuwTWrkk7r5MnUooK67tZwH9DEJnwK27j9dgngYu6KF6db8+F31
         AWLbtIXSy/7KMzNKc5Nu9j7RcfGILCbM/zwAcz1Oh9cJiGMjYUKdEZAY7N+ZRrQ7Czkm
         2hjy8FFI+KoJs2mOuMWhq5h1Won/1Mhlj1cfD4W5Co5Zy4FqYglj8PPH9DdMP4KLiGn7
         +zw4HLSP2WBActg5VfNCP8JfC6J3mntx3a0vTD/g2319ASx0z7a88G8Ab00tKRaHdLk4
         G4Mw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=IvilBWGAnBlRQU+9jyrl5Is4xvOjLGN9x8U2mNdKUuA=;
        b=UhTSajYCXev50BV7wFkyhWFQkFB6yRhJKTE83pV1DdlTGcDjWARPGsStUlcQKhuMOU
         utbWQto+IdBIvAmfDlG4KJoorbYg0FMclaFcT5MC6qL11/Uq3N2uBsokf7PHRrIG3AD2
         SNoRplgituQ8XMtanmdqJlIRG7WuugpxZAwo7doiPaDi0hrd1jgema4L7XCBYzedUBj2
         3bAGfD8mqd0HZBzaTU9eRLhC42fUZDcNHdg0FeVvnqgDCl9Dwbyx8Y7mxjbjzZv6mxk+
         5+73g1Vj5mOpd6kizLRkHS48/kFVGJCCIjg2nIbq2vbZC+6TIc/P2H6vhbZg70j/aM3y
         EvYA==
X-Gm-Message-State: AOAM530HI/B5YVrSEanK+hHi0GnGXVymSyiz3jb6Jh9tk/0HrUrQ58lA
        odqgNK3IFDgC4DKiGX/O9fI=
X-Google-Smtp-Source: ABdhPJyvopiVyT4O43UNksA7O6pjAK73X83wxSdwvAO1QFgjxLTOD7mUL678+d8kzQ3Qa2X+T1FOiA==
X-Received: by 2002:a50:fc0d:0:b0:42d:c1ae:28bc with SMTP id i13-20020a50fc0d000000b0042dc1ae28bcmr28023125edr.24.1654528482474;
        Mon, 06 Jun 2022 08:14:42 -0700 (PDT)
Received: from localhost.localdomain (93-42-70-190.ip85.fastwebnet.it. [93.42.70.190])
        by smtp.googlemail.com with ESMTPSA id be5-20020a0564021a2500b0042e09f44f81sm7494001edb.38.2022.06.06.08.14.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Jun 2022 08:14:41 -0700 (PDT)
From:   Ansuel Smith <ansuelsmth@gmail.com>
To:     Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jens Axboe <axboe@kernel.dk>,
        Ansuel Smith <ansuelsmth@gmail.com>,
        =?UTF-8?q?=EF=BF=BDecki?= <rafal@milecki.pl>,
        Manivannan Sadhasivam <mani@kernel.org>,
        linux-mtd@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v5 2/3] dt-bindings: mtd: partitions: add additional example for qcom,smem-part
Date:   Mon,  6 Jun 2022 17:14:16 +0200
Message-Id: <20220606151417.19227-3-ansuelsmth@gmail.com>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20220606151417.19227-1-ansuelsmth@gmail.com>
References: <20220606151417.19227-1-ansuelsmth@gmail.com>
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

Signed-off-by: Ansuel Smith <ansuelsmth@gmail.com>
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

