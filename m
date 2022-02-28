Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6C1DC4C6D7C
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Feb 2022 14:13:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234936AbiB1NNn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Feb 2022 08:13:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58818 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231624AbiB1NNk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Feb 2022 08:13:40 -0500
Received: from mail-lf1-x12c.google.com (mail-lf1-x12c.google.com [IPv6:2a00:1450:4864:20::12c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5909B192A3;
        Mon, 28 Feb 2022 05:13:01 -0800 (PST)
Received: by mail-lf1-x12c.google.com with SMTP id i11so21302421lfu.3;
        Mon, 28 Feb 2022 05:13:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=EdNKXJkj2Hxc1yhKt9uLoL/rsONSDoRoULDQeNZCOcU=;
        b=IMXYolFvHnfacLay39iifcDxdLKD4Oe83NhqHvBStZwgk1PKAEcMzX9htgXOU8rFDP
         2xgENzHIst3hifPjBROpgglz1mnWrDyqDPyiu3mwmho+f+u9fmQ/SRi8Q018g5mukNMh
         LKVFEdy0mm81XfobwjyNcL7WrIQj2MdfJt7FaArruWs+bSsNW0R4Yl+/8NvcNuPeX0q3
         Sja9GH5vH8geCI6CUFgvicUCGSiz0kJLMkYXsDPTgd5f0Trw1TeW5vYkWD9iI6xRtPWp
         cCqiNoaqof0i0inU6uzFzrPGh7tcefl09AamjjOPI41VHgMGpkpxAoH5OighSSrb1lRu
         XzSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=EdNKXJkj2Hxc1yhKt9uLoL/rsONSDoRoULDQeNZCOcU=;
        b=Se2olIuwRHBkiYrKFGRE3NfE7/m0A0aZuA4X7l99VG7KU9NPVvapUGv62NOY2pi/Cq
         n49k7q5Dmbd08ONbqWjl07BpGNAM4mTVJ7ETtoZg0UG83CVwQ+wYSTvoCPAa2EMLAYFl
         n4607pUn2BaYeM2J117TTHgzN03n7z1bbWj3qxubOUraD1pYRHHtNKTSCzdyUR83LyVw
         ByBehuOZrBaP5YTVPTZ+Eq3zQV5vODl88Owesj0SDqP6ZpF5n07BxrH1VEAb4gP+KXj+
         iQX3YMxyp2QArqJ91fi96OwQosztr/kZ0qbC+8fgw/FXr4Ukbbz4IwaFAeJOxTUoKFia
         EVlA==
X-Gm-Message-State: AOAM5314CeYT5eRYFEK/xgJmin2c7HS2fiMsn1+3wrdkAJzCQX3h+FTq
        clki8XYVV4iXGYwtNFfsNb6C3uM5RpA=
X-Google-Smtp-Source: ABdhPJzQWEpJrtVBfYUwsC1x5fwzu5Xqz652nAKgxPDmWHbqx9Hq944/Px6uTO9b4lqDQTdU8LP3TQ==
X-Received: by 2002:a05:6512:3b06:b0:443:3b12:a1ff with SMTP id f6-20020a0565123b0600b004433b12a1ffmr12116447lfv.157.1646053979536;
        Mon, 28 Feb 2022 05:12:59 -0800 (PST)
Received: from localhost.lan (ip-194-187-74-233.konfederacka.maverick.com.pl. [194.187.74.233])
        by smtp.gmail.com with ESMTPSA id l9-20020a2ea309000000b00246299de080sm1316532lje.48.2022.02.28.05.12.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Feb 2022 05:12:59 -0800 (PST)
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
Subject: [PATCH V3] dt-bindings: nvmem: add U-Boot environment variables binding
Date:   Mon, 28 Feb 2022 14:12:50 +0100
Message-Id: <20220228131250.16943-1-zajec5@gmail.com>
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
V3: Drop
    allOf:
      - $ref: nvmem.yaml#
    as we don't use anything rom the nvmem.yaml. Thanks Rob.
---
 .../devicetree/bindings/nvmem/u-boot,env.yaml | 62 +++++++++++++++++++
 MAINTAINERS                                   |  5 ++
 2 files changed, 67 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/nvmem/u-boot,env.yaml

diff --git a/Documentation/devicetree/bindings/nvmem/u-boot,env.yaml b/Documentation/devicetree/bindings/nvmem/u-boot,env.yaml
new file mode 100644
index 000000000000..e70b2a60cb9a
--- /dev/null
+++ b/Documentation/devicetree/bindings/nvmem/u-boot,env.yaml
@@ -0,0 +1,62 @@
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
+additionalProperties: false
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
+        };
+    };
diff --git a/MAINTAINERS b/MAINTAINERS
index db8052bc1d26..24fc181a7e6c 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -19958,6 +19958,11 @@ W:	http://linuxtv.org
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

