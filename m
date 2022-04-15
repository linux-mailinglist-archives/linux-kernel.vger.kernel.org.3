Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F062B502704
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Apr 2022 10:46:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245357AbiDOIsN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Apr 2022 04:48:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58632 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351533AbiDOIrf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Apr 2022 04:47:35 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 803F917E0B
        for <linux-kernel@vger.kernel.org>; Fri, 15 Apr 2022 01:45:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1650012306;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=UbLS45MxOVAnr1j0DEMaqGL/RKjN2qTV3wn5wivIOzo=;
        b=CI5pICF/TbWjtLgGwnXpW+TnNjBaJSfJw6DNHeu1RY5h7RZGM942rggQ1wkMuYrg+hkRA8
        MUNjq6TBi5onrHA4v6enlfCY//orAUP79d1BXp+I51pUboEJ8Iuh610cIilYZUX9N9xwJ+
        /Nx0bLUSqU5N823m8O1rQrJztt22ICQ=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-571-ncjfo2W3Ob6oRpM3uj8-BQ-1; Fri, 15 Apr 2022 04:45:05 -0400
X-MC-Unique: ncjfo2W3Ob6oRpM3uj8-BQ-1
Received: by mail-wm1-f69.google.com with SMTP id i184-20020a1c3bc1000000b0038e4c5968b5so5816957wma.0
        for <linux-kernel@vger.kernel.org>; Fri, 15 Apr 2022 01:45:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=UbLS45MxOVAnr1j0DEMaqGL/RKjN2qTV3wn5wivIOzo=;
        b=Qqggi41n124e3aD404HRKipoglPRfG/i/09QQm7WLIX1ne+pQTw0zX+Vj34ytl1kBl
         tPiyeFpL78X5nfgRGV0d5NVJW9qah2eT/GK+S/dx4Q0+xOM2m7qyiiIZmP29/FuIS3Ml
         n+7UgOi/e1DyXUbEDOPbVH1AoJ8Ot8iJMPSpjGEo/LRn5qoPwF1AGHGyw74dbodlqOgj
         jayQcH63RrIpro6cMt8jw9BQwulNUNS+psXKikGZ5IDFYTxkmetm+1/e3FaQAQiAg0s4
         ARdRfsCBd5k1K3+pyV5EFDjJtxjZu5OZuyCSD38HZzbwKqjOo/Rdbh85Vck26YZjP9JB
         8aCw==
X-Gm-Message-State: AOAM5318PNA7/o0kc5pOD8EQga7UPWzve++pbssmhZiehcBVNl0Jh41E
        Zy4Vq99GKWpl9UzQLUNcZB4Lw5MSGg/ZkrVbXJ8M1tf9mbG+S7KZFU6nvf50wTjMuOiZ9zVfTVm
        UA4xdhhaoj5zJlj+5wYv2KNhq
X-Received: by 2002:a05:600c:4f88:b0:391:e34e:ca66 with SMTP id n8-20020a05600c4f8800b00391e34eca66mr768126wmq.16.1650012303795;
        Fri, 15 Apr 2022 01:45:03 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxtZ3CsHMRHFsioNGpLaugIquRbj8GlmtB0g6ZbYpJjZi2MjwNik9eBG9L3OBpQkHXDtDgk7g==
X-Received: by 2002:a05:600c:4f88:b0:391:e34e:ca66 with SMTP id n8-20020a05600c4f8800b00391e34eca66mr768102wmq.16.1650012303495;
        Fri, 15 Apr 2022 01:45:03 -0700 (PDT)
Received: from redhat.com ([2.53.138.98])
        by smtp.gmail.com with ESMTPSA id f8-20020a5d64c8000000b0020784359295sm5084468wri.54.2022.04.15.01.45.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Apr 2022 01:45:02 -0700 (PDT)
