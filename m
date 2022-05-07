Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7691D51E92A
	for <lists+linux-kernel@lfdr.de>; Sat,  7 May 2022 20:20:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1446848AbiEGSXf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 7 May 2022 14:23:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52280 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1446795AbiEGSXQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 7 May 2022 14:23:16 -0400
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com [IPv6:2a00:1450:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 76C542FFF3;
        Sat,  7 May 2022 11:19:28 -0700 (PDT)
Received: by mail-wm1-x336.google.com with SMTP id l62-20020a1c2541000000b0038e4570af2fso6114879wml.5;
        Sat, 07 May 2022 11:19:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=f9eTxQwBpqmyE5YQv8y/mSGc6BFKrmx/9RtbXRM94yk=;
        b=q0QvHmJEV199SvJxS8MMwMhMnT/+xhVpVqbOLeHgkt06Xhs2dBC0jVTbeKOwr91pvR
         ndKaasEP0xJG1RLgJyqL7ROM0gZzZQdJc/q0MNhHsXPKClgmJU88UwkBbKhnyLTjrxeH
         akHWUnH51O7ewtusDhyChb/efNbilF+VAy0f52Ter98LqUPNVkvzci9eD41asZ+qZHI8
         cxd6Fw0R6dR9XKl9hBhot2Ml9a+SI7h0b6qTcC3h1dkFbCIGTfD57A7X/PwLBhWUviLJ
         RMrUlN4pHsO1OCXg4EHqgP/3qgV4jfWL/K1p0l8arjpAUs+e6MkOmajqxI/Xjre5TUMj
         SXUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=f9eTxQwBpqmyE5YQv8y/mSGc6BFKrmx/9RtbXRM94yk=;
        b=U1Xv2TTj2r2fYvELJfp/iYj9jx148urRPUPZEbC6A6xo+OzEcFrzeGC2dzRbz7dPHu
         hFWjDzR2BcHvo6vsFjJJKyEMT7IrqJgntXu78W+4R7Gzy/1OIseTyZXWuHrnKAh7yuG2
         6B87aOGn4LWtJd4EkSmL8JDdk4sgSE5MXTGajvmlDrK5nRZFHAf8nen6+LZTVUusNDj1
         mzump8e/HKM4e1GtSy5day90OacjflagNYXmJ4X3mKspSeZtdVuHrzbw1k+16bOEvQQb
         t5W3ZSrqvl5MjNmgd1TI1deux7rRNv4T16W6Q35rPvuLuiRMNYZ+Mm0W0rt0HAydblWV
         YsGA==
X-Gm-Message-State: AOAM5333iitphoNfhmzRhnmnqd2vGv/sbAjXY1/EUm8aLEkNUnLRJnyE
        gHOQ4pQukBbeHrSt/X/LLT8=
X-Google-Smtp-Source: ABdhPJzhvjQBg6LQrWKFmAkWoYNYrT/dAdUxxfWwxE0Fo8ocoWuRQNu1extz5NXA4crK+Rzl3m2uBw==
X-Received: by 2002:a05:600c:4f03:b0:394:6499:21c7 with SMTP id l3-20020a05600c4f0300b00394649921c7mr8976554wmq.103.1651947566943;
        Sat, 07 May 2022 11:19:26 -0700 (PDT)
Received: from otyshchenko.router ([212.22.223.21])
        by smtp.gmail.com with ESMTPSA id b10-20020a5d4d8a000000b0020c5253d8f3sm8198457wru.63.2022.05.07.11.19.25
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 07 May 2022 11:19:26 -0700 (PDT)
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
        Christoph Hellwig <hch@infradead.org>,
        Jean-Philippe Brucker <jean-philippe@linaro.org>
Subject: [PATCH V2 5/7] dt-bindings: Add xen,dev-domid property description for xen-grant DMA ops
Date:   Sat,  7 May 2022 21:19:06 +0300
Message-Id: <1651947548-4055-6-git-send-email-olekstysh@gmail.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1651947548-4055-1-git-send-email-olekstysh@gmail.com>
References: <1651947548-4055-1-git-send-email-olekstysh@gmail.com>
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

Changes V1 -> V2:
   - update text in description
   - change the maintainer of the binding
   - fix validation issue
   - reference xen,dev-domid.yaml schema from virtio/mmio.yaml
---
 .../devicetree/bindings/arm/xen,dev-domid.yaml     | 37 ++++++++++++++++++++++
 Documentation/devicetree/bindings/virtio/mmio.yaml |  7 ++++
 2 files changed, 44 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/arm/xen,dev-domid.yaml

diff --git a/Documentation/devicetree/bindings/arm/xen,dev-domid.yaml b/Documentation/devicetree/bindings/arm/xen,dev-domid.yaml
new file mode 100644
index 00000000..750e89e
--- /dev/null
+++ b/Documentation/devicetree/bindings/arm/xen,dev-domid.yaml
@@ -0,0 +1,37 @@
+# SPDX-License-Identifier: (GPL-2.0-only or BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/arm/xen,dev-domid.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Xen specific binding for virtualized devices (e.g. virtio)
+
+maintainers:
+  - Stefano Stabellini <sstabellini@kernel.org>
+
+select: true
+
+description:
+  This binding indicates that Xen grant mappings need to be enabled for
+  the device, and it specifies the ID of the domain where the corresponding
+  device (backend) resides. The property is required to restrict memory
+  access using Xen grant mappings.
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
+    virtio@3000 {
+            compatible = "virtio,mmio";
+            reg = <0x3000 0x100>;
+            interrupts = <41>;
+
+            /* The device is located in Xen domain with ID 1 */
+            xen,dev-domid = <1>;
+    };
diff --git a/Documentation/devicetree/bindings/virtio/mmio.yaml b/Documentation/devicetree/bindings/virtio/mmio.yaml
index 10c22b5..29a0932 100644
--- a/Documentation/devicetree/bindings/virtio/mmio.yaml
+++ b/Documentation/devicetree/bindings/virtio/mmio.yaml
@@ -13,6 +13,9 @@ description:
   See https://www.oasis-open.org/committees/tc_home.php?wg_abbrev=virtio for
   more details.
 
+allOf:
+  - $ref: /schemas/arm/xen,dev-domid.yaml#
+
 properties:
   compatible:
     const: virtio,mmio
@@ -33,6 +36,10 @@ properties:
     description: Required for devices making accesses thru an IOMMU.
     maxItems: 1
 
+  xen,dev-domid:
+    description: Required when Xen grant mappings need to be enabled for device.
+    $ref: /schemas/types.yaml#/definitions/uint32
+
 required:
   - compatible
   - reg
-- 
2.7.4

