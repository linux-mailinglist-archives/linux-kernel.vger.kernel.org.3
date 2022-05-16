Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 97720527E03
	for <lists+linux-kernel@lfdr.de>; Mon, 16 May 2022 09:04:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240650AbiEPHEN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 May 2022 03:04:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50670 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238075AbiEPHEL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 May 2022 03:04:11 -0400
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com [IPv6:2a00:1450:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D8B2DFBF
        for <linux-kernel@vger.kernel.org>; Mon, 16 May 2022 00:04:06 -0700 (PDT)
Received: by mail-ej1-x631.google.com with SMTP id i27so26725649ejd.9
        for <linux-kernel@vger.kernel.org>; Mon, 16 May 2022 00:04:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ghI1ogo+duQXi1Z/u80HHdV9SuiqzEwKV8u7i8Howyg=;
        b=IbDU4IG5HsEOWwzOl40WmDPBdKuF9CSAYaiigkGuL2b0Bj8oSNHf84J4Rp/xxpDgDW
         0kpB9fJS0mLgKHVLWeEjhMAvfSzt8g4LewX7HD0FYpzdgi2sshHTKT8ksmQoLNdYH1pm
         DfbInRH2kAE2W7OOaLsI93nrlnvQkN9jchSDZuUKcUkPtd3KIPycIxCItodBM0pT/AZ7
         iaTIyEDTY9gZ+u+fEEkoKnmhE3bgHH1BnqQHAFKXlYyyrW4TcbEwvCL+Nppx2Px4YzjY
         Z0VHkpL4noHI24M7cKOsdOyDp5MpSC2p2APOnyHanL57zamAKmFiBVHEi92F4GPK2HjI
         WcPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ghI1ogo+duQXi1Z/u80HHdV9SuiqzEwKV8u7i8Howyg=;
        b=48NA9gHbCrupXRbHChyx58HRDdfabDBKnCIPOocUELWNbcQsAGyTwOxVlIUOCYKx8y
         4H8M8txvYacie/CipKpXsTewgNYmOyfBnqjX/akdIZO1h5pXVamO90zuCbVtOwBzpPEE
         KPM+hD2ikivoDof7KfBT61tkvluSSd+dVuV6Y0KZwIqL4rd2bEtPoH9BHKzNgiHK2VfI
         8QbGAJjVVBuYhHq8hRMx/WtVuN+7rBLYY8UTrxm9RPXR5FR7/1EeJl5QKORy7xTv3Mu9
         0uEMb68n4B6/dqveUXfAaTdL4PZia4JnIZT0MfJLSndn7zaV7Yqvnvp/HS/P7NlGkI9q
         rVnQ==
X-Gm-Message-State: AOAM533OzB6WITHypScL+PNtC3sxcO+aDfQLzDdbBZmpF+IHyRZTGKN6
        UTpicQd0Oc/z6B/7dEmUuDgywjYxC1x9J/PrCHM=
X-Google-Smtp-Source: ABdhPJxqB50s2ExIeidD7b631YiJ74fsGuyBHjaa9c7Rftr1vRLNUv8V7oq7saYigspr+eRwy5E9dwX1bqNlyQc1NdI=
X-Received: by 2002:a17:906:a453:b0:6f5:132c:1a10 with SMTP id
 cb19-20020a170906a45300b006f5132c1a10mr14089263ejb.746.1652684644452; Mon, 16
 May 2022 00:04:04 -0700 (PDT)
MIME-Version: 1.0
References: <CAGsJ_4x_k9009HwpTswEq1ut_co8XYdpZ9k0BVW=0=HRiifxkA@mail.gmail.com>
 <e3c1beb1-e3d5-6e26-bae2-06785080b57e@linux.alibaba.com> <CAGsJ_4weJ9onh0EJVy8QXMXZ++4qVyVuRi7oP3wiD0XWnqF-Dg@mail.gmail.com>
 <CAGsJ_4z8vMNDwL4uYB6_=txvm9zW7LKrFA2HChS2D-+fxhBiKA@mail.gmail.com>
 <08fff4b9-3ae9-db68-13bb-cf5f0654e20a@linux.alibaba.com> <CAGsJ_4wKqPEnFGdijwjKeCvfRwfdxkk-263EZt2Y21GMyn1_uA@mail.gmail.com>
In-Reply-To: <CAGsJ_4wKqPEnFGdijwjKeCvfRwfdxkk-263EZt2Y21GMyn1_uA@mail.gmail.com>
From:   Barry Song <21cnbao@gmail.com>
Date:   Mon, 16 May 2022 19:03:53 +1200
Message-ID: <CAGsJ_4z2TT5H2PO+mvgMSnL3h5ke=QVhFzDmYs6yOgwgB24bhg@mail.gmail.com>
Subject: Re: DAMON VA regions don't split on an large Android APP
To:     Rongwei Wang <rongwei.wang@linux.alibaba.com>
Cc:     sj@kernel.org, Andrew Morton <akpm@linux-foundation.org>,
        Linux-MM <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Matthew Wilcox <willy@infradead.org>, shuah@kernel.org,
        Brendan Higgins <brendanhiggins@google.com>,
        foersleo@amazon.de, sieberf@amazon.com,
        Shakeel Butt <shakeelb@google.com>, sjpark@amazon.de,
        tuhailong@gmail.com, Song Jiang <sjiang88@gmail.com>,
        =?UTF-8?B?5byg6K+X5piOKFNpbW9uIFpoYW5nKQ==?= 
        <zhangshiming@oppo.com>,
        =?UTF-8?B?5p2O5Z+56ZSLKHdpbmsp?= <lipeifeng@oppo.com>,
        xhao@linux.alibaba.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 28, 2022 at 7:37 PM Barry Song <21cnbao@gmail.com> wrote:
>
> On Thu, Apr 28, 2022 at 2:05 PM Rongwei Wang
> <rongwei.wang@linux.alibaba.com> wrote:
> >
> >
> >
> > On 4/27/22 5:22 PM, Barry Song wrote:
> > > On Wed, Apr 27, 2022 at 7:44 PM Barry Song <21cnbao@gmail.com> wrote:
> > >>
> > >> On Wed, Apr 27, 2022 at 6:56 PM Rongwei Wang
> > >> <rongwei.wang@linux.alibaba.com> wrote:
> > >>>
> > >>>
> > >>>
> > >>> On 4/27/22 7:19 AM, Barry Song wrote:
> > >>>> Hi SeongJae & Andrew,
> > >>>> (also Cc-ed main damon developers)
> > >>>> On an Android phone, I tried to use the DAMON vaddr monitor and found
> > >>>> that vaddr regions don't split well on large Android Apps though
> > >>>> everything works well on native Apps.
> > >>>>
> > >>>> I have tried the below two cases on an Android phone with 12GB memory
> > >>>> and snapdragon 888 CPU.
> > >>>> 1. a native program with small memory working set  as below,
> > >>>> #define size (1024*1024*100)
> > >>>> main()
> > >>>> {
> > >>>>           volatile int *p = malloc(size);
> > >>>>           memset(p, 0x55, size);
> > >>>>
> > >>>>           while(1) {
> > >>>>                   int i;
> > >>>>                   for (i = 0; i < size / 4; i++)
> > >>>>                           (void)*(p + i);
> > >>>>                   usleep(1000);
> > >>>>
> > >>>>                   for (i = 0; i < size / 16; i++)
> > >>>>                           (void)*(p + i);
> > >>>>                   usleep(1000);
> > >>>>
> > >>>>           }
> > >>>> }
> > >>>> For this application, the Damon vaddr monitor works very well.
> > >>>> I have modified monitor.py in the damo userspace tool a little bit to
> > >>>> show the raw data getting from the kernel.
> > >>>> Regions can split decently on this kind of applications, a typical raw
> > >>>> data is as below,
> > >>>>
> > >>>> monitoring_start:             2.224 s
> > >>>> monitoring_end:               2.329 s
> > >>>> monitoring_duration:       104.336 ms
> > >>>> target_id: 0
> > >>>> nr_regions: 24
> > >>>> 005fb37b2000-005fb734a000(  59.594 MiB): 0
> > >>>> 005fb734a000-005fbaf95000(  60.293 MiB): 0
> > >>>> 005fbaf95000-005fbec0b000(  60.461 MiB): 0
> > >>>> 005fbec0b000-005fc2910000(  61.020 MiB): 0
> > >>>> 005fc2910000-005fc6769000(  62.348 MiB): 0
> > >>>> 005fc6769000-005fca33f000(  59.836 MiB): 0
> > >>>> 005fca33f000-005fcdc8b000(  57.297 MiB): 0
> > >>>> 005fcdc8b000-005fd115a000(  52.809 MiB): 0
> > >>>> 005fd115a000-005fd45bd000(  52.387 MiB): 0
> > >>>> 007661c59000-007661ee4000(   2.543 MiB): 2
> > >>>> 007661ee4000-0076623e4000(   5.000 MiB): 3
> > >>>> 0076623e4000-007662837000(   4.324 MiB): 2
> > >>>> 007662837000-0076630f1000(   8.727 MiB): 3
> > >>>> 0076630f1000-007663494000(   3.637 MiB): 2
> > >>>> 007663494000-007663753000(   2.746 MiB): 1
> > >>>> 007663753000-007664251000(  10.992 MiB): 3
> > >>>> 007664251000-0076666fd000(  36.672 MiB): 2
> > >>>> 0076666fd000-007666e73000(   7.461 MiB): 1
> > >>>> 007666e73000-007667c89000(  14.086 MiB): 2
> > >>>> 007667c89000-007667f97000(   3.055 MiB): 0
> > >>>> 007667f97000-007668112000(   1.480 MiB): 1
> > >>>> 007668112000-00766820f000(1012.000 KiB): 0
> > >>>> 007ff27b7000-007ff27d6000( 124.000 KiB): 0
> > >>>> 007ff27d6000-007ff27d8000(   8.000 KiB): 8
> > >>>>
> > >>>> 2. a large Android app like Asphalt 9
> > >>>> For this case, basically regions can't split very well, but monitor
> > >>>> works on small vma:
> > >>>>
> > >>>> monitoring_start:             2.220 s
> > >>>> monitoring_end:               2.318 s
> > >>>> monitoring_duration:        98.576 ms
> > >>>> target_id: 0
> > >>>> nr_regions: 15
> > >>>> 000012c00000-0001c301e000(   6.754 GiB): 0
> > >>>> 0001c301e000-000371b6c000(   6.730 GiB): 0
> > >>>> 000371b6c000-000400000000(   2.223 GiB): 0
> > >>>> 005c6759d000-005c675a2000(  20.000 KiB): 0
> > >>>> 005c675a2000-005c675a3000(   4.000 KiB): 3
> > >>>> 005c675a3000-005c675a7000(  16.000 KiB): 0
> > >>>> 0072f1e14000-0074928d4000(   6.510 GiB): 0
> > >>>> 0074928d4000-00763c71f000(   6.655 GiB): 0
> > >>>> 00763c71f000-0077e863e000(   6.687 GiB): 0
> > >>>> 0077e863e000-00798e214000(   6.590 GiB): 0
> > >>>> 00798e214000-007b0e48a000(   6.002 GiB): 0
> > >>>> 007b0e48a000-007c62f00000(   5.323 GiB): 0
> > >>>> 007c62f00000-007defb19000(   6.199 GiB): 0
> > >>>> 007defb19000-007f794ef000(   6.150 GiB): 0
> > >>>> 007f794ef000-007fe8f53000(   1.745 GiB): 0
> > >>>>
> > >>>> As you can see, we have some regions which are very very big and they
> > >>>> are losing the chance to be splitted. But
> > >>>> Damon can still monitor memory access for those small VMA areas very well like:
> > >>>> 005c675a2000-005c675a3000(   4.000 KiB): 3
> > >>> Hi, Barry
> > >>>
> > >>> Actually, we also had found the same problem in redis by ourselves
> > >>> tool[1]. The DAMON can not split the large anon VMA well, and the anon
> > >>> VMA has 10G~20G memory. I guess the whole region doesn't have sufficient
> > >>> hot areas to been monitored or found by DAMON, likes one or more address
> > >>> choose by DAMON not been accessed during sample period.
> > >>
> > >> Hi Rongwei,
> > >> Thanks  for your comments and thanks for sharing your tools.
> > >>
> > >> I guess the cause might be:
> > >> in case a region is very big like 10GiB, we have only 1MiB hot pages
> > >> in this large region.
> > >> damon will randomly pick one page to sample, but the page has only
> > >> 1MiB/10GiB, thus
> > >> less than 1/10000 chance to hit the hot 1MiB. so probably we need
> > >> 10000 sample periods
> > >> to hit the hot 1MiB in order to split this large region?
> > >>
> > >> @SeongJae, please correct me if I am wrong.
> > >>
> > >>>
> > >>> I'm not sure whether sets init_regions can deal with the above problem,
> > >>> or dynamic choose one or limited number VMA to monitor.
> > >>>
> > >>
> > >> I won't set a limited number of VMA as this will make the damon too hard to use
> > >> as nobody wants to make such complex operations, especially an Android
> > >> app might have more than 8000 VMAs.
> > >>
> > >> I agree init_regions might be the right place to enhance the situation.
> > >>
> > >>> I'm not sure, just share my idea.
> > >>>
> > >>> [1] https://github.com/aliyun/data-profile-tools.git
> > >>
> > >> I suppose this tool is based on damon? How do you finally resolve the problem
> > >> that large anon VMAs can't be splitted?
> > >> Anyway, I will give your tool a try.
> > >
> > > Unfortunately, data-profile-tools.git doesn't build on aarch64 ubuntu
> > > though autogen.sh
> > > runs successfully.
> > >
> > > /usr/bin/ld: ./.libs/libdatop.a(disp.o): in function `cons_handler':
> > > /root/data-profile-tools/src/disp.c:625: undefined reference to `stdscr'
> > > /usr/bin/ld: /root/data-profile-tools/src/disp.c:625: undefined
> > > reference to `stdscr'
> > > /usr/bin/ld: /root/data-profile-tools/src/disp.c:625: undefined
> > > reference to `wgetch'
> > > /usr/bin/ld: ./.libs/libdatop.a(reg.o): in function `reg_win_create':
> > > /root/data-profile-tools/src/reg.c:108: undefined reference to `stdscr'
> > > /usr/bin/ld: /root/data-profile-tools/src/reg.c:108: undefined
> > > reference to `stdscr'
> > > /usr/bin/ld: /root/data-profile-tools/src/reg.c:108: undefined
> > > reference to `subwin'
> > > /usr/bin/ld: ./.libs/libdatop.a(reg.o): in function `reg_erase':
> > > /root/data-profile-tools/src/reg.c:161: undefined reference to `werase'
> > > /usr/bin/ld: ./.libs/libdatop.a(reg.o): in function `reg_refresh':
> > > /root/data-profile-tools/src/reg.c:171: undefined reference to `wrefresh'
> > > /usr/bin/ld: ./.libs/libdatop.a(reg.o): in function `reg_refresh_nout':
> > > /root/data-profile-tools/src/reg.c:182: undefined reference to `wnoutrefresh'
> > > /usr/bin/ld: ./.libs/libdatop.a(reg.o): in function `reg_update_all':
> > > /root/data-profile-tools/src/reg.c:191: undefined reference to `doupdate'
> > > /usr/bin/ld: ./.libs/libdatop.a(reg.o): in function `reg_win_destroy':
> > > /root/data-profile-tools/src/reg.c:200: undefined reference to `delwin'
> > > /usr/bin/ld: ./.libs/libdatop.a(reg.o): in function `reg_line_write':
> > > /root/data-profile-tools/src/reg.c:226: undefined reference to `mvwprintw'
> > > /usr/bin/ld: /root/data-profile-tools/src/reg.c:230: undefined
> > > reference to `wattr_off'
> > > /usr/bin/ld: /root/data-profile-tools/src/reg.c:217: undefined
> > > reference to `wattr_on'
> > > /usr/bin/ld: ./.libs/libdatop.a(reg.o): in function `reg_highlight_write':
> > > /root/data-profile-tools/src/reg.c:245: undefined reference to `wattr_on'
> > > /usr/bin/ld: /root/data-profile-tools/src/reg.c:255: undefined
> > > reference to `wattr_off'
> > > /usr/bin/ld: /root/data-profile-tools/src/reg.c:252: undefined
> > > reference to `mvwprintw'
> > > /usr/bin/ld: /root/data-profile-tools/src/reg.c:255: undefined
> > > reference to `wattr_off'
> > > /usr/bin/ld: ./.libs/libdatop.a(reg.o): in function `reg_curses_fini':
> > > /root/data-profile-tools/src/reg.c:367: undefined reference to `stdscr'
> > > /usr/bin/ld: /root/data-profile-tools/src/reg.c:367: undefined
> > > reference to `stdscr'
> > > /usr/bin/ld: /root/data-profile-tools/src/reg.c:367: undefined
> > > reference to `wclear'
> > > /usr/bin/ld: /root/data-profile-tools/src/reg.c:368: undefined
> > > reference to `wrefresh'
> > > /usr/bin/ld: /root/data-profile-tools/src/reg.c:369: undefined
> > > reference to `endwin'
> > > /usr/bin/ld: ./.libs/libdatop.a(reg.o): in function `reg_curses_init':
> > > /root/data-profile-tools/src/reg.c:382: undefined reference to `stdscr'
> > > /usr/bin/ld: /root/data-profile-tools/src/reg.c:381: undefined
> > > reference to `initscr'
> > > /usr/bin/ld: /root/data-profile-tools/src/reg.c:382: undefined
> > > reference to `stdscr'
> > > /usr/bin/ld: /root/data-profile-tools/src/reg.c:382: undefined
> > > reference to `wrefresh'
> > > /usr/bin/ld: /root/data-profile-tools/src/reg.c:383: undefined
> > > reference to `use_default_colors'
> > > /usr/bin/ld: /root/data-profile-tools/src/reg.c:384: undefined
> > > reference to `start_color'
> > > /usr/bin/ld: /root/data-profile-tools/src/reg.c:385: undefined
> > > reference to `keypad'
> > > /usr/bin/ld: /root/data-profile-tools/src/reg.c:386: undefined
> > > reference to `nonl'
> > > /usr/bin/ld: /root/data-profile-tools/src/reg.c:387: undefined
> > > reference to `cbreak'
> > > /usr/bin/ld: /root/data-profile-tools/src/reg.c:388: undefined
> > > reference to `noecho'
> > > /usr/bin/ld: /root/data-profile-tools/src/reg.c:389: undefined
> > > reference to `curs_set'
> > > /usr/bin/ld: /root/data-profile-tools/src/reg.c:401: undefined
> > > reference to `stdscr'
> > > /usr/bin/ld: /root/data-profile-tools/src/reg.c:401: undefined
> > > reference to `mvwprintw'
> > > /usr/bin/ld: /root/data-profile-tools/src/reg.c:403: undefined
> > > reference to `mvwprintw'
> > > /usr/bin/ld: /root/data-profile-tools/src/reg.c:405: undefined
> > > reference to `wrefresh'
> > > collect2: error: ld returned 1 exit status
> > > make[1]: *** [Makefile:592: datop] Error 1
> > > make[1]: Leaving directory '/root/data-profile-tools'
> > > make: *** [Makefile:438: all] Error 2
> > Hi, Barry
> >
> > Now, the question made me realize that the compatibility of this tool is
> > very poor. I built a ubuntu environment at yesterday, and fixed above
> > errors by:
> >
> > diff --git a/configure.ac b/configure.ac
> > index 7922f27..1ed823c 100644
> > --- a/configure.ac
> > +++ b/configure.ac
> > @@ -21,13 +21,9 @@ AC_PROG_INSTALL
> >   AC_CHECK_LIB([numa], [numa_free])
> >   AC_CHECK_LIB([pthread], [pthread_create])
> >
> > -PKG_CHECK_MODULES([CHECK], [check])
> > -
> > -PKG_CHECK_MODULES([NCURSES], [ncursesw ncurses], [LIBS="$LIBS
> > $ncurses_LIBS"], [
> > -       AC_SEARCH_LIBS([delwin], [ncursesw ncurses], [], [
> > -               AC_MSG_ERROR([ncurses is required but was not found])
> > -       ], [])
> > -])
> > +AC_SEARCH_LIBS([stdscr], [ncurses ncursesw], [], [
> > +       AC_MSG_ERROR([required library libncurses or ncurses not found])
> > +       ])
> >
>
> I can confirm the patch fixed the issue I reported yesterday, thanks!
>
> > It works. But I found an another thing will hinder you using this tool.
> > We had developed other patches about DAMON base on upstream. This tool
> > only works well in ourselves kernel(anolis kernel, already open source).
> > Of course, I think it's unnecessary for you to change kernel, just let
> > you know this tool still has this problem.
> >
>
> Although I can't use this tool directly as I am not a NUMA right now,
> ~/data-profile-tools # ./datop --help
> Not support NUMA fault stat (DAMON)!
>

I wonder if you can extend it to non-numa by setting "remote" to 0%
and local to "100%" always for non-numa machines rather than death.
as your tools can map regions to .so, which seems to be quite useful.

> I am still quite interested in your design and the purpose of this project.
> Unfortunately the project seems to be lacking some design doc.
>
> And would you like to send patches to lkml regarding what you
> have changed atop DAMON?
>
> > Anyway, the question that you reported was valuable, made me realize
> > what we need to improve next.
> >
> > Thanks,
> > Rongwei Wang
> > >
> > >>
> > >>>>
> > >>>> Typical characteristics of a large Android app is that it has
> > >>>> thousands of vma and very large virtual address spaces:
> > >>>> ~/damo # pmap 2550 | wc -l
> > >>>> 8522
> > >>>>
> > >>>> ~/damo # pmap 2550
> > >>>> ...
> > >>>> 0000007992bbe000      4K r----   [ anon ]
> > >>>> 0000007992bbf000     24K rw---   [ anon ]
> > >>>> 0000007fe8753000      4K -----   [ anon ]
> > >>>> 0000007fe8754000   8188K rw---   [ stack ]
> > >>>>    total         36742112K
> > >>>>
> > >>>> Because the whole vma list is too long, I have put the list here for
> > >>>> you to download:
> > >>>> wget http://www.linuxep.com/patches/android-app-vmas
> > >>>>
> > >>>> I can reproduce this problem on other Apps like youtube as well.
> > >>>> I suppose we need to boost the algorithm of splitting regions for this
> > >>>> kind of application.
> > >>>> Any thoughts?
> > >>>>
> > >>

Thanks
Barry
