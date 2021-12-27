Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0123247FD90
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Dec 2021 14:36:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236877AbhL0NgK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Dec 2021 08:36:10 -0500
Received: from smtp-relay-internal-0.canonical.com ([185.125.188.122]:39542
        "EHLO smtp-relay-internal-0.canonical.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S236824AbhL0NgE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Dec 2021 08:36:04 -0500
Received: from mail-lj1-f198.google.com (mail-lj1-f198.google.com [209.85.208.198])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id 79A4B3F1F2
        for <linux-kernel@vger.kernel.org>; Mon, 27 Dec 2021 13:36:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1640612163;
        bh=oGE8+PkJuWqDrKE6+d8+2gthXnHr3q/vecIpexN8XNM=;
        h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
         MIME-Version;
        b=A/Ma89W7+3kWK3pPagrOUcVcBd7WNfxciTxjaJQ/hPRjUlkfwWTZb8KzY9JZGeHkj
         TtFQrsxshUGmQxCc6pecwoEUcfoGhpcao/afLwli1etF9u9ghghcFiHPqzJV7kQChS
         yGPaXOCz94AwwZMOBhToZcFI9MRLRuBtxQd+luENiE/ZuD2B1CwCePOcoqFisE6VK7
         jeeXSvD8Au2OpjkW/+DMrUFKz8+/5NREy5SEWz+umfMc2U/86lFOcEZ8wtjnMAGwra
         5/B8u7BF3DYSBeYV5lG/j27R/54Xw3cIZymjXVAwXR2B+rsm9e30Q5WDA575I7m/jT
         3bFbsh82s5sIA==
Received: by mail-lj1-f198.google.com with SMTP id v19-20020a2e87d3000000b0022dbe4687f1so2193525ljj.7
        for <linux-kernel@vger.kernel.org>; Mon, 27 Dec 2021 05:36:03 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=oGE8+PkJuWqDrKE6+d8+2gthXnHr3q/vecIpexN8XNM=;
        b=JvdIQOFauMOtDfGp6rkKYglWWpyHaDqigQqykQyhUgINHzGGw8z2Et3yyIK+ffoCYn
         GQbu6E7dU5xliFB5c9XNSJgC06oLhK/l1/3gzyiE9mEneHGlNsFc9Eh2fdkATXp/ICtA
         2W8b8pDk9MC857FuJ46VEGwmAlO+G8wxT548pQ8xO8oTj6eHdK3fDD0RLg9GAYcp+5I9
         /9n1L2XkOHecNWWTARo6NA8vQCD3/U81TC/V8veXWr+LJrRZc2sZ9cGBs5p2WP8BgboZ
         DvodBWBP7Qj0pW7ACMmRh+W3fn/jVWPyTApNtoVCv/41eI268qGRcenWOJHpfL7M12JD
         fbzg==
X-Gm-Message-State: AOAM531N8jCYOZcjFORfVlrhnjTDncB1d9K3g+UimB2JYMqrxQ842ngw
        sMsksYctlYyuixHq3BBcFC5WR1nLug1PdJNUozgxQupIC3xjkapFdlYazPhYKE4h16t+FtvcRwq
        iqqsUcmEQ2UT+lJhB2Hf9sFTHcGc3YDtlHHhIiYjMwA==
X-Received: by 2002:a05:6512:3391:: with SMTP id h17mr15749070lfg.646.1640612162885;
        Mon, 27 Dec 2021 05:36:02 -0800 (PST)
X-Google-Smtp-Source: ABdhPJzJmeFRyQ9NYY7GmLmgjrSh1Xye8b5U/JAgM4Oa91imAYxlVkDhOgwM/hmySIhkAGyWAkk0JA==
X-Received: by 2002:a05:6512:3391:: with SMTP id h17mr15749060lfg.646.1640612162708;
        Mon, 27 Dec 2021 05:36:02 -0800 (PST)
Received: from krzk-bin.lan (89-77-68-124.dynamic.chello.pl. [89.77.68.124])
        by smtp.gmail.com with ESMTPSA id g18sm800107ljj.124.2021.12.27.05.36.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Dec 2021 05:36:02 -0800 (PST)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Dinh Nguyen <dinguyen@kernel.org>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-mmc@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
Subject: [PATCH 08/19] dt-bindings: clock: intel,stratix10: convert to dtschema
Date:   Mon, 27 Dec 2021 14:35:47 +0100
Message-Id: <20211227133558.135185-2-krzysztof.kozlowski@canonical.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20211227133131.134369-1-krzysztof.kozlowski@canonical.com>
References: <20211227133131.134369-1-krzysztof.kozlowski@canonical.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Convert the Intel Stratix 10 clock controller bindings to DT schema format.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
---
 .../bindings/clock/intc_stratix10.txt         | 20 -----------
 .../bindings/clock/intel,stratix10.yaml       | 35 +++++++++++++++++++
 2 files changed, 35 insertions(+), 20 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/clock/intc_stratix10.txt
 create mode 100644 Documentation/devicetree/bindings/clock/intel,stratix10.yaml

diff --git a/Documentation/devicetree/bindings/clock/intc_stratix10.txt b/Documentation/devicetree/bindings/clock/intc_stratix10.txt
deleted file mode 100644
index 9f4ec5cb5c6b..000000000000
--- a/Documentation/devicetree/bindings/clock/intc_stratix10.txt
+++ /dev/null
@@ -1,20 +0,0 @@
-Device Tree Clock bindings for Intel's SoCFPGA Stratix10 platform
-
-This binding uses the common clock binding[1].
-
-[1] Documentation/devicetree/bindings/clock/clock-bindings.txt
-
-Required properties:
-- compatible : shall be
-	"intel,stratix10-clkmgr"
-
-- reg : shall be the control register offset from CLOCK_MANAGER's base for the clock.
-
-- #clock-cells : from common clock binding, shall be set to 1.
-
-Example:
-	clkmgr: clock-controller@ffd10000 {
-		compatible = "intel,stratix10-clkmgr";
-		reg = <0xffd10000 0x1000>;
-		#clock-cells = <1>;
-	};
diff --git a/Documentation/devicetree/bindings/clock/intel,stratix10.yaml b/Documentation/devicetree/bindings/clock/intel,stratix10.yaml
new file mode 100644
index 000000000000..f506e3db9782
--- /dev/null
+++ b/Documentation/devicetree/bindings/clock/intel,stratix10.yaml
@@ -0,0 +1,35 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/clock/intel,stratix10.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Intel SoCFPGA Stratix10 platform clock controller binding
+
+maintainers:
+  - Dinh Nguyen <dinguyen@kernel.org>
+
+properties:
+  compatible:
+    const: intel,stratix10-clkmgr
+
+  '#clock-cells':
+    const: 1
+
+  reg:
+    maxItems: 1
+
+required:
+  - compatible
+  - reg
+  - '#clock-cells'
+
+additionalProperties: false
+
+examples:
+  - |
+    clock-controller@ffd10000 {
+        compatible = "intel,stratix10-clkmgr";
+        reg = <0xffd10000 0x1000>;
+        #clock-cells = <1>;
+    };
-- 
2.32.0

