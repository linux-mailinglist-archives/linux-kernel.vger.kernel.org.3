Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 74B6F5150DC
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Apr 2022 18:29:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379195AbiD2QcK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Apr 2022 12:32:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49968 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1379142AbiD2Qb1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Apr 2022 12:31:27 -0400
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com [IPv6:2a00:1450:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1EB2FD95DE
        for <linux-kernel@vger.kernel.org>; Fri, 29 Apr 2022 09:28:09 -0700 (PDT)
Received: by mail-wr1-x42e.google.com with SMTP id q23so11476583wra.1
        for <linux-kernel@vger.kernel.org>; Fri, 29 Apr 2022 09:28:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=WNtxLER3UVWbKTs2IgzwZg6nrHSr8NtqUXr1n9ePXw8=;
        b=s7rQUh/w5RkSpjcatPLSojUT/2hjuEQZL0MasfHqFzAWCePpd2h4fittlMHL9mTBbS
         3xZZwGsDhfAKveqt9HFigF9m2uI99+EXmEYqCsFw/jOv4zaxtHxgqyGBLuFKYD1jexym
         lZ8nTfir8/T2BYnOJUrSci9+abmcCNPzUkAK41LJ0b8lDg11VXatonyoa05Chvi/h/LP
         sRZn+h98UXn77M8cQjGJ/SR2e7aYRZpWR5+NHFVmi0uOouF7VA7BO116SCOHOzuQ50Jk
         6y53L0oXKEhRQo4ffiIiGcCaDBm4tRYKd8EPCNXq0mSAj/E5G0seEuAsr66/asdPcUtp
         JgyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=WNtxLER3UVWbKTs2IgzwZg6nrHSr8NtqUXr1n9ePXw8=;
        b=a79uP137u9fjw44+vXQdbtQBKQYVaBzLyqdLtz1CUgVPgBHeDG6aKU/aW6htdLMwVv
         gAWshyWJ0jjbGB/MlNc9runW8uhJzn8ivPS1mrN5lhLZ7d6/EJh7T5ifFsi4VDgj1/YU
         AKnqzQy9vX5IVbIMDoIJO7NzSKwFEUXZUqcpfixyl6SDDihtC9irbKsrFimstJWU8abn
         GYGzTxdQlCabnvW49Roju2+v3TdYI9uFpDDnEgWSnhmWxv6wji0PtlkvmkjuBHsumGNX
         dMe7D4QgLOT0eYDlrFZYXuiiPpKjuauyUBjTiEQ2yyAP2jW7pYTCnVJRPoIZntbFRJu9
         JbtQ==
X-Gm-Message-State: AOAM531E0fA/Rv1L9CGs0cpQ3M2SMOJB4MEVtIv4zzCW2/184+0Kt3a3
        vxq2BPox2/gwX7r+G8IwVvCcdQ==
X-Google-Smtp-Source: ABdhPJxf5SAKbjdmACBi5377Y5D8zZLGHXVja+JnWNnOzQukIX5F2u5caBNXLI72s+Xg3cf4HeBipQ==
X-Received: by 2002:adf:fc52:0:b0:20a:e296:6e8a with SMTP id e18-20020adffc52000000b0020ae2966e8amr16456414wrs.432.1651249687687;
        Fri, 29 Apr 2022 09:28:07 -0700 (PDT)
Received: from srini-hackbox.lan (cpc90716-aztw32-2-0-cust825.18-1.cable.virginm.net. [86.26.103.58])
        by smtp.gmail.com with ESMTPSA id b5-20020adff905000000b0020a8781be70sm2781801wrr.12.2022.04.29.09.28.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 Apr 2022 09:28:07 -0700 (PDT)
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
To:     gregkh@linuxfoundation.org
Cc:     linux-kernel@vger.kernel.org,
        Sean Anderson <sean.anderson@seco.com>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: [PATCH 12/16] dt-bindings: nvmem: sfp: Add clock properties
Date:   Fri, 29 Apr 2022 17:26:57 +0100
Message-Id: <20220429162701.2222-13-srinivas.kandagatla@linaro.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20220429162701.2222-1-srinivas.kandagatla@linaro.org>
References: <20220429162701.2222-1-srinivas.kandagatla@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Sean Anderson <sean.anderson@seco.com>

To program fuses, it is necessary to set the fuse programming time. This
is determined based on the value of the platform clock. Add a clock
property.

Because this property is necessary for programming, it is made
mandatory. Since these bindings have not yet been present in a stable
release (though they are on track for 5.18), it is not an ABI break to
change them in this manner.

Signed-off-by: Sean Anderson <sean.anderson@seco.com>
Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
---
 .../bindings/nvmem/fsl,layerscape-sfp.yaml         | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/Documentation/devicetree/bindings/nvmem/fsl,layerscape-sfp.yaml b/Documentation/devicetree/bindings/nvmem/fsl,layerscape-sfp.yaml
index b7798e903191..54086f50157d 100644
--- a/Documentation/devicetree/bindings/nvmem/fsl,layerscape-sfp.yaml
+++ b/Documentation/devicetree/bindings/nvmem/fsl,layerscape-sfp.yaml
@@ -24,15 +24,29 @@ properties:
   reg:
     maxItems: 1
 
+  clocks:
+    maxItems: 1
+    description:
+      The SFP clock. Typically, this is the platform clock divided by 4.
+
+  clock-names:
+    const: sfp
+
 required:
   - compatible
   - reg
+  - clock-names
+  - clocks
 
 unevaluatedProperties: false
 
 examples:
   - |
+    #include <dt-bindings/clock/fsl,qoriq-clockgen.h>
     efuse@1e80000 {
         compatible = "fsl,ls1028a-sfp";
         reg = <0x1e80000 0x8000>;
+        clocks = <&clockgen QORIQ_CLK_PLATFORM_PLL
+                            QORIQ_CLK_PLL_DIV(4)>;
+        clock-names = "sfp";
     };
-- 
2.21.0

