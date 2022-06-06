Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D3C6553EA92
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Jun 2022 19:09:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240382AbiFFPOv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Jun 2022 11:14:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47896 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240345AbiFFPOn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Jun 2022 11:14:43 -0400
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com [IPv6:2a00:1450:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B5B35DEEB1;
        Mon,  6 Jun 2022 08:14:42 -0700 (PDT)
Received: by mail-ej1-x62b.google.com with SMTP id y19so29580587ejq.6;
        Mon, 06 Jun 2022 08:14:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=wdA5SSs2A+GftYSjZhbZ3WXsisBDCmDB/JAxOYIkUdU=;
        b=Erz1QKme2uzu1CL53DykcnrB+qfgjJVnrpzSTvOrs+a/I69PggV9QsYYLXjzqxHebU
         atO+cXtLR7n5ZB6wEgQ6IdC7lYVVlOBMbGAAUyXlYZBNl1FZgYz6TyUWfIAqXNbSXL2T
         UG9Zo2iohTfIMSlrKX2DPboaZgVGBb57qjEyd0DhZMoYf7eWWUNrKmfleK2dDnVruHHs
         bK7wxDw/KOtX5hkmXJrnkVW4hhXZ9DQR3zktMyBdMGmPnvC6GGaeQLXbYSn1zNDASMZK
         hNDcpkbLwl71VmMIITEVDlEXBFz0CGCrQ9VkpyBbLzCgSGeilwXFVz9GQVUfu8L4dHTp
         7DzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=wdA5SSs2A+GftYSjZhbZ3WXsisBDCmDB/JAxOYIkUdU=;
        b=evtPmtFBR/UiziSpdssWZnMGh9vRui6yLULDniENbx27wNsWuY8VH3SOGZOfYX7ZYX
         Kj79dUnGrLe6P+CnBhAUrksHpCFdkQmXo2uAjCfTS1XVXFET+5Fll/2n7JmlQ0XNXiyi
         etL/xQtVtqVn6IutL6/Bqe9pxvcL07oa5iuohZ/0GUjWvCIuoikRD0Cswg67l0nAU7vf
         GXkCmmzKu6QDUlUSjS+GiQzBZKUIadjlLdpfhFxZIDXN+fZZi8GKrjDX7HnmHOJHq2un
         NqgMEsNEsmAhMraFxSotgOmF7/KiN0qbX4K1shbRFLZXpp8o/XgLSqEI7CP2U4+VU24A
         gvBA==
X-Gm-Message-State: AOAM533PzQkzZYKftPB1zbbAe8H9Gf/NkbmrIQI4K/xSSVm/sfXFwpQF
        YP1lp9YQvR/Z8CZBknsa6YM=
X-Google-Smtp-Source: ABdhPJyt2liP+1F1RvMMxu7z+WgrxpjuApud9EFnbwkjgtInQOBqMpdZdFYR9tePcSfc/J8YciKCbQ==
X-Received: by 2002:a17:906:8301:b0:6e4:896d:59b1 with SMTP id j1-20020a170906830100b006e4896d59b1mr21131479ejx.396.1654528481019;
        Mon, 06 Jun 2022 08:14:41 -0700 (PDT)
Received: from localhost.localdomain (93-42-70-190.ip85.fastwebnet.it. [93.42.70.190])
        by smtp.googlemail.com with ESMTPSA id be5-20020a0564021a2500b0042e09f44f81sm7494001edb.38.2022.06.06.08.14.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Jun 2022 08:14:40 -0700 (PDT)
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
Subject: [PATCH v5 1/3] dt-bindings: mtd: partitions: Support label only partition
Date:   Mon,  6 Jun 2022 17:14:15 +0200
Message-Id: <20220606151417.19227-2-ansuelsmth@gmail.com>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20220606151417.19227-1-ansuelsmth@gmail.com>
References: <20220606151417.19227-1-ansuelsmth@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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

Document new partition nodes that declare only the label instead of the
reg used to provide an OF node for partition registred at runtime by
parsers. This is required for nvmem system to declare and detect
nvmem-cells.

With these special partitions, the reg / offset is not required.
The label binding is used to match the partition allocated by the
parser at runtime and the parser will provide reg and offset of the mtd.

NVMEM will use the data from the parser and provide the NVMEM cells
declared in the DTS, "connecting" the dynamic partition with a
static declaration of cells in them.

Signed-off-by: Ansuel Smith <ansuelsmth@gmail.com>
---
 .../bindings/mtd/partitions/partition.yaml       | 16 ++++++++++++++--
 1 file changed, 14 insertions(+), 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/mtd/partitions/partition.yaml b/Documentation/devicetree/bindings/mtd/partitions/partition.yaml
index e1ac08064425..bff6fb980e6b 100644
--- a/Documentation/devicetree/bindings/mtd/partitions/partition.yaml
+++ b/Documentation/devicetree/bindings/mtd/partitions/partition.yaml
@@ -11,6 +11,13 @@ description: |
   relative offset and size specified. Depending on partition function extra
   properties can be used.
 
+  A partition may be dynamically allocated by a specific parser at runtime.
+  In this specific case, the label is required instead of the reg.
+  This is used to assign an OF node to the dynamiccally allocated partition
+  so that subsystem like NVMEM can provide an OF node and declare NVMEM cells.
+  The OF node will be assigned only if the partition label declared match the
+  one assigned by the parser at runtime.
+
 maintainers:
   - Rafał Miłecki <rafal@milecki.pl>
 
@@ -22,6 +29,8 @@ properties:
   label:
     description: The label / name for this partition. If omitted, the label
       is taken from the node name (excluding the unit address).
+      With dynamically allocated partition the label is required and won't
+      fallback to the node name.
 
   read-only:
     description: This parameter, if present, is a hint that this partition
@@ -41,7 +50,10 @@ properties:
       immune to paired-pages corruptions
     type: boolean
 
-required:
-  - reg
+if:
+  not:
+    required: [ reg ]
+then:
+  required: [ label ]
 
 additionalProperties: true
-- 
2.36.1

