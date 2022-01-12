Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E353048C079
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jan 2022 09:56:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351813AbiALI4Z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Jan 2022 03:56:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55932 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351812AbiALI4X (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Jan 2022 03:56:23 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A9B7DC061748
        for <linux-kernel@vger.kernel.org>; Wed, 12 Jan 2022 00:56:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Transfer-Encoding:
        Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:
        Sender:Reply-To:Content-ID:Content-Description;
        bh=NggganCdDeKjUqagsctVdMr1XqjwmXp86S2FxDd1sfo=; b=aq8Q0jAph6jNKa1KNsqyrw8S85
        5ti2plkwDEU0ZNfjNeoS9v4NCl0jpj7WUjrODD4ka7ySN0Lmk0j+Oy7Nsg4FCXkb9x606/ymfsRzP
        nOktO/n7O3ZFcyX63maoa2A2ilj+eF39Y0IhBJQzt87Lgs2S8Lm0SIgvACsJB5RECFQYOGAJAav6Y
        /o/9Hc6d++SHGd5Yshd1oe9OQrGRaxFnSUWmIpZTeIqAYcF2DgoBSMK4gAX9R5VtA/GSS/BhnRJI8
        wo8yGreBvEqSMwnpIGv2DDq7C++c3v2M3jxOnz8l1Ji78tXhdizJNO4/G0jRrJGpprbM6SiRezOHp
        o0VoYrUg==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1n7ZQA-003xnJ-On; Wed, 12 Jan 2022 08:55:55 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 1350A3001CD;
        Wed, 12 Jan 2022 09:55:51 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id C7DEC20CF2F6B; Wed, 12 Jan 2022 09:55:51 +0100 (CET)
Date:   Wed, 12 Jan 2022 09:55:51 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     =?utf-8?B?546L6LSH?= <yun.wang@linux.alibaba.com>
Cc:     Ingo Molnar <mingo@redhat.com>, Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        Chris Down <chris@chrisdown.name>,
        Vipin Sharma <vipinsh@google.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Arnd Bergmann <arnd@arndb.de>,
        Cruz Zhao <cruzzhao@linux.alibaba.com>,
        Tianchen Ding <dtcccc@linux.alibaba.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH] sched: introduce group balancer
Message-ID: <Yd6Xlw1qvEbWFSwU@hirez.programming.kicks-ass.net>
References: <98f41efd-74b2-198a-839c-51b785b748a6@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <98f41efd-74b2-198a-839c-51b785b748a6@linux.alibaba.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 04, 2022 at 03:33:57PM +0800, 王贇 wrote:
> Modern platform are growing fast on CPU numbers, multiple
> apps sharing one box are very common, they used to have
> exclusive cpu setting but nowadays things are changing.
> 
> To achieve better utility of CPU resource, multiple apps
> are starting to sharing the CPUs. The CPU resources usually
> overcommitted since app's workload are undulated.
> 
> This introduced problems on performance when share mode vs
> exclusive mode, for eg with cgroup A,B and C deployed in
> exclusive mode, it will be:
> 
>   CPU_X (100%)     CPU_Y (100%)     CPU_Z (50%)
>   T_1_CG_A         T_1_CG_B         T_1_CG_C
>   T_2_CG_A         T_2_CG_B         T_2_CG_C
>   T_3_CG_A         T_3_CG_B
>   T_4_CG_A         T_4_CG_B
> 
> while the share mode will be:
> 
>   CPU_X (100%)     CPU_Y (75%)     CPU_Z (75%)
>   T_1_CG_A         T_2_CG_A         T_1_CG_B
>   T_2_CG_B         T_3_CG_B         T_2_CG_C
>   T_4_CG_B         T_4_CG_A         T_3_CG_A
>   T_1_CG_C
> 
> As we can see, the confliction between groups on CPU
> resources are now happening all over the CPUs.
> 
> The testing on sysbench-memory show 30+% drop on share
> mode, and redis-benchmark show 10+% drop too, compared
> to the exclusive mode.
> 
> However, despite of the performance drop, in real world
> we still prefer share mode. The undulated workload can
> make the exclusive mode so unefficient on CPU utilization,
> for eg the next period, when CG_A become 'idle', exclusive
> mode will like:
> 
>   CPU_X (0%)     CPU_Y (100%)     CPU_Z (50%)
>                  T_1_CG_B         T_1_CG_C
>                  T_2_CG_B         T_2_CG_C
>                  T_3_CG_B
>                  T_4_CG_B
> 
> while share mode like:
> 
>   CPU_X (50%)     CPU_Y (50%)     CPU_Z (50%)
>   T_2_CG_B         T_1_CG_C        T_3_CG_B
>   T_4_CG_B         T_1_CG_B        T_2_CG_C
> 
> The CPU_X is totally wasted in exclusive mode, the resource
> efficiency are really poor.
> 
> Thus what we need, is a way to ease confliction in share mode,
> make groups as exclusive as possible, to gain both performance
> and resource efficiency.
> 
> The main idea of group balancer is to fulfill this requirement
> by balancing groups of tasks among groups of CPUs, consider this
> as a dynamic demi-exclusive mode.

