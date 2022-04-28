Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C8FAA5128CC
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Apr 2022 03:28:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240629AbiD1Bbg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Apr 2022 21:31:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54398 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240595AbiD1Bb2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Apr 2022 21:31:28 -0400
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com [IPv6:2a00:1450:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9FFF199684
        for <linux-kernel@vger.kernel.org>; Wed, 27 Apr 2022 18:28:12 -0700 (PDT)
Received: by mail-ej1-x630.google.com with SMTP id i19so6604402eja.11
        for <linux-kernel@vger.kernel.org>; Wed, 27 Apr 2022 18:28:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=VNIRwkfqjUD5R8U0ipGZPsXbHRV8SsjY9E1i4kUuJY0=;
        b=lxFpfu3F440Y+/ZmpdbNhJgvGl+f4BwknEB44diDFGRj5vZ5C2mBKbQhJNMO8T3/zP
         ezKqYHBKLKHDAHl5n2/7uhREj8gf/YIP1XhB5xxo3U/ZgcFVn3ZrlCG5iUMXsUJLOAVO
         fkc/JDnSIo5hMuDHXD9t7GigEuC4MyINGkzj5OQLqVv909PZk7xxhUPJyRAJjvMfSPuE
         PzSoizIDHNcq9mryEKflkiCeVuJL0RUXbV9OgIR8kDVEJKYc9udBigDnnwJWnlFvEeIJ
         z089jmrDtf5Yx0pfIVdbFAR28C+8e4ouaDFcy7PGLLbOuZOvnqznDsev5F8tntvu/hDo
         pRZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=VNIRwkfqjUD5R8U0ipGZPsXbHRV8SsjY9E1i4kUuJY0=;
        b=gyUP3/0ljN4nvxpNOKeVchRt4aspakBZv4L7vyLbWdFcJJtkwZmwpsrI4zdQqj0ZB7
         ecBNB75ZXnoMmnlWwrLb8jI5Y4ocRCmH/SD4eTqdpLccU20CQPjgB+yfXlZ3Un93+1Na
         EamHPoeOkFqjulLkzXUJdKEa5mjwe94cn85aZ6mD6tmlsP2BCjEjo5Kd72lbL+5jekmG
         FdzU0XG5G/YbDmxC4RV8piNyB2BUOl1VQxyGA1G9aiQBmNciWdbZ+8owGU35taYNfr1h
         INnl0M1WuAOOBD69VK5Fd3spVbeKW/ZKKKvNniZEaHag/Qc+uld2QI0qKC5sp8jsUWC8
         2J6Q==
X-Gm-Message-State: AOAM533c781upH2twLVjZx8PXp6JTpdU5WLQA8UHoaITxuZeHFNe9bYD
        q0GRLRIVIowLy3CO71iMRYeuk3pCJEnuGn8GRtM=
X-Google-Smtp-Source: ABdhPJzAfmr0L7d93dOCWSkLaP/+Hccf93V8LkpBPqErTtTDuPQD4ddTK5MezJzwgDAIXEumX9ZekKMaXqgpBdEYKrc=
X-Received: by 2002:a17:906:2991:b0:6cd:ac19:ce34 with SMTP id
 x17-20020a170906299100b006cdac19ce34mr29852826eje.746.1651109290629; Wed, 27
 Apr 2022 18:28:10 -0700 (PDT)
MIME-Version: 1.0
References: <CAGsJ_4wUa0i0nq61C01hb18Czpg-EuzHqH_NN=Xcfr+tKoqMCQ@mail.gmail.com>
 <20220427173927.49994-1-sj@kernel.org>
In-Reply-To: <20220427173927.49994-1-sj@kernel.org>
From:   Barry Song <21cnbao@gmail.com>
Date:   Thu, 28 Apr 2022 13:27:59 +1200
Message-ID: <CAGsJ_4y==XhrG9mNnLV_s1UovpsUsHGjTAvEK-XDJTy_L7AvDA@mail.gmail.com>
Subject: Re: DAMON VA regions don't split on an large Android APP
To:     sj@kernel.org
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Linux-MM <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Matthew Wilcox <willy@infradead.org>, shuah@kernel.org,
        brendanhiggins@google.com, foersleo@amazon.de, sieberf@amazon.com,
        Shakeel Butt <shakeelb@google.com>, sjpark@amazon.de,
        tuhailong@gmail.com, Song Jiang <sjiang88@gmail.com>,
        =?UTF-8?B?5byg6K+X5piOKFNpbW9uIFpoYW5nKQ==?= 
        <zhangshiming@oppo.com>,
        =?UTF-8?B?5p2O5Z+56ZSLKHdpbmsp?= <lipeifeng@oppo.com>,
        linux-damon@amazon.com
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

On Thu, Apr 28, 2022 at 5:39 AM <sj@kernel.org> wrote:
>
> On Wed, 27 Apr 2022 14:08:04 +1200 Barry Song <21cnbao@gmail.com> wrote:
>
> > On Wed, Apr 27, 2022 at 12:21 PM <sj@kernel.org> wrote:
> > >
> > > Hello Barry,
> > >
> > >
> > > Thank you so much for sharing your great findings! :)
> >
> > Thanks for your quick response.
>
> My pleasure :)
>
> >
> > >
> > > On Wed, 27 Apr 2022 11:19:23 +1200 Barry Song <21cnbao@gmail.com> wrote:
> > >
> > > > Hi SeongJae & Andrew,
> > > > (also Cc-ed main damon developers)
> > > > On an Android phone, I tried to use the DAMON vaddr monitor and found
> > > > that vaddr regions don't split well on large Android Apps though
> > > > everything works well on native Apps.
> > > >
> > > > I have tried the below two cases on an Android phone with 12GB memory
> > > > and snapdragon 888 CPU.
> > > > 1. a native program with small memory working set  as below,
> > > > #define size (1024*1024*100)
> > > > main()
> > > > {
> > > >         volatile int *p = malloc(size);
> > > >         memset(p, 0x55, size);
> > > >
> > > >         while(1) {
> > > >                 int i;
> > > >                 for (i = 0; i < size / 4; i++)
> > > >                         (void)*(p + i);
> > > >                 usleep(1000);
> > > >
> > > >                 for (i = 0; i < size / 16; i++)
> > > >                         (void)*(p + i);
> > > >                 usleep(1000);
> > > >
> > > >         }
> > > > }
> > > > For this application, the Damon vaddr monitor works very well.
> > > > I have modified monitor.py in the damo userspace tool a little bit to
> > > > show the raw data getting from the kernel.
> > > > Regions can split decently on this kind of applications, a typical raw
> > > > data is as below,
> > > >
> > > > monitoring_start:             2.224 s
> > > > monitoring_end:               2.329 s
> > > > monitoring_duration:       104.336 ms
> > > > target_id: 0
> > > > nr_regions: 24
> > > > 005fb37b2000-005fb734a000(  59.594 MiB): 0
> > > > 005fb734a000-005fbaf95000(  60.293 MiB): 0
> > > > 005fbaf95000-005fbec0b000(  60.461 MiB): 0
> > > > 005fbec0b000-005fc2910000(  61.020 MiB): 0
> > > > 005fc2910000-005fc6769000(  62.348 MiB): 0
> > > > 005fc6769000-005fca33f000(  59.836 MiB): 0
> > > > 005fca33f000-005fcdc8b000(  57.297 MiB): 0
> > > > 005fcdc8b000-005fd115a000(  52.809 MiB): 0
> > > > 005fd115a000-005fd45bd000(  52.387 MiB): 0
> > > > 007661c59000-007661ee4000(   2.543 MiB): 2
> > > > 007661ee4000-0076623e4000(   5.000 MiB): 3
> > > > 0076623e4000-007662837000(   4.324 MiB): 2
> > > > 007662837000-0076630f1000(   8.727 MiB): 3
> > > > 0076630f1000-007663494000(   3.637 MiB): 2
> > > > 007663494000-007663753000(   2.746 MiB): 1
> > > > 007663753000-007664251000(  10.992 MiB): 3
> > > > 007664251000-0076666fd000(  36.672 MiB): 2
> > > > 0076666fd000-007666e73000(   7.461 MiB): 1
> > > > 007666e73000-007667c89000(  14.086 MiB): 2
> > > > 007667c89000-007667f97000(   3.055 MiB): 0
> > > > 007667f97000-007668112000(   1.480 MiB): 1
> > > > 007668112000-00766820f000(1012.000 KiB): 0
> > > > 007ff27b7000-007ff27d6000( 124.000 KiB): 0
> > > > 007ff27d6000-007ff27d8000(   8.000 KiB): 8
> > > >
> > > > 2. a large Android app like Asphalt 9
> > > > For this case, basically regions can't split very well, but monitor
> > > > works on small vma:
> > > >
> > > > monitoring_start:             2.220 s
> > > > monitoring_end:               2.318 s
> > > > monitoring_duration:        98.576 ms
> > > > target_id: 0
> > > > nr_regions: 15
> > > > 000012c00000-0001c301e000(   6.754 GiB): 0
> > > > 0001c301e000-000371b6c000(   6.730 GiB): 0
> > > > 000371b6c000-000400000000(   2.223 GiB): 0
> > > > 005c6759d000-005c675a2000(  20.000 KiB): 0
> > > > 005c675a2000-005c675a3000(   4.000 KiB): 3
> > > > 005c675a3000-005c675a7000(  16.000 KiB): 0
> > > > 0072f1e14000-0074928d4000(   6.510 GiB): 0
> > > > 0074928d4000-00763c71f000(   6.655 GiB): 0
> > > > 00763c71f000-0077e863e000(   6.687 GiB): 0
> > > > 0077e863e000-00798e214000(   6.590 GiB): 0
> > > > 00798e214000-007b0e48a000(   6.002 GiB): 0
> > > > 007b0e48a000-007c62f00000(   5.323 GiB): 0
> > > > 007c62f00000-007defb19000(   6.199 GiB): 0
> > > > 007defb19000-007f794ef000(   6.150 GiB): 0
> > > > 007f794ef000-007fe8f53000(   1.745 GiB): 0
> > > >
> > > > As you can see, we have some regions which are very very big and they
> > > > are losing the chance to be splitted. But
> > > > Damon can still monitor memory access for those small VMA areas very well like:
> > > > 005c675a2000-005c675a3000(   4.000 KiB): 3
> > >
> > > In short, DAMON doesn't set regions based on VMA but access pattern, and
> > > therefore this looks not a problem.
> > >
> > > DAMON allows users set min/max monitoring overhead limit and provides a best
> > > accuracy under the condition.  In detail, users are allowed to set the min/max
> > > monitoring regions as DAMON's monitoring overhead is proportional to the number
> > > of regions.  DAMON provides best effort accuracy under the condition by
> > > splitting and merging regions so that pages in each region has different access
> > > frequency.
> > >
> > > The default min number of regions is 10.  I believe that's why there are many 6
> > > GiB regions.
> > >
> >
> > i had actually tried to set min regions to 100 as below:
> > /sys/kernel/debug/damon # echo 5000 100000 60000000 100 1000 > attrs
> > /sys/kernel/debug/damon # cat attrs
> > 5000 100000 60000000 100 1000
> >
> > but it seems i am still only getting regions like 16:
> >
> > monitoring_start:          805.192 ms
> > monitoring_end:            905.385 ms
> > monitoring_duration:       100.193 ms
> > target_id: 0
> > nr_regions: 16
> > 000012c00000-0001fc021000(   7.645 GiB): 0
> > 0001fc021000-0003e6b9a000(   7.667 GiB): 0
> > 0003e6b9a000-000400000000( 404.398 MiB): 0
> > 005e95645000-005e9564a000(  20.000 KiB): 0
> > 005e9564a000-005e9564b000(   4.000 KiB): 8
> > 005e9564b000-005e9564c000(   4.000 KiB): 1
> > 005e9564c000-005e9564f000(  12.000 KiB): 0
> > 006ffffff000-0071fa4f8000(   7.911 GiB): 0
> > 0071fa4f8000-0073dacd1000(   7.508 GiB): 0
> > 0073dacd1000-00759533c000(   6.913 GiB): 0
> > 00759533c000-0076cc999000(   4.866 GiB): 0
> > 0076cc999000-00788bea1000(   6.989 GiB): 0
> > 00788bea1000-007a6fe14000(   7.562 GiB): 0
> > 007a6fe14000-007c5c4a3000(   7.694 GiB): 0
> > 007c5c4a3000-007df9bd8000(   6.460 GiB): 0
> > 007df9bd8000-007fe6d7b000(   7.705 GiB): 0
> >
> > so it seems the 100 set in min regions doesn't mean we will have at
> > least 100 regions?
>
> Have you used the debugfs interface for turning DAMON on for the above case?
> If not, and if you have used 'damo monitor' again, 'damo monitor' should have
> reset the 'min_nr_regions' to 10.
>

