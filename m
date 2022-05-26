Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 98E6B535413
	for <lists+linux-kernel@lfdr.de>; Thu, 26 May 2022 21:46:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348851AbiEZTqw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 May 2022 15:46:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53722 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234813AbiEZTqt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 May 2022 15:46:49 -0400
Received: from mail-pl1-x62e.google.com (mail-pl1-x62e.google.com [IPv6:2607:f8b0:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA4906B088
        for <linux-kernel@vger.kernel.org>; Thu, 26 May 2022 12:46:47 -0700 (PDT)
Received: by mail-pl1-x62e.google.com with SMTP id s14so2287952plk.8
        for <linux-kernel@vger.kernel.org>; Thu, 26 May 2022 12:46:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=10Sx9S31e2idpPzTS8bdIYASB+W2MY1RjKj3b50jxno=;
        b=BhWNPt+Fs+dkDlGSEJf+F2zzckhK5r4u/mwh0dONw5POvJTOhTrYg+5hgv7x7vkzXo
         N8vrUh9AaoNUN+i4bCfRTy5pVYdZCp4muwGl5DM8/sUrwrlW/arMbLzUPohjFx/T6QtE
         toMt2+2rc+2ZIjqT/JZEDDUxBxWwV73CuwYTJogb9hMdzGFCzI3Yogh8Ukpn46DvTB5e
         8euJeIO1oUShbtMlSJrYygh0rP0h+9CFehB5aEXSxdXk64gUaL7o6egRLlvFnA7T+BDY
         UPUQXu8wKrDr93Xm+wbOGQNFJvL4NHBsHn6oi0h+sLO+IIbnB0gSUvPDvqdQxgdu1tIX
         msbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=10Sx9S31e2idpPzTS8bdIYASB+W2MY1RjKj3b50jxno=;
        b=dctKz7uZWksF9SblIis7NVD+BwPlGRKfKlRgnNV57hbh0V/LwfnqAbKe0OeCP3mBUJ
         LX3QzK8OooBNjfqC9gR8pGbadlZFKUXQ5bKWo2RX1iltGbwd0NWPYIhiraNb3C940nnH
         Y0cj70nNf+j8492+wMPtVzziRoVed05w5fb55pW+gek6ywMn9Di199m/gzP8gx0e5zIv
         XURx13OI9zwX5d146OuoRc1EHWfr1OELxH6KhtzEfTPRieeACEaIe/bGwnToYOTbs/7m
         kZnBXhv3D7FSfikIejc4XPgkVCyDUUh86OM8yUgwQUUyFp8Q7WEwAdJl2At4f17TB3ve
         W7iQ==
X-Gm-Message-State: AOAM530MSdbGvdLqxckSdybNrqGJm/OfatqBtWA4MTS6aEPO0w/AhX5i
        yRhKFOHuuV8oQrsoINVcAqI=
X-Google-Smtp-Source: ABdhPJxwvObOqF0ec6vutPjsD1M0dTjHDj1dhQuRd4QPqe95Y4WSFjdIzdOEhubaAyzDa8kP4aEOFQ==
X-Received: by 2002:a17:90a:8b98:b0:1e2:5df6:52b8 with SMTP id z24-20020a17090a8b9800b001e25df652b8mr3235837pjn.28.1653594407329;
        Thu, 26 May 2022 12:46:47 -0700 (PDT)
Received: from [192.168.1.50] (ip70-191-40-110.oc.oc.cox.net. [70.191.40.110])
        by smtp.gmail.com with ESMTPSA id q2-20020a170902b10200b0015e8d4eb1f7sm2010994plr.65.2022.05.26.12.46.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 26 May 2022 12:46:46 -0700 (PDT)
Message-ID: <c3932a6f-77fe-29f7-0c29-fe6b1c67ab7b@gmail.com>
Date:   Thu, 26 May 2022 12:46:44 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.0
Subject: Re: [PATCH v11 3/6] mm: make alloc_contig_range work at pageblock
 granularity
Content-Language: en-US
To:     Zi Yan <ziy@nvidia.com>
Cc:     David Hildenbrand <david@redhat.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org,
        virtualization@lists.linux-foundation.org,
        Vlastimil Babka <vbabka@suse.cz>,
        Mel Gorman <mgorman@techsingularity.net>,
        Eric Ren <renzhengeek@gmail.com>,
        Mike Rapoport <rppt@kernel.org>,
        Oscar Salvador <osalvador@suse.de>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        Andrew Morton <akpm@linux-foundation.org>,
        kernel test robot <lkp@intel.com>,
        Qian Cai <quic_qiancai@quicinc.com>
References: <20220425143118.2850746-1-zi.yan@sent.com>
 <20220425143118.2850746-4-zi.yan@sent.com>
 <23A7297E-6C84-4138-A9FE-3598234004E6@nvidia.com>
 <180aaa57-28d8-30f0-e843-ea52e3a180a8@gmail.com>
 <F80CEC0E-0EA8-4210-8730-57D4D0CF0B23@nvidia.com>
 <fcac3340-31b5-8536-fd4e-ecb8a9aee2ae@gmail.com>
 <ABD35D2B-58CB-4050-8B45-17F34B360573@nvidia.com>
 <805CA8E8-9216-4CB3-BC8E-DC89456FDF3C@nvidia.com>
From:   Doug Berger <opendmb@gmail.com>
In-Reply-To: <805CA8E8-9216-4CB3-BC8E-DC89456FDF3C@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/26/2022 10:34 AM, Zi Yan wrote:
> On 25 May 2022, at 17:11, Zi Yan wrote:
> 
>> On 25 May 2022, at 17:03, Doug Berger wrote:
>>
>>> On 5/25/2022 10:53 AM, Zi Yan wrote:
>>>> On 25 May 2022, at 13:41, Doug Berger wrote:
>>>>
>>>>> I am seeing some free memory accounting problems with linux-next that I have bisected to this commit (i.e. b2c9e2fbba32 ("mm: make alloc_contig_range work at pageblock granularity").
>>>>>
>>>>> On an arm64 SMP platform with 4GB total memory and the default 16MB default CMA pool, I am seeing the following after boot with a sysrq Show Memory (e.g. 'echo m > /proc/sysrq-trigger'):
>>>>>
>>>>> [   16.015906] sysrq: Show Memory
>>>>> [   16.019039] Mem-Info:
>>>>> [   16.021348] active_anon:14604 inactive_anon:919 isolated_anon:0
>>>>> [   16.021348]  active_file:0 inactive_file:0 isolated_file:0
>>>>> [   16.021348]  unevictable:0 dirty:0 writeback:0
>>>>> [   16.021348]  slab_reclaimable:3662 slab_unreclaimable:3333
>>>>> [   16.021348]  mapped:928 shmem:15146 pagetables:63 bounce:0
>>>>> [   16.021348]  kernel_misc_reclaimable:0
>>>>> [   16.021348]  free:976766 free_pcp:991 free_cma:7017
>>>>> [   16.056937] Node 0 active_anon:58416kB inactive_anon:3676kB active_file:0kB inactive_file:0kB unevictable:0kB isolated(anon):0kB isolated(file):0kB mapped:3712kB dirty:0kB writeback:0kB shmem:60584kB writeback_tmp:0kB kernel_stack:1200kB pagetables:252kB all_unreclaimable? no
>>>>> [   16.081526] DMA free:3041036kB boost:0kB min:6036kB low:9044kB high:12052kB reserved_highatomic:0KB active_anon:0kB inactive_anon:0kB active_file:0kB inactive_file:0kB unevictable:0kB writepending:0kB present:3145728kB managed:3029992kB mlocked:0kB bounce:0kB free_pcp:636kB local_pcp:0kB free_cma:28068kB
>>>>> [   16.108650] lowmem_reserve[]: 0 0 944 944
>>>>> [   16.112746] Normal free:866028kB boost:0kB min:1936kB low:2900kB high:3864kB reserved_highatomic:0KB active_anon:58416kB inactive_anon:3676kB active_file:0kB inactive_file:0kB unevictable:0kB writepending:0kB present:1048576kB managed:967352kB mlocked:0kB bounce:0kB free_pcp:3328kB local_pcp:864kB free_cma:0kB
>>>>> [   16.140393] lowmem_reserve[]: 0 0 0 0
>>>>> [   16.144133] DMA: 7*4kB (UMC) 4*8kB (M) 3*16kB (M) 3*32kB (MC) 5*64kB (M) 4*128kB (MC) 5*256kB (UMC) 7*512kB (UM) 5*1024kB (UM) 9*2048kB (UMC) 732*4096kB (MC) = 3027724kB
>>>>> [   16.159609] Normal: 149*4kB (UM) 95*8kB (UME) 26*16kB (UME) 8*32kB (ME) 2*64kB (UE) 1*128kB (M) 2*256kB (ME) 2*512kB (ME) 2*1024kB (UM) 0*2048kB 210*4096kB (M) = 866028kB
>>>>> [   16.175165] Node 0 hugepages_total=0 hugepages_free=0 hugepages_surp=0 hugepages_size=1048576kB
>>>>> [   16.183937] Node 0 hugepages_total=0 hugepages_free=0 hugepages_surp=0 hugepages_size=32768kB
>>>>> [   16.192533] Node 0 hugepages_total=0 hugepages_free=0 hugepages_surp=0 hugepages_size=2048kB
>>>>> [   16.201040] Node 0 hugepages_total=0 hugepages_free=0 hugepages_surp=0 hugepages_size=64kB
>>>>> [   16.209374] 15146 total pagecache pages
>>>>> [   16.213246] 0 pages in swap cache
>>>>> [   16.216595] Swap cache stats: add 0, delete 0, find 0/0
>>>>> [   16.221867] Free swap  = 0kB
>>>>> [   16.224780] Total swap = 0kB
>>>>> [   16.227693] 1048576 pages RAM
>>>>> [   16.230694] 0 pages HighMem/MovableOnly
>>>>> [   16.234564] 49240 pages reserved
>>>>> [   16.237825] 4096 pages cma reserved
>>>>>
>>>>> Some anomolies in the above are:
>>>>> free_cma:7017 with only 4096 pages cma reserved
>>>>> DMA free:3041036kB with only managed:3029992kB
>>>>>
>>>>> I'm not sure what is going on here, but I am suspicious of split_free_page() since del_page_from_free_list doesn't affect migrate_type accounting, but __free_one_page() can.
>>>>> Also PageBuddy(page) is being checked without zone->lock in isolate_single_pageblock().
>>>>>
>>>>> Please investigate this as well.
>>>>
>>>>
>>>> Can you try this patch https://lore.kernel.org/linux-mm/20220524194756.1698351-1-zi.yan@sent.com/
>>>> and see if it fixes the issue?
>>>>
>>>> Thanks.
>>>>
>>> The last hunk didn't apply directly to this commit, but I was able to apply the patch to linux-next/master with no improvement to the free memory accounting (actually anecdotaly worse):
>>>
>>> [    6.236828] sysrq: Show Memory
>>> [    6.239973] Mem-Info:
>>> [    6.242290] active_anon:14594 inactive_anon:924 isolated_anon:0
>>> [    6.242290]  active_file:0 inactive_file:0 isolated_file:0
>>> [    6.242290]  unevictable:0 dirty:0 writeback:0
>>> [    6.242290]  slab_reclaimable:3671 slab_unreclaimable:3575
>>> [    6.242290]  mapped:935 shmem:15147 pagetables:63 bounce:0
>>> [    6.242290]  kernel_misc_reclaimable:0
>>> [    6.242290]  free:1059009 free_pcp:1067 free_cma:90112
>>> [    6.278048] Node 0 active_anon:58376kB inactive_anon:3844kB active_file:0kB inactive_file:0kB unevictable:0kB isolated(anon):0kB isolated(file):0kB mapped:3740kB dirty:0kB writeback:0kB shmem:60588kB writeback_tmp:0kB kernel_stack:1216kB pagetables:252kB all_unreclaimable? no
>>> [    6.279422] arm-scmi brcm_scmi@0: timed out in resp(caller: scmi_perf_level_set+0xe0/0x110)
>>> [    6.302501] DMA free:3372200kB boost:0kB min:6032kB low:9040kB high:12048kB reserved_highatomic:0KB active_anon:0kB inactive_anon:0kB active_file:0kB inactive_file:0kB unevictable:0kB writepending:0kB present:3145728kB managed:3029800kB mlocked:0kB bounce:0kB free_pcp:636kB local_pcp:0kB free_cma:360448kB
>>> [    6.302515] lowmem_reserve[]: 0 0 944
>>> [    6.310894] cpufreq: __target_index: Failed to change cpu frequency: -110
>>> [    6.337920]  944
>>> [    6.337925] Normal free:863584kB boost:0kB min:1940kB low:2904kB high:3868kB reserved_highatomic:0KB active_anon:58376kB inactive_anon:3896kB active_file:0kB inactive_file:0kB unevictable:0kB writepending:0kB present:1048576kB managed:967352kB mlocked:0kB bounce:0kB free_pcp:3492kB local_pcp:828kB free_cma:0kB
>>> [    6.377782] lowmem_reserve[]: 0 0 0 0
>>> [    6.381461] DMA: 4*4kB (UM) 5*8kB (M) 3*16kB (M) 2*32kB (M) 6*64kB (M) 5*128kB (M) 6*256kB (UM) 5*512kB (UM) 4*1024kB (M) 10*2048kB (UMC) 732*4096kB (MC) = 3028136kB
>>> [    6.396324] Normal: 84*4kB (U) 94*8kB (UM) 260*16kB (UME) 149*32kB (UM) 99*64kB (UME) 39*128kB (UM) 12*256kB (U) 3*512kB (UME) 2*1024kB (UM) 0*2048kB 204*4096kB (M) = 863584kB
>>> [    6.412054] Node 0 hugepages_total=0 hugepages_free=0 hugepages_surp=0 hugepages_size=1048576kB
>>> [    6.420770] Node 0 hugepages_total=0 hugepages_free=0 hugepages_surp=0 hugepages_size=32768kB
>>> [    6.429312] Node 0 hugepages_total=0 hugepages_free=0 hugepages_surp=0 hugepages_size=2048kB
>>> [    6.437767] Node 0 hugepages_total=0 hugepages_free=0 hugepages_surp=0 hugepages_size=64kB
>>> [    6.446047] 15147 total pagecache pages
>>> [    6.449890] 0 pages in swap cache
>>> [    6.453210] Swap cache stats: add 0, delete 0, find 0/0
>>> [    6.458445] Free swap  = 0kB
>>> [    6.461331] Total swap = 0kB
>>> [    6.464217] 1048576 pages RAM
>>> [    6.467190] 0 pages HighMem/MovableOnly
>>> [    6.471032] 49288 pages reserved
>>> [    6.474267] 4096 pages cma reserved
>>>
>>> Regards,
>>>      Doug
>>
>> I will look into it. Thanks for reporting it.
> 
> Hi Doug,
> 
> Can you try the patch below? It takes out free pages under zone lock now
> and modifies page stats properly. Thanks.
> 
> 
> diff --git a/mm/internal.h b/mm/internal.h
> index 64e61b032dac..c0f8fbe0445b 100644
> --- a/mm/internal.h
> +++ b/mm/internal.h
> @@ -374,8 +374,8 @@ extern void *memmap_alloc(phys_addr_t size, phys_addr_t align,
>   			  phys_addr_t min_addr,
>   			  int nid, bool exact_nid);
> 
> -void split_free_page(struct page *free_page,
> -				int order, unsigned long split_pfn_offset);
> +int split_free_page(struct page *free_page,
> +			unsigned int order, unsigned long split_pfn_offset);
> 
>   #if defined CONFIG_COMPACTION || defined CONFIG_CMA
> 
> diff --git a/mm/page_alloc.c b/mm/page_alloc.c
> index bc93a82e51e6..6f6e4649ac21 100644
> --- a/mm/page_alloc.c
> +++ b/mm/page_alloc.c
> @@ -1100,30 +1100,44 @@ static inline void __free_one_page(struct page *page,
>    * @order:		the order of the page
>    * @split_pfn_offset:	split offset within the page
>    *
> + * Return -ENOENT if the free page is changed, otherwise 0
> + *
>    * It is used when the free page crosses two pageblocks with different migratetypes
>    * at split_pfn_offset within the page. The split free page will be put into
>    * separate migratetype lists afterwards. Otherwise, the function achieves
>    * nothing.
>    */
> -void split_free_page(struct page *free_page,
> -				int order, unsigned long split_pfn_offset)
> +int split_free_page(struct page *free_page,
> +			unsigned int order, unsigned long split_pfn_offset)
>   {
>   	struct zone *zone = page_zone(free_page);
>   	unsigned long free_page_pfn = page_to_pfn(free_page);
>   	unsigned long pfn;
>   	unsigned long flags;
>   	int free_page_order;
> +	int mt;
> +	int ret = 0;
> 
>   	if (split_pfn_offset == 0)
> -		return;
> +		return ret;
> 
>   	spin_lock_irqsave(&zone->lock, flags);
> +
> +	if (!PageBuddy(free_page) || buddy_order(free_page) != order) {
> +		ret = -ENOENT;
> +		goto out;
> +	}
> +
> +	mt = get_pageblock_migratetype(free_page);
> +	if (likely(!is_migrate_isolate(mt)))
> +		__mod_zone_freepage_state(zone, -(1UL << order), mt);
> +
>   	del_page_from_free_list(free_page, zone, order);
>   	for (pfn = free_page_pfn;
>   	     pfn < free_page_pfn + (1UL << order);) {
>   		int mt = get_pfnblock_migratetype(pfn_to_page(pfn), pfn);
> 
> -		free_page_order = min_t(int,
> +		free_page_order = min_t(unsigned int,
>   					pfn ? __ffs(pfn) : order,
>   					__fls(split_pfn_offset));
This part of the patch doesn't agree with any version of page_alloc.c I 
have, but I was able to manually apply the change.


>   		__free_one_page(pfn_to_page(pfn), pfn, zone, free_page_order,
> @@ -1134,7 +1148,9 @@ void split_free_page(struct page *free_page,
>   		if (split_pfn_offset == 0)
>   			split_pfn_offset = (1UL << order) - (pfn - free_page_pfn);
>   	}
> +out:
>   	spin_unlock_irqrestore(&zone->lock, flags);
> +	return ret;
>   }
>   /*
>    * A bad page could be due to a number of fields. Instead of multiple branches,
> diff --git a/mm/page_isolation.c b/mm/page_isolation.c
> index c643c8420809..f539ccf7fb44 100644
> --- a/mm/page_isolation.c
> +++ b/mm/page_isolation.c
> @@ -300,7 +300,7 @@ __first_valid_page(unsigned long pfn, unsigned long nr_pages)
>    * the in-use page then splitting the free page.
>    */
>   static int isolate_single_pageblock(unsigned long boundary_pfn, int flags,
> -			gfp_t gfp_flags, bool isolate_before)
> +			gfp_t gfp_flags, bool isolate_before, bool skip_isolation)
>   {
>   	unsigned char saved_mt;
>   	unsigned long start_pfn;
> @@ -327,11 +327,16 @@ static int isolate_single_pageblock(unsigned long boundary_pfn, int flags,
>   				      zone->zone_start_pfn);
> 
>   	saved_mt = get_pageblock_migratetype(pfn_to_page(isolate_pageblock));
> -	ret = set_migratetype_isolate(pfn_to_page(isolate_pageblock), saved_mt, flags,
> -			isolate_pageblock, isolate_pageblock + pageblock_nr_pages);
> 
> -	if (ret)
> -		return ret;
> +	if (skip_isolation)
> +		VM_BUG_ON(!is_migrate_isolate(saved_mt));
> +	else {
> +		ret = set_migratetype_isolate(pfn_to_page(isolate_pageblock), saved_mt, flags,
> +				isolate_pageblock, isolate_pageblock + pageblock_nr_pages);
> +
> +		if (ret)
> +			return ret;
> +	}
> 
>   	/*
>   	 * Bail out early when the to-be-isolated pageblock does not form
> @@ -367,8 +372,11 @@ static int isolate_single_pageblock(unsigned long boundary_pfn, int flags,
>   			int order = buddy_order(page);
> 
>   			if (pfn + (1UL << order) > boundary_pfn)
> -				split_free_page(page, order, boundary_pfn - pfn);
> -			pfn += (1UL << order);
> +				/* free page changed before split, check it again */
> +				if (split_free_page(page, order, boundary_pfn - pfn))
> +				    continue;
> +
> +			pfn += 1UL << order;
>   			continue;
>   		}
>   		/*
> @@ -463,7 +471,8 @@ static int isolate_single_pageblock(unsigned long boundary_pfn, int flags,
>   	return 0;
>   failed:
>   	/* restore the original migratetype */
> -	unset_migratetype_isolate(pfn_to_page(isolate_pageblock), saved_mt);
> +	if (!skip_isolation)
> +		unset_migratetype_isolate(pfn_to_page(isolate_pageblock), saved_mt);
>   	return -EBUSY;
>   }
> 
> @@ -522,14 +531,18 @@ int start_isolate_page_range(unsigned long start_pfn, unsigned long end_pfn,
>   	unsigned long isolate_start = ALIGN_DOWN(start_pfn, pageblock_nr_pages);
>   	unsigned long isolate_end = ALIGN(end_pfn, pageblock_nr_pages);
>   	int ret;
> +	bool skip_isolation = false;
> 
>   	/* isolate [isolate_start, isolate_start + pageblock_nr_pages) pageblock */
> -	ret = isolate_single_pageblock(isolate_start, flags, gfp_flags, false);
> +	ret = isolate_single_pageblock(isolate_start, flags, gfp_flags, false, skip_isolation);
>   	if (ret)
>   		return ret;
> 
> +	if (isolate_start == isolate_end - pageblock_nr_pages)
> +		skip_isolation = true;
> +
>   	/* isolate [isolate_end - pageblock_nr_pages, isolate_end) pageblock */
> -	ret = isolate_single_pageblock(isolate_end, flags, gfp_flags, true);
> +	ret = isolate_single_pageblock(isolate_end, flags, gfp_flags, true, skip_isolation);
>   	if (ret) {
>   		unset_migratetype_isolate(pfn_to_page(isolate_start), migratetype);
>   		return ret;
> 
> 
> --
> Best Regards,
> Yan, Zi

This patch does appear to fix the problem I observed. I'll poke it a 
little more, but so far it looks good.

Thanks!,
     Doug
