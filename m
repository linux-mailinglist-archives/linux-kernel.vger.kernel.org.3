Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9E42C481AFC
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Dec 2021 10:05:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238093AbhL3JFH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Dec 2021 04:05:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52710 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237961AbhL3JFD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Dec 2021 04:05:03 -0500
Received: from mail-lj1-x232.google.com (mail-lj1-x232.google.com [IPv6:2a00:1450:4864:20::232])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A436EC06173E;
        Thu, 30 Dec 2021 01:05:02 -0800 (PST)
Received: by mail-lj1-x232.google.com with SMTP id by39so39690396ljb.2;
        Thu, 30 Dec 2021 01:05:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=qJD186S2XKoNzVu+mbYMaAb2EZdG5LnCBd09sDF2R4A=;
        b=EjsU93qpYeMUtOLkHpD9TpRJWXawGtQX0ncW3Vln7DOBOb7pG/PC0LD5+gzmqz90S9
         URcbwRjLdqjwJBaL7HSbo9/3PUQVOkDubtkcz9taFMWidue0KtRxqI0bUVGn6Hcl1jA9
         8fT3ql0Ud0mZZ1WbfeEoZDHHPnoRC1JbUzLy6siGSjcHMeq1+VIaOXZV8n+j1yl41gk5
         nb7aHBixuMDx8HxA7ttJaOKjLCnDcU2y64afbH2lwD1NJ7V93sDw+6RmMpvEaPd+t5BB
         qolpaWTgW4ZJTiJEvqvUNUeUdNGnYH0sVJopNWS9yiG3K5KRahFhPoVkxs+Su6/gVOHN
         j4HQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=qJD186S2XKoNzVu+mbYMaAb2EZdG5LnCBd09sDF2R4A=;
        b=dbFTIXR9Y3B5dKb7u9m8di+HyJDmC+9rfbSVfDoPWdgGOHJmJkmlX+S7C1zw3pW5xU
         hUQORt8qCww2LX6y5yU+dInAk+E4ZP4kFWuIHBHDQowMZNHWHxev0oIlo6O5KetbXWmN
         /ZOv26fSIjZlmNu1DR9DCCnwHcXWsO9HIZT/7a+7dikpS/uwJvYppFv6gGQcPXDc1bpn
         w3K38ooFlgZSf3IkX5cjzLicLhHZjHZe0U12RHBBXjp9BhgnuD6cgRjpzQ6EZ3naXNKL
         72N4q2X+Vyt80TUTtZaa7I6T3+bbppuLDk/RKehHrod4Be3k+v37B89RAz3To+uFPuF5
         mvRA==
X-Gm-Message-State: AOAM530GUoY2W5Cfvn3G1N6K/jnzaaCKwg9GTDA4M4HRkxQQ2Exqlff/
        /9Ysa8mcL9gpEwOtyi56oqE=
X-Google-Smtp-Source: ABdhPJyMA2lF2DxYBvC1Nmxh8j3AMK1fbdok3UDzKj9earMnqtEk+Y1E7m/n3LlrJwGuzNL4/pGq8g==
X-Received: by 2002:a2e:9901:: with SMTP id v1mr26250906lji.61.1640855100917;
        Thu, 30 Dec 2021 01:05:00 -0800 (PST)
Received: from localhost.lan (ip-194-187-74-233.konfederacka.maverick.com.pl. [194.187.74.233])
        by smtp.gmail.com with ESMTPSA id d5sm2440007lfl.242.2021.12.30.01.04.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Dec 2021 01:05:00 -0800 (PST)
From:   =?UTF-8?q?Rafa=C5=82=20Mi=C5=82ecki?= <zajec5@gmail.com>
To:     Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mtd@lists.infradead.org,
        =?UTF-8?q?Rafa=C5=82=20Mi=C5=82ecki?= <rafal@milecki.pl>
Subject: [PATCH V2 2/3] dt-bindings: nvmem: add U-Boot environment variables binding
Date:   Thu, 30 Dec 2021 10:04:48 +0100
Message-Id: <20211230090449.11808-2-zajec5@gmail.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20211230090449.11808-1-zajec5@gmail.com>
References: <20211230090449.11808-1-zajec5@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Rafał Miłecki <rafal@milecki.pl>

This binding allows describing a (part of) MTD device (partition) that
contains a block with environment variables. Operating system usually
needs to parse that block to read variables values that may affect
booting process & device configuration.

Signed-off-by: Rafał Miłecki <rafal@milecki.pl>
---
V2: s/u,boot/u-boot/
---
 .../devicetree/bindings/nvmem/u-boot,env.yaml | 56 +++++++++++++++++++
 MAINTAINERS                                   |  5 ++
 2 files changed, 61 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/nvmem/u-boot,env.yaml

diff --git a/Documentation/devicetree/bindings/nvmem/u-boot,env.yaml b/Documentation/devicetree/bindings/nvmem/u-boot,env.yaml
new file mode 100644
index 000000000000..e3296e005ffd
--- /dev/null
+++ b/Documentation/devicetree/bindings/nvmem/u-boot,env.yaml
@@ -0,0 +1,56 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
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
+  interesting info.
+
+  Data is stored on flash partition in a U-Boot specific format (CRC32 and NUL
+  separated key-value pairs).
+
+  This binding allows specifying data location and format (default one or vendor
+  specific).
+
+maintainers:
+  - Rafał Miłecki <rafal@milecki.pl>
+
+allOf:
+  - $ref: nvmem.yaml#
+
+properties:
+  compatible:
+    enum:
+      - u-boot,env
+      - brcm,env
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
+            label = "uboot";
+            reg = <0x0 0x100000>;
+
+            #address-cells = <1>;
+            #size-cells = <1>;
+
+            nvmem@10000 {
+                compatible = "u-boot,env";
+                reg = <0x10000 0x10000>;
+            };
+        };
+    };
diff --git a/MAINTAINERS b/MAINTAINERS
index 67558097bb66..271c29c84c7d 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -19624,6 +19624,11 @@ W:	http://linuxtv.org
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
2.31.1

