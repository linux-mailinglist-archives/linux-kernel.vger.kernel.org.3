Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EF7C25111CD
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Apr 2022 08:57:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1358491AbiD0G7w (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Apr 2022 02:59:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59198 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1358486AbiD0G7l (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Apr 2022 02:59:41 -0400
Received: from out30-130.freemail.mail.aliyun.com (out30-130.freemail.mail.aliyun.com [115.124.30.130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3633E15836
        for <linux-kernel@vger.kernel.org>; Tue, 26 Apr 2022 23:56:24 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R181e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04357;MF=rongwei.wang@linux.alibaba.com;NM=1;PH=DS;RN=17;SR=0;TI=SMTPD_---0VBRXa0n_1651042577;
Received: from 30.240.99.9(mailfrom:rongwei.wang@linux.alibaba.com fp:SMTPD_---0VBRXa0n_1651042577)
          by smtp.aliyun-inc.com(127.0.0.1);
          Wed, 27 Apr 2022 14:56:19 +0800
Message-ID: <e3c1beb1-e3d5-6e26-bae2-06785080b57e@linux.alibaba.com>
Date:   Wed, 27 Apr 2022 14:56:16 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:100.0)
 Gecko/20100101 Thunderbird/100.0
Subject: Re: DAMON VA regions don't split on an large Android APP
Content-Language: en-US
To:     Barry Song <21cnbao@gmail.com>, sj@kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux-MM <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>
Cc:     Matthew Wilcox <willy@infradead.org>, shuah@kernel.org,
        brendanhiggins@google.com, foersleo@amazon.de, sieberf@amazon.com,
        Shakeel Butt <shakeelb@google.com>, sjpark@amazon.de,
        tuhailong@gmail.com, Song Jiang <sjiang88@gmail.com>,
        =?UTF-8?B?5byg6K+X5piOKFNpbW9uIFpoYW5nKQ==?= 
        <zhangshiming@oppo.com>,
        =?UTF-8?B?5p2O5Z+56ZSLKHdpbmsp?= <lipeifeng@oppo.com>,
        xhao@linux.alibaba.com
References: <CAGsJ_4x_k9009HwpTswEq1ut_co8XYdpZ9k0BVW=0=HRiifxkA@mail.gmail.com>
From:   Rongwei Wang <rongwei.wang@linux.alibaba.com>
In-Reply-To: <CAGsJ_4x_k9009HwpTswEq1ut_co8XYdpZ9k0BVW=0=HRiifxkA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-11.8 required=5.0 tests=BAYES_00,
        ENV_AND_HDR_SPF_MATCH,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS,UNPARSEABLE_RELAY,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 4/27/22 7:19 AM, Barry Song wrote:
> Hi SeongJae & Andrew,
> (also Cc-ed main damon developers)
> On an Android phone, I tried to use the DAMON vaddr monitor and found
> that vaddr regions don't split well on large Android Apps though
> everything works well on native Apps.
> 
> I have tried the below two cases on an Android phone with 12GB memory
> and snapdragon 888 CPU.
> 1. a native program with small memory working set  as below,
> #define size (1024*1024*100)
> main()
> {
>          volatile int *p = malloc(size);
>          memset(p, 0x55, size);
> 
>          while(1) {
>                  int i;
>                  for (i = 0; i < size / 4; i++)
>                          (void)*(p + i);
>                  usleep(1000);
> 
>                  for (i = 0; i < size / 16; i++)
>                          (void)*(p + i);
>                  usleep(1000);
> 
>          }
> }
> For this application, the Damon vaddr monitor works very well.
> I have modified monitor.py in the damo userspace tool a little bit to
> show the raw data getting from the kernel.
> Regions can split decently on this kind of applications, a typical raw
> data is as below,
> 
> monitoring_start:             2.224 s
> monitoring_end:               2.329 s
> monitoring_duration:       104.336 ms
> target_id: 0
> nr_regions: 24
> 005fb37b2000-005fb734a000(  59.594 MiB): 0
> 005fb734a000-005fbaf95000(  60.293 MiB): 0
> 005fbaf95000-005fbec0b000(  60.461 MiB): 0
> 005fbec0b000-005fc2910000(  61.020 MiB): 0
> 005fc2910000-005fc6769000(  62.348 MiB): 0
> 005fc6769000-005fca33f000(  59.836 MiB): 0
> 005fca33f000-005fcdc8b000(  57.297 MiB): 0
> 005fcdc8b000-005fd115a000(  52.809 MiB): 0
> 005fd115a000-005fd45bd000(  52.387 MiB): 0
> 007661c59000-007661ee4000(   2.543 MiB): 2
> 007661ee4000-0076623e4000(   5.000 MiB): 3
> 0076623e4000-007662837000(   4.324 MiB): 2
> 007662837000-0076630f1000(   8.727 MiB): 3
> 0076630f1000-007663494000(   3.637 MiB): 2
> 007663494000-007663753000(   2.746 MiB): 1
> 007663753000-007664251000(  10.992 MiB): 3
> 007664251000-0076666fd000(  36.672 MiB): 2
> 0076666fd000-007666e73000(   7.461 MiB): 1
> 007666e73000-007667c89000(  14.086 MiB): 2
> 007667c89000-007667f97000(   3.055 MiB): 0
> 007667f97000-007668112000(   1.480 MiB): 1
> 007668112000-00766820f000(1012.000 KiB): 0
> 007ff27b7000-007ff27d6000( 124.000 KiB): 0
> 007ff27d6000-007ff27d8000(   8.000 KiB): 8
> 
> 2. a large Android app like Asphalt 9
> For this case, basically regions can't split very well, but monitor
> works on small vma:
> 
> monitoring_start:             2.220 s
> monitoring_end:               2.318 s
> monitoring_duration:        98.576 ms
> target_id: 0
> nr_regions: 15
> 000012c00000-0001c301e000(   6.754 GiB): 0
> 0001c301e000-000371b6c000(   6.730 GiB): 0
> 000371b6c000-000400000000(   2.223 GiB): 0
> 005c6759d000-005c675a2000(  20.000 KiB): 0
> 005c675a2000-005c675a3000(   4.000 KiB): 3
> 005c675a3000-005c675a7000(  16.000 KiB): 0
> 0072f1e14000-0074928d4000(   6.510 GiB): 0
> 0074928d4000-00763c71f000(   6.655 GiB): 0
> 00763c71f000-0077e863e000(   6.687 GiB): 0
> 0077e863e000-00798e214000(   6.590 GiB): 0
> 00798e214000-007b0e48a000(   6.002 GiB): 0
> 007b0e48a000-007c62f00000(   5.323 GiB): 0
> 007c62f00000-007defb19000(   6.199 GiB): 0
> 007defb19000-007f794ef000(   6.150 GiB): 0
> 007f794ef000-007fe8f53000(   1.745 GiB): 0
> 
> As you can see, we have some regions which are very very big and they
> are losing the chance to be splitted. But
> Damon can still monitor memory access for those small VMA areas very well like:
> 005c675a2000-005c675a3000(   4.000 KiB): 3
Hi, Barry

Actually, we also had found the same problem in redis by ourselves 
tool[1]. The DAMON can not split the large anon VMA well, and the anon 
VMA has 10G~20G memory. I guess the whole region doesn't have sufficient 
hot areas to been monitored or found by DAMON, likes one or more address 
choose by DAMON not been accessed during sample period.

I'm not sure whether sets init_regions can deal with the above problem, 
or dynamic choose one or limited number VMA to monitor.

I'm not sure, just share my idea.

[1] https://github.com/aliyun/data-profile-tools.git
> 
> Typical characteristics of a large Android app is that it has
> thousands of vma and very large virtual address spaces:
> ~/damo # pmap 2550 | wc -l
> 8522
> 
> ~/damo # pmap 2550
> ...
> 0000007992bbe000      4K r----   [ anon ]
> 0000007992bbf000     24K rw---   [ anon ]
> 0000007fe8753000      4K -----   [ anon ]
> 0000007fe8754000   8188K rw---   [ stack ]
>   total         36742112K
> 
> Because the whole vma list is too long, I have put the list here for
> you to download:
> wget http://www.linuxep.com/patches/android-app-vmas
> 
> I can reproduce this problem on other Apps like youtube as well.
> I suppose we need to boost the algorithm of splitting regions for this
> kind of application.
> Any thoughts?
> 
> Thanks
> Barry
