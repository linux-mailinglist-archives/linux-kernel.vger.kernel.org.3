Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 85C1A5B25C3
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Sep 2022 20:30:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231875AbiIHSaS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Sep 2022 14:30:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48532 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231800AbiIHSaP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Sep 2022 14:30:15 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E03E052092
        for <linux-kernel@vger.kernel.org>; Thu,  8 Sep 2022 11:30:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1662661813;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ryx+d+OHn3xml5qSZXlEbynB2sUx1inAWaTsZWKc9JY=;
        b=Ha+lDWbr+oNIv9kyOyTtzQDHLu/RhWFBqn1rbboVwJSDfKeW3giMRowvZIG8hIoLIilIxp
        ++KvUZprh+QjpibmQSyQ4Z68TpI2mYW5vFsZXErOauTYESXWpE7QLiFTLepUNEZzIXkIE6
        /fdLBWn2s3BKvyB0w5y2mIdRdUfoabY=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-263-_0FGHSj7Nf-n68yWnkwy-g-1; Thu, 08 Sep 2022 14:30:10 -0400
X-MC-Unique: _0FGHSj7Nf-n68yWnkwy-g-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com [10.11.54.6])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 89ACA80A0B9;
        Thu,  8 Sep 2022 18:30:09 +0000 (UTC)
Received: from [10.22.9.66] (unknown [10.22.9.66])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 3F9962166B26;
        Thu,  8 Sep 2022 18:30:09 +0000 (UTC)
Message-ID: <b7ed663e-2b5b-80d7-4039-8995084dd572@redhat.com>
Date:   Thu, 8 Sep 2022 14:30:09 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.12.0
Subject: Re: [PATCH v2] locking/rwsem: Disable preemption while trying for
 rwsem lock
Content-Language: en-US
To:     Mukesh Ojha <quic_mojha@quicinc.com>, peterz@infradead.org,
        mingo@redhat.com, will@kernel.org, boqun.feng@gmail.com
Cc:     linux-kernel@vger.kernel.org,
        Gokul krishna Krishnakumar <quic_gokukris@quicinc.com>
References: <1662661467-24203-1-git-send-email-quic_mojha@quicinc.com>
From:   Waiman Long <longman@redhat.com>
In-Reply-To: <1662661467-24203-1-git-send-email-quic_mojha@quicinc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.78 on 10.11.54.6
X-Spam-Status: No, score=-6.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/8/22 14:24, Mukesh Ojha wrote:
> From: Gokul krishna Krishnakumar <quic_gokukris@quicinc.com>
>
> Make the region inside the rwsem_write_trylock non preemptible.
>
> We observe RT task is hogging CPU when trying to acquire rwsem lock
> which was acquired by a kworker task but before the rwsem owner was set.
>
> Here is the scenario:
> 1. CFS task (affined to a particular CPU) takes rwsem lock.
>
> 2. CFS task gets preempted by a RT task before setting owner.
>
> 3. RT task (FIFO) is trying to acquire the lock, but spinning until
> RT throttling happens for the lock as the lock was taken by CFS task.
>
> This patch attempts to fix the above issue by disabling preemption
> until owner is set for the lock. While at it also fix the issues
> at the places where rwsem_{set,clear}_owner() are called.
>
> This also adds lockdep annotation of preemption disable in
> rwsem_{set,clear}_owner() on Peter Z. suggestion.
>
> Signed-off-by: Gokul krishna Krishnakumar <quic_gokukris@quicinc.com>
> Signed-off-by: Mukesh Ojha <quic_mojha@quicinc.com>
> ---
> Changes in v2:
>   - Remove preempt disable code in rwsem_try_write_lock_unqueued()
>   - Addressed suggestion from Peter Z.
>   - Modified commit text
>   kernel/locking/rwsem.c | 14 ++++++++++++--
>   1 file changed, 12 insertions(+), 2 deletions(-)
>
> diff --git a/kernel/locking/rwsem.c b/kernel/locking/rwsem.c
> index 65f0262..4487359 100644
> --- a/kernel/locking/rwsem.c
> +++ b/kernel/locking/rwsem.c
> @@ -133,14 +133,19 @@
>    * the owner value concurrently without lock. Read from owner, however,
>    * may not need READ_ONCE() as long as the pointer value is only used
>    * for comparison and isn't being dereferenced.
> + *
> + * Both rwsem_{set,clear}_owner() functions should be in the same
> + * preempt disable section as the atomic op that changes sem->count.
>    */
>   static inline void rwsem_set_owner(struct rw_semaphore *sem)
>   {
> +	lockdep_assert_preemption_disabled();
>   	atomic_long_set(&sem->owner, (long)current);
>   }
>   
>   static inline void rwsem_clear_owner(struct rw_semaphore *sem)
>   {
> +	lockdep_assert_preemption_disabled();
>   	atomic_long_set(&sem->owner, 0);
>   }
>   
> @@ -251,13 +256,16 @@ static inline bool rwsem_read_trylock(struct rw_semaphore *sem, long *cntp)
>   static inline bool rwsem_write_trylock(struct rw_semaphore *sem)
>   {
>   	long tmp = RWSEM_UNLOCKED_VALUE;
> +	bool ret = false;
>   
> +	preempt_disable();
>   	if (atomic_long_try_cmpxchg_acquire(&sem->count, &tmp, RWSEM_WRITER_LOCKED)) {
>   		rwsem_set_owner(sem);
> -		return true;
> +		ret = true;
>   	}
>   
> -	return false;
> +	preempt_enable();
> +	return ret;
>   }
>   
>   /*
> @@ -1352,8 +1360,10 @@ static inline void __up_write(struct rw_semaphore *sem)
>   	DEBUG_RWSEMS_WARN_ON((rwsem_owner(sem) != current) &&
>   			    !rwsem_test_oflags(sem, RWSEM_NONSPINNABLE), sem);
>   
> +	preempt_disable();
>   	rwsem_clear_owner(sem);
>   	tmp = atomic_long_fetch_add_release(-RWSEM_WRITER_LOCKED, &sem->count);
> +	preempt_enable();
>   	if (unlikely(tmp & RWSEM_FLAG_WAITERS))
>   		rwsem_wake(sem);
>   }
Reviewed-by: Waiman Long <longman@redhat.com>

Cheers,
Longman

