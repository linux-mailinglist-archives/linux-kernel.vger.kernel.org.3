Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 47E5C501BB5
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Apr 2022 21:21:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345153AbiDNTWI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Apr 2022 15:22:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51942 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229991AbiDNTWG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Apr 2022 15:22:06 -0400
Received: from mail-lf1-x12f.google.com (mail-lf1-x12f.google.com [IPv6:2a00:1450:4864:20::12f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 24945A1459
        for <linux-kernel@vger.kernel.org>; Thu, 14 Apr 2022 12:19:40 -0700 (PDT)
Received: by mail-lf1-x12f.google.com with SMTP id x33so10809577lfu.1
        for <linux-kernel@vger.kernel.org>; Thu, 14 Apr 2022 12:19:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=hBeYUJyh8cohFIBXMw+rp2zvHseFstsvrmjjJq6v1RA=;
        b=OS9Zyyw11+ahcSbaFBwnet4m/+SqFvTSxBJAra7HuBWht0AJqsov+byDRY2fDcE7Cs
         ytQj6zRGrqwIncCbAZw9crMvkswQ0zpZovlwDav7PgeiWph9GDH1Vn+lFgWyfq4pf9Q6
         D2bG8OWhifqZbowaCdO0dbVut/XPPk2sn+J4gDQPfI0IRUkzB49h1qS2s77WM2wj6Hc0
         XiiWyRzeOYZiYXi7x7A/rRQlZHH+glMqunBBbrU6BwKqFdu1m5oH6E29FDom7ZKFAHyW
         2ozw4PRAgrtB8ITcoMnvHW1txGeX3p4mnMFmtLnTd+4XkolWYRvNXGTibUY+EzZSgMXW
         D3vw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=hBeYUJyh8cohFIBXMw+rp2zvHseFstsvrmjjJq6v1RA=;
        b=CrRnxZLkgQsX7+isz5LVGNwtpsXbBDmQ6AJPizRUUNRPr7PBCOgQ9etq3eD47jpDaT
         KH51G34NqItNI9/Y4/0tz/AyM9EI4PQZy6JiOnnpqHXQDQBRR7pTeFZLI9VXhOmc28mU
         F5uok6T8Jxy4+yK8SxcTrszX13yAJmeT9OU48MgPX7WOYS3r+CGfPxuUk8GNVLcZBqdP
         FrfEPxtxXKkAkwUUjNcTuAaXtX031ucigCSFksBY3kZYuSDvaqBiYbsUTJuAvuEoUX6e
         N3v4U0j8eIUvKxDfcKyYcoIsAVCrvSFBATMA7WCk+HREfJuaRJk7VYVy5+f0kmL2h0Yf
         4FyQ==
X-Gm-Message-State: AOAM532utX8JtoFziUbuFKGPDHV/NVgHq9b3z3fLv5NRzgLJv0nivCZM
        mMzS8FXf0DHS3pWKaPS8GX0=
X-Google-Smtp-Source: ABdhPJyF5XrQhJyJg+R3ILmVTNsDHntbRwzflHI2RtvXh6tjp4CUiSxKClbc5XPs/9iS6Kt3RoSWZQ==
X-Received: by 2002:ac2:4d18:0:b0:46b:c318:193b with SMTP id r24-20020ac24d18000000b0046bc318193bmr2602821lfi.293.1649963978137;
        Thu, 14 Apr 2022 12:19:38 -0700 (PDT)
Received: from otyshchenko.router ([212.22.223.21])
        by smtp.gmail.com with ESMTPSA id l3-20020a194943000000b0046b928d2795sm85001lfj.67.2022.04.14.12.19.36
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 14 Apr 2022 12:19:37 -0700 (PDT)
From:   Oleksandr Tyshchenko <olekstysh@gmail.com>
To:     xen-devel@lists.xenproject.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        virtualization@lists.linux-foundation.org
Cc:     Oleksandr Tyshchenko <oleksandr_tyshchenko@epam.com>,
        "Michael S. Tsirkin" <mst@redhat.com>,
        Stefano Stabellini <sstabellini@kernel.org>,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        Juergen Gross <jgross@suse.com>, Julien Grall <julien@xen.org>,
        Bertrand Marquis <bertrand.marquis@arm.com>,
        Wei Chen <Wei.Chen@arm.com>, Henry Wang <Henry.Wang@arm.com>,
        Kaly Xin <Kaly.Xin@arm.com>, Jiamei Xie <Jiamei.Xie@arm.com>,
        =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Subject: [RFC PATCH 0/6] virtio: Solution to restrict memory access under Xen using xen-virtio DMA ops layer
Date:   Thu, 14 Apr 2022 22:19:27 +0300
Message-Id: <1649963973-22879-1-git-send-email-olekstysh@gmail.com>
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

The purpose of this RFC patch series is to add support for restricting memory access under Xen using specific
grant table based DMA ops layer. Patch series is based on Juergen Gross’ initial work [1] which implies using
grant references instead of raw guest physical addresses (GPA) for the virtio communications (some kind of
the software IOMMU).

The high level idea is to create new Xen’s grant table based DMA ops layer for the guest Linux whose main
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
APIs). It worth mentioning that toolstack patch is based on non  upstreamed yet “Virtio support for toolstack
on Arm” series which is on review now [2].

Please note the following:
- Patch series only covers Arm and virtio-mmio (device-tree) for now. To enable the restricted memory access
  feature on Arm the following options should be set:
  CONFIG_XEN_VIRTIO = y
  CONFIG_XEN_HVM_VIRTIO_GRANT = y
- Some callbacks in xen-virtio DMA ops layer (map_sg/unmap_sg, etc) are not implemented yet as they are not
  needed/used in the first prototype

Patch series is rebased on Linux 5.18-rc2 tag and tested on Renesas Salvator-X board + H3 ES3.0 SoC (Arm64)
with standalone userspace (non-Qemu) virtio-mmio based virtio-disk backend running in Driver domain and Linux
guest running on existing virtio-blk driver (frontend). No issues were observed. Guest domain 'reboot/destroy'
use-cases work properly. I have also tested other use-cases such as assigning several virtio block devices
or a mix of virtio and Xen PV block devices to the guest. 

1. Xen changes located at (last patch):
https://github.com/otyshchenko1/xen/commits/libxl_virtio_next
2. Linux changes located at:
https://github.com/otyshchenko1/linux/commits/virtio_grant5
3. virtio-disk changes located at:
https://github.com/otyshchenko1/virtio-disk/commits/virtio_grant

Any feedback/help would be highly appreciated.

[1] https://www.youtube.com/watch?v=IrlEdaIUDPk
[2] https://lore.kernel.org/xen-devel/1649442065-8332-1-git-send-email-olekstysh@gmail.com/

Juergen Gross (2):
  xen/grants: support allocating consecutive grants
  virtio: add option to restrict memory access under Xen

Oleksandr Tyshchenko (4):
  dt-bindings: xen: Add xen,dev-domid property description for
    xen-virtio layer
  virtio: Various updates to xen-virtio DMA ops layer
  arm/xen: Introduce xen_setup_dma_ops()
  arm/xen: Assign xen-virtio DMA ops for virtio devices in Xen guests

 .../devicetree/bindings/virtio/xen,dev-domid.yaml  |  39 +++
 arch/arm/include/asm/xen/xen-ops.h                 |   1 +
 arch/arm/mm/dma-mapping.c                          |   5 +-
 arch/arm/xen/enlighten.c                           |  11 +
 arch/arm64/include/asm/xen/xen-ops.h               |   1 +
 arch/arm64/mm/dma-mapping.c                        |   5 +-
 arch/x86/mm/init.c                                 |  15 +
 arch/x86/mm/mem_encrypt.c                          |   5 -
 arch/x86/xen/Kconfig                               |   9 +
 drivers/xen/Kconfig                                |  20 ++
 drivers/xen/Makefile                               |   1 +
 drivers/xen/grant-table.c                          | 238 +++++++++++++--
 drivers/xen/xen-virtio.c                           | 335 +++++++++++++++++++++
 include/xen/arm/xen-ops.h                          |  20 ++
 include/xen/grant_table.h                          |   4 +
 include/xen/xen-ops.h                              |  13 +
 16 files changed, 679 insertions(+), 43 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/virtio/xen,dev-domid.yaml
 create mode 100644 arch/arm/include/asm/xen/xen-ops.h
 create mode 100644 arch/arm64/include/asm/xen/xen-ops.h
 create mode 100644 drivers/xen/xen-virtio.c
 create mode 100644 include/xen/arm/xen-ops.h

-- 
2.7.4

