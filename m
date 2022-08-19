Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C82A259A919
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Aug 2022 01:15:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243603AbiHSXOr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 Aug 2022 19:14:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39586 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239686AbiHSXOa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Aug 2022 19:14:30 -0400
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com [IPv6:2a00:1450:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 56A6DDB066
        for <linux-kernel@vger.kernel.org>; Fri, 19 Aug 2022 16:14:29 -0700 (PDT)
Received: by mail-wr1-x433.google.com with SMTP id k16so6699262wrx.11
        for <linux-kernel@vger.kernel.org>; Fri, 19 Aug 2022 16:14:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=conchuod.ie; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc;
        bh=DWhXZZFAZhCnIU4fgoPIE8pwmZNnfCyeRQd6/ThxbP8=;
        b=TlHri4rXXzgpOkPtCLjuGJ1mPrjJL/4KdH3rMQIdvOOrOUXEki8NgXCDfrl8xltG/Y
         xyRc7iJvLuKqvcNsrzPpTNM/lfOcWd0/QRQehj2lGgmGG3fpL+6Wyu3BzVOASjMNKWCk
         apFHqHXAp25MLTIzwJz1KuT2wyu0K4KOSuIdtKD+Y3T7osGjaVIj2gOTEJds0qmjFanA
         mQ3SNn3CZ8Ytc3f1+nbzwv1XAduJ00V1IG7vGfMkLMl3uPwJdfZzpo6yP/e7bMBKxR/S
         1ptgZmk15AnDXat7ziGc19VedjhfPSzcS+Ckv/T2r9yM/7TqqikNV3W35ELd2QHKCtIN
         DYWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc;
        bh=DWhXZZFAZhCnIU4fgoPIE8pwmZNnfCyeRQd6/ThxbP8=;
        b=gmlv+VvjXWQfX2YUretmVcTjxjuHV/WExhQ9p/8SbgqBVvgSYcEuj8dmr82NW+TOX5
         3Ji9KkfIaLFPcbOag4+jXgZv53BopbnFyLSeIIz/D1caL24en0r+SsgXeIgjYjFDi53J
         BLrsDxGFq6KnPmUe/xw8C5wBgoKNMT3Jspos+VHTCtiUlPdJLHJ336GltK8uHc9lF53z
         Xw7Sie7Luogh244uOhn7kFzDpEqcKchf6hhWIrXxqVmp7AodGrla35Ql1ClspkQWZ6hx
         LXpypln10VIs8ippKoAFzYF3AC+tyWnr0vQdEHKMLPclKd/G9ZWcEiLDU920cnuTcuhm
         6y3w==
X-Gm-Message-State: ACgBeo0L8ZFrAjMzuNwot+q7S2C/RizujqXDLEskda5MPwpHI+FhU6L6
        vHRxlobY2G+CDDo0hQpD2C3q5Q==
X-Google-Smtp-Source: AA6agR4v+IICZ3bclYWDQkb0DGxyv2hQHAvTlMTrWB2qMnF7A2A2AVYqWTgQXMw3/HeIhAsI5Ns4lw==
X-Received: by 2002:a05:6000:80b:b0:21e:d62e:b282 with SMTP id bt11-20020a056000080b00b0021ed62eb282mr5271465wrb.557.1660950867592;
        Fri, 19 Aug 2022 16:14:27 -0700 (PDT)
Received: from henark71.. ([109.76.58.63])
        by smtp.gmail.com with ESMTPSA id g17-20020a5d46d1000000b0020fff0ea0a3sm5198522wrs.116.2022.08.19.16.14.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Aug 2022 16:14:27 -0700 (PDT)
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
Subject: [PATCH v3 3/7] dt-bindings: PCI: microchip,pcie-host: fix missing dma-ranges
Date:   Sat, 20 Aug 2022 00:14:12 +0100
Message-Id: <20220819231415.3860210-4-mail@conchuod.ie>
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

The dma-ranges property was missed when adding the binding initially.
The root port can use up to 6 address translation tables, depending on
configuration.

Link: https://www.microsemi.com/document-portal/doc_download/1245812-polarfire-fpga-and-polarfire-soc-fpga-pci-express-user-guide # Section 1.3.3
Fixes: 6ee6c89aac35 ("dt-bindings: PCI: microchip: Add Microchip PolarFire host binding")
Signed-off-by: Conor Dooley <conor.dooley@microchip.com>
---
 .../devicetree/bindings/pci/microchip,pcie-host.yaml          | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/Documentation/devicetree/bindings/pci/microchip,pcie-host.yaml b/Documentation/devicetree/bindings/pci/microchip,pcie-host.yaml
index 6fbe62f4da93..23d95c65acff 100644
--- a/Documentation/devicetree/bindings/pci/microchip,pcie-host.yaml
+++ b/Documentation/devicetree/bindings/pci/microchip,pcie-host.yaml
@@ -67,6 +67,10 @@ properties:
   ranges:
     maxItems: 1
 
+  dma-ranges:
+    minItems: 1
+    maxItems: 6
+
   msi-controller:
     description: Identifies the node as an MSI controller.
 
-- 
2.37.1

