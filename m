Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 29EF246F429
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Dec 2021 20:40:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230094AbhLIToU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Dec 2021 14:44:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53426 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229461AbhLIToT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Dec 2021 14:44:19 -0500
Received: from mail-lf1-x136.google.com (mail-lf1-x136.google.com [IPv6:2a00:1450:4864:20::136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B6ACEC061746;
        Thu,  9 Dec 2021 11:40:45 -0800 (PST)
Received: by mail-lf1-x136.google.com with SMTP id bi37so14049538lfb.5;
        Thu, 09 Dec 2021 11:40:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=7e4wPhBpHhYcL4TNHjTq6GfxBUZhweLfxcnZCfxNmD0=;
        b=kx0CzCpM7B18oC7QqVp3vpnqp9czqNUFHoA2bD/13SOmPSLpXfnGusM07Ge5JLunbJ
         9QkHy3yixBqpBDwSBgS7OU9mfK0byvztX0LPJ7k5RUcD0t9pObVR9K6hakgZqmRLoFMg
         3ZsSxuPOZUyJDMKa+aaKpskTHBH0Hq9xeLVXlzmdgbrwRqz4HraO/uiKg1twyPxvwEag
         lNW9Plx1vS7dvlYw4F+GCUlX2XpMqQghtbQtwF5XhicqFh4bWeJj180Z5oYOfhc+rwAR
         5vAz780e1rZWX9o0PLV5Qz3lnR3SfNfn93g6KevrV4jDAk0buKHm10H8qaKP7g/I8ImJ
         IQlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=7e4wPhBpHhYcL4TNHjTq6GfxBUZhweLfxcnZCfxNmD0=;
        b=gPxtaAGuydJ9qOiK5U0A0wykZ8vtukyPIJbHEj/V1cDd7YnqjuXxbKExVN3C0tSlEQ
         yUdOv+pIT9EPfyJw8/ZFDd5eJH4zTzl/MelzMb/PDXrrY36kvoeDqmpzAsXHrGmrjF8k
         77vVWJ0U8lfNyOgveEkeQSZeRPT0ThpAYpBS1EqPYAiAWlx4t97qcUsEmUqNAM5c/iIK
         3ozGRd/4QZdOws0pKVIfXdZnFdL6kYGauciH3Ht7zEcewQd3W8iqa8zqyIlTmd9T8Htw
         IOkbWOAYZXhGlNsgxeGGAIOjOZUlOOxSlGhswjhSwCSyfHCR6xDfIA/0oKLWs1A4j6Ls
         +bJw==
X-Gm-Message-State: AOAM5320M12yrHusEadCARX7xkvSeVAbH/8QBV1D8A7k5Or/z22gcpsF
        I8+IvpL0aqeOCXi/xVt7tjaEOI0BZ3s=
X-Google-Smtp-Source: ABdhPJya6K3A+oUSCP6WXn/UJfIBjZHyRWdgszR22IMDqvOAXepYBTyL4q4uAlCO5kEr8GD3/wMW8A==
X-Received: by 2002:a05:6512:2082:: with SMTP id t2mr8285209lfr.186.1639078843695;
        Thu, 09 Dec 2021 11:40:43 -0800 (PST)
Received: from [192.168.2.145] (94-29-46-111.dynamic.spd-mgts.ru. [94.29.46.111])
        by smtp.googlemail.com with ESMTPSA id x5sm69577ljm.101.2021.12.09.11.40.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 09 Dec 2021 11:40:43 -0800 (PST)
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
From:   Dmitry Osipenko <digetx@gmail.com>
Message-ID: <97a32c9a-2ec7-6579-7d8d-026d6f820a3e@gmail.com>
Date:   Thu, 9 Dec 2021 22:40:42 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <20211209193253.GB34762@Asurada-Nvidia>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

09.12.2021 22:32, Nicolin Chen пишет:
> On Thu, Dec 09, 2021 at 05:47:18PM +0300, Dmitry Osipenko wrote:
>> External email: Use caution opening links or attachments
>>
>>
>> 09.12.2021 10:38, Nicolin Chen пишет:
>>> @@ -545,6 +719,15 @@ static void tegra_smmu_detach_as(struct tegra_smmu *smmu,
>>>               if (group->swgrp != swgrp)
>>>                       continue;
>>>               group->as = NULL;
>>> +
>>> +             if (smmu->debugfs_mappings) {
>> Do we really need this check?
>>
>> Looks like all debugfs_create_dir() usages in this driver are incorrect,
>> that function never returns NULL. Please fix this.
> debugfs_create_dir returns ERR_PTR on failure. So here should be
> to check !IS_ERR. Thanks for pointing it out!
> 

All debugfs functions handle IS_ERR(). GregKH removes all such checks
all over the kernel. So the check shouldn't be needed at all, please
remove it if it's unneeded or prove that it's needed.
