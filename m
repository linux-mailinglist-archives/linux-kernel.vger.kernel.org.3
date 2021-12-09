Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B929A46F472
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Dec 2021 20:58:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231339AbhLIUBx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Dec 2021 15:01:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57458 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231337AbhLIUBw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Dec 2021 15:01:52 -0500
Received: from mail-lj1-x22c.google.com (mail-lj1-x22c.google.com [IPv6:2a00:1450:4864:20::22c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3DB87C061746;
        Thu,  9 Dec 2021 11:58:18 -0800 (PST)
Received: by mail-lj1-x22c.google.com with SMTP id l7so10697654lja.2;
        Thu, 09 Dec 2021 11:58:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=IEeVho3+ZGBFM/fmNQDb763cjTKB84TOM9P4baD+LcY=;
        b=ZSnnmgt9r1Dv1p+tRXvYN9WzST5JpCAxCxgSuL7TlN6cW9Q/JXeGduQ2X34ucOUGi+
         +9yFJpHOUcNbHiyi2+fJf9sH51D0j/+5f5Nd1HW51hOkKsuE9h7+xSZJP9TJ66fLlbsG
         PWTk0oUXPgVvR0hvUTshpioOFkDgQI5uEgPyjxAJl2QS0DfVBGDCzZzThpLF8xOh4Dit
         sMY3abt0z1bjsyrC1aBSpUdfboeRsnhEluMJXv3qqNywhSR8c37fZIQTc8lvx8GY1EXX
         hr91mDCOUjAZEOgIo2izaMZwK1hxRD0Pbcy0jIcrpAGhEQ5I7cKFVKR2aJyK+btWO0Bk
         WGhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=IEeVho3+ZGBFM/fmNQDb763cjTKB84TOM9P4baD+LcY=;
        b=RmJsz8+kdJhtvgHYbH70h25HwHfyrLhJj8Qjnbsc1c3SNWMMXirfoyss6D9ThhxNf4
         HodlZyae22GpOt8odgflcKtpWnbwtODZ/yINi8JhGeyqPgV0MIkwqG+W1BzmsO4xzaav
         xf+3Py4OGxVKjWj+lReMdSDMo/hdl6HGKFqxUs2CbLCTRTOS/BTDKF9pvH+8jLKCBny7
         nJPtfI16piGmmNBRfqDeNlSdlro8vF8Q39DELEkMGr1/LzBmyN0FGUOcaTz7IGke1/Jl
         tYKWQEa0N599yr+2/xM18l80oej00Xfn/wvoU0uHiRLYP9JfNCmodzkKLdU0N7orb1HV
         ggiw==
X-Gm-Message-State: AOAM531Qe1Ow9J/f5A2x7XGBlUYWnT7+ZVru6IHg2SKZb97pCNb8BL6o
        ZGKWRsEDNxF7Ial7rGDGb6poHiQ0lw0=
X-Google-Smtp-Source: ABdhPJwpdCSPAcMKjslAF7mr6CyWEIaJXYq48zjgf+9WJ8qhS9zhxOTI3ZWKOjnu7CsVOj9lfY5nfg==
X-Received: by 2002:a2e:a378:: with SMTP id i24mr8805987ljn.290.1639079895951;
        Thu, 09 Dec 2021 11:58:15 -0800 (PST)
Received: from [192.168.2.145] (94-29-46-111.dynamic.spd-mgts.ru. [94.29.46.111])
        by smtp.googlemail.com with ESMTPSA id w15sm84215lfe.184.2021.12.09.11.58.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 09 Dec 2021 11:58:15 -0800 (PST)
Subject: Re: [PATCH v8 6/6] iommu/tegra-smmu: Add pagetable mappings to
 debugfs
To:     Nicolin Chen <nicolinc@nvidia.com>
Cc:     thierry.reding@gmail.com, joro@8bytes.org, will@kernel.org,
        vdumpa@nvidia.com, jonathanh@nvidia.com,
        linux-tegra@vger.kernel.org, iommu@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org
References: <20211209073822.26728-1-nicolinc@nvidia.com>
 <20211209073822.26728-7-nicolinc@nvidia.com>
 <5713902d-823b-63ca-00c9-aa6c64c1af41@gmail.com>
 <20211209193253.GB34762@Asurada-Nvidia>
 <97a32c9a-2ec7-6579-7d8d-026d6f820a3e@gmail.com>
 <20211209195128.GA35526@Asurada-Nvidia>
From:   Dmitry Osipenko <digetx@gmail.com>
Message-ID: <a4002ad9-70d9-22d1-7bcc-ae4f712187c8@gmail.com>
Date:   Thu, 9 Dec 2021 22:58:15 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <20211209195128.GA35526@Asurada-Nvidia>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

09.12.2021 22:51, Nicolin Chen пишет:
> On Thu, Dec 09, 2021 at 10:40:42PM +0300, Dmitry Osipenko wrote:
>> External email: Use caution opening links or attachments
>>
>>
>> 09.12.2021 22:32, Nicolin Chen пишет:
>>> On Thu, Dec 09, 2021 at 05:47:18PM +0300, Dmitry Osipenko wrote:
>>>> External email: Use caution opening links or attachments
>>>>
>>>>
>>>> 09.12.2021 10:38, Nicolin Chen пишет:
>>>>> @@ -545,6 +719,15 @@ static void tegra_smmu_detach_as(struct tegra_smmu *smmu,
>>>>>               if (group->swgrp != swgrp)
>>>>>                       continue;
>>>>>               group->as = NULL;
>>>>> +
>>>>> +             if (smmu->debugfs_mappings) {
>>>> Do we really need this check?
>>>>
>>>> Looks like all debugfs_create_dir() usages in this driver are incorrect,
>>>> that function never returns NULL. Please fix this.
>>> debugfs_create_dir returns ERR_PTR on failure. So here should be
>>> to check !IS_ERR. Thanks for pointing it out!
>>>
>>
>> All debugfs functions handle IS_ERR(). GregKH removes all such checks
>> all over the kernel. So the check shouldn't be needed at all, please
>> remove it if it's unneeded or prove that it's needed.
> 
> debugfs_create_file can handle a NULL parent, but not ERR_PTR one,
> and then it puts the new node under the root. So either passing an
> ERR_PTR parent or creating orphan nodes here doesn't sound good...
> 

What makes you say so? Please show the exact source code that will cause
the problem.

The smmu->debugfs_mappings can't ever be NULL and debugfs_create_file
handles the ERR_PTR [1][2].

[1] https://elixir.bootlin.com/linux/latest/source/fs/debugfs/inode.c#L397

[2] https://elixir.bootlin.com/linux/latest/source/fs/debugfs/inode.c#L330
