Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D5199538873
	for <lists+linux-kernel@lfdr.de>; Mon, 30 May 2022 23:01:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243269AbiE3VBI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 May 2022 17:01:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40194 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243223AbiE3VAf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 May 2022 17:00:35 -0400
Received: from mail-lj1-x230.google.com (mail-lj1-x230.google.com [IPv6:2a00:1450:4864:20::230])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 027339156C;
        Mon, 30 May 2022 14:00:32 -0700 (PDT)
Received: by mail-lj1-x230.google.com with SMTP id s13so981058ljd.4;
        Mon, 30 May 2022 14:00:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=+FJSf1vwMYB6K1+IygWHYLgdHKsQ/Ri86qwFQ7er7r4=;
        b=qQaEnEqIn8+KVCu3pPRo+BDQrdzTpsLMqbypvWjSdP/zBsAUHoF+Gerr5XT7DNRZW1
         0bpkwfkPu1hMKNckTJkbfqyHKTvvxPuLi2IZmXv8DMFMNKXEOakkweh7lNNBTtPOBInP
         RK0XWq87slLWTrLyJGGcQJqd8OW+B3LmN9XSCB6PL+8FmxkWI4gWNWUhuz5hn/0OLywc
         FmS2FjqsGyViA9Q3hUbKnJx84AOsuqZKFmqJuUPb+jKs+WQqtD/joiFjLBoJ8UGFL5xq
         t9Y57ac2D/yaMy2ErqyyoxRbxwDkBaU13uHKzvKFZmAcaFPptLb+oQOVf2CD+OnQqqDE
         qNHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=+FJSf1vwMYB6K1+IygWHYLgdHKsQ/Ri86qwFQ7er7r4=;
        b=BIRChedqMtG6xMp0pZRoqcp1BP1PbBucY7g6yndesc88p1xSmPYh4eOjEe4m5MkLO3
         oOLRxIjCTM7vJUQA6pJymIOkLNIKwhr6sIhxj7xQjAq3+jwazG+D2RHL0D1lliN1MBNM
         +PayFrAQVSsoh3zL2xTGIF8enfOL0z9YAgWTpvuQkwLlApCrRnhkbtlICNcGRLYz2z+L
         8YmMnok5bhtxwGDNBIrBkY5COeiHdKN5Qod+7kC8co8uSFIXBSbrzjG0IBZQIH6gU+h/
         tp6mmBDjJjU9ERVTv4u0AslfNTau897eDJGvam4dZQJTJoFpkfbSwDkhWV0kL6QpjtMP
         O7KA==
X-Gm-Message-State: AOAM533MwhsoxRrIyy/rTL7yGxt8vhtECfXuFbDCDghb5nZ6yQtmsaiF
        O67p8mnkVA0SPxc1uS7vAh4=
X-Google-Smtp-Source: ABdhPJy1j0CZ8u38C6o5Ly2O9aBU8Z/J0PR4IPWipSyv2hmVKkIJPggqQZ4sM6kw/XDqJU3SD8VYcQ==
X-Received: by 2002:a2e:a36f:0:b0:253:d948:731c with SMTP id i15-20020a2ea36f000000b00253d948731cmr32005387ljn.159.1653944431239;
        Mon, 30 May 2022 14:00:31 -0700 (PDT)
Received: from otyshchenko.router ([212.22.223.21])
        by smtp.gmail.com with ESMTPSA id k21-20020a2ea275000000b0025550e2693asm581541ljm.38.2022.05.30.14.00.30
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 30 May 2022 14:00:30 -0700 (PDT)
From:   Oleksandr Tyshchenko <olekstysh@gmail.com>
To:     xen-devel@lists.xenproject.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        iommu@lists.linux-foundation.org
Cc:     Oleksandr Tyshchenko <oleksandr_tyshchenko@epam.com>,
        Rob Herring <robh+dt@kernel.org>,
        Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Julien Grall <julien@xen.org>, Juergen Gross <jgross@suse.com>,
        Stefano Stabellini <sstabellini@kernel.org>,
        "Michael S. Tsirkin" <mst@redhat.com>,
        Christoph Hellwig <hch@infradead.org>,
        Arnd Bergmann <arnd@arndb.de>
