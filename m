Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E1F115004CB
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Apr 2022 05:46:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239773AbiDNDsN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Apr 2022 23:48:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52432 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239744AbiDNDsE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Apr 2022 23:48:04 -0400
Received: from mail-pg1-x52d.google.com (mail-pg1-x52d.google.com [IPv6:2607:f8b0:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D540D1C92D;
        Wed, 13 Apr 2022 20:45:40 -0700 (PDT)
Received: by mail-pg1-x52d.google.com with SMTP id h5so3662636pgc.7;
        Wed, 13 Apr 2022 20:45:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :in-reply-to:references;
        bh=0JdVfvnJIv7+14ew0e1XIOssCgXf2JJO0dNcA76IPPw=;
        b=Pccwd7mbb1Ck29mtHcLe6iqulkw1joS5pfXyBx8q04yj2E9ojf/MC+mVXpL3YQ5WZN
         UZgrIdeIrRRCxtsS/oO6Sv9UpmooQN9uhdyd64+SwBFqqi5FtY4t4xffDkIG52kntk44
         7GBEuIwbHlhSGqdxMTK/6kmfqZOnR158d69N5gb5XbrCXE+n3fjZTNjEGBCjgVB4tMd+
         diXjMRSFtYDZNqaO3Rsk9bRbQgCwVxsC9SSRqZRbF9hGeXoFm5rnP4rSvf290hdf6gAQ
         Paakf+gcWo2P9DkAXbXLIiAY2M/iLX3PoHWc+uh9Mn5N3Vyj83kQ5TJWiUL9gpHfu7ln
         jdtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:in-reply-to:references;
        bh=0JdVfvnJIv7+14ew0e1XIOssCgXf2JJO0dNcA76IPPw=;
        b=n7uUQdIrWge4TKZ+mWQJtjx+xqAOvipVodyQEoh1lyErpMQZ8nFw4QYF8fvOc/1a58
         J2b9ZVCPVv/ZuHvukuSFgN6BhzUsFNRZdwYl9rC0V5j1poTBQm0GMlKfUqflw9NXV53g
         2PRztbwDRlVpRYjouloSBgnuMA/6lcIKUatF8brWxXZ8nrIPRK0yGMhP8X+OLk1tnuzp
         WUf2KHVK/DMHHXcLPmK9cBvjCXw2E3/Dq+LdNqpvkEBNLeqJFurAhf7s+aZuA5xN+obR
         rpJJ1dzsjmfAbZb2hXh4yvcdtWP+dc7ZpFbHnOC/pWdnH4T6FjQnLPRNRkbUwZu7lTtn
         m29g==
X-Gm-Message-State: AOAM532wSrksFz/78omb6OjalL6JzIIjsCKbGFqOx7rDhJY+UtfSNLef
        is0rc0vkESI5nAx8POdKz0o=
X-Google-Smtp-Source: ABdhPJxFQC5qlyC+yfdNhBUO2uiJRlca0AqwLBBG2YcTxd9YfUAW6jeumXx8TcPvyp3THwyij5Xm+g==
X-Received: by 2002:a63:4147:0:b0:382:9ac9:b12b with SMTP id o68-20020a634147000000b003829ac9b12bmr700047pga.277.1649907940217;
        Wed, 13 Apr 2022 20:45:40 -0700 (PDT)
Received: from scdiu3.sunplus.com ([113.196.136.192])
        by smtp.googlemail.com with ESMTPSA id l6-20020a17090aaa8600b001cd5b85d664sm3193854pjq.1.2022.04.13.20.45.37
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 13 Apr 2022 20:45:39 -0700 (PDT)
From:   Tony Huang <tonyhuang.sunplus@gmail.com>
To:     ulf.hansson@linaro.org, robh+dt@kernel.org, krzk+dt@kernel.org,
        linux-mmc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, p.zabel@pengutronix.de,
        kuba@kernel.org, davem@davemloft.net, vladimir.oltean@nxp.com,
        colin.foster@in-advantage.com
Cc:     wells.lu@sunplus.com, tony.huang@sunplus.com, lh.Kuo@sunplus.com,
        Tony Huang <tonyhuang.sunplus@gmail.com>
Subject: [PATCH v7 1/2] dt-binding: mmc: Add mmc yaml file for Sunplus SP7021
Date:   Thu, 14 Apr 2022 11:45:23 +0800
Message-Id: <206476ae88e0af8a068f7a47a31b215b03bc8b0a.1649903900.git.tonyhuang.sunplus@gmail.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <cover.1649903900.git.tonyhuang.sunplus@gmail.com>
References: <cover.1649903900.git.tonyhuang.sunplus@gmail.com>
In-Reply-To: <cover.1649903900.git.tonyhuang.sunplus@gmail.com>
References: <cover.1649903900.git.tonyhuang.sunplus@gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add MMC YAML file for Sunplus SP7021.

Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Signed-off-by: Tony Huang <tonyhuang.sunplus@gmail.com>
---
Changes in v5:
 - Addressed comments from Krzysztof.

Changes in v6:
 - Addressed comments from Krzysztof.
 - To substitute MMC for mmc. To substitute YMAL for ymal.
 - Remove max-frequency.
 - Fixed wrong file name.

Changes in v7:
 -No change.

 .../devicetree/bindings/mmc/sunplus,mmc.yaml       | 62 ++++++++++++++++++++++
 MAINTAINERS                                        |  6 +++
 2 files changed, 68 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/mmc/sunplus,mmc.yaml

diff --git a/Documentation/devicetree/bindings/mmc/sunplus,mmc.yaml b/Documentation/devicetree/bindings/mmc/sunplus,mmc.yaml
new file mode 100644
index 0000000..9a50d9e
--- /dev/null
+++ b/Documentation/devicetree/bindings/mmc/sunplus,mmc.yaml
@@ -0,0 +1,62 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+# Copyright (C) Sunplus Ltd. Co. 2021
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/mmc/sunplus,mmc.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Sunplus MMC Controller
+
+maintainers:
+  - Tony Huang <tonyhuang.sunplus@gmail.com>
+  - Li-hao Kuo <lhjeff911@gmail.com>
+
+allOf:
+  - $ref: "mmc-controller.yaml"
+
+properties:
+  compatible:
+    enum:
+      - sunplus,sp7021-mmc
+
+  reg:
+    maxItems: 1
+
+  interrupts:
+    maxItems: 1
+
+  clocks:
+    maxItems: 1
+
+  resets:
+    maxItems: 1
+
+required:
+  - compatible
+  - reg
+  - interrupts
+  - clocks
+  - resets
+
+unevaluatedProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/interrupt-controller/irq.h>
+    #include <dt-bindings/interrupt-controller/arm-gic.h>
+    mmc0: mmc@9c003b00 {
+        compatible = "sunplus,sp7021-mmc";
+        reg = <0x9c003b00 0x180>;
+        interrupts = <20 IRQ_TYPE_LEVEL_HIGH>;
+        clocks = <&clkc 0x4e>;
+        resets = <&rstc 0x3e>;
+        bus-width = <8>;
+        max-frequency = <52000000>;
+        non-removable;
+        disable-wp;
+        cap-mmc-highspeed;
+        mmc-ddr-3_3v;
+        no-sdio;
+        no-sd;
+    };
+
diff --git a/MAINTAINERS b/MAINTAINERS
index fd768d4..cdd809a 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -18869,6 +18869,12 @@ L:	netdev@vger.kernel.org
 S:	Maintained
 F:	drivers/net/ethernet/dlink/sundance.c
 
+SUNPLUS MMC DRIVER
+M:	Tony Huang <tonyhuang.sunplus@gmail.com>
+M:	Li-hao Kuo <lhjeff911@gmail.com>
+S:	Maintained
+F:	Documentation/devicetree/bindings/mmc/sunplus,mmc.yaml
+
 SUNPLUS OCOTP DRIVER
 M:	Vincent Shih <vincent.sunplus@gmail.com>
 S:	Maintained
-- 
2.7.4