Thanks for the clarification.

i hardcoded min_nr_regions to 200 by:
diff --git a/_damon.py b/_damon.py
index 1306ea1..82342a5 100644
--- a/_damon.py
+++ b/_damon.py
@@ -344,7 +344,7 @@ def set_attrs_argparser(parser):
     parser.add_argument('-u', '--updr', metavar='<interval>', type=int,
             default=1000000, help='regions update interval (us)')
     parser.add_argument('-n', '--minr', metavar='<# regions>', type=int,
-            default=10, help='minimal number of regions')
+            default=200, help='minimal number of regions')
     parser.add_argument('-m', '--maxr', metavar='<# regions>', type=int,
             default=1000, help='maximum number of regions')


Now wss seems to make more senses:

~/damo # ./damo monitor --report_type=wss --count=20 2551
# <percentile> <wss>
# target_id 0
# avr: 235.394 MiB
  0             0 B |
         |
 25       2.164 MiB |
         |
 50     129.875 MiB |*********
         |
 75     430.547 MiB |******************************
         |
100     844.238 MiB
|***********************************************************|

# <percentile> <wss>
# target_id 0
# avr: 352.501 MiB
  0       8.781 MiB |
         |
 25     100.793 MiB |*****
         |
 50     309.883 MiB |***************
         |
 75     487.027 MiB |************************
         |
