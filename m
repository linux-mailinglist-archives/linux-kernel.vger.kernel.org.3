Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B42D252B099
	for <lists+linux-kernel@lfdr.de>; Wed, 18 May 2022 05:03:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234396AbiERDDo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 May 2022 23:03:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50192 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234398AbiERDDg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 May 2022 23:03:36 -0400
Received: from out30-45.freemail.mail.aliyun.com (out30-45.freemail.mail.aliyun.com [115.124.30.45])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1608E43AD2
        for <linux-kernel@vger.kernel.org>; Tue, 17 May 2022 20:03:32 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R621e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04400;MF=rongwei.wang@linux.alibaba.com;NM=1;PH=DS;RN=18;SR=0;TI=SMTPD_---0VDb8x2Q_1652843006;
Received: from 192.168.31.179(mailfrom:rongwei.wang@linux.alibaba.com fp:SMTPD_---0VDb8x2Q_1652843006)
          by smtp.aliyun-inc.com(127.0.0.1);
          Wed, 18 May 2022 11:03:27 +0800
Message-ID: <a2524475-7c11-2cfa-3d29-03e67523e0c6@linux.alibaba.com>
Date:   Wed, 18 May 2022 11:03:24 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:101.0)
 Gecko/20100101 Thunderbird/101.0
Subject: Re: DAMON VA regions don't split on an large Android APP
Content-Language: en-US
To:     Barry Song <21cnbao@gmail.com>
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
        xhao@linux.alibaba.com, vxc5208@mavs.uta.edu
References: <CAGsJ_4x_k9009HwpTswEq1ut_co8XYdpZ9k0BVW=0=HRiifxkA@mail.gmail.com>
 <e3c1beb1-e3d5-6e26-bae2-06785080b57e@linux.alibaba.com>
 <CAGsJ_4weJ9onh0EJVy8QXMXZ++4qVyVuRi7oP3wiD0XWnqF-Dg@mail.gmail.com>
 <CAGsJ_4z8vMNDwL4uYB6_=txvm9zW7LKrFA2HChS2D-+fxhBiKA@mail.gmail.com>
 <08fff4b9-3ae9-db68-13bb-cf5f0654e20a@linux.alibaba.com>
 <CAGsJ_4wKqPEnFGdijwjKeCvfRwfdxkk-263EZt2Y21GMyn1_uA@mail.gmail.com>
 <CAGsJ_4z2TT5H2PO+mvgMSnL3h5ke=QVhFzDmYs6yOgwgB24bhg@mail.gmail.com>
 <1b2040ba-9780-8d2b-257d-35c66567011b@linux.alibaba.com>
 <CAGsJ_4wK=Xw7g=FZgRBo4FRK11AeyS0Jyrd7D0UeDe3DLVUmfA@mail.gmail.com>
From:   Rongwei Wang <rongwei.wang@linux.alibaba.com>
In-Reply-To: <CAGsJ_4wK=Xw7g=FZgRBo4FRK11AeyS0Jyrd7D0UeDe3DLVUmfA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-12.0 required=5.0 tests=BAYES_00,
        ENV_AND_HDR_SPF_MATCH,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 5/17/22 7:14 PM, Barry Song wrote:
