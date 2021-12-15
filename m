Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 20A5D475B5B
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Dec 2021 16:06:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243635AbhLOPEe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Dec 2021 10:04:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58488 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243578AbhLOPEc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Dec 2021 10:04:32 -0500
Received: from mail-wr1-x44a.google.com (mail-wr1-x44a.google.com [IPv6:2a00:1450:4864:20::44a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE33BC06173E
        for <linux-kernel@vger.kernel.org>; Wed, 15 Dec 2021 07:04:31 -0800 (PST)
Received: by mail-wr1-x44a.google.com with SMTP id y4-20020adfd084000000b00186b16950f3so5952107wrh.14
        for <linux-kernel@vger.kernel.org>; Wed, 15 Dec 2021 07:04:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=pyL+iMUMyBYszI38fgaNUchU9lpO/cjF5JBVAbs2Psc=;
        b=jlny/QcwcuEy5ev6XF2gP0ZBso3jt7gXEdzDliPUANM04QWypH6wlZ0wyaCNau6Tgg
         SQh1xauWbFMQRmMFhJWUMcsKaVIlp4IsySmN8/e20MtqeOFxLIVGH3aV2xb/6ZJA+w5k
         q/cE5KPjJ3cM9NZvSH68lANma2fPKBEKATrMobbXN2LvF4tjhztzCWf7AbcTgckOU7Jz
         zU8ncv5eKlZ77wWGyRWbn/2VYv7lD2EnT1e3rsr0W9gn2vml/097H3T6P6Zf5EUqhM2a
         42GjqdV3oQ307hbwL7ANGeNvvcH6gRJtLZV/qUlkOwI0wHqaXou+TeTDb1yEkAvB6cDJ
         Du2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=pyL+iMUMyBYszI38fgaNUchU9lpO/cjF5JBVAbs2Psc=;
        b=UIiW/X7fEOultBGGTxn5NB5qoOkfEKLG/PYyCBQdWaQ6Al+rsci32usgt5SOkIMxTC
         56qo89m4GSoA2OFaGPzb0T1eFXvXmUX2Jy5Wrov8gEMbja55BaEru1k37M7iOGAUAmw0
         Vtn4Ea4BPzYHn8CLCJG2VSs5Eyx2lw1Nx58VPGmjozGKTMzFx4odQHrBUh6vSnj7LfGO
         ioQLlnGkRJejdCjyZhxRJGOTZByAbcvNoH9zuv2z/hh4sX+La9hQqdhD9x0Vq6AquMMa
         5CTS4sgR4PqSsmzAHIHN4GvGtcdC1hO4aAkLhc5EFaUkPftVsC+tP6fOxLcEb9z7w522
         7y3Q==
X-Gm-Message-State: AOAM532BPJUGGufOWiLGt5wvjD2kmdOhhHYSIoZMIR0Iza8eSz26O4HP
        0m8sCvvf8uthWhEWOk6Gm56DR34rKX1FPA==
X-Google-Smtp-Source: ABdhPJzmS5YOOsuMIx+1NQ4DCD2saBVZYtr9JzL58yxt+iEGpqfttEKgmbfGQXpC99XWdPEIZ7pNlkYPBn5VBw==
X-Received: from dbrazdil.lon.corp.google.com ([2a00:79e0:d:209:8505:8095:9f82:42b7])
 (user=dbrazdil job=sendgmr) by 2002:a5d:4591:: with SMTP id
 p17mr4712734wrq.483.1639580670302; Wed, 15 Dec 2021 07:04:30 -0800 (PST)
Date:   Wed, 15 Dec 2021 15:04:09 +0000
In-Reply-To: <20211215150410.1707849-1-dbrazdil@google.com>
Message-Id: <20211215150410.1707849-2-dbrazdil@google.com>
Mime-Version: 1.0
References: <20211215150410.1707849-1-dbrazdil@google.com>
X-Mailer: git-send-email 2.34.1.173.g76aa8bc2d0-goog
Subject: [PATCH v4 1/2] dt-bindings: firmware: Add Open Profile for DICE
From:   David Brazdil <dbrazdil@google.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Rob Herring <robh+dt@kernel.org>, Arnd Bergmann <arnd@arndb.de>,
        David Brazdil <dbrazdil@google.com>,
        Will Deacon <will@kernel.org>,
        Andrew Scull <ascull@google.com>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add DeviceTree bindings for Open Profile for DICE, an open protocol for
measured boot. Firmware uses DICE to measure the hardware/software
combination and generates Compound Device Identifier (CDI) certificates.
These are stored in memory and the buffer is described in the DT as
a reserved memory region referenced by a compatible device node.

Signed-off-by: David Brazdil <dbrazdil@google.com>
---
 .../bindings/firmware/google,open-dice.yaml   | 51 +++++++++++++++++++
 1 file changed, 51 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/firmware/google,open-dice.yaml

diff --git a/Documentation/devicetree/bindings/firmware/google,open-dice.yaml b/Documentation/devicetree/bindings/firmware/google,open-dice.yaml
new file mode 100644
index 000000000000..1aa69f381b8c
--- /dev/null
+++ b/Documentation/devicetree/bindings/firmware/google,open-dice.yaml
@@ -0,0 +1,51 @@
+# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/firmware/google,open-dice.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Open Profile for DICE Device Tree Bindings
+
+description: |
+  This binding represents a reserved memory region containing data
+  generated by the Open Profile for DICE protocol.
+
+  See https://pigweed.googlesource.com/open-dice/
+
+maintainers:
+  - David Brazdil <dbrazdil@google.com>
+
+properties:
+  compatible:
+    enum:
+      - google,open-dice
+
+  memory-region:
+    maxItems: 1
+    description: |
+      phandle to the reserved memory node to be associated with the device
+      The reserved memory node should be defined as per the bindings,
+      Documentation/devicetree/bindings/reserved-memory/reserved-memory.yaml
+
+required:
+  - compatible
+  - memory-region
+
+additionalProperties: false
+
+examples:
+  - |
+    reserved-memory {
+        #address-cells = <2>;
+        #size-cells = <1>;
+
+        dice_reserved: dice@12340000 {
+            reg = <0x00 0x12340000 0x2000>;
+            no-map;
+        };
+    };
+
+    dice {
+        compatible = "google,open-dice";
+        memory-region = <&dice_reserved>;
+    };
-- 
2.34.1.173.g76aa8bc2d0-goog

