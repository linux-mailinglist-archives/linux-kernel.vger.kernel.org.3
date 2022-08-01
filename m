Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D2F0B5863AC
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Aug 2022 06:56:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239634AbiHAE4S (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 Aug 2022 00:56:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42060 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238845AbiHAE4Q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Aug 2022 00:56:16 -0400
X-Greylist: delayed 165 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Sun, 31 Jul 2022 21:56:13 PDT
Received: from p3plwbeout18-06.prod.phx3.secureserver.net (p3plsmtp18-06-2.prod.phx3.secureserver.net [173.201.193.192])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 54885958A
        for <linux-kernel@vger.kernel.org>; Sun, 31 Jul 2022 21:56:12 -0700 (PDT)
Received: from mailex.mailcore.me ([94.136.40.141])
        by :WBEOUT: with ESMTP
        id INQioSaLhwd14INQiowzyE; Sun, 31 Jul 2022 21:53:25 -0700
X-CMAE-Analysis: v=2.4 cv=Lc75VhTi c=1 sm=1 tr=0 ts=62e75c46
 a=bheWAUFm1xGnSTQFbH9Kqg==:117 a=84ok6UeoqCVsigPHarzEiQ==:17
 a=ggZhUymU-5wA:10 a=IkcTkHD0fZMA:10 a=biHskzXt2R4A:10 a=pGLkceISAAAA:8
 a=M5qS2GdLtPm0FGHqoQ0A:9 a=QEXdDO2ut3YA:10
X-SECURESERVER-ACCT: phillip@squashfs.org.uk  
X-SID:  INQioSaLhwd14
Received: from 82-69-79-175.dsl.in-addr.zen.co.uk ([82.69.79.175] helo=[192.168.178.33])
        by smtp02.mailcore.me with esmtpa (Exim 4.94.2)
        (envelope-from <phillip@squashfs.org.uk>)
        id 1oINQh-0000wA-9b; Mon, 01 Aug 2022 05:53:23 +0100
Message-ID: <28fd8f61-8005-96f8-7bfb-4a2519be5f18@squashfs.org.uk>
Date:   Mon, 1 Aug 2022 05:53:18 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH v5 3/3] squashfs: implement readahead
To:     Xiongwei Song <sxwjean@gmail.com>
Cc:     Hsin-Yi Wang <hsinyi@chromium.org>,
        Matthew Wilcox <willy@infradead.org>,
        Xiongwei Song <Xiongwei.Song@windriver.com>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Zheng Liang <zhengliang6@huawei.com>,
        Zhang Yi <yi.zhang@huawei.com>, Hou Tao <houtao1@huawei.com>,
        Miao Xie <miaoxie@huawei.com>,
        "linux-mm @ kvack . org" <linux-mm@kvack.org>,
        "squashfs-devel @ lists . sourceforge . net" 
        <squashfs-devel@lists.sourceforge.net>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        xiaohong.qi@windriver.com
References: <20220606150305.1883410-1-hsinyi@chromium.org>
 <20220606150305.1883410-4-hsinyi@chromium.org>
 <CAEVVKH_6PEc0CEfVrThO9m3kdcHVA=-i5FXkQTKaCgESVkJpig@mail.gmail.com>
 <c02886b7-c3c0-aafa-d360-4bf54b972311@squashfs.org.uk>
 <CAEVVKH_NemHoUuH6+Zf+gD5NgY_svGZ87G2XhHoK+1nEpL0sXA@mail.gmail.com>
 <CAEVVKH8Ci-nU4eFqaLRrXN69zQuTr6PLZt3dcDkgcB6NrYPuSA@mail.gmail.com>
From:   Phillip Lougher <phillip@squashfs.org.uk>
In-Reply-To: <CAEVVKH8Ci-nU4eFqaLRrXN69zQuTr6PLZt3dcDkgcB6NrYPuSA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Mailcore-Auth: 439999529
X-Mailcore-Domain: 1394945
X-123-reg-Authenticated:  phillip@squashfs.org.uk  
X-Originating-IP: 82.69.79.175
X-CMAE-Envelope: MS4xfK71FcYgAkbV9nNrY2lvlIMUk/hY2rFxUygHCKmRLQHmd736QQkiTEt5SO9Byfjk7hC7UKCmks1ioO9c5iTrQW0rkHVev+kE8apPLiynvjbXqVapySk9
 mQUE7HMFMLwa3U2herZVaFjYfn2WIVXdBIXvirXsqESvSc8SXF4LvyIZa/ajFRozaBHArCQ5ueSWUOVgKHCrtrrA4eOH56u5PC0=
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 29/07/2022 06:22, Xiongwei Song wrote:
 > Hi Phillip,
 >
 > Gentle ping.
 >
 > Regards,
 > Xiongwei
 >
 > On Fri, Jul 15, 2022 at 9:45 AM Xiongwei Song <sxwjean@gmail.com> wrote:
 >>
 >> Please see the test results below, which are from my colleague 