Subject: [PATCH V3 5/8] dt-bindings: Add xen,grant-dma IOMMU description for xen-grant DMA ops
Date:   Tue, 31 May 2022 00:00:14 +0300
Message-Id: <1653944417-17168-6-git-send-email-olekstysh@gmail.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1653944417-17168-1-git-send-email-olekstysh@gmail.com>
References: <1653944417-17168-1-git-send-email-olekstysh@gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Oleksandr Tyshchenko <oleksandr_tyshchenko@epam.com>

The main purpose of this binding is to communicate Xen specific
information using generic IOMMU device tree bindings (which is
a good fit here) rather than introducing a custom property.

Introduce Xen specific IOMMU for the virtualized device (e.g. virtio)
to be used by Xen grant DMA-mapping layer in the subsequent commit.

The reference to Xen specific IOMMU node using "iommus" property
indicates that Xen grant mappings need to be enabled for the device,
and it specifies the ID of the domain where the corresponding backend
resides. The domid (domain ID) is used as an argument to the Xen grant
mapping APIs.

This is needed for the option to restrict memory access using Xen grant
mappings to work which primary goal is to enable using virtio devices
in Xen guests.

Signed-off-by: Oleksandr Tyshchenko <oleksandr_tyshchenko@epam.com>
---
Changes RFC -> V1:
   - update commit subject/description and text in description
   - move to devicetree/bindings/arm/

Changes V1 -> V2:
   - update text in description
   - change the maintainer of the binding
   - fix validation issue
   - reference xen,dev-domid.yaml schema from virtio/mmio.yaml

Change V2 -> V3:
   - Stefano already gave his Reviewed-by, I dropped it due to the changes (significant)
   - use generic IOMMU device tree bindings instead of custom property
     "xen,dev-domid"
   - change commit subject and description, was
     "dt-bindings: Add xen,dev-domid property description for xen-grant DMA ops"
---
 .../devicetree/bindings/iommu/xen,grant-dma.yaml   | 49 ++++++++++++++++++++++
 1 file changed, 49 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/iommu/xen,grant-dma.yaml

diff --git a/Documentation/devicetree/bindings/iommu/xen,grant-dma.yaml b/Documentation/devicetree/bindings/iommu/xen,grant-dma.yaml
new file mode 100644
index 00000000..ab5765c
--- /dev/null
+++ b/Documentation/devicetree/bindings/iommu/xen,grant-dma.yaml
@@ -0,0 +1,49 @@
+# SPDX-License-Identifier: (GPL-2.0-only or BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/iommu/xen,grant-dma.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Xen specific IOMMU for virtualized devices (e.g. virtio)
+
+maintainers:
+  - Stefano Stabellini <sstabellini@kernel.org>
+
+description:
+  The reference to Xen specific IOMMU node using "iommus" property indicates
+  that Xen grant mappings need to be enabled for the device, and it specifies
+  the ID of the domain where the corresponding backend resides.
+  The binding is required to restrict memory access using Xen grant mappings.
+
+properties:
+  compatible:
+    const: xen,grant-dma
+
+  '#iommu-cells':
+    const: 1
+    description:
+      Xen specific IOMMU is multiple-master IOMMU device.
+      The single cell describes the domid (domain ID) of the domain where
+      the backend is running.
+
+required:
+  - compatible
+  - "#iommu-cells"
+
+additionalProperties: false
+
+examples:
+  - |
+    xen_iommu {
+        compatible = "xen,grant-dma";
+        #iommu-cells = <1>;
+    };
+
+    virtio@3000 {
+        compatible = "virtio,mmio";
+        reg = <0x3000 0x100>;
+        interrupts = <41>;
+
+        /* The backend is located in Xen domain with ID 1 */
+        iommus = <&xen_iommu 1>;
+    };
-- 
2.7.4

