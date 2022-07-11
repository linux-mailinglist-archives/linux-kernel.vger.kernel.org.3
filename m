Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 90EFA56D7A8
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Jul 2022 10:17:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229866AbiGKIRk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Jul 2022 04:17:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55406 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229593AbiGKIRe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Jul 2022 04:17:34 -0400
Received: from mail-wr1-x449.google.com (mail-wr1-x449.google.com [IPv6:2a00:1450:4864:20::449])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD6521E3E4
        for <linux-kernel@vger.kernel.org>; Mon, 11 Jul 2022 01:17:33 -0700 (PDT)
Received: by mail-wr1-x449.google.com with SMTP id l11-20020adfbd8b000000b0021d754b84c5so412268wrh.17
        for <linux-kernel@vger.kernel.org>; Mon, 11 Jul 2022 01:17:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=syuU6hHKkMyzySl7opH6TLKAl/ic71oCS/pfUZCKirM=;
        b=slmquxYyCF5l1GuoXqQAh4rbp57KlHoYd672itZUMAiym9q7m/Dl/0pwHmi0UgE1+U
         hvADufU+gM23uFNNqcyQGF9cSGK27l5TFJcZk3ZLu0q/KZZC5wdF8q9ap30X66KQm461
         mlveih2RYHgr3BF/VOfQDjThdudbkhjPtJbz+tVYUjmzhCDqFtGCvaI4A89DQycd8/0g
         F/wEC3WJN4bhcPNd9JafrI85dEl5lIsXfVSau+wldZwgfUylXdWom6xz6huoH4kEM0E/
         mQ0sezAx3iqML6sIfKIRKHBM5Gk55hShfYnKloRimYGwz6w7ODL4RHazZE65K3p1IdvS
         nfPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=syuU6hHKkMyzySl7opH6TLKAl/ic71oCS/pfUZCKirM=;
        b=y9KJY8AmIH3jcBGCAIpB9MsQafVgCr1AUb57dKc5WMGM0ntvRI/G54910+YVw92qfv
         qjZc0PEMSt68KCgI57lLcDuzV0KW2B9silPtLd0f58uhMpy2RDHF7FsA4qTwZf/dACSL
         CqlvhxHIu4l56ZD7+Faxw9EV3xnW+EOhHkUxO6jUlf82mYXPItKZQmGXnczZFBrtmVvD
         UJgGBCR9uhtGMAUaRU3keauSu6Q7Vh1ySW0iEjNPZBwDY9RGCZDloIMIrqHxm8v5gLph
         NjiLNTCjlGBTjzZDSJ1YWXbwaOFeK2fstjh5/GIdQng8nsU/JGOwXQm5Vt0laiCYHaYw
         Zbgg==
X-Gm-Message-State: AJIora9BKldrweSWKFCZY1EbLDwWTB0jonm1ONNYgSlybAYGh4Dlahd1
        e2f1o48gJ3of9uS3MFA29rkFPiYY7o7XOC9+Dwc=
X-Google-Smtp-Source: AGRyM1u7FuP1KGdBlg8jDEeP7dMShyBG/pP8xRp0jh0MP9N7jQYQLEjVuupE3XuY6SHDTU7MfUsP1bX/CaRPKxNdK74=
X-Received: from seb.c.googlers.com ([fda3:e722:ac3:cc00:28:9cb1:c0a8:31bd])
 (user=sebastianene job=sendgmr) by 2002:a05:600c:3c83:b0:39c:9039:852c with
 SMTP id bg3-20020a05600c3c8300b0039c9039852cmr14842863wmb.187.1657527452448;
 Mon, 11 Jul 2022 01:17:32 -0700 (PDT)
Date:   Mon, 11 Jul 2022 08:17:19 +0000
In-Reply-To: <20220711081720.2870509-1-sebastianene@google.com>
Message-Id: <20220711081720.2870509-2-sebastianene@google.com>
Mime-Version: 1.0
References: <20220711081720.2870509-1-sebastianene@google.com>
X-Mailer: git-send-email 2.37.0.rc0.161.g10f37bed90-goog
Subject: [PATCH v12 1/2] dt-bindings: vcpu_stall_detector: Add
 qemu,vcpu-stall-detector compatible
From:   Sebastian Ene <sebastianene@google.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Dragan Cvetic <dragan.cvetic@xilinx.com>
Cc:     linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        maz@kernel.org, will@kernel.org, vdonnefort@google.com,
        Guenter Roeck <linux@roeck-us.net>,
        Sebastian Ene <sebastianene@google.com>,
        Rob Herring <robh@kernel.org>
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

Reviewed-by: Rob Herring <robh@kernel.org>
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