Xiaohong Qi:
 >>
 >> I test file size from  256KB to 5120KB with thread number
 >> 1,2,4,8,16,24,32(run ten times and get it’s average value). The read
 >> performance is shown below. The difference of read performance between
 >> 4.18 kernel and 5.10(with squashfs_readahead() patch v7) seems is
 >> caused by the files whose size is litter than 256KB.
 >>
 >>                      T1              T2            T4             T8
 >>           T16          T24          T32
 >> All File Size
 >>      4.18         136.8642   100.479    96.5523    96.1569    96.204
 >>   96.0587    96.0519
 >>      5.10-v7    138.474     103.1351  99.9192    99.7091    99.7894
 >> 100.2034   100.4447
 >>      Delta        1.6098       2.6561      3.3669      3.5522
 >> 3.5854      4.1447      4.3928

To clarify what was mentioned later in the email - these results were
obtained using SQUASHFS_DECOMP_MULTI_PERCPU, on a 12 core system?

If so these results are unexpected.  There is very little extra
parallelism shown when increasing the threads.  There is about
a 36% increase in performance moving from 1 thread to 2 threads, which
is about what I expected, but from there on there is almost no
parellelism improvement, even though you should have 12 available
Squashfs decompressors.

This is the results I get on a rather old 4-core X86_64 system using
virtualisation, off SSD with a Squashfs filesystem created from a set of
Linux kernel repositories and distro root filesystems.  So a lot of 
small files and some larger files.

************************
1 Thread

real    8m4.435s
user    4m1.401s
sys     2m57.680s

2 Threads

real    5m16.647s
user    3m16.984s
sys     2m35.655s

4 Threads

real    3m46.047s
user    2m58.669s
sys     2m20.193s

8 Threads

real    3m0.239s
user    2m41.253s
sys     2m27.935s

16 Threads

real    2m38.329s
user    2m34.478s
sys     2m26.303s
***************************

This is the behaviour I would expect to see, a steadily decreasing
overall clock time, as more threads in parallel mean more Squashfs
decompressors are used.  Due to user-space overheads and context
switching, you will generally expect to see a decreasing clock
time even after the number of threads is more than the number of cores
available.  The rule of thumb is always to use at least double the number
of real cores.

As such your results are confusing, because they max out after only 2
parallel threads.

This may indicate there is something wrong somewhere in your system,
where I/O is bottlenecking early, or it cannot accomodate multiple
parallel reads and it is locking reads out.

These results remind me of the old days using rotating media, where
there was an expensive disk head SEEK to data blocks.  Trying to
read multiple files simultaneously was often self-defeating because the
extra SEEK time swallowed up any parallelism improvements, leading to
negligible, flat and decreasing performance improvement as more threads
were added.

Of course I doubt seek time is involved here, but, a lot of things
can emulate seek time, such as a constant unexpected cost.

As this effect is observed with the "original" Squashfs, this is going
to be external to Squashfs, and unrelated to the readhead patches.

 >>
 >> Fsize < 256KB
 >>      4.18          21.7949    14.6959    11.639     10.5154    10.14
 >>    10.1092    10.1425
 >>      5.10-v7     23.8629    16.2483    13.1475   12.3697    12.1985
 >> 12.8799    13.3292
 >>      Delta         2.068        1.5524      1.5085     1.8543
 >> 2.0585     2.7707     3.1867
 >>

This appears to show the readhead patch is performing much worse with
files less than 256KB, than larger files.  Which would indicate a
problem with the readahead patch.

But, this may be a symptom of whatever is causing your general
lack of parallelism. i.e. external to Squashfs.    When read sizes
are small, any extra fixed costs loom large in the result because
they are a significant proportion of the overall cost.  When
read sizes are large, any extra fixed costs are a small proportion
of the overall cost and show up marginally or not at all in the results.

In otherwords, there is already a suspicion there are some unexpected
fixed costs to doing I/O, which results in poor parallel performance.
These fixed costs if they are worse on the later kernel, will show
up here where read sizes are small, and may not show up elsewhere.

I have instrumented and profiled the readahead patches on a large
number of workloads, with various degrees of parallelism and I have
not experienced any unexpected regressions in performance as reported
here on small files.

This is not to say there isn't an undiscovered issue with the
readahead patch, but, I have to say the evidence more points to an
issue with your system rather than the readahead patch.

What I would do here is first investigate why you apear to have
poor parallel I/O scaling.

Phillip


