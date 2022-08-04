Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9622958989A
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Aug 2022 09:44:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238850AbiHDHoT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 Aug 2022 03:44:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60758 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232405AbiHDHoQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Aug 2022 03:44:16 -0400
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 80A5061D7A
        for <linux-kernel@vger.kernel.org>; Thu,  4 Aug 2022 00:44:14 -0700 (PDT)
Received: from canpemm500009.china.huawei.com (unknown [172.30.72.57])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4Lz1031vtHzmVLF;
        Thu,  4 Aug 2022 15:42:11 +0800 (CST)
Received: from [10.67.109.51] (10.67.109.51) by canpemm500009.china.huawei.com
 (7.192.105.203) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Thu, 4 Aug
 2022 15:44:08 +0800
Message-ID: <1f1f625a-148d-0398-f840-1f9b4e964189@huawei.com>
Date:   Thu, 4 Aug 2022 15:44:08 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.2
Subject: Re: [Question] Reading /proc/stat has a time backward issue
From:   "Lihua (lihua, ran)" <hucool.lihua@huawei.com>
To:     Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        "open list:SCHEDULER" <linux-kernel@vger.kernel.org>
References: <85d5087b-450c-351f-270d-c61303cf3187@huawei.com>
In-Reply-To: <85d5087b-450c-351f-270d-c61303cf3187@huawei.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.67.109.51]
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 canpemm500009.china.huawei.com (7.192.105.203)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

ping...

Any good suggestions?

thanks all.

在 2022/7/27 12:02, Lihua (lihua, ran) 写道:
> Hi all,
> 
> I found a problem that the statistical time goes backward, the value read first is 319, and the value read again is 318. As follows：
> first：
> cat /proc/stat |  grep cpu1
> cpu1    319    0    496    41665    0    0    0    0    0    0
> then：
> cat /proc/stat |  grep cpu1
> cpu1    318    0    497    41674    0    0    0    0    0    0
> 
> Time goes back, which is counterintuitive.
> 
> After debug this, I found that the problem is caused by the implementation of kcpustat_cpu_fetch_vtime. As follows：
> 
>                                CPU0                                                                          CPU1
> First:
> show_stat():
>      ->kcpustat_cpu_fetch()
>          ->kcpustat_cpu_fetch_vtime()
>              ->cpustat[CPUTIME_USER] = kcpustat_cpu(cpu) + vtime->utime + delta;              rq->curr is in user mod
>               ---> When CPU1 rq->curr running on userspace, need add utime and delta
>                                                                                               --->  rq->curr->vtime->utime is less than 1 tick
> Then:
> show_stat():
>      ->kcpustat_cpu_fetch()
>          ->kcpustat_cpu_fetch_vtime()
>              ->cpustat[CPUTIME_USER] = kcpustat_cpu(cpu);                                     rq->curr is in kernel mod
>              ---> When CPU1 rq->curr running on kernel space, just got kcpustat
> 
> Because the values ​​of utime、 stime and delta are temporarily written to cpustat. Therefore, there are two problems  read from /proc/stat:
> 1. There may be a regression phenomenon;
> 2. When there are many tasks, the statistics are not accurate enough when utime and stime do not exceed one TICK.
> The time goes back is counterintuitive, and I want to discuss whether there is a good solution without compromising performance.
> 
> Thanks a lot.
