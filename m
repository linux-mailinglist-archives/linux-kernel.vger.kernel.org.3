Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 073F74680C4
	for <lists+linux-kernel@lfdr.de>; Sat,  4 Dec 2021 00:42:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1383504AbhLCXpe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Dec 2021 18:45:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37924 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1383461AbhLCXpc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Dec 2021 18:45:32 -0500
Received: from mail-qk1-x72e.google.com (mail-qk1-x72e.google.com [IPv6:2607:f8b0:4864:20::72e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 85756C061751;
        Fri,  3 Dec 2021 15:42:07 -0800 (PST)
Received: by mail-qk1-x72e.google.com with SMTP id t6so5199140qkg.1;
        Fri, 03 Dec 2021 15:42:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=e/2fR1DEOwOnIt2ZN3aYDVK8fDwuingfzb4Dn02cKyM=;
        b=nnYYpI7XjfqpEZC7AA0w2KHysPOE5nBf2GzVzmS14fwR+Q9Wy7Y5v+0f16RVGwmOTx
         nxMZSGg7dveoJnZjAF0t6lZzfWZyxbb2qOWNOz4O5kPs6ScXoQLnhViW0qmx5vRVbdKL
         FhmGuQqL5RvlTIt7YtfeGwxolvzfNQhqV0oy00OLLO7xxx1t3NgGxLJ+64fXH7Aur0vF
         r1USO+/bKjOY3yXErxInIVvRjqimY2XUZ+bwCDXerYk4Nr+h1jKi8PgYwoqJTwe2/H9B
         zpsyOW+Zh3583X0s3mv9Tfc4DyA9VqyAKVCBpAP6bnebLsjqkknRI+ZZApz1i1xqGnvN
         nHbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=e/2fR1DEOwOnIt2ZN3aYDVK8fDwuingfzb4Dn02cKyM=;
        b=5Li/Fr2m096UPUqPIJS2vz/HlbL9+guTf1P3TnBGtwpA2DsdmFj/wTb1kv2jlKZ++R
         50R8K6EvB32av1l1vnrR8BgVFv6qfctKSewjxQlShefsfUMnXGLoP6Gj6iaxc2tz4elL
         gRtBr9+0Qy/ue8RdhSwIuP+U2dDun+gMUzXlXMsA9ZGMjX1ZyknDZR7oZhsIKzSA3ZUJ
         o5lCf8Ad3edmkoF1ga5P6RzwHeYfKMzoKVdBxGM+UnfHkinswXCU+39B7n3WB7EQy+31
         rkiJoCm2jjZJUieLM8aKS3zw+trW97F8WMB1a3IRzUHVuRjzuZ0TDcZu2qCrqjPEjy0k
         mQ5Q==
X-Gm-Message-State: AOAM530h4SZOItA6ColawTKX8tItavr13GFL0TL3fu8YgqnWtMQwjx5E
        XYbUJL4a/iAUxH+RBcUi+UthaL5G1S8=
X-Google-Smtp-Source: ABdhPJxFONJ+yJdEZXZXdoTdA75IudsESdaGdl6A/tPTw9tzAc05ZLTu4sSSbHm8J/BkuO0uPzPDOg==
X-Received: by 2002:a05:620a:240d:: with SMTP id d13mr20346021qkn.638.1638574926492;
        Fri, 03 Dec 2021 15:42:06 -0800 (PST)
Received: from glsvmlin.ini.cmu.edu (GLSVMLIN.INI.CMU.EDU. [128.2.16.9])
        by smtp.gmail.com with ESMTPSA id d15sm3495111qtd.70.2021.12.03.15.42.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Dec 2021 15:42:06 -0800 (PST)
From:   Gabriel Somlo <gsomlo@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     robh+dt@kernel.org, devicetree@vger.kernel.org,
        ulf.hansson@linaro.org, linux-mmc@vger.kernel.org,
        kgugala@antmicro.com, mholenko@antmicro.com, krakoczy@antmicro.com,
        mdudek@internships.antmicro.com, paulus@ozlabs.org, joel@jms.id.au,
        shorne@gmail.com, geert@linux-m68k.org,
        david.abdurachmanov@sifive.com, florent@enjoy-digital.fr
Subject: [PATCH v1 2/3] dt-bindings: mmc: Add bindings for LiteSDCard
Date:   Fri,  3 Dec 2021 18:41:54 -0500
Message-Id: <20211203234155.2319803-3-gsomlo@gmail.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20211203234155.2319803-1-gsomlo@gmail.com>
References: <20211203234155.2319803-1-gsomlo@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

LiteSDCard is a small footprint, configurable SDCard core for FPGA
based system on chips.

Signed-off-by: Gabriel Somlo <gsomlo@gmail.com>
---
 .../devicetree/bindings/mmc/litex,mmc.yaml    | 63 +++++++++++++++++++
 1 file changed, 63 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/mmc/litex,mmc.yaml

diff --git a/Documentation/devicetree/bindings/mmc/litex,mmc.yaml b/Documentation/devicetree/bindings/mmc/litex,mmc.yaml
new file mode 100644
index 000000000000..edc5ab7f359b
--- /dev/null
+++ b/Documentation/devicetree/bindings/mmc/litex,mmc.yaml
@@ -0,0 +1,63 @@
+# SPDX-License-Identifier: GPL-2.0-or-later OR BSD-2-Clause
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/mmc/litex,mmc.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: LiteX LiteSDCard device
+
+maintainers:
+  - Gabriel Somlo <gsomlo@gmail.com>
+
+description: |
+  LiteSDCard is a small footprint, configurable SDCard core for FPGA based
+  system on chips.
+
+  The hardware source is Open Source and can be found on at
+  https://github.com/enjoy-digital/litesdcard/.
+
+allOf:
+  - $ref: mmc-controller.yaml#
+
+properties:
+  compatible:
+    const: litex,mmc
+
+  reg:
+    items:
+      - description: PHY registers
+      - description: CORE registers
+      - description: DMA Reader buffer
+      - description: DMA Writer buffer
+      - description: IRQ registers
+
+  reg-names:
+    items:
+      - const: phy
+      - const: core
+      - const: reader
+      - const: writer
+      - const: irq
+
+  interrupts:
+    maxItems: 1
+
+required:
+  - compatible
+  - reg
+  - interrupts
+
+additionalProperties: false
+
+examples:
+  - |
+    mmc: mmc@12005000 {
+        compatible = "litex,mmc";
+        reg = <0x12005000 0x100>,
+              <0x12003800 0x100>,
+              <0x12003000 0x100>,
+              <0x12004800 0x100>,
+              <0x12004000 0x100>;
+        reg-names = "phy", "core", "reader", "writer", "irq";
+        interrupts = <4>;
+    };
-- 
2.31.1

