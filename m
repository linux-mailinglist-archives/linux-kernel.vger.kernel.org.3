Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9C74B54DE2A
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Jun 2022 11:28:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1359440AbiFPJ2K (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Jun 2022 05:28:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51408 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242186AbiFPJ2I (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Jun 2022 05:28:08 -0400
Received: from mail-wm1-x34a.google.com (mail-wm1-x34a.google.com [IPv6:2a00:1450:4864:20::34a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2EC0E11C04
        for <linux-kernel@vger.kernel.org>; Thu, 16 Jun 2022 02:28:03 -0700 (PDT)
Received: by mail-wm1-x34a.google.com with SMTP id c187-20020a1c35c4000000b003970013833aso402675wma.1
        for <linux-kernel@vger.kernel.org>; Thu, 16 Jun 2022 02:28:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=1US4ipP4yJiU7A6OGZd0Asu0Q0XiNeHCX3Q6kDfh5U0=;
        b=rkjeg6RzT4J90BHSluI8KX4QcffgtXJbeCtRKfmkre+JXLudYR4VRgH4/f/sAtKP24
         gCvaL7uTHvaolQ1vI0ecJAxHl297gGL0c/9oBzo/ne6cBzWpYmVg+dm+ur0lWR1KEPSV
         nXQg3OZBmMCOssO5lBoP+IjCi4k8Clf/1f14iTlh4nxjDRT5ILERmepDp59hga/dGZj3
         jxctvT0izLS4PnwBgxxhSNdVKMOWw710Lr2Z/MBeCCneQVgdcFwJqnGVIMzbAWyzWe9H
         Pq1/D9Hb3cJ6ZalBqzfRcykZW9lr7hxuLPPj9g+JpNSZTiFoqLpUfOeqY6BCMaf1k3LZ
         3ESQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=1US4ipP4yJiU7A6OGZd0Asu0Q0XiNeHCX3Q6kDfh5U0=;
        b=hI/n1GlhLaxKknTg46oftbeLj16rrLGw5M3JrlGFr1QcGzhWmQjc2SBcvD+rHqO1Us
         rrRQ8XZ6J/LGPVXOp2REUN6MjeyyLSc8G5d8V7Ddk+/RkRj2eHM265+hWJl7oXohLlCP
         bURlY8r07o7nG04LRvMEpLaB1l7bC+LbR76ZwBnB8GeXQvi+RGV2TnQ2Gecx/jy6DYLf
         ttfbBBV6IjlDqJ4GdvYQ6ajDxCjE+7/G1WCxD3JRYqmOewH4y0bos6eewtc/zJ93UBbG
         xPzcURfTbXnQbfFgel7ExI0Cx1jfBiNpxZBp6lm6uhyaJULx+UMb0TmnrBBWIEcH7c4J
         Y7mQ==
X-Gm-Message-State: AJIora8UdzAXuVncthm6cY2wC2CfsDeNhY24LXqC8z61P5N2nS9AKY3d
        Tk3kCP3E2zcChSfAqgwwQadraRIjaYhCgbdHgiE=
X-Google-Smtp-Source: AGRyM1vHrrC6U3tAYQLJBOexb6K9wgagt9bPjSyCNwxbZQFj8ruuBint847mczEy1+pjxi9txGiK5JSS2QKRFLbN5Tg=
X-Received: from sene.c.googlers.com ([fda3:e722:ac3:cc00:28:9cb1:c0a8:27c4])
 (user=sebastianene job=sendgmr) by 2002:a5d:4dc9:0:b0:215:c611:db73 with SMTP
 id f9-20020a5d4dc9000000b00215c611db73mr3886585wru.551.1655371682085; Thu, 16
 Jun 2022 02:28:02 -0700 (PDT)
Date:   Thu, 16 Jun 2022 09:27:38 +0000
In-Reply-To: <20220616092737.1713667-1-sebastianene@google.com>
Message-Id: <20220616092737.1713667-2-sebastianene@google.com>
Mime-Version: 1.0
References: <20220616092737.1713667-1-sebastianene@google.com>
X-Mailer: git-send-email 2.36.1.476.g0c4daa206d-goog
Subject: [PATCH v6 1/2] dt-bindings: vcpu_stall_detector: Add
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
        autolearn=unavailable autolearn_force=no version=3.4.6
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
 .../bindings/misc/vcpu_stall_detector.yaml    | 49 +++++++++++++++++++
 1 file changed, 49 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/misc/vcpu_stall_detector.yaml

diff --git a/Documentation/devicetree/bindings/misc/vcpu_stall_detector.yaml b/Documentation/devicetree/bindings/misc/vcpu_stall_detector.yaml
new file mode 100644
index 000000000000..55323676194b
--- /dev/null
+++ b/Documentation/devicetree/bindings/misc/vcpu_stall_detector.yaml
@@ -0,0 +1,49 @@
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
+
+  clock-frequency:
+    $ref: /schemas/types.yaml#/definitions/uint32
+    description: |
+      The internal clock of the stall detector peripheral measure in Hz used
+      to decrement its internal counter register on each tick.
+      Defaults to 10 if unset.
+
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
2.36.1.476.g0c4daa206d-goog