> On Tue, May 17, 2022 at 3:00 AM Rongwei Wang
> <rongwei.wang@linux.alibaba.com> wrote:
>>
>>
>>
>> On 5/16/22 3:03 PM, Barry Song wrote:
>>> On Thu, Apr 28, 2022 at 7:37 PM Barry Song <21cnbao@gmail.com> wrote:
>>>>
>>>> On Thu, Apr 28, 2022 at 2:05 PM Rongwei Wang
>>>> <rongwei.wang@linux.alibaba.com> wrote:
>>>>>
>>>>>
>>>>>
>>>>> On 4/27/22 5:22 PM, Barry Song wrote:
>>>>>> On Wed, Apr 27, 2022 at 7:44 PM Barry Song <21cnbao@gmail.com> wrote:
>>>>>>>
>>>>>>> On Wed, Apr 27, 2022 at 6:56 PM Rongwei Wang
>>>>>>> <rongwei.wang@linux.alibaba.com> wrote:
>>>>>>>>
>>>>>>>>
>>>>>>>>
>>>>>>>> On 4/27/22 7:19 AM, Barry Song wrote:
>>>>>>>>> Hi SeongJae & Andrew,
>>>>>>>>> (also Cc-ed main damon developers)
>>>>>>>>> On an Android phone, I tried to use the DAMON vaddr monitor and found
>>>>>>>>> that vaddr regions don't split well on large Android Apps though
>>>>>>>>> everything works well on native Apps.
>>>>>>>>>
>>>>>>>>> I have tried the below two cases on an Android phone with 12GB memory
>>>>>>>>> and snapdragon 888 CPU.
>>>>>>>>> 1. a native program with small memory working set  as below,
>>>>>>>>> #define size (1024*1024*100)
>>>>>>>>> main()
>>>>>>>>> {
>>>>>>>>>             volatile int *p = malloc(size);
>>>>>>>>>             memset(p, 0x55, size);
>>>>>>>>>
>>>>>>>>>             while(1) {
>>>>>>>>>                     int i;
>>>>>>>>>                     for (i = 0; i < size / 4; i++)
>>>>>>>>>                             (void)*(p + i);
>>>>>>>>>                     usleep(1000);
>>>>>>>>>
>>>>>>>>>                     for (i = 0; i < size / 16; i++)
>>>>>>>>>                             (void)*(p + i);
>>>>>>>>>                     usleep(1000);
>>>>>>>>>
>>>>>>>>>             }
>>>>>>>>> }
>>>>>>>>> For this application, the Damon vaddr monitor works very well.
>>>>>>>>> I have modified monitor.py in the damo userspace tool a little bit to
>>>>>>>>> show the raw data getting from the kernel.
>>>>>>>>> Regions can split decently on this kind of applications, a typical raw
>>>>>>>>> data is as below,
>>>>>>>>>
>>>>>>>>> monitoring_start:             2.224 s
>>>>>>>>> monitoring_end:               2.329 s
>>>>>>>>> monitoring_duration:       104.336 ms
>>>>>>>>> target_id: 0
>>>>>>>>> nr_regions: 24
>>>>>>>>> 005fb37b2000-005fb734a000(  59.594 MiB): 0
>>>>>>>>> 005fb734a000-005fbaf95000(  60.293 MiB): 0
>>>>>>>>> 005fbaf95000-005fbec0b000(  60.461 MiB): 0
>>>>>>>>> 005fbec0b000-005fc2910000(  61.020 MiB): 0
>>>>>>>>> 005fc2910000-005fc6769000(  62.348 MiB): 0
>>>>>>>>> 005fc6769000-005fca33f000(  59.836 MiB): 0
>>>>>>>>> 005fca33f000-005fcdc8b000(  57.297 MiB): 0
>>>>>>>>> 005fcdc8b000-005fd115a000(  52.809 MiB): 0
>>>>>>>>> 005fd115a000-005fd45bd000(  52.387 MiB): 0
>>>>>>>>> 007661c59000-007661ee4000(   2.543 MiB): 2
>>>>>>>>> 007661ee4000-0076623e4000(   5.000 MiB): 3
>>>>>>>>> 0076623e4000-007662837000(   4.324 MiB): 2
>>>>>>>>> 007662837000-0076630f1000(   8.727 MiB): 3
>>>>>>>>> 0076630f1000-007663494000(   3.637 MiB): 2
>>>>>>>>> 007663494000-007663753000(   2.746 MiB): 1
>>>>>>>>> 007663753000-007664251000(  10.992 MiB): 3
>>>>>>>>> 007664251000-0076666fd000(  36.672 MiB): 2
>>>>>>>>> 0076666fd000-007666e73000(   7.461 MiB): 1
>>>>>>>>> 007666e73000-007667c89000(  14.086 MiB): 2
>>>>>>>>> 007667c89000-007667f97000(   3.055 MiB): 0
>>>>>>>>> 007667f97000-007668112000(   1.480 MiB): 1
>>>>>>>>> 007668112000-00766820f000(1012.000 KiB): 0
>>>>>>>>> 007ff27b7000-007ff27d6000( 124.000 KiB): 0
>>>>>>>>> 007ff27d6000-007ff27d8000(   8.000 KiB): 8
>>>>>>>>>
>>>>>>>>> 2. a large Android app like Asphalt 9
>>>>>>>>> For this case, basically regions can't split very well, but monitor
>>>>>>>>> works on small vma:
>>>>>>>>>
>>>>>>>>> monitoring_start:             2.220 s
>>>>>>>>> monitoring_end:               2.318 s
>>>>>>>>> monitoring_duration:        98.576 ms
>>>>>>>>> target_id: 0
>>>>>>>>> nr_regions: 15
>>>>>>>>> 000012c00000-0001c301e000(   6.754 GiB): 0
>>>>>>>>> 0001c301e000-000371b6c000(   6.730 GiB): 0
>>>>>>>>> 000371b6c000-000400000000(   2.223 GiB): 0
>>>>>>>>> 005c6759d000-005c675a2000(  20.000 KiB): 0
>>>>>>>>> 005c675a2000-005c675a3000(   4.000 KiB): 3
>>>>>>>>> 005c675a3000-005c675a7000(  16.000 KiB): 0
>>>>>>>>> 0072f1e14000-0074928d4000(   6.510 GiB): 0
>>>>>>>>> 0074928d4000-00763c71f000(   6.655 GiB): 0
>>>>>>>>> 00763c71f000-0077e863e000(   6.687 GiB): 0
>>>>>>>>> 0077e863e000-00798e214000(   6.590 GiB): 0
>>>>>>>>> 00798e214000-007b0e48a000(   6.002 GiB): 0
>>>>>>>>> 007b0e48a000-007c62f00000(   5.323 GiB): 0
>>>>>>>>> 007c62f00000-007defb19000(   6.199 GiB): 0
>>>>>>>>> 007defb19000-007f794ef000(   6.150 GiB): 0
>>>>>>>>> 007f794ef000-007fe8f53000(   1.745 GiB): 0
>>>>>>>>>
>>>>>>>>> As you can see, we have some regions which are very very big and they
>>>>>>>>> are losing the chance to be splitted. But
>>>>>>>>> Damon can still monitor memory access for those small VMA areas very well like:
>>>>>>>>> 005c675a2000-005c675a3000(   4.000 KiB): 3
>>>>>>>> Hi, Barry
>>>>>>>>
>>>>>>>> Actually, we also had found the same problem in redis by ourselves
>>>>>>>> tool[1]. The DAMON can not split the large anon VMA well, and the anon
>>>>>>>> VMA has 10G~20G memory. I guess the whole region doesn't have sufficient
>>>>>>>> hot areas to been monitored or found by DAMON, likes one or more address
>>>>>>>> choose by DAMON not been accessed during sample period.
>>>>>>>
>>>>>>> Hi Rongwei,
>>>>>>> Thanks  for your comments and thanks for sharing your tools.
>>>>>>>
>>>>>>> I guess the cause might be:
>>>>>>> in case a region is very big like 10GiB, we have only 1MiB hot pages
>>>>>>> in this large region.
>>>>>>> damon will randomly pick one page to sample, but the page has only
>>>>>>> 1MiB/10GiB, thus
>>>>>>> less than 1/10000 chance to hit the hot 1MiB. so probably we need
>>>>>>> 10000 sample periods
>>>>>>> to hit the hot 1MiB in order to split this large region?
>>>>>>>
>>>>>>> @SeongJae, please correct me if I am wrong.
>>>>>>>
>>>>>>>>
>>>>>>>> I'm not sure whether sets init_regions can deal with the above problem,
>>>>>>>> or dynamic choose one or limited number VMA to monitor.
>>>>>>>>
>>>>>>>
>>>>>>> I won't set a limited number of VMA as this will make the damon too hard to use
>>>>>>> as nobody wants to make such complex operations, especially an Android
>>>>>>> app might have more than 8000 VMAs.
>>>>>>>
>>>>>>> I agree init_regions might be the right place to enhance the situation.
>>>>>>>
>>>>>>>> I'm not sure, just share my idea.
>>>>>>>>
>>>>>>>> [1] https://github.com/aliyun/data-profile-tools.git
>>>>>>>
>>>>>>> I suppose this tool is based on damon? How do you finally resolve the problem
>>>>>>> that large anon VMAs can't be splitted?
>>>>>>> Anyway, I will give your tool a try.
>>>>>>
>>>>>> Unfortunately, data-profile-tools.git doesn't build on aarch64 ubuntu
>>>>>> though autogen.sh
>>>>>> runs successfully.
>>>>>>
>>>>>> /usr/bin/ld: ./.libs/libdatop.a(disp.o): in function `cons_handler':
>>>>>> /root/data-profile-tools/src/disp.c:625: undefined reference to `stdscr'
>>>>>> /usr/bin/ld: /root/data-profile-tools/src/disp.c:625: undefined
>>>>>> reference to `stdscr'
>>>>>> /usr/bin/ld: /root/data-profile-tools/src/disp.c:625: undefined
>>>>>> reference to `wgetch'
>>>>>> /usr/bin/ld: ./.libs/libdatop.a(reg.o): in function `reg_win_create':
>>>>>> /root/data-profile-tools/src/reg.c:108: undefined reference to `stdscr'
>>>>>> /usr/bin/ld: /root/data-profile-tools/src/reg.c:108: undefined
>>>>>> reference to `stdscr'
>>>>>> /usr/bin/ld: /root/data-profile-tools/src/reg.c:108: undefined
>>>>>> reference to `subwin'
>>>>>> /usr/bin/ld: ./.libs/libdatop.a(reg.o): in function `reg_erase':
>>>>>> /root/data-profile-tools/src/reg.c:161: undefined reference to `werase'
>>>>>> /usr/bin/ld: ./.libs/libdatop.a(reg.o): in function `reg_refresh':
>>>>>> /root/data-profile-tools/src/reg.c:171: undefined reference to `wrefresh'
>>>>>> /usr/bin/ld: ./.libs/libdatop.a(reg.o): in function `reg_refresh_nout':
>>>>>> /root/data-profile-tools/src/reg.c:182: undefined reference to `wnoutrefresh'
>>>>>> /usr/bin/ld: ./.libs/libdatop.a(reg.o): in function `reg_update_all':
>>>>>> /root/data-profile-tools/src/reg.c:191: undefined reference to `doupdate'
>>>>>> /usr/bin/ld: ./.libs/libdatop.a(reg.o): in function `reg_win_destroy':
>>>>>> /root/data-profile-tools/src/reg.c:200: undefined reference to `delwin'
>>>>>> /usr/bin/ld: ./.libs/libdatop.a(reg.o): in function `reg_line_write':
>>>>>> /root/data-profile-tools/src/reg.c:226: undefined reference to `mvwprintw'
>>>>>> /usr/bin/ld: /root/data-profile-tools/src/reg.c:230: undefined
>>>>>> reference to `wattr_off'
>>>>>> /usr/bin/ld: /root/data-profile-tools/src/reg.c:217: undefined
>>>>>> reference to `wattr_on'
>>>>>> /usr/bin/ld: ./.libs/libdatop.a(reg.o): in function `reg_highlight_write':
>>>>>> /root/data-profile-tools/src/reg.c:245: undefined reference to `wattr_on'
>>>>>> /usr/bin/ld: /root/data-profile-tools/src/reg.c:255: undefined
>>>>>> reference to `wattr_off'
>>>>>> /usr/bin/ld: /root/data-profile-tools/src/reg.c:252: undefined
>>>>>> reference to `mvwprintw'
>>>>>> /usr/bin/ld: /root/data-profile-tools/src/reg.c:255: undefined
>>>>>> reference to `wattr_off'
>>>>>> /usr/bin/ld: ./.libs/libdatop.a(reg.o): in function `reg_curses_fini':
>>>>>> /root/data-profile-tools/src/reg.c:367: undefined reference to `stdscr'
>>>>>> /usr/bin/ld: /root/data-profile-tools/src/reg.c:367: undefined
>>>>>> reference to `stdscr'
>>>>>> /usr/bin/ld: /root/data-profile-tools/src/reg.c:367: undefined
>>>>>> reference to `wclear'
>>>>>> /usr/bin/ld: /root/data-profile-tools/src/reg.c:368: undefined
>>>>>> reference to `wrefresh'
>>>>>> /usr/bin/ld: /root/data-profile-tools/src/reg.c:369: undefined
>>>>>> reference to `endwin'
>>>>>> /usr/bin/ld: ./.libs/libdatop.a(reg.o): in function `reg_curses_init':
>>>>>> /root/data-profile-tools/src/reg.c:382: undefined reference to `stdscr'
>>>>>> /usr/bin/ld: /root/data-profile-tools/src/reg.c:381: undefined
>>>>>> reference to `initscr'
>>>>>> /usr/bin/ld: /root/data-profile-tools/src/reg.c:382: undefined
>>>>>> reference to `stdscr'
>>>>>> /usr/bin/ld: /root/data-profile-tools/src/reg.c:382: undefined
>>>>>> reference to `wrefresh'
>>>>>> /usr/bin/ld: /root/data-profile-tools/src/reg.c:383: undefined
>>>>>> reference to `use_default_colors'
>>>>>> /usr/bin/ld: /root/data-profile-tools/src/reg.c:384: undefined
>>>>>> reference to `start_color'
>>>>>> /usr/bin/ld: /root/data-profile-tools/src/reg.c:385: undefined
>>>>>> reference to `keypad'
>>>>>> /usr/bin/ld: /root/data-profile-tools/src/reg.c:386: undefined
>>>>>> reference to `nonl'
>>>>>> /usr/bin/ld: /root/data-profile-tools/src/reg.c:387: undefined
>>>>>> reference to `cbreak'
>>>>>> /usr/bin/ld: /root/data-profile-tools/src/reg.c:388: undefined
>>>>>> reference to `noecho'
>>>>>> /usr/bin/ld: /root/data-profile-tools/src/reg.c:389: undefined
>>>>>> reference to `curs_set'
>>>>>> /usr/bin/ld: /root/data-profile-tools/src/reg.c:401: undefined
>>>>>> reference to `stdscr'
>>>>>> /usr/bin/ld: /root/data-profile-tools/src/reg.c:401: undefined
>>>>>> reference to `mvwprintw'
>>>>>> /usr/bin/ld: /root/data-profile-tools/src/reg.c:403: undefined
>>>>>> reference to `mvwprintw'
>>>>>> /usr/bin/ld: /root/data-profile-tools/src/reg.c:405: undefined
>>>>>> reference to `wrefresh'
>>>>>> collect2: error: ld returned 1 exit status
>>>>>> make[1]: *** [Makefile:592: datop] Error 1
>>>>>> make[1]: Leaving directory '/root/data-profile-tools'
>>>>>> make: *** [Makefile:438: all] Error 2
>>>>> Hi, Barry
>>>>>
>>>>> Now, the question made me realize that the compatibility of this tool is
>>>>> very poor. I built a ubuntu environment at yesterday, and fixed above
>>>>> errors by:
>>>>>
>>>>> diff --git a/configure.ac b/configure.ac
>>>>> index 7922f27..1ed823c 100644
>>>>> --- a/configure.ac
>>>>> +++ b/configure.ac
>>>>> @@ -21,13 +21,9 @@ AC_PROG_INSTALL
>>>>>     AC_CHECK_LIB([numa], [numa_free])
>>>>>     AC_CHECK_LIB([pthread], [pthread_create])
>>>>>
>>>>> -PKG_CHECK_MODULES([CHECK], [check])
>>>>> -
>>>>> -PKG_CHECK_MODULES([NCURSES], [ncursesw ncurses], [LIBS="$LIBS
>>>>> $ncurses_LIBS"], [
>>>>> -       AC_SEARCH_LIBS([delwin], [ncursesw ncurses], [], [
>>>>> -               AC_MSG_ERROR([ncurses is required but was not found])
>>>>> -       ], [])
>>>>> -])
>>>>> +AC_SEARCH_LIBS([stdscr], [ncurses ncursesw], [], [
>>>>> +       AC_MSG_ERROR([required library libncurses or ncurses not found])
>>>>> +       ])
>>>>>
>>>>
>>>> I can confirm the patch fixed the issue I reported yesterday, thanks!
>>>>
>>>>> It works. But I found an another thing will hinder you using this tool.
>>>>> We had developed other patches about DAMON base on upstream. This tool
>>>>> only works well in ourselves kernel(anolis kernel, already open source).
>>>>> Of course, I think it's unnecessary for you to change kernel, just let
>>>>> you know this tool still has this problem.
>>>>>
>>>>
>>>> Although I can't use this tool directly as I am not a NUMA right now,
>>>> ~/data-profile-tools # ./datop --help
>>>> Not support NUMA fault stat (DAMON)!
>>>>
>>>
>>> I wonder if you can extend it to non-numa by setting "remote" to 0%
>>> and local to "100%" always for non-numa machines rather than death.
>> Hi Barry
>>
>> That's a great suggestion. Actually, I have removed 'numa_stat' check in
>> datop. Maybe you can found. It does not enable numa stat when
>> 'numa_stat' sysfs not found in the current system.
> 
> yep. i am able to run it on a non-numa machine, but datop immediately crashes
> due to some memory corruption issues:
> 
> Monitoring 270 processes (interval: 5.5s)
Barry, it's known bug. I remember the maximum number of processes that 
is 32 in datop. The reason that setting like this is that I feel 
impossible to monitor so many processes at the beginning.

And it seems that the error message should been printed here, instead of 
crash. Thank you for reminding me.
> 
>     PID           PROC       TYPE           START             END
> SIZE(KiB)    ACCESS      AGE
>    1693    Binder:1693       ----               0               0
>     0         0        0
>     428        ueventd       ----               0               0
>     0         0        0
>   28654           adbd       ----               0               0
>     0         0        0
>     971    usb@1.2-ser       ----               0               0
>     0         0        0
>     619           logd       ----               0               0
>     0         0        0
>    4311    a...
> 
> <- Hotkey for sorting: 1(PID), 2(START), 3(SIZE), 4(ACCESS), 5(RMA) ->
> CPU% = system CPU utilization
> 
> Q: Quit; H: Home; B: Back; R: Refresh; D: DAMON
> double free or corruption (!prev)
> 
>           Aborted
> 
> if i move to monitor only one process, datop doesn't crash but it
> doesn't show any
> data either:
> 
> # pgrep youtube
> 4311
>   # ./datop -p 4311
> 
> Monitoring 1 processes (interval: 5.0s)
Oh, it's ever happen to me. Does It always show like this when 
monitoring one process in your environment?
> 
>     PID           PROC       TYPE           START             END
> SIZE(KiB)   *ACCESS      AGE
>    4311    youtube      ----               0               0          0
>          0        0
> 
> 
>>
>> What's more, a new hot key 'f' will be introduced which can enable some
>> features dynamically, such as numa stat. Others features can be used
>> only in our internal version, likes 'f' in top, and will be open source
>> when stable.
>>
>>> as your tools can map regions to .so, which seems to be quite useful.
>> enen, I'm agree with you. But you know, one region maybe covers one or
>> more VMAs, hard to map access count of regions to the related .so or
>> anon. A lazy way used by me now. I still think it's valuable in the future.
>>
> 
> it seems really an interesting topic worth more investigation. I wonder if
> damon vaddr monitor should actually take vmas, or at least the types of
> vmas into consideration while splitting.
> 
> Different vma types should be inherently different in hotness. for example,
> if 1mb text and 1mb data are put in the same region, the monitored data
> to reflect the hotness for the whole 2mb seems to be pointless at all.
> 
> Hi SeongJae,
> what do you think about it?
> 
>> Anyway, any idea are welcome.
>>
>> Thanks,
>> -wrw
>>
>>>
>>>> I am still quite interested in your design and the purpose of this project.
>>>> Unfortunately the project seems to be lacking some design doc.
>>>>
>>>> And would you like to send patches to lkml regarding what you
>>>> have changed atop DAMON?
>>>>
>>>>> Anyway, the question that you reported was valuable, made me realize
>>>>> what we need to improve next.
>>>>>
>>>>> Thanks,
>>>>> Rongwei Wang
>>>>>>
>>>>>>>
>>>>>>>>>
>>>>>>>>> Typical characteristics of a large Android app is that it has
>>>>>>>>> thousands of vma and very large virtual address spaces:
>>>>>>>>> ~/damo # pmap 2550 | wc -l
>>>>>>>>> 8522
>>>>>>>>>
>>>>>>>>> ~/damo # pmap 2550
>>>>>>>>> ...
>>>>>>>>> 0000007992bbe000      4K r----   [ anon ]
>>>>>>>>> 0000007992bbf000     24K rw---   [ anon ]
>>>>>>>>> 0000007fe8753000      4K -----   [ anon ]
>>>>>>>>> 0000007fe8754000   8188K rw---   [ stack ]
>>>>>>>>>      total         36742112K
>>>>>>>>>
>>>>>>>>> Because the whole vma list is too long, I have put the list here for
>>>>>>>>> you to download:
>>>>>>>>> wget http://www.linuxep.com/patches/android-app-vmas
>>>>>>>>>
>>>>>>>>> I can reproduce this problem on other Apps like youtube as well.
>>>>>>>>> I suppose we need to boost the algorithm of splitting regions for this
>>>>>>>>> kind of application.
>>>>>>>>> Any thoughts?
>>>>>>>>>
>>>>>>>
>>>
> 
> Thanks
> Barry
