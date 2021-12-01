Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 465D1464BE9
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Dec 2021 11:46:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348781AbhLAKuM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Dec 2021 05:50:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51036 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348777AbhLAKuK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Dec 2021 05:50:10 -0500
Received: from mail-pf1-x432.google.com (mail-pf1-x432.google.com [IPv6:2607:f8b0:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3DDC5C061574;
        Wed,  1 Dec 2021 02:46:50 -0800 (PST)
Received: by mail-pf1-x432.google.com with SMTP id g19so23957737pfb.8;
        Wed, 01 Dec 2021 02:46:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=2fzwCgHmFMX3NXd2jEfr7dnG6xVoYL9jcUVbqd5DMXM=;
        b=FdoJfir+Uy/BLOwXb1hnHWoMAE97P1lA25O9XdtrZKJ6GLOY1xdTt6dxLEVoaD5DNS
         0A5hX67P52IyZyEYY5ujo7LNinKwj7wG6WyjGHGaGsSwN90bUQ6ICVXco3mrVs7SSLjR
         JrwJbC+YwTwUKi62XOjk16T4t9PptJyrH8UTqCr8Bm5qC82GSOh6sGMFV8V1JGJ8sRRu
         vemk1iCA+3mJfCvAIOkSSdMjWDDzeQYkBNZO4W2FXRf3gVA4vFdt3powJnPfRNXaYMNW
         HpP2yXLQrJVSCdPDqOW0sX6gCBDNyKKvaPDPzqIZF+y1nnCnperq5UZXnD7Zjnq/udQj
         uwsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=2fzwCgHmFMX3NXd2jEfr7dnG6xVoYL9jcUVbqd5DMXM=;
        b=LcGIv3yDjd6e40fEaLhKgOPAp2rdRI98GK34QhcPl8J2rxeptgBfcFGHU9TG9FCWEn
         1iDw1Pm+m4ER7GTlO3E3bA1sGLSZzjkgy3X/HDNY6ZRKkIAKTgTe3UilGRuJG+jn2Otq
         idsvogBg/f4rcEyg6I66snnmD1o5Hhv2H7mJuDBci7vWrQmzokeSZhWTT2533bWHyR1F
         90QxGPy0OSJZpMvQLSedJ1XmxtrYtvZaMTs3w7F5O5rzg+Q8plcK2gCKCj7fa7VHZ0Xk
         YLffCuJRN33vLhjTdDPcr02F0M3+ZuBwQTYm5rp+gYrT8NGp1p3Yu1XVqVnKek1O5CYx
         ol2w==
X-Gm-Message-State: AOAM531SFmyQHhmQcXohygxbb0RUgbzKcB8Xq1oR59SU0W72X863Pbgt
        /e9hyBCCUnXXk/DoriGoaj4=
X-Google-Smtp-Source: ABdhPJx7b7YAnMhCyB2Vn24x7k6jt6On+njkIxaxdThmZ7xp9llO9liTzGS3XHyWPv5ktPSJ2zdUzg==
X-Received: by 2002:a05:6a00:21c4:b0:4a7:ec46:34b7 with SMTP id t4-20020a056a0021c400b004a7ec4634b7mr5216657pfj.15.1638355609810;
        Wed, 01 Dec 2021 02:46:49 -0800 (PST)
Received: from scdiu3.sunplus.com ([113.196.136.192])
        by smtp.googlemail.com with ESMTPSA id f22sm26395318pfj.49.2021.12.01.02.46.47
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 01 Dec 2021 02:46:49 -0800 (PST)
From:   Hammer Hsieh <hammerh0314@gmail.com>
X-Google-Original-From: Hammer Hsieh <hammer.hsieh@sunplus.com>
To:     gregkh@linuxfoundation.org, robh+dt@kernel.org,
        linux-serial@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, jirislaby@kernel.org,
        p.zabel@pengutronix.de
Cc:     tony.huang@sunplus.com, wells.lu@sunplus.com,
        Hammer Hsieh <hammer.hsieh@sunplus.com>
Subject: [PATCH v4 1/2] dt-bindings:serial:Add bindings doc for Sunplus SoC UART Driver
Date:   Wed,  1 Dec 2021 18:46:43 +0800
Message-Id: <1638355604-24002-2-git-send-email-hammer.hsieh@sunplus.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1638355604-24002-1-git-send-email-hammer.hsieh@sunplus.com>
References: <1638355604-24002-1-git-send-email-hammer.hsieh@sunplus.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add bindings doc for Sunplus SoC UART Driver

Reviewed-by: Rob Herring <robh@kernel.org>
Signed-off-by: Hammer Hsieh <hammer.hsieh@sunplus.com>
---
Changes in v4:
 - no change.
 - Reviewed-by : Rob Herring <robh@kernel.org> in v3.

 .../bindings/serial/sunplus,sp7021-uart.yaml       | 58 ++++++++++++++++++++++
 MAINTAINERS                                        |  5 ++
 2 files changed, 63 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/serial/sunplus,sp7021-uart.yaml

diff --git a/Documentation/devicetree/bindings/serial/sunplus,sp7021-uart.yaml b/Documentation/devicetree/bindings/serial/sunplus,sp7021-uart.yaml
new file mode 100644
index 0000000..df11074
--- /dev/null
+++ b/Documentation/devicetree/bindings/serial/sunplus,sp7021-uart.yaml
@@ -0,0 +1,58 @@
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
+  - Tony Huang <tony.huang@sunplus.com>
+  - Hammer Hsieh <hammer.hsieh@sunplus.com>
+  - Wells Lu <wells.lu@sunplus.com>
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
index 3b79fd4..f2ee40c 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -17945,6 +17945,11 @@ L:	netdev@vger.kernel.org
 S:	Maintained
 F:	drivers/net/ethernet/dlink/sundance.c
 
+SUNPLUS UART DRIVER
+M:	Hammer Hsieh <hammer.hsieh@sunplus.com>
+S:	Maintained
+F:	Documentation/devicetree/bindings/serial/sunplus,sp7021-uart.yaml
+
 SUPERH
 M:	Yoshinori Sato <ysato@users.sourceforge.jp>
 M:	Rich Felker <dalias@libc.org>
-- 
2.7.4

