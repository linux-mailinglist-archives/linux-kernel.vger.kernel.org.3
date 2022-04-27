Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6DD03511FB9
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Apr 2022 20:38:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244484AbiD0RyH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Apr 2022 13:54:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53644 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229920AbiD0RyF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Apr 2022 13:54:05 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C09A585644
        for <linux-kernel@vger.kernel.org>; Wed, 27 Apr 2022 10:50:53 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 6685361EA6
        for <linux-kernel@vger.kernel.org>; Wed, 27 Apr 2022 17:50:53 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7A22DC385A7;
        Wed, 27 Apr 2022 17:50:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1651081852;
        bh=wGkQ6bOf5DwV4aJRMZkEA5wEzpzAIRokdGkW7OEyS+U=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=fGVli05x9E0ui2PCPTieJb1U/F02qJWkGBwfWddyHtM7ohBrP1abR/n7LzcMGGsdB
         yw7T1KjolZFHTAosbIlUzx8Bvk/mVfAoZSDkJUndma8g7ydEl0K2yjXah3zg3S7Ys9
         axRsAzll/A/ElxYIfh7kVrGfTN8avHya0IFIa6hdajS9Sj1eRyPwexMnj0v4e4zqfX
         yrDXJ20457Z4Kxfae6gsHPxg9hPQ14fMMSKvrgN6UXXycLMtRMKZoh3X7rUROHbgvb
         nd5nhVcp+9TNufUFjs4kcFhyZU2Si/Gj07DBu1ke/1eLgEZg9XJEMhyCx3zLwty+zi
         JhnacOcnKlz0w==
From:   sj@kernel.org
To:     Barry Song <21cnbao@gmail.com>
Cc:     Rongwei Wang <rongwei.wang@linux.alibaba.com>, sj@kernel.org,
        "Andrew Morton" <akpm@linux-foundation.org>,
        Linux-MM <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>,
        "Matthew Wilcox" <willy@infradead.org>, shuah@kernel.org,
        brendanhiggins@google.com, foersleo@amazon.de, sieberf@amazon.com,
        "Shakeel Butt" <shakeelb@google.com>, sjpark@amazon.de,
        tuhailong@gmail.com, "Song Jiang" <sjiang88@gmail.com>,
        =?UTF-8?q?=E5=BC=A0=E8=AF=97=E6=98=8E=28Simon=20Zhang=29?= 
        <zhangshiming@oppo.com>,
        =?UTF-8?q?=E6=9D=8E=E5=9F=B9=E9=94=8B=28wink=29?= 
        <lipeifeng@oppo.com>, xhao@linux.alibaba.com
Subject: Re: DAMON VA regions don't split on an large Android APP
Date:   Wed, 27 Apr 2022 17:50:49 +0000
Message-Id: <20220427175049.50057-1-sj@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <CAGsJ_4weJ9onh0EJVy8QXMXZ++4qVyVuRi7oP3wiD0XWnqF-Dg@mail.gmail.com>
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

Hello Rongwei and Barry,

On Wed, 27 Apr 2022 19:44:23 +1200 Barry Song <21cnbao@gmail.com> wrote:

> On Wed, Apr 27, 2022 at 6:56 PM Rongwei Wang
> <rongwei.wang@linux.alibaba.com> wrote:
> >
> >
> >
> > On 4/27/22 7:19 AM, Barry Song wrote:
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
> > >          volatile int *p = malloc(size);
> > >          memset(p, 0x55, size);
> > >
> > >          while(1) {
> > >                  int i;
> > >                  for (i = 0; i < size / 4; i++)
> > >                          (void)*(p + i);
> > >                  usleep(1000);
> > >
> > >                  for (i = 0; i < size / 16; i++)
> > >                          (void)*(p + i);
> > >                  usleep(1000);
> > >
> > >          }
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
> > Hi, Barry
> >
> > Actually, we also had found the same problem in redis by ourselves
> > tool[1]. The DAMON can not split the large anon VMA well, and the anon
> > VMA has 10G~20G memory. I guess the whole region doesn't have sufficient
> > hot areas to been monitored or found by DAMON, likes one or more address
> > choose by DAMON not been accessed during sample period.
> 
> Hi Rongwei,
> Thanks  for your comments and thanks for sharing your tools.

I also appreciate for sharing the great tool, Rongwei!

> 
> I guess the cause might be:
> in case a region is very big like 10GiB, we have only 1MiB hot pages
> in this large region.
> damon will randomly pick one page to sample, but the page has only
> 1MiB/10GiB, thus
> less than 1/10000 chance to hit the hot 1MiB. so probably we need
> 10000 sample periods
> to hit the hot 1MiB in order to split this large region?
> 
> @SeongJae, please correct me if I am wrong.

I think your theory makes sense.  There was a similar concern, so we made DAMON
to split regions into 3 sub-regions when we don't see advance[1].  My current
rough idea for improving DAMON accuracy is making it more aggressive while
keeping the monitoring overhead low.

[1] https://git.kernel.org/pub/scm/linux/kernel/git/sj/linux.git/tree/mm/damon/core.c?h=damon/next-2022-04-21-08-31-on-v5.18-rc3-mmots-2022-04-20-17-37#n1053

> 
> >
> > I'm not sure whether sets init_regions can deal with the above problem,
> > or dynamic choose one or limited number VMA to monitor.
> >
> 
> I won't set a limited number of VMA as this will make the damon too hard to use
> as nobody wants to make such complex operations, especially an Android
> app might have more than 8000 VMAs.
> 
> I agree init_regions might be the right place to enhance the situation.

'init_regions' has developed for the purpose, where user space knows some good
information for starting point of the regions adjustment, and thus want to hint
DAMON.  Nevertheless, it might not work as expected, because DAMON
automatically updates the target regions to cover all VMAs as much as it can.
I have posted a patchset for the use case yesterday[1].

[1] https://lore.kernel.org/linux-mm/20220426231750.48822-1-sj@kernel.org/

> 
> > I'm not sure, just share my idea.
> >
> > [1] https://github.com/aliyun/data-profile-tools.git
> 
> I suppose this tool is based on damon? How do you finally resolve the problem
> that large anon VMAs can't be splitted?
> Anyway, I will give your tool a try.
> 
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
> > >   total         36742112K
> > >
> > > Because the whole vma list is too long, I have put the list here for
> > > you to download:
> > > wget http://www.linuxep.com/patches/android-app-vmas
> > >
> > > I can reproduce this problem on other Apps like youtube as well.
> > > I suppose we need to boost the algorithm of splitting regions for this
> > > kind of application.
> > > Any thoughts?
> > >
> 
> Thanks
> Barry