100       1.146 GiB
|***********************************************************|

# <percentile> <wss>
# target_id 0
# avr: 161.014 MiB
  0       2.398 MiB |
         |
 25       9.902 MiB |*
         |
 50      48.539 MiB |*****
         |
 75     326.391 MiB |************************************
         |
100     528.809 MiB
|***********************************************************|

# <percentile> <wss>
# target_id 0
# avr: 226.624 MiB
  0       3.336 MiB |
         |
 25       4.078 MiB |
         |
 50     248.410 MiB |***************************
         |
 75     374.551 MiB |*****************************************
         |
100     536.539 MiB
|***********************************************************|

# <percentile> <wss>
# target_id 0
# avr: 312.534 MiB
  0             0 B |
         |
 25     123.539 MiB |********
         |
 50     248.914 MiB |*****************
         |
 75     461.578 MiB |********************************
         |
100     839.188 MiB
|***********************************************************|

# <percentile> <wss>
# target_id 0
# avr: 134.619 MiB
  0             0 B |
         |
 25             0 B |
         |
 50      32.883 MiB |**
         |
 75     240.508 MiB |********************
         |
100     705.434 MiB
|***********************************************************|

# <percentile> <wss>
# target_id 0
# avr: 126.954 MiB
  0       2.371 MiB |
         |
 25       4.195 MiB |
         |
 50       4.500 MiB |
         |
 75     228.879 MiB |***************
         |
100     851.113 MiB
|***********************************************************|

# <percentile> <wss>
# target_id 0
# avr: 217.697 MiB
  0      12.391 MiB |
         |
 25      14.273 MiB |
         |
 50      17.473 MiB |
         |
 75     377.797 MiB |********************
         |
100       1.043 GiB
|***********************************************************|

# <percentile> <wss>
# target_id 0
# avr: 147.215 MiB
  0       1.660 MiB |
         |
 25       2.078 MiB |
         |
 50      42.012 MiB |**
         |
 75     136.105 MiB |*******
         |
100       1.096 GiB
|***********************************************************|

# <percentile> <wss>
# target_id 0
# avr: 185.126 MiB
  0       2.164 MiB |
         |
 25       4.203 MiB |
         |
 50      34.738 MiB |**
         |
 75     270.617 MiB |********************
         |
100     790.008 MiB
|***********************************************************|

# <percentile> <wss>
# target_id 0
# avr: 324.269 MiB
  0      14.824 MiB |
         |
 25      25.648 MiB |
         |
 50      45.023 MiB |*
         |
 75     450.941 MiB |************
         |
100       2.019 GiB
|***********************************************************|

# <percentile> <wss>
# target_id 0
# avr: 165.244 MiB
  0       9.664 MiB |
         |
 25      10.316 MiB |
         |
 50      31.832 MiB |**
         |
 75     330.348 MiB |****************************
         |
100     679.520 MiB
|***********************************************************|

# <percentile> <wss>
# target_id 0
# avr: 127.422 MiB
  0      13.043 MiB |*
         |
 25      15.020 MiB |**
         |
 50      16.145 MiB |**
         |
 75     300.398 MiB |****************************************
         |
100     432.977 MiB
|***********************************************************|

# <percentile> <wss>
# target_id 0
# avr: 256.081 MiB
  0      13.387 MiB |
         |
 25      18.477 MiB |*
         |
 50      48.340 MiB |**
         |
 75     497.965 MiB |****************************
         |
100       1.014 GiB
|***********************************************************|

# <percentile> <wss>
# target_id 0
# avr: 378.882 MiB
  0       2.832 MiB |
         |
 25      56.801 MiB |***
         |
 50     383.211 MiB |**********************
         |
 75     658.094 MiB |*************************************
         |
100    1022.305 MiB
|***********************************************************|

# <percentile> <wss>
# target_id 0
# avr: 180.306 MiB
  0       3.137 MiB |
         |
 25      12.395 MiB |
         |
 50      68.301 MiB |****
         |
 75     287.266 MiB |****************
         |
100    1001.176 MiB
|***********************************************************|

# <percentile> <wss>
# target_id 0
# avr: 212.827 MiB
  0      10.887 MiB |
         |
 25      20.914 MiB |*
         |
 50      38.023 MiB |**
         |
 75     458.492 MiB |*******************************
         |
100     866.816 MiB
|***********************************************************|

# <percentile> <wss>
# target_id 0
# avr: 108.935 MiB
  0       1.840 MiB |
         |
 25       2.219 MiB |
         |
 50       5.582 MiB |
         |
 75     119.770 MiB |******
         |
100       1.004 GiB
|***********************************************************|

# <percentile> <wss>
# target_id 0
# avr: 164.604 MiB
  0       3.973 MiB |
         |
 25       4.559 MiB |
         |
 50      36.355 MiB |***
         |
 75     279.863 MiB |*************************
         |
100     650.730 MiB
|***********************************************************|

# <percentile> <wss>
# target_id 0
# avr: 226.909 MiB
  0       9.691 MiB |
         |
 25      11.453 MiB |*
         |
 50      25.648 MiB |**
         |
 75     560.414 MiB |*************************************************
         |
100     664.480 MiB
|***********************************************************|

Regions are like:

