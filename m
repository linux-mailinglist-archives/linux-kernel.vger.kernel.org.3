Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4C80453BEB6
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Jun 2022 21:25:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238398AbiFBTYU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Jun 2022 15:24:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58456 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238339AbiFBTYT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Jun 2022 15:24:19 -0400
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com [IPv6:2a00:1450:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D1292DCD
        for <linux-kernel@vger.kernel.org>; Thu,  2 Jun 2022 12:24:17 -0700 (PDT)
Received: by mail-ej1-x629.google.com with SMTP id me5so11304666ejb.2
        for <linux-kernel@vger.kernel.org>; Thu, 02 Jun 2022 12:24:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=uZWf8OfW06wjRVZAgl1HK+YLzR5URPKYW1hO+2XycMY=;
        b=WXCbAGOdwthNz7JOaFwSAUnxA/ls8r/957G0EZDOoet9Ob1zjdRpDX2mg5f7nRnQMe
         i7STT3KF5AT8zIFgesLqvyTUBaBAlR5fiYvzZ+Fws0kLwrNbREbLOhCQbg7kloyNOGhN
         RnenAJBMA6moK+K4pnXCG4gdMKwFnwfLhiEwFjpWRXcdTIqWwNglLc40m8Yn6zAu1pLu
         tpLnrRaBP3GCVuBAREF1faftktovinZR7ZIR2gDTIwlx3VvIt5dvw7EUscc+xzBE6NXC
         Y8wPNXXUy/gecJ9bHOIdAFdYMOAS5N76qAxkz8MPPGJlGmLdVZF+VeBdGiJFhM6vWQgz
         GKlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=uZWf8OfW06wjRVZAgl1HK+YLzR5URPKYW1hO+2XycMY=;
        b=bvlK1BzKUaqmVbu9eFfYK6V9B2b5PXDWM8Attr10Ut8XELhe+UYorumvnzk6EogzYR
         5zTjxN5zvWTYNSDtbBFJO+jK6OBfBPTFXaiZPy0P0+pwJMCyOhgNibtPQImoKWsksRqD
         IpNYgoUcGcKqxRrBnvNOvgEeKlWNrE+9WnahGg7+hJ6RTUIYBfMSFr9Wg+uHF46eC6RC
         1jgblf+oIbisL+h6McAlnroWIxTodVhK6kpXiK7M2CtzXjKQdfMJWl1ONU/O9SHX2SNZ
         Mp11zfYzbk+rdTZd8oBhaouDZuDljYQ47VHE0lXHMiIexA2lTErbLXmFuxNrCJoAbCbp
         yVew==
X-Gm-Message-State: AOAM533fvK9lCPAzGnmyTOkaVaI53j917/7LX3r9NLGBp4lHV6ljUIfz
        GFOm7aiyH8vpdXr4iQENc1o=
X-Google-Smtp-Source: ABdhPJzGG+rmpMMdlJHu1m2b41/LSpc6IQX1oGnbgOADMIvgbQTpOYfgkFHqvKd7AUU946nanljHwg==
X-Received: by 2002:a17:907:7f0d:b0:6ff:b84:a4aa with SMTP id qf13-20020a1709077f0d00b006ff0b84a4aamr5807189ejc.595.1654197855998;
        Thu, 02 Jun 2022 12:24:15 -0700 (PDT)
Received: from otyshchenko.router ([212.22.223.21])
        by smtp.gmail.com with ESMTPSA id eg13-20020a056402288d00b0042dce73168csm2938301edb.13.2022.06.02.12.24.14
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 02 Jun 2022 12:24:15 -0700 (PDT)
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
Subject: [PATCH V4 0/8] virtio: Solution to restrict memory access under Xen using xen-grant DMA-mapping layer
Date:   Thu,  2 Jun 2022 22:23:45 +0300
Message-Id: <1654197833-25362-1-git-send-email-olekstysh@gmail.com>
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

You can find RFC-V3 patch series (and previous discussions) at [3].

!!! Please note, the only diff between V3 and V4 is in commit #5, also I have collected the acks (commits ##4-7).

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
for that particular device). We only need to update toolstack to insert "xen,grant-dma" IOMMU node (to be referred
by the virtio-mmio device using "iommus" property) when creating a guest device-tree (this is an indicator for
the guest to use Xen grant mappings scheme for that device with the endpoint ID being used as ID of Xen domain
where the corresponding backend is running, the backend domid is used as an argument to the grant mapping APIs).
It worth mentioning that toolstack patch is based on non upstreamed yet “Virtio support for toolstack on Arm”
series which is on review now [4].

