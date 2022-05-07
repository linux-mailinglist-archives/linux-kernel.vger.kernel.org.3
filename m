Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4DE2C51E91C
	for <lists+linux-kernel@lfdr.de>; Sat,  7 May 2022 20:19:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1446786AbiEGSXJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 7 May 2022 14:23:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52170 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230244AbiEGSXH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 7 May 2022 14:23:07 -0400
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com [IPv6:2a00:1450:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 74353201BB
        for <linux-kernel@vger.kernel.org>; Sat,  7 May 2022 11:19:19 -0700 (PDT)
Received: by mail-wm1-x32a.google.com with SMTP id 1-20020a05600c248100b00393fbf11a05so8581107wms.3
        for <linux-kernel@vger.kernel.org>; Sat, 07 May 2022 11:19:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=XX78GWwMd1nia7nwVqcpbwaGJYOhbuMkDsq/dHRQm1Y=;
        b=NMekUxOk5A9I52CMEmMbtbPh5mza3hWVxCElP9ubE0KvS685lAQ6mzs2uEPkqTYBK5
         FOtr+BdB6ua9HG1LiAdwO4OQ/ebkBrNvHN1d0E5RgAetlfcCL9tAiR43Og6zAlRYW55W
         88r+oBoEZNEYeE4R4NV8LEcDnq8OEteXHou8aU/wrzVABEqgAjc7i4hhEk2ZK2u1/oZ5
         tgrOFy5uwz0lMPGxrMtC90bOEVjYYOCBCs8FlIuoyp4LB7p3QuIBSKqqtl6lhwkMVfIP
         03ZEu+ufqYvoSDN/C1JgVRCqUCkWH+mdS79q9RnfT6RP+tvDiP45mUuKhqCYaxTE2DLc
         JP4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=XX78GWwMd1nia7nwVqcpbwaGJYOhbuMkDsq/dHRQm1Y=;
        b=YHd9ICfUBnyUvNG+GxjjpnFIJj7fJIzH8JyyNOgJCggpYNx8kmHT5lwtjvGFnn0qoA
         IZL5c8S5EVcCB+m4ximTrnQSs9doRKJSdNbZGbwvWbEEEo06FQc1N/pczOtSMLB5HbwZ
         Un63v76EkpYYHJNV0yw9DQlTiw+BwdGyi/zYtX7Q4r+Fw2AXrCQqYHuA6MdyodQg1rch
         fWBItn2mPUsyfpu4sYbEseDx8JHgWO2IvgzV2tkVwWgep6ob+rnr4u4Cg4TfOJqvn4t7
         5hnGhs7+4p3nCiu1XeML27v9cqDkCrCbivzxAj/eOSUtMvdkPk7wJ9muS3eV82cdQFnw
         w2Kw==
X-Gm-Message-State: AOAM530LN+F1XH1ebOaj/nYu7zAh8TyZsj+HEuCbdqe8naRpDc85SETT
        vgk5ZHx8WM65Rz7nXylPxvQ=
X-Google-Smtp-Source: ABdhPJwccDv2hxVU9RUi+xr7GLJPabMJIGyT1Ic0dLKzlXNKKB7nSQ4aD1yIw6UH2GBRi7PQazSapw==
X-Received: by 2002:a05:600c:2112:b0:393:ff25:fb92 with SMTP id u18-20020a05600c211200b00393ff25fb92mr8827389wml.194.1651947557846;
        Sat, 07 May 2022 11:19:17 -0700 (PDT)
Received: from otyshchenko.router ([212.22.223.21])
        by smtp.gmail.com with ESMTPSA id b10-20020a5d4d8a000000b0020c5253d8f3sm8198457wru.63.2022.05.07.11.19.15
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 07 May 2022 11:19:16 -0700 (PDT)
From:   Oleksandr Tyshchenko <olekstysh@gmail.com>
To:     xen-devel@lists.xenproject.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        virtualization@lists.linux-foundation.org, x86@kernel.org
Cc:     Oleksandr Tyshchenko <oleksandr_tyshchenko@epam.com>,
        "Michael S. Tsirkin" <mst@redhat.com>,
        Christoph Hellwig <hch@infradead.org>,
        Stefano Stabellini <sstabellini@kernel.org>,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        Juergen Gross <jgross@suse.com>, Julien Grall <julien@xen.org>,
        Bertrand Marquis <bertrand.marquis@arm.com>,
        Wei Chen <Wei.Chen@arm.com>, Henry Wang <Henry.Wang@arm.com>,
        Kaly Xin <Kaly.Xin@arm.com>, Jiamei Xie <Jiamei.Xie@arm.com>,
        =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Subject: [PATCH V2 0/7] virtio: Solution to restrict memory access under Xen using xen-grant DMA-mapping layer
Date:   Sat,  7 May 2022 21:19:01 +0300
Message-Id: <1651947548-4055-1-git-send-email-olekstysh@gmail.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
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

Hello all.

The purpose of this patch series is to add support for restricting memory access under Xen using specific
grant table [1] based DMA-mapping layer. Patch series is based on Juergen Gross’ initial work [2] which implies
using grant references instead of raw guest physical addresses (GPA) for the virtio communications (some
kind of the software IOMMU).

You can find RFC-V1 patch series (and previous discussions) at [3].

The high level idea is to create new Xen’s grant table based DMA-mapping layer for the guest Linux whose main
purpose is to provide a special 64-bit DMA address which is formed by using the grant reference (for a page
to be shared with the backend) with offset and setting the highest address bit (this is for the backend to
be able to distinguish grant ref based DMA address from normal GPA). For this to work we need the ability
to allocate contiguous (consecutive) grant references for multi-page allocations. And the backend then needs
to offer VIRTIO_F_ACCESS_PLATFORM and VIRTIO_F_VERSION_1 feature bits (it must support virtio-mmio modern
transport for 64-bit addresses in the virtqueue).

Xen's grant mapping mechanism is the secure and safe solution to share pages between domains which proven
to work and works for years (in the context of traditional Xen PV drivers for example). So far, the foreign
mapping is used for the virtio backend to map and access guest memory. With the foreign mapping, the backend
is able to map arbitrary pages from the guest memory (or even from Dom0 memory). And as the result, the malicious
backend which runs in a non-trusted domain can take advantage of this. Instead, with the grant mapping
the backend is only allowed to map pages which were explicitly granted by the guest before and nothing else.
According to the discussions in various mainline threads this solution would likely be welcome because it
perfectly fits in the security model Xen provides.

What is more, the grant table based solution requires zero changes to the Xen hypervisor itself at least
with virtio-mmio and DT (in comparison, for example, with "foreign mapping + virtio-iommu" solution which would
require the whole new complex emulator in hypervisor in addition to new functionality/hypercall to pass IOVA
from the virtio backend running elsewhere to the hypervisor and translate it to the GPA before mapping into
P2M or denying the foreign mapping request if no corresponding IOVA-GPA mapping present in the IOMMU page table
for that particular device). We only need to update toolstack to insert a new "xen,dev-domid" property to
the virtio-mmio device node when creating a guest device-tree (this is an indicator for the guest to use grants
and the ID of Xen domain where the corresponding backend resides, it is used as an argument to the grant mapping
APIs). It worth mentioning that toolstack patch is based on non upstreamed yet “Virtio support for toolstack
on Arm” series which is on review now [4].

Please note the following:
- Patch series only covers Arm and virtio-mmio (device-tree) for now. To enable the restricted memory access
  feature on Arm the following option should be set:
  CONFIG_XEN_VIRTIO = y
- Patch series is based on "platform_has()" patch series which is on review now [5]
- Xen should be built with the following options:
  CONFIG_IOREQ_SERVER=y
  CONFIG_EXPERT=y

Patch series is rebased on Linux 5.18-rc4 tag with "platform_has()" series applied and tested on Renesas
Salvator-X board + H3 ES3.0 SoC (Arm64) with standalone userspace (non-Qemu) virtio-mmio based virtio-disk
backend running in Driver domain and Linux guest running on existing virtio-blk driver (frontend).
No issues were observed. Guest domain 'reboot/destroy' use-cases work properly. I have also tested other
use-cases such as assigning several virtio block devices or a mix of virtio and Xen PV block devices
to the guest. Patch series was build-tested on Arm32 and x86.

1. Xen changes located at (last patch):
https://github.com/otyshchenko1/xen/commits/libxl_virtio_next1
2. Linux changes located at (last 7 patches):
https://github.com/otyshchenko1/linux/commits/virtio_grant7
3. virtio-disk changes located at:
https://github.com/otyshchenko1/virtio-disk/commits/virtio_grant

Any feedback/help would be highly appreciated.

[1] https://xenbits.xenproject.org/docs/4.16-testing/misc/grant-tables.txt
[2] https://www.youtube.com/watch?v=IrlEdaIUDPk
[3] https://lore.kernel.org/xen-devel/1649963973-22879-1-git-send-email-olekstysh@gmail.com/
    https://lore.kernel.org/xen-devel/1650646263-22047-1-git-send-email-olekstysh@gmail.com/
[4] https://lore.kernel.org/xen-devel/1651598763-12162-1-git-send-email-olekstysh@gmail.com/
[5] https://lore.kernel.org/xen-devel/20220504155703.13336-1-jgross@suse.com/

Juergen Gross (3):
  xen/grants: support allocating consecutive grants
  xen/grant-dma-ops: Add option to restrict memory access under Xen
  xen/virtio: Enable restricted memory access using Xen grant mappings

Oleksandr Tyshchenko (4):
  arm/xen: Introduce xen_setup_dma_ops()
  dt-bindings: Add xen,dev-domid property description for xen-grant DMA
    ops
  xen/grant-dma-ops: Retrieve the ID of backend's domain for DT devices
  arm/xen: Assign xen-grant DMA ops for xen-grant DMA devices

 .../devicetree/bindings/arm/xen,dev-domid.yaml     |  37 +++
 Documentation/devicetree/bindings/virtio/mmio.yaml |   7 +
 arch/arm/include/asm/xen/xen-ops.h                 |   2 +
 arch/arm/mm/dma-mapping.c                          |   7 +-
 arch/arm/xen/enlighten.c                           |   2 +
 arch/arm64/include/asm/xen/xen-ops.h               |   2 +
 arch/arm64/mm/dma-mapping.c                        |   7 +-
 arch/x86/xen/enlighten_hvm.c                       |   2 +
 arch/x86/xen/enlighten_pv.c                        |   2 +
 drivers/xen/Kconfig                                |  15 +
 drivers/xen/Makefile                               |   1 +
 drivers/xen/grant-dma-ops.c                        | 324 +++++++++++++++++++++
 drivers/xen/grant-table.c                          | 238 +++++++++++++--
 include/xen/arm/xen-ops.h                          |  18 ++
 include/xen/grant_table.h                          |   4 +
 include/xen/xen-ops.h                              |  13 +
 include/xen/xen.h                                  |   8 +
 17 files changed, 647 insertions(+), 42 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/arm/xen,dev-domid.yaml
 create mode 100644 arch/arm/include/asm/xen/xen-ops.h
 create mode 100644 arch/arm64/include/asm/xen/xen-ops.h
 create mode 100644 drivers/xen/grant-dma-ops.c
 create mode 100644 include/xen/arm/xen-ops.h

-- 
2.7.4

