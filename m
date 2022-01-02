Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C859B482C30
	for <lists+linux-kernel@lfdr.de>; Sun,  2 Jan 2022 17:57:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229623AbiABQ5k (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 2 Jan 2022 11:57:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41470 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229584AbiABQ5i (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 2 Jan 2022 11:57:38 -0500
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com [IPv6:2a00:1450:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA8DDC061761;
        Sun,  2 Jan 2022 08:57:37 -0800 (PST)
Received: by mail-wr1-x42f.google.com with SMTP id v6so3959017wra.8;
        Sun, 02 Jan 2022 08:57:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=xY5sdN/MjZvpkzIVHRkalM0h2jmAhubj3ucgmZy/xLE=;
        b=i8OYmVcfHjMRcYo9XYExn4e2LNHOqCu1kTC+mLNyb1O47gYyzhvVI3sN2L7M8JFbvL
         qr5ahmw45IF7mWqD/M12tFe3IfZDoor+Jry72WbiuC1IzkXFrA2SS1uP1IygNh6NwInG
         cKzxx3gu0Any4MqLizbuaAL7Q7DlWh7mdjrQYsXpLEE7F5XXbKvEyndvSIZsir4xFqqk
         JuMD1OPQFzRbNiIqqbEvWGscH1wDS+sdXf2snHWc/It7j0+RplOnCyTVftHHhC90cEa4
         bdP2Sh+pUK6cuSFcyrdeubEUH6mwkq8K3BmTKxEbvP0Xh6uFPpE0pc7QRFCZ5mZ0gXBJ
         cNfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=xY5sdN/MjZvpkzIVHRkalM0h2jmAhubj3ucgmZy/xLE=;
        b=7/H2XtdSEeZnTpKN0/VLXfB40LGtVsJV8YM+pU1sNNGa/MC3+yDatNs5r3yF3fLEaJ
         GE4y/x+aOM8gCiEpa9/zojJShSO8uDcQryGT4TryS4aSU5U9AuQ+LJRW4fvCXScHkxJA
         cewVQrDcDhl1yQG4xlLd8ypWm6+IL106puFTf8x9foIwEZEXmuZTojRKlCMM6RzUtymr
         3ruD7JG0G3qKfKqzfB+88z8eH/PS9zipWCFM8rqVnG0BPd+J1FTyxEfBloaph83m+/JD
         iMnMIphyqiyx0uzXVngs8aRkSZf+FDd1N65nOV6sWLPUbTOK3E4uzdPgl+NSeHoTghIL
         eRWA==
X-Gm-Message-State: AOAM533JGgw9XYZ82BfSYFLRXUh9vfU65U2gvdEnqLnmJ/nDdRJijCgr
        2MSFJmmlezw2wQCwW+0wonmP9DeYJVTCdw==
X-Google-Smtp-Source: ABdhPJzdOuDFcSB38KIyoLrnqkve6qQFfKNS1W+N8l0uI2s/gbI4hx/9N/M6aAIWfb3msaI4TUvdGg==
X-Received: by 2002:a05:6000:188c:: with SMTP id a12mr38138519wri.45.1641142655727;
        Sun, 02 Jan 2022 08:57:35 -0800 (PST)
Received: from debby ([2a01:e0a:a6d:a8d0:7ff4:8f61:5574:9f95])
        by smtp.gmail.com with ESMTPSA id bg12sm40620846wmb.5.2022.01.02.08.57.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 02 Jan 2022 08:57:35 -0800 (PST)
From:   Romain Perier <romain.perier@gmail.com>
To:     Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>, linux-clk@vger.kernel.org,
        Arnd Bergmann <arnd@arndb.de>, Daniel Palmer <daniel@0x0f.com>,
        Romain Perier <romain.perier@gmail.com>,
        Rob Herring <robh+dt@kernel.org>
Cc:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 1/9] dt-bindings: clk: mstar msc313 cpupll binding description
Date:   Sun,  2 Jan 2022 17:57:22 +0100
Message-Id: <20220102165730.50190-2-romain.perier@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220102165730.50190-1-romain.perier@gmail.com>
References: <20220102165730.50190-1-romain.perier@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Daniel Palmer <daniel@0x0f.com>

Add a binding description for the MStar/SigmaStar CPU PLL block.

Signed-off-by: Daniel Palmer <daniel@0x0f.com>
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

