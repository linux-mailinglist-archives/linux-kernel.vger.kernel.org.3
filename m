Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 662A24965B0
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jan 2022 20:36:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232143AbiAUTf4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Jan 2022 14:35:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58118 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232561AbiAUTfw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Jan 2022 14:35:52 -0500
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com [IPv6:2a00:1450:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E4D2EC06173B;
        Fri, 21 Jan 2022 11:35:51 -0800 (PST)
Received: by mail-wm1-x336.google.com with SMTP id q9-20020a7bce89000000b00349e697f2fbso30049521wmj.0;
        Fri, 21 Jan 2022 11:35:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=JQsJN7pJU0BMJyEgmIQu4kyCp2vR66DlJR8TnVMAcyQ=;
        b=q44HUq6w2KiYoMvHttu5w86WGdLVEIS0Ai7y8an10oGs3eaMf86rF9MbcxY7Gpy/f0
         ZfsOC6HI0O7ZIK9/sB0stqNjrC2oH7h10PkQnfYIOUGvvGmg8ofXDI/iR4jiyoq4oygn
         FfAtrXGB8sLS7QGi+oVm5M1xaX67WORdIfvrNMfVvl+oZz8X0PS3rIE3yjUXMJxel8K8
         Zlbbtefde24UKEEab0ncyT88YogLhQ8vxJuJcmgSxpBXs377ynfUfBZaUqrnBfq3wXuk
         6qrgsJ8i6SjEA0L1UxAqRtChUsV0xAojzgQoIraHMpzBGPdZzuPhsFrpmbzIRbH4IgoH
         ZoTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=JQsJN7pJU0BMJyEgmIQu4kyCp2vR66DlJR8TnVMAcyQ=;
        b=w4hz/dFo+KCkNvLDhjLzlunZQ2Qjvm3FWNqJ0QWguzduWLuBglP2QNwJ3NgmSVcdjV
         7RLt8y+EUjkiFAfSvhY5gKuknmFOUKADMhOUZrxvdxbCxsOQw6atcCz9TZK0MiA93ekB
         b5plGeGFYxkB53AS752oxj0NW5yJ9y9DolZ4lEU/BIpVSB4ESiWqhd19Q0UwrS/0VNvA
         thpRzYIqX77K5OX19PegMvBcesy3gSlCWQc5IXKCdJB6U4dklfP+3eu+beYVeJE5cwZR
         ABC6uX/IkZdXOyjf9ImK/6+XHX4NI9/jOLZx2UlXyRfPrHc3/0zRpEriQrNNXb4Nx+lP
         HZXA==
X-Gm-Message-State: AOAM532uCpsKT8dWhcayCG8ev3Rh1e9JIm/J3CDHjZYNPH9+4fSTxxH3
        Xs8gPOXv116zUSxPuBy3yE0=
X-Google-Smtp-Source: ABdhPJy74/M/l9l60yzDFsAdVmnA+Bxt582Pt24ra8TkTCnRoeglEPeKLr6FE1ypAg5zoVb6hpA0aA==
X-Received: by 2002:a1c:984a:: with SMTP id a71mr2004193wme.115.1642793750322;
        Fri, 21 Jan 2022 11:35:50 -0800 (PST)
Received: from debby ([2a01:e0a:a6d:a8d0:7ff4:8f61:5574:9f95])
        by smtp.gmail.com with ESMTPSA id a18sm6944790wrw.5.2022.01.21.11.35.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Jan 2022 11:35:49 -0800 (PST)
From:   Romain Perier <romain.perier@gmail.com>
To:     Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>, linux-clk@vger.kernel.org,
        Arnd Bergmann <arnd@arndb.de>, Daniel Palmer <daniel@0x0f.com>,
        Romain Perier <romain.perier@gmail.com>,
        Rob Herring <robh+dt@kernel.org>
Cc:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, Rob Herring <robh@kernel.org>
Subject: [PATCH v3 1/9] dt-bindings: clk: mstar msc313 cpupll binding description
Date:   Fri, 21 Jan 2022 20:35:36 +0100
Message-Id: <20220121193544.23231-2-romain.perier@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220121193544.23231-1-romain.perier@gmail.com>
References: <20220121193544.23231-1-romain.perier@gmail.com>
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

