Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0AF8453A280
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Jun 2022 12:25:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351853AbiFAKZW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Jun 2022 06:25:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56836 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352058AbiFAKZN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Jun 2022 06:25:13 -0400
Received: from mail-pf1-x42e.google.com (mail-pf1-x42e.google.com [IPv6:2607:f8b0:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D9CC46A42B
        for <linux-kernel@vger.kernel.org>; Wed,  1 Jun 2022 03:25:11 -0700 (PDT)
Received: by mail-pf1-x42e.google.com with SMTP id bo5so1574255pfb.4
        for <linux-kernel@vger.kernel.org>; Wed, 01 Jun 2022 03:25:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=DlxLGMBD2rycrdizEoUgUGGKpKnTn88LsuKtd1elSBw=;
        b=IfmRzoxe0DV+Wou8Wfa3BPaoSuV4IAqkwM1FX7dDImx76yCiNL6EUZdXOQBqKEqsd5
         PwQp/1TKcU+tPb78/erhcqCch1d3RhKA1vmIvZvvKmXw8PF/rvsfEHc16c+mrqys82TY
         PehglRNgcn0q7TW4dzT8AGZfpr8Z6cLx9hrqpb6wDAZ5GHIfHcXTuPQ/IQl+myp9u8dL
         U/lGlXAXd0UGIndUKa/vTJuBmarhFMqKtDLZ4dnPyeNFnVbm31t2rJq0cQj6LOtF9WmP
         kmu4TDSLOsFUM/x3jFhZuNlBXYaNGTQk16b8L7cn+O/abuKjjhFLGhulCWFcJweNUkad
         tG/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=DlxLGMBD2rycrdizEoUgUGGKpKnTn88LsuKtd1elSBw=;
        b=NUUPPbaXmFjx+/9yO+OX35bgeQu4nKS+/D16KR1KzGOGhe4534gWdjCEDPDFQm/CD3
         oiR2QMp8YPwOZU+/jD9GClKePdRuPukJ/bwa/XGReQCW/0Ed8j7hLWnkqAC7oYdOBaB+
         3gM2kYpUCjK7g/5ADBEo2cyBv08KNn+yXLSuF49P0rdq+vDQeYWf7WnMG6Jl2XnRceHx
         B+fr260keygIwDlWNSxAjWLNT16O7OtiMAKJJNSFnKczK/HWbABmaf8AlsbGjwEco2LK
         TgN0MALAq7UD1OdtDBcKMm7YRJQhyShTXQ3iAF38wo62huoUdcsh5MZbOLtW/VGAuSh7
         Q09g==
X-Gm-Message-State: AOAM532cSOvroefVq2Qjt44DTSFmGqwuJJaCXDFHqGKAu32zv0ZkD8bK
        DQoFvimvj3ZMyHo5GSFI9oVecA==
X-Google-Smtp-Source: ABdhPJxC2r0nqh8Vxi0xek24UWJ1cmZY58t3GL5MaluqP9APToMZmLh27YEyHyqv0EJsLyzjTq5Wgg==
X-Received: by 2002:a63:e504:0:b0:3fc:596d:31c1 with SMTP id r4-20020a63e504000000b003fc596d31c1mr6726918pgh.550.1654079111214;
        Wed, 01 Jun 2022 03:25:11 -0700 (PDT)
Received: from leoy-ThinkPad-X240s (n058152077182.netvigator.com. [58.152.77.182])
        by smtp.gmail.com with ESMTPSA id f16-20020aa782d0000000b0051b291c2778sm1075508pfn.134.2022.06.01.03.25.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Jun 2022 03:25:10 -0700 (PDT)
Date:   Wed, 1 Jun 2022 18:25:05 +0800
From:   Leo Yan <leo.yan@linaro.org>
To:     Joe Mario <jmario@redhat.com>
Cc:     Arnaldo Carvalho de Melo <acme@kernel.org>,
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
Subject: Re: [PATCH v4 00/12] perf c2c: Support display for Arm64
Message-ID: <20220601102505.GA408721@leoy-ThinkPad-X240s>
References: <20220530114036.3225544-1-leo.yan@linaro.org>
 <57a826ad-5ceb-ba1d-b80c-452f72720889@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <57a826ad-5ceb-ba1d-b80c-452f72720889@redhat.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Joe,

On Tue, May 31, 2022 at 02:44:07PM -0400, Joe Mario wrote:

[...]

> Hi Leo:
> I built a new perf with your patches and ran it on a 2-numa node Neoverse platform.
> I then ran my simple test that creates reader and writer threads to tug on the same cacheline.
> The c2c output is appended below.
>
> The output looks good, especially where you've broken out the (average) cycles for local and remote peer loads.  
> And I'm glad to see you fixed the "Node" column.  I use that a lot to help detect remote node accesses.  

Thanks a lot for your testing and suggestions, which are really helpful!

> And the "PA cnt" field is working as well,  which is important to see if numa_balance is moving the data around.

Good to know this.  To be honest, before I didn't note for "PA cnt"
metric, I checked a bit for the code, this metrics is very useful to
understand how it's severe that a cache line is accessed from different
addresses, so we can get sense how a cache line is hammered.

> =================================================
>            Shared Data Cache Line Table
> =================================================
> #
> #        ----------- Cacheline ----------     Peer  ------- Load Peer -------    Total    Total    Total  --------- Stores --------  ----- Core Load Hit -----  - LLC Load Hit --  - RMT Load Hit --  --- Load Dram ----
> # Index             Address  Node  PA cnt    Snoop    Total    Local   Remote  records    Loads   Stores    L1Hit   L1Miss      N/A       FB       L1       L2    LclHit  LclHitm    RmtHit  RmtHitm       Lcl       Rmt
> # .....  ..................  ....  ......  .......  .......  .......  .......  .......  .......  .......  .......  .......  .......  .......  .......  .......  ........  .......  ........  .......  ........  ........
> #
>       0            0x422140     0    6904   74.86%      137      131        6   148008   144970     3038        0        0     3038        0   144833      120        11        0         6        0         0         0
>       1  0xffffd976e63ae5c0     1       6    3.83%        7        7        0       15       15        0        0        0        0        0        8        4         3        0         0        0         0         0
>       2  0xffff07ffbf290980     0       5    2.19%        4        2        2       14       14        0        0        0        0        0       10        1         1        0         2        0         0         0
>       3  0xffffd976e57275c0     1       1    0.55%        1        1        0        1        1        0        0        0        0        0        0        1         0        0         0        0         0         0
>       4  0xffffd976e6071c00     1       3    0.55%        1        0        1        4        4        0        0        0        0        0        3        0         0        0         1        0         0         0
>      [snip]
> =================================================
>       Shared Cache Line Distribution Pareto
> =================================================
> #
> #        -- Peer Snoop --  ------- Store Refs ------  --------- Data address ---------                      ---------- cycles ----------    Total       cpu                               Shared
> #   Num      Rmt      Lcl   L1 Hit  L1 Miss      N/A              Offset  Node  PA cnt        Code address  rmt peer  lcl peer      load  records       cnt                      Symbol   Object                Source:Line  Node
> # .....  .......  .......  .......  .......  .......  ..................  ....  ......  ..................  ........  ........  ........  .......  ........  ..........................  .......  .........................  ....
> #
>   ----------------------------------------------------------------------
>       0        6      131        0        0     3038            0x422140
>   ----------------------------------------------------------------------
>            0.00%    0.00%    0.00%    0.00%   52.60%                 0x8     0       1            0x400e6c         0         0         0     1598         4  [.] writer                  tugtest  tugtest.c:152               0 1
>            0.00%    0.00%    0.00%    0.00%   47.40%                0x10     0       1            0x400e7c         0         0         0     1440         4  [.] writer                  tugtest  tugtest.c:153               0 1
>           33.33%   75.57%    0.00%    0.00%    0.00%                0x20     0       1            0x401018      4095      3803      3419      409         4  [.] reader                  tugtest  tugtest.c:187               0 1
>           66.67%   24.43%    0.00%    0.00%    0.00%                0x28     0       1            0x401034      4095      3470      3643      413         4  [.] reader                  tugtest  tugtest.c:187               0 1
> 
>   ----------------------------------------------------------------------
>       1        0        7        0        0        0  0xffffd976e63ae5c0
>   ----------------------------------------------------------------------
>            0.00%   57.14%    0.00%    0.00%    0.00%                 0x0     1       1  0xffffd976e4815fbc         0      1333         0        4         2  [k] ktime_get                   [kernel.kallsyms]  seqlock.h:276          1                   
>            0.00%   14.29%    0.00%    0.00%    0.00%                 0x0     1       1  0xffffd976e4816d10         0       266       794        4         3  [k] ktime_get_update_offsets_n  [kernel.kallsyms]  seqlock.h:276        0 1
>            0.00%   28.57%    0.00%    0.00%    0.00%                0x30     1       1  0xffffd976e4816d20         0        87       150        4         3  [k] ktime_get_update_offsets_n  [kernel.kallsyms]  timekeeping.c:2298   0 1
>   
>   ----------------------------------------------------------------------     
>       2        2        2        0        0        0  0xffff07ffbf290980
>   ----------------------------------------------------------------------
>           50.00%  100.00%    0.00%    0.00%    0.00%                 0x4     0       1  0xffffd976e47d2bdc      1217      1600      1147        4         3  [k] queued_spin_lock_slowpath  [kernel.kallsyms]  qspinlock.c:511    0 1
>           50.00%    0.00%    0.00%    0.00%    0.00%                 0x4     0       1  0xffffd976e47d2a2c      4033         0         0        1         1  [k] queued_spin_lock_slowpath  [kernel.kallsyms]  qspinlock.c:382    0 1
>   
>   ----------------------------------------------------------------------     
> 
> Thanks for doing this.  It looks good.

You are welcome!  And very appreicate your helping to mature the code.

> I'll assume someone else is reviewing your code changes.

Yeah, let's give a bit more time for reviewing.

Thanks,
Leo
