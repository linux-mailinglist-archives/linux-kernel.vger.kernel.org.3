Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2A67C553FE7
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Jun 2022 03:12:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355328AbiFVBLJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Jun 2022 21:11:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33832 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229917AbiFVBLE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Jun 2022 21:11:04 -0400
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com [IPv6:2a00:1450:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 439393191B;
        Tue, 21 Jun 2022 18:11:03 -0700 (PDT)
Received: by mail-wr1-x434.google.com with SMTP id i10so17445118wrc.0;
        Tue, 21 Jun 2022 18:11:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=K6qKElTJRH1xqsuMI22agJPVydPpDeCDPF+3KJh55+w=;
        b=AXviIowkwnwirSoG8qaa9h+NDYTQ9tN16Nn3dLJ8JdzE2ao2zmkrL4JUz27+qnsRgb
         yLdqaqX6RCty27iZJUdPlTqnWPdmtlS2jPxk6aoA9jcbsKfe97425ioKLF7GGB29HVyg
         nqNUnSbaXdXFB/Ps5UkUA6Nysug8Mr5Pqb1UdvsVrJCi+vHl69WfRjHfTmfx6AsfPfei
         oy/oWx7zIUXWiQrjGovYUp7Jz/OevNQktwxw4RPAQQqW6CaeYo+4by9dD2aG1QVqBL9p
         LbFHkupeQ0Sh07KCOAFAaYdBtkbvhSULg9tPGgP5h5Y0lj0Ap5WumkWS8D1Trk0BGHuB
         Bx6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=K6qKElTJRH1xqsuMI22agJPVydPpDeCDPF+3KJh55+w=;
        b=6zzmabQoii3orz1BRwEA/mxOmFqZhsMsf9VdqOtL8OOoZmH0xYjgsKsbhhmaWCQn3l
         mJRri39jgKhh1a15bQbtbWAtuxRN3Nc78MqdUy2fSNbHVEmhQkbGbsKGX+CFTgVaHT8c
         Alln6iDw/8Npv4WazseaAPA4zVlIfDw/hCbSrqyYKwzKSZ/qKGe3ZNG/mu2QxBc2HGsi
         W1cuuEEegSD2J8KvXRz23CKYk+yEUcZ1Ypua73Ah4kMQyc8AMSnlQUy233SyvdVkXjgp
         V8ruMgkoKzMZ4X8o270tqZrvDOSvnoS2SmceyEMLgBOU4B8Nvs/XyqNfB43zs5A/+Ibj
         VmvA==
X-Gm-Message-State: AJIora9KcivvZkmD98WOp+gRvF1i6b3lpzP+WkNNGCkZpAsAFX1WqMdB
        wei68/CjoL3TYLMm78w5U1g=
X-Google-Smtp-Source: AGRyM1tPWwN6F6KomkQo6rqcXzv6P/7t0b4jDz7Bg0/MyPftF12VjIvqZBCSTVVjBbxBkxss/OtHYg==
X-Received: by 2002:a5d:6d09:0:b0:21a:1321:55b6 with SMTP id e9-20020a5d6d09000000b0021a132155b6mr640978wrq.117.1655860261401;
        Tue, 21 Jun 2022 18:11:01 -0700 (PDT)
Received: from localhost.localdomain (93-42-70-190.ip85.fastwebnet.it. [93.42.70.190])
        by smtp.googlemail.com with ESMTPSA id x13-20020adfdd8d000000b0021b81855c1csm16560086wrl.27.2022.06.21.18.10.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Jun 2022 18:11:00 -0700 (PDT)
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
Subject: [PATCH v6 1/3] dt-bindings: mtd: partitions: support label/name only partition
Date:   Wed, 22 Jun 2022 03:06:26 +0200
Message-Id: <20220622010628.30414-2-ansuelsmth@gmail.com>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20220622010628.30414-1-ansuelsmth@gmail.com>
References: <20220622010628.30414-1-ansuelsmth@gmail.com>
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

Document new partition nodes that declare only the label/name instead
of the reg used to provide an OF node for partition registred at runtime
by parsers. This is required for nvmem system to declare and detect
nvmem-cells.

With these special partitions, the reg / offset is not required and a
'partition-' prefix is needed.
The node name with the 'partition-' prefix stripped, is used to match
the partition allocated by the parser at runtime and the parser will
provide reg and offset of the mtd.
If the partition to match contains invalid char for a node name, the
label binding can be used to declare the partition name.

NVMEM will use the data from the parser and provide the NVMEM cells
declared in the DTS, "connecting" the dynamic partition with a
static declaration of cells in them.

Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>
---
 .../bindings/mtd/partitions/partition.yaml    | 20 +++++++++++++++++--
 1 file changed, 18 insertions(+), 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/mtd/partitions/partition.yaml b/Documentation/devicetree/bindings/mtd/partitions/partition.yaml
index e1ac08064425..f1a02d840b12 100644
--- a/Documentation/devicetree/bindings/mtd/partitions/partition.yaml
+++ b/Documentation/devicetree/bindings/mtd/partitions/partition.yaml
@@ -11,6 +11,17 @@ description: |
   relative offset and size specified. Depending on partition function extra
   properties can be used.
 
+  A partition may be dynamically allocated by a specific parser at runtime.
+  In this specific case, a specific suffix is required to the node name.
+  Everything after 'partition-' will be used as the partition name to compare
+  with the one dynamically allocated by the specific parser.
+  If the partition contains invalid char a label can be provided that will
+  be used instead of the node name to make the comparison.
+  This is used to assign an OF node to the dynamiccally allocated partition
+  so that subsystem like NVMEM can provide an OF node and declare NVMEM cells.
+  The OF node will be assigned only if the partition label declared match the
+  one assigned by the parser at runtime.
+
 maintainers:
   - Rafał Miłecki <rafal@milecki.pl>
 
@@ -41,7 +52,12 @@ properties:
       immune to paired-pages corruptions
     type: boolean
 
-required:
-  - reg
+if:
+  not:
+    required: [ reg ]
+then:
+  properties:
+    $nodename:
+      pattern: '^partition-.*$'
 
 additionalProperties: true
-- 
2.36.1

