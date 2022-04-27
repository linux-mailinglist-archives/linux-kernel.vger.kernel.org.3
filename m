Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 44E34511ED4
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Apr 2022 20:37:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244331AbiD0RnP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Apr 2022 13:43:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34340 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244498AbiD0RnG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Apr 2022 13:43:06 -0400
Received: from sin.source.kernel.org (sin.source.kernel.org [145.40.73.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 44229C42F8
        for <linux-kernel@vger.kernel.org>; Wed, 27 Apr 2022 10:39:34 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id BE777CE26C4
        for <linux-kernel@vger.kernel.org>; Wed, 27 Apr 2022 17:39:32 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B8504C385A9;
        Wed, 27 Apr 2022 17:39:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1651081171;
        bh=9uBwVYTRgJmEvCO4uzesfu5uPlVtvTj5SWA5B3WiUhs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Ac0z9T0286JXA93jlZkguEXQD0KSO2sLzDVvg27SW/rbumDDvFkIV4/olhaCyTlgZ
         /btPnh7tzdIePlwufwaKDdezEcn5bMZCzEUFP/bqZKQWuKRnWbVGS90pCekCD4mdCZ
         7aZIWlm/AwKAU1w83nkw/CwqlCgTFrtkYzO+T8NtaRx9O07Igl3X5bYqw+YXcnTNNP
         Dvh28wGd+96l4LpIbkUilqxgfI1grAl5zQ1Sj26RfK7hrgaPFhZz14RMTd1scM9zx4
         bjwGUhTcivE036gIDwD8FrkIhEcMFNpFWU35HaVhl3YMzXnRh1GF10w7wDbuczRxvZ
         04BA4WAvpg19Q==
From:   sj@kernel.org
To:     Barry Song <21cnbao@gmail.com>
Cc:     sj@kernel.org, "Andrew Morton" <akpm@linux-foundation.org>,
        Linux-MM <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>,
        "Matthew Wilcox" <willy@infradead.org>, shuah@kernel.org,
        brendanhiggins@google.com, foersleo@amazon.de, sieberf@amazon.com,
        "Shakeel Butt" <shakeelb@google.com>, sjpark@amazon.de,
        tuhailong@gmail.com, "Song Jiang" <sjiang88@gmail.com>,
        =?UTF-8?q?=E5=BC=A0=E8=AF=97=E6=98=8E=28Simon=20Zhang=29?= 
        <zhangshiming@oppo.com>,
        =?UTF-8?q?=E6=9D=8E=E5=9F=B9=E9=94=8B=28wink=29?= 
        <lipeifeng@oppo.com>, linux-damon@amazon.com
Subject: Re: DAMON VA regions don't split on an large Android APP
Date:   Wed, 27 Apr 2022 17:39:27 +0000
Message-Id: <20220427173927.49994-1-sj@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <CAGsJ_4wUa0i0nq61C01hb18Czpg-EuzHqH_NN=Xcfr+tKoqMCQ@mail.gmail.com>
References: 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 27 Apr 2022 14:08:04 +1200 Barry Song <21cnbao@gmail.com> wrote:

> On Wed, Apr 27, 2022 at 12:21 PM <sj@kernel.org> wrote:
> >
> > Hello Barry,
> >
> >
> > Thank you so much for sharing your great findings! :)
> 
> Thanks for your quick response.

My pleasure :)

