Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5407453BEBB
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Jun 2022 21:25:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237961AbiFBTYk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Jun 2022 15:24:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58910 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238551AbiFBTYZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Jun 2022 15:24:25 -0400
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com [IPv6:2a00:1450:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B3E3FF6C;
        Thu,  2 Jun 2022 12:24:23 -0700 (PDT)
Received: by mail-ej1-x630.google.com with SMTP id m20so11797396ejj.10;
        Thu, 02 Jun 2022 12:24:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=JATYvLe48LS2H6IM0secvITvXQRFYJatDO7tIGdxKew=;
        b=VTT0OBaJLQkU0DXmYjkEMy4pAELAV+jBlguhxMn7A/UqRxOPNmS5CHgPtJ8qEHZ37t
         dJchUBQgCQYu0sVoQ3XZJeZMu/D3NfZmgNzNcTSM6d3mQgW/gfiuwtDFZ3C/zopEft70
         53psImCdfXqfPzsfnsJ0x1WX2TilCTwWqqoFx42M3g540JOK5MIBPNJ4HDu3rtPd0NvR
         Q9zPUyeZA5Hv2CYInUh8MlFvL4nmj/eO1LHolt3AXfJI734JjCLw7bSnIYS5ZeZ4TIuR
         W3MaS7EEAi42acDU5NxK7pTxBgmMuOOT0q63i2Wpbh1F/ySWKn407asxBaQC4EJYFYUB
         ZPxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=JATYvLe48LS2H6IM0secvITvXQRFYJatDO7tIGdxKew=;
        b=xXYAu4d1YqYKyQNj1DR+5kHfdM+R2usSSCRTiV57WcliV2nBNmb1akTaAPh2XGn/+v
         698ssMmqI+VumDh9hzOOFvTP6Aa8iMOUWqLNEyNcLuzgVbIZCZ7v2IrMpxhWrVc4JM/F
         47DS1L8jVsvSZO3ImpIBrc/9cd3Ka9FnT8ILpwyp2zWORy6j3/zl1driMj9CioBd3Zuj
         To4GYv8QWTlEo8jv1wjYPCxXdW0edO6MRdm4LwKQLUKfW24gkoYgRQFfGDh9MdZR09hD
         7SDwsvf4AdowQHZbVNNDczvXCr2OP0FR4lz+XeNC0hmOr5IfrPK4YpylCN12R916sof4
         ztiw==
X-Gm-Message-State: AOAM531Iz5+SfdL15Z8VU6dOK/SJMW/MpwlxLZNMQHsd434P+bLL/oit
        69tGdbbwr5dwEVR9ZkeWFqQ=
X-Google-Smtp-Source: ABdhPJwiCOLciOxN6TBYEcpArcIF1bwM/jhBDOJnBMmkSZAOupAwiR+Hr2XzW8lOBJHN2sRoLEmt4Q==
X-Received: by 2002:a17:906:8146:b0:6ff:119c:881f with SMTP id z6-20020a170906814600b006ff119c881fmr5659395ejw.38.1654197862292;
        Thu, 02 Jun 2022 12:24:22 -0700 (PDT)
Received: from otyshchenko.router ([212.22.223.21])
        by smtp.gmail.com with ESMTPSA id eg13-20020a056402288d00b0042dce73168csm2938301edb.13.2022.06.02.12.24.20
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 02 Jun 2022 12:24:21 -0700 (PDT)
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
Subject: [PATCH V4 5/8] dt-bindings: Add xen,grant-dma IOMMU description for xen-grant DMA ops
Date:   Thu,  2 Jun 2022 22:23:50 +0300
Message-Id: <1654197833-25362-6-git-send-email-olekstysh@gmail.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1654197833-25362-1-git-send-email-olekstysh@gmail.com>
References: <1654197833-25362-1-git-send-email-olekstysh@gmail.com>
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
Reviewed-by: Stefano Stabellini <sstabellini@kernel.org>
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

Changes V3 -> V4:
   - add Stefano's R-b
   - remove underscore in iommu node name
   - remove consumer example virtio@3000
   - update text for two descriptions
---
 .../devicetree/bindings/iommu/xen,grant-dma.yaml   | 39 ++++++++++++++++++++++
 1 file changed, 39 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/iommu/xen,grant-dma.yaml

diff --git a/Documentation/devicetree/bindings/iommu/xen,grant-dma.yaml b/Documentation/devicetree/bindings/iommu/xen,grant-dma.yaml
new file mode 100644
index 00000000..be1539d
--- /dev/null
+++ b/Documentation/devicetree/bindings/iommu/xen,grant-dma.yaml
@@ -0,0 +1,39 @@
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
+  The Xen IOMMU represents the Xen grant table interface. Grant mappings
+  are to be used with devices connected to the Xen IOMMU using the "iommus"
+  property, which also specifies the ID of the backend domain.
+  The binding is required to restrict memory access using Xen grant mappings.
+
+properties:
+  compatible:
+    const: xen,grant-dma
+
+  '#iommu-cells':
+    const: 1
+    description:
+      The single cell is the domid (domain ID) of the domain where the backend
+      is running.
+
+required:
+  - compatible
+  - "#iommu-cells"
+
+additionalProperties: false
+
+examples:
+  - |
+    iommu {
+        compatible = "xen,grant-dma";
+        #iommu-cells = <1>;
+    };
-- 
2.7.4

