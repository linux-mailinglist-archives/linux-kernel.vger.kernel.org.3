Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A53BE46CE65
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Dec 2021 08:33:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244539AbhLHHhM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Dec 2021 02:37:12 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124]:27875 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233900AbhLHHhL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Dec 2021 02:37:11 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1638948820;
        h=from:from:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=VaQgBFKDWPtyW4rX+GpfnPjaazD4SfZz/ToOHd0Wuzc=;
        b=iAmIaxB83Y/qYpZ2HPyygRGdhXh4AA5558MRqsGs+pYJJ+o+tQas8sTZ7ADGCg3w8jjVvC
        V7h3DJoQlq+upyaCzLdO7Pme0cSv3MSleHzkaJ8NbCnSdXGeDTbMNGKveFWI1Dj5MwgBZi
        L43EvKXt6AJqzA5FOkoEEYvK5xxqUwU=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-51-zmOi2HSZOjKXfS2MBylEmw-1; Wed, 08 Dec 2021 02:33:37 -0500
X-MC-Unique: zmOi2HSZOjKXfS2MBylEmw-1
Received: by mail-wr1-f69.google.com with SMTP id q15-20020adfbb8f000000b00191d3d89d09so167522wrg.3
        for <linux-kernel@vger.kernel.org>; Tue, 07 Dec 2021 23:33:37 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:reply-to:subject:to:cc:references:from
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-transfer-encoding:content-language;
        bh=VaQgBFKDWPtyW4rX+GpfnPjaazD4SfZz/ToOHd0Wuzc=;
        b=cNVXjOYtYGjRDwDyKlyqSG8bklkloRAGN4m1evhED5k2OYxD70xj0jurbaMXQifBFj
         V3VrnYaaCgqTDfrOehDpH4HNiHeuG+jNodkCsNt9wc4ZU1vwk3b4JP+ubB5AVTUbnFiV
         SNgRIne6Ti73QONaeEzEV1fcAVcbthGKWY4NYQQTI0ri6FTYdnclxDC1oW1sdsDuXooY
         as8WZO4Mwp8MOOpfX7evmt47YFtewgfoxdPIiaY3dIwRBbGh9jpswMZSkVxOeKCohqOH
         v3M/HfvaxLGLx325sTyxRmZ+a939KEhxrFGKQVSU2LXqVMfwWU1NvjYyjE0CbHcCCUNi
         IrhA==
X-Gm-Message-State: AOAM533plmXmWv55amclalqplYNS9iRjm5y6cnmVZB/4YdkLjaHrcBgC
        O9h6anW2fcdbGblIZVYaT5ua2sOJDovOu1Nc6aD0VQpavBLJf2nrpTwda1/L/woGWjgpKHpgzAT
        3E5UlpXyp3gAhSpph9ixcarFz
X-Received: by 2002:adf:f708:: with SMTP id r8mr57333466wrp.198.1638948816619;
        Tue, 07 Dec 2021 23:33:36 -0800 (PST)
X-Google-Smtp-Source: ABdhPJy7KoV5p8PVF3If5VE3e/tXMfPoPdiN58LX+mhb+Qk/apSQFS8E5N4maEwm2dxUTEGR+YL9hQ==
X-Received: by 2002:adf:f708:: with SMTP id r8mr57333432wrp.198.1638948816394;
        Tue, 07 Dec 2021 23:33:36 -0800 (PST)
Received: from ?IPv6:2a01:e0a:59e:9d80:527b:9dff:feef:3874? ([2a01:e0a:59e:9d80:527b:9dff:feef:3874])
        by smtp.gmail.com with ESMTPSA id l3sm2033529wmq.46.2021.12.07.23.33.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 07 Dec 2021 23:33:35 -0800 (PST)
Reply-To: eric.auger@redhat.com
Subject: Re: [RFC v16 1/9] iommu: Introduce attach/detach_pasid_table API
To:     Lu Baolu <baolu.lu@linux.intel.com>, Joerg Roedel <joro@8bytes.org>
Cc:     peter.maydell@linaro.org, kvm@vger.kernel.org,
        vivek.gautam@arm.com, kvmarm@lists.cs.columbia.edu,
        eric.auger.pro@gmail.com, jean-philippe@linaro.org,
        ashok.raj@intel.com, maz@kernel.org, vsethi@nvidia.com,
        zhangfei.gao@linaro.org, kevin.tian@intel.com, will@kernel.org,
        alex.williamson@redhat.com, wangxingang5@huawei.com,
        linux-kernel@vger.kernel.org, lushenming@huawei.com,
        iommu@lists.linux-foundation.org, robin.murphy@arm.com,
        Jason Gunthorpe <jgg@nvidia.com>
References: <20211027104428.1059740-1-eric.auger@redhat.com>
 <20211027104428.1059740-2-eric.auger@redhat.com>
 <Ya3qd6mT/DpceSm8@8bytes.org>
 <c7e26722-f78c-a93f-c425-63413aa33dde@redhat.com>
 <e6733c59-ffcb-74d4-af26-273c1ae8ce68@linux.intel.com>
From:   Eric Auger <eric.auger@redhat.com>
Message-ID: <fbeabcff-a6d4-dcc5-6687-7b32d6358fe3@redhat.com>
Date:   Wed, 8 Dec 2021 08:33:33 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.1
MIME-Version: 1.0
In-Reply-To: <e6733c59-ffcb-74d4-af26-273c1ae8ce68@linux.intel.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Baolu,

On 12/8/21 3:44 AM, Lu Baolu wrote:
> Hi Eric,
>
> On 12/7/21 6:22 PM, Eric Auger wrote:
>> On 12/6/21 11:48 AM, Joerg Roedel wrote:
>>> On Wed, Oct 27, 2021 at 12:44:20PM +0200, Eric Auger wrote:
>>>> Signed-off-by: Jean-Philippe Brucker<jean-philippe.brucker@arm.com>
>>>> Signed-off-by: Liu, Yi L<yi.l.liu@linux.intel.com>
>>>> Signed-off-by: Ashok Raj<ashok.raj@intel.com>
>>>> Signed-off-by: Jacob Pan<jacob.jun.pan@linux.intel.com>
>>>> Signed-off-by: Eric Auger<eric.auger@redhat.com>
>>> This Signed-of-by chain looks dubious, you are the author but the last
>>> one in the chain?
>> The 1st RFC in Aug 2018
>> (https://lists.cs.columbia.edu/pipermail/kvmarm/2018-August/032478.html)
>> said this was a generalization of Jacob's patch
>>
>>
>>    [PATCH v5 01/23] iommu: introduce bind_pasid_table API function
>>
>>
>>   
>> https://lists.linuxfoundation.org/pipermail/iommu/2018-May/027647.html
>>
>> So indeed Jacob should be the author. I guess the multiple rebases got
>> this eventually replaced at some point, which is not an excuse. Please
>> forgive me for that.
>> Now the original patch already had this list of SoB so I don't know if I
>> shall simplify it.
>
> As we have decided to move the nested mode (dual stages) implementation
> onto the developing iommufd framework, what's the value of adding this
> into iommu core?

The iommu_uapi_attach_pasid_table uapi should disappear indeed as it is
is bound to be replaced by /dev/iommu fellow API.
However until I can rebase on /dev/iommu code I am obliged to keep it to
maintain this integration, hence the RFC.

Thanks

Eric
>
> Best regards,
> baolu
>