> 
> >
> > On Wed, 27 Apr 2022 11:19:23 +1200 Barry Song <21cnbao@gmail.com> wrote:
> >
> > > Hi SeongJae & Andrew,
> > > (also Cc-ed main damon developers)
> > > On an Android phone, I tried to use the DAMON vaddr monitor and found
> > > that vaddr regions don't split well on large Android Apps though
> > > everything works well on native Apps.
> > >
> > > I have tried the below two cases on an Android phone with 12GB memory
> > > and snapdragon 888 CPU.
> > > 1. a native program with small memory working set  as below,
> > > #define size (1024*1024*100)
> > > main()
> > > {
> > >         volatile int *p = malloc(size);
> > >         memset(p, 0x55, size);
> > >
> > >         while(1) {
> > >                 int i;
> > >                 for (i = 0; i < size / 4; i++)
> > >                         (void)*(p + i);
> > >                 usleep(1000);
> > >
> > >                 for (i = 0; i < size / 16; i++)
> > >                         (void)*(p + i);
> > >                 usleep(1000);
> > >
> > >         }
> > > }
> > > For this application, the Damon vaddr monitor works very well.
> > > I have modified monitor.py in the damo userspace tool a little bit to
> > > show the raw data getting from the kernel.
> > > Regions can split decently on this kind of applications, a typical raw
> > > data is as below,
> > >
> > > monitoring_start:             2.224 s
> > > monitoring_end:               2.329 s
> > > monitoring_duration:       104.336 ms
> > > target_id: 0
> > > nr_regions: 24
> > > 005fb37b2000-005fb734a000(  59.594 MiB): 0
> > > 005fb734a000-005fbaf95000(  60.293 MiB): 0
> > > 005fbaf95000-005fbec0b000(  60.461 MiB): 0
> > > 005fbec0b000-005fc2910000(  61.020 MiB): 0
> > > 005fc2910000-005fc6769000(  62.348 MiB): 0
> > > 005fc6769000-005fca33f000(  59.836 MiB): 0
> > > 005fca33f000-005fcdc8b000(  57.297 MiB): 0
> > > 005fcdc8b000-005fd115a000(  52.809 MiB): 0
> > > 005fd115a000-005fd45bd000(  52.387 MiB): 0
> > > 007661c59000-007661ee4000(   2.543 MiB): 2
> > > 007661ee4000-0076623e4000(   5.000 MiB): 3
> > > 0076623e4000-007662837000(   4.324 MiB): 2
> > > 007662837000-0076630f1000(   8.727 MiB): 3
> > > 0076630f1000-007663494000(   3.637 MiB): 2
> > > 007663494000-007663753000(   2.746 MiB): 1
> > > 007663753000-007664251000(  10.992 MiB): 3
> > > 007664251000-0076666fd000(  36.672 MiB): 2
> > > 0076666fd000-007666e73000(   7.461 MiB): 1
> > > 007666e73000-007667c89000(  14.086 MiB): 2
> > > 007667c89000-007667f97000(   3.055 MiB): 0
> > > 007667f97000-007668112000(   1.480 MiB): 1
> > > 007668112000-00766820f000(1012.000 KiB): 0
> > > 007ff27b7000-007ff27d6000( 124.000 KiB): 0
> > > 007ff27d6000-007ff27d8000(   8.000 KiB): 8
> > >
> > > 2. a large Android app like Asphalt 9
> > > For this case, basically regions can't split very well, but monitor
> > > works on small vma:
> > >
> > > monitoring_start:             2.220 s
> > > monitoring_end:               2.318 s
> > > monitoring_duration:        98.576 ms
> > > target_id: 0
> > > nr_regions: 15
> > > 000012c00000-0001c301e000(   6.754 GiB): 0
> > > 0001c301e000-000371b6c000(   6.730 GiB): 0
> > > 000371b6c000-000400000000(   2.223 GiB): 0
> > > 005c6759d000-005c675a2000(  20.000 KiB): 0
> > > 005c675a2000-005c675a3000(   4.000 KiB): 3
> > > 005c675a3000-005c675a7000(  16.000 KiB): 0
> > > 0072f1e14000-0074928d4000(   6.510 GiB): 0
> > > 0074928d4000-00763c71f000(   6.655 GiB): 0
> > > 00763c71f000-0077e863e000(   6.687 GiB): 0
> > > 0077e863e000-00798e214000(   6.590 GiB): 0
> > > 00798e214000-007b0e48a000(   6.002 GiB): 0
> > > 007b0e48a000-007c62f00000(   5.323 GiB): 0
> > > 007c62f00000-007defb19000(   6.199 GiB): 0
> > > 007defb19000-007f794ef000(   6.150 GiB): 0
> > > 007f794ef000-007fe8f53000(   1.745 GiB): 0
> > >
> > > As you can see, we have some regions which are very very big and they
> > > are losing the chance to be splitted. But
> > > Damon can still monitor memory access for those small VMA areas very well like:
> > > 005c675a2000-005c675a3000(   4.000 KiB): 3
> >
> > In short, DAMON doesn't set regions based on VMA but access pattern, and
> > therefore this looks not a problem.
> >
> > DAMON allows users set min/max monitoring overhead limit and provides a best
> > accuracy under the condition.  In detail, users are allowed to set the min/max
> > monitoring regions as DAMON's monitoring overhead is proportional to the number
> > of regions.  DAMON provides best effort accuracy under the condition by
> > splitting and merging regions so that pages in each region has different access
> > frequency.
> >
> > The default min number of regions is 10.  I believe that's why there are many 6
> > GiB regions.
> >
> 
> i had actually tried to set min regions to 100 as below:
> /sys/kernel/debug/damon # echo 5000 100000 60000000 100 1000 > attrs
> /sys/kernel/debug/damon # cat attrs
> 5000 100000 60000000 100 1000
> 
> but it seems i am still only getting regions like 16:
> 
> monitoring_start:          805.192 ms
> monitoring_end:            905.385 ms
> monitoring_duration:       100.193 ms
> target_id: 0
> nr_regions: 16
> 000012c00000-0001fc021000(   7.645 GiB): 0
> 0001fc021000-0003e6b9a000(   7.667 GiB): 0
> 0003e6b9a000-000400000000( 404.398 MiB): 0
> 005e95645000-005e9564a000(  20.000 KiB): 0
> 005e9564a000-005e9564b000(   4.000 KiB): 8
> 005e9564b000-005e9564c000(   4.000 KiB): 1
> 005e9564c000-005e9564f000(  12.000 KiB): 0
> 006ffffff000-0071fa4f8000(   7.911 GiB): 0
> 0071fa4f8000-0073dacd1000(   7.508 GiB): 0
> 0073dacd1000-00759533c000(   6.913 GiB): 0
> 00759533c000-0076cc999000(   4.866 GiB): 0
> 0076cc999000-00788bea1000(   6.989 GiB): 0
> 00788bea1000-007a6fe14000(   7.562 GiB): 0
> 007a6fe14000-007c5c4a3000(   7.694 GiB): 0
> 007c5c4a3000-007df9bd8000(   6.460 GiB): 0
> 007df9bd8000-007fe6d7b000(   7.705 GiB): 0
> 
> so it seems the 100 set in min regions doesn't mean we will have at
> least 100 regions?