Date:   Fri, 15 Apr 2022 04:44:58 -0400
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     Oleksandr Tyshchenko <olekstysh@gmail.com>
Cc:     xen-devel@lists.xenproject.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        virtualization@lists.linux-foundation.org,
        Oleksandr Tyshchenko <oleksandr_tyshchenko@epam.com>,
        Stefano Stabellini <sstabellini@kernel.org>,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        Juergen Gross <jgross@suse.com>, Julien Grall <julien@xen.org>,
        Bertrand Marquis <bertrand.marquis@arm.com>,
        Wei Chen <Wei.Chen@arm.com>, Henry Wang <Henry.Wang@arm.com>,
        Kaly Xin <Kaly.Xin@arm.com>, Jiamei Xie <Jiamei.Xie@arm.com>,
        Alex =?iso-8859-1?Q?Benn=E9e?= <alex.bennee@linaro.org>
Subject: Re: [RFC PATCH 0/6] virtio: Solution to restrict memory access under
 Xen using xen-virtio DMA ops layer
Message-ID: <20220415044225-mutt-send-email-mst@kernel.org>
References: <1649963973-22879-1-git-send-email-olekstysh@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1649963973-22879-1-git-send-email-olekstysh@gmail.com>
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 14, 2022 at 10:19:27PM +0300, Oleksandr Tyshchenko wrote:
> From: Oleksandr Tyshchenko <oleksandr_tyshchenko@epam.com>
> 
> Hello all.
> 
> The purpose of this RFC patch series is to add support for restricting memory access under Xen using specific
> grant table based DMA ops layer. Patch series is based on Juergen Gross’ initial work [1] which implies using
> grant references instead of raw guest physical addresses (GPA) for the virtio communications (some kind of
> the software IOMMU).
> 
> The high level idea is to create new Xen’s grant table based DMA ops layer for the guest Linux whose main
> purpose is to provide a special 64-bit DMA address which is formed by using the grant reference (for a page
> to be shared with the backend) with offset and setting the highest address bit (this is for the backend to
> be able to distinguish grant ref based DMA address from normal GPA). For this to work we need the ability
> to allocate contiguous (consecutive) grant references for multi-page allocations. And the backend then needs
> to offer VIRTIO_F_ACCESS_PLATFORM and VIRTIO_F_VERSION_1 feature bits (it must support virtio-mmio modern
> transport for 64-bit addresses in the virtqueue).

I'm not enough of a xen expert to review this, and I didn't get
all patches, but I'm very happy to see that approach being
taken. VIRTIO_F_ACCESS_PLATFORM and VIRTIO_F_VERSION_1 are
exactly the way to declare not all of memory is accessible.
Thanks!

