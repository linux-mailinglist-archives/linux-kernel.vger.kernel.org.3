Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C6A254DDED3
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Mar 2022 17:25:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239186AbiCRQZg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Mar 2022 12:25:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39306 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237327AbiCRQZY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Mar 2022 12:25:24 -0400
Received: from smtp-relay-internal-1.canonical.com (smtp-relay-internal-1.canonical.com [185.125.188.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 90A1F30DC65
        for <linux-kernel@vger.kernel.org>; Fri, 18 Mar 2022 09:21:26 -0700 (PDT)
Received: from mail-lf1-f72.google.com (mail-lf1-f72.google.com [209.85.167.72])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id A9E423F1F6
        for <linux-kernel@vger.kernel.org>; Fri, 18 Mar 2022 16:21:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1647620483;
        bh=O5YEItFojELUQ2ZVAdFWmd7QnNJFa0nT8LdWFM6nccM=;
        h=From:To:Cc:Subject:Date:Message-Id:MIME-Version;
        b=c/fOo4zU9mb8jCYfW0YF/+tCrIWepDwaZCTXRnDu6eiyG+GMG/LwSvrSA4coqCzdX
         mg7q6D75Um+FkhqFAIUY35qd5QhMq9aD6Eb9C3DwF+JxR1Fd8/Xw0mAwo4ZLIvfEZo
         X6FDhgpw0rf3V0jchz4aEYOliC4+7nXzlN/WoxHxGBWsEyfnMJMLH4Wwlfm/NwPCL4
         yz1IVWkY98rlMSYgkNvbOPDJxov9ZXke2OSTkMMQ40XlHkG4uzKzTSw6o/3ilQkfMk
         3hq5AvlqlrRzVSzT3UT+X/0vvs+POxCZPNCSb1mb7Z9/mAmojgnIZ+XOUgBO6BihGz
         H0IIZ/wiRq0xA==
Received: by mail-lf1-f72.google.com with SMTP id d14-20020a05651233ce00b004475964142aso2729660lfg.21
        for <linux-kernel@vger.kernel.org>; Fri, 18 Mar 2022 09:21:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=O5YEItFojELUQ2ZVAdFWmd7QnNJFa0nT8LdWFM6nccM=;
        b=4eNZJsF8fh1rVxlzzh/V5Y+Csuo4kANqC3f+bvF5qGhpZ+Si0J4uB3/SwVE5Vt9/Zn
         dUMIHAI8gnjB3nEggWbwIdZlZAggHGLh6jUOaH7UNtR9ClAgWugTx14GLabIp7bepLPr
         BkHe01N1p6W+f1p/JGNQ8pfKcUPySHzLIEgiF0xdxsi35s7vJ+MTxK0+tfCc5XesZYrX
         6kNn5SfQzvRrP/XMUZ/+36LKS6H/fcSRK8CoTbB0xE7KUP/+Da04Nek6xrJyWSf169RZ
         53jAe4vhtfp126P6DzyUPEm+YmydQkSXgGD3bmhrTy5RlmN/tz04TfN5IjrWCXbb2gR3
         6J8w==
X-Gm-Message-State: AOAM533lMxgGWFssn2ZmtDoYqJTKu7Br4wGgGGECw+oOBrdqw2nsWAse
        ls2/U4cn5oLkGhPTudu16UjIFG/x3MT4t46cVEINfHNl/WPMNaYmArDn1jBC0uT14f0lQYXtQ7S
        HghDmc/0dCUVXWhJnY+k+OZ5wGR/5z3y99v+Lcg8FHA==
X-Received: by 2002:a05:6512:6c1:b0:448:6291:f135 with SMTP id u1-20020a05651206c100b004486291f135mr6405491lff.451.1647620483035;
        Fri, 18 Mar 2022 09:21:23 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJz7IhRjpip8ZxqWpdk/rNDzwPEQOlG6V0utFUzBi0pEzxIv6O5tJhNXTUklIfs5QHZNcJq1TQ==
X-Received: by 2002:a05:6512:6c1:b0:448:6291:f135 with SMTP id u1-20020a05651206c100b004486291f135mr6405475lff.451.1647620482814;
        Fri, 18 Mar 2022 09:21:22 -0700 (PDT)
Received: from localhost.localdomain (78-11-189-27.static.ip.netia.com.pl. [78.11.189.27])
        by smtp.gmail.com with ESMTPSA id h5-20020a197005000000b00448287d1275sm906913lfc.298.2022.03.18.09.21.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Mar 2022 09:21:22 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
To:     Green Wan <green.wan@sifive.com>, Vinod Koul <vkoul@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Alexandre Ghiti <alexandre.ghiti@canonical.com>,
        Palmer Debbelt <palmer@sifive.com>, dmaengine@vger.kernel.org,
        devicetree@vger.kernel.org, linux-riscv@lists.infradead.org,
        linux-kernel@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
Subject: [PATCH 1/2] dt-bindings: dmaengine: sifive,fu540-c000: include generic schema
Date:   Fri, 18 Mar 2022 17:20:43 +0100
Message-Id: <20220318162044.169350-1-krzysztof.kozlowski@canonical.com>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-5.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Include generic dma-controller.yaml schema, which enforces node naming
and other generic properties.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
---
 .../devicetree/bindings/dma/sifive,fu540-c000-pdma.yaml   | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/Documentation/devicetree/bindings/dma/sifive,fu540-c000-pdma.yaml b/Documentation/devicetree/bindings/dma/sifive,fu540-c000-pdma.yaml
index 75ad898c59bc..47c46af25536 100644
--- a/Documentation/devicetree/bindings/dma/sifive,fu540-c000-pdma.yaml
+++ b/Documentation/devicetree/bindings/dma/sifive,fu540-c000-pdma.yaml
@@ -22,6 +22,9 @@ description: |
 
   https://static.dev.sifive.com/FU540-C000-v1.0.pdf
 
+allOf:
+  - $ref: "dma-controller.yaml#"
+
 properties:
   compatible:
     items:
@@ -41,13 +44,12 @@ required:
   - compatible
   - reg
   - interrupts
-  - '#dma-cells'
 
-additionalProperties: false
+unevaluatedProperties: false
 
 examples:
   - |
-    dma@3000000 {
+    dma-controller@3000000 {
       compatible = "sifive,fu540-c000-pdma";
       reg = <0x3000000 0x8000>;
       interrupts = <23>, <24>, <25>, <26>, <27>, <28>, <29>, <30>;
-- 
2.32.0

