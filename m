Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6311C4D9639
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Mar 2022 09:31:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345923AbiCOIcH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Mar 2022 04:32:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54578 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231732AbiCOIcG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Mar 2022 04:32:06 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 1F2014BFE8
        for <linux-kernel@vger.kernel.org>; Tue, 15 Mar 2022 01:30:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1647333053;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=dQG+Rkt8gdJ4PWygDlMCP3zo7PDSl3k1Tni5cdgA4uE=;
        b=aSCu1omlLjEeC/1AhJKe5GOsubEUj+N00yfDgGFuWAL/moN3o6wwNgYdz4UoglJNeYmq9/
        nTo9DLCvaqS5qPksdSitY7jdKBZGnNmUwxgOuQSXmxiIr6mT0mvTVYD1V00cwXiA0PwpBU
        +OSAaXoLaDZ328y/TFJoUdqGiMw0AAE=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-619-hCd97qtDMHuA_oT9VJH6TA-1; Tue, 15 Mar 2022 04:30:51 -0400
X-MC-Unique: hCd97qtDMHuA_oT9VJH6TA-1
Received: by mail-wm1-f70.google.com with SMTP id k41-20020a05600c1ca900b00389a2b983efso6368720wms.4
        for <linux-kernel@vger.kernel.org>; Tue, 15 Mar 2022 01:30:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:organization:in-reply-to
         :content-transfer-encoding;
        bh=dQG+Rkt8gdJ4PWygDlMCP3zo7PDSl3k1Tni5cdgA4uE=;
        b=jGKngAi/WMT8xpQGYHNqox2eKwiYXjOPdvzRhwNHHFWBOkGyXcUs5Qk+AWSKgbFVX3
         8vGyoA2m/OD6+bKJ/pmNCBco82uDLXUoMzsvoaMnBJMRPshJ3ek91N2ge2HzuENhagmF
         7J/4BeLm6yg/CrVpPLhfCBu4WAgaIEcaR6dfAiUC+0+Q9cpvYuLV7SbRNXW3+c1KHH07
         Y2bfzooIdz3BYU4aPCjuXAXJBOa7Nu0eV5CP7FRZ0mxqpUc8CdYBHrjyN9Rex3NnewRS
         Fe89+C9ooFGMt2BkPSkEV7xRAtGL/sBtZFqhdcPCDIxoSl+Y6TL38Dc29uBygFb2mC0B
         UiEA==
X-Gm-Message-State: AOAM530asZDxxIqTlzc7RT2vyytgwOIWKkKX8hJ4tZwJXqsLlA/qZ13G
        wS5fdI1DnN0MV0fiBPHzyGyhAr3OnRC3KR5iLhaARmRcv3I7oWtj9WevRnugNRRqU0sH1oNPzXz
        n1KzStkrnWDXJPBSL840bhh4x
X-Received: by 2002:a05:6000:1864:b0:203:7e40:b0de with SMTP id d4-20020a056000186400b002037e40b0demr19232281wri.268.1647333050598;
        Tue, 15 Mar 2022 01:30:50 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJz/JlEsKbctZlvSR+reSprzJ1VZhPTLwCjWq3hrG5M7QziVqcIXh31wUbtmG31IMxtswrH2zg==
X-Received: by 2002:a05:6000:1864:b0:203:7e40:b0de with SMTP id d4-20020a056000186400b002037e40b0demr19232254wri.268.1647333050243;
        Tue, 15 Mar 2022 01:30:50 -0700 (PDT)
Received: from ?IPV6:2003:cb:c708:1800:42bd:3cac:d22a:3c62? (p200300cbc708180042bd3cacd22a3c62.dip0.t-ipconnect.de. [2003:cb:c708:1800:42bd:3cac:d22a:3c62])
        by smtp.gmail.com with ESMTPSA id 10-20020adf808a000000b001edd413a952sm15120297wrl.95.2022.03.15.01.30.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 15 Mar 2022 01:30:49 -0700 (PDT)
Message-ID: <e37e7e12-66e9-e26c-11a0-5f8a4268df14@redhat.com>
Date:   Tue, 15 Mar 2022 09:30:48 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.2
Subject: Re: zram corruption due to uninitialized do_swap_page fault
Content-Language: en-US
To:     Minchan Kim <minchan@kernel.org>, Ivan Babrou <ivan@cloudflare.com>
Cc:     Linux MM <linux-mm@kvack.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Nitin Gupta <ngupta@vflare.org>,
        Sergey Senozhatsky <senozhatsky@chromium.org>,
        Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        kernel-team <kernel-team@cloudflare.com>
