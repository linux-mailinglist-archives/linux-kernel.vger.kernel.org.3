Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4354D467766
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Dec 2021 13:27:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235590AbhLCMbN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Dec 2021 07:31:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53308 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232849AbhLCMbM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Dec 2021 07:31:12 -0500
Received: from mail-pg1-x534.google.com (mail-pg1-x534.google.com [IPv6:2607:f8b0:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB29CC06174A
        for <linux-kernel@vger.kernel.org>; Fri,  3 Dec 2021 04:27:48 -0800 (PST)
Received: by mail-pg1-x534.google.com with SMTP id r5so2855743pgi.6
        for <linux-kernel@vger.kernel.org>; Fri, 03 Dec 2021 04:27:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=EA1du2e/ZPRzAt8K2DwIBgKjt5fsYwCbvSbLazp7FLA=;
        b=LnM14K0IH4hYWcx02Er5ag2+HMiyqlgR3Q0bBB0hoE/Yc+j2TzxgPYYBQHoDDQVheC
         2a1bjHXoHd+TLSDN5O7+t0DRX69uBDy1EpyIyLNnxRNBGd2czsiIHVDxr5tuI7xBzqYB
         /zTgw0PRoCeM4qOjNA7MACeNFmJfs7LtjmdeeHv7B+nhBnrKOEMjQtDmTh2gWHD+pkAG
         NCQfOnkp188m9zVsO6H4hFy6PPLm3lptrOhWxNYp//2esTtA4RfdwB6rAbNuhzZmdTJb
         jKTb7az+bf+exKCMGMRr61twCq1sgAWX500Y21LfOvfxR4xiz15JmzzH0kxo7NXy8oup
         Yj5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=EA1du2e/ZPRzAt8K2DwIBgKjt5fsYwCbvSbLazp7FLA=;
        b=RzZSb98rqT/Q2ZUaAIDBXxyG0p9UlP2UQweLd0lVkyzHOoW63cJgO/FnF8XCuNxkhU
         +VnxNNpsnLlCz7ET67rQNm0NTe8ggO51gmWRXI5Lx0TodTo2sn/Kira/2fGfosnr7qsD
         plqp7nrd3JrgUoFdwxF4nCnWnk16+Md/6wRQWG18jQZkbnTfOUdeODxOE+ZI7khGeJho
         UzN7tKROKCrd+7Z4EmmZ7Ja6ofFe2BsQLYDt1F3e16b2aL9hzCrCDXhLuhrtXQmIiiK9
         gPKWBAgu8IjUUIv7UL0g3h9kU3BxjSNSThEvAKwItfYlH6L9Zh/clzQXQj7GdfGxLBbw
         MV3A==
X-Gm-Message-State: AOAM533XVeCZALq+3ad3ObcIbye8sroSvY0C+g6ulrdFqspEUB2dCJm8
        zYjPCp6UEwaphSwUk0rCYPXWNQ==
X-Google-Smtp-Source: ABdhPJyrxTUXmZtazjCg/eZ+NyB0KowH4QAVCWqZOWtphbHo3fiDsky8cC6Lf9QHm8d5ncPuLQ4aIg==
X-Received: by 2002:a63:6687:: with SMTP id a129mr4131270pgc.477.1638534468248;
        Fri, 03 Dec 2021 04:27:48 -0800 (PST)
Received: from [10.152.0.6] ([94.177.118.64])
        by smtp.gmail.com with ESMTPSA id mp12sm5226964pjb.39.2021.12.03.04.27.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 03 Dec 2021 04:27:47 -0800 (PST)
Subject: Re: [RFC v16 0/9] SMMUv3 Nested Stage Setup (IOMMU part)
To:     Eric Auger <eric.auger@redhat.com>, eric.auger.pro@gmail.com,
        iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org,
        kvm@vger.kernel.org, kvmarm@lists.cs.columbia.edu, joro@8bytes.org,
        will@kernel.org, robin.murphy@arm.com, jean-philippe@linaro.org,
        zhukeqian1@huawei.com
Cc:     alex.williamson@redhat.com, jacob.jun.pan@linux.intel.com,
        yi.l.liu@intel.com, kevin.tian@intel.com, ashok.raj@intel.com,
        maz@kernel.org, peter.maydell@linaro.org, vivek.gautam@arm.com,
        shameerali.kolothum.thodi@huawei.com, wangxingang5@huawei.com,
        jiangkunkun@huawei.com, yuzenghui@huawei.com,
        nicoleotsuka@gmail.com, chenxiang66@hisilicon.com,
        sumitg@nvidia.com, nicolinc@nvidia.com, vdumpa@nvidia.com,
        zhangfei.gao@gmail.com, lushenming@huawei.com, vsethi@nvidia.com
References: <20211027104428.1059740-1-eric.auger@redhat.com>
From:   Zhangfei Gao <zhangfei.gao@linaro.org>
Message-ID: <ee119b42-92b1-5744-4321-6356bafb498f@linaro.org>
Date:   Fri, 3 Dec 2021 20:27:39 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20211027104428.1059740-1-eric.auger@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Hi, Eric

On 2021/10/27 下午6:44, Eric Auger wrote:
> This series brings the IOMMU part of HW nested paging support
> in the SMMUv3.
>
> The SMMUv3 driver is adapted to support 2 nested stages.
>
> The IOMMU API is extended to convey the guest stage 1
> configuration and the hook is implemented in the SMMUv3 driver.
>
> This allows the guest to own the stage 1 tables and context
> descriptors (so-called PASID table) while the host owns the
> stage 2 tables and main configuration structures (STE).
>
> This work mainly is provided for test purpose as the upper
> layer integration is under rework and bound to be based on
> /dev/iommu instead of VFIO tunneling. In this version we also get
> rid of the MSI BINDING ioctl, assuming the guest enforces
> flat mapping of host IOVAs used to bind physical MSI doorbells.
> In the current QEMU integration this is achieved by exposing
> RMRs to the guest, using Shameer's series [1]. This approach
> is RFC as the IORT spec is not really meant to do that
> (single mapping flag limitation).
>
> Best Regards
>
> Eric
>
> This series (Host) can be found at:
> https://github.com/eauger/linux/tree/v5.15-rc7-nested-v16
> This includes a rebased VFIO integration (although not meant
> to be upstreamed)
>
> Guest kernel branch can be found at:
> https://github.com/eauger/linux/tree/shameer_rmrr_v7
> featuring [1]
>
> QEMU integration (still based on VFIO and exposing RMRs)
> can be found at:
> https://github.com/eauger/qemu/tree/v6.1.0-rmr-v2-nested_smmuv3_v10
> (use iommu=nested-smmuv3 ARM virt option)
>
> Guest dependency:
> [1] [PATCH v7 0/9] ACPI/IORT: Support for IORT RMR node

Thanks a lot for upgrading these patches.

I have basically verified these patches on HiSilicon Kunpeng920.
And integrated them to these branches.
https://github.com/Linaro/linux-kernel-uadk/tree/uacce-devel-5.16
https://github.com/Linaro/qemu/tree/v6.1.0-rmr-v2-nested_smmuv3_v10

Though they are provided for test purpose,

Tested-by: Zhangfei Gao <zhangfei.gao@linaro.org>

Thanks
