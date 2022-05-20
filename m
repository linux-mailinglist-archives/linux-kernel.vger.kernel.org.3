Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AF4B552E66C
	for <lists+linux-kernel@lfdr.de>; Fri, 20 May 2022 09:43:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344018AbiETHn1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 May 2022 03:43:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60070 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232387AbiETHnX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 May 2022 03:43:23 -0400
Received: from mail-pf1-x431.google.com (mail-pf1-x431.google.com [IPv6:2607:f8b0:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8EF5514AF66
        for <linux-kernel@vger.kernel.org>; Fri, 20 May 2022 00:43:21 -0700 (PDT)
Received: by mail-pf1-x431.google.com with SMTP id x143so7084462pfc.11
        for <linux-kernel@vger.kernel.org>; Fri, 20 May 2022 00:43:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=pRKuV0ZPM6TaUxRPX9vcfUV9fTGWoEVSYfCWeDoFKco=;
        b=7J7CxRx2RnibiVTQg9wUGNTyfIjGr8fG6Gk7vm4aGBUs3C6Mimb93S0dHAMu6+anaq
         PPRcJ1xxK/O9PVfTLn1I+9lLMNkN8ScQMSxK3vE8B8KGQDE+hBjXrLECPpCFFEBJ+7im
         w5snW6CXGJ/n7B4ciKjYrj2rgA2WAlbh4OH2kklIAyTu0UXkTHrojtNmDNxjkS8QAZRY
         jwWkXQB/P+LiTIy5MICexwShamhCpN/KiP8ciG7ig7Q6HeH3X0jqDVmyTNiCq6MltExz
         j/Ian8JTJV0Yv7oCpcvv4eaaj7r41vNH8K6pynlhWvu+YYGzVwvywZ4fbk5VNzoQPiJN
         VJFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=pRKuV0ZPM6TaUxRPX9vcfUV9fTGWoEVSYfCWeDoFKco=;
        b=Sx2vale7p6VP7nbFjqXzjuuextz9u7Ek57m8CMdWfvrbiY8VPNhE0vo5ZihIAo3++6
         GycI/shYZR6OE4uKUAleKolEFgImsye0X4DcYUPNPu9qhYLWxSS1YiPJ2ubJLAv/H8Yj
         VPFKaOduTM7M9ugCtLT4roxO66Qk/EiQEoiN1ctZXSH3Lp4N1WF74YW6tVm5+VVRTB7t
         izZxsDMqcb75ThGtJect98Fc3Ac/TLcDn8h+OmJpQJpDIsJKMGazJ5DjY5Qc+IaCt8t6
         oeW2VoWa6bnZFAv5YemHhnGgqqlQJuH3JEo/jCEYe4GrFfY+v0DsJfTk+cZbL73lXJni
         Irng==
X-Gm-Message-State: AOAM532PWa7lK716k3W3/X7UbcYyKDlnLn2jwpD+FNvSGDbf6IcHa3FM
        FnJDQqB9wRbWuBxCdHosBa1Gxw==
X-Google-Smtp-Source: ABdhPJxzZfE7Glgm64BF0iEZRFlQ/TzOloxTyciJ8bnNUCZHg8dCxG3e9r7b4YvCapHT8prJjDw4YQ==
X-Received: by 2002:a05:6a00:2186:b0:4f7:5544:1cc9 with SMTP id h6-20020a056a00218600b004f755441cc9mr8883575pfi.62.1653032600977;
        Fri, 20 May 2022 00:43:20 -0700 (PDT)
Received: from [10.254.77.173] ([139.177.225.224])
        by smtp.gmail.com with ESMTPSA id b12-20020a170902e94c00b0015e8d4eb27csm4871222pll.198.2022.05.20.00.43.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 20 May 2022 00:43:20 -0700 (PDT)
Message-ID: <97cb5a21-2030-8251-8e33-b225e8db13e0@bytedance.com>
Date:   Fri, 20 May 2022 15:43:15 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.9.0
Subject: Re: [PATCH v3] sched/fair: filter out overloaded cpus in SIS
Content-Language: en-US
To:     K Prateek Nayak <kprateek.nayak@amd.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Mel Gorman <mgorman@suse.de>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Josh Don <joshdon@google.com>
Cc:     linux-kernel@vger.kernel.org, Abel Wu <wuyun.abel@bytedance.com>
References: <20220505122331.42696-1-wuyun.abel@bytedance.com>
 <8a369b3c-58cd-84cb-d206-255dcc66e3e4@amd.com>
From:   Abel Wu <wuyun.abel@bytedance.com>
In-Reply-To: <8a369b3c-58cd-84cb-d206-255dcc66e3e4@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Prateek, thanks very much for your test!

On 5/20/22 2:48 PM, K Prateek Nayak Wrote:
> Hello Abel,
> 
> We tested this patch on our systems.
> 
> tl;dr
> 
> - We observed some regressions in schbench with 128 workers in
>    NPS4 mode.
> - tbench shows regression for 32 workers in NPS2 mode and 64 workers
>    in NPS2 and NPS4 mode.
> - Great improvements in schbench for low worker count.
> - Overall, the performance seems to be comparable to the tip.
> 
> Following are the results from testing on a dual socket Zen3 system
> (2 x 64C/128T) in different NPS modes.
> 
> Following is the NUMA configuration for each NPS mode on the system:
> 
> NPS1: Each socket is a NUMA node.
>      Total 2 NUMA nodes in the dual socket machine.
> 
>      Node 0: 0-63,   128-191
>      Node 1: 64-127, 192-255
> 
> NPS2: Each socket is further logically divided into 2 NUMA regions.
>      Total 4 NUMA nodes exist over 2 socket.
>     
>      Node 0: 0-31,   128-159
>      Node 1: 32-63,  160-191
>      Node 2: 64-95,  192-223
>      Node 3: 96-127, 223-255
> 
> NPS4: Each socket is logically divided into 4 NUMA regions.
>      Total 8 NUMA nodes exist over 2 socket.
>     
>      Node 0: 0-15,    128-143
>      Node 1: 16-31,   144-159
>      Node 2: 32-47,   160-175
>      Node 3: 48-63,   176-191
>      Node 4: 64-79,   192-207
>      Node 5: 80-95,   208-223
>      Node 6: 96-111,  223-231
>      Node 7: 112-127, 232-255

I remember you replied in Chen's patch that the number of CPUs in
LLC domain is always 16 irrespective of the NPS mode. This reminds
me of something that Josh previously concerned about. The piece of
code below in SIS may hurt the performance badly:

	if (weight - nro < (nr >> 4) && !has_idle_core)
		return -1;

where nr is no more than LLC weight which is 16 in your test. So
this condition never stands, and a following cpumask_andnot on the
LLC shared sds->overloaded_cpus[] will most probably occur, causing
heavier cache traffic to negate a lot of the benefit it brought.

The early bailing out needs carefully re-designed, and luckily Chen
is working on that. Besides, I also have some major improvements on
this SIS filter under testing and I will post v4 in one or two weeks.

Thanks again for your test & best regards,
Abel

> 
> Kernel versions:
> - tip:      		5.18-rc1 tip sched/core
> - Filter Overloaded:    5.18-rc1 tip sched/core + this patch
> 
> When we began testing, we recorded the tip at:
> 
> commit: a658353167bf "sched/fair: Revise comment about lb decision matrix"
> 
> Following are the results from the benchmark:
> 
> Note: Results marked with * are data points of concern. A rerun
> for the data point has been provided on both the tip and the
> patched kernel to check for any run to run variation.
> 
> ~~~~~~~~~
> hackbench
> ~~~~~~~~~
> 
> NPS1
> 
> Test:                   tip               Filter Overloaded
>   1-groups:         4.64 (0.00 pct)         4.74 (-2.15 pct)
>   2-groups:         5.38 (0.00 pct)         5.55 (-3.15 pct)
>   4-groups:         6.15 (0.00 pct)         6.20 (-0.81 pct)
>   8-groups:         7.42 (0.00 pct)         7.47 (-0.67 pct)
> 16-groups:        10.70 (0.00 pct)        10.60 (0.93 pct)
> 
> NPS2
> 
> Test:                   tip               Filter Overloaded
>   1-groups:         4.70 (0.00 pct)         4.68 (0.42 pct)
>   2-groups:         5.45 (0.00 pct)         5.46 (-0.18 pct)
>   4-groups:         6.13 (0.00 pct)         6.11 (0.32 pct)
>   8-groups:         7.30 (0.00 pct)         7.23 (0.95 pct)
> 16-groups:        10.30 (0.00 pct)        10.38 (-0.77 pct)
> 
> NPS4
> 
> Test:                   tip               Filter Overloaded
>   1-groups:         4.60 (0.00 pct)         4.66 (-1.30 pct)
>   2-groups:         5.41 (0.00 pct)         5.53 (-2.21 pct)
>   4-groups:         6.12 (0.00 pct)         6.16 (-0.65 pct)
>   8-groups:         7.22 (0.00 pct)         7.28 (-0.83 pct)
> 16-groups:        10.24 (0.00 pct)        10.26 (-0.19 pct)
> 
> ~~~~~~~~
> schbench
> ~~~~~~~~
> 
> NPS1
> 
> #workers:      tip                Filter Overloaded
>    1:      29.00 (0.00 pct)        29.00 (0.00 pct)
>    2:      28.00 (0.00 pct)        27.00 (3.57 pct)
>    4:      31.50 (0.00 pct)        33.00 (-4.76 pct)
>    8:      42.00 (0.00 pct)        42.50 (-1.19 pct)
>   16:      56.50 (0.00 pct)        56.00 (0.88 pct)
>   32:      94.50 (0.00 pct)        96.50 (-2.11 pct)
>   64:     176.00 (0.00 pct)       178.50 (-1.42 pct)
> 128:     404.00 (0.00 pct)       418.00 (-3.46 pct)
> 256:     869.00 (0.00 pct)       900.00 (-3.56 pct)
> 512:     58432.00 (0.00 pct)     56256.00 (3.72 pct)
> 
> NPS2
> 
> #workers:      tip                Filter Overloaded
>    1:      26.50 (0.00 pct)        14.00 (47.16 pct)
>    2:      26.50 (0.00 pct)        14.50 (45.28 pct)
>    4:      34.50 (0.00 pct)        18.00 (47.82 pct)
>    8:      45.00 (0.00 pct)        30.50 (32.22 pct)
>   16:      56.50 (0.00 pct)        57.00 (-0.88 pct)
>   32:      95.50 (0.00 pct)        94.00 (1.57 pct)
>   64:     179.00 (0.00 pct)       176.00 (1.67 pct)
> 128:     369.00 (0.00 pct)       411.00 (-11.38 pct)    *
> 128:     400.60 (0.00 pct)       412.90 (-3.07 pct)     [Verification Run]
> 256:     898.00 (0.00 pct)       850.00 (5.34 pct)
> 512:     56256.00 (0.00 pct)     59456.00 (-5.68 pct)
> 
> NPS4
> 
> #workers:      tip                Filter Overloaded
>    1:      25.00 (0.00 pct)        24.50 (2.00 pct)
>    2:      28.00 (0.00 pct)        24.00 (14.28 pct)
>    4:      29.50 (0.00 pct)        28.50 (3.38 pct)
>    8:      41.00 (0.00 pct)        36.50 (10.97 pct)
>   16:      65.50 (0.00 pct)        59.00 (9.92 pct)
>   32:      93.00 (0.00 pct)        95.50 (-2.68 pct)
>   64:     170.50 (0.00 pct)       182.00 (-6.74 pct)     *
>   64:     175.00 (0.00 pct)       176.00 (-0.57 pct)     [Verification Run]
> 128:     377.00 (0.00 pct)       409.50 (-8.62 pct)     *
> 128:     372.00 (0.00 pct)       401.00 (-7.79 pct)     [Verification Run]
> 256:     867.00 (0.00 pct)       940.00 (-8.41 pct)     *
> 256:     925.00 (0.00 pct)       892.00 (+3.45 pct)     [Verification Run]
> 512:     58048.00 (0.00 pct)     59456.00 (-2.42 pct)
> 
> ~~~~~~
> tbench
> ~~~~~~
> 
> NPS1
> 
> Clients:      tip                Filter Overloaded
>      1    443.31 (0.00 pct)       466.32 (5.19 pct)
>      2    877.32 (0.00 pct)       891.87 (1.65 pct)
>      4    1665.11 (0.00 pct)      1727.98 (3.77 pct)
>      8    3016.68 (0.00 pct)      3125.12 (3.59 pct)
>     16    5374.30 (0.00 pct)      5414.02 (0.73 pct)
>     32    8763.86 (0.00 pct)      8599.72 (-1.87 pct)
>     64    15786.93 (0.00 pct)     14095.47 (-10.71 pct)  *
>     64    15441.33 (0.00 pct)     15148.00 (-1.89 pct)   [Verification Run]
>    128    26826.08 (0.00 pct)     27837.07 (3.76 pct)
>    256    24207.35 (0.00 pct)     23769.48 (-1.80 pct)
>    512    51740.58 (0.00 pct)     53369.28 (3.14 pct)
>   1024    51177.82 (0.00 pct)     51928.06 (1.46 pct)
> 
> NPS2
> 
> Clients:      tip                Filter Overloaded
>      1    449.49 (0.00 pct)       464.65 (3.37 pct)
>      2    867.28 (0.00 pct)       898.85 (3.64 pct)
>      4    1643.60 (0.00 pct)      1691.53 (2.91 pct)
>      8    3047.35 (0.00 pct)      3010.65 (-1.20 pct)
>     16    5340.77 (0.00 pct)      5242.42 (-1.84 pct)
>     32    10536.85 (0.00 pct)     8978.74 (-14.78 pct)   *
>     32    10417.46 /90.00 pct)    8375.55 (-19.60 pct)   [Verification Run]
>     64    16543.23 (0.00 pct)     15357.35 (-7.16 pct)   *
>     64    17101.56 (0.00 pct)     15465.73 (-9.56 pct)   [Verification Run]
>    128    26400.40 (0.00 pct)     26637.87 (0.89 pct)
>    256    23436.75 (0.00 pct)     24324.08 (3.78 pct)
>    512    50902.60 (0.00 pct)     49159.14 (-3.42 pct)
>   1024    50216.10 (0.00 pct)     50218.74 (0.00 pct)
> 
> NPS4
> 
> Clients:      tip                Filter Overloaded
>      1    443.82 (0.00 pct)       458.65 (3.34 pct)
>      2    849.14 (0.00 pct)       883.79 (4.08 pct)
>      4    1603.26 (0.00 pct)      1658.89 (3.46 pct)
>      8    2972.37 (0.00 pct)      3087.76 (3.88 pct)
>     16    5277.13 (0.00 pct)      5472.11 (3.69 pct)
>     32    9744.73 (0.00 pct)      9666.67 (-0.80 pct)
>     64    15854.80 (0.00 pct)     13778.51 (-13.09 pct)  *
>     64    15732.56 (0.00 pct)     14397.83 (-8.48 pct)   [Verification Run]
>    128    26116.97 (0.00 pct)     25966.86 (-0.57 pct)
>    256    22403.25 (0.00 pct)     22634.04 (1.03 pct)
>    512    48317.20 (0.00 pct)     47123.73 (-2.47 pct)
>   1024    50445.41 (0.00 pct)     48934.56 (-2.99 pct)
> 
> Note: tbench resuts for 256 workers are known to have
> a great amount of run to run variation on the test
> machine. Any regression seen for the data point can
> be safely ignored.
> 
> ~~~~~~
> Stream
> ~~~~~~
> 
> - 10 runs
> 
> NPS1
> 
> Test:         tip                  Filter Overloaded
>   Copy:   189113.11 (0.00 pct)    184006.43 (-2.70 pct)
> Scale:   201190.61 (0.00 pct)    197663.80 (-1.75 pct)
>    Add:   232654.21 (0.00 pct)    223226.88 (-4.05 pct)
> Triad:   226583.57 (0.00 pct)    218920.27 (-3.38 pct)
> 
> NPS2
> 
> Test:          tip                 Filter Overloaded
>   Copy:   155347.14 (0.00 pct)    150710.93 (-2.98 pct)
> Scale:   191701.53 (0.00 pct)    181436.61 (-5.35 pct)
>    Add:   210013.97 (0.00 pct)    200397.89 (-4.57 pct)
> Triad:   207602.00 (0.00 pct)    198247.25 (-4.50 pct)
> 
> NPS4
> 
> Test:          tip                 Filter Overloaded
>   Copy:   136421.15 (0.00 pct)    137608.05 (0.87 pct)
> Scale:   191217.59 (0.00 pct)    189674.77 (-0.80 pct)
>    Add:   189229.52 (0.00 pct)    188682.22 (-0.28 pct)
> Triad:   188052.99 (0.00 pct)    188946.75 (0.47 pct)
> 
> - 100 runs
> 
> NPS1
> 
> Test:          tip                 Filter Overloaded
>   Copy:   244693.32 (0.00 pct)    235089.48 (-3.92 pct)
> Scale:   221874.99 (0.00 pct)    217716.94 (-1.87 pct)
>    Add:   268363.89 (0.00 pct)    266529.22 (-0.68 pct)
> Triad:   260945.24 (0.00 pct)    252780.93 (-3.12 pct)
> 
> NPS2
> 
> Test:          tip                 Filter Overloaded
>   Copy:   211262.00 (0.00 pct)    240922.15 (14.03 pct)
> Scale:   222493.34 (0.00 pct)    220122.09 (-1.06 pct)
>    Add:   280277.17 (0.00 pct)    278002.19 (-0.81 pct)
> Triad:   265860.49 (0.00 pct)    264231.43 (-0.61 pct)
> 
> NPS4
> 
> Test:          tip                 Filter Overloaded
>   Copy:   250171.40 (0.00 pct)    243512.01 (-2.66 pct)
> Scale:   222293.56 (0.00 pct)    224911.55 (1.17 pct)
>    Add:   279222.16 (0.00 pct)    280700.91 (0.52 pct)
> Triad:   262013.92 (0.00 pct)    265729.44 (1.41 pct)
> 
> ~~~~~~~~~~~~
> ycsb-mongodb
> ~~~~~~~~~~~~
> 
> NPS1
> 
> sched-tip:      303718.33 (var: 1.31)
> NUMA Bal:       309396.00 (var: 1.24)    (+1.83%)
> 
> NPS2
> 
> sched-tip:      304536.33 (var: 2.46)
> NUMA Bal:       305209.00 (var: 0.80)    (+0.22%)
> 
> NPS4
> 
> sched-tip:      301192.33 (var: 1.81)
> NUMA Bal:       304248.00 (var: 2.05)    (+1.00%)
> 
> ~~~~~
> Notes
> ~~~~~
> 
> - schbench shows regression for 128 workers in NPS4 mode.
>    The rerun shows stable results for both tip and patched
>    kernel.
> - tbench shows regression for 64 workers in NPS2 and NPS4
>    mode. In NPS2 mode, the tip shows some run to run variance
>    however the median of 10 runs reported is lower for the
>    patched kernel.
> - tbench shows regression for 32 workers in NPS2 mode. The
>    tip seems to report stable values here but there is a
>    slight run to run variation observed in the patched kernel.
> 
> - Overall, the performance is comparable to that of the tip.
> - schbench low worker count improvements has the load balancer
>    coming into the picture. We still have to do deeper analysis
>    to see if and how this patch is helping.
> 
> I haven't run the mmtest as a part of this testing. I've made
> a note of the configs you ran the numbers for. I'll try to
> get numbers for same.
> 
>>
>> v3:
>>    - removed sched-idle balance feature and focus on SIS
>>    - take non-CFS tasks into consideration
>>    - several fixes/improvement suggested by Josh Don
>>
>> v2:
>>    - several optimizations on sched-idle balancing
>>    - ignore asym topos in can_migrate_task
>>    - add more benchmarks including SIS efficiency
>>    - re-organize patch as suggested by Mel
>>
>> v1: https://lore.kernel.org/lkml/20220217154403.6497-5-wuyun.abel@bytedance.com/
>> v2: https://lore.kernel.org/lkml/20220409135104.3733193-1-wuyun.abel@bytedance.com/
>>
>> Signed-off-by: Abel Wu <wuyun.abel@bytedance.com>
>> ---
>>   include/linux/sched/topology.h | 12 ++++++++++
>>   kernel/sched/core.c            | 38 ++++++++++++++++++++++++++++++
>>   kernel/sched/fair.c            | 43 +++++++++++++++++++++++++++-------
>>   kernel/sched/idle.c            |  1 +
>>   kernel/sched/sched.h           |  4 ++++
>>   kernel/sched/topology.c        |  4 +++-
>>   6 files changed, 92 insertions(+), 10 deletions(-)
>>
>> [..snip..]
> 
> Let me know if there is some additional data you would like
> me to gather on the test machine.
> --
> Thanks and Regards,
> Prateek