monitoring_start:             2.250 s
monitoring_end:               2.350 s
monitoring_duration:       100.425 ms
target_id: 0
nr_regions: 488
000012c00000-00002c14a000( 405.289 MiB): 0
00002c14a000-000044f05000( 397.730 MiB): 0
000044f05000-00005d106000( 386.004 MiB): 0
00005d106000-0000765f9000( 404.949 MiB): 0
0000765f9000-0000867b8000( 257.746 MiB): 0
0000867b8000-00009fb18000( 403.375 MiB): 0
00009fb18000-0000b932d000( 408.082 MiB): 0
0000b932d000-0000d1376000( 384.285 MiB): 0
0000d1376000-0000e765d000( 354.902 MiB): 0
0000e765d000-0000fccab000( 342.305 MiB): 0
0000fccab000-0001132b2000( 358.027 MiB): 0
0001132b2000-00012bc48000( 393.586 MiB): 0
00012bc48000-0001445c8000( 393.500 MiB): 0
0001445c8000-00015cc7c000( 390.703 MiB): 0
00015cc7c000-000172a92000( 350.086 MiB): 0
000172a92000-00018b19b000( 391.035 MiB): 0
00018b19b000-0001a0f74000( 349.848 MiB): 0
0001a0f74000-0001b707b000( 353.027 MiB): 0
0001b707b000-0001d05fc000( 405.504 MiB): 0
0001d05fc000-0001e10f9000( 266.988 MiB): 0
0001e10f9000-0001f75c6000( 356.801 MiB): 0
0001f75c6000-00020fc0e000( 390.281 MiB): 0
00020fc0e000-00022923d000( 406.184 MiB): 0
00022923d000-000240acb000( 376.555 MiB): 0
000240acb000-000250b48000( 256.488 MiB): 0
000250b48000-000266cc5000( 353.488 MiB): 0
000266cc5000-00027bf32000( 338.426 MiB): 0
00027bf32000-0002944fe000( 389.797 MiB): 0
0002944fe000-0002ac8c6000( 387.781 MiB): 0
0002ac8c6000-0002c52e8000( 394.133 MiB): 0
0002c52e8000-0002db30d000( 352.145 MiB): 0
0002db30d000-0002eedd0000( 314.762 MiB): 0
0002eedd0000-0003075f9000( 392.160 MiB): 0
0003075f9000-000316ff8000( 249.996 MiB): 0
000316ff8000-00032f8ec000( 392.953 MiB): 0
00032f8ec000-000342f72000( 310.523 MiB): 0
000342f72000-00035be55000( 398.887 MiB): 0
00035be55000-00037299d000( 363.281 MiB): 0
00037299d000-00038a649000( 380.672 MiB): 0
00038a649000-0003a2dbd000( 391.453 MiB): 0
0003a2dbd000-0003b2b96000( 253.848 MiB): 0
0003b2b96000-0003c8902000( 349.422 MiB): 0
0003c8902000-0003e06c2000( 381.750 MiB): 0
0003e06c2000-0003f92d9000( 396.090 MiB): 0
0003f92d9000-000400000000( 109.152 MiB): 0
005858822000-00585882c000(  40.000 KiB): 0
006fd5edd000-006fef5c4000( 406.902 MiB): 0
006fef5c4000-0070089ba000( 403.961 MiB): 0
0070089ba000-007021339000( 393.496 MiB): 0
007021339000-007039f08000( 395.809 MiB): 0
007039f08000-00704fb11000( 348.035 MiB): 0
00704fb11000-007067cfb000( 385.914 MiB): 0
007067cfb000-00707e1a2000( 356.652 MiB): 0
00707e1a2000-0070940cd000( 351.168 MiB): 0
0070940cd000-0070ad473000( 403.648 MiB): 0
0070ad473000-0070c65d6000( 401.387 MiB): 0
0070c65d6000-0070dbf07000( 345.191 MiB): 0
0070dbf07000-0070f5077000( 401.438 MiB): 0
0070f5077000-007107593000( 293.109 MiB): 0
007107593000-00711a860000( 306.801 MiB): 0
00711a860000-007131800000( 367.625 MiB): 0
007131800000-007143aff000( 290.996 MiB): 0
007143aff000-00715ce42000( 403.262 MiB): 0
00715ce42000-0071756e3000( 392.629 MiB): 0
0071756e3000-00718d7f1000( 385.055 MiB): 0
00718d7f1000-0071a5bf2000( 388.004 MiB): 0
0071a5bf2000-0071be018000( 388.148 MiB): 0
0071be018000-0071ceefa000( 270.883 MiB): 0
0071ceefa000-0071e3f2d000( 336.199 MiB): 0
0071e3f2d000-0071faa8c000( 363.371 MiB): 0
0071faa8c000-00721257e000( 378.945 MiB): 0
00721257e000-00722ace6000( 391.406 MiB): 0
00722ace6000-00724308f000( 387.660 MiB): 0
00724308f000-0072597ab000( 359.109 MiB): 0
0072597ab000-007272a9e000( 402.949 MiB): 0
007272a9e000-00728bb31000( 400.574 MiB): 0
00728bb31000-00729fa37000( 319.023 MiB): 0
00729fa37000-0072b3486000( 314.309 MiB): 0
0072b3486000-0072cc684000( 401.992 MiB): 0
0072cc684000-0072e51af000( 395.168 MiB): 0
0072e51af000-0072fb3c6000( 354.090 MiB): 0
0072fb3c6000-007305891000( 164.793 MiB): 0
007305891000-007305893000(   8.000 KiB): 11
007305893000-007305897000(  16.000 KiB): 14
007305897000-00730589a000(  12.000 KiB): 11
00730589a000-0073058a0000(  24.000 KiB): 0
0073058a0000-0073058a2000(   8.000 KiB): 11
0073058a2000-0073058ab000(  36.000 KiB): 8
0073058ab000-0073058ad000(   8.000 KiB): 0
0073058ad000-0073058ae000(   4.000 KiB): 13
0073058ae000-0073058b3000(  20.000 KiB): 10
0073058b3000-0073058b4000(   4.000 KiB): 5
0073058b4000-0073058b8000(  16.000 KiB): 13
0073058b8000-0073058ca000(  72.000 KiB): 11
0073058ca000-0073058cf000(  20.000 KiB): 0
0073058cf000-0073058d1000(   8.000 KiB): 13
0073058d1000-0073058d4000(  12.000 KiB): 10
0073058d4000-0073058d5000(   4.000 KiB): 0
0073058d5000-0073058d7000(   8.000 KiB): 13
0073058d7000-0073058da000(  12.000 KiB): 10
0073058da000-0073058db000(   4.000 KiB): 6
0073058db000-0073058dd000(   8.000 KiB): 11
0073058dd000-0073058df000(   8.000 KiB): 6
0073058df000-0073058e0000(   4.000 KiB): 0
0073058e0000-0073058e2000(   8.000 KiB): 11
0073058e2000-0073058e9000(  28.000 KiB): 14
0073058e9000-0073058ef000(  24.000 KiB): 6
0073058ef000-0073058f1000(   8.000 KiB): 12
0073058f1000-007305997000( 664.000 KiB): 5
007305997000-007305999000(   8.000 KiB): 11
007305999000-00730599d000(  16.000 KiB): 7
00730599d000-00730599e000(   4.000 KiB): 9
00730599e000-00730599f000(   4.000 KiB): 0
00730599f000-0073059a1000(   8.000 KiB): 2
0073059a1000-0073059a6000(  20.000 KiB): 0
0073059a6000-0073059ae000(  32.000 KiB): 9
0073059ae000-0073059c1000(  76.000 KiB): 0
0073059c1000-0073059c2000(   4.000 KiB): 6
0073059c2000-0073059c4000(   8.000 KiB): 3
0073059c4000-0073059c6000(   8.000 KiB): 12
0073059c6000-0073059c8000(   8.000 KiB): 0
0073059c8000-0073059ca000(   8.000 KiB): 5
0073059ca000-0073059d4000(  40.000 KiB): 0
0073059d4000-0073059d5000(   4.000 KiB): 13
0073059d5000-0073059d6000(   4.000 KiB): 4
0073059d6000-0073059d8000(   8.000 KiB): 13
0073059d8000-0073059db000(  12.000 KiB): 1
0073059db000-0073059dd000(   8.000 KiB): 12
0073059dd000-0073059e1000(  16.000 KiB): 7
0073059e1000-0073059e3000(   8.000 KiB): 12
0073059e3000-0073059e6000(  12.000 KiB): 6
0073059e6000-0073059e8000(   8.000 KiB): 10
0073059e8000-0073059e9000(   4.000 KiB): 13
0073059e9000-0073059ea000(   4.000 KiB): 9
0073059ea000-0073059ec000(   8.000 KiB): 11
0073059ec000-0073059ee000(   8.000 KiB): 3
0073059ee000-0073059f0000(   8.000 KiB): 13
0073059f0000-0073059f2000(   8.000 KiB): 0
0073059f2000-0073059f3000(   4.000 KiB): 13
0073059f3000-007305a1b000( 160.000 KiB): 3
007305a1b000-007305a20000(  20.000 KiB): 5
007305a20000-007305a22000(   8.000 KiB): 13
007305a22000-007305a23000(   4.000 KiB): 6
007305a23000-007305a25000(   8.000 KiB): 11
007305a25000-007305a28000(  12.000 KiB): 7
007305a28000-007305a2f000(  28.000 KiB): 1
007305a2f000-007305a39000(  40.000 KiB): 4
007305a39000-007305a3b000(   8.000 KiB): 9
007305a3b000-007305a3d000(   8.000 KiB): 11
007305a3d000-007305a3f000(   8.000 KiB): 5
007305a3f000-007305a43000(  16.000 KiB): 0
007305a43000-007305a44000(   4.000 KiB): 9
007305a44000-007305a49000(  20.000 KiB): 13
007305a49000-00731d952000( 383.035 MiB): 0
00731d952000-0073371b4000( 408.383 MiB): 0
0073371b4000-00735039e000( 401.914 MiB): 0
00735039e000-007368d88000( 393.914 MiB): 0
007368d88000-007381dd7000( 400.309 MiB): 0
007381dd7000-00739b19a000( 403.762 MiB): 0
00739b19a000-0073a76ea000( 197.312 MiB): 0
0073a76ea000-0073a76ec000(   8.000 KiB): 8
0073a76ec000-0073a76f0000(  16.000 KiB): 0
0073a76f0000-0073a76f1000(   4.000 KiB): 7
0073a76f1000-0073a76f4000(  12.000 KiB): 3
0073a76f4000-0073a76f5000(   4.000 KiB): 0
0073a76f5000-0073a76f7000(   8.000 KiB): 10
0073a76f7000-0073a76fa000(  12.000 KiB): 4
0073a76fa000-0073a76fb000(   4.000 KiB): 11
0073a76fb000-0073a76fe000(  12.000 KiB): 5
0073a76fe000-0073a7700000(   8.000 KiB): 13
0073a7700000-0073a7711000(  68.000 KiB): 9
0073a7711000-0073a772e000( 116.000 KiB): 5
0073a772e000-0073a7730000(   8.000 KiB): 10
0073a7730000-0073a7733000(  12.000 KiB): 0
0073a7733000-0073a7734000(   4.000 KiB): 4
0073a7734000-0073a7738000(  16.000 KiB): 2
0073a7738000-0073a773b000(  12.000 KiB): 4
0073a773b000-0073a773d000(   8.000 KiB): 0
0073a773d000-0073a7745000(  32.000 KiB): 4
0073a7745000-0073a778c000( 284.000 KiB): 0
0073a778c000-0073a77a0000(  80.000 KiB): 5
0073a77a0000-0073a77a2000(   8.000 KiB): 11
0073a77a2000-0073a77a5000(  12.000 KiB): 8
0073a77a5000-0073a77fc000( 348.000 KiB): 0
0073a77fc000-0073a7805000(  36.000 KiB): 5
0073a7805000-0073a7809000(  16.000 KiB): 7
0073a7809000-0073a780b000(   8.000 KiB): 10
0073a780b000-0073a780f000(  16.000 KiB): 6
0073a780f000-0073a7811000(   8.000 KiB): 8
0073a7811000-0073a7815000(  16.000 KiB): 3
0073a7815000-0073a7817000(   8.000 KiB): 6
0073a7817000-0073a781c000(  20.000 KiB): 10
0073a781c000-0073a781f000(  12.000 KiB): 12
0073a781f000-0073a7827000(  32.000 KiB): 10
0073a7827000-0073a782a000(  12.000 KiB): 6
0073a782a000-0073a784c000( 136.000 KiB): 7
0073a784c000-0073a784d000(   4.000 KiB): 9
0073a784d000-0073a7855000(  32.000 KiB): 6
0073a7855000-0073a7860000(  44.000 KiB): 11
0073a7860000-0073a7864000(  16.000 KiB): 9
0073a7864000-0073a7865000(   4.000 KiB): 12
0073a7865000-0073a78f6000( 580.000 KiB): 7
0073a78f6000-0073a78f7000(   4.000 KiB): 0
0073a78f7000-0073a78fb000(  16.000 KiB): 7
0073a78fb000-0073a78fc000(   4.000 KiB): 0
0073a78fc000-0073a793a000( 248.000 KiB): 8
0073a793a000-0073a7941000(  28.000 KiB): 6
0073a7941000-0073a7948000(  28.000 KiB): 8
0073a7948000-0073a7953000(  44.000 KiB): 4
0073a7953000-0073a795b000(  32.000 KiB): 10
0073a795b000-0073a7961000(  24.000 KiB): 7
0073a7961000-0073a7964000(  12.000 KiB): 10
0073a7964000-0073a7967000(  12.000 KiB): 7
0073a7967000-0073a7969000(   8.000 KiB): 2
0073a7969000-0073a796b000(   8.000 KiB): 7
0073a796b000-0073a796d000(   8.000 KiB): 1
0073a796d000-0073a796f000(   8.000 KiB): 5
0073a796f000-0073a7974000(  20.000 KiB): 0
0073a7974000-0073a7975000(   4.000 KiB): 6
0073a7975000-0073a7977000(   8.000 KiB): 2
0073a7977000-0073a7978000(   4.000 KiB): 13
0073a7978000-0073a797a000(   8.000 KiB): 7
0073a797a000-0073a797d000(  12.000 KiB): 3
0073a797d000-0073a7983000(  24.000 KiB): 1
0073a7983000-0073a7985000(   8.000 KiB): 12
0073a7985000-0073a7987000(   8.000 KiB): 0
0073a7987000-0073a7994000(  52.000 KiB): 11
0073a7994000-0073a7998000(  16.000 KiB): 8
0073a7998000-0073a799d000(  20.000 KiB): 10
0073a799d000-0073a799f000(   8.000 KiB): 8
0073a799f000-0073a79a1000(   8.000 KiB): 13
0073a79a1000-0073a79a6000(  20.000 KiB): 10
0073a79a6000-0073a79ad000(  28.000 KiB): 6
0073a79ad000-0073a79b1000(  16.000 KiB): 8
0073a79b1000-0073a79b2000(   4.000 KiB): 4
0073a79b2000-0073a79b3000(   4.000 KiB): 11
0073a79b3000-0073a79b6000(  12.000 KiB): 5
0073a79b6000-0073a79b7000(   4.000 KiB): 1
0073a79b7000-0073a79d2000( 108.000 KiB): 12
0073a79d2000-0073a79f7000( 148.000 KiB): 8
0073a79f7000-0073a79f8000(   4.000 KiB): 1
0073a79f8000-0073a7a13000( 108.000 KiB): 6
0073a7a13000-0073a7a19000(  24.000 KiB): 9
0073a7a19000-0073a7a1a000(   4.000 KiB): 0
0073a7a1a000-0073a7a1b000(   4.000 KiB): 7
0073a7a1b000-0073a7a2e000(  76.000 KiB): 0
0073a7a2e000-0073a7a30000(   8.000 KiB): 3
0073a7a30000-0073a7a33000(  12.000 KiB): 0
0073a7a33000-0073a7a35000(   8.000 KiB): 4
0073a7a35000-0073a7a36000(   4.000 KiB): 9
0073a7a36000-0073a7a37000(   4.000 KiB): 12
0073a7a37000-0073a7a50000( 100.000 KiB): 4
0073a7a50000-0073a7a58000(  32.000 KiB): 6
0073a7a58000-0073a7aa1000( 292.000 KiB): 4
0073a7aa1000-0073a7b23000( 520.000 KiB): 9
0073a7b23000-0073a7b32000(  60.000 KiB): 7
0073a7b32000-0073a7b71000( 252.000 KiB): 10
0073a7b71000-0073c0c49000( 400.844 MiB): 0
0073c0c49000-0073d9ea9000( 402.375 MiB): 0
0073d9ea9000-0073f31cb000( 403.133 MiB): 0
0073f31cb000-00740c9b8000( 407.926 MiB): 0
00740c9b8000-0074179b1000( 175.973 MiB): 0
0074179b1000-0074179b2000(   4.000 KiB): 5
0074179b2000-0074179b3000(   4.000 KiB): 10
0074179b3000-0074179b7000(  16.000 KiB): 4
0074179b7000-0074179ba000(  12.000 KiB): 11
0074179ba000-0074179bb000(   4.000 KiB): 6
0074179bb000-0074179bc000(   4.000 KiB): 9
0074179bc000-0074179be000(   8.000 KiB): 5
0074179be000-0074179bf000(   4.000 KiB): 0
0074179bf000-0074179c0000(   4.000 KiB): 5
0074179c0000-0074179ca000(  40.000 KiB): 10
0074179ca000-0074179cd000(  12.000 KiB): 3
0074179cd000-0074179d0000(  12.000 KiB): 0
0074179d0000-0074179e6000(  88.000 KiB): 5
0074179e6000-00742f340000( 377.352 MiB): 0
00742f340000-0074479a6000( 390.398 MiB): 0
0074479a6000-007457a3d000( 256.590 MiB): 0
007457a3d000-007457a43000(  24.000 KiB): 7
007457a43000-007457a44000(   4.000 KiB): 12
007457a44000-007457a5c000(  96.000 KiB): 6
007457a5c000-007457a5e000(   8.000 KiB): 11
007457a5e000-007457a60000(   8.000 KiB): 6
007457a60000-007457a69000(  36.000 KiB): 0
007457a69000-007457a7f000(  88.000 KiB): 2
007457a7f000-007457a82000(  12.000 KiB): 7
007457a82000-007457a8b000(  36.000 KiB): 0
007457a8b000-007457a90000(  20.000 KiB): 2
007457a90000-007457a91000(   4.000 KiB): 8
007457a91000-007457a98000(  28.000 KiB): 5
007457a98000-007457a9a000(   8.000 KiB): 8
007457a9a000-007457aa9000(  60.000 KiB): 5
007457aa9000-007457abc000(  76.000 KiB): 2
007457abc000-007457ad8000( 112.000 KiB): 5
007457ad8000-007457ae9000(  68.000 KiB): 2
007457ae9000-007457aef000(  24.000 KiB): 0
007457aef000-007457af2000(  12.000 KiB): 4
007457af2000-007457af8000(  24.000 KiB): 7
007457af8000-007457b0a000(  72.000 KiB): 5
007457b0a000-007457b17000(  52.000 KiB): 0
007457b17000-007457b21000(  40.000 KiB): 7
007457b21000-007457b23000(   8.000 KiB): 0
007457b23000-007457b25000(   8.000 KiB): 3
007457b25000-007457b2c000(  28.000 KiB): 6
007457b2c000-007457b2e000(   8.000 KiB): 11
007457b2e000-007457b30000(   8.000 KiB): 0
007457b30000-007457b34000(  16.000 KiB): 3
007457b34000-007457b3c000(  32.000 KiB): 7
007457b3c000-007457b3e000(   8.000 KiB): 5
007457b3e000-007457b3f000(   4.000 KiB): 9
007457b3f000-007457b5b000( 112.000 KiB): 0
007457b5b000-007457b5c000(   4.000 KiB): 9
007457b5c000-007457b5e000(   8.000 KiB): 4
007457b5e000-007457b61000(  12.000 KiB): 7
007457b61000-007457b62000(   4.000 KiB): 0
007457b62000-007457b63000(   4.000 KiB): 8
007457b63000-007457b65000(   8.000 KiB): 3
007457b65000-007457b6d000(  32.000 KiB): 0
007457b6d000-007457b6f000(   8.000 KiB): 7
007457b6f000-007457b73000(  16.000 KiB): 1
007457b73000-007457b77000(  16.000 KiB): 4
007457b77000-007457b78000(   4.000 KiB): 10
007457b78000-007457b88000(  64.000 KiB): 0
007457b88000-007457b8b000(  12.000 KiB): 4
007457b8b000-007457b8d000(   8.000 KiB): 1
007457b8d000-007457b92000(  20.000 KiB): 4
007457b92000-007457baa000(  96.000 KiB): 6
007457baa000-007457bac000(   8.000 KiB): 0
007457bac000-007457bae000(   8.000 KiB): 6
007457bae000-007457bb2000(  16.000 KiB): 0
007457bb2000-007457bb5000(  12.000 KiB): 4
007457bb5000-007457bb7000(   8.000 KiB): 9
007457bb7000-007457bb8000(   4.000 KiB): 0
007457bb8000-007457bb9000(   4.000 KiB): 7
007457bb9000-007457bba000(   4.000 KiB): 0
007457bba000-007457bbc000(   8.000 KiB): 5
007457bbc000-007457bbd000(   4.000 KiB): 9
007457bbd000-007457bbe000(   4.000 KiB): 7
007457bbe000-007457bc0000(   8.000 KiB): 4
007457bc0000-007457bc1000(   4.000 KiB): 6
007457bc1000-007457bc3000(   8.000 KiB): 0
007457bc3000-007457bc6000(  12.000 KiB): 8
007457bc6000-007457bc8000(   8.000 KiB): 10
007457bc8000-007457bca000(   8.000 KiB): 6
007457bca000-007457bcf000(  20.000 KiB): 8
007457bcf000-007457bd0000(   4.000 KiB): 0
007457bd0000-007457bd1000(   4.000 KiB): 7
007457bd1000-007457bd3000(   8.000 KiB): 2
007457bd3000-007457bd5000(   8.000 KiB): 0
007457bd5000-007457bd7000(   8.000 KiB): 5
007457bd7000-007457c8c000( 724.000 KiB): 0
007457c8c000-007457cbd000( 196.000 KiB): 6
007457cbd000-007457cd0000(  76.000 KiB): 0
007457cd0000-007457d50000( 512.000 KiB): 3
007457d50000-007457dfe000( 696.000 KiB): 7
007457dfe000-007457e12000(  80.000 KiB): 5
007457e12000-0074687b1000( 265.621 MiB): 0
0074687b1000-007481a01000( 402.312 MiB): 0
007481a01000-00749997a000( 383.473 MiB): 0
00749997a000-0074b130f000( 377.582 MiB): 0
0074b130f000-0074ca3dd000( 400.805 MiB): 0
0074ca3dd000-0074e1ba0000( 375.762 MiB): 0
0074e1ba0000-0074fa5d3000( 394.199 MiB): 0
0074fa5d3000-007513006000( 394.199 MiB): 0
007513006000-007525068000( 288.383 MiB): 0
007525068000-007534c34000( 251.797 MiB): 0
007534c34000-00754ca08000( 381.828 MiB): 0
00754ca08000-007560ddc000( 323.828 MiB): 0
007560ddc000-007579e5e000( 400.508 MiB): 0
007579e5e000-007591e6d000( 384.059 MiB): 0
007591e6d000-0075a86ab000( 360.242 MiB): 0
0075a86ab000-0075bddd3000( 343.156 MiB): 0
0075bddd3000-0075d562c000( 376.348 MiB): 0
0075d562c000-0075ed81b000( 385.934 MiB): 0
0075ed81b000-00760536d000( 379.320 MiB): 0
00760536d000-00761b6c3000( 355.336 MiB): 0
00761b6c3000-007631df5000( 359.195 MiB): 0
007631df5000-00764ac4a000( 398.332 MiB): 0
00764ac4a000-007663774000( 395.164 MiB): 0
007663774000-00767a2f4000( 363.500 MiB): 0
00767a2f4000-00769004e000( 349.352 MiB): 0
00769004e000-0076a32e5000( 306.590 MiB): 0
0076a32e5000-0076ba7dc000( 372.965 MiB): 0
0076ba7dc000-0076d104c000( 360.438 MiB): 0
0076d104c000-0076e9e04000( 397.719 MiB): 0
0076e9e04000-0077005cd000( 359.785 MiB): 0
0077005cd000-0077163ad000( 349.875 MiB): 0
0077163ad000-00772f3b6000( 400.035 MiB): 0
00772f3b6000-007747429000( 384.449 MiB): 0
007747429000-00775ccc7000( 344.617 MiB): 0
00775ccc7000-007775b1d000( 398.336 MiB): 0
007775b1d000-00778d5fa000( 378.863 MiB): 0
00778d5fa000-0077a0b88000( 309.555 MiB): 0
0077a0b88000-0077b415b000( 309.824 MiB): 0
0077b415b000-0077cca1e000( 392.762 MiB): 0
0077cca1e000-0077de313000( 280.957 MiB): 0
0077de313000-0077f420d000( 350.977 MiB): 0
0077f420d000-00780d701000( 404.953 MiB): 0
00780d701000-007826047000( 393.273 MiB): 0
007826047000-007836cda000( 268.574 MiB): 0
007836cda000-00785010d000( 404.199 MiB): 0
00785010d000-0078695e1000( 404.828 MiB): 0
0078695e1000-00788210a000( 395.160 MiB): 0
00788210a000-00789b0e9000( 399.871 MiB): 0
00789b0e9000-0078b13f8000( 355.059 MiB): 0
0078b13f8000-0078c8052000( 364.352 MiB): 0
0078c8052000-0078d8b7e000( 267.172 MiB): 0
0078d8b7e000-0078eb5e6000( 298.406 MiB): 0
0078eb5e6000-007904c7e000( 406.594 MiB): 0
007904c7e000-00791bbef000( 367.441 MiB): 0
00791bbef000-00792887d000( 204.555 MiB): 0
00792887d000-007941070000( 391.949 MiB): 0
007941070000-007955283000( 322.074 MiB): 0
007955283000-00796e01c000( 397.598 MiB): 0
00796e01c000-0079870e8000( 400.797 MiB): 0
0079870e8000-0079972d5000( 257.926 MiB): 0
0079972d5000-0079ada20000( 359.293 MiB): 0
0079ada20000-0079c66f9000( 396.848 MiB): 0
0079c66f9000-0079df2f4000( 395.980 MiB): 0
0079df2f4000-0079f4943000( 342.309 MiB): 0
0079f4943000-007a0918c000( 328.285 MiB): 0
007a0918c000-007a21cd9000( 395.301 MiB): 0
007a21cd9000-007a3a8e6000( 396.051 MiB): 0
007a3a8e6000-007a51841000( 367.355 MiB): 0
007a51841000-007a66e4a000( 342.035 MiB): 0
007a66e4a000-007a72270000( 180.148 MiB): 0
007a72270000-007a8a370000( 385.000 MiB): 0
007a8a370000-007a9b42e000( 272.742 MiB): 0
007a9b42e000-007aafd69000( 329.230 MiB): 0
007aafd69000-007ac7e3a000( 384.816 MiB): 0
007ac7e3a000-007adfbbc000( 381.508 MiB): 0
007adfbbc000-007af6579000( 361.738 MiB): 0
007af6579000-007b0c320000( 349.652 MiB): 0
007b0c320000-007b1f4b2000( 305.570 MiB): 0
007b1f4b2000-007b380d9000( 396.152 MiB): 0
007b380d9000-007b516be000( 405.895 MiB): 0
007b516be000-007b69d9b000( 390.863 MiB): 0
007b69d9b000-007b8206a000( 386.809 MiB): 0
007b8206a000-007b92bf0000( 267.523 MiB): 0
007b92bf0000-007ba1d2a000( 241.227 MiB): 0
007ba1d2a000-007bb716c000( 340.258 MiB): 0
007bb716c000-007bd0252000( 400.898 MiB): 0
007bd0252000-007be5ad8000( 344.523 MiB): 0
007be5ad8000-007bfc6f6000( 364.117 MiB): 0
007bfc6f6000-007c148e4000( 385.930 MiB): 0
007c148e4000-007c2bf85000( 374.629 MiB): 0
007c2bf85000-007c401ce000( 322.285 MiB): 0
007c401ce000-007c57cd1000( 379.012 MiB): 0
007c57cd1000-007c70b1c000( 398.293 MiB): 0
007c70b1c000-007c8895e000( 382.258 MiB): 0
007c8895e000-007c9fca1000( 371.262 MiB): 0
007c9fca1000-007cb6566000( 360.770 MiB): 0
007cb6566000-007cce54f000( 383.910 MiB): 0
007cce54f000-007ce6ef9000( 393.664 MiB): 0
007ce6ef9000-007cff709000( 392.062 MiB): 0
007cff709000-007d158ba000( 353.691 MiB): 0
007d158ba000-007d2e725000( 398.418 MiB): 0
007d2e725000-007d46614000( 382.934 MiB): 0
007d46614000-007d5e963000( 387.309 MiB): 0
007d5e963000-007d6b9d0000( 208.426 MiB): 0
007d6b9d0000-007d843c4000( 393.953 MiB): 0
007d843c4000-007d9aa8a000( 358.773 MiB): 0
007d9aa8a000-007db1101000( 358.465 MiB): 0
007db1101000-007dc8fb0000( 382.684 MiB): 0
007dc8fb0000-007de1fc3000( 400.074 MiB): 0
007de1fc3000-007df9408000( 372.270 MiB): 0
007df9408000-007e09ae4000( 262.859 MiB): 0
007e09ae4000-007e21d3b000( 386.340 MiB): 0
007e21d3b000-007e3921e000( 372.887 MiB): 0
007e3921e000-007e519f0000( 391.820 MiB): 0
007e519f0000-007e63a63000( 288.449 MiB): 0
007e63a63000-007e7a69c000( 364.223 MiB): 0
007e7a69c000-007e8c3b9000( 285.113 MiB): 0
007e8c3b9000-007ea3ed2000( 379.098 MiB): 0
007ea3ed2000-007eb6e90000( 303.742 MiB): 0
007eb6e90000-007ecbdeb000( 335.355 MiB): 0
007ecbdeb000-007ee2f8e000( 369.637 MiB): 0
007ee2f8e000-007ef9ec8000( 367.227 MiB): 0
007ef9ec8000-007f12ac7000( 395.996 MiB): 0
007f12ac7000-007f2c18f000( 406.781 MiB): 0
007f2c18f000-007f43c22000( 378.574 MiB): 0
007f43c22000-007f5baee000( 382.797 MiB): 0
007f5baee000-007f74a66000( 399.469 MiB): 0
007f74a66000-007f8caaf000( 384.285 MiB): 0
007f8caaf000-007fa423b000( 375.547 MiB): 0
007fa423b000-007fb9fb6000( 349.480 MiB): 0
007fb9fb6000-007fd29ae000( 393.969 MiB): 0
007fd29ae000-007fdbd6e000( 147.750 MiB): 0

