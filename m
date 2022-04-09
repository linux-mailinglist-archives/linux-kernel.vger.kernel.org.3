Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 16E584FA92D
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Apr 2022 17:16:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242422AbiDIPSH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 9 Apr 2022 11:18:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38548 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240816AbiDIPSF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 Apr 2022 11:18:05 -0400
Received: from mail-qt1-x834.google.com (mail-qt1-x834.google.com [IPv6:2607:f8b0:4864:20::834])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 18D10231
        for <linux-kernel@vger.kernel.org>; Sat,  9 Apr 2022 08:15:58 -0700 (PDT)
Received: by mail-qt1-x834.google.com with SMTP id s7so12924871qtk.6
        for <linux-kernel@vger.kernel.org>; Sat, 09 Apr 2022 08:15:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=WEBoai8zO7McWouh0qYd7A4MNkEqvAkiPULBtZOOfXE=;
        b=W+zldX7hSUY+tbbttLGWVXSM+FUo0M2zff2JlsStl6RQYRlToNtyfmVSM0OArTUI1c
         D8AewIRo8porerujW16op9VBPCUEWeYyy8nrSDwLnCDWQR1kfqNk8okWRMEwm/yW2LwD
         JahjufPNI8Te0IK6tcRMlkFHMM9nk+mQOT5tQl70bvFOISbeiS6/gznlTs9qTr5PfFA9
         sAO56WqhnLfV7DpmijrrPZNhZnPT0bp4ZWVrwkKVGSH/mtmA6Q8ygR+KoLxTGhfgMUqb
         sEPZWTArW7rWCGgXvwenTu7cb/u7UQAyMXA9pJ7QtN0rHIym0kCdQ9yBE3SstJsVJpAa
         E/mQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=WEBoai8zO7McWouh0qYd7A4MNkEqvAkiPULBtZOOfXE=;
        b=h2hogYbmGQZoXluGOLQEcdRvnJYxRX/z7IJjnKJRNndIZslDBAnxvgQtqzAQlI/tYV
         naAgxJvZnVIW/XgH8m2+y8Rko8BRohtGJKe/d97vKnw/KoK1NcAbXm2qYvIh4Dw/EpOM
         uiTgo9iy+ox4pY4SdmspvLP5ssIJqQ9VXHF1lCEEAG5l+/pk3q9nqvljpLk/Srlxf62Y
         DSHAGyoQJJT8i8qFwi2UjXGS4/VxKzKyYqqflUY3G22wDfCaUB0JbpD9syH536KwH2FW
         DiYRN4ezYz6yT6/zALzhUPxbWOMNtSYtJbd+Ra3m9TAoYRUNncahOATrvqPFAz6syhmK
         4eIg==
X-Gm-Message-State: AOAM532MTi3HTHYvh5MT9Gq8t/AVUdS24PjGRw4/SC9irXJTI8YuXiTs
        B/TeQahlsxT15Ptj4b5UF5AFGVKVE42Pm8NeOr4=
X-Google-Smtp-Source: ABdhPJxoKcHQ9KDMJ9pcTwgIuRZCB2D5ZyBvfaxLdlKEYW04N0HijOmdC0BtDLV8msDMmnH8tAgzqO4rY8OKc6xrEf8=
X-Received: by 2002:a05:622a:5d0:b0:2e1:d430:a5c9 with SMTP id
 d16-20020a05622a05d000b002e1d430a5c9mr20431091qtb.639.1649517357099; Sat, 09
 Apr 2022 08:15:57 -0700 (PDT)
MIME-Version: 1.0
References: <20220310005228.11737-1-yu.c.chen@intel.com> <50315795-c2cf-fc1a-6698-752b0c26cb96@amd.com>
 <20220316115418.GA20589@chenyu5-mobl1> <9191110a-daf9-0520-a47a-801fa3f744d8@amd.com>
 <c8ddd124-1d83-fa13-eaf9-be5c2328943f@amd.com>
In-Reply-To: <c8ddd124-1d83-fa13-eaf9-be5c2328943f@amd.com>
From:   Chen Yu <yu.chen.surf@gmail.com>
Date:   Sat, 9 Apr 2022 23:15:45 +0800
Message-ID: <CADjb_WQjzZsZpg-CpCM+sGbH-k2qUWPk2738=EBQLUaQ7KtCTQ@mail.gmail.com>
Subject: Re: [PATCH v2][RFC] sched/fair: Change SIS_PROP to search idle CPU
 based on sum of util_avg
To:     K Prateek Nayak <kprateek.nayak@amd.com>
Cc:     Chen Yu <yu.c.chen@intel.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Tim Chen <tim.c.chen@intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Mel Gorman <mgorman@suse.de>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Barry Song <21cnbao@gmail.com>,
        Barry Song <song.bao.hua@hisilicon.com>,
        Yicong Yang <yangyicong@hisilicon.com>,
        Srikar Dronamraju <srikar@linux.vnet.ibm.com>,
        Len Brown <len.brown@intel.com>,
        Ben Segall <bsegall@google.com>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Aubrey Li <aubrey.li@intel.com>
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

