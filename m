Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E18AF564347
	for <lists+linux-kernel@lfdr.de>; Sun,  3 Jul 2022 01:13:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230000AbiGBXMu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 2 Jul 2022 19:12:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58352 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230405AbiGBXMo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 2 Jul 2022 19:12:44 -0400
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com [IPv6:2a00:1450:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AD282BC21;
        Sat,  2 Jul 2022 16:12:42 -0700 (PDT)
Received: by mail-ed1-x52a.google.com with SMTP id z19so7116207edb.11;
        Sat, 02 Jul 2022 16:12:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=id5EAPhh+vCKRnSjZnH7hfilYjwKLu84ggjPXCm1/G8=;
        b=nqQ/bOLiokYQHiRMikb/oKWZA7po0z9WQaPyd7gHXSxKhnxKZwj5pbqWmmi5WyvTWa
         JuR1x9lISJwH6sX5265PcrMon9Q3RYmteK+hoS7l1kUAEfRzgVSxDTv3/pOzIlBYSq7k
         PGHHW4RUdqtYE2ai9jd6BZDX/KqtibFqeoVQQKTgUwey/+YSzfCxmD6rin3sgPo96oIV
         HFx06479WhIXrdj5ca2y2fQigIs2mDzb9r7nrrdu6kY3UCYKgIkR6hWrMAjbBxkzg4Ea
         oKKliTVTmdIjEfJUHBXWXNOJce+hSmqEYLkX89cFmcbdHmjVZPAi6NYZALT4lpnRYp4Q
         rKiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=id5EAPhh+vCKRnSjZnH7hfilYjwKLu84ggjPXCm1/G8=;
        b=RB0EmUHyBKhUVUmNT3B4mRT7tpxVKl3yDVe4a/ItmDDQHBC7KQZKarx4b91d6dBHOG
         Vcc1zT+U8nf5mIMB4L99DdpMzVOdP2p2yw+PgdipgLjK7Qtg9SVzqaRvZjSZooUz9++U
         lKveddggysfftaKix7Gs46BCtXhIQFalLq5bxQUCtPAIJq0Vl7xTA40rQXffcMIdI0Ct
         6qaFtj5rMGOrVKZRx6Mu7G9DPbpDLpKlnhzd8YR1TWR2EdcywLVsnZBNUj22whOL8Ttn
         G6QyROW29cy3YjtiXr5+5ozSc/QHbqWpfsY/xHAsuu5AR9zHtCQukLknLN6UIZckGpCG
         4A3A==
X-Gm-Message-State: AJIora97/yAqOBAqFi/1m04XF4X2qrxs3Kl487gONNrVcZeNcJ4RChDJ
        WZaS0g+ufwgs1a+3Rz+QS34=
X-Google-Smtp-Source: AGRyM1s+PfHINkPK2o4Y9IrDNSoTxUsuRjB6Y56Vre6odL3SEEJp4RM55pYz5yPKUY9OP6eBFSY1pw==
X-Received: by 2002:a05:6402:1e88:b0:435:bf05:f0f with SMTP id f8-20020a0564021e8800b00435bf050f0fmr28367231edf.2.1656803561139;
        Sat, 02 Jul 2022 16:12:41 -0700 (PDT)
Received: from localhost.localdomain (dynamic-2a01-0c23-c4d4-2700-f22f-74ff-fe21-0725.c23.pool.telefonica.de. [2a01:c23:c4d4:2700:f22f:74ff:fe21:725])
        by smtp.googlemail.com with ESMTPSA id uz12-20020a170907118c00b00711aed17047sm12234329ejb.28.2022.07.02.16.12.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 02 Jul 2022 16:12:40 -0700 (PDT)
From:   Martin Blumenstingl <martin.blumenstingl@googlemail.com>
To:     linux-mtd@lists.infradead.org, devicetree@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, tlanger@maxlinear.com,
        rtanwar@maxlinear.com, miquel.raynal@bootlin.com, richard@nod.at,
        vigneshr@ti.com,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Subject: [PATCH v3 1/8] dt-bindings: mtd: intel: lgm-nand: Fix compatible string
Date:   Sun,  3 Jul 2022 01:12:20 +0200
Message-Id: <20220702231227.1579176-2-martin.blumenstingl@googlemail.com>
X-Mailer: git-send-email 2.37.0
In-Reply-To: <20220702231227.1579176-1-martin.blumenstingl@googlemail.com>
References: <20220702231227.1579176-1-martin.blumenstingl@googlemail.com>
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

The driver which was added at the same time as the dt-bindings uses the
compatible string "intel,lgm-ebunand". Use the same compatible string
also in the dt-bindings and rename the bindings file accordingly.

Fixes: 2f9cea8eae44f5 ("dt-bindings: mtd: Add Nand Flash Controller support for Intel LGM SoC")
Signed-off-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
---
 .../mtd/{intel,lgm-nand.yaml => intel,lgm-ebunand.yaml}     | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)
 rename Documentation/devicetree/bindings/mtd/{intel,lgm-nand.yaml => intel,lgm-ebunand.yaml} (92%)

diff --git a/Documentation/devicetree/bindings/mtd/intel,lgm-nand.yaml b/Documentation/devicetree/bindings/mtd/intel,lgm-ebunand.yaml
similarity index 92%
rename from Documentation/devicetree/bindings/mtd/intel,lgm-nand.yaml
rename to Documentation/devicetree/bindings/mtd/intel,lgm-ebunand.yaml
index 30e0c66ab0eb..763ee3e1faf3 100644
--- a/Documentation/devicetree/bindings/mtd/intel,lgm-nand.yaml
+++ b/Documentation/devicetree/bindings/mtd/intel,lgm-ebunand.yaml
@@ -1,7 +1,7 @@
 # SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
 %YAML 1.2
 ---
-$id: http://devicetree.org/schemas/mtd/intel,lgm-nand.yaml#
+$id: http://devicetree.org/schemas/mtd/intel,lgm-ebunand.yaml#
 $schema: http://devicetree.org/meta-schemas/core.yaml#
 
 title: Intel LGM SoC NAND Controller Device Tree Bindings
@@ -14,7 +14,7 @@ maintainers:
 
 properties:
   compatible:
-    const: intel,lgm-nand
+    const: intel,lgm-ebunand
 
   reg:
     maxItems: 6
@@ -75,7 +75,7 @@ additionalProperties: false
 examples:
   - |
     nand-controller@e0f00000 {
-      compatible = "intel,lgm-nand";
+      compatible = "intel,lgm-ebunand";
       reg = <0xe0f00000 0x100>,
             <0xe1000000 0x300>,
             <0xe1400000 0x8000>,
-- 
2.37.0