Though I am not quite sure if it is accurate enough :-) so fixed-gran would be
a nice feature.

> On my x86 test machine, the 'min_nr_regions' was respected:
>
>     $ sudo damo record --minr 100 paddr
>     [...]
>     $ sudo damo report nr_regions
>     # <percentile> <# regions>
>     # target_id     0
>     # avr:  111
>     0       109
>     25      111
>     50      111
>     75      113
>     100     116
>
> Unfortunately, 'damo monitor' has no option to set the min_nr_regions.  You
> could modify the default value of the option of damo-record on 'damo_record.py'
> for the case.  Sorry for your inconvenient.
>
> >
> > > If we don't see small regions having some non-zero access frequency, we would
> > > be better to be worried.  However, it is finding the small 4 KiB regions having
> > > higher access frequency successfully.  The 4 KiB region is not because the
> > > region is having 4 KiB VMA, but the address region shows high access frequency.
> > >
> > > >
> > > > Typical characteristics of a large Android app is that it has
> > > > thousands of vma and very large virtual address spaces:
> > > > ~/damo # pmap 2550 | wc -l
> > > > 8522
> > > >
> > > > ~/damo # pmap 2550
> > > > ...
> > > > 0000007992bbe000      4K r----   [ anon ]
> > > > 0000007992bbf000     24K rw---   [ anon ]
> > > > 0000007fe8753000      4K -----   [ anon ]
> > > > 0000007fe8754000   8188K rw---   [ stack ]
> > > >  total         36742112K
> > > >
> > > > Because the whole vma list is too long, I have put the list here for
> > > > you to download:
> > > > wget http://www.linuxep.com/patches/android-app-vmas
> > > >
> > > > I can reproduce this problem on other Apps like youtube as well.
> > > > I suppose we need to boost the algorithm of splitting regions for this
> > > > kind of application.
> > > > Any thoughts?
> > >
> > > As mentioned above, this looks not a problem, as DAMON's monitoring regions is
> > > not constructed based on VMAs but access patterns.
> >
> > What makes me believe it is a problem is that it seems we are getting
> > an incorrect
> > wss based on the data reported from kernel:
> > ~/damo # ./damo monitor --report_type wss --count 20 2561
> > # <percentile> <wss>
> > # target_id 0
> > # avr: 443.854 MiB
> >   0             0 B |
> >          |
> >  25       4.000 KiB |
> >          |
> >  50      12.000 KiB |
> >          |
> >  75      20.000 KiB |
> >          |
> > 100       5.851 GiB
> > |***********************************************************|
> [...]
> >
> > And I have a question, what do percentile 0,25,50,75 mean here?
> > Why are they so different with percentile 100?
> > For example, 0,25,50,75 has only KiB but 100 has GiB.
>
> For each aggregation interval, we get one snapshot.  So, if we have a
> monitoring results that recorded for, say, 100 aggregation interval, we have
> 100 snapshots.  'damo' calculates working set size of each snapshot by summing
> size of regions assumed to be accessed at least once.  So, in this example, we
> get 100 wss values.  Then, 'damo' sorts the values and provides the smallest
> one as 0-th percentile, 25th small value as 25-th percentile, and so on.
>
> 100-th percentile wss is usually noisy, as DAMON regions shouldn't be converged
> well at the beginning of the record.  I believe that could be the reason why
> the 100-th percentile wss is so unexpectedly big.
>
> I personally use 50-th percentile as reliable value.