Please note the following:
- Patch series only covers Arm and virtio-mmio (device-tree) for now. To enable the restricted memory access
  feature on Arm the following option should be set:
  CONFIG_XEN_VIRTIO=y
- Patch series is based on "kernel: add new infrastructure for platform_has() support" patch series which
  is on review now [5]
- Xen should be built with the following options:
  CONFIG_IOREQ_SERVER=y
  CONFIG_EXPERT=y

Patch series is rebased on "for-linus-5.19" branch [1] with "platform_has()" series applied and tested on Renesas
Salvator-X board + H3 ES3.0 SoC (Arm64) with standalone userspace (non-Qemu) virtio-mmio based virtio-disk backend
running in Driver domain and Linux guest running on existing virtio-blk driver (frontend). No issues were observed.
Guest domain 'reboot/destroy' use-cases work properly.
I have also tested other use-cases such as assigning several virtio block devices or a mix of virtio and Xen PV block
devices to the guest. Patch series was build-tested on Arm32 and x86.

1. Xen changes located at (last patch):
https://github.com/otyshchenko1/xen/commits/libxl_virtio_next2_1
2. Linux changes located at (last 8 patches):
https://github.com/otyshchenko1/linux/commits/virtio_grant9
3. virtio-disk changes located at:
https://github.com/otyshchenko1/virtio-disk/commits/virtio_grant

Any feedback/help would be highly appreciated.

[1] https://xenbits.xenproject.org/docs/4.16-testing/misc/grant-tables.txt
[2] https://www.youtube.com/watch?v=IrlEdaIUDPk
[3] https://lore.kernel.org/xen-devel/1649963973-22879-1-git-send-email-olekstysh@gmail.com/
    https://lore.kernel.org/xen-devel/1650646263-22047-1-git-send-email-olekstysh@gmail.com/
    https://lore.kernel.org/xen-devel/1651947548-4055-1-git-send-email-olekstysh@gmail.com/
    https://lore.kernel.org/xen-devel/1653944417-17168-1-git-send-email-olekstysh@gmail.com/
[4] https://lore.kernel.org/xen-devel/1654106261-28044-1-git-send-email-olekstysh@gmail.com/
    https://lore.kernel.org/xen-devel/1653944813-17970-1-git-send-email-olekstysh@gmail.com/
[5] https://lore.kernel.org/xen-devel/20220504155703.13336-1-jgross@suse.com/
[6] https://git.kernel.org/pub/scm/linux/kernel/git/xen/tip.git/log/?h=for-linus-5.19

Juergen Gross (3):
  xen/grants: support allocating consecutive grants
  xen/grant-dma-ops: Add option to restrict memory access under Xen
  xen/virtio: Enable restricted memory access using Xen grant mappings

Oleksandr Tyshchenko (5):
  arm/xen: Introduce xen_setup_dma_ops()
  dt-bindings: Add xen,grant-dma IOMMU description for xen-grant DMA ops
  xen/grant-dma-iommu: Introduce stub IOMMU driver
  xen/grant-dma-ops: Retrieve the ID of backend's domain for DT devices
  arm/xen: Assign xen-grant DMA ops for xen-grant DMA devices

 .../devicetree/bindings/iommu/xen,grant-dma.yaml   |  39 +++
 arch/arm/include/asm/xen/xen-ops.h                 |   2 +
 arch/arm/mm/dma-mapping.c                          |   7 +-
 arch/arm/xen/enlighten.c                           |   2 +
 arch/arm64/include/asm/xen/xen-ops.h               |   2 +
 arch/arm64/mm/dma-mapping.c                        |   7 +-
 arch/x86/xen/enlighten_hvm.c                       |   2 +
 arch/x86/xen/enlighten_pv.c                        |   2 +
 drivers/xen/Kconfig                                |  20 ++
 drivers/xen/Makefile                               |   2 +
 drivers/xen/grant-dma-iommu.c                      |  78 +++++
 drivers/xen/grant-dma-ops.c                        | 345 +++++++++++++++++++++
 drivers/xen/grant-table.c                          | 251 ++++++++++++---
 include/xen/arm/xen-ops.h                          |  18 ++
 include/xen/grant_table.h                          |   4 +
 include/xen/xen-ops.h                              |  13 +
 include/xen/xen.h                                  |   8 +
 17 files changed, 756 insertions(+), 46 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/iommu/xen,grant-dma.yaml
 create mode 100644 arch/arm/include/asm/xen/xen-ops.h
 create mode 100644 arch/arm64/include/asm/xen/xen-ops.h
 create mode 100644 drivers/xen/grant-dma-iommu.c
 create mode 100644 drivers/xen/grant-dma-ops.c
 create mode 100644 include/xen/arm/xen-ops.h

-- 
2.7.4

