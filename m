Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B7E48510EB0
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Apr 2022 04:21:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1357078AbiD0CLa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Apr 2022 22:11:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49072 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245579AbiD0CL1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Apr 2022 22:11:27 -0400
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com [IPv6:2a00:1450:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 358953631A
        for <linux-kernel@vger.kernel.org>; Tue, 26 Apr 2022 19:08:17 -0700 (PDT)
Received: by mail-ed1-x52d.google.com with SMTP id k27so350326edk.4
        for <linux-kernel@vger.kernel.org>; Tue, 26 Apr 2022 19:08:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=HkaWNsEVaMQw479ofHFExjyxelKNB58BbBelahXQPlE=;
        b=VEJGDPfQ6qwbUuqLPHSAnMAbq7R51wd+qb+J8rfuBv4zmp7XyCo6sNHc2v5nx3JU39
         aH7GuNMyfUs3mDOHQUEZQBQWM3744MvnV6FqfEoppQDKIDFgIqcUvSZh5SGT1JHd+Mk+
         atqOhys+ESvWfuS6B441nkMTVWmzjGCA/Q5cKgYGj+ha4/EfkO0N45vyeZOUF9ijmngr
         NlzaKbOjvoFUx8qVYsgGM4U7EnI0wRCmJQIWOBktklQSnOqEZoxbZIC8TrrQpbzjWi0w
         XAUGUBZM5JzBQ/B64zso2TN970xW0jgvLVedLKuaa3SY+R/5NGfNq51H71TK664sn3v/
         Z4Yg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=HkaWNsEVaMQw479ofHFExjyxelKNB58BbBelahXQPlE=;
        b=kcf1EAKU+z9vm79u3KbL+mIll2H7miZQtxXrtnt4+KYIac/wUElKI1NKg3ti2GMcMH
         0cyBqJBp3PQwfP/pPOOHuvSb08lGX/lOZxX06ma3UoL5iorWI9L3TOprAJSJOiOu4a9P
         uvlEqTKUcG6cKU6i8pQ5IGh7c0cvUfx6YQ9hBGcYQKnbbA8RRngfBYPnEHMgOf9GmpXm
         6I6x8JBSLozMUgYRyl4ChwkW79gpp6a6wbx+lXipCYlGhdYdpj7ylEglW9M4O3fVLLRV
         +ZOHlNwS9rET4LOvJYjZS8vUKDAvGFcVaE/f0tZvRXZ1ih0cuFPcPpQi8BLcQmRDlNWM
         Nq8Q==
X-Gm-Message-State: AOAM533Hz4iOmR2VI/Hv2VHx+Pl7DK3efi2F7fS0a5Ssg7dolLg3Ywse
        hJyJBlk6NCpKGyZAuLztsZGWiDzY1o0nBbL83uVjcbijHJI=
X-Google-Smtp-Source: ABdhPJyVBhs7VHmrmlWr68/1smHstMNnHHSDukx63pzvuxvhyA0VKe6LaIBVf4BR8YFW8bvrjH+nd4F5bN6NMRCVrQw=
X-Received: by 2002:a05:6402:2214:b0:425:d6ed:de5d with SMTP id
 cq20-20020a056402221400b00425d6edde5dmr18728793edb.383.1651025295582; Tue, 26
 Apr 2022 19:08:15 -0700 (PDT)
MIME-Version: 1.0
References: <CAGsJ_4x_k9009HwpTswEq1ut_co8XYdpZ9k0BVW=0=HRiifxkA@mail.gmail.com>
 <20220427002125.48937-1-sj@kernel.org>
In-Reply-To: <20220427002125.48937-1-sj@kernel.org>
From:   Barry Song <21cnbao@gmail.com>
Date:   Wed, 27 Apr 2022 14:08:04 +1200
Message-ID: <CAGsJ_4wUa0i0nq61C01hb18Czpg-EuzHqH_NN=Xcfr+tKoqMCQ@mail.gmail.com>
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

On Wed, Apr 27, 2022 at 12:21 PM <sj@kernel.org> wrote:
>
> Hello Barry,
>
>
> Thank you so much for sharing your great findings! :)

Thanks for your quick response.

