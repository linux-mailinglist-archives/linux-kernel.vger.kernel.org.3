Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 69B175690DC
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Jul 2022 19:42:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234060AbiGFRmd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Jul 2022 13:42:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58828 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233990AbiGFRm0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Jul 2022 13:42:26 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 4CE3220BD4
        for <linux-kernel@vger.kernel.org>; Wed,  6 Jul 2022 10:42:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1657129344;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Bm6ni0e0Z3ZqDaHM6VmzfCaa2VxT43x1YW4zQJliK1o=;
        b=Ph56QsOt4O4p6CyqrzHLBwCWxbwLVB38pmIPAI+WO00VTukDz0Q1ZywioJ8yJrM8KQ+sP/
        GIfKaJdtE7raTMLSlJFp7S/bTJZ22FvCel5plTNmvpvBXdKmWr0GnK2qZfkJ03h+y8Olex
        7lNyLrlHD2n221D7KVCeiUs6rV9sO+o=
Received: from mail-il1-f199.google.com (mail-il1-f199.google.com
 [209.85.166.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-453-yEBB8VLzPWu5-aqsowrSVA-1; Wed, 06 Jul 2022 13:42:20 -0400
X-MC-Unique: yEBB8VLzPWu5-aqsowrSVA-1
Received: by mail-il1-f199.google.com with SMTP id y13-20020a056e021bed00b002dc2f0ab426so2163393ilv.14
        for <linux-kernel@vger.kernel.org>; Wed, 06 Jul 2022 10:42:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:in-reply-to
         :references:organization:mime-version:content-transfer-encoding;
        bh=Bm6ni0e0Z3ZqDaHM6VmzfCaa2VxT43x1YW4zQJliK1o=;
        b=B4N7dJSojlZ1AQ7IYnKMOv3ci2yj5c8W7wEZNT7OZYPT8TCCvxfubADOtWIWQocY48
         FeIDL65kYe3l036oAQujJ8kcW0fpamQJJF8RBFYoAbhAjd7HGE3bcwYou46Ep1jNOfLg
         zoLNgE5/AqDT0QjBvHfdRnHYjuW4HtqT51B8+Iw1zSZO85Ylv5mGFhZ8S/4T1OrF8rix
         4LFvS/tiaW7rFhlJchP0+UWNNuKGPFxuqei2HZfcqPK3sGeliKQ7Y8Vz3yC6lBNlgj5L
         DJBCcGr/XWUz4CKHotufYy78ZDRDXGRFgDzAXahvqoFny3j094b5o5G6ac8CGc6Npb3+
         dq4A==
X-Gm-Message-State: AJIora/j6Lkgy9k6fT8hvuN1fGjC8QaDKdkyamnwxFF5UU0UxSnArFzz
        xbakHyb63K9glyI0eTUzYEe9RRg+8isG1V7E6K8gpV3NSv2NYmsJBlyuuJczjteLLe0dh5vm2Db
        TUbh3qkzH53+n22bd6e1I2PRs
X-Received: by 2002:a05:6e02:1be6:b0:2db:ea7f:10c4 with SMTP id y6-20020a056e021be600b002dbea7f10c4mr17220919ilv.248.1657129340288;
        Wed, 06 Jul 2022 10:42:20 -0700 (PDT)
X-Google-Smtp-Source: AGRyM1tKW5hHrIbN8D8MKAPlov0FsaTgJJCZrivyPi82ikNP5NQmibHb26OWtdHiMispm5nOi3tbJA==
X-Received: by 2002:a05:6e02:1be6:b0:2db:ea7f:10c4 with SMTP id y6-20020a056e021be600b002dbea7f10c4mr17220872ilv.248.1657129339926;
        Wed, 06 Jul 2022 10:42:19 -0700 (PDT)
Received: from redhat.com ([38.15.36.239])
        by smtp.gmail.com with ESMTPSA id i83-20020a6bb856000000b0065a47e16f53sm17005663iof.37.2022.07.06.10.42.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Jul 2022 10:42:19 -0700 (PDT)
Date:   Wed, 6 Jul 2022 11:42:17 -0600
From:   Alex Williamson <alex.williamson@redhat.com>
To:     Nicolin Chen <nicolinc@nvidia.com>
Cc:     <joro@8bytes.org>, <will@kernel.org>, <marcan@marcan.st>,
        <sven@svenpeter.dev>, <robin.murphy@arm.com>,
        <robdclark@gmail.com>, <baolu.lu@linux.intel.com>,
        <orsonzhai@gmail.com>, <baolin.wang7@gmail.com>,
        <zhang.lyra@gmail.com>, <jean-philippe@linaro.org>,
        <jgg@nvidia.com>, <kevin.tian@intel.com>,
        <suravee.suthikulpanit@amd.com>, <alyssa@rosenzweig.io>,
        <dwmw2@infradead.org>, <mjrosato@linux.ibm.com>,
        <gerald.schaefer@linux.ibm.com>, <thierry.reding@gmail.com>,
        <vdumpa@nvidia.com>, <jonathanh@nvidia.com>, <cohuck@redhat.com>,
        <thunder.leizhen@huawei.com>, <christophe.jaillet@wanadoo.fr>,
        <chenxiang66@hisilicon.com>, <john.garry@huawei.com>,
        <yangyingliang@huawei.com>, <iommu@lists.linux.dev>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-arm-msm@vger.kernel.org>, <linux-s390@vger.kernel.org>,
        <linux-tegra@vger.kernel.org>,
        <virtualization@lists.linux-foundation.org>, <kvm@vger.kernel.org>
Subject: Re: [PATCH v5 0/5] cover-letter: Simplify vfio_iommu_type1
 attach/detach routine
Message-ID: <20220706114217.105f4f61.alex.williamson@redhat.com>
In-Reply-To: <20220701214455.14992-1-nicolinc@nvidia.com>
References: <20220701214455.14992-1-nicolinc@nvidia.com>
Organization: Red Hat
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 1 Jul 2022 14:44:50 -0700
Nicolin Chen <nicolinc@nvidia.com> wrote:

> This is a preparatory series for IOMMUFD v2 patches. It enforces error
> code -EMEDIUMTYPE in iommu_attach_device() and iommu_attach_group() when
> an IOMMU domain and a device/group are incompatible. It also drops the
> useless domain->ops check since it won't fail in current environment.
> 
> These allow VFIO iommu code to simplify its group attachment routine, by
> avoiding the extra IOMMU domain allocations and attach/detach sequences
> of the old code.
> 
> Worths mentioning the exact match for enforce_cache_coherency is removed
> with this series, since there's very less value in doing that as KVM will
> not be able to take advantage of it -- this just wastes domain memory.
> Instead, we rely on Intel IOMMU driver taking care of that internally.
> 
> This is on github:
> https://github.com/nicolinc/iommufd/commits/vfio_iommu_attach

How do you foresee this going in, I'm imagining Joerg would merge the
first patch via the IOMMU tree and provide a topic branch that I'd
merge into the vfio tree along with the remaining patches.  Sound
right?  Thanks,

Alex

 
> Changelog
> v5:
>  * Rebased on top of Robin's "Simplify bus_type determination".
>  * Fixed a wrong change returning -EMEDIUMTYPE in arm-smmu driver.
>  * Added Baolu's "Reviewed-by".
> v4:
>  * Dropped -EMEDIUMTYPE change in mtk_v1 driver per Robin's input
>  * Added Baolu's and Kevin's Reviewed-by lines
> v3: https://lore.kernel.org/kvm/20220623200029.26007-1-nicolinc@nvidia.com/
>  * Dropped all dev_err since -EMEDIUMTYPE clearly indicates what error.
>  * Updated commit message of enforce_cache_coherency removing patch.
>  * Updated commit message of domain->ops removing patch.
>  * Replaced "goto out_unlock" with simply mutex_unlock() and return.
>  * Added a line of comments for -EMEDIUMTYPE return check.
>  * Moved iommu_get_msi_cookie() into alloc_attach_domain() as a cookie
>    should be logically tied to the lifetime of a domain itself.
>  * Added Kevin's "Reviewed-by".
> v2: https://lore.kernel.org/kvm/20220616000304.23890-1-nicolinc@nvidia.com/
>  * Added -EMEDIUMTYPE to more IOMMU drivers that fit the category.
>  * Changed dev_err to dev_dbg for -EMEDIUMTYPE to avoid kernel log spam.
>  * Dropped iommu_ops patch, and removed domain->ops in VFIO directly,
>    since there's no mixed-driver use case that would fail the sanity.
>  * Updated commit log of the patch removing enforce_cache_coherency.
>  * Fixed a misplace of "num_non_pinned_groups--" in detach_group patch.
>  * Moved "num_non_pinned_groups++" in PATCH-5 to the common path between
>    domain-reusing and new-domain pathways, like the code previously did.
>  * Fixed a typo in EMEDIUMTYPE patch.
> v1: https://lore.kernel.org/kvm/20220606061927.26049-1-nicolinc@nvidia.com/
> 
> Jason Gunthorpe (1):
>   vfio/iommu_type1: Prefer to reuse domains vs match enforced cache
>     coherency
> 
> Nicolin Chen (4):
>   iommu: Return -EMEDIUMTYPE for incompatible domain and device/group
>   vfio/iommu_type1: Remove the domain->ops comparison
>   vfio/iommu_type1: Clean up update_dirty_scope in detach_group()
>   vfio/iommu_type1: Simplify group attachment
> 
>  drivers/iommu/amd/iommu.c                   |   2 +-
>  drivers/iommu/apple-dart.c                  |   4 +-
>  drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c |  15 +-
>  drivers/iommu/arm/arm-smmu/arm-smmu.c       |   5 +-
>  drivers/iommu/arm/arm-smmu/qcom_iommu.c     |   9 +-
>  drivers/iommu/intel/iommu.c                 |  10 +-
>  drivers/iommu/iommu.c                       |  28 ++
>  drivers/iommu/ipmmu-vmsa.c                  |   4 +-
>  drivers/iommu/omap-iommu.c                  |   3 +-
>  drivers/iommu/s390-iommu.c                  |   2 +-
>  drivers/iommu/sprd-iommu.c                  |   6 +-
>  drivers/iommu/tegra-gart.c                  |   2 +-
>  drivers/iommu/virtio-iommu.c                |   3 +-
>  drivers/vfio/vfio_iommu_type1.c             | 352 ++++++++++----------
>  14 files changed, 229 insertions(+), 216 deletions(-)
> 

