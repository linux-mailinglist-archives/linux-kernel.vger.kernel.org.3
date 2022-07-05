Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8FC6B567825
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Jul 2022 22:02:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231648AbiGEUCO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Jul 2022 16:02:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53670 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229565AbiGEUCM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Jul 2022 16:02:12 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 7A75C15701
        for <linux-kernel@vger.kernel.org>; Tue,  5 Jul 2022 13:02:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1657051330;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=impGN86WT//yl8g2V8kK4ZClNs+NosWwK05DaY5Q5Co=;
        b=hxxp/R7AqtWIiNxDIiMxosPtZAj0ZM0lpvfI0GxJRO8dybnh204QkHMoHkyYiOhPsBmfrn
        ZAPFxu9tKLsQZZ5PqNbdlWwjOpTnkh+u35iPgUeCPWnrBbebEB+pnDBdgfCFv0wfPtpotI
        TIA/rsfK2BVUhXjr27nI/f0QMB4lt+c=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-543-iG887xqjPKKuT5WlYI9MvA-1; Tue, 05 Jul 2022 16:02:06 -0400
X-MC-Unique: iG887xqjPKKuT5WlYI9MvA-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com [10.11.54.5])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id E1CB13815D22;
        Tue,  5 Jul 2022 20:02:05 +0000 (UTC)
Received: from [10.22.16.141] (unknown [10.22.16.141])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 8D4BE18EBF;
        Tue,  5 Jul 2022 20:02:05 +0000 (UTC)
Message-ID: <9bb0e3b3-288f-31d2-ef82-684386265b3e@redhat.com>
Date:   Tue, 5 Jul 2022 16:02:05 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCH 05/13] locking/qspinlock: be less clever with the
 preprocessor
Content-Language: en-US
To:     Nicholas Piggin <npiggin@gmail.com>,
        Peter Zijlstra <peterz@infradead.org>
Cc:     Ingo Molnar <mingo@redhat.com>, Will Deacon <will@kernel.org>,
        Boqun Feng <boqun.feng@gmail.com>, linux-kernel@vger.kernel.org
References: <20220704143820.3071004-1-npiggin@gmail.com>
 <20220704143820.3071004-6-npiggin@gmail.com>
From:   Waiman Long <longman@redhat.com>
In-Reply-To: <20220704143820.3071004-6-npiggin@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.11.54.5
X-Spam-Status: No, score=-3.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/4/22 10:38, Nicholas Piggin wrote:
> Stop qspinlock.c including itself and avoid most of the function
> renaming with the preprocessor.
>
> This is mostly done by having the common slowpath code take a 'bool
> paravirt' argument and adjusting code based on that.
>
> Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
> ---
>   kernel/locking/qspinlock.c          | 116 ++++++++++++----------------
>   kernel/locking/qspinlock_paravirt.h |  10 +--
>   2 files changed, 52 insertions(+), 74 deletions(-)
>
> diff --git a/kernel/locking/qspinlock.c b/kernel/locking/qspinlock.c
> index 8f2173e22479..b96c58ca51de 100644
> --- a/kernel/locking/qspinlock.c
> +++ b/kernel/locking/qspinlock.c
> @@ -11,8 +11,6 @@
>    *          Peter Zijlstra <peterz@infradead.org>
>    */
>   
> -#ifndef _GEN_PV_LOCK_SLOWPATH
> -
>   #include <linux/smp.h>
>   #include <linux/bug.h>
>   #include <linux/cpumask.h>
> @@ -285,35 +283,21 @@ static __always_inline void set_locked(struct qspinlock *lock)
>   	WRITE_ONCE(lock->locked, _Q_LOCKED_VAL);
>   }
>   
> -
> -/*
> - * Generate the native code for queued_spin_unlock_slowpath(); provide NOPs for
> - * all the PV callbacks.
> - */
> -
> -static __always_inline void __pv_init_node(struct qnode *node) { }
> -static __always_inline void __pv_wait_node(struct qnode *node,
> -					   struct qnode *prev) { }
> -static __always_inline void __pv_kick_node(struct qspinlock *lock,
> -					   struct qnode *node) { }
> -static __always_inline u32  __pv_wait_head_or_lock(struct qspinlock *lock,
> -						   struct qnode *node)
> -						   { return 0; }
> -
> -#define pv_enabled()		false
> -
> -#define pv_init_node		__pv_init_node
> -#define pv_wait_node		__pv_wait_node
> -#define pv_kick_node		__pv_kick_node
> -#define pv_wait_head_or_lock	__pv_wait_head_or_lock
> -
>   #ifdef CONFIG_PARAVIRT_SPINLOCKS
> -#define queued_spin_lock_slowpath	native_queued_spin_lock_slowpath
> -#endif
> -
> -#endif /* _GEN_PV_LOCK_SLOWPATH */
> +#include "qspinlock_paravirt.h"
> +#else /* CONFIG_PARAVIRT_SPINLOCKS */
> +static __always_inline void pv_init_node(struct qnode *node) { }
> +static __always_inline void pv_wait_node(struct qnode *node,
> +					 struct qnode *prev) { }
> +static __always_inline void pv_kick_node(struct qspinlock *lock,
> +					 struct qnode *node) { }
> +static __always_inline u32  pv_wait_head_or_lock(struct qspinlock *lock,
> +						 struct qnode *node)
> +						   { return 0; }
> +static __always_inline bool pv_hybrid_queued_unfair_trylock(struct qspinlock *lock) { BUILD_BUG(); }
> +#endif /* CONFIG_PARAVIRT_SPINLOCKS */
>   
> -static inline void queued_spin_lock_mcs_queue(struct qspinlock *lock)
> +static inline void queued_spin_lock_mcs_queue(struct qspinlock *lock, bool paravirt)

Using "const bool paravirt" may help the compiler generating better code 
by eliminating dead one, if it is not doing that already.

>   {
>   	struct qnode *prev, *next, *node;
>   	u32 val, old, tail;
> @@ -338,8 +322,13 @@ static inline void queued_spin_lock_mcs_queue(struct qspinlock *lock)
>   	 */
>   	if (unlikely(idx >= MAX_NODES)) {
>   		lockevent_inc(lock_no_node);
> -		while (!queued_spin_trylock(lock))
> -			cpu_relax();
> +		if (paravirt) {
> +			while (!pv_hybrid_queued_unfair_trylock(lock))
> +				cpu_relax();
> +		} else {
> +			while (!queued_spin_trylock(lock))
> +				cpu_relax();
> +		}

The code will look a bit better if you add the following helper function 
and use it instead.

static inline bool queued_spin_trylock_common(struct qspinlock *lock, 
const bool paravirt)
{
         if (paravirt)
                 return pv_hybrid_queued_unfair_trylock(lock);
         else
                 return queued_spin_trylock(lock);
}

Cheers,
Longman

