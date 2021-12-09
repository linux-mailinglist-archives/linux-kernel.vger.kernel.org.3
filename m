Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0548F46ED42
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Dec 2021 17:38:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241215AbhLIQlj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Dec 2021 11:41:39 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:23604 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S241053AbhLIQli (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Dec 2021 11:41:38 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1639067884;
        h=from:from:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=jNxrSJ7hA39700PK5sP9nWrntBLNr8e9xNebTOGiU18=;
        b=aMB9he4adxWVAHPddpbC7tYDw+MnVsvOtIe57Owss6iC7nFbaZgjeygzO/RHU4GZ+lQOzB
        TSXx/shiNYMaC6QlwYpEdaF0DzvEPFleXPqpYnUQXBD7kX7u7HS+qhTDACoGneBGC9ZwyY
        Ujv4qwrWrCLP/rmvLvpwrzG6jlA0+/U=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-544-hAg5uwjJNKqO8QMSQqB52Q-1; Thu, 09 Dec 2021 11:38:02 -0500
X-MC-Unique: hAg5uwjJNKqO8QMSQqB52Q-1
Received: by mail-wr1-f72.google.com with SMTP id q7-20020adff507000000b0017d160d35a8so1595841wro.4
        for <linux-kernel@vger.kernel.org>; Thu, 09 Dec 2021 08:38:02 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:reply-to:subject:to:cc:references:from
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-transfer-encoding:content-language;
        bh=jNxrSJ7hA39700PK5sP9nWrntBLNr8e9xNebTOGiU18=;
        b=Oj7vIAX26fdNKHIKjQ820FFaRTItLpsYf6CJSElivLGwew9AkjoVj8JThevwjw6kuc
         h0w3uEA/ju++7GgJP6RVmTQRO9ay4/brSVRTM5kBA/Pz5twenaNfQz41duQBSwCmcrHT
         EcqWf1AcOC0oBnAuSyKnLvfeHEzorTVwhnU/9PER/T1qieZnWmG/pm0hOlZK1BR2rsmx
         uGXEjZiDyF64RNfJ20DNwDQa9XT3GEocUpZzzDYY7Ey5G3W92ME02jqeDhtN2T4S5r5s
         0FHZrGzu/QJW+giGsJyrL7m1lCD7cDqqjRU0D5wqvSEFajyGRnnP9qTC1nd/fZ5l7NpJ
         3iyw==
X-Gm-Message-State: AOAM530NdWH/Zc48FnagbeWERnNaJBcoM7o++txObfxzDAZBoqx1/Ic0
        zdELTqgaA/UOerxkXNVWrXYDMC/mYMl4WIk4xI/IlEQxcQYJ0R2TDxB+3VQlCITipc8xHBoEcpV
        gfR5n4FjG/3k15ByjZgd2mZyT
X-Received: by 2002:a5d:58ed:: with SMTP id f13mr7636097wrd.373.1639067881495;
        Thu, 09 Dec 2021 08:38:01 -0800 (PST)
X-Google-Smtp-Source: ABdhPJzaV0R+9HzYiSu0FZYalbofmj5ndV0Ij51Jvm3EMXiekkqz6rpjx+QrGmfxHOtUjUM3LxbGgQ==
X-Received: by 2002:a5d:58ed:: with SMTP id f13mr7636061wrd.373.1639067881306;
        Thu, 09 Dec 2021 08:38:01 -0800 (PST)
Received: from ?IPv6:2a01:e0a:59e:9d80:527b:9dff:feef:3874? ([2a01:e0a:59e:9d80:527b:9dff:feef:3874])
        by smtp.gmail.com with ESMTPSA id d7sm163025wrw.87.2021.12.09.08.37.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 09 Dec 2021 08:38:00 -0800 (PST)
Reply-To: eric.auger@redhat.com
Subject: Re: [RFC v16 1/9] iommu: Introduce attach/detach_pasid_table API
To:     Jason Gunthorpe <jgg@nvidia.com>
Cc:     Jean-Philippe Brucker <jean-philippe@linaro.org>,
        Lu Baolu <baolu.lu@linux.intel.com>,
        Joerg Roedel <joro@8bytes.org>, peter.maydell@linaro.org,
        kvm@vger.kernel.org, vivek.gautam@arm.com,
        kvmarm@lists.cs.columbia.edu, eric.auger.pro@gmail.com,
        ashok.raj@intel.com, maz@kernel.org, vsethi@nvidia.com,
        zhangfei.gao@linaro.org, kevin.tian@intel.com, will@kernel.org,
        alex.williamson@redhat.com, wangxingang5@huawei.com,
        linux-kernel@vger.kernel.org, lushenming@huawei.com,
        iommu@lists.linux-foundation.org, robin.murphy@arm.com
References: <20211027104428.1059740-1-eric.auger@redhat.com>
 <20211027104428.1059740-2-eric.auger@redhat.com>
 <Ya3qd6mT/DpceSm8@8bytes.org>
 <c7e26722-f78c-a93f-c425-63413aa33dde@redhat.com>
 <e6733c59-ffcb-74d4-af26-273c1ae8ce68@linux.intel.com>
 <fbeabcff-a6d4-dcc5-6687-7b32d6358fe3@redhat.com>
 <20211208125616.GN6385@nvidia.com> <YbDpZ0pf7XeZcc7z@myrica>
 <20211208183102.GD6385@nvidia.com>
 <b576084b-482f-bcb7-35a6-d786dbb305e1@redhat.com>
 <20211209154046.GQ6385@nvidia.com>
From:   Eric Auger <eric.auger@redhat.com>
Message-ID: <f6e93350-e0ee-649a-bf97-314398481fc8@redhat.com>
Date:   Thu, 9 Dec 2021 17:37:58 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.1
MIME-Version: 1.0
In-Reply-To: <20211209154046.GQ6385@nvidia.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jason,

On 12/9/21 4:40 PM, Jason Gunthorpe wrote:
> On Thu, Dec 09, 2021 at 08:50:04AM +0100, Eric Auger wrote:
>
>>> The kernel API should accept the S1ContextPtr IPA and all the parts of
>>> the STE that relate to the defining the layout of what the S1Context
>>> points to an thats it.
>> Yes that's exactly what is done currently. At config time the host must
>> trap guest STE changes (format and S1ContextPtr) and "incorporate" those
>> changes into the stage2 related STE information. The STE is owned by the
>> host kernel as it contains the stage2 information (S2TTB).
> [..]
>
>> Note this series only coped with a single CD in the Context Descriptor
>> Table.
> I'm confused, where does this limit arise?
>
> The kernel accepts as input all the bits in the STE that describe the
> layout of the CDT owned by userspace, shouldn't userspace be able to
> construct all forms of CDT with any number of CDs in them?
>
> Or do you mean this is some qemu limitation?
The upstream vSMMUv3 emulation does not support multiple CDs at the
moment and since I have no proper means to validate the vSVA case I am
rejecting any attempt from user space to inject guest configs featuring
mutliple PASIDs. Also PASID cache invalidation must be added to this series.

Nevertheless those limitations were tackled and overcomed by others in
CC so I don't think there is any blocking issue.

Thanks

Eric
>
> Jason
>

