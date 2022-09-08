Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7A7135B22C6
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Sep 2022 17:49:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231320AbiIHPs4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Sep 2022 11:48:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43852 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229624AbiIHPsx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Sep 2022 11:48:53 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E42B1228F5
        for <linux-kernel@vger.kernel.org>; Thu,  8 Sep 2022 08:48:52 -0700 (PDT)
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 288DZVqC010534;
        Thu, 8 Sep 2022 15:48:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=yOugogtwzC8XK024aZ0V07QQgwjWnAXlPiIzTrNpCoE=;
 b=ZN5G4sqm+ZVBYqJckd6beYzb1C59UKXYPzYNKN+MoLiGug3jOybregsFWuLOHoYODytf
 fGOnFr/GG1Jx1br56kjULA9k/Rrg71zgX8Rpq0zvzQSARYOD8XuwupMn4Huk+Df/VM2s
 e308NHM6pjL45LPGNEVUFKhGg2b8/NH0gV2ns4RsVuTc1XHYvlyKxT8wYrI+7DdZOIUa
 2nOOhgsNLReTXOdZRlEbtarGLGDTmlqM7owfU8rWjcUn51DP5v6MkIp1b0Gl3VOQumR/
 2l9jRm3rw5PgMPt75wqUf92pFjcKOTTPS23xO2EyJr8pzjV28ldUi4JHEOo+RuYzz3A6 Qg== 
Received: from nasanppmta01.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3jfcpbs8eq-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 08 Sep 2022 15:48:37 +0000
Received: from pps.filterd (NASANPPMTA01.qualcomm.com [127.0.0.1])
        by NASANPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTP id 288FmaPO026533;
        Thu, 8 Sep 2022 15:48:36 GMT
Received: from pps.reinject (localhost [127.0.0.1])
        by NASANPPMTA01.qualcomm.com (PPS) with ESMTPS id 3jfe8xb2f6-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 08 Sep 2022 15:48:36 +0000
