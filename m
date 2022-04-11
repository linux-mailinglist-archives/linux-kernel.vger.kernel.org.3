Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 25B884FB597
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Apr 2022 10:05:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343503AbiDKIHT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Apr 2022 04:07:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44086 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235172AbiDKIHN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Apr 2022 04:07:13 -0400
Received: from szxga03-in.huawei.com (szxga03-in.huawei.com [45.249.212.189])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F68D65F7
        for <linux-kernel@vger.kernel.org>; Mon, 11 Apr 2022 01:04:58 -0700 (PDT)
Received: from canpemm500009.china.huawei.com (unknown [172.30.72.53])
        by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4KcLrS6RwQzBs1B;
        Mon, 11 Apr 2022 16:00:40 +0800 (CST)
Received: from [10.67.102.169] (10.67.102.169) by
 canpemm500009.china.huawei.com (7.192.105.203) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Mon, 11 Apr 2022 16:04:56 +0800
CC:     <yangyicong@hisilicon.com>, Chen Yu <yu.c.chen@intel.com>,
        Yicong Yang <yangyccccc@gmail.com>,
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
Subject: Re: [PATCH v2][RFC] sched/fair: Change SIS_PROP to search idle CPU
 based on sum of util_avg
To:     Chen Yu <yu.chen.surf@gmail.com>
References: <20220310005228.11737-1-yu.c.chen@intel.com>
 <a1d9fa78-4d27-78c6-d462-d9b1f8cd39e3@gmail.com>
 <20220318034335.GA12577@chenyu5-mobl1>
 <cb64be05-9ace-4eff-8fdf-2c831406fa9c@huawei.com>
 <CADjb_WTYJoAd0Ok+gxXUQQX0C2uN9-eKkm_tiybqO3hDnYjvFg@mail.gmail.com>
From:   Yicong Yang <yangyicong@huawei.com>
Message-ID: <246c377f-7095-2416-d068-2e7a531e843e@huawei.com>
Date:   Mon, 11 Apr 2022 16:04:56 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.5.1
MIME-Version: 1.0
In-Reply-To: <CADjb_WTYJoAd0Ok+gxXUQQX0C2uN9-eKkm_tiybqO3hDnYjvFg@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.67.102.169]
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 canpemm500009.china.huawei.com (7.192.105.203)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-8.3 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2022/4/9 23:09, Chen Yu wrote:
> On Tue, Apr 5, 2022 at 9:05 AM Yicong Yang <yangyicong@huawei.com> wrote:
>>
>> FYI, shenyang has done some investigation on whether we can get an idle cpu if the nr is 4.
>> For netperf running on node 0-1 (32 cores on each node) with 32, 64, 128 threads, the success
>> rate of findindg an idle cpu is about 61.8%, 7.4%, <0.1%, the CPU utilization is 70.7%, 87.4%
>> and 99.9% respectively.
>>
> Thanks for this testing. So this indicates that nr = 4 would not
> improve the idle CPU search efficiency
>  much when the load is extremely high. Stop searching entirely when it
> is nearly 100%  may be
> more appropriate.
>> I have test this patch based on 5.17-rc7 on Kunpeng 920. The benchmarks are binding to node 0
>> or node 0-1. The tbench result has some oscillation so I need to have a further check.
>> For netperf I see performance enhancement when the threads equals to the cpu number.
>>
> The benefit might come from returning previous CPU earlier when
> nr_threads equals to nr_cpu.
> And when the threads number exceeds that of CPU, it might have already
> returned previous CPU
> without this patch, so we didn't see much improvements(in Shenyang's
> test, the success rate is only
> 7.4% when threads number equals to CPU number)

yes. I think it maybe the case. When the system is fully loaded the behaviour may stay
the same with previous approach, both are scanning 4 cpus.

