Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 683AB596275
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Aug 2022 20:27:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236832AbiHPS0Q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 Aug 2022 14:26:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45768 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236559AbiHPS0F (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Aug 2022 14:26:05 -0400
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com [IPv6:2a00:1450:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 16871868B9
        for <linux-kernel@vger.kernel.org>; Tue, 16 Aug 2022 11:25:58 -0700 (PDT)
Received: by mail-wr1-x42a.google.com with SMTP id n4so13574967wrp.10
        for <linux-kernel@vger.kernel.org>; Tue, 16 Aug 2022 11:25:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=conchuod.ie; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc;
        bh=d9TppbXdiWPs+48x7U6F2RLRbtXIB7UvU4Wm4rVvtl0=;
        b=f2AlxGScpJunozXwr3OLri+tVAp8DP91ryrotY2//J2fi1OUCt1LNagskuDqphhkZT
         YrquLa/5e3kZ0mNDTpe8BZPCqsenNm2Iz6veDpmpJ2eS1/XvlY9RG0X5z1/PE71xJM/z
         T89NIgNPpq6E+d39MQKxfD7TWO20cghUHmkysLjgO3lWV5s7Rl+R6uqjodyd8Uo9Phd8
         3Jpqpdld6ng03AVC6cciJzWfKieF0XVANREG8RAcZlM+uEsFPf0miZbDNl9GDQcXyNWL
         1Gy9OFXRx+voQGCrcVvklEEfQh2gOjJjjJeoID3OXAAvB/6mk0/QFGfKnDLEXI1kcD03
         MiRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc;
        bh=d9TppbXdiWPs+48x7U6F2RLRbtXIB7UvU4Wm4rVvtl0=;
        b=g4NsrOota8Bn580kkwVyYdh9n+n7v2tO8VGYcx+klllr7FCmQQ9eURakiiubjlCMIg
         Kacp1oT019Pf6VVNim6eplTuQJrc1jhgOrCq1lLa8VIY3R4o/LxkZOAn/sUPr1eaYCcL
         wyEnE4tdQUecU9K+oMx300sWmR2ylWndVs1GbKq++ojPeGQd8HSC8QGXxCU1m12ENGPv
         L43DxlPYTx8TxHb2ZPRfhQysJF1bW1OdZjNxSpleDv6d7zVkuxwqee2gn8CA+H+ieFVB
         oCz0mLfp00fxm+iWYS4GNpq3J61pN3MyV/hQ5EbJHWC/wK+TrmdfNNI0gd+e4wlCLryT
         eB+Q==
X-Gm-Message-State: ACgBeo36Dgy2BaS5f/Rn1Rl8nB2dxvj+S+oR+iavp7utMY6vlwx7IFlU
        91B/Ny1VGPpifVRKdZ0bIWBWUoRZn3ln+Iym
X-Google-Smtp-Source: AA6agR5I+KbBV3e/0Gh9/t5/+sRspQ2mbNFQlQO0aX1NckIqMfw5q/VrA8Cv5/N3BXLfG6j4FPECGg==
X-Received: by 2002:a05:6000:1152:b0:220:6421:ccdc with SMTP id d18-20020a056000115200b002206421ccdcmr12322712wrx.61.1660674356514;
        Tue, 16 Aug 2022 11:25:56 -0700 (PDT)
Received: from henark71.. ([109.76.58.63])
        by smtp.gmail.com with ESMTPSA id s17-20020a1cf211000000b003a603fbad5bsm4015482wmc.45.2022.08.16.11.25.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Aug 2022 11:25:55 -0700 (PDT)
From:   Conor Dooley <mail@conchuod.ie>
To:     Daire McNamara <daire.mcnamara@microchip.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Greentime Hu <greentime.hu@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        Conor Dooley <conor.dooley@microchip.com>
Cc:     linux-pci@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org
Subject: [PATCH v2 1/6] dt-bindings: PCI: fu740-pci: fix missing clock-names
Date:   Tue, 16 Aug 2022 19:25:43 +0100
Message-Id: <20220816182547.3454843-2-mail@conchuod.ie>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20220816182547.3454843-1-mail@conchuod.ie>
References: <20220816182547.3454843-1-mail@conchuod.ie>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Conor Dooley <conor.dooley@microchip.com>

The commit b92225b034c0 ("dt-bindings: PCI: designware: Fix
'unevaluatedProperties' warnings") removed the clock-names property as
a requirement and from the example as it triggered unevaluatedProperty
warnings. dtbs_check was not able to pick up on this at the time, but
now can:

arch/riscv/boot/dts/sifive/hifive-unmatched-a00.dtb: pcie@e00000000: Unevaluated properties are not allowed ('clock-names' was unexpected)
        From schema: linux/Documentation/devicetree/bindings/pci/sifive,fu740-pcie.yaml

The property was already in use by the FU740 DTS and the clock must be
enabled. The Linux driver does not use this property, but outside of
the kernel this property may have users. Re-add the property and its
"clocks" dependency.

Fixes: b92225b034c0 ("dt-bindings: PCI: designware: Fix 'unevaluatedProperties' warnings")
Fixes: 43cea116be0b ("dt-bindings: PCI: Add SiFive FU740 PCIe host controller")
Signed-off-by: Conor Dooley <conor.dooley@microchip.com>
---
v2022.08 of dt-schema is required.
---
 .../devicetree/bindings/pci/sifive,fu740-pcie.yaml          | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/Documentation/devicetree/bindings/pci/sifive,fu740-pcie.yaml b/Documentation/devicetree/bindings/pci/sifive,fu740-pcie.yaml
index 195e6afeb169..c7a9a2dc0fa6 100644
--- a/Documentation/devicetree/bindings/pci/sifive,fu740-pcie.yaml
+++ b/Documentation/devicetree/bindings/pci/sifive,fu740-pcie.yaml
@@ -51,6 +51,12 @@ properties:
     description: A phandle to the PCIe power up reset line.
     maxItems: 1
 
+  clocks:
+    maxItems: 1
+
+  clock-names:
+    const: pcie_aux
+
   pwren-gpios:
     description: Should specify the GPIO for controlling the PCI bus device power on.
     maxItems: 1
-- 
2.37.1