Received: from NASANPPMTA01.qualcomm.com (NASANPPMTA01.qualcomm.com [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 288Fmaae026522;
        Thu, 8 Sep 2022 15:48:36 GMT
Received: from nasanex01c.na.qualcomm.com (corens_vlan604_snip.qualcomm.com [10.53.140.1])
        by NASANPPMTA01.qualcomm.com (PPS) with ESMTPS id 288Fmaq5026520
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 08 Sep 2022 15:48:36 +0000
Received: from [10.216.56.128] (10.80.80.8) by nasanex01c.na.qualcomm.com
 (10.45.79.139) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.29; Thu, 8 Sep 2022
 08:48:33 -0700
Message-ID: <0aafd6bd-6c4c-bb77-7b33-a6d04ee6e5b3@quicinc.com>
Date:   Thu, 8 Sep 2022 21:18:29 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.13.0
Subject: Re: [PATCH] locking/rwsem: Disable preemption while trying for rwsem
 lock
Content-Language: en-US
To:     Peter Zijlstra <peterz@infradead.org>
CC:     <mingo@redhat.com>, <will@kernel.org>, <longman@redhat.com>,
        <boqun.feng@gmail.com>, <linux-kernel@vger.kernel.org>,
        "Gokul krishna Krishnakumar" <quic_gokukris@quicinc.com>
References: <1662028090-26495-1-git-send-email-quic_mojha@quicinc.com>
 <Yxn87KDv1h4mwbIL@hirez.programming.kicks-ass.net>
From:   Mukesh Ojha <quic_mojha@quicinc.com>
In-Reply-To: <Yxn87KDv1h4mwbIL@hirez.programming.kicks-ass.net>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nasanex01c.na.qualcomm.com (10.45.79.139)
X-QCInternal: smtphost
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: ivSJA-x0m7O2KAKNIiI4IONCTliXZJwA
X-Proofpoint-GUID: ivSJA-x0m7O2KAKNIiI4IONCTliXZJwA
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.528,FMLib:17.11.122.1
 definitions=2022-09-08_10,2022-09-08_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0 adultscore=0
 clxscore=1015 bulkscore=0 mlxlogscore=928 lowpriorityscore=0
 malwarescore=0 mlxscore=0 impostorscore=0 spamscore=0 priorityscore=1501
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2207270000 definitions=main-2209080057
X-Spam-Status: No, score=-6.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Peter,

Thanks for your time in reviewing this patch.

On 9/8/2022 8:02 PM, Peter Zijlstra wrote:
> On Thu, Sep 01, 2022 at 03:58:10PM +0530, Mukesh Ojha wrote:
>> From: Gokul krishna Krishnakumar <quic_gokukris@quicinc.com>
>>
>> Make the region inside the rwsem_write_trylock non preemptible.
>>
>> We observe RT task is hogging CPU when trying to acquire rwsem lock
>> which was acquired by a kworker task but before the rwsem owner was set.
>>
>> Here is the scenario:
>> 1. CFS task (affined to a particular CPU) takes rwsem lock.
>>
>> 2. CFS task gets preempted by a RT task before setting owner.
>>
>> 3. RT task (FIFO) is trying to acquire the lock, but spinning until
>> RT throttling happens for the lock as the lock was taken by CFS task.
>>
>> This patch attempts to fix the above issue by disabling preemption
>> until owner is set for the lock. while at it also fix this issue
>> at the place where owner being set/cleared.
>>
>> Signed-off-by: Gokul krishna Krishnakumar <quic_gokukris@quicinc.com>
>> Signed-off-by: Mukesh Ojha <quic_mojha@quicinc.com>
> 
> This is not a valid SoB chain.

Since this patch of adding preempt disable() at rwsem_write_trylock() is 
originated from Gokul.

Would be adding him in
Original-patch-by: Gokul krishna Krishnakumar <quic_gokukris@quicinc.com>

Convert myself to the author/SoB.

Would that be fine ?  please suggest.

> 
>> ---
>>   kernel/locking/rwsem.c | 18 ++++++++++++++----
>>   1 file changed, 14 insertions(+), 4 deletions(-)
>>
>> diff --git a/kernel/locking/rwsem.c b/kernel/locking/rwsem.c
>> index 65f0262..3b4b32e 100644
>> --- a/kernel/locking/rwsem.c
>> +++ b/kernel/locking/rwsem.c
>> @@ -251,13 +251,16 @@ static inline bool rwsem_read_trylock(struct rw_semaphore *sem, long *cntp)
>>   static inline bool rwsem_write_trylock(struct rw_semaphore *sem)
>>   {
>>   	long tmp = RWSEM_UNLOCKED_VALUE;
>> +	bool ret = false;
>>   
>> +	preempt_disable();
>>   	if (atomic_long_try_cmpxchg_acquire(&sem->count, &tmp, RWSEM_WRITER_LOCKED)) {
>>   		rwsem_set_owner(sem);
>> -		return true;
>> +		ret = true;
>>   	}
>>   
>> -	return false;
>> +	preempt_enable();
>> +	return ret;
>>   }
>>   
>>   /*
> 
> Yes, this part looks ok.
> 
>> @@ -686,16 +689,21 @@ enum owner_state {
>>   static inline bool rwsem_try_write_lock_unqueued(struct rw_semaphore *sem)
>>   {
>>   	long count = atomic_long_read(&sem->count);
>> +	bool ret = false;
>>   
>> +	preempt_disable();
>>   	while (!(count & (RWSEM_LOCK_MASK|RWSEM_FLAG_HANDOFF))) {
>>   		if (atomic_long_try_cmpxchg_acquire(&sem->count, &count,
>>   					count | RWSEM_WRITER_LOCKED)) {
>>   			rwsem_set_owner(sem);
>>   			lockevent_inc(rwsem_opt_lock);
>> -			return true;
>> +			ret = true;
>> +			break;
>>   		}
>>   	}
>> -	return false;
>> +
>> +	preempt_enable();
>> +	return ret;
>>   }
>>   
> 
> This one I can't follow; afaict this is only called with preemption
> already disabled.

Agreed. Will remove it in v2.

> 
>>   static inline bool rwsem_can_spin_on_owner(struct rw_semaphore *sem)
>> @@ -1352,8 +1360,10 @@ static inline void __up_write(struct rw_semaphore *sem)
>>   	DEBUG_RWSEMS_WARN_ON((rwsem_owner(sem) != current) &&
>>   			    !rwsem_test_oflags(sem, RWSEM_NONSPINNABLE), sem);
>>   
>> +	preempt_disable();
>>   	rwsem_clear_owner(sem);
>>   	tmp = atomic_long_fetch_add_release(-RWSEM_WRITER_LOCKED, &sem->count);
>> +	preempt_enable();
>>   	if (unlikely(tmp & RWSEM_FLAG_WAITERS))
>>   		rwsem_wake(sem);
>>   }
> 
> Yep, that looks good again.
> 
> Perhaps the thing to do would be to add:
> 
>    lockdep_assert_preemption_disabled()
> 
> to rwsem_{set,clear}_owner() and expand the comment there to explain
> that these functions should be in the same preempt-disable section as
> the atomic op that changes sem->count.

Thanks for the suggestion, will add it in v2.

-Mukesh