>
> On Wed, 27 Apr 2022 11:19:23 +1200 Barry Song <21cnbao@gmail.com> wrote:
>
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
> >         volatile int *p = malloc(size);
> >         memset(p, 0x55, size);
> >
> >         while(1) {
> >                 int i;
> >                 for (i = 0; i < size / 4; i++)
> >                         (void)*(p + i);
> >                 usleep(1000);
> >
> >                 for (i = 0; i < size / 16; i++)
> >                         (void)*(p + i);
> >                 usleep(1000);
> >
> >         }
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
>
> In short, DAMON doesn't set regions based on VMA but access pattern, and
> therefore this looks not a problem.
>
> DAMON allows users set min/max monitoring overhead limit and provides a best
> accuracy under the condition.  In detail, users are allowed to set the min/max
> monitoring regions as DAMON's monitoring overhead is proportional to the number
> of regions.  DAMON provides best effort accuracy under the condition by
> splitting and merging regions so that pages in each region has different access
> frequency.
>
> The default min number of regions is 10.  I believe that's why there are many 6
> GiB regions.
>

i had actually tried to set min regions to 100 as below:
/sys/kernel/debug/damon # echo 5000 100000 60000000 100 1000 > attrs
/sys/kernel/debug/damon # cat attrs
5000 100000 60000000 100 1000

but it seems i am still only getting regions like 16:

monitoring_start:          805.192 ms
monitoring_end:            905.385 ms
monitoring_duration:       100.193 ms
target_id: 0
nr_regions: 16
000012c00000-0001fc021000(   7.645 GiB): 0
0001fc021000-0003e6b9a000(   7.667 GiB): 0
0003e6b9a000-000400000000( 404.398 MiB): 0
005e95645000-005e9564a000(  20.000 KiB): 0
005e9564a000-005e9564b000(   4.000 KiB): 8
005e9564b000-005e9564c000(   4.000 KiB): 1
005e9564c000-005e9564f000(  12.000 KiB): 0
006ffffff000-0071fa4f8000(   7.911 GiB): 0
0071fa4f8000-0073dacd1000(   7.508 GiB): 0
0073dacd1000-00759533c000(   6.913 GiB): 0
00759533c000-0076cc999000(   4.866 GiB): 0
0076cc999000-00788bea1000(   6.989 GiB): 0
00788bea1000-007a6fe14000(   7.562 GiB): 0
007a6fe14000-007c5c4a3000(   7.694 GiB): 0
007c5c4a3000-007df9bd8000(   6.460 GiB): 0
007df9bd8000-007fe6d7b000(   7.705 GiB): 0

so it seems the 100 set in min regions doesn't mean we will have at
least 100 regions?

> If we don't see small regions having some non-zero access frequency, we would
> be better to be worried.  However, it is finding the small 4 KiB regions having
> higher access frequency successfully.  The 4 KiB region is not because the
> region is having 4 KiB VMA, but the address region shows high access frequency.
>
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
> >  total         36742112K
> >
> > Because the whole vma list is too long, I have put the list here for
> > you to download:
> > wget http://www.linuxep.com/patches/android-app-vmas
> >
> > I can reproduce this problem on other Apps like youtube as well.
> > I suppose we need to boost the algorithm of splitting regions for this
> > kind of application.
> > Any thoughts?
>
> As mentioned above, this looks not a problem, as DAMON's monitoring regions is
> not constructed based on VMAs but access patterns.

What makes me believe it is a problem is that it seems we are getting
an incorrect
wss based on the data reported from kernel:
~/damo # ./damo monitor --report_type wss --count 20 2561
# <percentile> <wss>
# target_id 0
# avr: 443.854 MiB
  0             0 B |
         |
 25       4.000 KiB |
         |
 50      12.000 KiB |
         |
 75      20.000 KiB |
         |
100       5.851 GiB
|***********************************************************|

# <percentile> <wss>
# target_id 0
# avr: 666.112 MiB
  0             0 B |
         |
 25       4.000 KiB |
         |
 50       8.000 KiB |
         |
 75      20.000 KiB |
         |
100       6.159 GiB
|***********************************************************|

# <percentile> <wss>
# target_id 0
# avr: 566.706 MiB
  0             0 B |
         |
 25       4.000 KiB |
         |
 50      20.000 KiB |
         |
 75      36.000 KiB |
         |
100       4.654 GiB
|***********************************************************|

# <percentile> <wss>
# target_id 0
# avr: 977.249 MiB
  0       4.000 KiB |
         |
 25      12.000 KiB |
         |
 50      20.000 KiB |
         |
 75      20.000 KiB |
         |
100       8.798 GiB
|***********************************************************|

# <percentile> <wss>
# target_id 0
# avr: 837.221 MiB
  0             0 B |
         |
 25             0 B |
         |
 50      20.000 KiB |
         |
 75     422.656 MiB |****
         |
100       5.113 GiB
|***********************************************************|

# <percentile> <wss>
# target_id 0
# avr: 456.690 MiB
  0       4.000 KiB |
         |
 25       5.180 MiB |
         |
 50      10.023 MiB |
         |
 75      84.137 MiB |*
         |
