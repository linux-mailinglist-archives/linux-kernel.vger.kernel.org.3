Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F1B4149FB8A
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jan 2022 15:21:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349068AbiA1OVo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Jan 2022 09:21:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41162 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349046AbiA1OVm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Jan 2022 09:21:42 -0500
Received: from mail-qv1-xf31.google.com (mail-qv1-xf31.google.com [IPv6:2607:f8b0:4864:20::f31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 42C4EC061714
        for <linux-kernel@vger.kernel.org>; Fri, 28 Jan 2022 06:21:41 -0800 (PST)
Received: by mail-qv1-xf31.google.com with SMTP id h16so5914773qvk.10
        for <linux-kernel@vger.kernel.org>; Fri, 28 Jan 2022 06:21:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=makDagrHRlU7vaXpIkbBqsJmR2imX/hQ0vT1IyZGbe8=;
        b=hagW1D3vrAXgmIdAaPuyb0ZYpBBI5GPj5cGf4t4VMPl2Hby0LDAfvZWMHlJD4RNPqz
         udQ6uMwMCSFght7z8OXaOlANPe89fBH+JadGzhs2iy3sYKIgrM8DNT9kykuob784vNJb
         /Y/FgIYpTCK+z7cKXzoYjO1GyqMmNfC0h5hNyGY73VQ5CoPXpXPP9nyVMuQ4vWD+VQga
         0hYXfzvwCLnChzgjp4NqFihb4T9f8dI0raxoWaXnXY+5G5GDrUXCHtUcKwBORYZObA9Y
         YPaqcPq/4bzPj+zORYsBg7/S7b+i2mhRoE+TwNrxyzVcDs3wf6ttmJBlILKVUF4beVAI
         0u4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=makDagrHRlU7vaXpIkbBqsJmR2imX/hQ0vT1IyZGbe8=;
        b=SMfURLX+aHBbPCKicMoDF2hJ1dRtrgG2ZEtiqRnMFL2KwkvyVDgqStFcscWlDCLz+k
         QpgksGgLauzQ2XpT4oxYUMFMOUV6GLKH/1PtUs4hqjIzyTkg6NcOLlP+mYPx37OGayqc
         lnNrIviW1zqQMLFPUlnJEIedulGn3vqXrNEil1EGuB7LwSo5R116aovM07DglupT0LKw
         48pfFqjpeCP47yFs5NvyXZmlEA7L0fK8NmdhG7lIWnuEGCEARcVsyc304MlJ0UR7DSTe
         qhslYxST2mt2V2gMBaDWMRS+oIBAk6j9mqoZcj2tXAXsCSxMhkJczxbs8szBBvz/7MPg
         o85w==
X-Gm-Message-State: AOAM531Gmn0ijNVCeqPytBleUYC+yS1DKukiZwWqDSFxtp4rsy/oCz90
        BAMfongeW65WciffdPQ/4Dtnkw==
X-Google-Smtp-Source: ABdhPJw4cx6/r5UFZ4KcHMvTw88cPD84uAemPNZJJIK7lCC9YLt9fXRF4PueHdJDgL+a1AuPlHcoPg==
X-Received: by 2002:a05:6214:519a:: with SMTP id kl26mr7027757qvb.68.1643379700472;
        Fri, 28 Jan 2022 06:21:40 -0800 (PST)
Received: from ziepe.ca (hlfxns017vw-142-162-113-129.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.162.113.129])
        by smtp.gmail.com with ESMTPSA id o4sm3070925qtw.53.2022.01.28.06.21.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Jan 2022 06:21:39 -0800 (PST)
Received: from jgg by mlx with local (Exim 4.94)
        (envelope-from <jgg@ziepe.ca>)
        id 1nDS8A-007UXM-Bu; Fri, 28 Jan 2022 10:21:38 -0400
Date:   Fri, 28 Jan 2022 10:21:38 -0400
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Logan Gunthorpe <logang@deltatee.com>
Cc:     linux-kernel@vger.kernel.org, linux-nvme@lists.infradead.org,
        linux-block@vger.kernel.org, linux-pci@vger.kernel.org,
        linux-mm@kvack.org, iommu@lists.linux-foundation.org,
        Stephen Bates <sbates@raithlin.com>,
        Christoph Hellwig <hch@lst.de>,
        Dan Williams <dan.j.williams@intel.com>,
        Christian =?utf-8?B?S8O2bmln?= <christian.koenig@amd.com>,
        John Hubbard <jhubbard@nvidia.com>,
        Don Dutile <ddutile@redhat.com>,
        Matthew Wilcox <willy@infradead.org>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        Jakowski Andrzej <andrzej.jakowski@intel.com>,
        Minturn Dave B <dave.b.minturn@intel.com>,
        Jason Ekstrand <jason@jlekstrand.net>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Xiong Jianxin <jianxin.xiong@intel.com>,
        Bjorn Helgaas <helgaas@kernel.org>,
        Ira Weiny <ira.weiny@intel.com>,
        Robin Murphy <robin.murphy@arm.com>,
        Martin Oliveira <martin.oliveira@eideticom.com>,
        Chaitanya Kulkarni <ckulkarnilinux@gmail.com>,
        Ralph Campbell <rcampbell@nvidia.com>,
        Alex Sierra <alex.sierra@amd.com>
Subject: Re: [PATCH v5 02/24] mm: remove extra ZONE_DEVICE struct page
 refcount
Message-ID: <20220128142138.GU8034@ziepe.ca>
References: <20220128002614.6136-1-logang@deltatee.com>
 <20220128002614.6136-3-logang@deltatee.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220128002614.6136-3-logang@deltatee.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 27, 2022 at 05:25:52PM -0700, Logan Gunthorpe wrote:
> From: Ralph Campbell <rcampbell@nvidia.com>
> 
> ZONE_DEVICE struct pages have an extra reference count that complicates the
> code for put_page() and several places in the kernel that need to check the
> reference count to see that a page is not being used (gup, compaction,
> migration, etc.). Clean up the code so the reference count doesn't need to
> be treated specially for ZONE_DEVICE.
> 
> [logang: dropped no longer used section from mm.h including
>  page_is_devmap_managed, rebased on v5.17-rc1 (possibly poorly)]
> Signed-off-by: Ralph Campbell <rcampbell@nvidia.com>
> Signed-off-by: Alex Sierra <alex.sierra@amd.com>
> Signed-off-by: Logan Gunthorpe <logang@deltatee.com>
> Reviewed-by: Christoph Hellwig <hch@lst.de>
> ---
>  arch/powerpc/kvm/book3s_hv_uvmem.c     |  2 +-
>  drivers/gpu/drm/nouveau/nouveau_dmem.c |  2 +-
>  fs/dax.c                               |  4 +-
>  include/linux/dax.h                    |  2 +-
>  include/linux/memremap.h               |  7 +--
>  include/linux/mm.h                     | 44 ----------------
>  lib/test_hmm.c                         |  2 +-
>  mm/internal.h                          |  8 +++
>  mm/memcontrol.c                        |  6 +--
>  mm/memremap.c                          | 70 +++++++-------------------
>  mm/migrate.c                           |  5 --
>  mm/page_alloc.c                        |  3 ++
>  mm/swap.c                              | 45 ++---------------
>  13 files changed, 46 insertions(+), 154 deletions(-)

This patch still can't be applied until the FSDAX issues are solved,
right? See my remarks the last time it was posted..

Jason
