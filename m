Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3B41E46B8F6
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Dec 2021 11:27:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235119AbhLGKbS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Dec 2021 05:31:18 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124]:28205 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S235090AbhLGKbR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Dec 2021 05:31:17 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1638872867;
        h=from:from:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=WuGNH/dyVygpiGOJkCWGmo3DKhkMVbJWC9pFgiPTsyo=;
        b=Qzyxl7F8hJMl4RapqEy8wr2fAlZeeqPiHstGT9HapqfdFgkw2CV4OUlv4oUDlQ0Cp+QKUT
        VkQQQy6DIDkN8ewsUB01dQvMW/1slQW/fSo3kKPmmzSt+KDWwjZgQCXFuk1EQN+k+ohNoA
        wycVGXED2KHXN3Hgn3u7lpwUmmTU2BE=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-433-_f8qVsljNTKDh6_W6EsF1g-1; Tue, 07 Dec 2021 05:27:46 -0500
X-MC-Unique: _f8qVsljNTKDh6_W6EsF1g-1
Received: by mail-wm1-f69.google.com with SMTP id r129-20020a1c4487000000b00333629ed22dso1012405wma.6
        for <linux-kernel@vger.kernel.org>; Tue, 07 Dec 2021 02:27:46 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:reply-to:subject:to:cc:references:from
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-transfer-encoding:content-language;
        bh=WuGNH/dyVygpiGOJkCWGmo3DKhkMVbJWC9pFgiPTsyo=;
        b=HaaOjo8ZEBCEmI4mEKp8N9SIh0F2Z5955kWkUWwz/1rvbtsU2oktI2griXMv418Mj0
         LCkRZmmiR2LHp3dGVgmYMzuBg06QKLt6VXwT8k00RZIC/s50c8sypma30mSQZZzQZcoe
         DJC1xjFt9JRNbua25ULZxXAWtM65IfE0PPfuGTgCO3I71LnCmEgTy6wrkGCD7NdQSy94
         9VbY05O1cjaoSvyVPFDEzSrrkmNos1cN/nMMZeCNLmYGzR3WK+1HT289e+DOJjx9yD+Z
         TgEcQ03Hrh8T1hJwdyXRA0gdRr9fRP1GqIS2TSnYthToe4sN+UoC3iP2BaQgxseGuFp7
         gB5A==
X-Gm-Message-State: AOAM530ENbYivmgrGimWyj9H3lmSdSfb3x2tQt21AgldsXvqBMXtPfUe
        qlu+0mDstoeO/w5p2Sp7Fkhfe3Ej9VtImC5NhIgcGm12u63t9g395qiTKnc+nziVw6G7CwL1L76
        9nUFXjtmuKF/pJOFIr6cLTW1c
X-Received: by 2002:adf:d22a:: with SMTP id k10mr51871503wrh.80.1638872865020;
        Tue, 07 Dec 2021 02:27:45 -0800 (PST)
X-Google-Smtp-Source: ABdhPJw5SYKxnf/czGLnzekcByHTylqSUw2oDFUY77k108vZsKZFOCs+7tv9nPFdqCwIsIDIRwPszg==
X-Received: by 2002:adf:d22a:: with SMTP id k10mr51871467wrh.80.1638872864803;
        Tue, 07 Dec 2021 02:27:44 -0800 (PST)
Received: from ?IPv6:2a01:e0a:59e:9d80:527b:9dff:feef:3874? ([2a01:e0a:59e:9d80:527b:9dff:feef:3874])
        by smtp.gmail.com with ESMTPSA id d15sm18622235wri.50.2021.12.07.02.27.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 07 Dec 2021 02:27:43 -0800 (PST)
Reply-To: eric.auger@redhat.com
Subject: Re: [RFC v16 0/9] SMMUv3 Nested Stage Setup (IOMMU part)
To:     Zhangfei Gao <zhangfei.gao@linaro.org>, eric.auger.pro@gmail.com,
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
 <ee119b42-92b1-5744-4321-6356bafb498f@linaro.org>
From:   Eric Auger <eric.auger@redhat.com>
Message-ID: <7763531a-625d-10c6-c35e-2ce41e75f606@redhat.com>
Date:   Tue, 7 Dec 2021 11:27:41 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.1
MIME-Version: 1.0
In-Reply-To: <ee119b42-92b1-5744-4321-6356bafb498f@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Zhangfei,

On 12/3/21 1:27 PM, Zhangfei Gao wrote:
>
> Hi, Eric
>
> On 2021/10/27 下午6:44, Eric Auger wrote:
>> This series brings the IOMMU part of HW nested paging support
>> in the SMMUv3.
>>
>> The SMMUv3 driver is adapted to support 2 nested stages.
>>
>> The IOMMU API is extended to convey the guest stage 1
>> configuration and the hook is implemented in the SMMUv3 driver.
>>
>> This allows the guest to own the stage 1 tables and context
>> descriptors (so-called PASID table) while the host owns the
>> stage 2 tables and main configuration structures (STE).
>>
>> This work mainly is provided for test purpose as the upper
>> layer integration is under rework and bound to be based on
>> /dev/iommu instead of VFIO tunneling. In this version we also get
>> rid of the MSI BINDING ioctl, assuming the guest enforces
>> flat mapping of host IOVAs used to bind physical MSI doorbells.
>> In the current QEMU integration this is achieved by exposing
>> RMRs to the guest, using Shameer's series [1]. This approach
>> is RFC as the IORT spec is not really meant to do that
>> (single mapping flag limitation).
>>
>> Best Regards
>>
>> Eric
>>
>> This series (Host) can be found at:
>> https://github.com/eauger/linux/tree/v5.15-rc7-nested-v16
>> This includes a rebased VFIO integration (although not meant
>> to be upstreamed)
>>
>> Guest kernel branch can be found at:
>> https://github.com/eauger/linux/tree/shameer_rmrr_v7
>> featuring [1]
>>
>> QEMU integration (still based on VFIO and exposing RMRs)
>> can be found at:
>> https://github.com/eauger/qemu/tree/v6.1.0-rmr-v2-nested_smmuv3_v10
>> (use iommu=nested-smmuv3 ARM virt option)
>>
>> Guest dependency:
>> [1] [PATCH v7 0/9] ACPI/IORT: Support for IORT RMR node
>
> Thanks a lot for upgrading these patches.
>
> I have basically verified these patches on HiSilicon Kunpeng920.
> And integrated them to these branches.
> https://github.com/Linaro/linux-kernel-uadk/tree/uacce-devel-5.16
> https://github.com/Linaro/qemu/tree/v6.1.0-rmr-v2-nested_smmuv3_v10
>
> Though they are provided for test purpose,
>
> Tested-by: Zhangfei Gao <zhangfei.gao@linaro.org>

Thank you very much. As you mentioned, until we do not have the
/dev/iommu integration this is maintained for testing purpose. The SMMU
changes shouldn't be much impacted though.
The added value of this respin was to propose an MSI binding solution
based on RMRRs which simplify things at kernel level.

Thanks!

Eric
>
> Thanks
>

