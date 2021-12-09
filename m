Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B0B1746F432
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Dec 2021 20:44:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230225AbhLITsC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Dec 2021 14:48:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54268 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229461AbhLITsC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Dec 2021 14:48:02 -0500
Received: from mail-lf1-x131.google.com (mail-lf1-x131.google.com [IPv6:2a00:1450:4864:20::131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1194AC061746;
        Thu,  9 Dec 2021 11:44:28 -0800 (PST)
Received: by mail-lf1-x131.google.com with SMTP id z7so13996847lfi.11;
        Thu, 09 Dec 2021 11:44:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=W3M3FLz1taxe7b+77mKr7ESR2sB6VgJaCSXT4PXYVl4=;
        b=eGY5CV7vI95Jbczr3qe0LqFbn9/PcXqSI7y6DZgHP6wPgwipojVAfRBYzqigkthVZn
         UazITCDN++Y8asH79fyndNPjkk/6rBqV0rySptjAHGRUfCNqs1V4y0nQZgQk26xo86q6
         y7FyGluxEZn5US6qjR8aA22SF2oJ2YTaz0qXNyZupPrUefcplDPGrPNJqbCuDbfJV+O0
         6LDqlL3/v5Xbwnh0HzoSzhImVspE/D1jSZ2zC1KXgeTBj8SgfNojnHx9p6i3D11Dm/j7
         u4S/zhpVPbcd3ApJS+gOLyf/xU50tLIfNYOPrwGR+u4kKdcdu+w5KHx2TXoIj4tB4xbw
         wepg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=W3M3FLz1taxe7b+77mKr7ESR2sB6VgJaCSXT4PXYVl4=;
        b=RxJy7E/dUIJ+0H9sbZfFhcCYdCVSsZ756XMPykhwaHuSVM3M9bxyqNu55McZHGsKbm
         q4mHhVQAThoyppyIlNbBWDiZXCaDXT10AU4M78bH63iKNvyV/2y3RzdHCElk2NGk8wzm
         8R4uegUvRquRC7h9IEsKgXW1xG80m9slrquns+SlDtBSX/D2UNgW/mwnzK18n1QXgtNe
         UECn2KczLdx2czz5Eq/D46dQqvBb6t7QYJO3NwBPy+REPtx2rE7SQSEzm+DR0DVg8HL5
         Idxrf+Gd70d0aM/4oAUuNVjUyIfhhYzjFG7u16Ir/9FqpTJpLZdd7mDDkpSiwXT0QLaT
         fcYQ==
X-Gm-Message-State: AOAM531CASMHbonwT0O9SQUnXFsBubbmSBiih2q9gEAXZe/sSsEJuvGh
        P6/C5SFjvwtBJ7U2CWkhL8Qu+LUFyH8=
X-Google-Smtp-Source: ABdhPJzmRqO8K8YP9qOB01q2ejoBUkmaK+Jj+SXh/lFFavAM6lm2pmNJsA/4TI8gdc+EQ2+mgufg2Q==
X-Received: by 2002:ac2:5fca:: with SMTP id q10mr8032056lfg.281.1639079066185;
        Thu, 09 Dec 2021 11:44:26 -0800 (PST)
Received: from [192.168.2.145] (94-29-46-111.dynamic.spd-mgts.ru. [94.29.46.111])
        by smtp.googlemail.com with ESMTPSA id s25sm74065ljd.39.2021.12.09.11.44.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 09 Dec 2021 11:44:25 -0800 (PST)
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
From:   Dmitry Osipenko <digetx@gmail.com>
Message-ID: <fab11209-a579-bbfb-a701-e613cecabd56@gmail.com>
Date:   Thu, 9 Dec 2021 22:44:25 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <20211209192450.GA34762@Asurada-Nvidia>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

09.12.2021 22:24, Nicolin Chen пишет:
> On Thu, Dec 09, 2021 at 05:49:09PM +0300, Dmitry Osipenko wrote:
>> External email: Use caution opening links or attachments
>>
>>
>> 09.12.2021 10:38, Nicolin Chen пишет:
>>> +static unsigned long pd_pt_index_iova(unsigned int pd_index, unsigned int pt_index)
>>> +{
>>> +     return (pd_index & (SMMU_NUM_PDE - 1)) << SMMU_PDE_SHIFT |
>>> +            (pt_index & (SMMU_NUM_PTE - 1)) << SMMU_PTE_SHIFT;
>>> +}
>>
>> I'd change the return type to u32 here, for consistency.
> 
> The whole file defines iova using "unsigned long", which I see
> as the consistency... If we change it to u32, it'd be probably
> necessary to change all iova types to u32 too... So I'd rather
> keep it "unsigned long" here. If you see a big necessity to do
> that, an additional patch would be nicer IMHO.
> 

In general IOVA is "unsigned long", of course. But in case of Tegra
SMMU, we know that is always u32.

Alright, I see now that there are other places in the driver code that
use "unsigned long", so need to change it in this patch.
