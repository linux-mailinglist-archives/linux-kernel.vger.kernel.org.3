Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B4B3C4FA926
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Apr 2022 17:09:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242374AbiDIPLc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 9 Apr 2022 11:11:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43354 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229437AbiDIPL1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 Apr 2022 11:11:27 -0400
Received: from mail-qv1-xf33.google.com (mail-qv1-xf33.google.com [IPv6:2607:f8b0:4864:20::f33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC22D75E76
        for <linux-kernel@vger.kernel.org>; Sat,  9 Apr 2022 08:09:19 -0700 (PDT)
Received: by mail-qv1-xf33.google.com with SMTP id p8so9754257qvv.5
        for <linux-kernel@vger.kernel.org>; Sat, 09 Apr 2022 08:09:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=XZyaNrKnWQ3OxNWIlk/HZpTSNSvp2mqmDY/7G8nvfkI=;
        b=kSAu76WpzRQJo8Q4tSg403Y0QBymLeMmk35w2DVInEBBp940QNwLoyFWnAwgZzozAJ
         9AykxP+0RV0jXt2//MTr1+DLzi8XHQS1EFW7stEwcNvKOrvNBBnYtbeJz3WmwpkgoP93
         dlBe0bOwF5J+9fN5xRGHoEzEJIcpWCANuYgcIe+iYKfo8hS3uTv0HWr0ZMIqJPQAnvBN
         3eMMgvDhiaFtWuP9QPdWm4iuhRATZvcVUjG/m2D83maQlcQn4MFvPiRdx26QOMfXKIjT
         l6gwapGSGmGd9PNm7DYyMKWu+o+iHMxI9BrdRV2kvU49acX+LMakUtDQBKzv1i7ltHUn
         ljLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=XZyaNrKnWQ3OxNWIlk/HZpTSNSvp2mqmDY/7G8nvfkI=;
        b=KbLuhJMIb/8S9fm3tpm1o1GU5aKQ81IRl2YRdl/kYb6qby5OQlyjTS4CuI22iKgXdZ
         KQCJ97XXBLKqyDYRsIGhoUESVXCcU6KoUPmISp85krPxhvJnjzXiWrSV3xYBBCYv8ILu
         xdSVniP6ACaRf0imS68gJ6VL6QOH2W3zwRfj/IyQHlCMNFdswj1JIQ1kNIZvviOVY/7g
         spOu1aDSqujah6wc/a26GeTK7ANOYCUrPfvaAzNBTntpRZbIrCv83bNhlFsCNcXZwlIg
         x+7G2WGYAuy09W11E2rHwGNhGDpeNsMRlUnMNCefMobWyzKtXieJdn9P5biizk53x9uZ
         A5DA==
X-Gm-Message-State: AOAM53368LBV6/IJ8uJtkD57c+4LhPrOd+bgqdw0XruH2jxMwgpa01GV
        qBYs40TsV3eAnCO1qmu6WcnXI0GCLUPoCwP1hK8=
X-Google-Smtp-Source: ABdhPJw3RlMh7sKaZvV8eRNrhOFhwPuPwi2whAwxqQNAAEC0Oq4br+jOTwcys2xyPl21kjkvfSk3d4vry3lNWOvIIsM=
X-Received: by 2002:ad4:5f4b:0:b0:441:4d40:f8d2 with SMTP id
 p11-20020ad45f4b000000b004414d40f8d2mr20303653qvg.33.1649516958997; Sat, 09
 Apr 2022 08:09:18 -0700 (PDT)
MIME-Version: 1.0
References: <20220310005228.11737-1-yu.c.chen@intel.com> <a1d9fa78-4d27-78c6-d462-d9b1f8cd39e3@gmail.com>
 <20220318034335.GA12577@chenyu5-mobl1> <cb64be05-9ace-4eff-8fdf-2c831406fa9c@huawei.com>
In-Reply-To: <cb64be05-9ace-4eff-8fdf-2c831406fa9c@huawei.com>
From:   Chen Yu <yu.chen.surf@gmail.com>
Date:   Sat, 9 Apr 2022 23:09:07 +0800
Message-ID: <CADjb_WTYJoAd0Ok+gxXUQQX0C2uN9-eKkm_tiybqO3hDnYjvFg@mail.gmail.com>
Subject: Re: [PATCH v2][RFC] sched/fair: Change SIS_PROP to search idle CPU
 based on sum of util_avg
To:     Yicong Yang <yangyicong@huawei.com>
Cc:     Chen Yu <yu.c.chen@intel.com>, Yicong Yang <yangyccccc@gmail.com>,
        yangyicong@hisilicon.com,
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
        Srikar Dronamraju <srikar@linux.vnet.ibm.com>,
        Len Brown <len.brown@intel.com>,
        Ben Segall <bsegall@google.com>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Aubrey Li <aubrey.li@intel.com>,
        K Prateek Nayak <kprateek.nayak@amd.com>,
        "shenyang (M)" <shenyang39@huawei.com>
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

On Tue, Apr 5, 2022 at 9:05 AM Yicong Yang <yangyicong@huawei.com> wrote:
>
> FYI, shenyang has done some investigation on whether we can get an idle cpu if the nr is 4.
> For netperf running on node 0-1 (32 cores on each node) with 32, 64, 128 threads, the success
> rate of findindg an idle cpu is about 61.8%, 7.4%, <0.1%, the CPU utilization is 70.7%, 87.4%
> and 99.9% respectively.
>
Thanks for this testing. So this indicates that nr = 4 would not
improve the idle CPU search efficiency
 much when the load is extremely high. Stop searching entirely when it
is nearly 100%  may be
more appropriate.
> I have test this patch based on 5.17-rc7 on Kunpeng 920. The benchmarks are binding to node 0
> or node 0-1. The tbench result has some oscillation so I need to have a further check.
> For netperf I see performance enhancement when the threads equals to the cpu number.
>
The benefit might come from returning previous CPU earlier when
nr_threads equals to nr_cpu.
And when the threads number exceeds that of CPU, it might have already
returned previous CPU
without this patch, so we didn't see much improvements(in Shenyang's
test, the success rate is only
7.4% when threads number equals to CPU number)
> For netperf:
> TCP_RR 2 nodes
> threads         base            patched         pct
> 16              50335.56667     49970.63333     -0.73%
> 32              47281.53333     48191.93333     1.93%
> 64              18907.7         34263.63333     81.22%
> 128             14391.1         14480.8         0.62%
> 256             6905.286667     6853.83         -0.75%
>
> TCP_RR 1 node
> threads         base            patched         pct
> 16              50086.06667     49648.13333     -0.87%
> 32              24983.3         39489.43333     58.06%
> 64              18340.03333     18399.56667     0.32%
> 128             7174.713333     7390.09         3.00%
> 256             3433.696667     3404.956667     -0.84%
>
> UDP_RR 2 nodes
> threads         base            patched         pct
> 16              81448.7         82659.43333     1.49%
> 32              75351.13333     76812.36667     1.94%
> 64              25539.46667     41835.96667     63.81%
> 128             25081.56667     23595.56667     -5.92%
> 256             11848.23333     11017.13333     -7.01%
>
> UDP_RR 1 node
> threads         base            patched         pct
> 16              87288.96667     88719.83333     1.64%
> 32              22891.73333     68854.33333     200.78%
> 64              33853.4         35891.6         6.02%
> 128             12108.4         11885.76667     -1.84%
> 256             5620.403333     5531.006667     -1.59%
>
> mysql on node 0-1
>                         base            patched         pct
> 16threads-TPS           7100.27         7224.31         1.75%
> 16threads-QPS           142005.45       144486.19       1.75%
> 16threads-avg lat       2.25            2.22            1.63%
> 16threads-99th lat      2.46            2.43            1.08%
> 24threads-TPS           10424.70        10312.20        -1.08%
> 24threads-QPS           208493.86       206243.93       -1.08%
> 24threads-avg lat       2.30            2.32            -0.87%
> 24threads-99th lat      2.52            2.57            -1.85%
> 32threads-TPS           12528.79        12228.88        -2.39%
> 32threads-QPS           250575.92       244577.59       -2.39%
> 32threads-avg lat       2.55            2.61            -2.35%
> 32threads-99th lat      2.88            2.99            -3.82%
> 64threads-TPS           21386.17        21789.99        1.89%
> 64threads-QPS           427723.41       435799.85       1.89%
> 64threads-avg lat       2.99            2.94            1.78%
> 64threads-99th lat      5.00            4.69            6.33%
> 128threads-TPS          20865.13        20781.24        -0.40%
> 128threads-QPS          417302.73       415624.83       -0.40%
> 128threads-avg lat      6.13            6.16            -0.38%
> 128threads-99th lat     8.90            8.95            -0.60%
> 256threads-TPS          19258.15        19295.11        0.19%
> 256threads-QPS          385162.92       385902.27       0.19%
> 256threads-avg lat      13.29           13.26           0.23%
> 256threads-99th lat     20.12           20.12           0.00%
>
> I also had a look on a machine with 2-socket Xeon 6148 (80 threads in total)
> For TCP_RR, the best enhancement also happens when the threads equals to
> the cpu number.
>
May I know if the test is with turbo enabled or disabled? If the turbo
is disabled,
there might be some issues when calculating the util_avg. I had a workaround at
https://lore.kernel.org/all/20220407234258.569681-1-yu.c.chen@intel.com/
And I'm working on the v3 patch which would include above workaround,
will sent it
out later.

-- 
Thanks,
Chenyu