On Tue, Apr 5, 2022 at 11:20 AM K Prateek Nayak <kprateek.nayak@amd.com> wrote:
>
> Hello Chenyu,
>
> This is the output of vmstat captured every minute during the runtime of the benchmark:
>
> procs -----------memory---------- ---swap-- -----io---- -system-- ------cpu-----
>   r  b   swpd   free   buff  cache   si   so    bi    bo   in   cs us sy id wa st
>   0  0      0 524179712  47956 623328    0    0    18     1   95   70  0  1 99  0  0
>   0  0      0 524583488   6984 296760    0    0   869    32  765  613  0  0 100  0  0
>   2  0      0 519057408  10840 413092    0    0  1413    97 40022 245964  2  1 98  0  0
>  13  0      0 515806048  11036 1560292    0    0     1 15861 47291 481310  3  1 95  0  0
>   0  0      0 519494240  11844 2073552    0    0    27 11934 7397 70297  1  0 99  0  0
>  49  1      0 508753216  12064 4519468    0    0    22 82723 160775 1219361 11  5 84  0  0
>  51  1      0 508787424  12188 4686136    0    0     3 177661 199218 1522425 13  5 81  0  0
>  51  0      0 508717088  12464 5102900    0    0     8 172393 215555 1526566 14  6 81  0  0
>  54  0      0 508974208  12584 5133116    0    0     0 196022 194294 1520359 14  5 81  0  0
>  49  0      0 509171712  12720 5133420    0    0     1 189473 181195 1520990 14  5 81  0  0
>  65  2      0 509624672  12820 5172400    0    0     0 192406 190311 1516981 14  5 80  0  0
>  50  1      0 510052864  14228 5231312    0    0   886 173806 236733 1491140 14  6 80  0  0
>  50  1      0 510455904  14340 5231412    0    0     0 191996 252078 1479435 14  6 80  0  0
>  51  0      0 510845184  14464 5231436    0    0     0 191033 251433 1480865 14  6 80  0  0
>  54  0      0 511137472  15128 5247844    0    0    12 198460 254401 1485615 14  6 80  0  0
>  54  0      0 511242816  15240 5247868    0    0     0 205262 255299 1483994 14  6 80  0  0
>   0  0      0 524682656   6488 302624    0    0   596 64012 55117 315385  3  1 96  0  0
>  11  0      0 523307136  10096 350728    0    0   788    89 3350 30092  0  0 100  0  0
>   9  0      0 516713440  10276 1222368    0    0     2  8941 51751 497130  3  1 95  0  0
>   0  0      0 519524608  10428 2009192    0    0     8 18969 29798 277747  2  1 97  0  0
>  50  0      0 510469184  10608 4463716    0    0    15 72376 99893 592582  6  2 92  0  0
>  50  1      0 510225728  10760 4954988    0    0     3 175225 223641 1531010 13  5 81  0  0
>  49  0      0 510185376  10856 4955084    0    0     0 167856 208568 1541377 13  5 81  0  0
>  51  1      0 510101696  10964 5058408    0    0     0 185400 216839 1534992 13  5 81  0  0
>  56  0      0 509908448  11084 5058524    0    0     0 184871 240666 1478386 14  6 81  0  0
>  57  0      0 509593088  11188 5058624    0    0     0 174319 257078 1472289 14  6 80  0  0
>  46  0      0 509449280  11320 5120364    0    0     0 199695 246095 1484076 14  6 81  0  0
>  47  0      0 509569120  11440 5120504    0    0     0 195409 246954 1486632 14  6 81  0  0
>  51  1      0 509394240  11564 5120640    0    0     0 187739 235864 1487453 14  5 81  0  0
>  46  1      0 509165184  11668 5137480    0    0     0 190097 225997 1510812 14  5 81  0  0
>  83  1      0 509214944  11788 5137564    0    0     0 185712 232513 1524289 14  5 81  0  0
>   0  0      0 524685792   3940 268116    0    0    48 153174 152934 966090  9  3 88  0  0
>   0  0      0 524574880   6560 317068    0    0   703    82  193  342  0  0 100  0  0
>  11  0      0 515208960   8380 877736    0    0   606  8627 31043 324947  2  1 97  0  0
>   1  0      0 519673440   9196 1845944    0    0    20 13871 41874 470542  3  1 96  0  0
>  56  0      0 513421280   9328 2819588    0    0    13  6776 21005 106752  1  0 98  0  0
> 46  0      0 509829408   9520 4192212    0    0     4 157023 199117 1512516 13  5 82  0  0
> 49  1      0 509403200  10084 4596844    0    0    22 175970 205070 1512552 13  5 81  0  0
> 50  0      0 508933536  10220 4828368    0    0     0 180676 224455 1512344 14  6 81  0  0
> 47  0      0 508529472  10364 4940972    0    0     1 196158 250799 1502868 14  6 80  0  0
> 58  0      0 508565344  10476 4941012    0    0     0 194334 256721 1502510 14  6 80  0  0
> 50  0      0 508594176  10596 4941144    0    0     0 182299 257354 1501533 14  6 80  0  0
> 57  1      0 508721088  10700 4965532    0    0     0 186060 255378 1501167 14  6 80  0  0
> 49  0      0 508646144  10824 4965644    0    0     0 191029 257866 1500889 14  6 80  0  0
> 49  0      0 508739136  10920 4965672    0    0     0 182014 260923 1504201 14  6 80  0  0
> 50  0      0 509059616  11032 4974112    0    0     0 195981 260905 1503577 14  6 80  0  0
>  0  1      0 516111104  11152 4975472    0    0     0 190756 186797 1452580 13  5 82  0  0
>  0  0      0 519977088  17876 4985004    0    0   177 18948  747  650  0  0 100  0  0
>
> If there is any specific monitoring program you would like me to run, please let me know.
>
Thanks for providing this information. So the ycsb-mongodb had some
regression when the
load was around 20%. As v2 patch would change the search depth when
the load is low, this
results might indicate that we should search more CPUs when the system is low.

thanks,
Chenyu
