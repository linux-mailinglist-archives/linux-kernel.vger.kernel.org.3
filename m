Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DC56B53BCF4
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Jun 2022 19:00:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237358AbiFBQ7s (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Jun 2022 12:59:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46838 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237336AbiFBQ7q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Jun 2022 12:59:46 -0400
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com [IPv6:2a00:1450:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DFF6F2C132
        for <linux-kernel@vger.kernel.org>; Thu,  2 Jun 2022 09:59:44 -0700 (PDT)
Received: by mail-wr1-x432.google.com with SMTP id s24so7208842wrb.10
        for <linux-kernel@vger.kernel.org>; Thu, 02 Jun 2022 09:59:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=gJI0fyeehoL/waGjrLPc17/+5A3DkpPvOsvIqeP9Oew=;
        b=Y94H/LutL5xcvvqeYRIQ3k2GNtfTQGLIsyAiTm1KRpHmDXWPBiD8cUYpECmC7JycfR
         8ZJcrXrN6vL8Z6db9LKLidNIjG2gmonOGHsS4okQmtK1+34FZVazlCAt+BpWItf+Q1pA
         DaO0AXMe6RwCtoW3C/eK1eOU/YMAZH4B1V66+l3/g6Yyhe4NaIIJIcKkEJgdMk+vVy67
         kepfwqgFFpnL0+ao50VRg1e6QyZ1rycsRESdTA14o404hD2ZAVSwUrzWCaiF0RX6V5vW
         PfrQPQ9HdeiFep+qn5kXtlLIpHGVS5kwofHX6yyKXZdiGxUBrbdx4qgVtJTgTkxYlGAo
         gJBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=gJI0fyeehoL/waGjrLPc17/+5A3DkpPvOsvIqeP9Oew=;
        b=U9TU4MGZpyhcslM1UdxvbIOqlO5+oWgZRX1H/KWhZMotXFO8/6G67ZJbalXZDN378Y
         td8Caj7v4vzJ8ujCIyYypLKGNzxZLRcnzvXSk3AphKWQylhwjF2pkblJiAq9c1m+6FSE
         EWmdpqyZoNK9DyNOFtNgRvTzvfZ+it9/jDGp/n9aprfUbcePh/6RUdNP/mOOtbv+HPB/
         /ZyqzcwRVvHDVtCZUciyQn+aGxO9augJhdtprbvPmed/G+mUgUx0nP/fPza0Cmq8cZ13
         lW7/ybS8f1IKiYC1sN2PuMumLDQQO82VKDAKtXEMM6MNW6hNCrijY1VkFnDr8tfJcHT6
         pUjQ==
X-Gm-Message-State: AOAM533Z/eKcsOEaY/GaCd/Pz24sX636owtl/l89X/0gjj8ZnQfEduVJ
        3VXo1hrR1A4W0Sptq0v6dgP9Xf7uSYHmsyipDDFiMw==
X-Google-Smtp-Source: ABdhPJzrDLIa+YUVKzzK9QdIRSY+VILW7HE4gFksquJkHLRwzKd7OPr8qRLP8jVkh1j2y3XvHp/6QQY4mAX1teSdpIo=
X-Received: by 2002:a5d:598f:0:b0:20c:83c9:b05b with SMTP id
 n15-20020a5d598f000000b0020c83c9b05bmr4530509wri.343.1654189183096; Thu, 02
 Jun 2022 09:59:43 -0700 (PDT)
MIME-Version: 1.0
References: <20220530114036.3225544-1-leo.yan@linaro.org> <57a826ad-5ceb-ba1d-b80c-452f72720889@redhat.com>
 <20220601102505.GA408721@leoy-ThinkPad-X240s>
In-Reply-To: <20220601102505.GA408721@leoy-ThinkPad-X240s>
From:   Ian Rogers <irogers@google.com>
Date:   Thu, 2 Jun 2022 09:59:29 -0700
Message-ID: <CAP-5=fVqjZOvncE3iTAF6Wfqrn3_UxGsrBJkiaT=qMs5xdq9LA@mail.gmail.com>
Subject: Re: [PATCH v4 00/12] perf c2c: Support display for Arm64
To:     Leo Yan <leo.yan@linaro.org>
Cc:     Joe Mario <jmario@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>, Alyssa Ross <hi@alyssa.is>,
        Like Xu <likexu@tencent.com>, Kajol Jain <kjain@linux.ibm.com>,
        Li Huafei <lihuafei1@huawei.com>,
        Adam Li <adam.li@amperecomputing.com>,
        German Gomez <german.gomez@arm.com>,
        James Clark <james.clark@arm.com>,
        Ali Saidi <alisaidi@amazon.com>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 1, 2022 at 3:25 AM Leo Yan <leo.yan@linaro.org> wrote:
>
> Hi Joe,
>
> On Tue, May 31, 2022 at 02:44:07PM -0400, Joe Mario wrote:
>
> [...]
>
> > Hi Leo:
> > I built a new perf with your patches and ran it on a 2-numa node Neoverse platform.
> > I then ran my simple test that creates reader and writer threads to tug on the same cacheline.
> > The c2c output is appended below.
> >
> > The output looks good, especially where you've broken out the (average) cycles for local and remote peer loads.
> > And I'm glad to see you fixed the "Node" column.  I use that a lot to help detect remote node accesses.
>
> Thanks a lot for your testing and suggestions, which are really helpful!
>
> > And the "PA cnt" field is working as well,  which is important to see if numa_balance is moving the data around.
>
> Good to know this.  To be honest, before I didn't note for "PA cnt"
> metric, I checked a bit for the code, this metrics is very useful to
> understand how it's severe that a cache line is accessed from different
> addresses, so we can get sense how a cache line is hammered.
>
> > =================================================
> >            Shared Data Cache Line Table
> > =================================================
> > #
> > #        ----------- Cacheline ----------     Peer  ------- Load Peer -------    Total    Total    Total  --------- Stores --------  ----- Core Load Hit -----  - LLC Load Hit --  - RMT Load Hit --  --- Load Dram ----
> > # Index             Address  Node  PA cnt    Snoop    Total    Local   Remote  records    Loads   Stores    L1Hit   L1Miss      N/A       FB       L1       L2    LclHit  LclHitm    RmtHit  RmtHitm       Lcl       Rmt
> > # .....  ..................  ....  ......  .......  .......  .......  .......  .......  .......  .......  .......  .......  .......  .......  .......  .......  ........  .......  ........  .......  ........  ........
> > #
> >       0            0x422140     0    6904   74.86%      137      131        6   148008   144970     3038        0        0     3038        0   144833      120        11        0         6        0         0         0
> >       1  0xffffd976e63ae5c0     1       6    3.83%        7        7        0       15       15        0        0        0        0        0        8        4         3        0         0        0         0         0
> >       2  0xffff07ffbf290980     0       5    2.19%        4        2        2       14       14        0        0        0        0        0       10        1         1        0         2        0         0         0
> >       3  0xffffd976e57275c0     1       1    0.55%        1        1        0        1        1        0        0        0        0        0        0        1         0        0         0        0         0         0
> >       4  0xffffd976e6071c00     1       3    0.55%        1        0        1        4        4        0        0        0        0        0        3        0         0        0         1        0         0         0
> >      [snip]
> > =================================================
> >       Shared Cache Line Distribution Pareto
> > =================================================
> > #
> > #        -- Peer Snoop --  ------- Store Refs ------  --------- Data address ---------                      ---------- cycles ----------    Total       cpu                               Shared
> > #   Num      Rmt      Lcl   L1 Hit  L1 Miss      N/A              Offset  Node  PA cnt        Code address  rmt peer  lcl peer      load  records       cnt                      Symbol   Object                Source:Line  Node
> > # .....  .......  .......  .......  .......  .......  ..................  ....  ......  ..................  ........  ........  ........  .......  ........  ..........................  .......  .........................  ....
> > #
> >   ----------------------------------------------------------------------
> >       0        6      131        0        0     3038            0x422140
> >   ----------------------------------------------------------------------
> >            0.00%    0.00%    0.00%    0.00%   52.60%                 0x8     0       1            0x400e6c         0         0         0     1598         4  [.] writer                  tugtest  tugtest.c:152               0 1
> >            0.00%    0.00%    0.00%    0.00%   47.40%                0x10     0       1            0x400e7c         0         0         0     1440         4  [.] writer                  tugtest  tugtest.c:153               0 1
> >           33.33%   75.57%    0.00%    0.00%    0.00%                0x20     0       1            0x401018      4095      3803      3419      409         4  [.] reader                  tugtest  tugtest.c:187               0 1
> >           66.67%   24.43%    0.00%    0.00%    0.00%                0x28     0       1            0x401034      4095      3470      3643      413         4  [.] reader                  tugtest  tugtest.c:187               0 1
> >
> >   ----------------------------------------------------------------------
> >       1        0        7        0        0        0  0xffffd976e63ae5c0
> >   ----------------------------------------------------------------------
> >            0.00%   57.14%    0.00%    0.00%    0.00%                 0x0     1       1  0xffffd976e4815fbc         0      1333         0        4         2  [k] ktime_get                   [kernel.kallsyms]  seqlock.h:276          1
> >            0.00%   14.29%    0.00%    0.00%    0.00%                 0x0     1       1  0xffffd976e4816d10         0       266       794        4         3  [k] ktime_get_update_offsets_n  [kernel.kallsyms]  seqlock.h:276        0 1
> >            0.00%   28.57%    0.00%    0.00%    0.00%                0x30     1       1  0xffffd976e4816d20         0        87       150        4         3  [k] ktime_get_update_offsets_n  [kernel.kallsyms]  timekeeping.c:2298   0 1
> >
> >   ----------------------------------------------------------------------
> >       2        2        2        0        0        0  0xffff07ffbf290980
> >   ----------------------------------------------------------------------
> >           50.00%  100.00%    0.00%    0.00%    0.00%                 0x4     0       1  0xffffd976e47d2bdc      1217      1600      1147        4         3  [k] queued_spin_lock_slowpath  [kernel.kallsyms]  qspinlock.c:511    0 1
> >           50.00%    0.00%    0.00%    0.00%    0.00%                 0x4     0       1  0xffffd976e47d2a2c      4033         0         0        1         1  [k] queued_spin_lock_slowpath  [kernel.kallsyms]  qspinlock.c:382    0 1
> >
> >   ----------------------------------------------------------------------
> >
> > Thanks for doing this.  It looks good.
>
> You are welcome!  And very appreicate your helping to mature the code.
>
> > I'll assume someone else is reviewing your code changes.
>
> Yeah, let's give a bit more time for reviewing.
>
> Thanks,
> Leo

This is great Leo! I've not been able to test the changes but I didn't
have any coding comments (happy to give an Acked-by). Do you think we
can add a test for this? The test can skip when c2c isn't supported.

Thanks,
Ian
