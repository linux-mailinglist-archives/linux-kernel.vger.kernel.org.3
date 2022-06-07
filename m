Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 24DE253FEE8
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Jun 2022 14:36:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243845AbiFGMgN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Jun 2022 08:36:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54326 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243825AbiFGMgH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Jun 2022 08:36:07 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id D8F5AC5D98
        for <linux-kernel@vger.kernel.org>; Tue,  7 Jun 2022 05:36:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1654605364;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=SG5jebj8zcHrBhx/2kXIScTU7FM9X7+rD0sLol08C7M=;
        b=YMpSztEty69ZuvJnOvpTjOXxwsqVEExQDx8KBJSbJchTpp4AO7Qq3vSaMOT4DQNcsXypiN
        e7EyzmsqckMBXflgi+sP/y9aqb2CK5H02qP0lbjgbFwV8KkOsWy3g0HBvMrrlS3Bo/i95j
        PGRfO2hC/lb2/RWHYn3iIH2YuyZ1/1k=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-616-jzWd_BNgP5i0chkog6gSeQ-1; Tue, 07 Jun 2022 08:36:03 -0400
X-MC-Unique: jzWd_BNgP5i0chkog6gSeQ-1
Received: by mail-wm1-f72.google.com with SMTP id c187-20020a1c35c4000000b003970013833aso5743786wma.1
        for <linux-kernel@vger.kernel.org>; Tue, 07 Jun 2022 05:36:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:organization:in-reply-to
         :content-transfer-encoding;
        bh=SG5jebj8zcHrBhx/2kXIScTU7FM9X7+rD0sLol08C7M=;
        b=6Q9xEbxlt2VEHNpyIfxBImGQhyUMAzKfJ6bGTuitUyDf52KzBosUEGRpW3bTYW3oh9
         aMPo5ZobHYfazwj4ChGcMEwtfR3fFfznd2mY4zzjMRta8r6cR1e0IGDOkRZ01HOvhSzi
         Yt/MlZfMY9BvDF+Ey9dcnUwVNWTr2zMV1KumJUIRz6r+PUTKa4aOxN5j8eFSc0P1d53c
         fda+wFy9APmZ2UnVOnPmQFsr7c5TwSooEGY4Xnj4VH1ObKhNc7K6aco/xdptdgDHGt/a
         akCW41yILMotrg1wOYGajon7Dfds/XNFXJTeKZuo1HX0r2rZ26XWrVPi4NUnUPtwQPt+
         lP6w==
X-Gm-Message-State: AOAM530aNDJ3zfCF3jWhjj1U0aoPIFO0oWWMU3OXI98GXyfCsh1ufNSc
        ++b3o5+TT6bloTm9vlVr4Praa6lbwJlEVyaSPezr4A8NRcy4FUzDWem7cvs1N73QliTbiaH2xTN
        oZREWRHpglaKNNOMIoPdn8NXB
X-Received: by 2002:a5d:668e:0:b0:213:bb30:b909 with SMTP id l14-20020a5d668e000000b00213bb30b909mr22338680wru.700.1654605362229;
        Tue, 07 Jun 2022 05:36:02 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyyF+NGDsgIqVCaMNWJyrSZZpEY1swzgN6G4wcAXa3sEkG/qt4gi6Y9GF/dMZGvdWoF4Ih6jQ==
X-Received: by 2002:a5d:668e:0:b0:213:bb30:b909 with SMTP id l14-20020a5d668e000000b00213bb30b909mr22338653wru.700.1654605361932;
        Tue, 07 Jun 2022 05:36:01 -0700 (PDT)
Received: from ?IPV6:2003:cb:c709:500:4c8d:4886:f874:7b6f? (p200300cbc70905004c8d4886f8747b6f.dip0.t-ipconnect.de. [2003:cb:c709:500:4c8d:4886:f874:7b6f])
        by smtp.gmail.com with ESMTPSA id h13-20020a05600c2cad00b00397623ff335sm22315616wmc.10.2022.06.07.05.36.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 07 Jun 2022 05:36:01 -0700 (PDT)
