Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 00CC550BD9B
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Apr 2022 18:52:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1449922AbiDVQyv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Apr 2022 12:54:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51802 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1449871AbiDVQyU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Apr 2022 12:54:20 -0400
Received: from mail-lf1-x136.google.com (mail-lf1-x136.google.com [IPv6:2a00:1450:4864:20::136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0512D5F8DE;
        Fri, 22 Apr 2022 09:51:26 -0700 (PDT)
Received: by mail-lf1-x136.google.com with SMTP id y32so15294134lfa.6;
        Fri, 22 Apr 2022 09:51:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=99hspxuLODhQpov2wjpLVe38h5x1eJYakvWm7x8e6iI=;
        b=F23kF0eGH2ZVB+UGEjmW9/zKmFnzoAMLghAwzApvwMCcMhtBG9yJPpY4U1QzTxgJqh
         dlRXZHbEg3zZ7nY0RRV+8fUOu1XkZkXeqKyrW16n02fiZBATqOd2CzVkTaqbBEsKlX+6
         r6aK5PoP5QLM42PK/aLq8s/VUKQChEmq/ezbmXtxZxY1a/RDaoMGUVuns/+Ft+exgVHV
         qbfu1h52HdfRiNt9rNvFnhuiPOsYt6N8H7gak3I0DBjmtU3G2m7PdaKAunzdkWOdWVMV
         ovHh6R/nKxeNIZ67iu83BqdSWGokrQ3h7RK4/vcpMr2+xi4nqmoXe2TQmCa8LS8q13oq
         2CTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=99hspxuLODhQpov2wjpLVe38h5x1eJYakvWm7x8e6iI=;
        b=6FY5FYnS1St3K6vtckp1HCF1HGA1h0gC6c3GI822TaqBEt8EaDzH3TVjK0adfUOrpU
         N9Kl6EK/7nsZ3YV2J5O3ILtHk6KP21R1wP5DPrIBejLHmVAPHeRm028ZWM2SmLED3sh+
         x572An9S5Il2udEBGz35WI6rg9KB/j/3Y269m8uEcRFcOwq6/ywtYCpj5/mH3Mc1z6Qx
         1Ebr/EecZXzsa8wE38ZAj2BV6FTa6GoRZGOCzGhaCO8mkMsnoEz+S2VrdWV+Wxi90rhy
         Uywi66LCGs7PFxsfKmfwet8vJZYoXajEoyrLjydT2pVw9AtuavFuql2IchOH3PoEY7/e
         5XHA==
X-Gm-Message-State: AOAM530eKJjkjhIWXv10iTEK+8ecxWsWc/DPqGLjkcs/91PzgSgPLIRK
        dlqmigfP0qJpRAMUCGezkn0=
X-Google-Smtp-Source: ABdhPJxHzbye4XRLnSvBlQObswNpXjTS3XrDqE1jJLqg0maTMcfec1EnyxM49kxDQRnXmTUAz/llKg==
X-Received: by 2002:a05:6512:499:b0:46f:d419:a19b with SMTP id v25-20020a056512049900b0046fd419a19bmr3576799lfq.654.1650646284247;
        Fri, 22 Apr 2022 09:51:24 -0700 (PDT)
Received: from otyshchenko.router ([212.22.223.21])
        by smtp.gmail.com with ESMTPSA id n2-20020a056512310200b0046e2f507a3asm279742lfb.167.2022.04.22.09.51.23
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 22 Apr 2022 09:51:23 -0700 (PDT)
From:   Oleksandr Tyshchenko <olekstysh@gmail.com>
To:     xen-devel@lists.xenproject.org,
        virtualization@lists.linux-foundation.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Cc:     Oleksandr Tyshchenko <oleksandr_tyshchenko@epam.com>,
        Jason Wang <jasowang@redhat.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Julien Grall <julien@xen.org>, Juergen Gross <jgross@suse.com>,
        Stefano Stabellini <sstabellini@kernel.org>,
        "Michael S. Tsirkin" <mst@redhat.com>,
        Christoph Hellwig <hch@infradead.org>
Subject: [PATCH V1 4/6] dt-bindings: Add xen,dev-domid property description for xen-grant DMA ops
Date:   Fri, 22 Apr 2022 19:51:01 +0300
Message-Id: <1650646263-22047-5-git-send-email-olekstysh@gmail.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1650646263-22047-1-git-send-email-olekstysh@gmail.com>
References: <1650646263-22047-1-git-send-email-olekstysh@gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Oleksandr Tyshchenko <oleksandr_tyshchenko@epam.com>

Introduce Xen specific binding for the virtualized device (e.g. virtio)
to be used by Xen grant DMA-mapping layer in the subsequent commit.

This binding indicates that Xen grant mappings scheme needs to be
enabled for the device which DT node contains that property and specifies
the ID of Xen domain where the corresponding backend resides. The ID
(domid) is used as an argument to the grant mapping APIs.

This is needed for the option to restrict memory access using Xen grant
mappings to work which primary goal is to enable using virtio devices
in Xen guests.

Signed-off-by: Oleksandr Tyshchenko <oleksandr_tyshchenko@epam.com>
---
Changes RFC -> V1:
   - update commit subject/description and text in description
   - move to devicetree/bindings/arm/
---
 .../devicetree/bindings/arm/xen,dev-domid.yaml     | 37 ++++++++++++++++++++++
 1 file changed, 37 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/arm/xen,dev-domid.yaml

diff --git a/Documentation/devicetree/bindings/arm/xen,dev-domid.yaml b/Documentation/devicetree/bindings/arm/xen,dev-domid.yaml
new file mode 100644
index 00000000..ef0f747
--- /dev/null
+++ b/Documentation/devicetree/bindings/arm/xen,dev-domid.yaml
@@ -0,0 +1,37 @@
+# SPDX-License-Identifier: (GPL-2.0-only or BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/arm/xen,dev-domid.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Xen specific binding for the virtualized device (e.g. virtio)
+
+maintainers:
+  - Oleksandr Tyshchenko <oleksandr_tyshchenko@epam.com>
+
+select: true
+
+description:
+  This binding indicates that Xen grant mappings scheme needs to be enabled
+  for that device and specifies the ID of Xen domain where the corresponding
+  device (backend) resides. This is needed for the option to restrict memory
+  access using Xen grant mappings to work.
+
+properties:
+  xen,dev-domid:
+    $ref: /schemas/types.yaml#/definitions/uint32
+    description:
+      The domid (domain ID) of the domain where the device (backend) is running.
+
+additionalProperties: true
+
+examples:
+  - |
+    virtio_block@3000 {
+            compatible = "virtio,mmio";
+            reg = <0x3000 0x100>;
+            interrupts = <41>;
+
+            /* The device is located in Xen domain with ID 1 */
+            xen,dev-domid = <1>;
+    };
-- 
2.7.4

