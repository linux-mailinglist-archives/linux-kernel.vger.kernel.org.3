Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BEC2C590655
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Aug 2022 20:47:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234657AbiHKSUC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 Aug 2022 14:20:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55100 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229524AbiHKST7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Aug 2022 14:19:59 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id C3EAC96FE0
        for <linux-kernel@vger.kernel.org>; Thu, 11 Aug 2022 11:19:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1660241997;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Uw9jjZxJStdHvO1AO7z3YPRphmpVhIhNHgK+Wa9wTPQ=;
        b=W+R7yE7kGx2nXUQrt/+DWzlfjuPBrX7hf/ttBKnhIm+cHhfkeEpVidj9bNUIxnwGCjCxpp
        cGBpqCr4gqgAceSdfwumm9Jy8bvporx6gy4k3SlSb2bK0M4lVGdkzoIScI6RRRqLsiTPmF
        Ad/yZXF6P6Uum+x0qPNU3PBpuKV4FKQ=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-500-V3eotgQOOmmFs1ant9drwQ-1; Thu, 11 Aug 2022 14:19:54 -0400
X-MC-Unique: V3eotgQOOmmFs1ant9drwQ-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com [10.11.54.5])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 50AD0811E81;
        Thu, 11 Aug 2022 18:19:54 +0000 (UTC)
Received: from [10.22.18.117] (unknown [10.22.18.117])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 094609459C;
        Thu, 11 Aug 2022 18:19:53 +0000 (UTC)
Message-ID: <c7e4289a-a995-65f2-47fc-054b7e55757d@redhat.com>
Date:   Thu, 11 Aug 2022 14:19:53 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH v2] locking: Add __lockfunc to slow path functions
Content-Language: en-US
To:     Namhyung Kim <namhyung@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>, Will Deacon <will@kernel.org>
Cc:     Boqun Feng <boqun.feng@gmail.com>,
        LKML <linux-kernel@vger.kernel.org>
