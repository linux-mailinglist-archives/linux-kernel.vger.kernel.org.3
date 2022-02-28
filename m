Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C514A4C7880
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Feb 2022 20:10:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229634AbiB1TLB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Feb 2022 14:11:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40168 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229516AbiB1TLA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Feb 2022 14:11:00 -0500
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 840CAB560D
        for <linux-kernel@vger.kernel.org>; Mon, 28 Feb 2022 11:10:20 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id ECEF02199B;
        Mon, 28 Feb 2022 19:10:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1646075418; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=DCyZs1aAreyI+M1npN1wJP9oBMspfKyr+BXRhzaFXdI=;
        b=wpWSDB35o/2o0nljZ0C2oL9zhpb5PHrc4e8F33sb7/SbdMW734D0Am3VXHjVoZIl8HUoy4
        STkQ5eaPB+G+1CvyzhWWjEFXKhnhim/Me9vV0l/ZQnVmQWbLlUnzo33Tbp5gJOBcBQXOgs
        KgYtQeOIo8AMGn85gT04h+KGGHl6ZW0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1646075418;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=DCyZs1aAreyI+M1npN1wJP9oBMspfKyr+BXRhzaFXdI=;
        b=9kTtRx5RYWt2nkoQJxrVyJpK3wP3mCqe8MEw3b0Qv4lVBm2eZh1W96bXDxHZML/bwGsVT1
        3md69atfTOaFP0Aw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id B1F0713C8E;
        Mon, 28 Feb 2022 19:10:18 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id cIfcKhoeHWJfVgAAMHmgww
        (envelope-from <vbabka@suse.cz>); Mon, 28 Feb 2022 19:10:18 +0000
Message-ID: <f194f876-1c46-f3ae-573e-d3ddd6dcf4cc@suse.cz>
Date:   Mon, 28 Feb 2022 20:10:18 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.1
Content-Language: en-US
To:     Hyeonggon Yoo <42.hyeyoo@gmail.com>
Cc:     David Rientjes <rientjes@google.com>,
        Christoph Lameter <cl@linux.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Pekka Enberg <penberg@kernel.org>,
        Roman Gushchin <roman.gushchin@linux.dev>,
        Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        patches@lists.linux.dev, linux-kernel@vger.kernel.org,
        Oliver Glitta <glittao@gmail.com>,
        Faiyaz Mohammed <faiyazm@codeaurora.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Randy Dunlap <rdunlap@infradead.org>,
        Marco Elver <elver@google.com>,
        Karolina Drobnik <karolinadrobnik@gmail.com>,
        Mike Rapoport <rppt@linux.ibm.com>
References: <20220225180318.20594-1-vbabka@suse.cz>
 <YhnUcqyeMgCrWZbd@ip-172-31-19-208.ap-northeast-1.compute.internal>
From:   Vlastimil Babka <vbabka@suse.cz>
Subject: Re: [PATCH 0/5] SLUB debugfs improvements based on stackdepot
In-Reply-To: <YhnUcqyeMgCrWZbd@ip-172-31-19-208.ap-northeast-1.compute.internal>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/26/22 08:19, Hyeonggon Yoo wrote:
> On Fri, Feb 25, 2022 at 07:03:13PM +0100, Vlastimil Babka wrote:
>> Hi,
>> 
>> this series combines and revives patches from Oliver's last year
>> bachelor thesis (where I was the advisor) that make SLUB's debugfs
>> files alloc_traces and free_traces more useful.
>> The resubmission was blocked on stackdepot changes that are now merged,
>> as explained in patch 2.
>> 
> 
> Hello. I just started review/testing this series.
> 
> it crashed on my system (arm64)

Hmm, interesting. On x86_64 this works for me and stackdepot is allocated
from memblock. arm64 must have memblock freeing happen earlier or something.
(CCing memblock experts)

> I ran with boot parameter slub_debug=U, and without KASAN.
> So CONFIG_STACKDEPOT_ALWAYS_INIT=n.
> 
> void * __init memblock_alloc_try_nid(
>                         phys_addr_t size, phys_addr_t align,
>                         phys_addr_t min_addr, phys_addr_t max_addr,
>                         int nid)
> {
>         void *ptr;
> 
>         memblock_dbg("%s: %llu bytes align=0x%llx nid=%d from=%pa max_addr=%pa %pS\n",
>                      __func__, (u64)size, (u64)align, nid, &min_addr,
>                      &max_addr, (void *)_RET_IP_);
>         ptr = memblock_alloc_internal(size, align,
>                                            min_addr, max_addr, nid, false);
>         if (ptr)
>                 memset(ptr, 0, size); <--- Crash Here
> 
>         return ptr;
> }
> 
> It crashed during create_boot_cache() -> stack_depot_init() ->
> memblock_alloc().
> 
> I think That's because, in kmem_cache_init(), both slab and memblock is not
> available. (AFAIU memblock is not available after mem_init() because of
> memblock_free_all(), right?)

Hm yes I see, even in x86_64 version mem_init() calls memblock_free_all().
But then, I would expect stack_depot_init() to detect that memblock_alloc()
returns NULL, we print ""Stack Depot hash table allocation failed,
disabling" and disable it. Instead it seems memblock_alloc() returns
something that's already potentially used by somebody else? Sounds like a bug?

> Thanks!
> 
> /*
>  * Set up kernel memory allocators
>  */
> static void __init mm_init(void)
> {
>         /*
>          * page_ext requires contiguous pages,
>          * bigger than MAX_ORDER unless SPARSEMEM.
>          */
>         page_ext_init_flatmem();
>         init_mem_debugging_and_hardening();
>         kfence_alloc_pool();
>         report_meminit();
>         stack_depot_early_init();
>         mem_init();
>         mem_init_print_info();
>         kmem_cache_init();
>         /*
>          * page_owner must be initialized after buddy is ready, and also after
>          * slab is ready so that stack_depot_init() works properly
>          */)
> 
>> Patch 1 is a new preparatory cleanup.
>> 
>> Patch 2 originally submitted here [1], was merged to mainline but
>> reverted for stackdepot related issues as explained in the patch.
>> 
>> Patches 3-5 originally submitted as RFC here [2]. In this submission I
>> have omitted the new file 'all_objects' (patch 3/3 in [2]) as it might
>> be considered too intrusive so I will postpone it for later. The docs
>> patch is adjusted accordingly.
>> 
>> Also available in git, based on v5.17-rc1:
>> https://git.kernel.org/pub/scm/linux/kernel/git/vbabka/linux.git/log/?h=slub-stackdepot-v1
>> 
>> I'd like to ask for some review before I add this to the slab tree.
>> 
>> [1] https://lore.kernel.org/all/20210414163434.4376-1-glittao@gmail.com/
>> [2] https://lore.kernel.org/all/20210521121127.24653-1-glittao@gmail.com/
>> 
>> Oliver Glitta (4):
>>   mm/slub: use stackdepot to save stack trace in objects
>>   mm/slub: aggregate and print stack traces in debugfs files
>>   mm/slub: sort debugfs output by frequency of stack traces
>>   slab, documentation: add description of debugfs files for SLUB caches
>> 
>> Vlastimil Babka (1):
>>   mm/slub: move struct track init out of set_track()
>> 
>>  Documentation/vm/slub.rst |  61 +++++++++++++++
>>  init/Kconfig              |   1 +
>>  mm/slub.c                 | 152 +++++++++++++++++++++++++-------------
>>  3 files changed, 162 insertions(+), 52 deletions(-)
>> 
>> -- 
>> 2.35.1
>> 
>> 
> 

