Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C6479539672
	for <lists+linux-kernel@lfdr.de>; Tue, 31 May 2022 20:44:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347082AbiEaSoU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 May 2022 14:44:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53696 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238198AbiEaSoQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 May 2022 14:44:16 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id C2084B7B
        for <linux-kernel@vger.kernel.org>; Tue, 31 May 2022 11:44:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1654022653;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ErJHM8tap1ZcL/SnaxNJvSXd4WthGzPsYfd+ht5Uyq4=;
        b=A45X45lRhGK8GUc9tN09UmFDNEV+W8NjnEPY7DtHAOuecA0arcLmcxqdzmQ7euN3oCAbTt
        4Gml6/bTecatt45sQodtu6EyHc4s2eX4rPaocNZRQNS2XkCpuugT38kH2A24iP+91lJ7Gh
        UwNaMaoaM6LMR+uFQo/DaddBjksW9mQ=
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com
 [209.85.160.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-628-QRAaR6NbNjWNMwvupZszQA-1; Tue, 31 May 2022 14:44:10 -0400
X-MC-Unique: QRAaR6NbNjWNMwvupZszQA-1
Received: by mail-qt1-f197.google.com with SMTP id u2-20020ac80502000000b002f94701339eso12896532qtg.13
        for <linux-kernel@vger.kernel.org>; Tue, 31 May 2022 11:44:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:references:from:in-reply-to
         :content-transfer-encoding;
        bh=ErJHM8tap1ZcL/SnaxNJvSXd4WthGzPsYfd+ht5Uyq4=;
        b=OxB/osB6T4v7zA6ciSctihKKaB0YCW8wIUrTLyAuZqCAqAFGqwLx5mC8sBQH0ZbOdU
         JcTTNcCzCeqQbhKyuDwaYySgayBIm7lznqagOY4Du1UBnfcFS65E6fVh8mvwSAie+h6V
         i7n6RqzzudxRWOhQLY5V4jhVEp5py2v+HCnT/W+7QWwM3RLz6Zm8Rz/CxKeIKE7YyXJ/
         6CitOUU0AbKbm/03VsCJcO0qXjPrZx/uo4+zteLpdOxe967WvSoQ4dcMflBnFgOn/L5/
         cUOQkR1RyV/BxfCHUuBy7X9Rhy+fD+EjINX/hiHxRZfzX+7SGgEndzu3V+LdbEYrbuiK
         4f/w==
X-Gm-Message-State: AOAM530OvObYkT/1mLGnv0hOF2pi5TuVq/Ue4z/INE7K/zapEasPXzu3
        bNUfDFkFWJgqgp1f+Pz5q5jfKBQBFifBFWvi+SJk+isS3ySMaftmjRmmh6JnzAt6mlyWjkaESt3
        AqHkBOFyYzjNVhNbBwAtGxjW/
X-Received: by 2002:a05:6214:238d:b0:461:d89a:e1f3 with SMTP id fw13-20020a056214238d00b00461d89ae1f3mr51710920qvb.118.1654022649769;
        Tue, 31 May 2022 11:44:09 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwpDfsnGzgsPeH60rbVEh5JBB+zSG0hZmXkCL57ItNlcHcZoKWqOdk0Fi0pScnxi0iep3yuwA==
X-Received: by 2002:a05:6214:238d:b0:461:d89a:e1f3 with SMTP id fw13-20020a056214238d00b00461d89ae1f3mr51710898qvb.118.1654022649310;
        Tue, 31 May 2022 11:44:09 -0700 (PDT)
Received: from [192.168.1.86] (pool-173-48-131-43.bstnma.fios.verizon.net. [173.48.131.43])
        by smtp.gmail.com with ESMTPSA id h4-20020ac85144000000b002ffad31c4easm6576935qtn.50.2022.05.31.11.44.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 31 May 2022 11:44:08 -0700 (PDT)
Message-ID: <57a826ad-5ceb-ba1d-b80c-452f72720889@redhat.com>
Date:   Tue, 31 May 2022 14:44:07 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.0
Subject: Re: [PATCH v4 00/12] perf c2c: Support display for Arm64
Content-Language: en-US
To:     Leo Yan <leo.yan@linaro.org>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>, Alyssa Ross <hi@alyssa.is>,
        Ian Rogers <irogers@google.com>, Like Xu <likexu@tencent.com>,
        Kajol Jain <kjain@linux.ibm.com>,
        Li Huafei <lihuafei1@huawei.com>,
        Adam Li <adam.li@amperecomputing.com>,
        German Gomez <german.gomez@arm.com>,
        James Clark <james.clark@arm.com>,
        Ali Saidi <alisaidi@amazon.com>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20220530114036.3225544-1-leo.yan@linaro.org>
From:   Joe Mario <jmario@redhat.com>
In-Reply-To: <20220530114036.3225544-1-leo.yan@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 5/30/22 7:40 AM, Leo Yan wrote:
> Arm64 Neoverse CPUs supports data source in Arm SPE trace, this allows
> us to detect cache line contention and transfers.
> 
> This patch set is based on Ali Said's patch set v9 "perf: arm-spe: Decode SPE
> source and use for perf c2c" [1] and Ali's patch set doesn't need any
> change in this new round.
> 
> To clearly show peer loads and express the local peer loads and remote
> peer lodes, this patch introduces three new metrics 'lcl_peer',
> 'rmt_peer' and 'tot_peer'.  The display 'peer' mode uses metric
> 'tot_peer' for sorting cache lines.
> 
> Patches 01-05 adds statistics for memory samples, and add dimensions for
> peer metrics.
> 
> Patches 06-09 are for refactoring, it refines the code with more general
> naming so this can allow us to easier to extend display modes but not
> strictly bound to HITM tags.
> 
> Patches 10-11 are to extend display 'peer' mode, and also changes to use
> 'peer' mode as default mode for Arm64 arches.
> 
> Patch 12 updates document to describe the new dimensions for peer
> metrics.
> 
> This patch set has been verified for both x86 and Arm64 memory samples.
> 
> Known issues:  Joe reminded there have an issue in patch set v3 that the
> cache line metric shows 'N/A' for node, this is because Arm SPE trace
> data doesn't contain physical address and leads to perf c2c tool fails
> to find matched node range if physical address is zero.  This issue is
> addressed in a separte patch [2].  Since I am still using the old
> perf data file (I have no Neoverse platforms), the output result still
> shows the Node field is 'N/A'.
> 

Hi Leo:
I built a new perf with your patches and ran it on a 2-numa node Neoverse platform.
I then ran my simple test that creates reader and writer threads to tug on the same cacheline.
The c2c output is appended below.

The output looks good, especially where you've broken out the (average) cycles for local and remote peer loads.  
And I'm glad to see you fixed the "Node" column.  I use that a lot to help detect remote node accesses.  
And the "PA cnt" field is working as well,  which is important to see if numa_balance is moving the data around.

=================================================
           Shared Data Cache Line Table
=================================================
#
#        ----------- Cacheline ----------     Peer  ------- Load Peer -------    Total    Total    Total  --------- Stores --------  ----- Core Load Hit -----  - LLC Load Hit --  - RMT Load Hit --  --- Load Dram ----
# Index             Address  Node  PA cnt    Snoop    Total    Local   Remote  records    Loads   Stores    L1Hit   L1Miss      N/A       FB       L1       L2    LclHit  LclHitm    RmtHit  RmtHitm       Lcl       Rmt
# .....  ..................  ....  ......  .......  .......  .......  .......  .......  .......  .......  .......  .......  .......  .......  .......  .......  ........  .......  ........  .......  ........  ........
#
      0            0x422140     0    6904   74.86%      137      131        6   148008   144970     3038        0        0     3038        0   144833      120        11        0         6        0         0         0
      1  0xffffd976e63ae5c0     1       6    3.83%        7        7        0       15       15        0        0        0        0        0        8        4         3        0         0        0         0         0
      2  0xffff07ffbf290980     0       5    2.19%        4        2        2       14       14        0        0        0        0        0       10        1         1        0         2        0         0         0
      3  0xffffd976e57275c0     1       1    0.55%        1        1        0        1        1        0        0        0        0        0        0        1         0        0         0        0         0         0
      4  0xffffd976e6071c00     1       3    0.55%        1        0        1        4        4        0        0        0        0        0        3        0         0        0         1        0         0         0
     [snip]
=================================================
      Shared Cache Line Distribution Pareto
=================================================
#
#        -- Peer Snoop --  ------- Store Refs ------  --------- Data address ---------                      ---------- cycles ----------    Total       cpu                               Shared
#   Num      Rmt      Lcl   L1 Hit  L1 Miss      N/A              Offset  Node  PA cnt        Code address  rmt peer  lcl peer      load  records       cnt                      Symbol   Object                Source:Line  Node
# .....  .......  .......  .......  .......  .......  ..................  ....  ......  ..................  ........  ........  ........  .......  ........  ..........................  .......  .........................  ....
#
  ----------------------------------------------------------------------
      0        6      131        0        0     3038            0x422140
  ----------------------------------------------------------------------
           0.00%    0.00%    0.00%    0.00%   52.60%                 0x8     0       1            0x400e6c         0         0         0     1598         4  [.] writer                  tugtest  tugtest.c:152               0 1
           0.00%    0.00%    0.00%    0.00%   47.40%                0x10     0       1            0x400e7c         0         0         0     1440         4  [.] writer                  tugtest  tugtest.c:153               0 1
          33.33%   75.57%    0.00%    0.00%    0.00%                0x20     0       1            0x401018      4095      3803      3419      409         4  [.] reader                  tugtest  tugtest.c:187               0 1
          66.67%   24.43%    0.00%    0.00%    0.00%                0x28     0       1            0x401034      4095      3470      3643      413         4  [.] reader                  tugtest  tugtest.c:187               0 1

  ----------------------------------------------------------------------
      1        0        7        0        0        0  0xffffd976e63ae5c0
  ----------------------------------------------------------------------
           0.00%   57.14%    0.00%    0.00%    0.00%                 0x0     1       1  0xffffd976e4815fbc         0      1333         0        4         2  [k] ktime_get                   [kernel.kallsyms]  seqlock.h:276          1                   
           0.00%   14.29%    0.00%    0.00%    0.00%                 0x0     1       1  0xffffd976e4816d10         0       266       794        4         3  [k] ktime_get_update_offsets_n  [kernel.kallsyms]  seqlock.h:276        0 1
           0.00%   28.57%    0.00%    0.00%    0.00%                0x30     1       1  0xffffd976e4816d20         0        87       150        4         3  [k] ktime_get_update_offsets_n  [kernel.kallsyms]  timekeeping.c:2298   0 1
  
  ----------------------------------------------------------------------     
      2        2        2        0        0        0  0xffff07ffbf290980
  ----------------------------------------------------------------------
          50.00%  100.00%    0.00%    0.00%    0.00%                 0x4     0       1  0xffffd976e47d2bdc      1217      1600      1147        4         3  [k] queued_spin_lock_slowpath  [kernel.kallsyms]  qspinlock.c:511    0 1
          50.00%    0.00%    0.00%    0.00%    0.00%                 0x4     0       1  0xffffd976e47d2a2c      4033         0         0        1         1  [k] queued_spin_lock_slowpath  [kernel.kallsyms]  qspinlock.c:382    0 1
  
  ----------------------------------------------------------------------     

Thanks for doing this.  It looks good.
I'll assume someone else is reviewing your code changes.

Joe

> Another thing is we need to enhance data source setting for old Arm
> platforms.  As discussed, German would follow up this task later.
> 
> The latest patch set has been uploaded on the git server [3].
> 
> The display result with x86 memory samples:
> 
>   =================================================
>              Shared Data Cache Line Table          
>   =================================================
>   #
>   #        ----------- Cacheline ----------      Tot  ------- Load Hitm -------    Total    Total    Total  --------- Stores --------  ----- Core Load Hit -----  - LLC Load Hit --  - RMT Load Hit --  --- Load Dram ----
>   # Index             Address  Node  PA cnt     Hitm    Total  LclHitm  RmtHitm  records    Loads   Stores    L1Hit   L1Miss      N/A       FB       L1       L2    LclHit  LclHitm    RmtHit  RmtHitm       Lcl       Rmt
>   # .....  ..................  ....  ......  .......  .......  .......  .......  .......  .......  .......  .......  .......  .......  .......  .......  .......  ........  .......  ........  .......  ........  ........
>   #
>         0      0x55c8971f0080     0    1967   66.14%      252      252        0     6044     3550     2494     2024      470        0      528     2672       78        20      252         0        0         0         0
>         1      0x55c8971f00c0     0       1   33.86%      129      129        0      914      914        0        0        0        0      272      374       52        87      129         0        0         0         0
> 
>   =================================================
>         Shared Cache Line Distribution Pareto      
>   =================================================
>   #
>   #        ----- HITM -----  ------- Store Refs ------  --------- Data address ---------                      ---------- cycles ----------    Total       cpu                                     Shared                               
>   #   Num  RmtHitm  LclHitm   L1 Hit  L1 Miss      N/A              Offset  Node  PA cnt        Code address  rmt hitm  lcl hitm      load  records       cnt                  Symbol             Object              Source:Line  Node
>   # .....  .......  .......  .......  .......  .......  ..................  ....  ......  ..................  ........  ........  ........  .......  ........  ......................  .................  .......................  ....
>   #
>     ----------------------------------------------------------------------
>         0        0      252     2024      470        0      0x55c8971f0080
>     ----------------------------------------------------------------------
>              0.00%   12.30%    0.00%    0.00%    0.00%                 0x0     0       1      0x55c8971ed3e9         0      1313       863     1222         3  [.] 0x00000000000013e9  false_sharing.exe  false_sharing.exe[13e9]   0
>              0.00%    0.79%   90.51%    0.00%    0.00%                 0x0     0       1      0x55c8971ed3e2         0      1800       878     3029         3  [.] 0x00000000000013e2  false_sharing.exe  false_sharing.exe[13e2]   0
>              0.00%    0.00%    9.49%  100.00%    0.00%                 0x0     0       1      0x55c8971ed3f4         0         0         0      662         3  [.] 0x00000000000013f4  false_sharing.exe  false_sharing.exe[13f4]   0
>              0.00%   86.90%    0.00%    0.00%    0.00%                0x20     0       1      0x55c8971ed447         0       141       103     1131         2  [.] 0x0000000000001447  false_sharing.exe  false_sharing.exe[1447]   0
> 
>     ----------------------------------------------------------------------
>         1        0      129        0        0        0      0x55c8971f00c0
>     ----------------------------------------------------------------------
>              0.00%  100.00%    0.00%    0.00%    0.00%                0x20     0       1      0x55c8971ed455         0        88        94      914         2  [.] 0x0000000000001455  false_sharing.exe  false_sharing.exe[1455]   0
> 
> 
> The display result with Arm SPE:
> 
>   =================================================
>              Shared Data Cache Line Table          
>   =================================================
>   #
>   #        ----------- Cacheline ----------     Peer  ------- Load Peer -------    Total    Total    Total  --------- Stores --------  ----- Core Load Hit -----  - LLC Load Hit --  - RMT Load Hit --  --- Load Dram ----
>   # Index             Address  Node  PA cnt    Snoop    Total    Local   Remote  records    Loads   Stores    L1Hit   L1Miss      N/A       FB       L1       L2    LclHit  LclHitm    RmtHit  RmtHitm       Lcl       Rmt
>   # .....  ..................  ....  ......  .......  .......  .......  .......  .......  .......  .......  .......  .......  .......  .......  .......  .......  ........  .......  ........  .......  ........  ........
>   #
>         0      0xaaaac17d6000   N/A       0  100.00%       99       99        0    18851    18851        0        0        0        0        0    18752        0        99        0         0        0         0         0
> 
>   =================================================
>         Shared Cache Line Distribution Pareto      
>   =================================================
>   #
>   #        -- Peer Snoop --  ------- Store Refs ------  --------- Data address ---------                      ---------- cycles ----------    Total       cpu                                    Shared                       
>   #   Num      Rmt      Lcl   L1 Hit  L1 Miss      N/A              Offset  Node  PA cnt        Code address  rmt peer  lcl peer      load  records       cnt                  Symbol            Object      Source:Line  Node{cpus %peers %stores}
>   # .....  .......  .......  .......  .......  .......  ..................  ....  ......  ..................  ........  ........  ........  .......  ........  ......................  ................  ...............  ....
>   #
>     ----------------------------------------------------------------------
>         0        0       99        0        0        0      0xaaaac17d6000
>     ----------------------------------------------------------------------
>              0.00%    6.06%    0.00%    0.00%    0.00%                0x20   N/A       0      0xaaaac17c25ac         0       375        43    18469         2  [.] 0x00000000000025ac  memstress         memstress[25ac]   0{ 2 100.0%    n/a}
>              0.00%   93.94%    0.00%    0.00%    0.00%                0x29   N/A       0      0xaaaac17c3e88         0       180       173      135         2  [.] 0x0000000000003e88  memstress         memstress[3e88]   0{ 2 100.0%    n/a}
> 
> 
> Changes from v3:
> * Changed to display remote and local peer accesses (Joe);
> * Fixed the usage info for display types (Joe);
> * Do not display HITM dimensions when use 'peer' display, and HITM
>   display doesn't show any 'peer' dimensions (James);
> * Split to smaller patches for adding dimensions of peer operations;
> * Updated documentation to reflect the latest GUI and stdio.
> 
> Changes from v2:
> * Updated patch 04 to account metrics for both cache level and ld_peer
>   for PEER flag;
> * Updated document for metric 'rmt_hit' which is accounted for all
>   remote accesses (include remote DRAM and any upward caches).
> 
> Changes from v1:
> * Updated patches 01, 02 and 03 to support 'N/A' metrics for store
>   operations, so can align with the patch set [1] for store samples.
> 
> 
> [1] https://lore.kernel.org/lkml/20220517020326.18580-1-alisaidi@amazon.com/
> [2] https://lore.kernel.org/lkml/20220530083645.253432-1-leo.yan@linaro.org/
> [3] https://git.linaro.org/people/leo.yan/linux-spe.git/ branch: perf_c2c_arm_spe_peer_v4
> 
> 
> Leo Yan (12):
>   perf mem: Add statistics for peer snooping
>   perf c2c: Output statistics for peer snooping
>   perf c2c: Add dimensions for peer load operations
>   perf c2c: Add dimensions of peer metrics for cache line view
>   perf c2c: Add mean dimensions for peer operations
>   perf c2c: Use explicit names for display macros
>   perf c2c: Rename dimension from 'percent_hitm' to
>     'percent_costly_snoop'
>   perf c2c: Refactor node header
>   perf c2c: Refactor display string
>   perf c2c: Sort on peer snooping for load operations
>   perf c2c: Use 'peer' as default display for Arm64
>   perf c2c: Update documentation for new display option 'peer'
> 
>  tools/perf/Documentation/perf-c2c.txt |  30 +-
>  tools/perf/builtin-c2c.c              | 454 ++++++++++++++++++++------
>  tools/perf/util/mem-events.c          |  28 +-
>  tools/perf/util/mem-events.h          |   3 +
>  4 files changed, 403 insertions(+), 112 deletions(-)
> 