>> For netperf:
>> TCP_RR 2 nodes
>> threads         base            patched         pct
>> 16              50335.56667     49970.63333     -0.73%
>> 32              47281.53333     48191.93333     1.93%
>> 64              18907.7         34263.63333     81.22%
>> 128             14391.1         14480.8         0.62%
>> 256             6905.286667     6853.83         -0.75%
>>
>> TCP_RR 1 node
>> threads         base            patched         pct
>> 16              50086.06667     49648.13333     -0.87%
>> 32              24983.3         39489.43333     58.06%
>> 64              18340.03333     18399.56667     0.32%
>> 128             7174.713333     7390.09         3.00%
>> 256             3433.696667     3404.956667     -0.84%
>>
>> UDP_RR 2 nodes
>> threads         base            patched         pct
>> 16              81448.7         82659.43333     1.49%
>> 32              75351.13333     76812.36667     1.94%
>> 64              25539.46667     41835.96667     63.81%
>> 128             25081.56667     23595.56667     -5.92%
>> 256             11848.23333     11017.13333     -7.01%
>>
>> UDP_RR 1 node
>> threads         base            patched         pct
>> 16              87288.96667     88719.83333     1.64%
>> 32              22891.73333     68854.33333     200.78%
>> 64              33853.4         35891.6         6.02%
>> 128             12108.4         11885.76667     -1.84%
>> 256             5620.403333     5531.006667     -1.59%
>>
>> mysql on node 0-1
>>                         base            patched         pct
>> 16threads-TPS           7100.27         7224.31         1.75%
>> 16threads-QPS           142005.45       144486.19       1.75%
>> 16threads-avg lat       2.25            2.22            1.63%
>> 16threads-99th lat      2.46            2.43            1.08%
>> 24threads-TPS           10424.70        10312.20        -1.08%
>> 24threads-QPS           208493.86       206243.93       -1.08%
>> 24threads-avg lat       2.30            2.32            -0.87%
>> 24threads-99th lat      2.52            2.57            -1.85%
>> 32threads-TPS           12528.79        12228.88        -2.39%
>> 32threads-QPS           250575.92       244577.59       -2.39%
>> 32threads-avg lat       2.55            2.61            -2.35%
>> 32threads-99th lat      2.88            2.99            -3.82%
>> 64threads-TPS           21386.17        21789.99        1.89%
>> 64threads-QPS           427723.41       435799.85       1.89%
>> 64threads-avg lat       2.99            2.94            1.78%
>> 64threads-99th lat      5.00            4.69            6.33%
>> 128threads-TPS          20865.13        20781.24        -0.40%
>> 128threads-QPS          417302.73       415624.83       -0.40%
>> 128threads-avg lat      6.13            6.16            -0.38%
>> 128threads-99th lat     8.90            8.95            -0.60%
>> 256threads-TPS          19258.15        19295.11        0.19%
>> 256threads-QPS          385162.92       385902.27       0.19%
>> 256threads-avg lat      13.29           13.26           0.23%
>> 256threads-99th lat     20.12           20.12           0.00%
>>
>> I also had a look on a machine with 2-socket Xeon 6148 (80 threads in total)
>> For TCP_RR, the best enhancement also happens when the threads equals to
>> the cpu number.
>>
> May I know if the test is with turbo enabled or disabled? If the turbo
> is disabled,

p-state is controlled by the platform on my machine. I assume it's on as the Avg_MHz
and Bzy_Mhz varies according to the load. turbostat says:
# cpu 0 idle
Package Core    CPU     Avg_MHz Busy%   Bzy_MHz TSC_MHz IPC     IRQ     SMI     POLL    C1      POLL%   C1%     CPU%c1  CPU%c6  CoreTmp PkgTmp  PkgWatt RAMWatt PKG_%   RAM_%
-       -       -       0       0.01    3100    2400    1.41    1935    0       0       1831    0.00    100.00  99.99   0.00    69      69      150.55  44.41   0.00    0.00
0       0       0       2       0.06    3100    2400    0.99    46      0       0       45      0.00    99.95   99.94   0.00    66      68      74.12   21.71   0.00    0.00
# cpu 0 partly loaded
Package Core    CPU     Avg_MHz Busy%   Bzy_MHz TSC_MHz IPC     IRQ     SMI     POLL    C1      POLL%   C1%     CPU%c1  CPU%c6  CoreTmp PkgTmp  PkgWatt RAMWatt PKG_%   RAM_%
-       -       -       1559    50.34   3097    2400    1.44    56952   0       64      4729    0.00    49.67   49.66   0.00    83      84      291.81  43.79   0.00    0.00
0       0       0       1642    53.01   3098    2400    1.48    1610    0       0       620     0.00    47.51   46.99   0.00    75      78      142.62  21.44   0.00    0.00
# cpu 0 loaded by stress-ng
Package Core    CPU     Avg_MHz Busy%   Bzy_MHz TSC_MHz IPC     IRQ     SMI     POLL    C1      POLL%   C1%     CPU%c1  CPU%c6  CoreTmp PkgTmp  PkgWatt RAMWatt PKG_%   RAM_%
-       -       -       2917    99.52   2931    2400    1.06    101718  0       0       0       0.00    0.00    0.48    0.00    86      86      299.87  43.84   0.00    0.00
0       0       0       2943    99.39   2961    2400    1.05    1278    0       0       0       0.00    0.00    0.61    0.00    81      83      149.90  21.38   0.00    0.00


> there might be some issues when calculating the util_avg. I had a workaround at
> https://lore.kernel.org/all/20220407234258.569681-1-yu.c.chen@intel.com/
> And I'm working on the v3 patch which would include above workaround,
> will sent it
> out later.
> 