References: <20220810220346.1919485-1-namhyung@kernel.org>
From:   Waiman Long <longman@redhat.com>
In-Reply-To: <20220810220346.1919485-1-namhyung@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.11.54.5
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/10/22 18:03, Namhyung Kim wrote:
> So that we can skip the functions in the perf lock contention and other
> places like /proc/PID/wchan.
>
> Signed-off-by: Namhyung Kim <namhyung@kernel.org>
> ---
> * annotate pv qspinlock functions too
>
>   arch/x86/include/asm/qspinlock_paravirt.h | 13 +++++++------
>   kernel/locking/qrwlock.c                  |  4 ++--
>   kernel/locking/qspinlock.c                |  2 +-
>   kernel/locking/qspinlock_paravirt.h       |  4 ++--
>   4 files changed, 12 insertions(+), 11 deletions(-)
>
> diff --git a/arch/x86/include/asm/qspinlock_paravirt.h b/arch/x86/include/asm/qspinlock_paravirt.h
> index 892fd8c3a6f7..60ece592b220 100644
> --- a/arch/x86/include/asm/qspinlock_paravirt.h
> +++ b/arch/x86/include/asm/qspinlock_paravirt.h
> @@ -12,7 +12,7 @@
>    */
>   #ifdef CONFIG_64BIT
>   
> -PV_CALLEE_SAVE_REGS_THUNK(__pv_queued_spin_unlock_slowpath);
> +__PV_CALLEE_SAVE_REGS_THUNK(__pv_queued_spin_unlock_slowpath, ".spinlock.text");
>   #define __pv_queued_spin_unlock	__pv_queued_spin_unlock
>   #define PV_UNLOCK		"__raw_callee_save___pv_queued_spin_unlock"
>   #define PV_UNLOCK_SLOWPATH	"__raw_callee_save___pv_queued_spin_unlock_slowpath"
> @@ -20,9 +20,10 @@ PV_CALLEE_SAVE_REGS_THUNK(__pv_queued_spin_unlock_slowpath);
>   /*
>    * Optimized assembly version of __raw_callee_save___pv_queued_spin_unlock
>    * which combines the registers saving trunk and the body of the following
> - * C code:
> + * C code.  Note that it puts the code in the .spinlock.text section which
> + * is equivalent to adding __lockfunc in the C code:
>    *
> - * void __pv_queued_spin_unlock(struct qspinlock *lock)
> + * void __lockfunc __pv_queued_spin_unlock(struct qspinlock *lock)
>    * {
>    *	u8 lockval = cmpxchg(&lock->locked, _Q_LOCKED_VAL, 0);
>    *
> @@ -36,7 +37,7 @@ PV_CALLEE_SAVE_REGS_THUNK(__pv_queued_spin_unlock_slowpath);
>    *   rsi = lockval           (second argument)
>    *   rdx = internal variable (set to 0)
>    */
> -asm    (".pushsection .text;"
> +asm    (".pushsection .spinlock.text;"
>   	".globl " PV_UNLOCK ";"
>   	".type " PV_UNLOCK ", @function;"
>   	".align 4,0x90;"
> @@ -65,8 +66,8 @@ asm    (".pushsection .text;"
>   
>   #else /* CONFIG_64BIT */
>   
> -extern void __pv_queued_spin_unlock(struct qspinlock *lock);
> -PV_CALLEE_SAVE_REGS_THUNK(__pv_queued_spin_unlock);
> +extern void __lockfunc __pv_queued_spin_unlock(struct qspinlock *lock);
> +__PV_CALLEE_SAVE_REGS_THUNK(__pv_queued_spin_unlock, ".spinlock.text");
>   
>   #endif /* CONFIG_64BIT */
>   #endif
> diff --git a/kernel/locking/qrwlock.c b/kernel/locking/qrwlock.c
> index 2e1600906c9f..d2ef312a8611 100644
> --- a/kernel/locking/qrwlock.c
> +++ b/kernel/locking/qrwlock.c
> @@ -18,7 +18,7 @@
>    * queued_read_lock_slowpath - acquire read lock of a queued rwlock
>    * @lock: Pointer to queued rwlock structure
>    */
> -void queued_read_lock_slowpath(struct qrwlock *lock)
> +void __lockfunc queued_read_lock_slowpath(struct qrwlock *lock)
>   {
>   	/*
>   	 * Readers come here when they cannot get the lock without waiting
> @@ -63,7 +63,7 @@ EXPORT_SYMBOL(queued_read_lock_slowpath);
>    * queued_write_lock_slowpath - acquire write lock of a queued rwlock
>    * @lock : Pointer to queued rwlock structure
>    */
> -void queued_write_lock_slowpath(struct qrwlock *lock)
> +void __lockfunc queued_write_lock_slowpath(struct qrwlock *lock)
>   {
>   	int cnts;
>   
> diff --git a/kernel/locking/qspinlock.c b/kernel/locking/qspinlock.c
> index 65a9a10caa6f..2b23378775fe 100644
> --- a/kernel/locking/qspinlock.c
> +++ b/kernel/locking/qspinlock.c
> @@ -313,7 +313,7 @@ static __always_inline u32  __pv_wait_head_or_lock(struct qspinlock *lock,
>    * contended             :    (*,x,y) +--> (*,0,0) ---> (*,0,1) -'  :
>    *   queue               :         ^--'                             :
>    */
> -void queued_spin_lock_slowpath(struct qspinlock *lock, u32 val)
> +void __lockfunc queued_spin_lock_slowpath(struct qspinlock *lock, u32 val)
>   {
>   	struct mcs_spinlock *prev, *next, *node;
>   	u32 old, tail;
> diff --git a/kernel/locking/qspinlock_paravirt.h b/kernel/locking/qspinlock_paravirt.h
> index e84d21aa0722..6afc249ce697 100644
> --- a/kernel/locking/qspinlock_paravirt.h
> +++ b/kernel/locking/qspinlock_paravirt.h
> @@ -489,7 +489,7 @@ pv_wait_head_or_lock(struct qspinlock *lock, struct mcs_spinlock *node)
>    * PV versions of the unlock fastpath and slowpath functions to be used
>    * instead of queued_spin_unlock().
>    */
> -__visible void
> +__visible __lockfunc void
>   __pv_queued_spin_unlock_slowpath(struct qspinlock *lock, u8 locked)
>   {
>   	struct pv_node *node;
> @@ -544,7 +544,7 @@ __pv_queued_spin_unlock_slowpath(struct qspinlock *lock, u8 locked)
>   #include <asm/qspinlock_paravirt.h>
>   
>   #ifndef __pv_queued_spin_unlock
> -__visible void __pv_queued_spin_unlock(struct qspinlock *lock)
> +__visible __lockfunc void __pv_queued_spin_unlock(struct qspinlock *lock)
>   {
>   	u8 locked;
>   
Acked-by: Waiman Long <longman@redhat.com>

