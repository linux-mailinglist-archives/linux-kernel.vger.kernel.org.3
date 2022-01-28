Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 04DCE49F751
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jan 2022 11:32:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347873AbiA1KcC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Jan 2022 05:32:02 -0500
Received: from smtp-out1.suse.de ([195.135.220.28]:50232 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347786AbiA1Kb6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Jan 2022 05:31:58 -0500
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id E4AC8210FF;
        Fri, 28 Jan 2022 10:31:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1643365916; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Z/V9vEYKRBcrryQOAQOlk5QqnU5HZcwb55Ru/9AucMg=;
        b=QOxhwGnNnTs/Y91/gFvvQovMASxHKYBSWTK1b8byFS8j5s0vD/VWblJ4ARP0v+/kY1SeCz
        ap8kXq4m/f2GLk1BexWD8IUTpROSeSudV+dvkWkDfKORlBut7kw2W5fTjuuKgbfdg7pqEf
        VdczoaPBOpI+b/vA1oPJsMEcswuj7Eo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1643365916;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Z/V9vEYKRBcrryQOAQOlk5QqnU5HZcwb55Ru/9AucMg=;
        b=yrm8MaBvxfX2i7YM4Npq/I9jnqaRP2MNs1LlnmUgCJlW4eRCt0YIuEIYWGTfJcaQwS0+UP
        2oT9y1Djkjfn8uBQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 8CFF613D17;
        Fri, 28 Jan 2022 10:31:56 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id syEWIRzG82EXHQAAMHmgww
        (envelope-from <ptesarik@suse.cz>); Fri, 28 Jan 2022 10:31:56 +0000
Message-ID: <ba065272-78bd-65d0-1e76-08455519b6db@suse.cz>
Date:   Fri, 28 Jan 2022 11:31:49 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.4.1
From:   =?UTF-8?B?UGV0ciBUZXNhxZnDrWs=?= <ptesarik@suse.cz>
Content-Language: en-GB
To:     Tiezhu Yang <yangtiezhu@loongson.cn>, Baoquan He <bhe@redhat.com>,
        Vivek Goyal <vgoyal@redhat.com>,
        Dave Young <dyoung@redhat.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     Xuefeng Li <lixuefeng@loongson.cn>, kexec@lists.infradead.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
References: <1643275911-19489-1-git-send-email-yangtiezhu@loongson.cn>
 <d513dea3-7300-9684-73af-0b51f5f0e572@suse.cz>
 <f28c65f0-9bbb-6bf8-a223-0e18b861c805@loongson.cn>
Subject: Re: [RFC PATCH] kdump: Add support for crashkernel=auto
In-Reply-To: <f28c65f0-9bbb-6bf8-a223-0e18b861c805@loongson.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Tiezhu Yang,

On Jan 28, 2022 at 02:20 Tiezhu Yang wrote:
>[...]
> Hi Petr,
> 
> Thank you for your reply.
> 
> This is a RFC patch, the initial aim of this patch is to discuss what is 
> the proper way to support crashkernel=auto.

Well, the point I'm trying to make is that crashkernel=auto cannot be 
implemented. Your code would have to know what happens in the future, 
and AFAIK time travel has not been discovered yet. ;-)

A better approach is to make a very large allocation initially, e.g. 
half of available RAM. The remaining RAM should still be big enough to 
start booting the system. Later, when a kdump user-space service knows 
what it wants to load, it can shrink the reservation by writing a lower 
value into /sys/kernel/kexec_crash_size.

The alternative approach does not need any changes to the kernel, except 
maybe adding something like "crashkernel=max".

Just my two cents,
Petr T

> A moment ago, I find the following patch, it is more flexible, but it is 
> not merged into the upstream kernel now.
> 
> kernel/crash_core: Add crashkernel=auto for vmcore creation
> 
> https://lore.kernel.org/lkml/20210223174153.72802-1-saeed.mirzamohammadi@oracle.com/ 
> 
> 
>>
>>> [...]
>>> diff --git a/kernel/crash_core.c b/kernel/crash_core.c
>>> index 256cf6d..32c51e2 100644
>>> --- a/kernel/crash_core.c
>>> +++ b/kernel/crash_core.c
>>> @@ -252,6 +252,26 @@ static int __init __parse_crashkernel(char 
>>> *cmdline,
>>>       if (suffix)
>>>           return parse_crashkernel_suffix(ck_cmdline, crash_size,
>>>                   suffix);
>>> +
>>> +    if (strncmp(ck_cmdline, "auto", 4) == 0) {
>>> +#if defined(CONFIG_X86_64) || defined(CONFIG_S390)
>>> +        ck_cmdline = "1G-4G:160M,4G-64G:192M,64G-1T:256M,1T-:512M";
>>> +#elif defined(CONFIG_ARM64)
>>> +        ck_cmdline = "2G-:448M";
>>> +#elif defined(CONFIG_PPC64)
>>> +        char *fadump_cmdline;
>>> +
>>> +        fadump_cmdline = get_last_crashkernel(cmdline, "fadump=", 
>>> NULL);
>>> +        fadump_cmdline = fadump_cmdline ?
>>> +                fadump_cmdline + strlen("fadump=") : NULL;
>>> +        if (!fadump_cmdline || (strncmp(fadump_cmdline, "off", 3) == 
>>> 0))
>>> +            ck_cmdline =
>>> "2G-4G:384M,4G-16G:512M,16G-64G:1G,64G-128G:2G,128G-:4G";
>>> +        else
>>> +            ck_cmdline =
>>> "4G-16G:768M,16G-64G:1G,64G-128G:2G,128G-1T:4G,1T-2T:6G,2T-4T:12G,4T-8T:20G,8T-16T:36G,16T-32T:64G,32T-64T:128G,64T-:180G"; 
>>>
>>>
>>> +#endif
>>> +        pr_info("Using crashkernel=auto, the size chosen is a best
>>> effort estimation.\n");
>>> +    }
>>> +
>>
>> How did you even arrive at the above numbers?
> 
> Memory requirements for kdump:
> 
> https://access.redhat.com/documentation/en-us/red_hat_enterprise_linux/8/html/managing_monitoring_and_updating_the_kernel/supported-kdump-configurations-and-targets_managing-monitoring-and-updating-the-kernel#memory-requirements-for-kdump_supported-kdump-configurations-and-targets 
> 
> 
> I've done some research on
>> this topic recently (ie. during the last 7 years or so). My x86_64
>> system with 8G RAM running openSUSE Leap 15.3 seems needs 188M for
>> saving to the local disk, and 203M to save over the network (using
>> SFTP). My PPC64 LPAR with 16G RAM running latest Beta of SLES 15 SP4
>> needs 587M, i.e. with the above numbers it may run out of memory while
>> saving the dump.
>>
>> Since this is not the first time, I'm trying to explain things, I've
>> written a blog post now:
>>
>> https://sigillatum.tesarici.cz/2022-01-27-whats-wrong-with-crashkernel-auto.html 
>>
>>
> 
> Thank you, this is useful.
> 
> Thanks,
> Tiezhu
> 
>>
>> HTH
>> Petr Tesarik
> 
> 
> _______________________________________________
> kexec mailing list
> kexec@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/kexec