Also look at the oracle soft affinity patches

> Just like balance the task among CPUs, now with GB a user can
> put CPU X,Y,Z into three partitions, and balance group A,B,C
> into these partition, to make them as exclusive as possible.
> 
> The design is very likely to the numa balancing, task trigger
> work to settle it's group into a proper partition (minimum
> predicted load), then try migrate itself into it. To gradually
> settle groups into the most exclusively partition.

No words on the interaction between this and numa balancing. Numa
balancing is already a bit tricky because it and the regular load
balancer will have conflicting goals, some of that is mitigated by
teaching the regular balancing about some of that.

I can't help but feel you're making the whole thing look like a 3 body
problem. Also, regular balancing in the face of affinities is already
somewhat dicy. All that needs exploring.

> 
> How To Use:
> 
> To create partition, for example run:
>   echo disable > /proc/gb_ctrl
>   echo "0-15;16-31;32-47;48-63;" > /proc/gb_ctrl
>   echo enable > /proc/gb_ctrl

That's just never going to happen; please look at the cpuset partition
stuff.

> 
> this will create 4 partitions contain CPUs 0-15,16-31,32-47 and
> 48-63 separately.
> 
> Then enable GB for your cgroup, run
>   $CPU_CGROUP_PATH/cpu.gb_period_ms
> 
> And you can check:
>   $CPU_CGROUP_PATH/cpu.gb_stat
> 
> which give output as:
>   PART-0 0-15 1008 1086  *
>   PART-1 16-31 0 2
>   PART-2 32-47 0 0
>   PART-3 48-63 0 1024
> 
> The partition ID followed by it's CPUs range, load of group, load
> of partition and a star mark as preferred.
> 
> Testing Results:
>   In order to enlarge the differences, we do testing on ARM platform
>   with 128 CPUs, create 8 partition according to cluster info.
> 
>   Since we pick benchmark which can gain benefit from exclusive mode,
>   this is more like a functional testing rather than performance, to
>   show that GB help winback the performance.
> 
>   Create 8 cgroup each running 'sysbench memory --threads=16 run',
>   the output of share mode is:
>     events/s (eps):                      4181233.4646
>     events/s (eps):                      3548328.2346
>     events/s (eps):                      4578816.2412
>     events/s (eps):                      4761797.3932
>     events/s (eps):                      3486703.0455
>     events/s (eps):                      3474920.9803
>     events/s (eps):                      3604632.7799
>     events/s (eps):                      3149506.7001
>   the output of gb mode is:
>     events/s (eps):                      5472334.9313
>     events/s (eps):                      4085399.1606
>     events/s (eps):                      4398122.2170
>     events/s (eps):                      6180233.6766
>     events/s (eps):                      4299784.2742
>     events/s (eps):                      4914813.6847
>     events/s (eps):                      3675395.1191
>     events/s (eps):                      6767666.6229
> 
>   Create 4 cgroup each running redis-server with 16 io threads,
>   4 redis-benchmark per each server show average rps as:
> 
>                     share mode       gb mode
> 
>   PING_INLINE     : 41154.84         42229.27               2.61%
>   PING_MBULK      : 43042.07         44907.10               4.33%
>   SET             : 34502.00         37374.58               8.33%
>   GET             : 41713.47         45257.68               8.50%
>   INCR            : 41533.26         44259.31               6.56%
>   LPUSH           : 36541.23         39417.84               7.87%
>   RPUSH           : 39059.26         42075.32               7.72%
>   LPOP            : 36978.73         39903.15               7.91%
>   RPOP            : 39553.32         42071.53               6.37%
>   SADD            : 40614.30         44693.33              10.04%
>   HSET            : 39101.93         42401.16               8.44%
>   SPOP            : 42838.90         46560.46               8.69%
>   ZADD            : 38346.80         41685.46               8.71%
>   ZPOPMIN         : 41952.26         46138.14               9.98%
>   LRANGE_100      : 19364.66         20251.56               4.58%
>   LRANGE_300      : 9699.57          9935.86                2.44%
>   LRANGE_500      : 6291.76          6512.48                3.51%
>   LRANGE_600      : 5619.13          5658.31                0.70%
>   MSET            : 24432.78         26517.63               8.53%
> 
> Signed-off-by: Cruz Zhao <cruzzhao@linux.alibaba.com>
> Signed-off-by: Tianchen Ding <dtcccc@linux.alibaba.com>
> Signed-off-by: Michael Wang <yun.wang@linux.alibaba.com>

Invalid SoB chain.


I'll not really have much time at the moment to look at the code.
Hopefully in a few weeks, but I first need to recover from a 2 week
break and then finish the umcg bits I was working on before that.
