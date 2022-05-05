Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8F63551C855
	for <lists+linux-kernel@lfdr.de>; Thu,  5 May 2022 20:46:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1380686AbiEESuO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 May 2022 14:50:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55010 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1355541AbiEEStx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 May 2022 14:49:53 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id E8CDF140DF
        for <linux-kernel@vger.kernel.org>; Thu,  5 May 2022 11:44:26 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id BC45D106F;
        Thu,  5 May 2022 11:44:26 -0700 (PDT)
Received: from [192.168.178.6] (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 44E493FA31;
        Thu,  5 May 2022 11:44:25 -0700 (PDT)
Message-ID: <e5c9bf77-7a86-ff6c-1a0f-57ba6d12ff6b@arm.com>
Date:   Thu, 5 May 2022 20:44:16 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.1
Subject: Re: [PATCH v8 1/7] sched/fair: Provide u64 read for 32-bits arch
 helper
Content-Language: en-US
From:   Dietmar Eggemann <dietmar.eggemann@arm.com>
To:     peterz@infradead.org, mingo@redhat.com, vincent.guittot@linaro.org,
        vdonnefort@gmail.com
Cc:     linux-kernel@vger.kernel.org, morten.rasmussen@arm.com,
        chris.redpath@arm.com, qperret@google.com, tao.zhou@linux.dev
References: <20220429141148.181816-1-vincent.donnefort@arm.com>
 <20220429141148.181816-2-vincent.donnefort@arm.com>
 <251d4cd4-7a28-af7b-942e-4e9f762fc05f@arm.com>
In-Reply-To: <251d4cd4-7a28-af7b-942e-4e9f762fc05f@arm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-9.4 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

+ vdonnefort@gmail.com
- vincent.donnefort@arm.com

On 05/05/2022 20:25, Dietmar Eggemann wrote:
> On 29/04/2022 16:11, Vincent Donnefort wrote:
>> Introducing macro helpers u64_u32_{store,load}() to factorize lockless
>> accesses to u64 variables for 32-bits architectures.
>>
>> Users are for now cfs_rq.min_vruntime and sched_avg.last_update_time. To
>> accommodate the later where the copy lies outside of the structure
>> (cfs_rq.last_udpate_time_copy instead of sched_avg.last_update_time_copy),
>> use the _copy() version of those helpers.
>>
>> Those new helpers encapsulate smp_rmb() and smp_wmb() synchronization and
>> therefore, have a small penalty in set_task_rq_fair() and init_cfs_rq().
> 
> ... but obviously only on 32bit machines. And for set_task_rq_fair() we
> now do one smp_rmb per cfs_rq (prev and next), like we do one smp_wmb()
> per cfs_rq in update_cfs_rq_load_avg().
> 
> [...]
> 
>> @@ -3786,8 +3770,9 @@ update_cfs_rq_load_avg(u64 now, struct cfs_rq *cfs_rq)
>>  	decayed |= __update_load_avg_cfs_rq(now, cfs_rq);
>>  
>>  #ifndef CONFIG_64BIT
> 
> Can we not get rid of this last CONFIG_64BIT here?
> 
>> -	smp_wmb();
>> -	cfs_rq->load_last_update_time_copy = sa->last_update_time;
>> +	u64_u32_store_copy(sa->last_update_time,
>> +			   cfs_rq->last_update_time_copy,
>> +			   sa->last_update_time);
> 
> (sa->last_update_time = sa->last_update_time); should dissolve on 64bit.
> 
>>  #endif
> 
> [...]
> 
> Reviewed-by: Dietmar Eggemann <dietmar.eggemann@arm.com>