Thanks, it seems you mean if we get 100 snapshots with values exactly as
2, 4, 6, 8, 10..... , 198, 200 (just an example)

for 25%, we will get 50; for 50%, we will get 100; for 75%, we will
get 150, for 100%,
we will get 200. Right?

I am not quite sure I understand "as DAMON regions shouldn't be converged well
at the beginning of the record", in case we are monitoring with
--count=2000, I suppose
only at the beginning, regions are not splitted very well? When we
have run monitor
for a while, regions should have been relatively stable? I mean I
don't quite understand
why 100% is noise and 50% is more reliable.

>
> >
> > I guess Asphalt 9 should be normally accessing hundreds of megabytes of memory.
>
> Each wss value is calculated for each aggregation interval.  That is, the wss
> value is amount of memory that accessed within an aggregation interval.  As the
> default aggregation interval is 100ms, the working set size could be smaller
> than your expectation.
>
> For such cases, 'damo report wss' has an option called '--work_time' to
> simulate higher aggregation intervals.  That is, you can get the total size of
> the memory regions that DAMON shown access to those within arbitrary amount of
> time using the option.  'damo monitor' doesn't support the option at the
> moment, though.
>
> >
> > >
> > > Nevertheless, I believe there are many rooms for improvement of DAMON's access
> > > frequency.  I want to implement fixed-gran monitoring feature first, and
> > > develop some accuracy optimizations using the fixed-gran monitoring as
> > > comparison target.
> >
> > Does fixed-gran mean splitting VA to some regions equally with the same size?
> > for example, if we have 1GB VA, we split it into 512 regions in 2MB
> > size, something like that?
>
> Yes, exactly.  That's the idea.  It would incur much higher, and unbounded
> overhead, but could be a good comparison target for accuracy improvement of
> DAMON.  Also, for some environments that doesn't care about the monitoring
> overhead, it could be used well.
>
>
> Thanks,
> SJ
>
> > >
> > > If I'm missing something or the explanation was not enough, please feel free to
> > > let me know.
> > >
> > >
> > > Thank,
> > > SJ
> > >

Thanks
Barry
