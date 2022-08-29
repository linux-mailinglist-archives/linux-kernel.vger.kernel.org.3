Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4F6AC5A4EB9
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Aug 2022 16:01:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229953AbiH2OBA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 Aug 2022 10:01:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43490 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229477AbiH2OA5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Aug 2022 10:00:57 -0400
Received: from mail-pj1-x102b.google.com (mail-pj1-x102b.google.com [IPv6:2607:f8b0:4864:20::102b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 593811D0FB
        for <linux-kernel@vger.kernel.org>; Mon, 29 Aug 2022 07:00:56 -0700 (PDT)
Received: by mail-pj1-x102b.google.com with SMTP id t11-20020a17090a510b00b001fac77e9d1fso14743783pjh.5
        for <linux-kernel@vger.kernel.org>; Mon, 29 Aug 2022 07:00:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc;
        bh=VwucjO56FRTXH12J+9VmzrsKwG2woKnxAdupUBhNqZk=;
        b=pJg3FM/SVT7c7CGf9zgV9P8uQTwk+0K2zEhQ9snPlJzes0qNEE4Uoz15USvy7vk7rW
         zoYDq+YJYe0woGR1NEVwVw9PbB2YNu6TlOCTgLq0HYPhgPIR0+JMiW1GWnt7d6OSmkRB
         p3LWle2z9mlCNzNjtGzrilUsNUEizIOvlugfVawJdf2Dw5I/9nNwON2KiI/dcNoi4HCM
         Lagcx/cNmZi53hWmsdOG07kdrB9ufwj1PvVItSUkqa1sfERBrDIuP3YsdPh6syGYwL8c
         wwCoJzu1TKXA1EU1sYXRbh7gMKeJzFseelPLAecAbCK549sxuED0iVBJzrLbRS77lRfx
         w7zg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc;
        bh=VwucjO56FRTXH12J+9VmzrsKwG2woKnxAdupUBhNqZk=;
        b=cwJ55ILHYoszEsWS51zATmvBQnW1WY2vJqMab6HQ2Slt24+3fV6OdVEVkB14RFFyLy
         rBB3++fUPA4mRZs5RedLWvbuoqq0qZS1gg+piH2L+PUCigp87J4Ljb7SmpyRmwgh71bC
         g/fmKlxwEFOak06CljQS3wxGkJeOdhIS4BrNoqA5FSMqSImlW6VX5XsiE9uE3ER8PBgc
         KEFgu4KYyC3KLbz34hpbPvWLhHKhnzzClxRM5erDIMezuJx16HZUTnYVMsu9QGjFjZmk
         QXTzST3Si9EyPiPdUJVS3eemoSZI+z6H1wVy05b5kgPJQXWIZ8gwrFSOui0VPi8eQbHR
         yU1Q==
X-Gm-Message-State: ACgBeo1p2fm3p7I5+CFn4U85Gwjb+S7f9Kg9/NhQqRMsCmYWL82AqUX4
        tEGksb0MJHYgzXRJ3MMrRMh5Aw==
X-Google-Smtp-Source: AA6agR4rDbtL93VfkB2mzMD8qt15B4Q5tCJdb8y45a8UrAx2DEmzdxcEQTlhzKzVmPRvjNsdhay+Kg==
X-Received: by 2002:a17:902:8ec6:b0:172:dc2c:306d with SMTP id x6-20020a1709028ec600b00172dc2c306dmr17023408plo.104.1661781655448;
        Mon, 29 Aug 2022 07:00:55 -0700 (PDT)
Received: from [10.4.115.67] ([139.177.225.244])
        by smtp.gmail.com with ESMTPSA id u123-20020a626081000000b0053813de1fdasm3500660pfb.28.2022.08.29.07.00.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 29 Aug 2022 07:00:54 -0700 (PDT)
Message-ID: <68f43b57-32b6-1844-a0a6-d22fb0e089aa@bytedance.com>
Date:   Mon, 29 Aug 2022 22:00:47 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.1.2
Subject: Re: [RFC PATCH 0/7] Try to free empty and zero user PTE page table
 pages
Content-Language: en-US
To:     David Hildenbrand <david@redhat.com>, akpm@linux-foundation.org,
        kirill.shutemov@linux.intel.com, jgg@nvidia.com,
        tglx@linutronix.de, willy@infradead.org
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        muchun.song@linux.dev
References: <20220825101037.96517-1-zhengqi.arch@bytedance.com>
 <cf2dee71-0b01-1df2-f97e-12c27ed6d630@redhat.com>
From:   Qi Zheng <zhengqi.arch@bytedance.com>
In-Reply-To: <cf2dee71-0b01-1df2-f97e-12c27ed6d630@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2022/8/29 18:09, David Hildenbrand wrote:
> On 25.08.22 12:10, Qi Zheng wrote:
>> Hi,
>>
>> Before this, in order to free empty user PTE page table pages, I posted the
>> following patch sets of two solutions:
>>   - atomic refcount version:
>> 	https://lore.kernel.org/lkml/20211110105428.32458-1-zhengqi.arch@bytedance.com/
>>   - percpu refcount version:
>> 	https://lore.kernel.org/lkml/20220429133552.33768-1-zhengqi.arch@bytedance.com/
>>
>> Both patch sets have the following behavior:
>> a. Protect the page table walker by hooking pte_offset_map{_lock}() and
>>     pte_unmap{_unlock}()
>> b. Will automatically reclaim PTE page table pages in the non-reclaiming path
>>
>> For behavior a, there may be the following disadvantages mentioned by
>> David Hildenbrand:
>>   - It introduces a lot of complexity. It's not something easy to get in and most
>>     probably not easy to get out again
>>   - It is inconvenient to extend to other architectures. For example, for the
>>     continuous ptes of arm64, the pointer to the PTE entry is obtained directly
>>     through pte_offset_kernel() instead of pte_offset_map{_lock}()
>>   - It has been found that pte_unmap() is missing in some places that only
>>     execute on 64-bit systems, which is a disaster for pte_refcount
>>
>> For behavior b, it may not be necessary to actively reclaim PTE pages, especially
>> when memory pressure is not high, and deferring to the reclaim path may be a
>> better choice.
>>
>> In addition, the above two solutions are only for empty PTE pages (a PTE page
>> where all entries are empty), and do not deal with the zero PTE page ( a PTE
>> page where all page table entries are mapped to shared zero page) mentioned by
>> David Hildenbrand:
>> 	"Especially the shared zeropage is nasty, because there are
>> 	 sane use cases that can trigger it. Assume you have a VM
>> 	 (e.g., QEMU) that inflated the balloon to return free memory
>> 	 to the hypervisor.
>>
>> 	 Simply migrating that VM will populate the shared zeropage to
>> 	 all inflated pages, because migration code ends up reading all
>> 	 VM memory. Similarly, the guest can just read that memory as
>> 	 well, for example, when the guest issues kdump itself."
>>
>> The purpose of this RFC patch is to continue the discussion and fix the above
>> issues. The following is the solution to be discussed.
> 
> Thanks for providing an alternative! It's certainly easier to digest :)

Hi David,

Nice to see your reply.

> 
>>
>> In order to quickly identify the above two types of PTE pages, we still
>> introduced a pte_refcount for each PTE page. We put the mapped and zero PTE
>> entry counter into the pte_refcount of the PTE page. The bitmask has the
>> following meaning:
>>
>>   - bits 0-9 are mapped PTE entry count
>>   - bits 10-19 are zero PTE entry count
> 
> I guess we could factor the zero PTE change out, to have an even simpler
OK, we can deal with the empty PTE page case first.

> first version. The issue is that some features (userfaultfd) don't
> expect page faults when something was aleady mapped previously.
> 
> PTE markers as introduced by Peter might require a thought -- we don't
> have anything mapped but do have additional information that we have to
> maintain.

I see the pte marker entry is non-present entry not empty entry 
(pte_none()). So we've dealt with this situation, which is also
what's done in [RFC PATCH 1/7].

> 
>>
>> In this way, when mapped PTE entry count is 0, we can know that the current PTE
>> page is an empty PTE page, and when zero PTE entry count is PTRS_PER_PTE, we can
>> know that the current PTE page is a zero PTE page.
>>
>> We only update the pte_refcount when setting and clearing of PTE entry, and
>> since they are both protected by pte lock, pte_refcount can be a non-atomic
>> variable with little performance overhead.
>>
>> For page table walker, we mutually exclusive it by holding write lock of
>> mmap_lock when doing pmd_clear() (in the newly added path to reclaim PTE pages).
> 
> I recall when I played with that idea that the mmap_lock is not
> sufficient to rip out a page table. IIRC, we also have to hold the rmap
> lock(s), to prevent RMAP walkers from still using the page table.

Oh, I forgot this. We should also hold rmap lock(s) like
move_normal_pmd().

> 
> Especially if multiple VMAs intersect a page table, things might get
> tricky, because multiple rmap locks could be involved.

Maybe we can iterate over the vma list and just process the 2M aligned
part?

> 
> We might want/need another mechanism to synchronize against page table
> walkers.

This is a tricky problem, equivalent to narrowing the protection scope
of mmap_lock. Any preliminary ideas?

Thanks,
Qi

> 

-- 
Thanks,
Qi
