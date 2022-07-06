Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D93CC56806E
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Jul 2022 09:45:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231922AbiGFHpW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Jul 2022 03:45:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34246 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231827AbiGFHpT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Jul 2022 03:45:19 -0400
Received: from out30-56.freemail.mail.aliyun.com (out30-56.freemail.mail.aliyun.com [115.124.30.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E169813E0A
        for <linux-kernel@vger.kernel.org>; Wed,  6 Jul 2022 00:45:17 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R131e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046051;MF=cruzzhao@linux.alibaba.com;NM=1;PH=DS;RN=10;SR=0;TI=SMTPD_---0VIXa9DY_1657093513;
Received: from 30.97.49.75(mailfrom:cruzzhao@linux.alibaba.com fp:SMTPD_---0VIXa9DY_1657093513)
          by smtp.aliyun-inc.com;
          Wed, 06 Jul 2022 15:45:14 +0800
Message-ID: <2f2b3592-9cf8-95ad-7150-6fb430906231@linux.alibaba.com>
Date:   Wed, 6 Jul 2022 15:45:13 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.9.0
Subject: Re: [PATCH 2/3] sched/core: Introduce nr_running percpu for each
 cookie
Content-Language: en-US
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     mingo@redhat.com, juri.lelli@redhat.com,
        vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
        rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de,
        bristot@redhat.com, linux-kernel@vger.kernel.org
References: <1656403045-100840-1-git-send-email-CruzZhao@linux.alibaba.com>
 <1656403045-100840-3-git-send-email-CruzZhao@linux.alibaba.com>
 <YsK2riNersXeRgKM@hirez.programming.kicks-ass.net>
From:   cruzzhao <cruzzhao@linux.alibaba.com>
In-Reply-To: <YsK2riNersXeRgKM@hirez.programming.kicks-ass.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-9.9 required=5.0 tests=BAYES_00,
        ENV_AND_HDR_SPF_MATCH,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        UNPARSEABLE_RELAY,USER_IN_DEF_SPF_WL autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



在 2022/7/4 下午5:45, Peter Zijlstra 写道:
> On Tue, Jun 28, 2022 at 03:57:24PM +0800, Cruz Zhao wrote:
> 
>>  static unsigned long sched_core_alloc_cookie(void)
>>  {
>>  	struct sched_core_cookie *ck = kmalloc(sizeof(*ck), GFP_KERNEL);
>> +	int cpu;
>> +
>>  	if (!ck)
>>  		return 0;
>>  
>>  	refcount_set(&ck->refcnt, 1);
>> +
>> +	ck->nr_running = alloc_percpu(unsigned int);
> 
> 	if (!ck->nr_running)
> 		// do something
> 
>> +	for_each_possible_cpu(cpu)
>> +		*per_cpu_ptr(ck->nr_running, cpu) = 0;
> 
> So I really, as in *really* dislike how this blows up the size of
> cookies. Esp. with 100s of CPUs not actually being rare these days.

My idea is to get the distribution of cookie'd tasks on each runqueue
through ck->nr_running, so as to facilitate optimization of load
balance. Sorry for not stating this in the change log.

This does blow up the size of cookies in scenarios with a large number
of CPUs, and I'll try to get around this problem.

Many thanks for reviewing.
Best wishes,
Cruz Zhao
