Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AFC7755D78F
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Jun 2022 15:18:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232456AbiF0K2e (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Jun 2022 06:28:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36454 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232641AbiF0K2d (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Jun 2022 06:28:33 -0400
Received: from mail-wm1-x349.google.com (mail-wm1-x349.google.com [IPv6:2a00:1450:4864:20::349])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF596266B
        for <linux-kernel@vger.kernel.org>; Mon, 27 Jun 2022 03:28:31 -0700 (PDT)
Received: by mail-wm1-x349.google.com with SMTP id v184-20020a1cacc1000000b0039c7efa3e95so3384874wme.3
        for <linux-kernel@vger.kernel.org>; Mon, 27 Jun 2022 03:28:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=5yoOjCuxWXXLSKjOheMfZYUlzX6XssbQmvDDk/evZBs=;
        b=T+ZoH9BiG7ejFpyT99dcXqkAnMFezpeDUaKtR2HF7IBJZ8zeHqiw7fasMX3IbVlgm4
         iafSIU9+Ovnl02W+FHqO3dJlLJBfj7NzPULglX5lZci59ht+ts2AQWXJnxRtcdrQ6RQ6
         ThhGgkXLP22PuVA+R9GLoy6gN9Y30Z372VCgkc08+RUNXcz+da6cMc1+Rges3239IN/W
         igToaKzElYxK811q9Pgk0AK8xPBsjoGBJtlA0gO1um7yVEKngx02uOiTJhOPJJx2K40K
         nZYwqU4FU2ClDWJNieTbbc2Q4JC4bKepV1cUSpl83nSeplccpZjKkAsJm2WalXE4x57N
         5uJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=5yoOjCuxWXXLSKjOheMfZYUlzX6XssbQmvDDk/evZBs=;
        b=Q8quNZeRPF7sn5HKau3H9Axxnm0WIr1rRwOLMLAcCVanQB3e28o5gKbVybdDBKMde+
         s8Zx43YZvZCVRkrkkWIAPbpw84Mc6Ih7uAhIzhxLJXwGzYhtz5vBoPVd/crCIt2WGTTU
         keWUzNsSoQ4woPrtj3ljYX7m5GRHml6RH47bHWlqGa5jFIyo1BFaa/icmpsZc5XN/T7P
         IYLVDZBGKVkXYmIGxo4EQbmFHUeLqY7BCpqs6uTELuFEK0luDfYzoZwpBPr0rTyo4H0H
         /Yg8NsbmAJzsfYsd6ekhN0HU/oSCU5KBXWcca9l7ZOmSqjnt71+TXekftxjlfQJAqpq6
         FPnA==
X-Gm-Message-State: AJIora9sBSHWpi7LALHaTSX3hdKfNk6cq1uDW+rkhDlw8I61lKC6bgZb
        U/897BbKuMlLggDlQAjBv8QBQJsftWU/6wWgGiM=
X-Google-Smtp-Source: AGRyM1uixuGkpvZhhnFWALR4JaK6Q6IadJyqT4NA2OE2UH6hdeMCAfjRfnvN4u20zoYsaffGITCFvRiW7bBHpAH1UuA=
X-Received: from sene.c.googlers.com ([fda3:e722:ac3:cc00:28:9cb1:c0a8:27c4])
 (user=sebastianene job=sendgmr) by 2002:a05:600c:a14c:b0:3a0:4ddc:f710 with
 SMTP id ib12-20020a05600ca14c00b003a04ddcf710mr1164186wmb.38.1656325710439;
 Mon, 27 Jun 2022 03:28:30 -0700 (PDT)
Date:   Mon, 27 Jun 2022 10:28:11 +0000
In-Reply-To: <20220627102810.1811311-1-sebastianene@google.com>
Message-Id: <20220627102810.1811311-2-sebastianene@google.com>
Mime-Version: 1.0
References: <20220627102810.1811311-1-sebastianene@google.com>
X-Mailer: git-send-email 2.37.0.rc0.161.g10f37bed90-goog
Subject: [PATCH v8 1/2] dt-bindings: vcpu_stall_detector: Add
 qemu,vcpu-stall-detector compatible
From:   Sebastian Ene <sebastianene@google.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Dragan Cvetic <dragan.cvetic@xilinx.com>
Cc:     linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        maz@kernel.org, will@kernel.org, vdonnefort@google.com,
        Guenter Roeck <linux@roeck-us.net>,
        Sebastian Ene <sebastianene@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The VCPU stall detection mechanism allows to configure the expiration
duration and the internal counter clock frequency measured in Hz.
Add these properties in the schema.

While this is a memory mapped virtual device, it is expected to be loaded
when the DT contains the compatible: "qemu,vcpu-stall-detector" node.
In a protected VM we trust the generated DT nodes and we don't rely on
the host to present the hardware peripherals.

Signed-off-by: Sebastian Ene <sebastianene@google.com>
---
 .../misc/qemu,vcpu-stall-detector.yaml        | 51 +++++++++++++++++++
 1 file changed, 51 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/misc/qemu,vcpu-stall-detector.yaml

diff --git a/Documentation/devicetree/bindings/misc/qemu,vcpu-stall-detector.yaml b/Documentation/devicetree/bindings/misc/qemu,vcpu-stall-detector.yaml
new file mode 100644
index 000000000000..1aebeb696ee0
--- /dev/null
+++ b/Documentation/devicetree/bindings/misc/qemu,vcpu-stall-detector.yaml
@@ -0,0 +1,51 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/misc/qemu,vcpu-stall-detector.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: VCPU stall detector
+
+description:
+  This binding describes a CPU stall detector mechanism for virtual CPUs
+  which is accessed through MMIO.
+
+maintainers:
+  - Sebastian Ene <sebastianene@google.com>
+
+properties:
+  compatible:
+    enum:
+      - qemu,vcpu-stall-detector
+
+  reg:
+    maxItems: 1
+
+  clock-frequency:
+    $ref: /schemas/types.yaml#/definitions/uint32
+    description: |
+      The internal clock of the stall detector peripheral measure in Hz used
+      to decrement its internal counter register on each tick.
+      Defaults to 10 if unset.
+    default: 10
+
+  timeout-sec:
+    description: |
+      The stall detector expiration timeout measured in seconds.
+      Defaults to 8 if unset. Please note that it also takes into account the
+      time spent while the VCPU is not running.
+    default: 8
+
+required:
+  - compatible
+
+additionalProperties: false
+
+examples:
+  - |
+    vmwdt@9030000 {
+      compatible = "qemu,vcpu-stall-detector";
+      reg = <0x9030000 0x10000>;
+      clock-frequency = <10>;
+      timeout-sec = <8>;
+    };
-- 
2.37.0.rc0.161.g10f37bed90-goog

