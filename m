Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 90D07501BB6
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Apr 2022 21:21:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345297AbiDNTWX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Apr 2022 15:22:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52168 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345161AbiDNTWJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Apr 2022 15:22:09 -0400
Received: from mail-lf1-x130.google.com (mail-lf1-x130.google.com [IPv6:2a00:1450:4864:20::130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A2179A145C;
        Thu, 14 Apr 2022 12:19:43 -0700 (PDT)
Received: by mail-lf1-x130.google.com with SMTP id b21so10776932lfb.5;
        Thu, 14 Apr 2022 12:19:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=R46jQ8Mh8wQzPdylSEViVF+ujde6F3v3VBI24iINPTM=;
        b=QRWLAqmejMzVP/VaSSlfrFYwEo3OK4Yf6F7LquH6LbczOkSkbq/vAsvvcBkQZ3ISuO
         wk/F7z7KZoaZjO6jJEtsC8Z8u0HmEeGUEZBJ+5uIIL8d4EZc/Xy5CV+958+05d7Oh+3w
         0MTx5F+/q1lMyyGoE/T8SwKtQsZ+ljloGYnRMXgZR3RSh42S3JxNeguRIyZ8pSqxFcSJ
         lbwOzjD3LaDkuMdE7Vsq66i//JMVvHCxYJln9faVJVA4/8+FWK/0SSS5ZAme/0sNPB8x
         GZApoZF4cbZLwHjguo+2oIvkWDrnYDqQpErg124vnNNbbDISEkGcSHd43FjTBLZC5Hys
         u53A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=R46jQ8Mh8wQzPdylSEViVF+ujde6F3v3VBI24iINPTM=;
        b=hf6PxSD7Vr7l87OdoD9NNJAEBJLCSBtglmXXyciZgeR8YbFzBIItfG6L+sfFBz2XPF
         fbPD5Qzl+OU1DGp3fYvqI7KBFg8JOxBUVq9TlFquxisAfBEDp80evlAgI4rfTAj496WM
         nnw1vVTr7quXAc9RFq8OtoIKjuOnPgYjSxrUBL9IUf5+IISdN0PvQzUKOKoojggKRc3j
         7pT9qMp2u5r1+9xCRhk3yQv//bpGDTGGdTjNZSxCez3jPJirsmv060b1XqUy53tPkJMF
         Zu5P9TSNpZpCNogzMn4vy22cLvnDSL003YhApzrdozA9VdAcRo76pQ45NFjsh0jEOxMr
         y83g==
X-Gm-Message-State: AOAM5325wk9UfePDAfFCHcp9KUHUKOvTPR0rrBYwDrLM42FDI637jiXD
        jk8fbsTkJjJ0yxxIJFzRaQ4=
X-Google-Smtp-Source: ABdhPJwDFkGrudp03NZzkhnvIn/IK69FMZdjURZkh3p/wuKd/xnIHAcuOjWitfBhsfM9796bR6Fn5A==
X-Received: by 2002:a05:6512:169a:b0:44a:fea7:50a5 with SMTP id bu26-20020a056512169a00b0044afea750a5mr2825082lfb.498.1649963981876;
        Thu, 14 Apr 2022 12:19:41 -0700 (PDT)
Received: from otyshchenko.router ([212.22.223.21])
        by smtp.gmail.com with ESMTPSA id l3-20020a194943000000b0046b928d2795sm85001lfj.67.2022.04.14.12.19.40
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 14 Apr 2022 12:19:41 -0700 (PDT)
From:   Oleksandr Tyshchenko <olekstysh@gmail.com>
To:     xen-devel@lists.xenproject.org,
        virtualization@lists.linux-foundation.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Oleksandr Tyshchenko <oleksandr_tyshchenko@epam.com>,
        "Michael S. Tsirkin" <mst@redhat.com>,
        Jason Wang <jasowang@redhat.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Julien Grall <julien@xen.org>, Juergen Gross <jgross@suse.com>,
        Stefano Stabellini <sstabellini@kernel.org>
Subject: [RFC PATCH 3/6] dt-bindings: xen: Add xen,dev-domid property description for xen-virtio layer
Date:   Thu, 14 Apr 2022 22:19:30 +0300
Message-Id: <1649963973-22879-4-git-send-email-olekstysh@gmail.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1649963973-22879-1-git-send-email-olekstysh@gmail.com>
References: <1649963973-22879-1-git-send-email-olekstysh@gmail.com>
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

Introduce Xen specific binding for the virtio-mmio device to be used
by Xen virtio support driver in a subsequent commit.

This binding specifies the ID of Xen domain where the corresponding
device (backend) resides. This is needed for the option to restrict
memory access using Xen grant mappings to work.

Signed-off-by: Oleksandr Tyshchenko <oleksandr_tyshchenko@epam.com>
---
 .../devicetree/bindings/virtio/xen,dev-domid.yaml  | 39 ++++++++++++++++++++++
 1 file changed, 39 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/virtio/xen,dev-domid.yaml

diff --git a/Documentation/devicetree/bindings/virtio/xen,dev-domid.yaml b/Documentation/devicetree/bindings/virtio/xen,dev-domid.yaml
new file mode 100644
index 00000000..78be993
--- /dev/null
+++ b/Documentation/devicetree/bindings/virtio/xen,dev-domid.yaml
@@ -0,0 +1,39 @@
+# SPDX-License-Identifier: (GPL-2.0-only or BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/virtio/xen,dev-domid.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Xen specific binding for the virtio device
+
+maintainers:
+  - Oleksandr Tyshchenko <oleksandr_tyshchenko@epam.com>
+
+select: true
+
+description:
+  This binding specifies the ID of Xen domain where the corresponding device
+  (backend) resides. This is needed for the option to restrict memory access
+  using Xen grant mappings to work.
+
+  Note that current and generic "iommus" bindings are mutually exclusive, since
+  the restricted memory access model on Xen behaves as a kind of software IOMMU.
+
+properties:
+  xen,dev-domid:
+    $ref: /schemas/types.yaml#/definitions/uint32
+    description:
+      Should contain the ID of device's domain.
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

