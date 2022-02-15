Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A98174B6E08
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Feb 2022 14:50:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237519AbiBONuV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Feb 2022 08:50:21 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:45828 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229710AbiBONuS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Feb 2022 08:50:18 -0500
Received: from mail-lf1-x134.google.com (mail-lf1-x134.google.com [IPv6:2a00:1450:4864:20::134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 089BCE01B;
        Tue, 15 Feb 2022 05:50:08 -0800 (PST)
Received: by mail-lf1-x134.google.com with SMTP id b11so12283697lfb.12;
        Tue, 15 Feb 2022 05:50:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=2kZ/IBmjcS9tZCWpYljYHJzrq23MizmdNHzM2IiJLCU=;
        b=dgiSfuFN3ASYDMIZDgYLeoYeom9SjwBzyCFOQNOKznbr/a4ilWWlYJYZYbu/j4ZdEe
         G1rkw84c8Lz0VwSIZiYYpnCSFNR+N/1CyGVc8OGOqMCTapaX0ede15R+iV45SSe5gnxH
         MwkmeyEYhU2+XfNYO7kJlX2Avdc0fy3rysVaJzVMyLOVxKb6ThaebceWU+664+w6jZgB
         M+AfffjDjZu58IICKKFto68ZZQ8ucymtzIHEB5kvSYWMtrEeLzxFFbxmsFsWIDF/y5i8
         /XHChzYnDC9Z+t+WrAdPi4lLh4uQhdODOu6vZ9qBjRBBj2EQZE/0H1HicgLvUv9LYtma
         QUDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=2kZ/IBmjcS9tZCWpYljYHJzrq23MizmdNHzM2IiJLCU=;
        b=vPkMvPwSeEMNF2/eijdMLBC3RuqD0VyC9P7EUqA84/sei+jWGpPLC35CyeSKv37S9Z
         52IrrYtfHxgAbVpplw4ZIeu20wS1HyrdaoGCc7T4T0+wYxphgnb4nqaeyw22wJpOr+No
         4LYI5GvYTDIhRXb40E+9NbOrh9qwSRKrEaibOQpfdrYscdPnyEjDIprwYrrDxcZ57sNe
         j9yXqQy32O2aiIhhbFCzh9fb4Vbml1Y3NGt5aplC8stYmjZxi4QJllqeZaBK2tfPtBwu
         Frvdyh6vnjTGFzR3W40tk8pee7yL41K/GSiGkbNsLVrucD7lfGKuk538MAmfx86UGGn2
         heDA==
X-Gm-Message-State: AOAM533MrAe9Ur3YldnpJm4c51kChaGq6sGO4NnG/pRdc/hyEACKWQej
        2x0/iSSDLimTzKoA+YHX08Y=
X-Google-Smtp-Source: ABdhPJzfACnGR5sOoGxWkg4794pAqyMrui1kHLYW8QkYqC9NtPLDvAa5aNmATPCzPoQn+F0pwnGR2w==
X-Received: by 2002:a05:6512:eaa:: with SMTP id bi42mr3254062lfb.93.1644933006217;
        Tue, 15 Feb 2022 05:50:06 -0800 (PST)
Received: from localhost.lan (ip-194-187-74-233.konfederacka.maverick.com.pl. [194.187.74.233])
        by smtp.gmail.com with ESMTPSA id o17sm4511757lfu.180.2022.02.15.05.50.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Feb 2022 05:50:05 -0800 (PST)
From:   =?UTF-8?q?Rafa=C5=82=20Mi=C5=82ecki?= <zajec5@gmail.com>
To:     Rob Herring <robh+dt@kernel.org>, Tom Rini <trini@konsulko.com>
Cc:     Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        Ricardo Salveti <ricardo@foundries.io>,
        Michal Simek <michal.simek@xilinx.com>,
        Jorge Ramirez-Ortiz <jorge@foundries.io>,
        devicetree@vger.kernel.org, u-boot@lists.denx.de,
        linux-kernel@vger.kernel.org,
        =?UTF-8?q?Rafa=C5=82=20Mi=C5=82ecki?= <rafal@milecki.pl>
Subject: [PATCH] dt-bindings: nvmem: add U-Boot environment variables binding
Date:   Tue, 15 Feb 2022 14:49:25 +0100
Message-Id: <20220215134925.32691-1-zajec5@gmail.com>
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

U-Boot uses environment variables for storing device setup data on
flash. That data usually needs to be accessed by a bootloader, kernel
and often user-space.

This binding allows describing environment data location and its format
clearly. In some/many cases it should be cleaner than hardcoding &
duplicating that info in multiple places. Bootloader & kernel can share
DTS and user-space can try reading it too or just have correct data
exposed by a kernel.

Signed-off-by: Rafał Miłecki <rafal@milecki.pl>
---
 .../devicetree/bindings/nvmem/u-boot,env.yaml | 58 +++++++++++++++++++
 MAINTAINERS                                   |  5 ++
 2 files changed, 63 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/nvmem/u-boot,env.yaml

diff --git a/Documentation/devicetree/bindings/nvmem/u-boot,env.yaml b/Documentation/devicetree/bindings/nvmem/u-boot,env.yaml
new file mode 100644
index 000000000000..a2b3a9b88eb8
--- /dev/null
+++ b/Documentation/devicetree/bindings/nvmem/u-boot,env.yaml
@@ -0,0 +1,58 @@
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
+  Data is stored on flash in a U-Boot specific format (header and NUL separated
+  key-value pairs).
+
+  This binding allows specifying data location and used format.
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
+            label = "u-boot";
+            reg = <0x0 0x40000>;
+            read-only;
+        };
+
+        partition@40000 {
+            compatible = "u-boot,env";
+            label = "u-boot-env";
+            reg = <0x40000 0x10000>;
+        };
+    };
diff --git a/MAINTAINERS b/MAINTAINERS
index d20344ab7900..2f07f1d2290a 100644
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