100       4.503 GiB
|***********************************************************|

# <percentile> <wss>
# target_id 0
# avr: 179.652 MiB
  0             0 B |
         |
 25       4.000 KiB |
         |
 50       4.000 KiB |
         |
 75      20.000 KiB |
         |
100       3.166 GiB
|***********************************************************|

# <percentile> <wss>
# target_id 0
# avr: 878.505 MiB
  0       4.000 KiB |
         |
 25       4.000 KiB |
         |
 50      12.000 KiB |
         |
 75      20.000 KiB |
         |
100       6.741 GiB
|***********************************************************|

# <percentile> <wss>
# target_id 0
# avr: 1.000 GiB
  0       4.000 KiB |
         |
 25       4.000 KiB |
         |
 50      12.000 KiB |
         |
 75    1004.711 MiB |*******
         |
100       7.706 GiB
|***********************************************************|

# <percentile> <wss>
# target_id 0
# avr: 1.187 GiB
  0             0 B |
         |
 25       8.000 KiB |
         |
 50      16.000 KiB |
         |
 75     757.449 MiB |*******
         |
100       5.964 GiB
|***********************************************************|

# <percentile> <wss>
# target_id 0
# avr: 991.889 MiB
  0             0 B |
         |
 25             0 B |
         |
 50      36.000 KiB |
         |
 75       1.824 GiB |************************
         |
100       4.399 GiB
|***********************************************************|

# <percentile> <wss>
# target_id 0
# avr: 545.213 MiB
  0             0 B |
         |
 25       4.000 KiB |
         |
 50       8.000 KiB |
         |
 75      24.000 KiB |
         |
100       6.270 GiB
|***********************************************************|

# <percentile> <wss>
# target_id 0
# avr: 523.257 MiB
  0             0 B |
         |
 25             0 B |
         |
 50       8.000 KiB |
         |
 75      28.000 KiB |
         |
100       3.789 GiB
|***********************************************************|

# <percentile> <wss>
# target_id 0
# avr: 1.395 GiB
  0             0 B |
         |
 25       8.000 KiB |
         |
 50      40.000 KiB |
         |
 75       1.555 GiB |**************
         |
100       6.220 GiB
|***********************************************************|

# <percentile> <wss>
# target_id 0
# avr: 685.373 MiB
  0             0 B |
         |
 25             0 B |
         |
 50       8.000 KiB |
         |
 75      28.000 KiB |
         |
100       5.984 GiB
|***********************************************************|

# <percentile> <wss>
# target_id 0
# avr: 411.626 MiB
  0             0 B |
         |
 25             0 B |
         |
 50       8.000 KiB |
         |
 75      20.000 KiB |
         |
100       3.958 GiB
|***********************************************************|

# <percentile> <wss>
# target_id 0
# avr: 402.370 MiB
  0             0 B |
         |
 25             0 B |
         |
 50             0 B |
         |
 75      12.000 KiB |
         |
100       6.263 GiB
|***********************************************************|

# <percentile> <wss>
# target_id 0
# avr: 656.361 MiB
  0             0 B |
         |
 25             0 B |
         |
 50             0 B |
         |
 75      28.000 KiB |
         |
100       5.275 GiB
|***********************************************************|

# <percentile> <wss>
# target_id 0
# avr: 189.350 MiB
  0             0 B |
         |
 25             0 B |
         |
 50       8.000 KiB |
         |
 75      20.000 KiB |
         |
100       3.698 GiB
|***********************************************************|

# <percentile> <wss>
# target_id 0
# avr: 489.517 MiB
  0             0 B |
         |
 25             0 B |
         |
 50      12.000 KiB |
         |
 75      32.000 KiB |
         |
100       4.663 GiB
|***********************************************************|

And I have a question, what do percentile 0,25,50,75 mean here?
Why are they so different with percentile 100?
For example, 0,25,50,75 has only KiB but 100 has GiB.

I guess Asphalt 9 should be normally accessing hundreds of megabytes of memory.

>
> Nevertheless, I believe there are many rooms for improvement of DAMON's access
> frequency.  I want to implement fixed-gran monitoring feature first, and
> develop some accuracy optimizations using the fixed-gran monitoring as
> comparison target.

Does fixed-gran mean splitting VA to some regions equally with the same size?
for example, if we have 1GB VA, we split it into 512 regions in 2MB
size, something like that?
>
> If I'm missing something or the explanation was not enough, please feel free to
> let me know.
>
>
> Thank,
> SJ
>
> >
> > Thanks
> > Barry
> >

Thanks
Barry
