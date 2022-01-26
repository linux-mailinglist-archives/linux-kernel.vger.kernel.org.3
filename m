Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 75D0949D134
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jan 2022 18:56:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243978AbiAZR4S (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Jan 2022 12:56:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51332 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230370AbiAZR4P (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jan 2022 12:56:15 -0500
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com [IPv6:2a00:1450:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0097CC06173B;
        Wed, 26 Jan 2022 09:56:14 -0800 (PST)
Received: by mail-wr1-x433.google.com with SMTP id w11so428666wra.4;
        Wed, 26 Jan 2022 09:56:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=JQsJN7pJU0BMJyEgmIQu4kyCp2vR66DlJR8TnVMAcyQ=;
        b=TOQ67iGAT+7+07uNizB8BHdh7jMFRMf/l+pHtOhq2S77YS6VBRszqhcfC+kZOKGRat
         FDU9kMMTLJivAE7oOHzbCf3euJ2eoS9POx7iSbAzJejOKGfziBKQRm6/eN6yJtZ4JjNx
         vFgbZP4cgzgnYWq/BcN/VYm47yo6rxWa8EBNCagRH9Zeez4Ck3kKyQe/99aLWlPEXK7K
         +iBbCm9PFe18TWp3b9s5HkZCH8UCGMUa97bJMgBHMHfT5mCYlcVDpNqdlfb670pi5qHd
         APrtuHWtdxvmhEDMDFPhiZMxqvLc2XOVGjn53ZbCOx5hVQ1scgGYJ5JbuWeyyEKooKcB
         oUlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=JQsJN7pJU0BMJyEgmIQu4kyCp2vR66DlJR8TnVMAcyQ=;
        b=CsM+qIF/+auajpwZyWLz/CZq84RgpbxUKozJyUUo7VbwRNMOPzQE+/ephM0sr99EF/
         S1LOr/zMGUG0YKmeQogmQOXgq+rbnIl/NTLP1L/1z3EfXM/OQenZEA75ZjcsnVuh8hEA
         prgqBwt6Zawix7OJorBgY+nxV0GOCBK6gIiy0+p3GAhn2DVXwdfKtrzpW5wL6JTvluu9
         WoRzVfSPP+8ArmpJuKo9TuIgMokf9uj3ATNn9zkQO3iV9lSjutkAIuTK+xgH39cjIiYX
         ognDTbZhG/+LdHGoIrn8hHIHsFafF4OcAVBv3biLHxgX8QJ+ESoWG7heytHvXZ4jvykS
         lsOw==
X-Gm-Message-State: AOAM531+95j7Yj6tsxJER4TN6Yl7Od+1D9Z8o9EWpSD2jdRTKQVW+Sif
        mlQXUtzoegQGVwCtgYuk3Cs=
X-Google-Smtp-Source: ABdhPJx2eb5nlXZaKrsfJpJ+W8WqvxfydVOT6cwaVmM5rRae+FOQ+xqg8ALAfHShxVhcl4JknstmdQ==
X-Received: by 2002:a5d:610f:: with SMTP id v15mr23005925wrt.139.1643219773519;
        Wed, 26 Jan 2022 09:56:13 -0800 (PST)
Received: from debby ([2a01:e0a:a6d:a8d0:7ff4:8f61:5574:9f95])
        by smtp.gmail.com with ESMTPSA id m2sm4072416wmq.35.2022.01.26.09.56.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Jan 2022 09:56:13 -0800 (PST)
From:   Romain Perier <romain.perier@gmail.com>
To:     Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>, linux-clk@vger.kernel.org,
        Arnd Bergmann <arnd@arndb.de>, Daniel Palmer <daniel@0x0f.com>,
        Romain Perier <romain.perier@gmail.com>,
        Rob Herring <robh+dt@kernel.org>
Cc:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, Rob Herring <robh@kernel.org>
Subject: [PATCH v4 1/8] dt-bindings: clk: mstar msc313 cpupll binding description
Date:   Wed, 26 Jan 2022 18:55:57 +0100
Message-Id: <20220126175604.17919-2-romain.perier@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220126175604.17919-1-romain.perier@gmail.com>
References: <20220126175604.17919-1-romain.perier@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Daniel Palmer <daniel@0x0f.com>

Add a binding description for the MStar/SigmaStar CPU PLL block.

Signed-off-by: Daniel Palmer <daniel@0x0f.com>
Reviewed-by: Rob Herring <robh@kernel.org>
---
 .../bindings/clock/mstar,msc313-cpupll.yaml   | 45 +++++++++++++++++++
 1 file changed, 45 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/clock/mstar,msc313-cpupll.yaml

diff --git a/Documentation/devicetree/bindings/clock/mstar,msc313-cpupll.yaml b/Documentation/devicetree/bindings/clock/mstar,msc313-cpupll.yaml
new file mode 100644
index 000000000000..a9ad7ab5230c
--- /dev/null
+++ b/Documentation/devicetree/bindings/clock/mstar,msc313-cpupll.yaml
@@ -0,0 +1,45 @@
+# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/clock/mstar,msc313-cpupll.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: MStar/Sigmastar MSC313 CPU PLL
+
+maintainers:
+  - Daniel Palmer <daniel@thingy.jp>
+
+description: |
+  The MStar/SigmaStar MSC313 and later ARMv7 chips have a scalable
+  PLL that can be used as the clock source for the CPU(s).
+
+properties:
+  compatible:
+    const: mstar,msc313-cpupll
+
+  "#clock-cells":
+    const: 1
+
+  clocks:
+    maxItems: 1
+
+  reg:
+    maxItems: 1
+
+required:
+  - compatible
+  - "#clock-cells"
+  - clocks
+  - reg
+
+additionalProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/clock/mstar-msc313-mpll.h>
+    cpupll: cpupll@206400 {
+        compatible = "mstar,msc313-cpupll";
+        reg = <0x206400 0x200>;
+        #clock-cells = <1>;
+        clocks = <&mpll MSTAR_MSC313_MPLL_DIV2>;
+    };
-- 
2.34.1