References: <CABWYdi2a=Tc3dRfQ+037PG0GHKvZd5SEXJxBBbNspsrHK1zNpQ@mail.gmail.com>
 <CABWYdi1PeNbgnM4qE001+_BzHJxQcaaY9sLOK=Y7gjqfXZO0=g@mail.gmail.com>
 <YjA439FwajtHsahr@google.com>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
In-Reply-To: <YjA439FwajtHsahr@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 15.03.22 07:57, Minchan Kim wrote:
> On Mon, Mar 14, 2022 at 09:18:43PM -0700, Ivan Babrou wrote:
>> On Fri, Mar 11, 2022 at 11:51 AM Ivan Babrou <ivan@cloudflare.com> wrote:
>>>
>>> Hello,
>>>
>>> We're looking into using zram, but unfortunately we ran into some
>>> corruption issues. We've seen rocksdb complaining about "Corruption:
>>> bad entry in block", and we've also seen some coredumps that point at
>>> memory being zeroed out. One of our Rust processes coredumps contains
>>> a non-null pointer pointing at zero, among other things:
>>>
>>> * core::ptr::non_null::NonNull<u8> {pointer: 0x0}
>>>
>>> In fact, a whole bunch of memory around this pointer was all zeros.
>>>
>>> Disabling zram resolves all issues, and we can't reproduce any of
>>> these issues with other swap setups. I've tried adding crc32
>>> checksumming for pages that are compressed, but it didn't catch the
>>> issue either, even though userspace facing symptoms were present. My
>>> crc32 code doesn't touch ZRAM_SAME pages, though.
>>>
>>> Unfortunately, this isn't trivial to replicate, and I believe that it
>>> depends on zram used for swap specifically, not for zram as a block
>>> device. Specifically, swap_slot_free_notify looks suspicious.
>>>
>>> Here's a patch that I have to catch the issue in the act:
>>>
>>> diff --git a/drivers/block/zram/zram_drv.c b/drivers/block/zram/zram_drv.c
>>> index 438ce34ee760..fea46a70a3c9 100644
>>> --- a/drivers/block/zram/zram_drv.c
>>> +++ b/drivers/block/zram/zram_drv.c
>>> @@ -1265,6 +1265,9 @@ static int __zram_bvec_read(struct zram *zram,
>>> struct page *page, u32 index,
>>>   unsigned long value;
>>>   void *mem;
>>>
>>> + if (WARN_ON(!handle && !zram_test_flag(zram, index, ZRAM_SAME)))
>>> + pr_warn("Page %u read from zram without previous write\n", index);
>>> +
>>>   value = handle ? zram_get_element(zram, index) : 0;
>>>   mem = kmap_atomic(page);
>>>   zram_fill_page(mem, PAGE_SIZE, value);
>>>
>>> In essence, it warns whenever a page is read from zram that was not
>>> previously written to. To make this work, one needs to zero out zram
>>> prior to running mkswap on it.
>>>
>>> I have prepared a GitHub repo with my observations and a reproduction:
>>>
>>> * https://github.com/bobrik/zram-corruptor
>>>
>>> I'm able to trigger the following in an aarch64 VM with two threads
>>> reading the same memory out of swap:
>>>
>>> [ 512.651752][ T7285] ------------[ cut here ]------------
>>> [ 512.652279][ T7285] WARNING: CPU: 0 PID: 7285 at
>>> drivers/block/zram/zram_drv.c:1285 __zram_bvec_read+0x28c/0x2e8 [zram]
>>> [ 512.653923][ T7285] Modules linked in: zram zsmalloc kheaders nfsv3
>>> nfs lockd grace sunrpc xt_conntrack nft_chain_nat xt_MASQUERADE nf_nat
>>> nf_conntrack_netlink nf_conntrack nf_defrag_ipv6 nf_defrag_ipv4
>>> nft_counter xt_addrtype nft_compat nf_tables nfnetlink bridge stp llc
>>> overlay xfs libcrc32c zstd zstd_compress af_packet aes_ce_blk
>>> aes_ce_cipher ghash_ce gf128mul virtio_net sha3_ce net_failover
>>> sha3_generic failover sha512_ce sha512_arm64 sha2_ce sha256_arm64
>>> virtio_mmio virtio_ring qemu_fw_cfg rtc_pl031 virtio fuse ip_tables
>>> x_tables ext4 mbcache crc16 jbd2 nvme nvme_core pci_host_generic
>>> pci_host_common unix [last unloaded: zsmalloc]
>>> [ 512.659238][ T7285] CPU: 0 PID: 7285 Comm: zram-corruptor Tainted: G
>>> W 5.16.0-ivan #1 0877d306c6dc0716835d43cafe4399473d09e406
>>> [ 512.660413][ T7285] Hardware name: linux,dummy-virt (DT)
>>> [ 512.661077][ T7285] pstate: 80400005 (Nzcv daif +PAN -UAO -TCO -DIT
>>> -SSBS BTYPE=--)
>>> [ 512.661788][ T7285] pc : __zram_bvec_read+0x28c/0x2e8 [zram]
>>> [ 512.662099][ T7285] lr : zram_bvec_rw+0x70/0x204 [zram]
>>> [ 512.662422][ T7285] sp : ffffffc01018bac0
>>> [ 512.662720][ T7285] x29: ffffffc01018bae0 x28: ffffff9e4e725280 x27:
>>> ffffff9e4e725280
>>> [ 512.663122][ T7285] x26: ffffff9e4e725280 x25: 00000000000001f6 x24:
>>> 0000000100033e6c
>>> [ 512.663601][ T7285] x23: 00000000000001f6 x22: 0000000000000000 x21:
>>> fffffffe7a36d840
>>> [ 512.664252][ T7285] x20: 00000000000001f6 x19: ffffff9e69423c00 x18:
>>> ffffffc010711068
>>> [ 512.664812][ T7285] x17: 0000000000000008 x16: ffffffd34aed51bc x15:
>>> 0000000000000000
>>> [ 512.665507][ T7285] x14: 0000000000000a88 x13: 0000000000000000 x12:
>>> 0000000000000000
>>> [ 512.666183][ T7285] x11: 0000000100033e6c x10: ffffffc01091d000 x9 :
>>> 0000000001000000
>>> [ 512.666627][ T7285] x8 : 0000000000002f10 x7 : 80b75f8fb90b52c4 x6 :
>>> 051609fe50833de3
>>> [ 512.667276][ T7285] x5 : 0000000000000000 x4 : 0000000000000000 x3 :
>>> 0000000000000000
>>> [ 512.667875][ T7285] x2 : 00000000000001f6 x1 : 00000000000001f6 x0 :
>>> ffffffd305b746af
>>> [ 512.668483][ T7285] Call trace:
>>> [ 512.668682][ T7285] __zram_bvec_read+0x28c/0x2e8 [zram
>>> 745969ed35ea0fb382bfd518d6f70e13966e9b52]
>>> [ 512.669405][ T7285] zram_bvec_rw+0x70/0x204 [zram
>>> 745969ed35ea0fb382bfd518d6f70e13966e9b52]
>>> [ 512.670066][ T7285] zram_rw_page+0xb4/0x16c [zram
>>> 745969ed35ea0fb382bfd518d6f70e13966e9b52]
>>> [ 512.670584][ T7285] bdev_read_page+0x74/0xac
>>> [ 512.670843][ T7285] swap_readpage+0x5c/0x2e4
>>> [ 512.671243][ T7285] do_swap_page+0x2f4/0x988
>>> [ 512.671560][ T7285] handle_pte_fault+0xcc/0x1fc
>>> [ 512.671935][ T7285] handle_mm_fault+0x284/0x4a8
>>> [ 512.672412][ T7285] do_page_fault+0x274/0x428
>>> [ 512.672704][ T7285] do_translation_fault+0x5c/0xf8
>>> [ 512.673083][ T7285] do_mem_abort+0x50/0xc8
>>> [ 512.673293][ T7285] el0_da+0x3c/0x74
>>> [ 512.673549][ T7285] el0t_64_sync_handler+0xc4/0xec
>>> [ 512.673972][ T7285] el0t_64_sync+0x1a4/0x1a8
>>> [ 512.674495][ T7285] ---[ end trace cf983b7507c20343 ]---
>>> [ 512.675359][ T7285] zram: Page 502 read from zram without previous write
>>>
>>> I can also trace accesses to zram to catch the unfortunate sequence:
>>>
>>> zram_bvec_write index = 502 [cpu = 3, tid = 7286]
>>> zram_free_page index = 502 [cpu = 3, tid = 7286]
>>> zram_bvec_read index = 502 [cpu = 3, tid = 7286]
>>> zram_free_page index = 502 [cpu = 3, tid = 7286] <-- problematic free
>>> zram_bvec_read index = 502 [cpu = 0, tid = 7285] <-- problematic read
>>>
>>> With stacks for zram_free_page:
>>>
>>> zram_bvec_write index = 502 [cpu = 3, tid = 7286]
>>> zram_free_page  index = 502 [cpu = 3, tid = 7286]
>>>
>>>         zram_free_page+0
>>>         $x.97+32
>>>         zram_rw_page+180
>>>         bdev_write_page+124
>>>         __swap_writepage+116
>>>         swap_writepage+160
>>>         pageout+284
>>>         shrink_page_list+2892
>>>         shrink_inactive_list+688
>>>         shrink_lruvec+360
>>>         shrink_node_memcgs+148
>>>         shrink_node+860
>>>         shrink_zones+368
>>>         do_try_to_free_pages+232
>>>         try_to_free_mem_cgroup_pages+292
>>>         try_charge_memcg+608
>>>
>>> zram_bvec_read  index = 502 [cpu = 3, tid = 7286]
>>> zram_free_page  index = 502 [cpu = 3, tid = 7286] <-- problematic free
>>>
>>>         zram_free_page+0
>>>         swap_range_free+220
>>>         swap_entry_free+244
>>>         swapcache_free_entries+152
>>>         free_swap_slot+288
>>>         __swap_entry_free+216
>>>         swap_free+108
>>>         do_swap_page+1776
>>>         handle_pte_fault+204
>>>         handle_mm_fault+644
>>>         do_page_fault+628
>>>         do_translation_fault+92
>>>         do_mem_abort+80
>>>         el0_da+60
>>>         el0t_64_sync_handler+196
>>>         el0t_64_sync+420
>>>
>>> zram_bvec_read  index = 502 [cpu = 0, tid = 7285] <-- problematic read
>>>
>>> The very last read is the same one that triggered the warning from my
>>> patch in dmesg. You can see that the slot is freed before reading by
>>> swapcache_free_entries. As far as I can see, only zram implements
>>> swap_slot_free_notify. Swapping in an uninitialized zram page results
>>> in all zeroes copied, which matches the symptoms.
>>>
>>> The issue doesn't reproduce if I pin both threads to the same CPU. It
>>> also doesn't reproduce with a single thread. All of this seems to
>>> point at some sort of race condition.
>>>
>>> I was able to reproduce this on x86_64 bare metal server as well.
>>>
>>> I'm happy to try out mitigation approaches for this. If my
>>> understanding here is incorrect, I'm also happy to try out patches
>>> that could help me catch the issue in the wild.
>>
>> I poked around the swapping code a bit. In the failing read stack:
>>
>> [ 1298.167823][ T7004]  swap_readpage+0x60/0x328
>> [ 1298.168317][ T7004]  do_swap_page+0x438/0x904
>>
>> You can see that swap_readpage is only called from do_swap_page for
>> synchronous IO:
>>
>> if (data_race(si->flags & SWP_SYNCHRONOUS_IO) &&
>>     __swap_count(entry) == 1) {
>>     // ...
>>     if (page) {
>>         // ...
>>         swap_readpage(page, true);
>>
>> See: https://elixir.bootlin.com/linux/v5.15.28/source/mm/memory.c#L3548
>>
>> I looked around some more and found 0bcac06f27d7:
>>
>> * mm, swap: skip swapcache for swapin of synchronous device
>>
>> Zram is considered fast synchronous storage. Reverting that notion
>> makes my reproduction not complain anymore:
> 
> 
> Yeah, that was the part I was chasing since we had problem there
> 
> 5df373e95689b, mm/page_io.c: do not free shared swap slots
> 
> Initially, I suspected __swap_count race(I still believe it has
> swap_slot_free_notify and do_swap_page) and fixed the race
> with workaround but the problem still happened. 
> 
> Looks like your test program clone the child with CLONE_VM
> which never call swap_duplicate to increase swap_map count.
> It means the 0bcac06f27d7 and 5df373e95689b couldn't work
> with CLONE_VM.
> 
> I think reverting them is best at this moment unless someone
> has an idea.
> 

Is it just zram, that's broken? Can we special-case that to not bypass
the swapcache?

-- 
Thanks,

David / dhildenb

