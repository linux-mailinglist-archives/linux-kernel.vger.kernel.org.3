Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2ADE756A733
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Jul 2022 17:43:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235933AbiGGPnN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Jul 2022 11:43:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60866 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235895AbiGGPnJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Jul 2022 11:43:09 -0400
Received: from mail-wm1-x349.google.com (mail-wm1-x349.google.com [IPv6:2a00:1450:4864:20::349])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C8FC2CDC8
        for <linux-kernel@vger.kernel.org>; Thu,  7 Jul 2022 08:43:08 -0700 (PDT)
Received: by mail-wm1-x349.google.com with SMTP id z11-20020a05600c0a0b00b003a043991610so9712146wmp.8
        for <linux-kernel@vger.kernel.org>; Thu, 07 Jul 2022 08:43:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=syuU6hHKkMyzySl7opH6TLKAl/ic71oCS/pfUZCKirM=;
        b=ZMhXcj3R8JjdbPGK1RMipFlJQJ86lMDFuZO9OnnWxoDWejMeiIKlQE1/l6rKmWBNjG
         OMeODvWz+13whwJrciZJHlMCeujeT5FqqIflItvUc81Rb6SoYdvKWyTgKiCQ34lqGEwY
         tWckpY38L6n6VQUCV+793/zDMGGIunjtCQrneZSfl77+vSXSBxcYumZs7v/NCfZARZwJ
         eLWEZaQoH4hop3NISpz9zZtSl3HUxldZ+h6EXt8oEI9kDARhFgrD657Y88eYUFBAojxk
         KDdv749g3Fix3+bOiahusF270WW9315W6Y2DQx8B26t6860pffFQ738fdnuj+iLnV73s
         4BHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=syuU6hHKkMyzySl7opH6TLKAl/ic71oCS/pfUZCKirM=;
        b=HZVYeJTrqx9FkYw/VqZsU4M6noJTWv1SOH1YnPxKE+iWdKSVGIBND5jGnkDEB3hx+d
         aPp/T3c1cG3zLDxm0XCSbc+5UK0dixB9DNlmqmz1sEUoovOK2oO4rccdHh+k6SlWaEGE
         nasdm9cVhyVj+8lg/xdYXudeO7atxuc2GSz0CiWDIKkgZxhAaD+QMyUPkrw4FP4gJTJQ
         VrzYyHZaD/wW/BD/ChhoQPDzwIlReJeo0k3Uf/QmjyPoBxTURcprWzeYDjzUmyyqZwSr
         ZtzVytAft8RE8u3BSVjudy8Ojtb7Z+9xVtMfRcYf7imz5QzHrsXRIvBwy7FfvrUhd+FY
         WbkA==
X-Gm-Message-State: AJIora+4ukIGoaQxRiWTnG1xP8gjw0BiLeAXaciH1dlBqh7RGTe0GrP8
        xSDhCjxCppVCCxy6Xh44mR4ZJU/kdoJd31a74yM=
X-Google-Smtp-Source: AGRyM1s/z5vzucxzTqUnNnm7TDJ4CjC71IJlkl+nbMSVj+Hb1ZnIsskSvGSOP6z1E4Nv1uganQ5lrMPsgr02ysB+eNo=
X-Received: from seb.c.googlers.com ([fda3:e722:ac3:cc00:28:9cb1:c0a8:31bd])
 (user=sebastianene job=sendgmr) by 2002:a05:600c:35cf:b0:3a0:49c1:f991 with
 SMTP id r15-20020a05600c35cf00b003a049c1f991mr5046739wmq.95.1657208586677;
 Thu, 07 Jul 2022 08:43:06 -0700 (PDT)
Date:   Thu,  7 Jul 2022 15:42:26 +0000
In-Reply-To: <20220707154226.1478674-1-sebastianene@google.com>
Message-Id: <20220707154226.1478674-2-sebastianene@google.com>
Mime-Version: 1.0
References: <20220707154226.1478674-1-sebastianene@google.com>
X-Mailer: git-send-email 2.37.0.rc0.161.g10f37bed90-goog
Subject: [PATCH v10 1/2] dt-bindings: vcpu_stall_detector: Add
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

