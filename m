Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BC83E4B6782
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Feb 2022 10:24:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235865AbiBOJYb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Feb 2022 04:24:31 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:40894 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235850AbiBOJYZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Feb 2022 04:24:25 -0500
Received: from mail-pj1-x102f.google.com (mail-pj1-x102f.google.com [IPv6:2607:f8b0:4864:20::102f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 229A16CA5F;
        Tue, 15 Feb 2022 01:24:16 -0800 (PST)
Received: by mail-pj1-x102f.google.com with SMTP id h14-20020a17090a130e00b001b88991a305so2141424pja.3;
        Tue, 15 Feb 2022 01:24:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=wNYf9XyB+B2EPKIx67gZzL/jt7hm7OqLw1FDLs3cMiE=;
        b=At9kqCKOnNhXNC4dPPG6cfrZzltGpY7bV3w/7Y71EUo84Ml+OEsQ5UPJPycLcYanWB
         VRWckWvls21kuZKRWK8zZI50VlmqxjoKbL0E923uuu2b16g4LJTHnlN/fEVA3cIN9iq0
         cb3MltDM0j7RZNbdeQqTdOCoQ3Sc3mgtn+w20DIuPsZEqkQEH2RO8McXd3sy9fVKjpX3
         1m6ZaBTEOxclHbffAs6M8qOSqvVEBN8sRbofbrPpomDdxvXw78di1+T0+6N2LV8YRV/1
         vbpvPsFSO+wW6Kw0sRRsJGGIyKm2vLVTraG2t/njQfi1Ajfat3PAoI0xI0CFThTrt1jG
         CSmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=wNYf9XyB+B2EPKIx67gZzL/jt7hm7OqLw1FDLs3cMiE=;
        b=s2hXy4T6zGPdOEMGdmFbXS20sMgsaqS5DXqsf8RxTLvzfDLY1vFzBUQMiB8tYwoa85
         TjwHpMmkGll/wy2Es9GnEDc4YfBd0tkUYJgOI+m2HiDYC9F12dG2PB0Xi/QKo+KdtS8P
         K4/c1FyXj6RFFju3iK3LE70x9p5HL8WHskf5lhqbTXSpDjDtdXtC55nImiFTuSDf0+Ql
         2PAOFlIeW4mJtbS2wye55TaLIHVQMjhw1vuGUudENZZEfhaW0MAzB3sVrSJwhAT+2B/Z
         cz00z+UaTWSmRLVr028Ksc2AWE86+e/piVXAHaQWyW/QfUt+lvVtvM5M96125V1qZShF
         i+dg==
X-Gm-Message-State: AOAM531ZT6Ohoz/8GggV3ao+RfN7q4yfeXY4jkeRHQ6jh01UNWvOkPe4
        oLBQl8xT62RzqMge6jbQfjk=
X-Google-Smtp-Source: ABdhPJxsApxTHztjjYekgjfbDxXjUZ9cetyFibGPdt1RRC4WIZMwwWdowmPypOKLavLkpv50fUuzkA==
X-Received: by 2002:a17:90a:3e06:b0:1b8:d021:df11 with SMTP id j6-20020a17090a3e0600b001b8d021df11mr3235125pjc.235.1644917055632;
        Tue, 15 Feb 2022 01:24:15 -0800 (PST)
Received: from scdiu3.sunplus.com ([113.196.136.192])
        by smtp.googlemail.com with ESMTPSA id h5sm5503824pfc.69.2022.02.15.01.24.13
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 15 Feb 2022 01:24:15 -0800 (PST)
From:   Hammer Hsieh <hammerh0314@gmail.com>
To:     gregkh@linuxfoundation.org, robh+dt@kernel.org,
        linux-serial@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, jirislaby@kernel.org,
        p.zabel@pengutronix.de
Cc:     wells.lu@sunplus.com, hammer.hsieh@sunplus.com,
        Hammer Hsieh <hammerh0314@gmail.com>
Subject: [PATCH v8 1/2] dt-bindings:serial:Add bindings doc for Sunplus SoC UART Driver
Date:   Tue, 15 Feb 2022 17:24:24 +0800
Message-Id: <1644917065-23168-2-git-send-email-hammerh0314@gmail.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1644917065-23168-1-git-send-email-hammerh0314@gmail.com>
References: <1644917065-23168-1-git-send-email-hammerh0314@gmail.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add bindings doc for Sunplus SoC UART Driver

Reviewed-by: Rob Herring <robh@kernel.org>
Signed-off-by: Hammer Hsieh <hammerh0314@gmail.com>
---
Changes in v8:
 - no change.

 .../bindings/serial/sunplus,sp7021-uart.yaml       | 56 ++++++++++++++++++++++
 MAINTAINERS                                        |  5 ++
 2 files changed, 61 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/serial/sunplus,sp7021-uart.yaml

diff --git a/Documentation/devicetree/bindings/serial/sunplus,sp7021-uart.yaml b/Documentation/devicetree/bindings/serial/sunplus,sp7021-uart.yaml
new file mode 100644
index 0000000..894324c
--- /dev/null
+++ b/Documentation/devicetree/bindings/serial/sunplus,sp7021-uart.yaml
@@ -0,0 +1,56 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+# Copyright (C) Sunplus Co., Ltd. 2021
+%YAML 1.2
+---
+$id: "http://devicetree.org/schemas/serial/sunplus,sp7021-uart.yaml#"
+$schema: "http://devicetree.org/meta-schemas/core.yaml#"
+
+title: Sunplus SoC SP7021 UART Controller Device Tree Bindings
+
+maintainers:
+  - Hammer Hsieh <hammerh0314@gmail.com>
+
+allOf:
+  - $ref: serial.yaml#
+
+properties:
+  compatible:
+    const: sunplus,sp7021-uart
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
+additionalProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/interrupt-controller/irq.h>
+    aliases {
+            serial0 = &uart0;
+    };
+
+    uart0: serial@9c000900 {
+        compatible = "sunplus,sp7021-uart";
+        reg = <0x9c000900 0x80>;
+        interrupt-parent = <&intc>;
+        interrupts = <53 IRQ_TYPE_LEVEL_HIGH>;
+        clocks = <&clkc 0x28>;
+        resets = <&rstc 0x18>;
+    };
+...
diff --git a/MAINTAINERS b/MAINTAINERS
index 3b79fd4..3c1362e 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -17945,6 +17945,11 @@ L:	netdev@vger.kernel.org
 S:	Maintained
 F:	drivers/net/ethernet/dlink/sundance.c
 
+SUNPLUS UART DRIVER
+M:	Hammer Hsieh <hammerh0314@gmail.com>
+S:	Maintained
+F:	Documentation/devicetree/bindings/serial/sunplus,sp7021-uart.yaml
+
 SUPERH
 M:	Yoshinori Sato <ysato@users.sourceforge.jp>
 M:	Rich Felker <dalias@libc.org>
-- 
2.7.4

