Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2A1704BA089
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Feb 2022 14:03:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240619AbiBQNDD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Feb 2022 08:03:03 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:60674 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230093AbiBQNDA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Feb 2022 08:03:00 -0500
Received: from mail-lj1-x22c.google.com (mail-lj1-x22c.google.com [IPv6:2a00:1450:4864:20::22c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE23F291F9A;
        Thu, 17 Feb 2022 05:02:45 -0800 (PST)
Received: by mail-lj1-x22c.google.com with SMTP id bx31so8264939ljb.0;
        Thu, 17 Feb 2022 05:02:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=e+QX15fh6AjTvjCx86bn1wO86yEMC2bkhF0fAWHNnUg=;
        b=lut67Ponvp8shZTDWUe5Oj4AJ9ez1NfZDkmOcaExj54tgf/XNA2xehOZT6z8qFQ5Qn
         Uh1MpB93m8zYjKvlxYvtkKzZcU3r4syprwi4hXVnU9V4VB7b+AVu2PXJOrI0rVt/35u4
         xyw77JW2xXZDx1V8SiSXFMAK7lqk3zlw3Jb02TSWIMaeaSwNBx7WgQlPTN29ZQHeMkhU
         CgwQGnvQ6KU1hclxRNAxrRVW7xLwxQzGjk3yZqBZ6RYPdBBhLSyOiZuLzeAfb3/hnIZR
         jVC4UPKZ/uwf8nyIY6d7jtzWyTRPCeXx9n4+AZ0qfZTC6gi8ZOnNzQyd7B7ET0Df8riz
         zu4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=e+QX15fh6AjTvjCx86bn1wO86yEMC2bkhF0fAWHNnUg=;
        b=QBh6M4uv8MTRtjI5mSQeteqPXJicRHPtEOcMwLzaGhAfmMZzGoXOat1iHUh0gc12O6
         xbdTv0+ySTkhsXe3jbJFVAD6xiOyiv0NxJTjAVoWvvBi5xtjUxTp0HnpQzdxp0+My+W8
         ayFOU284V+d8a9YASMv+tE5zgttg4/flmN4knF2STJuH0wx6bzu8EyHfPwLGEk2qRuIB
         M9DqXvN/RH4+VSRWzxl3CK8dWgSdZ39i5LIDGoWDdf/22LX5eowYh26ac+1p50T7C964
         EE6mtxN13qpe8xUu79UomRk50hAq+3W9eeD8GYm+RYTNPcDYx8WMui69wLiLy2RFSELw
         ESSg==
X-Gm-Message-State: AOAM531+DFwFZHqfuZQumW3nGu9zCnaUZgKk7t26zCXp7wNcftQvrvfw
        OiuH+onRqZVvCwvcRABh298=
X-Google-Smtp-Source: ABdhPJwX/PuQ1lPFpaK+K1l8a4th2eL+Z3ItLD4DvLo0qVQgfPzUUio4gMfEyTzB3/jRDrapP4xjYg==
X-Received: by 2002:a05:651c:1797:b0:23a:18d7:1d39 with SMTP id bn23-20020a05651c179700b0023a18d71d39mr2134034ljb.470.1645102964126;
        Thu, 17 Feb 2022 05:02:44 -0800 (PST)
Received: from localhost.lan (ip-194-187-74-233.konfederacka.maverick.com.pl. [194.187.74.233])
        by smtp.gmail.com with ESMTPSA id w8sm653052ljd.27.2022.02.17.05.02.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Feb 2022 05:02:43 -0800 (PST)
From:   =?UTF-8?q?Rafa=C5=82=20Mi=C5=82ecki?= <zajec5@gmail.com>
To:     Rob Herring <robh+dt@kernel.org>, Tom Rini <trini@konsulko.com>
Cc:     Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        Ricardo Salveti <ricardo@foundries.io>,
        Michal Simek <michal.simek@xilinx.com>,
        Jorge Ramirez-Ortiz <jorge@foundries.io>,
        Sean Anderson <seanga2@gmail.com>, devicetree@vger.kernel.org,
        u-boot@lists.denx.de, linux-kernel@vger.kernel.org,
        =?UTF-8?q?Rafa=C5=82=20Mi=C5=82ecki?= <rafal@milecki.pl>
Subject: [PATCH V2] dt-bindings: nvmem: add U-Boot environment variables binding
Date:   Thu, 17 Feb 2022 14:02:35 +0100
Message-Id: <20220217130235.7450-1-zajec5@gmail.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Rafał Miłecki <rafal@milecki.pl>

U-Boot uses environment variables for storing device setup data. It
usually needs to be accessed by a bootloader, kernel and often
user-space.

This binding allows describing environment data located in a raw flash
partition. It's treated as NVMEM device and can be reused later for
other storage devices.

Using DT should be cleaner than hardcoding & duplicating such info in
multiple places. Bootloader & kernel can share DTS and user-space can
try reading it too or just have correct data exposed by a kernel.

A custom "compatible" string allows system to automatically load
relevant NVMEM driver but phandle can be also used for reading raw
location.

Signed-off-by: Rafał Miłecki <rafal@milecki.pl>
---
V2: Update descriptions to don't make this binding MTD (flash partition)
    specific. Mention multiple possible storage ways.
---
 .../devicetree/bindings/nvmem/u-boot,env.yaml | 66 +++++++++++++++++++
 MAINTAINERS                                   |  5 ++
 2 files changed, 71 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/nvmem/u-boot,env.yaml

diff --git a/Documentation/devicetree/bindings/nvmem/u-boot,env.yaml b/Documentation/devicetree/bindings/nvmem/u-boot,env.yaml
new file mode 100644
index 000000000000..a53e34152c97
--- /dev/null
+++ b/Documentation/devicetree/bindings/nvmem/u-boot,env.yaml
@@ -0,0 +1,66 @@
+# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/nvmem/u-boot,env.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: U-Boot environment variables
+
+description: |
+  U-Boot uses environment variables to store device parameters and
+  configuration. They may be used for booting process, setup or keeping end user
+  info.
+
+  Data is stored using U-Boot specific formats (variant specific header and NUL
+  separated key-value pairs).
+
+  Environment data can be stored on various storage entities, e.g.:
+  1. Raw flash partition
+  2. UBI volume
+
+  This binding allows marking storage device (as containing env data) and
+  specifying used format.
+
+  Right now only flash partition case is covered but it may be extended to e.g.
+  UBI volumes in the future.
+
+maintainers:
+  - Rafał Miłecki <rafal@milecki.pl>
+
+allOf:
+  - $ref: nvmem.yaml#
+
+properties:
+  compatible:
+    oneOf:
+      - description: A standalone env data block
+        const: u-boot,env
+      - description: Two redundant blocks with active one flagged
+        const: u-boot,env-redundant-bool
+      - description: Two redundant blocks with active having higher counter
+        const: u-boot,env-redundant-count
+
+  reg:
+    maxItems: 1
+
+unevaluatedProperties: false
+
+examples:
+  - |
+    partitions {
+        compatible = "fixed-partitions";
+        #address-cells = <1>;
+        #size-cells = <1>;
+
+        partition@0 {
+            reg = <0x0 0x40000>;
+            label = "u-boot";
+            read-only;
+        };
+
+        env: partition@40000 {
+            compatible = "u-boot,env";
+            reg = <0x40000 0x10000>;
+            label = "u-boot-env";
+        };
+    };
diff --git a/MAINTAINERS b/MAINTAINERS
index 66aa3a589f6a..55c56ce82856 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -19905,6 +19905,11 @@ W:	http://linuxtv.org
 T:	git git://linuxtv.org/media_tree.git
 F:	drivers/media/pci/tw686x/
 
+U-BOOT ENVIRONMENT VARIABLES
+M:	Rafał Miłecki <rafal@milecki.pl>
+S:	Maintained
+F:	Documentation/devicetree/bindings/nvmem/u-boot,env.yaml
+
 UACCE ACCELERATOR FRAMEWORK
 M:	Zhangfei Gao <zhangfei.gao@linaro.org>
 M:	Zhou Wang <wangzhou1@hisilicon.com>
-- 
2.34.1

