Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A916C51F83C
	for <lists+linux-kernel@lfdr.de>; Mon,  9 May 2022 11:30:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237767AbiEIJdy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 May 2022 05:33:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43140 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235054AbiEIJP3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 May 2022 05:15:29 -0400
Received: from mail-wr1-x449.google.com (mail-wr1-x449.google.com [IPv6:2a00:1450:4864:20::449])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4626F184336
        for <linux-kernel@vger.kernel.org>; Mon,  9 May 2022 02:11:34 -0700 (PDT)
Received: by mail-wr1-x449.google.com with SMTP id s16-20020adfeb10000000b0020cc4e5e683so1244804wrn.6
        for <linux-kernel@vger.kernel.org>; Mon, 09 May 2022 02:11:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=IH0vvM/kP0uifpRXlZnh4SaDor5QOPAjFTBMDXDGKyo=;
        b=B09v9hRISUnIUJr8S6o8wK7zVTSj8p7Dl9kKiv6agbvXdk0K+rYHFsQ20A91SX2LQY
         a4u0BeNjZdtCIHaD6hg4CegDvRIumU+GG9+WswJSqcmqxyAaCndBhKWWA/sHm+mULJsM
         EFxCoAVKUQ62TqFfcEoIcjcQwUlAeEZtk+790dMSF/NrjY3dhm3GMEzv7pcHJmafQvPW
         Swp2yETs1yqHbFVgodLjp02YYtze2k5+QCtM7C7PB1k9Ldx4uTT94pFklbUwDiEih0lm
         Ehlp6ZSZbFfSclo1Bo+RsNbp95CtRYg77mCiPGfj1uWYZY3VIMXOv+KR4Ovb2UgNcgsU
         1xMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=IH0vvM/kP0uifpRXlZnh4SaDor5QOPAjFTBMDXDGKyo=;
        b=q5nJysPh405O2JpIBZb8w3G5g2G4I3Z2nTU+DT+K4oPf3qfgEQfExfUtejMAzj4WsD
         MgZuj4UsNRE+TU/FWcbfNXzuMMkQCcvi58CrwV9yxyU09apogWEUMjowwyF0kICpJ5Q/
         Ks5py2q4AEbmaOdkKe4fnP2U0b/P8X9zJqRxzQ3c44OKspkgmf6FZSsNrAGXUf+0kviH
         CrraDWdeGbMYnsncHKliroIS/YYvzhSR69vyiZB5FgRQdGbV5SxKjR15fC4PXfXrsob2
         N8rU4f0bG04V6/7oqy0HBexAJdSeKCReTfg0+HAHNXVcGWn6kiJkCZBexqAQMHUZ83tJ
         ACAg==
X-Gm-Message-State: AOAM533XuWPkv2szjzfQR6j3ug2AduVZvam2J6rbxDnjlLldJ5vQAhG3
        OkjCvGz6SWDxfIv+QCMfJbFvXnQo1ND+VBecLGo=
X-Google-Smtp-Source: ABdhPJzDBb+IibuMCsYzEHx70Sg9Oqf6zDRjgWN+hqsk+ZHhARM2Qrlz4RolnqAZwHGEgHxe5gIWNvoQgmwIYQWQ/TM=
X-Received: from sene.c.googlers.com ([fda3:e722:ac3:cc00:28:9cb1:c0a8:27c4])
 (user=sebastianene job=sendgmr) by 2002:a05:6000:1843:b0:20c:57b2:472c with
 SMTP id c3-20020a056000184300b0020c57b2472cmr12738619wri.142.1652087492700;
 Mon, 09 May 2022 02:11:32 -0700 (PDT)
Date:   Mon,  9 May 2022 09:11:04 +0000
In-Reply-To: <20220509091103.2220604-1-sebastianene@google.com>
Message-Id: <20220509091103.2220604-2-sebastianene@google.com>
Mime-Version: 1.0
References: <20220509091103.2220604-1-sebastianene@google.com>
X-Mailer: git-send-email 2.36.0.512.ge40c2bad7a-goog
Subject: [PATCH v5 1/2] dt-bindings: vcpu_stall_detector: Add
 qemu,vcpu-stall-detector compatible
From:   Sebastian Ene <sebastianene@google.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Dragan Cvetic <dragan.cvetic@xilinx.com>
Cc:     linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        maz@kernel.org, will@kernel.org, qperret@google.com,
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
 .../bindings/misc/vcpu_stall_detector.yaml    | 47 +++++++++++++++++++
 1 file changed, 47 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/misc/vcpu_stall_detector.yaml

diff --git a/Documentation/devicetree/bindings/misc/vcpu_stall_detector.yaml b/Documentation/devicetree/bindings/misc/vcpu_stall_detector.yaml
new file mode 100644
index 000000000000..2496fd84faa0
--- /dev/null
+++ b/Documentation/devicetree/bindings/misc/vcpu_stall_detector.yaml
@@ -0,0 +1,47 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/misc/vcpu_stall_detector.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: VCPU stall detector
+
+description: |
+  This binding describes a CPU stall detector mechanism for virtual cpus
+  which is accessed through MMIO.
+
+maintainers:
+  - Sebastian Ene <sebastianene@google.com>
+
+properties:
+  compatible:
+    enum:
+      - qemu,vcpu-stall-detector
+  clock-frequency:
+    $ref: /schemas/types.yaml#/definitions/uint32
+    description: |
+      The internal clock of the stall detector peripheral measure in Hz used
+      to decrement its internal counter register on each tick.
+      Defaults to 10 if unset.
+  timeout-sec:
+    $ref: /schemas/types.yaml#/definitions/uint32
+    description: |
+      The stall detector expiration timeout measured in seconds.
+      Defaults to 8 if unset. Please note that it also takes into account the
+      time spent while the VCPU is not running.
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
+      clock-frequency = <10>;
+      timeout-sec = <8>;
+      reg = <0x0 0x9030000 0x0 0x10000>;
+    };
+
+...
-- 
2.36.0.512.ge40c2bad7a-goog

