Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 207155112C5
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Apr 2022 09:45:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1359016AbiD0Hru (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Apr 2022 03:47:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54128 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354769AbiD0Hrr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Apr 2022 03:47:47 -0400
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com [IPv6:2a00:1450:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1A32D1594A7
        for <linux-kernel@vger.kernel.org>; Wed, 27 Apr 2022 00:44:36 -0700 (PDT)
Received: by mail-ej1-x636.google.com with SMTP id l18so1693257ejc.7
        for <linux-kernel@vger.kernel.org>; Wed, 27 Apr 2022 00:44:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=JEihk+mny8ns7HLjYYHkgv6seQO0V7BVz6mjpDgHP/Y=;
        b=MDP+NaMib/S/EKvd7JEY9fTkCM65z4hAPV6SpAKAdWz1qmr9z1U/P3KC8Ie7FJcvhQ
         sqf/bYO4XTjcFJ7DLLCrCBjJALb3UuFuYJj60TRI0HCry3WPaHZYqIj8soUsdxGQD0it
         R3loT8xOvHALw3M7dWaY48ie699eRCBPcXjWIxTMAtGpNiIv6cHEnWFNdyLqt8f8CV5F
         NjZhBzPb4PIo4QGzEtjDzv9hpifJ2/EOxDpux0y9I0e+a0qEbY5iwiAP5p1ko3IVBK4q
         tAxARyqKoacEeUUomU9sXpgjAaMqe7QvM3ztpY9uBNQ1MZn8+7nvvedqddeP0luz1KJK
         noqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=JEihk+mny8ns7HLjYYHkgv6seQO0V7BVz6mjpDgHP/Y=;
        b=BMw1v1Pqw5mzhBM+6VJsp1drgbukRbqr7tmGJE/M2bdSY3zTo39LLkRAb+oPXCwRoc
         f3DVSQ6S11smdIeUgNJsw19MGyLhSEFC73WXixV3/PNX010329T5iDvoqLi5vbjXHgGl
         m80m4OINxYL70LY5zTusaQQOvbWsIs6DZv+l+IKU9egJziZ9dIoAY2S78nnR4s4jTYrv
         M51SQSTUR+wKPcHNbbX15CNwY5DqVyaDCS9f2osWpYLJ+WUhCyw+dWUZi5NZluFtSK3/
         Unzxk06zOfOBNxIfVNT1MC1i3IFJXFRQ0SfBIk4UM0SEVYFQiM9q/IO5D+tXhwFYC+5v
         lacQ==
X-Gm-Message-State: AOAM531+Y2IMTovF4xYPfvgnV9FtOU+gzg9g+hHI1wS69n9mDZ2SBDCx
        NRARskxq+U1sAjbyvW8rd4XTAKhKfmbvlq64C7M=
X-Google-Smtp-Source: ABdhPJxa+39hF2oMC/2ojZ6gZxGqyDtokwOXjV0yOibz/ORpSOZ8qbDVvUMn4zb+DKlvLyLdsbVZlAp6hbbdRi2CTCE=
X-Received: by 2002:a17:907:6ea8:b0:6f3:cd21:59b4 with SMTP id
 sh40-20020a1709076ea800b006f3cd2159b4mr1056108ejc.457.1651045474340; Wed, 27
 Apr 2022 00:44:34 -0700 (PDT)
MIME-Version: 1.0
References: <CAGsJ_4x_k9009HwpTswEq1ut_co8XYdpZ9k0BVW=0=HRiifxkA@mail.gmail.com>
 <e3c1beb1-e3d5-6e26-bae2-06785080b57e@linux.alibaba.com>
In-Reply-To: <e3c1beb1-e3d5-6e26-bae2-06785080b57e@linux.alibaba.com>
From:   Barry Song <21cnbao@gmail.com>
Date:   Wed, 27 Apr 2022 19:44:23 +1200
Message-ID: <CAGsJ_4weJ9onh0EJVy8QXMXZ++4qVyVuRi7oP3wiD0XWnqF-Dg@mail.gmail.com>
Subject: Re: DAMON VA regions don't split on an large Android APP
To:     Rongwei Wang <rongwei.wang@linux.alibaba.com>
Cc:     sj@kernel.org, Andrew Morton <akpm@linux-foundation.org>,
        Linux-MM <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Matthew Wilcox <willy@infradead.org>, shuah@kernel.org,
        brendanhiggins@google.com, foersleo@amazon.de, sieberf@amazon.com,
        Shakeel Butt <shakeelb@google.com>, sjpark@amazon.de,
        tuhailong@gmail.com, Song Jiang <sjiang88@gmail.com>,
        =?UTF-8?B?5byg6K+X5piOKFNpbW9uIFpoYW5nKQ==?= 
        <zhangshiming@oppo.com>,
        =?UTF-8?B?5p2O5Z+56ZSLKHdpbmsp?= <lipeifeng@oppo.com>,
        xhao@linux.alibaba.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 27, 2022 at 6:56 PM Rongwei Wang
<rongwei.wang@linux.alibaba.com> wrote:
>
>
>
> On 4/27/22 7:19 AM, Barry Song wrote:
> > Hi SeongJae & Andrew,
> > (also Cc-ed main damon developers)
> > On an Android phone, I tried to use the DAMON vaddr monitor and found
> > that vaddr regions don't split well on large Android Apps though
> > everything works well on native Apps.
> >
> > I have tried the below two cases on an Android phone with 12GB memory
> > and snapdragon 888 CPU.
> > 1. a native program with small memory working set  as below,
> > #define size (1024*1024*100)
> > main()
> > {
> >          volatile int *p = malloc(size);
> >          memset(p, 0x55, size);
> >
> >          while(1) {
> >                  int i;
> >                  for (i = 0; i < size / 4; i++)
> >                          (void)*(p + i);
> >                  usleep(1000);
> >
> >                  for (i = 0; i < size / 16; i++)
> >                          (void)*(p + i);
> >                  usleep(1000);
> >
> >          }
> > }
> > For this application, the Damon vaddr monitor works very well.
> > I have modified monitor.py in the damo userspace tool a little bit to
> > show the raw data getting from the kernel.
> > Regions can split decently on this kind of applications, a typical raw
> > data is as below,
> >
> > monitoring_start:             2.224 s
> > monitoring_end:               2.329 s
> > monitoring_duration:       104.336 ms
> > target_id: 0
> > nr_regions: 24
> > 005fb37b2000-005fb734a000(  59.594 MiB): 0
> > 005fb734a000-005fbaf95000(  60.293 MiB): 0
> > 005fbaf95000-005fbec0b000(  60.461 MiB): 0
> > 005fbec0b000-005fc2910000(  61.020 MiB): 0
> > 005fc2910000-005fc6769000(  62.348 MiB): 0
> > 005fc6769000-005fca33f000(  59.836 MiB): 0
> > 005fca33f000-005fcdc8b000(  57.297 MiB): 0
> > 005fcdc8b000-005fd115a000(  52.809 MiB): 0
> > 005fd115a000-005fd45bd000(  52.387 MiB): 0
> > 007661c59000-007661ee4000(   2.543 MiB): 2
> > 007661ee4000-0076623e4000(   5.000 MiB): 3
> > 0076623e4000-007662837000(   4.324 MiB): 2
> > 007662837000-0076630f1000(   8.727 MiB): 3
> > 0076630f1000-007663494000(   3.637 MiB): 2
> > 007663494000-007663753000(   2.746 MiB): 1
> > 007663753000-007664251000(  10.992 MiB): 3
> > 007664251000-0076666fd000(  36.672 MiB): 2
> > 0076666fd000-007666e73000(   7.461 MiB): 1
> > 007666e73000-007667c89000(  14.086 MiB): 2
> > 007667c89000-007667f97000(   3.055 MiB): 0
> > 007667f97000-007668112000(   1.480 MiB): 1
> > 007668112000-00766820f000(1012.000 KiB): 0
> > 007ff27b7000-007ff27d6000( 124.000 KiB): 0
> > 007ff27d6000-007ff27d8000(   8.000 KiB): 8
> >
> > 2. a large Android app like Asphalt 9
> > For this case, basically regions can't split very well, but monitor
> > works on small vma:
> >
> > monitoring_start:             2.220 s
> > monitoring_end:               2.318 s
> > monitoring_duration:        98.576 ms
> > target_id: 0
> > nr_regions: 15
> > 000012c00000-0001c301e000(   6.754 GiB): 0
> > 0001c301e000-000371b6c000(   6.730 GiB): 0
> > 000371b6c000-000400000000(   2.223 GiB): 0
> > 005c6759d000-005c675a2000(  20.000 KiB): 0
> > 005c675a2000-005c675a3000(   4.000 KiB): 3
> > 005c675a3000-005c675a7000(  16.000 KiB): 0
> > 0072f1e14000-0074928d4000(   6.510 GiB): 0
> > 0074928d4000-00763c71f000(   6.655 GiB): 0
> > 00763c71f000-0077e863e000(   6.687 GiB): 0
> > 0077e863e000-00798e214000(   6.590 GiB): 0
> > 00798e214000-007b0e48a000(   6.002 GiB): 0
> > 007b0e48a000-007c62f00000(   5.323 GiB): 0
> > 007c62f00000-007defb19000(   6.199 GiB): 0
> > 007defb19000-007f794ef000(   6.150 GiB): 0
> > 007f794ef000-007fe8f53000(   1.745 GiB): 0
> >
> > As you can see, we have some regions which are very very big and they
> > are losing the chance to be splitted. But
> > Damon can still monitor memory access for those small VMA areas very well like:
> > 005c675a2000-005c675a3000(   4.000 KiB): 3
> Hi, Barry
>
> Actually, we also had found the same problem in redis by ourselves
> tool[1]. The DAMON can not split the large anon VMA well, and the anon
> VMA has 10G~20G memory. I guess the whole region doesn't have sufficient
> hot areas to been monitored or found by DAMON, likes one or more address
> choose by DAMON not been accessed during sample period.

Hi Rongwei,
Thanks  for your comments and thanks for sharing your tools.

I guess the cause might be:
in case a region is very big like 10GiB, we have only 1MiB hot pages
in this large region.
damon will randomly pick one page to sample, but the page has only
1MiB/10GiB, thus
less than 1/10000 chance to hit the hot 1MiB. so probably we need
10000 sample periods
to hit the hot 1MiB in order to split this large region?

@SeongJae, please correct me if I am wrong.

>
> I'm not sure whether sets init_regions can deal with the above problem,
> or dynamic choose one or limited number VMA to monitor.
>

I won't set a limited number of VMA as this will make the damon too hard to use
as nobody wants to make such complex operations, especially an Android
app might have more than 8000 VMAs.

I agree init_regions might be the right place to enhance the situation.

> I'm not sure, just share my idea.
>
> [1] https://github.com/aliyun/data-profile-tools.git

I suppose this tool is based on damon? How do you finally resolve the problem
that large anon VMAs can't be splitted?
Anyway, I will give your tool a try.

> >
> > Typical characteristics of a large Android app is that it has
> > thousands of vma and very large virtual address spaces:
> > ~/damo # pmap 2550 | wc -l
> > 8522
> >
> > ~/damo # pmap 2550
> > ...
> > 0000007992bbe000      4K r----   [ anon ]
> > 0000007992bbf000     24K rw---   [ anon ]
> > 0000007fe8753000      4K -----   [ anon ]
> > 0000007fe8754000   8188K rw---   [ stack ]
> >   total         36742112K
> >
> > Because the whole vma list is too long, I have put the list here for
> > you to download:
> > wget http://www.linuxep.com/patches/android-app-vmas
> >
> > I can reproduce this problem on other Apps like youtube as well.
> > I suppose we need to boost the algorithm of splitting regions for this
> > kind of application.
> > Any thoughts?
> >

Thanks
Barry