Have you used the debugfs interface for turning DAMON on for the above case?
If not, and if you have used 'damo monitor' again, 'damo monitor' should have
reset the 'min_nr_regions' to 10.

On my x86 test machine, the 'min_nr_regions' was respected:

    $ sudo damo record --minr 100 paddr
    [...]
    $ sudo damo report nr_regions
    # <percentile> <# regions>
    # target_id     0
    # avr:  111
    0       109
    25      111
    50      111
    75      113
    100     116

Unfortunately, 'damo monitor' has no option to set the min_nr_regions.  You
could modify the default value of the option of damo-record on 'damo_record.py'
for the case.  Sorry for your inconvenient.

> 
> > If we don't see small regions having some non-zero access frequency, we would
> > be better to be worried.  However, it is finding the small 4 KiB regions having
> > higher access frequency successfully.  The 4 KiB region is not because the
> > region is having 4 KiB VMA, but the address region shows high access frequency.
> >
> > >
> > > Typical characteristics of a large Android app is that it has
> > > thousands of vma and very large virtual address spaces:
> > > ~/damo # pmap 2550 | wc -l
> > > 8522
> > >
> > > ~/damo # pmap 2550
> > > ...
> > > 0000007992bbe000      4K r----   [ anon ]
> > > 0000007992bbf000     24K rw---   [ anon ]
> > > 0000007fe8753000      4K -----   [ anon ]
> > > 0000007fe8754000   8188K rw---   [ stack ]
> > >  total         36742112K
> > >
> > > Because the whole vma list is too long, I have put the list here for
> > > you to download:
> > > wget http://www.linuxep.com/patches/android-app-vmas
> > >
> > > I can reproduce this problem on other Apps like youtube as well.
> > > I suppose we need to boost the algorithm of splitting regions for this
> > > kind of application.
> > > Any thoughts?
> >
> > As mentioned above, this looks not a problem, as DAMON's monitoring regions is
> > not constructed based on VMAs but access patterns.
> 
> What makes me believe it is a problem is that it seems we are getting
> an incorrect
> wss based on the data reported from kernel:
> ~/damo # ./damo monitor --report_type wss --count 20 2561
> # <percentile> <wss>
> # target_id 0
> # avr: 443.854 MiB
>   0             0 B |
>          |
>  25       4.000 KiB |
>          |
>  50      12.000 KiB |
>          |
>  75      20.000 KiB |
>          |
> 100       5.851 GiB
> |***********************************************************|
[...]
> 
> And I have a question, what do percentile 0,25,50,75 mean here?
> Why are they so different with percentile 100?
> For example, 0,25,50,75 has only KiB but 100 has GiB.

For each aggregation interval, we get one snapshot.  So, if we have a
monitoring results that recorded for, say, 100 aggregation interval, we have
100 snapshots.  'damo' calculates working set size of each snapshot by summing
size of regions assumed to be accessed at least once.  So, in this example, we
get 100 wss values.  Then, 'damo' sorts the values and provides the smallest
one as 0-th percentile, 25th small value as 25-th percentile, and so on.

100-th percentile wss is usually noisy, as DAMON regions shouldn't be converged
well at the beginning of the record.  I believe that could be the reason why
the 100-th percentile wss is so unexpectedly big.

I personally use 50-th percentile as reliable value.

> 
> I guess Asphalt 9 should be normally accessing hundreds of megabytes of memory.

Each wss value is calculated for each aggregation interval.  That is, the wss
value is amount of memory that accessed within an aggregation interval.  As the
default aggregation interval is 100ms, the working set size could be smaller
than your expectation.

For such cases, 'damo report wss' has an option called '--work_time' to
simulate higher aggregation intervals.  That is, you can get the total size of
the memory regions that DAMON shown access to those within arbitrary amount of
time using the option.  'damo monitor' doesn't support the option at the
moment, though.

> 
> >
> > Nevertheless, I believe there are many rooms for improvement of DAMON's access
> > frequency.  I want to implement fixed-gran monitoring feature first, and
> > develop some accuracy optimizations using the fixed-gran monitoring as
> > comparison target.
> 
> Does fixed-gran mean splitting VA to some regions equally with the same size?
> for example, if we have 1GB VA, we split it into 512 regions in 2MB
> size, something like that?

Yes, exactly.  That's the idea.  It would incur much higher, and unbounded
overhead, but could be a good comparison target for accuracy improvement of
DAMON.  Also, for some environments that doesn't care about the monitoring
overhead, it could be used well.


Thanks,
SJ

> >
> > If I'm missing something or the explanation was not enough, please feel free to
> > let me know.
> >
> >
> > Thank,
> > SJ
> >
> > >
> > > Thanks
> > > Barry
> > >
> 
> Thanks
> Barry
