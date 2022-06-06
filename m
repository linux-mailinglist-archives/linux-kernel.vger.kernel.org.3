Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F132D53E2D1
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Jun 2022 10:55:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230451AbiFFHZM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Jun 2022 03:25:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53374 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230445AbiFFHZJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Jun 2022 03:25:09 -0400
Received: from mail-pf1-x434.google.com (mail-pf1-x434.google.com [IPv6:2607:f8b0:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 021482C13B
        for <linux-kernel@vger.kernel.org>; Mon,  6 Jun 2022 00:25:08 -0700 (PDT)
Received: by mail-pf1-x434.google.com with SMTP id 15so12055170pfy.3
        for <linux-kernel@vger.kernel.org>; Mon, 06 Jun 2022 00:25:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=0AnhdS964ZAmAt3TlTWu07Znq5XtGyA8ySzA8lh+qAo=;
        b=z5AuHKqozZugOWvaT1dlWA/ZeoXf2Ucp69bIGQ7a3d4C/+nENFDDHQJsy6xbnzqj2y
         w8JTWFoxjrclRRmclnXcIphcwc/2G4borloKoYSXu7zgSZGbz555zM1JRq2ZCk34fsX2
         7RXJt5OFgkFLW0JPEmpz/+aKnw7lMLFgEPb/0+17RNfrGMrhrmdr3Kf4Tpz7mFPd2rW6
         7Fs12AlzEUQSpcTFBFS2IbSg8wzDprjMsZlrUqij9TfEIgUeK1QELPUVs1w8pImieHI8
         IKrYI0kG6I6n93rM3s92uWIFjuHl+pR4oddmCjWnYpUyOxK8hp+F4TE7Y+BC1tvEZglb
         Jrkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=0AnhdS964ZAmAt3TlTWu07Znq5XtGyA8ySzA8lh+qAo=;
        b=seTOL01tVd10gFNXRZc3szzsZ4+xKqlzoj/6cd/wYfyX6kzvT2PRKDLYEHf/FMXeeV
         iwx/+lyFUZwC32hdW11EpaB/kmjGtgCgzFs9RE0ymV251Abhcf+6METepjvi8FNnHCdV
         NwEoa22dwf5qhcDb1BB1+qA9es8kpHA5sE0dcb9VTovlJGCvmKkx8gGtY9Yp6N7y++73
         FlshjB4v2l6Revq9P8OLZyYmyWdsWP/Ns3nFnMxcVlXbCy55HKTe2En/mVUjG0rBDNeX
         04BRI3AYBiYQO7YZ/3+gTcxBg7aFMPWeB976x4/gls/2RuSw4z5c5PRPO1j6ulykg30v
         oxaA==
X-Gm-Message-State: AOAM533+M952u5fzCdpYfak4oa5444AgLxS12lZVNtz2TaD4m8kqj/WD
        FrIeRRoJmDr93U+ojrvVcw0TfA==
X-Google-Smtp-Source: ABdhPJyJbNz6BwWaufNGjpW5wGylhSJj8ejqCOVQkBGZrrv7fjiraQtaYx0X+kFfSZMM/s+yL+8bNQ==
X-Received: by 2002:a05:6a00:889:b0:510:91e6:6463 with SMTP id q9-20020a056a00088900b0051091e66463mr23124379pfj.58.1654500307440;
        Mon, 06 Jun 2022 00:25:07 -0700 (PDT)
Received: from [10.76.15.169] ([61.120.150.70])
        by smtp.gmail.com with ESMTPSA id v13-20020a17090331cd00b00163daef3dc2sm9739598ple.84.2022.06.06.00.25.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 06 Jun 2022 00:25:06 -0700 (PDT)
Message-ID: <3b58adbf-a8b2-8dba-71a7-123ba3850c10@bytedance.com>
Date:   Mon, 6 Jun 2022 15:20:27 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: Re: Re: [PATCH] mm/memory-failure: don't allow to unpoison hw
 corrupted page
Content-Language: en-US
To:     =?UTF-8?B?SE9SSUdVQ0hJIE5BT1lBKOWggOWPoyDnm7TkuZ8p?= 
        <naoya.horiguchi@nec.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Tony Luck <tony.luck@intel.com>,
        Wu Fengguang <fengguang.wu@intel.com>
References: <20220604103229.3378591-1-pizhenwei@bytedance.com>
 <20220604115616.b7d5912ac5a37db608f67b78@linux-foundation.org>
 <584eedd3-9369-9df1-39e2-62e331abdcc0@bytedance.com>
 <20220606043202.GA1328953@hori.linux.bs1.fc.nec.co.jp>
From:   zhenwei pi <pizhenwei@bytedance.com>
In-Reply-To: <20220606043202.GA1328953@hori.linux.bs1.fc.nec.co.jp>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 6/6/22 12:32, HORIGUCHI NAOYA(堀口 直也) wrote:
> On Sun, Jun 05, 2022 at 12:24:24PM +0800, zhenwei pi wrote:
>>
>>
>> On 6/5/22 02:56, Andrew Morton wrote:
>>> On Sat,  4 Jun 2022 18:32:29 +0800 zhenwei pi <pizhenwei@bytedance.com> wrote:
>>>
>>>> Currently unpoison_memory(unsigned long pfn) is designed for soft
>>>> poison(hwpoison-inject) only. Unpoisoning a hardware corrupted page
>>>> puts page back buddy only, this leads BUG during accessing on the
>>>> corrupted KPTE.
> 
> Thank you for the patch. I think this will be helpful for integration testing.
> 
> You mention "hardware corrupted page" as the condition of this bug, and I
> think that it means a real hardware error, but this BUG seems to be
> triggered when we use mce-inject or APEI (these are also software injection
> without corrupting the memory physically). So the actual condition is
> "when memory_failure() is called by MCE handler"?
> 

Yes, I use QEMU to emulate a 'real hardware error' by command:
virsh qemu-monitor-command vm --hmp mce 0 9 0xbd000000000000c0 0xd 
0x61234000 0x8c

>>>>
>>>> Do not allow to unpoison hardware corrupted page in unpoison_memory()
>>>> to avoid BUG like this:
>>>>
>>>>    Unpoison: Software-unpoisoned page 0x61234
>>>>    BUG: unable to handle page fault for address: ffff888061234000
>>>
>>> Thanks.
>>>
>>>> --- a/mm/memory-failure.c
>>>> +++ b/mm/memory-failure.c
>>>> @@ -2090,6 +2090,7 @@ int unpoison_memory(unsigned long pfn)
>>>>    {
>>>>    	struct page *page;
>>>>    	struct page *p;
>>>> +	pte_t *kpte;
>>>>    	int ret = -EBUSY;
>>>>    	int freeit = 0;
>>>>    	static DEFINE_RATELIMIT_STATE(unpoison_rs, DEFAULT_RATELIMIT_INTERVAL,
>>>> @@ -2101,6 +2102,13 @@ int unpoison_memory(unsigned long pfn)
>>>>    	p = pfn_to_page(pfn);
>>>>    	page = compound_head(p);
>>>> +	kpte = virt_to_kpte((unsigned long)page_to_virt(p));
>>>> +	if (kpte && !pte_present(*kpte)) {
>>>> +		unpoison_pr_info("Unpoison: Page was hardware poisoned %#lx\n",
>>>> +				 pfn, &unpoison_rs);
> 
> This can prevent unpoison for hwpoison on 4kB pages, but not for hugetlb pages,
> where I see the similar BUG as follows (even with applying your patch):
> 
>    [  917.806712] BUG: unable to handle page fault for address: ffff9f7bb3201000
>    [  917.810144] #PF: supervisor write access in kernel mode
>    [  917.812588] #PF: error_code(0x0002) - not-present page
>    [  917.815007] PGD 104801067 P4D 104801067 PUD 10006b063 PMD 1052d0063 PTE 800ffffeccdfe062
>    [  917.818768] Oops: 0002 [#1] PREEMPT SMP PTI
>    [  917.820759] CPU: 0 PID: 7774 Comm: test_alloc_gene Tainted: G   M       OE     5.18.0-v5.18-220606-0942-029-ge4dcc+ #47
>    [  917.825720] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.15.0-1.fc35 04/01/2014
>    [  917.829762] RIP: 0010:clear_page_erms+0x7/0x10
>    [  917.831867] Code: 48 89 47 18 48 89 47 20 48 89 47 28 48 89 47 30 48 89 47 38 48 8d 7f 40 75 d9 90 c3 0f 1f 80 00 00 00 00 b9 00 10 00 00 31 c0 <f3> aa c3 cc cc cc cc cc cc 48 85 ff 0f 84 d3 00 00 00 0f b6 0f 4c
>    [  917.840540] RSP: 0000:ffffab49c25ebdf0 EFLAGS: 00010246
>    [  917.842839] RAX: 0000000000000000 RBX: ffffd538c4cc8000 RCX: 0000000000001000
>    [  917.845835] RDX: 0000000080000000 RSI: 00007f2aeb600000 RDI: ffff9f7bb3201000
>    [  917.848687] RBP: 0000000000000000 R08: 0000000000000000 R09: 0000000000000000
>    [  917.851377] R10: 0000000000000002 R11: ffff9f7b87e3a2a0 R12: 0000000000000000
>    [  917.854035] R13: 0000000000000001 R14: ffffd538c4cc8000 R15: ffff9f7bc002a5d8
>    [  917.856539] FS:  00007f2aebad3740(0000) GS:ffff9f7bbbc00000(0000) knlGS:0000000000000000
>    [  917.859229] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
>    [  917.861149] CR2: ffff9f7bb3201000 CR3: 0000000107726003 CR4: 0000000000170ef0
>    [  917.863433] Call Trace:
>    [  917.864266]  <TASK>
>    [  917.864961]  clear_huge_page+0x147/0x270
>    [  917.866236]  hugetlb_fault+0x440/0xad0
>    [  917.867366]  handle_mm_fault+0x270/0x290
>    [  917.868532]  do_user_addr_fault+0x1c3/0x680
>    [  917.869768]  exc_page_fault+0x6c/0x160
>    [  917.870912]  ? asm_exc_page_fault+0x8/0x30
>    [  917.872082]  asm_exc_page_fault+0x1e/0x30
>    [  917.873220] RIP: 0033:0x7f2aeb8ba367
> 
> I don't think of a workaround for this now ...
> 

Could you please tell me how to reproduce this issue?

>>>> +		return -EPERM;
> 
> Is -EOPNOTSUPP a better error code?
> 

OK!

>>>> +	}
>>>> +
>>>>    	mutex_lock(&mf_mutex);
>>>>    	if (!PageHWPoison(p)) {
>>>
>>> I guess we don't want to let fault injection crash the kernel, so a
>>> cc:stable seems appropriate here.
>>>
>>> Can we think up a suitable Fixes: commit?  I'm suspecting this bug has
>>> been there for a long time?
>>>
>>
>> Sure!
>>
>> 2009-Dec-16, hwpoison_unpoison() was introduced into linux in commit:
>> 847ce401df392("HWPOISON: Add unpoisoning support")
>> ...
>> There is no hardware level unpoisioning, so this cannot be used for real
>> memory errors, only for software injected errors.
>> ...
>>
>> We can find that this function should be used for software level unpoisoning
>> only in both commit log and comment in source code. unfortunately there is
>> no check in function hwpoison_unpoison().
>>
>>
>> 2020-May-20, 17fae1294ad9d("x86/{mce,mm}: Unmap the entire page if the whole
>> page is affected and poisoned")
>>
>> This clears KPTE, and leads BUG(described in this patch) during unpoisoning
>> the hardware corrupted page.
>>
>>
>> Fixes: 847ce401df392("HWPOISON: Add unpoisoning support")
>> Fixes: 17fae1294ad9d("x86/{mce,mm}: Unmap the entire page if the whole page
>> is affected and poisoned")
>>
>> Cc: Wu Fengguang <fengguang.wu@intel.com>
>> Cc: Tony Luck <tony.luck@intel.com>.
> 
> Thanks for checking the history, I agree with sending to stable.
> 
> Thanks,
> Naoya Horiguchi

-- 
zhenwei pi