> Xen's grant mapping mechanism is the secure and safe solution to share pages between domains which proven
> to work and works for years (in the context of traditional Xen PV drivers for example). So far, the foreign
> mapping is used for the virtio backend to map and access guest memory. With the foreign mapping, the backend
> is able to map arbitrary pages from the guest memory (or even from Dom0 memory). And as the result, the malicious
> backend which runs in a non-trusted domain can take advantage of this. Instead, with the grant mapping
> the backend is only allowed to map pages which were explicitly granted by the guest before and nothing else. 
> According to the discussions in various mainline threads this solution would likely be welcome because it
> perfectly fits in the security model Xen provides. 
> 
> What is more, the grant table based solution requires zero changes to the Xen hypervisor itself at least
> with virtio-mmio and DT (in comparison, for example, with "foreign mapping + virtio-iommu" solution which would
> require the whole new complex emulator in hypervisor in addition to new functionality/hypercall to pass IOVA
> from the virtio backend running elsewhere to the hypervisor and translate it to the GPA before mapping into
> P2M or denying the foreign mapping request if no corresponding IOVA-GPA mapping present in the IOMMU page table
> for that particular device). We only need to update toolstack to insert a new "xen,dev-domid" property to
> the virtio-mmio device node when creating a guest device-tree (this is an indicator for the guest to use grants
> and the ID of Xen domain where the corresponding backend resides, it is used as an argument to the grant mapping
> APIs). It worth mentioning that toolstack patch is based on non  upstreamed yet “Virtio support for toolstack
> on Arm” series which is on review now [2].
> 
> Please note the following:
> - Patch series only covers Arm and virtio-mmio (device-tree) for now. To enable the restricted memory access
>   feature on Arm the following options should be set:
>   CONFIG_XEN_VIRTIO = y
>   CONFIG_XEN_HVM_VIRTIO_GRANT = y
> - Some callbacks in xen-virtio DMA ops layer (map_sg/unmap_sg, etc) are not implemented yet as they are not
>   needed/used in the first prototype
> 
> Patch series is rebased on Linux 5.18-rc2 tag and tested on Renesas Salvator-X board + H3 ES3.0 SoC (Arm64)
> with standalone userspace (non-Qemu) virtio-mmio based virtio-disk backend running in Driver domain and Linux
> guest running on existing virtio-blk driver (frontend). No issues were observed. Guest domain 'reboot/destroy'
> use-cases work properly. I have also tested other use-cases such as assigning several virtio block devices
> or a mix of virtio and Xen PV block devices to the guest. 
> 
> 1. Xen changes located at (last patch):
> https://github.com/otyshchenko1/xen/commits/libxl_virtio_next
> 2. Linux changes located at:
> https://github.com/otyshchenko1/linux/commits/virtio_grant5
> 3. virtio-disk changes located at:
> https://github.com/otyshchenko1/virtio-disk/commits/virtio_grant
> 
> Any feedback/help would be highly appreciated.
> 
> [1] https://www.youtube.com/watch?v=IrlEdaIUDPk
> [2] https://lore.kernel.org/xen-devel/1649442065-8332-1-git-send-email-olekstysh@gmail.com/
> 
> Juergen Gross (2):
>   xen/grants: support allocating consecutive grants
>   virtio: add option to restrict memory access under Xen
> 
> Oleksandr Tyshchenko (4):
>   dt-bindings: xen: Add xen,dev-domid property description for
>     xen-virtio layer
>   virtio: Various updates to xen-virtio DMA ops layer
>   arm/xen: Introduce xen_setup_dma_ops()
>   arm/xen: Assign xen-virtio DMA ops for virtio devices in Xen guests
> 
>  .../devicetree/bindings/virtio/xen,dev-domid.yaml  |  39 +++
>  arch/arm/include/asm/xen/xen-ops.h                 |   1 +
>  arch/arm/mm/dma-mapping.c                          |   5 +-
>  arch/arm/xen/enlighten.c                           |  11 +
>  arch/arm64/include/asm/xen/xen-ops.h               |   1 +
>  arch/arm64/mm/dma-mapping.c                        |   5 +-
>  arch/x86/mm/init.c                                 |  15 +
>  arch/x86/mm/mem_encrypt.c                          |   5 -
>  arch/x86/xen/Kconfig                               |   9 +
>  drivers/xen/Kconfig                                |  20 ++
>  drivers/xen/Makefile                               |   1 +
>  drivers/xen/grant-table.c                          | 238 +++++++++++++--
>  drivers/xen/xen-virtio.c                           | 335 +++++++++++++++++++++
>  include/xen/arm/xen-ops.h                          |  20 ++
>  include/xen/grant_table.h                          |   4 +
>  include/xen/xen-ops.h                              |  13 +
>  16 files changed, 679 insertions(+), 43 deletions(-)
>  create mode 100644 Documentation/devicetree/bindings/virtio/xen,dev-domid.yaml
>  create mode 100644 arch/arm/include/asm/xen/xen-ops.h
>  create mode 100644 arch/arm64/include/asm/xen/xen-ops.h
>  create mode 100644 drivers/xen/xen-virtio.c
>  create mode 100644 include/xen/arm/xen-ops.h
> 
> -- 
> 2.7.4

