Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6342059A92B
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Aug 2022 01:15:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242986AbiHSXOn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 Aug 2022 19:14:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39596 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239403AbiHSXOa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Aug 2022 19:14:30 -0400
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com [IPv6:2a00:1450:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D068CD31C2
        for <linux-kernel@vger.kernel.org>; Fri, 19 Aug 2022 16:14:27 -0700 (PDT)
Received: by mail-wr1-x432.google.com with SMTP id h24so6710423wrb.8
        for <linux-kernel@vger.kernel.org>; Fri, 19 Aug 2022 16:14:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=conchuod.ie; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc;
        bh=wh/YppWbOFIra6XEEBi8TGN83nz+Cc+tSET8IzCpaZI=;
        b=W9D4Kf3qouskAMJZ3q6S/VeXqLdByauzGngx+X+7e6HXVLyRJp2qiV49imrSF0crmZ
         L+/lw+44dXb25H5IyJUD9JCCTqUzJA+1/oxrn1Ci9GzGUNH221jW2FkfphFIrHIejF7U
         ePmkg+areMAdab8CVPvpshz9cX8IBKJS5PaIZLQACojidQmF+bbc24BtVq+G33logClN
         ASxboCEXR/ooftCzJuSRf6o5XGW/B22Jh8rfq9tjHTZzNEsGhjbvZO3b6LnW5/tZqv4O
         tzWIHhx8HZxn4AmZouZVFEcaBTlSqJRDFKEQ2wi310TqNvc8s5m72sM67xTqkWIDnjim
         mBzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc;
        bh=wh/YppWbOFIra6XEEBi8TGN83nz+Cc+tSET8IzCpaZI=;
        b=XUczWoJjFYAyvifC3g6NvVzVxMxV+AP86A2BmPZshxGzAOnm0bKIz+rbPHo+UQATfc
         bU4Mqvtia35EFGyuTAs+HgG2b+wis332az/icRbspj6MKo5eLp6gEf8xvVtUkSevYKVs
         5+3CXNTGzA20sEBou+AkKrQ+bg/8ImFLvgabpHAmjoHKK/klD3VqH3/t3ND9xCpHNXmQ
         9CazjmHbhRqHYNCWI29q6J4D36eGX7v5Fa5iniDtzXvAxrxRQKYPVAEeUMF4d3OvFZkl
         5B001InwSgkiQzHtfE0MvIgQLhw0Hyx3cj446qbSiMva+Gp1f+vKliCP1KSdkiwnjRNF
         qy0g==
X-Gm-Message-State: ACgBeo2Ry5vUa98ZVCbPNzjwMDZPb4lgzl7SouicFMskjDoXXsT3jGEN
        uprr7FrcH8nJ6nZW7EuurHSwSQ==
X-Google-Smtp-Source: AA6agR7HfQWIne/Nx7aBs4qRkDfV2raD5Z03KapbYexai/QZpgSfagbRv6cbGle41aqc6xYQGADp0A==
X-Received: by 2002:a5d:64ca:0:b0:225:48a0:d9cb with SMTP id f10-20020a5d64ca000000b0022548a0d9cbmr98484wri.399.1660950866431;
        Fri, 19 Aug 2022 16:14:26 -0700 (PDT)
Received: from henark71.. ([109.76.58.63])
        by smtp.gmail.com with ESMTPSA id g17-20020a5d46d1000000b0020fff0ea0a3sm5198522wrs.116.2022.08.19.16.14.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Aug 2022 16:14:26 -0700 (PDT)
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
Subject: [PATCH v3 2/7] dt-bindings: PCI: microchip,pcie-host: fix missing clocks properties
Date:   Sat, 20 Aug 2022 00:14:11 +0100
Message-Id: <20220819231415.3860210-3-mail@conchuod.ie>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20220819231415.3860210-1-mail@conchuod.ie>
References: <20220819231415.3860210-1-mail@conchuod.ie>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Conor Dooley <conor.dooley@microchip.com>

Recent versions of dt-schema warn about unevaluatedProperties:
arch/riscv/boot/dts/microchip/mpfs-icicle-kit.dtb: pcie@2000000000: Unevaluated properties are not allowed ('clock-names', 'clocks', 'legacy-interrupt-controller', 'microchip,axi-m-atr0' were unexpected)
        From schema: Documentation/devicetree/bindings/pci/microchip,pcie-host.yaml

The clocks are required to enable interfaces between the FPGA fabric
and the core complex, so add them to the binding.

Fixes: 6ee6c89aac35 ("dt-bindings: PCI: microchip: Add Microchip PolarFire host binding")
Signed-off-by: Conor Dooley <conor.dooley@microchip.com>
---
dt-schema v2022.08 is required to replicate
---
 .../bindings/pci/microchip,pcie-host.yaml     | 27 +++++++++++++++++++
 1 file changed, 27 insertions(+)

diff --git a/Documentation/devicetree/bindings/pci/microchip,pcie-host.yaml b/Documentation/devicetree/bindings/pci/microchip,pcie-host.yaml
index edb4f81253c8..6fbe62f4da93 100644
--- a/Documentation/devicetree/bindings/pci/microchip,pcie-host.yaml
+++ b/Documentation/devicetree/bindings/pci/microchip,pcie-host.yaml
@@ -25,6 +25,33 @@ properties:
       - const: cfg
       - const: apb
 
+  clocks:
+    description:
+      Fabric Interface Controllers, FICs, are the interface between the FPGA
+      fabric and the core complex on PolarFire SoC. The FICs require two clocks,
+      one from each side of the interface. The "FIC clocks" described by this
+      property are on the core complex side & communication through a FIC is not
+      possible unless it's corresponding clock is enabled. A clock must be
+      enabled for each of the interfaces the root port is connected through.
+      This could in theory be all 4 interfaces, one interface or any combination
+      in between.
+    minItems: 1
+    items:
+      - description: FIC0's clock
+      - description: FIC1's clock
+      - description: FIC2's clock
+      - description: FIC3's clock
+
+  clock-names:
+    description:
+      As any FIC connection combination is possible, the names should match the
+      order in the clocks property and take the form "ficN" where N is a number
+      0-3
+    minItems: 1
+    maxItems: 4
+    items:
+      pattern: '^fic[0-3]$'
+
   interrupts:
     minItems: 1
     items:
-- 
2.37.1

