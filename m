Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 919F553458E
	for <lists+linux-kernel@lfdr.de>; Wed, 25 May 2022 23:03:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239882AbiEYVDM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 May 2022 17:03:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50578 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230399AbiEYVDK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 May 2022 17:03:10 -0400
Received: from mail-pl1-x633.google.com (mail-pl1-x633.google.com [IPv6:2607:f8b0:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 94535BA982
        for <linux-kernel@vger.kernel.org>; Wed, 25 May 2022 14:03:08 -0700 (PDT)
Received: by mail-pl1-x633.google.com with SMTP id n18so19612899plg.5
        for <linux-kernel@vger.kernel.org>; Wed, 25 May 2022 14:03:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=4yi/odO3U4kNlVXavh9YaiqkpAbDEL9PGgt9BJ6Eb8Q=;
        b=Vz6S963og48uB2c+jTnfRxJcPwIoPFdXytuNOKs1bzlbUESS2ZuuN+xOOUu+FrcBtZ
         O98puyg6CQWJihTqR+bJlVWdmvx1ic2g7PcDGqnC27Z/vZMntqe75CoSyM5FriTqEOyC
         sxLnNc/RfeXsA8JItScLO3r3CV3WLpzNDRol6qHPuHCXpTMyudHd16SOAPWGSGpentjg
         /MSX7gshe3lv5CFQTWnThUtUcdlxeaIdAkctwFclsFdVaUi1gSh9mbbqpeuYJH93CY3M
         o4tk0lIrvFScpZvFF0tFMo4tBNfijDGig4zpyQ3Fp0jaQUqWiAi66+AkCqgIASXdQjp9
         /XoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=4yi/odO3U4kNlVXavh9YaiqkpAbDEL9PGgt9BJ6Eb8Q=;
        b=nf0t8a9G4djail5zPeZcMS1vBRjDzL4ZQ1H/gqUGRlIAZ9fMbg5LsRN9iQ3DXHBI1L
         SqSjsLHiMm9rVPOIRTT3gya00r81qsxFgwv8q/kqoKt0ZV162kC2JK2rcDHHbORb4nBk
         aX9fV9PbI+W7RgQdCYkJGNMNj6z4CqwIlRlcAfbajesdvHD+iezzAYUDoh/BJ1vPj/q6
         VZBKm3BhheRV0Cn/Zjc+Y807srUsXCK3VLNJnNkeh6ykQ/7iJ7BeDaqPIUmSkMFoBDsX
         C7VcqpX+7pV4Xiv9dYEt3+DlW8Ywpz7k2ej+sZgfcLFmi3WyD8Sz+oU9uCImTfCUR52Z
         e3IA==
X-Gm-Message-State: AOAM532yRYW1HCAw3/MVZ9G2UTSXZblEWp1xSY2pLFQFObPFvsLWvIis
        KhfjAUiiRwTqY7YavP6akm4=
X-Google-Smtp-Source: ABdhPJz5u/wu5Zf8O/J31HTkyC/sTM8k9Sfrvjdo9Wk0wRiPqXqQGWyEIr+v6ePfsPVyt0G6RQkR5g==
X-Received: by 2002:a17:902:f647:b0:15f:3408:60e8 with SMTP id m7-20020a170902f64700b0015f340860e8mr33999046plg.82.1653512588013;
        Wed, 25 May 2022 14:03:08 -0700 (PDT)
Received: from [192.168.1.50] (ip70-191-40-110.oc.oc.cox.net. [70.191.40.110])
        by smtp.gmail.com with ESMTPSA id t2-20020a170902e84200b001618fee3900sm10002136plg.196.2022.05.25.14.03.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 25 May 2022 14:03:07 -0700 (PDT)
Message-ID: <fcac3340-31b5-8536-fd4e-ecb8a9aee2ae@gmail.com>
Date:   Wed, 25 May 2022 14:03:05 -0700
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
From:   Doug Berger <opendmb@gmail.com>
In-Reply-To: <F80CEC0E-0EA8-4210-8730-57D4D0CF0B23@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/25/2022 10:53 AM, Zi Yan wrote:
> On 25 May 2022, at 13:41, Doug Berger wrote:
> 
>> I am seeing some free memory accounting problems with linux-next that I have bisected to this commit (i.e. b2c9e2fbba32 ("mm: make alloc_contig_range work at pageblock granularity").
>>
>> On an arm64 SMP platform with 4GB total memory and the default 16MB default CMA pool, I am seeing the following after boot with a sysrq Show Memory (e.g. 'echo m > /proc/sysrq-trigger'):
>>
>> [   16.015906] sysrq: Show Memory
>> [   16.019039] Mem-Info:
>> [   16.021348] active_anon:14604 inactive_anon:919 isolated_anon:0
>> [   16.021348]  active_file:0 inactive_file:0 isolated_file:0
>> [   16.021348]  unevictable:0 dirty:0 writeback:0
>> [   16.021348]  slab_reclaimable:3662 slab_unreclaimable:3333
>> [   16.021348]  mapped:928 shmem:15146 pagetables:63 bounce:0
>> [   16.021348]  kernel_misc_reclaimable:0
>> [   16.021348]  free:976766 free_pcp:991 free_cma:7017
>> [   16.056937] Node 0 active_anon:58416kB inactive_anon:3676kB active_file:0kB inactive_file:0kB unevictable:0kB isolated(anon):0kB isolated(file):0kB mapped:3712kB dirty:0kB writeback:0kB shmem:60584kB writeback_tmp:0kB kernel_stack:1200kB pagetables:252kB all_unreclaimable? no
>> [   16.081526] DMA free:3041036kB boost:0kB min:6036kB low:9044kB high:12052kB reserved_highatomic:0KB active_anon:0kB inactive_anon:0kB active_file:0kB inactive_file:0kB unevictable:0kB writepending:0kB present:3145728kB managed:3029992kB mlocked:0kB bounce:0kB free_pcp:636kB local_pcp:0kB free_cma:28068kB
>> [   16.108650] lowmem_reserve[]: 0 0 944 944
>> [   16.112746] Normal free:866028kB boost:0kB min:1936kB low:2900kB high:3864kB reserved_highatomic:0KB active_anon:58416kB inactive_anon:3676kB active_file:0kB inactive_file:0kB unevictable:0kB writepending:0kB present:1048576kB managed:967352kB mlocked:0kB bounce:0kB free_pcp:3328kB local_pcp:864kB free_cma:0kB
>> [   16.140393] lowmem_reserve[]: 0 0 0 0
>> [   16.144133] DMA: 7*4kB (UMC) 4*8kB (M) 3*16kB (M) 3*32kB (MC) 5*64kB (M) 4*128kB (MC) 5*256kB (UMC) 7*512kB (UM) 5*1024kB (UM) 9*2048kB (UMC) 732*4096kB (MC) = 3027724kB
>> [   16.159609] Normal: 149*4kB (UM) 95*8kB (UME) 26*16kB (UME) 8*32kB (ME) 2*64kB (UE) 1*128kB (M) 2*256kB (ME) 2*512kB (ME) 2*1024kB (UM) 0*2048kB 210*4096kB (M) = 866028kB
>> [   16.175165] Node 0 hugepages_total=0 hugepages_free=0 hugepages_surp=0 hugepages_size=1048576kB
>> [   16.183937] Node 0 hugepages_total=0 hugepages_free=0 hugepages_surp=0 hugepages_size=32768kB
>> [   16.192533] Node 0 hugepages_total=0 hugepages_free=0 hugepages_surp=0 hugepages_size=2048kB
>> [   16.201040] Node 0 hugepages_total=0 hugepages_free=0 hugepages_surp=0 hugepages_size=64kB
>> [   16.209374] 15146 total pagecache pages
>> [   16.213246] 0 pages in swap cache
>> [   16.216595] Swap cache stats: add 0, delete 0, find 0/0
>> [   16.221867] Free swap  = 0kB
>> [   16.224780] Total swap = 0kB
>> [   16.227693] 1048576 pages RAM
>> [   16.230694] 0 pages HighMem/MovableOnly
>> [   16.234564] 49240 pages reserved
>> [   16.237825] 4096 pages cma reserved
>>
>> Some anomolies in the above are:
>> free_cma:7017 with only 4096 pages cma reserved
>> DMA free:3041036kB with only managed:3029992kB
>>
>> I'm not sure what is going on here, but I am suspicious of split_free_page() since del_page_from_free_list doesn't affect migrate_type accounting, but __free_one_page() can.
>> Also PageBuddy(page) is being checked without zone->lock in isolate_single_pageblock().
>>
>> Please investigate this as well.
> 
> 
> Can you try this patch https://lore.kernel.org/linux-mm/20220524194756.1698351-1-zi.yan@sent.com/
> and see if it fixes the issue?
> 
> Thanks.
> 
The last hunk didn't apply directly to this commit, but I was able to 
apply the patch to linux-next/master with no improvement to the free 
memory accounting (actually anecdotaly worse):

[    6.236828] sysrq: Show Memory
[    6.239973] Mem-Info:
[    6.242290] active_anon:14594 inactive_anon:924 isolated_anon:0
[    6.242290]  active_file:0 inactive_file:0 isolated_file:0
[    6.242290]  unevictable:0 dirty:0 writeback:0
[    6.242290]  slab_reclaimable:3671 slab_unreclaimable:3575
[    6.242290]  mapped:935 shmem:15147 pagetables:63 bounce:0
[    6.242290]  kernel_misc_reclaimable:0
[    6.242290]  free:1059009 free_pcp:1067 free_cma:90112
[    6.278048] Node 0 active_anon:58376kB inactive_anon:3844kB 
active_file:0kB inactive_file:0kB unevictable:0kB isolated(anon):0kB 
isolated(file):0kB mapped:3740kB dirty:0kB writeback:0kB shmem:60588kB 
writeback_tmp:0kB kernel_stack:1216kB pagetables:252kB all_unreclaimable? no
[    6.279422] arm-scmi brcm_scmi@0: timed out in resp(caller: 
scmi_perf_level_set+0xe0/0x110)
[    6.302501] DMA free:3372200kB boost:0kB min:6032kB low:9040kB 
high:12048kB reserved_highatomic:0KB active_anon:0kB inactive_anon:0kB 
active_file:0kB inactive_file:0kB unevictable:0kB writepending:0kB 
present:3145728kB managed:3029800kB mlocked:0kB bounce:0kB 
free_pcp:636kB local_pcp:0kB free_cma:360448kB
[    6.302515] lowmem_reserve[]: 0 0 944
[    6.310894] cpufreq: __target_index: Failed to change cpu frequency: -110
[    6.337920]  944
[    6.337925] Normal free:863584kB boost:0kB min:1940kB low:2904kB 
high:3868kB reserved_highatomic:0KB active_anon:58376kB 
inactive_anon:3896kB active_file:0kB inactive_file:0kB unevictable:0kB 
writepending:0kB present:1048576kB managed:967352kB mlocked:0kB 
bounce:0kB free_pcp:3492kB local_pcp:828kB free_cma:0kB
[    6.377782] lowmem_reserve[]: 0 0 0 0
[    6.381461] DMA: 4*4kB (UM) 5*8kB (M) 3*16kB (M) 2*32kB (M) 6*64kB 
(M) 5*128kB (M) 6*256kB (UM) 5*512kB (UM) 4*1024kB (M) 10*2048kB (UMC) 
732*4096kB (MC) = 3028136kB
[    6.396324] Normal: 84*4kB (U) 94*8kB (UM) 260*16kB (UME) 149*32kB 
(UM) 99*64kB (UME) 39*128kB (UM) 12*256kB (U) 3*512kB (UME) 2*1024kB 
(UM) 0*2048kB 204*4096kB (M) = 863584kB
[    6.412054] Node 0 hugepages_total=0 hugepages_free=0 
hugepages_surp=0 hugepages_size=1048576kB
[    6.420770] Node 0 hugepages_total=0 hugepages_free=0 
hugepages_surp=0 hugepages_size=32768kB
[    6.429312] Node 0 hugepages_total=0 hugepages_free=0 
hugepages_surp=0 hugepages_size=2048kB
[    6.437767] Node 0 hugepages_total=0 hugepages_free=0 
hugepages_surp=0 hugepages_size=64kB
[    6.446047] 15147 total pagecache pages
[    6.449890] 0 pages in swap cache
[    6.453210] Swap cache stats: add 0, delete 0, find 0/0
[    6.458445] Free swap  = 0kB
[    6.461331] Total swap = 0kB
[    6.464217] 1048576 pages RAM
[    6.467190] 0 pages HighMem/MovableOnly
[    6.471032] 49288 pages reserved
[    6.474267] 4096 pages cma reserved

Regards,
     Doug
