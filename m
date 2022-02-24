Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4FF764C2214
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Feb 2022 04:23:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229521AbiBXDUP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Feb 2022 22:20:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34464 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229437AbiBXDUN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Feb 2022 22:20:13 -0500
Received: from mail-pl1-x633.google.com (mail-pl1-x633.google.com [IPv6:2607:f8b0:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C60D1BA939
        for <linux-kernel@vger.kernel.org>; Wed, 23 Feb 2022 19:19:45 -0800 (PST)
Received: by mail-pl1-x633.google.com with SMTP id m11so562270pls.5
        for <linux-kernel@vger.kernel.org>; Wed, 23 Feb 2022 19:19:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language
         :from:to:references:cc:in-reply-to:content-transfer-encoding;
        bh=wshqPUek1QQZBWiSkLmAGPlaWkbzJpVqUSsAMFQKUHE=;
        b=3vXVz5bDBpKS6EC4hhX7dxTtd1GALS1fAUpZD412SrZIIVl14TaiaE6iDmWADpLfVt
         VJ1f1VwfVPU9D97iCdHLBeUifWEdUJtmI+WwgcwMYiYP9Ekj5Kpt0020BXCFI9erTQy0
         L9GLLXrIdKHLXW59zeNcko8YmgvoYLUx1e0rJonAtxmj2Amd1y4wF0062OH2lWeK+rvf
         4BWSgAPk4eQROlNQUZVmKsSgx55tNJLQfozaqagitsaf82+M5we5oHjP+CDrnL0IN+0e
         QO9Wg+TVCd66OztQWjdv7gzdNRejUUsZ7utl8PPokoTXyd0VvMeBxxopmWAx5/AQBoOo
         QW9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:from:to:references:cc:in-reply-to
         :content-transfer-encoding;
        bh=wshqPUek1QQZBWiSkLmAGPlaWkbzJpVqUSsAMFQKUHE=;
        b=jIMs9i4CMKUFAKULWqe7UIPqwn+rYza2K1LHYvucTPSB3/n1IlLp1mfPoRK4HhbEtz
         Jy4WKFvJoKVexFQmoIDytJZ7h90aPr/nLdE+ASm7rT5FfltNfK60vHq+OzmqAYZYQM6U
         1D9m7x2OuCdY+lOmi3XLWabjF47Ki3sbN+JG2wHs4odDU/bfr2pgC9ztdEawwJ4D5t8o
         gvcMKu8nQAzNB1CckFauZb/3nxkJttVO82ZleMFCjztkEtth244Ouyzgjsmum85sb4w3
         4a/hoDC6czHVRPdGP+CTqkY5Nzos0k8NLddwVfPWhkwtii9d20jtWssFRIvE1eizrV52
         k+6w==
X-Gm-Message-State: AOAM531hKGzvpN9wgbMiIeFoEDO8r55XVP+4HU3sB3QPN/UfTzPkaupo
        1nAQEFeOqfTSBCQ1NlLhgOJKdg==
X-Google-Smtp-Source: ABdhPJxGkNb9oBC/MU4xkJGBAyGMgH3kQlcMpMRFEehkfrVCRxmFBD71BI6jUfHSeDZwWWtZx4hZGw==
X-Received: by 2002:a17:902:e80c:b0:14f:f95c:41ee with SMTP id u12-20020a170902e80c00b0014ff95c41eemr576513plg.31.1645672784562;
        Wed, 23 Feb 2022 19:19:44 -0800 (PST)
Received: from [10.94.58.189] ([139.177.225.254])
        by smtp.gmail.com with ESMTPSA id u4sm1038630pfk.220.2022.02.23.19.19.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 23 Feb 2022 19:19:44 -0800 (PST)
Message-ID: <f8480c59-f677-c6a4-75bb-227de6a1fc2c@bytedance.com>
Date:   Thu, 24 Feb 2022 11:19:38 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.6.1
Subject: Re: [RFC PATCH 0/5] introduce sched-idle balancing
Content-Language: en-US
From:   Abel Wu <wuyun.abel@bytedance.com>
To:     Peter Zijlstra <peterz@infradead.org>
References: <20220217154403.6497-1-wuyun.abel@bytedance.com>
Cc:     Ben Segall <bsegall@google.com>,
        Juri Lelli <juri.lelli@redhat.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Mel Gorman <mgorman@suse.de>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Ingo Molnar <mingo@redhat.com>, linux-kernel@vger.kernel.org,
        Abel Wu <wuyun.abel@bytedance.com>
In-Reply-To: <20220217154403.6497-1-wuyun.abel@bytedance.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Ping :)

On 2/17/22 11:43 PM, Abel Wu Wrote:
> Current load balancing is mainly based on cpu capacity
> and task util, which makes sense in the POV of overall
> throughput. While there still might be some improvement
> can be done by reducing number of overloaded cfs rqs if
> sched-idle or idle rq exists.
> 
> An CFS runqueue is considered overloaded when there are
> more than one pullable non-idle tasks on it (since sched-
> idle cpus are treated as idle cpus). And idle tasks are
> counted towards rq->cfs.idle_h_nr_running, that is either
> assigned SCHED_IDLE policy or placed under idle cgroups.
> 
> The overloaded cfs rqs can cause performance issues to
> both task types:
> 
>    - for latency critical tasks like SCHED_NORMAL,
>      time of waiting in the rq will increase and
>      result in higher pct99 latency, and
> 
>    - batch tasks may not be able to make full use
>      of cpu capacity if sched-idle rq exists, thus
>      presents poorer throughput.
> 
> So in short, the goal of the sched-idle balancing is to
> let the *non-idle tasks* make full use of cpu resources.
> To achieve that, we mainly do two things:
> 
>    - pull non-idle tasks for sched-idle or idle rqs
>      from the overloaded ones, and
> 
>    - prevent pulling the last non-idle task in an rq
> 
> The mask of overloaded cpus is updated in periodic tick
> and the idle path at the LLC domain basis. This cpumask
> will also be used in SIS as a filter, improving idle cpu
> searching.
> 
> Tests are done in an Intel Xeon E5-2650 v4 server with
> 2 NUMA nodes each of which has 12 cores, and with SMT2
> enabled, so 48 CPUs in total. Test results are listed
> as follows.
> 
>    - we used perf messaging test to test throughput
>      at different load (groups).
> 
>        perf bench sched messaging -g [N] -l 40000
> 
> 	N	w/o	w/	diff
> 	1	2.897	2.834	-2.17%
> 	3	5.156	4.904	-4.89%
> 	5	7.850	7.617	-2.97%
> 	10	15.140	14.574	-3.74%
> 	20	29.387	27.602	-6.07%
> 
>      the result shows approximate 2~6% improvement.
> 
>    - and schbench to test latency performance in two
>      scenarios: quiet and noisy. In quiet test, we
>      run schbench in a normal cpu cgroup in a quiet
>      system, while the noisy test additionally runs
>      perf messaging workload inside an idle cgroup
>      as nosie.
> 
>        schbench -m 2 -t 24 -i 60 -r 60
>        perf bench sched messaging -g 1 -l 4000000
> 
> 	[quiet]
> 			w/o	w/
> 	50.0th		31	31
> 	75.0th		45	45
> 	90.0th		55	55
> 	95.0th		62	61
> 	*99.0th		85	86
> 	99.5th		565	318
> 	99.9th		11536	10992
> 	max		13029	13067
> 
> 	[nosiy]
> 			w/o	w/
> 	50.0th		34	32
> 	75.0th		48	45
> 	90.0th		58	55
> 	95.0th		65	61
> 	*99.0th		2364	208
> 	99.5th		6696	2068
> 	99.9th		12688	8816
> 	max		15209	14191
> 
>      it can be seen that the quiet test results are
>      quite similar, but the p99 latency is greatly
>      improved in the nosiy test.
> 
> Comments and tests are appreciated!
> 
> Abel Wu (5):
>    sched/fair: record overloaded cpus
>    sched/fair: introduce sched-idle balance
>    sched/fair: add stats for sched-idle balancing
>    sched/fair: filter out overloaded cpus in sis
>    sched/fair: favor cpu capacity for idle tasks
> 
>   include/linux/sched/idle.h     |   1 +
>   include/linux/sched/topology.h |  15 ++++
>   kernel/sched/core.c            |   1 +
>   kernel/sched/fair.c            | 187 ++++++++++++++++++++++++++++++++++++++++-
>   kernel/sched/sched.h           |   6 ++
>   kernel/sched/stats.c           |   5 +-
>   kernel/sched/topology.c        |   4 +-
>   7 files changed, 215 insertions(+), 4 deletions(-)
> 