Message-ID: <5e7abb3f-56e7-0343-a678-749b6f5238a2@redhat.com>
Date:   Tue, 7 Jun 2022 14:36:00 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.0
Subject: Re: [PATCH] mm/memory-failure: don't allow to unpoison hw corrupted
 page
Content-Language: en-US
To:     =?UTF-8?B?SE9SSUdVQ0hJIE5BT1lBKOWggOWPoyDnm7TkuZ8p?= 
        <naoya.horiguchi@nec.com>, zhenwei pi <pizhenwei@bytedance.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Tony Luck <tony.luck@intel.com>,
        Wu Fengguang <fengguang.wu@intel.com>
References: <20220604103229.3378591-1-pizhenwei@bytedance.com>
 <20220604115616.b7d5912ac5a37db608f67b78@linux-foundation.org>
 <584eedd3-9369-9df1-39e2-62e331abdcc0@bytedance.com>
 <20220606043202.GA1328953@hori.linux.bs1.fc.nec.co.jp>
 <3b58adbf-a8b2-8dba-71a7-123ba3850c10@bytedance.com>
 <20220606091503.GA1337789@hori.linux.bs1.fc.nec.co.jp>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
In-Reply-To: <20220606091503.GA1337789@hori.linux.bs1.fc.nec.co.jp>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 06.06.22 11:15, HORIGUCHI NAOYA(堀口 直也) wrote:
> On Mon, Jun 06, 2022 at 03:20:27PM +0800, zhenwei pi wrote:
>>
>>
>> On 6/6/22 12:32, HORIGUCHI NAOYA(堀口 直也) wrote:
>>> On Sun, Jun 05, 2022 at 12:24:24PM +0800, zhenwei pi wrote:
>>>>
>>>>
>>>> On 6/5/22 02:56, Andrew Morton wrote:
>>>>> On Sat,  4 Jun 2022 18:32:29 +0800 zhenwei pi <pizhenwei@bytedance.com> wrote:
>>>>>
>>>>>> Currently unpoison_memory(unsigned long pfn) is designed for soft
>>>>>> poison(hwpoison-inject) only. Unpoisoning a hardware corrupted page
>>>>>> puts page back buddy only, this leads BUG during accessing on the
>>>>>> corrupted KPTE.
>>>
>>> Thank you for the patch. I think this will be helpful for integration testing.
>>>
>>> You mention "hardware corrupted page" as the condition of this bug, and I
>>> think that it means a real hardware error, but this BUG seems to be
>>> triggered when we use mce-inject or APEI (these are also software injection
>>> without corrupting the memory physically). So the actual condition is
>>> "when memory_failure() is called by MCE handler"?
>>>
>>
>> Yes, I use QEMU to emulate a 'real hardware error' by command:
>> virsh qemu-monitor-command vm --hmp mce 0 9 0xbd000000000000c0 0xd
>> 0x61234000 0x8c
>>
>>>>>>
>>>>>> Do not allow to unpoison hardware corrupted page in unpoison_memory()
>>>>>> to avoid BUG like this:
>>>>>>
>>>>>>    Unpoison: Software-unpoisoned page 0x61234
>>>>>>    BUG: unable to handle page fault for address: ffff888061234000
>>>>>
>>>>> Thanks.
>>>>>
>>>>>> --- a/mm/memory-failure.c
>>>>>> +++ b/mm/memory-failure.c
>>>>>> @@ -2090,6 +2090,7 @@ int unpoison_memory(unsigned long pfn)
>>>>>>    {
>>>>>>    	struct page *page;
>>>>>>    	struct page *p;
>>>>>> +	pte_t *kpte;
>>>>>>    	int ret = -EBUSY;
>>>>>>    	int freeit = 0;
>>>>>>    	static DEFINE_RATELIMIT_STATE(unpoison_rs, DEFAULT_RATELIMIT_INTERVAL,
>>>>>> @@ -2101,6 +2102,13 @@ int unpoison_memory(unsigned long pfn)
>>>>>>    	p = pfn_to_page(pfn);
>>>>>>    	page = compound_head(p);
>>>>>> +	kpte = virt_to_kpte((unsigned long)page_to_virt(p));
>>>>>> +	if (kpte && !pte_present(*kpte)) {
>>>>>> +		unpoison_pr_info("Unpoison: Page was hardware poisoned %#lx\n",
>>>>>> +				 pfn, &unpoison_rs);
>>>
>>> This can prevent unpoison for hwpoison on 4kB pages, but not for hugetlb pages,
>>> where I see the similar BUG as follows (even with applying your patch):
>>>
>>>    [  917.806712] BUG: unable to handle page fault for address: ffff9f7bb3201000
>>>    [  917.810144] #PF: supervisor write access in kernel mode
>>>    [  917.812588] #PF: error_code(0x0002) - not-present page
>>>    [  917.815007] PGD 104801067 P4D 104801067 PUD 10006b063 PMD 1052d0063 PTE 800ffffeccdfe062
>>>    [  917.818768] Oops: 0002 [#1] PREEMPT SMP PTI
>>>    [  917.820759] CPU: 0 PID: 7774 Comm: test_alloc_gene Tainted: G   M       OE     5.18.0-v5.18-220606-0942-029-ge4dcc+ #47
>>>    [  917.825720] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.15.0-1.fc35 04/01/2014
>>>    [  917.829762] RIP: 0010:clear_page_erms+0x7/0x10
>>>    [  917.831867] Code: 48 89 47 18 48 89 47 20 48 89 47 28 48 89 47 30 48 89 47 38 48 8d 7f 40 75 d9 90 c3 0f 1f 80 00 00 00 00 b9 00 10 00 00 31 c0 <f3> aa c3 cc cc cc cc cc cc 48 85 ff 0f 84 d3 00 00 00 0f b6 0f 4c
>>>    [  917.840540] RSP: 0000:ffffab49c25ebdf0 EFLAGS: 00010246
>>>    [  917.842839] RAX: 0000000000000000 RBX: ffffd538c4cc8000 RCX: 0000000000001000
>>>    [  917.845835] RDX: 0000000080000000 RSI: 00007f2aeb600000 RDI: ffff9f7bb3201000
>>>    [  917.848687] RBP: 0000000000000000 R08: 0000000000000000 R09: 0000000000000000
>>>    [  917.851377] R10: 0000000000000002 R11: ffff9f7b87e3a2a0 R12: 0000000000000000
>>>    [  917.854035] R13: 0000000000000001 R14: ffffd538c4cc8000 R15: ffff9f7bc002a5d8
>>>    [  917.856539] FS:  00007f2aebad3740(0000) GS:ffff9f7bbbc00000(0000) knlGS:0000000000000000
>>>    [  917.859229] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
>>>    [  917.861149] CR2: ffff9f7bb3201000 CR3: 0000000107726003 CR4: 0000000000170ef0
>>>    [  917.863433] Call Trace:
>>>    [  917.864266]  <TASK>
>>>    [  917.864961]  clear_huge_page+0x147/0x270
>>>    [  917.866236]  hugetlb_fault+0x440/0xad0
>>>    [  917.867366]  handle_mm_fault+0x270/0x290
>>>    [  917.868532]  do_user_addr_fault+0x1c3/0x680
>>>    [  917.869768]  exc_page_fault+0x6c/0x160
>>>    [  917.870912]  ? asm_exc_page_fault+0x8/0x30
>>>    [  917.872082]  asm_exc_page_fault+0x1e/0x30
>>>    [  917.873220] RIP: 0033:0x7f2aeb8ba367
>>>
>>> I don't think of a workaround for this now ...
>>>
>>
>> Could you please tell me how to reproduce this issue?
> 
> You are familiar with qemu-monitor-command, so the following procedure
> should work for you:
> 
>   - run a process using hugepages on your VM,
>   - check the guest physical address of the hugepage (page-types.c is helpful for this),
>   - inject a MCE with virsh qemu-monitor-command on the guest physical address, then
>   - unpoison the injected physical address.

That's triggered via debugfs / HWPOISON_INJECT, right?

That's a DEBUG_KERNEL option, so I'm not 100% sure if we really want to
cc stable.

-- 
Thanks,

David / dhildenb

