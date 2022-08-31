Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7AFF45A87C8
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Aug 2022 22:56:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231788AbiHaU4n (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 Aug 2022 16:56:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39072 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231755AbiHaU4j (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Aug 2022 16:56:39 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 897B5DA3F6
        for <linux-kernel@vger.kernel.org>; Wed, 31 Aug 2022 13:56:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1661979397;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=qnNunS1Uu1r2E9WQbQD7VNVpEMdhi6o4PT34nVTssRQ=;
        b=Z6IU8k/V7mNSagHILqoMDPudmJZzR2C6x44EeUbsLEJ2HfONXiMPt2NP/YnBYLabrDEf1M
        GBPu+MklEOiMlOtM+ltDKK+6w4ZYW449F6j09TnDyY83QwLw53A9zm7NWhaLoyOhF4aekQ
        lTFtYwv6Y+OjE7bBGET5SScf2jScZP4=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-533-hF-lzSJeP3e2wkCeHmHk6A-1; Wed, 31 Aug 2022 16:56:33 -0400
X-MC-Unique: hF-lzSJeP3e2wkCeHmHk6A-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com [10.11.54.3])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id CC08D29AB416;
        Wed, 31 Aug 2022 20:56:32 +0000 (UTC)
Received: from [10.18.17.215] (dhcp-17-215.bos.redhat.com [10.18.17.215])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 46AD11121314;
        Wed, 31 Aug 2022 20:56:32 +0000 (UTC)
Message-ID: <1eef45a5-e418-e3c6-631f-58b9e52afedf@redhat.com>
Date:   Wed, 31 Aug 2022 16:56:32 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.12.0
Subject: Re: [PATCH v6 4/5] sched: Handle set_cpus_allowed_ptr() &
 sched_setaffinity() race
Content-Language: en-US
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Ingo Molnar <mingo@redhat.com>, Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Valentin Schneider <vschneid@redhat.com>,
        Tejun Heo <tj@kernel.org>, Zefan Li <lizefan.x@bytedance.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Will Deacon <will@kernel.org>, linux-kernel@vger.kernel.org,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Lai Jiangshan <jiangshanlai@gmail.com>
References: <20220826010119.1265764-1-longman@redhat.com>
 <20220826010119.1265764-5-longman@redhat.com>
 <Yw8uS0Ibavb/5s4D@hirez.programming.kicks-ass.net>
From:   Waiman Long <longman@redhat.com>
In-Reply-To: <Yw8uS0Ibavb/5s4D@hirez.programming.kicks-ass.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.78 on 10.11.54.3
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/31/22 05:47, Peter Zijlstra wrote:
> On Thu, Aug 25, 2022 at 09:01:18PM -0400, Waiman Long wrote:
>> @@ -2722,6 +2734,7 @@ static int affine_move_task(struct rq *rq, struct task_struct *p, struct rq_flag
>>   			complete = true;
>>   		}
>>   
>> +		swap_user_cpus_ptr(p, puser_mask);
>>   		task_rq_unlock(rq, p, rf);
>>   
>>   		if (push_task) {
>> @@ -2793,6 +2806,7 @@ static int affine_move_task(struct rq *rq, struct task_struct *p, struct rq_flag
>>   		if (flags & SCA_MIGRATE_ENABLE)
>>   			p->migration_flags &= ~MDF_PUSH;
>>   
>> +		swap_user_cpus_ptr(p, puser_mask);
>>   		task_rq_unlock(rq, p, rf);
>>   
>>   		if (!stop_pending) {
>> @@ -2813,6 +2827,8 @@ static int affine_move_task(struct rq *rq, struct task_struct *p, struct rq_flag
>>   				complete = true;
>>   			}
>>   		}
>> +
>> +		swap_user_cpus_ptr(p, puser_mask);
>>   		task_rq_unlock(rq, p, rf);
>>   
>>   		if (complete)
> I'm not at all sure about those.
>
> Would it not be much simpler to keep the update of cpus_mask and
> cpus_user_mask together, always ensuring that cpus_user_mask is a strict
> superset of cpus_mask ? That is, set_cpus_allowed_common() seems like
> the right place to me.
>
> I'm thinking this also means blowing away user_mask when we do a full
> reset of the cpus_mask when we do an affnity break.

Thanks for the suggestion. I will need to think about what will be best 
way to pass in those additional parameters there.

Cheers,
Longman

