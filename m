Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7199D581E7B
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Jul 2022 06:03:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240202AbiG0EC4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Jul 2022 00:02:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45690 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231448AbiG0ECy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Jul 2022 00:02:54 -0400
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D1C315820
        for <linux-kernel@vger.kernel.org>; Tue, 26 Jul 2022 21:02:53 -0700 (PDT)
Received: from canpemm500009.china.huawei.com (unknown [172.30.72.53])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4Lt0RL2rhFzjXMK;
        Wed, 27 Jul 2022 11:59:58 +0800 (CST)
Received: from [10.67.109.51] (10.67.109.51) by canpemm500009.china.huawei.com
 (7.192.105.203) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Wed, 27 Jul
 2022 12:02:51 +0800
Message-ID: <85d5087b-450c-351f-270d-c61303cf3187@huawei.com>
Date:   Wed, 27 Jul 2022 12:02:51 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.2
To:     Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        "open list:SCHEDULER" <linux-kernel@vger.kernel.org>
From:   "Lihua (lihua, ran)" <hucool.lihua@huawei.com>
Subject: [Question] Reading /proc/stat has a time backward issue
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.67.109.51]
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 canpemm500009.china.huawei.com (7.192.105.203)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,

I found a problem that the statistical time goes backward, the value read first is 319, and the value read again is 318. As follows：
first：
cat /proc/stat |  grep cpu1
cpu1    319    0    496    41665    0    0    0    0    0    0
then：
cat /proc/stat |  grep cpu1
cpu1    318    0    497    41674    0    0    0    0    0    0

Time goes back, which is counterintuitive.

After debug this, I found that the problem is caused by the implementation of kcpustat_cpu_fetch_vtime. As follows：

                               CPU0                                                                          CPU1
First:
show_stat():
     ->kcpustat_cpu_fetch()
         ->kcpustat_cpu_fetch_vtime()
             ->cpustat[CPUTIME_USER] = kcpustat_cpu(cpu) + vtime->utime + delta;              rq->curr is in user mod
              ---> When CPU1 rq->curr running on userspace, need add utime and delta
                                                                                              --->  rq->curr->vtime->utime is less than 1 tick
Then:
show_stat():
     ->kcpustat_cpu_fetch()
         ->kcpustat_cpu_fetch_vtime()
             ->cpustat[CPUTIME_USER] = kcpustat_cpu(cpu);                                     rq->curr is in kernel mod
             ---> When CPU1 rq->curr running on kernel space, just got kcpustat

Because the values ​​of utime、 stime and delta are temporarily written to cpustat. Therefore, there are two problems  read from /proc/stat:
1. There may be a regression phenomenon;
2. When there are many tasks, the statistics are not accurate enough when utime and stime do not exceed one TICK.
The time goes back is counterintuitive, and I want to discuss whether there is a good solution without compromising performance.

Thanks a lot.
