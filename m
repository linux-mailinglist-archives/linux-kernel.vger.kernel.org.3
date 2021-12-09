Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BA2ED46F489
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Dec 2021 21:03:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231439AbhLIUGj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Dec 2021 15:06:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58580 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231337AbhLIUGh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Dec 2021 15:06:37 -0500
Received: from mail-lj1-x230.google.com (mail-lj1-x230.google.com [IPv6:2a00:1450:4864:20::230])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9194AC061746;
        Thu,  9 Dec 2021 12:03:03 -0800 (PST)
Received: by mail-lj1-x230.google.com with SMTP id m12so10688234ljj.6;
        Thu, 09 Dec 2021 12:03:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=ihEOhQoEWEgRs+9CLdXQa11iSfCT9fZ1UIZNVOm6lHI=;
        b=YsK6MGTpEJOO/0KbE/ZB9XYZdlgXIFyU6eamuFCje3seQSXH/gUooimKw+SVh4xCI5
         2WWVXZg4z+TSVPDTlyLuarP5R/L9hdhi2s2qmfGFsgfq54IDs6lHpjBQOfHFWNwijuPb
         4ASNoAMLYQ7cHPaTfvn7LnFRcHyqqpRn3jQu647IbWBS3TmajskyWWJ5eU+I6SviqDmA
         K6l23fdxLoXOnjsiwcVqnO03R3VjpkJGnhQWOT7WR3p2UJ3XPDd5c0fMC8EBlWAc8f2W
         WX6xC/wbo0TSZiyAIQKcPKdNVQogVemB3QAjnj5yYkcQscqRcSf80GBhphvM/xH5VZez
         Sp6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=ihEOhQoEWEgRs+9CLdXQa11iSfCT9fZ1UIZNVOm6lHI=;
        b=sAOQOT4b1C2/ChX+DSPmzodRZpCBR57Ep/zf8m8s8qaQnbLbXjvkEOmSjGixH7nUy7
         c8HIGuEGRtSu4gG5u1Z7ffd9uGyVmpv72Pw3sAimx+Vw+Sq0XgjKbsUYuqrFzlkWq7Fl
         BvL+3vAlxVL/pGE0WSz+vupqh+aJ6CmYhNI9/rjfM3fLHac6+Sz8cD4uQxFlbzPaigsa
         4p4qkR5VpGK2whW1KmNWzPtFrmKwJa5VYDSD1xUnk0+d5jbbqPXE2XlRMQxQ3vHVxPqo
         2v1fRk1X4URzftwu0fqYLHiweGpjCYIEJe3zhQFOsjHccYNsfKB3tgioBh3V2ohO3GpR
         5ZWg==
X-Gm-Message-State: AOAM532fo9AscDrLNnh7XoJkSObLSRG6ESnob7sni5JAL47c6febT8JG
        J+ho047RnmJ6xIs5//4+VJ34FJP3vkg=
X-Google-Smtp-Source: ABdhPJyIC6hdlhzGyYreJsxY/lkGafPwOf/c5Z7ZUSqaW/xN3uShMkXg9Ddp+HXFak2uB9cEZURuSg==
X-Received: by 2002:a05:651c:b23:: with SMTP id b35mr9021210ljr.286.1639080181485;
        Thu, 09 Dec 2021 12:03:01 -0800 (PST)
Received: from [192.168.2.145] (94-29-46-111.dynamic.spd-mgts.ru. [94.29.46.111])
        by smtp.googlemail.com with ESMTPSA id l14sm96276lfk.80.2021.12.09.12.03.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 09 Dec 2021 12:03:01 -0800 (PST)
Subject: Re: [PATCH v8 6/6] iommu/tegra-smmu: Add pagetable mappings to
 debugfs
To:     Nicolin Chen <nicolinc@nvidia.com>
Cc:     thierry.reding@gmail.com, joro@8bytes.org, will@kernel.org,
        vdumpa@nvidia.com, jonathanh@nvidia.com,
        linux-tegra@vger.kernel.org, iommu@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org
References: <20211209073822.26728-1-nicolinc@nvidia.com>
 <20211209073822.26728-7-nicolinc@nvidia.com>
 <63b4c2e2-0e55-5701-4c45-70684c7e058e@gmail.com>
 <20211209192450.GA34762@Asurada-Nvidia>
 <fab11209-a579-bbfb-a701-e613cecabd56@gmail.com>
 <20211209195450.GB35526@Asurada-Nvidia>
 <520bc232-7173-dc28-2d81-6b0f42773bc8@gmail.com>
 <20211209200141.GA35858@Asurada-Nvidia>
From:   Dmitry Osipenko <digetx@gmail.com>
Message-ID: <8baa58f4-fd3c-1273-d770-035a2fb76c96@gmail.com>
Date:   Thu, 9 Dec 2021 23:03:00 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <20211209200141.GA35858@Asurada-Nvidia>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

09.12.2021 23:01, Nicolin Chen пишет:
> On Thu, Dec 09, 2021 at 10:58:32PM +0300, Dmitry Osipenko wrote:
>> External email: Use caution opening links or attachments
>>
>>
>> 09.12.2021 22:54, Nicolin Chen пишет:
>>> On Thu, Dec 09, 2021 at 10:44:25PM +0300, Dmitry Osipenko wrote:
>>>> External email: Use caution opening links or attachments
>>>>
>>>>
>>>> 09.12.2021 22:24, Nicolin Chen пишет:
>>>>> On Thu, Dec 09, 2021 at 05:49:09PM +0300, Dmitry Osipenko wrote:
>>>>>> External email: Use caution opening links or attachments
>>>>>>
>>>>>>
>>>>>> 09.12.2021 10:38, Nicolin Chen пишет:
>>>>>>> +static unsigned long pd_pt_index_iova(unsigned int pd_index, unsigned int pt_index)
>>>>>>> +{
>>>>>>> +     return (pd_index & (SMMU_NUM_PDE - 1)) << SMMU_PDE_SHIFT |
>>>>>>> +            (pt_index & (SMMU_NUM_PTE - 1)) << SMMU_PTE_SHIFT;
>>>>>>> +}
>>>>>>
>>>>>> I'd change the return type to u32 here, for consistency.
>>>>>
>>>>> The whole file defines iova using "unsigned long", which I see
>>>>> as the consistency... If we change it to u32, it'd be probably
>>>>> necessary to change all iova types to u32 too... So I'd rather
>>>>> keep it "unsigned long" here. If you see a big necessity to do
>>>>> that, an additional patch would be nicer IMHO.
>>>>>
>>>>
>>>> In general IOVA is "unsigned long", of course. But in case of Tegra
>>>> SMMU, we know that is always u32.
>>>>
>>>> Alright, I see now that there are other places in the driver code that
>>>> use "unsigned long", so need to change it in this patch.
>>>
>>> I think we should do that in a separate patch that changes the iova
>>> type in the entire tegra-smmu file. I can add one in this series, if
>>> this makes you happy...
>>>
>>
>> Please keep it "unsigned long", no need for extra patches.
> 
> Oh, I guess that "so need to change it in this patch" should be
> "so (no) need to change it in this patch" then?
> 

Indeed, I missed that typo, sorry.
