Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E3506570F24
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Jul 2022 02:56:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232033AbiGLA4v (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Jul 2022 20:56:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55776 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229616AbiGLA4s (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Jul 2022 20:56:48 -0400
Received: from mail-pj1-x1035.google.com (mail-pj1-x1035.google.com [IPv6:2607:f8b0:4864:20::1035])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8AF7D2A72C
        for <linux-kernel@vger.kernel.org>; Mon, 11 Jul 2022 17:56:47 -0700 (PDT)
Received: by mail-pj1-x1035.google.com with SMTP id b8so4844489pjo.5
        for <linux-kernel@vger.kernel.org>; Mon, 11 Jul 2022 17:56:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:subject:to:cc:references:in-reply-to:mime-version
         :message-id:content-transfer-encoding;
        bh=kCOaQJiX/ub5vIUCXViUmqmONl/eauYA/7dZ8qeb3oU=;
        b=RZUFdRPiKD6UuuDpCJ77uRhOQX7myXXVL39YwByUPt+HoY0O8UNxykm9I0KeC+DFje
         Bjv/EsYmQhlS38mk+jHrzYHkYK8NQS8lnAqVcWH12EbaA+O9bYKaXDym/godxTGBnfAP
         bgzsA9z5gI918GgarMxe+LSIEQqIeDjrUrrA/qBQvdteTn/LU8P35YKQvw+afamlRjHG
         ZNKGb/lqmIvs3ustRg4KfDXMEbST6SgUvuygJZ9oP+3f7uwlP0LsaNtOuYfeE7GeGNCK
         a5YTTUArdaBeuj0pseNKj9Bk+jfJ+VeV4OXZX98DtIkDlItf+YqjLTAfL7XI7khXKSFl
         BEDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:subject:to:cc:references:in-reply-to
         :mime-version:message-id:content-transfer-encoding;
        bh=kCOaQJiX/ub5vIUCXViUmqmONl/eauYA/7dZ8qeb3oU=;
        b=geBwRzg2ittDrazvXkbqeBPek/q6d7jIi6yDR+AiNKRsYneZ9cj14vvVVjGN9VZ2DE
         0reQHY9CSNqctDD0ZgholRWSNo1EKdAkw5qawmRaesU/0VMJ/LtKIuzCMtXETCt4t199
         QIVdO+pnlV+2gXJaq+LKyJe6dykRY601J7WPUuqWs1U2AMjH62uZiKI2pazfm+y3q+un
         nx01F2750waywpjwP72TpDt8GOj39knXkPOADHWoKpql6vZ71G5zvJ+MmvcwsnBbirQl
         KvL4P73aVQMWUm2oiP7zlxrmgyWi7meKIh/V274Tw52Uzdb9B/oH0nlbc6XdwdKPNdk9
         jCQQ==
X-Gm-Message-State: AJIora9tiL3L/I+WHbR4GSdEdVbzcWsjN0SudFgewVvwBTLwRISu5GLY
        QbWzhx1xJlu065ePWtS9BmtGlf1jryU=
X-Google-Smtp-Source: AGRyM1scsLDcJ8lkYgqAw5lc/sZ/PJRCQZAJAZIQzI4lbXdlNLovRExr3LbaYi8NMgQQ9dpQ1Qva2g==
X-Received: by 2002:a17:903:41c2:b0:16c:52f8:9240 with SMTP id u2-20020a17090341c200b0016c52f89240mr4185882ple.161.1657587407068;
        Mon, 11 Jul 2022 17:56:47 -0700 (PDT)
Received: from localhost (193-116-203-247.tpgi.com.au. [193.116.203.247])
        by smtp.gmail.com with ESMTPSA id q1-20020a170902a3c100b001690a7df347sm5323331plb.96.2022.07.11.17.56.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Jul 2022 17:56:46 -0700 (PDT)
Date:   Tue, 12 Jul 2022 10:56:41 +1000
From:   Nicholas Piggin <npiggin@gmail.com>
Subject: Re: [PATCH 00/13] locking/qspinlock: simplify code generation
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Boqun Feng <boqun.feng@gmail.com>, linux-kernel@vger.kernel.org,
        Waiman Long <longman@redhat.com>,
        Ingo Molnar <mingo@redhat.com>, Will Deacon <will@kernel.org>
References: <20220704143820.3071004-1-npiggin@gmail.com>
        <YsR8BIyrSCQ8AlEo@worktop.programming.kicks-ass.net>
In-Reply-To: <YsR8BIyrSCQ8AlEo@worktop.programming.kicks-ass.net>
MIME-Version: 1.0
Message-Id: <1657587057.joeh91dvd9.astroid@bobo.none>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Excerpts from Peter Zijlstra's message of July 6, 2022 3:59 am:
> On Tue, Jul 05, 2022 at 12:38:07AM +1000, Nicholas Piggin wrote:
>> Hi,
>>=20
>> Been recently looking a bit closer at queued spinlock code, and
>> found it's a little tricky to follow especially the pv generation.
>> This series tries to improve the situation. It's not well tested
>> outside powerpc, but it's really the x86 pv code that is the
>> other major complexity that should need some review and testing.
>> Opinions?
>=20
> perhaps something like so on top/instead? This would still allow
> slotting in other implementations with relative ease and the compilers
> should constant fold all this.

Yeah that could be a bit neater... I don't know. It all has to be
inlined and compiled together so it's a matter of taste in syntactic
sugar. Doing it with C is probably better than doing it with CPP,
all else being equal.

At the moment I'm not planning to replace the PV functions on powerpc
though. If/when it comes to that I'd say more changes would be needed.

Thanks,
Nick

>=20
> --- a/kernel/locking/qspinlock.c
> +++ b/kernel/locking/qspinlock.c
> @@ -609,7 +609,7 @@ static void pv_kick_node(struct qspinloc
>   *
>   * The current value of the lock will be returned for additional process=
ing.
>   */
> -static void pv_wait_head_or_lock(struct qspinlock *lock, struct qnode *n=
ode)
> +static u32 pv_wait_head_or_lock(struct qspinlock *lock, struct qnode *no=
de)
>  {
>  	struct qspinlock **lp =3D NULL;
>  	int waitcnt =3D 0;
> @@ -641,7 +641,7 @@ static void pv_wait_head_or_lock(struct
>  		set_pending(lock);
>  		for (loop =3D SPIN_THRESHOLD; loop; loop--) {
>  			if (trylock_clear_pending(lock))
> -				return; /* got lock */
> +				goto out; /* got lock */
>  			cpu_relax();
>  		}
>  		clear_pending(lock);
> @@ -669,7 +669,7 @@ static void pv_wait_head_or_lock(struct
>  				 */
>  				WRITE_ONCE(lock->locked, _Q_LOCKED_VAL);
>  				WRITE_ONCE(*lp, NULL);
> -				return; /* got lock */
> +				goto out; /* got lock */
>  			}
>  		}
>  		WRITE_ONCE(node->state, vcpu_hashed);
> @@ -683,12 +683,22 @@ static void pv_wait_head_or_lock(struct
>  		 */
>  	}
> =20
> +out:
>  	/*
>  	 * The cmpxchg() or xchg() call before coming here provides the
>  	 * acquire semantics for locking.
>  	 */
> +	return atomic_read(&lock->val);
>  }
> =20
> +static const struct queue_ops pv_ops =3D {
> +	.init_node		=3D pv_init_node,
> +	.trylock		=3D pv_hybrid_queued_unfair_trylock,
> +	.wait_node		=3D pv_wait_node,
> +	.wait_head_or_lock	=3D pv_wait_head_or_lock,
> +	.kick_node		=3D pv_kick_node,
> +};
> +
>  /*
>   * PV versions of the unlock fastpath and slowpath functions to be used
>   * instead of queued_spin_unlock().
> @@ -756,18 +766,18 @@ __visible void __pv_queued_spin_unlock(s
>  EXPORT_SYMBOL(__pv_queued_spin_unlock);
>  #endif
> =20
> -#else /* CONFIG_PARAVIRT_SPINLOCKS */
> -static __always_inline void pv_init_node(struct qnode *node) { }
> -static __always_inline void pv_wait_node(struct qnode *node,
> -					 struct qnode *prev) { }
> -static __always_inline void pv_kick_node(struct qspinlock *lock,
> -					 struct qnode *node) { }
> -static __always_inline void pv_wait_head_or_lock(struct qspinlock *lock,
> -						 struct qnode *node) { }
> -static __always_inline bool pv_hybrid_queued_unfair_trylock(struct qspin=
lock *lock) { BUILD_BUG(); }
>  #endif /* CONFIG_PARAVIRT_SPINLOCKS */
> =20
> -static inline void queued_spin_lock_mcs_queue(struct qspinlock *lock, bo=
ol paravirt)
> +struct queue_ops {
> +	void (*init_node)(struct qnode *node);
> +	bool (*trylock)(struct qspinlock *lock);
> +	void (*wait_node)(struct qnode *node, struct qnode *prev);
> +	u32 (*wait_head_or_lock)(struct qspinlock *lock, struct qnode *node);
> +	void (*kick_node)(struct qspinlock *lock, struct qnode *node);
> +};
> +
> +static __always_inline
> +void queued_spin_lock_mcs_queue(struct qspinlock *lock, const struct que=
ue_ops *ops)
>  {
>  	struct qnode *prev, *next, *node;
>  	u32 val, old, tail;
> @@ -813,16 +823,16 @@ static inline void queued_spin_lock_mcs_
> =20
>  	node->locked =3D 0;
>  	node->next =3D NULL;
> -	if (paravirt)
> -		pv_init_node(node);
> +	if (ops && ops->init_node)
> +		ops->init_node(node);
> =20
>  	/*
>  	 * We touched a (possibly) cold cacheline in the per-cpu queue node;
>  	 * attempt the trylock once more in the hope someone let go while we
>  	 * weren't watching.
>  	 */
> -	if (paravirt) {
> -		if (pv_hybrid_queued_unfair_trylock(lock))
> +	if (ops && ops->trylock) {
> +		if (ops->trylock(lock))
>  			goto release;
>  	} else {
>  		if (queued_spin_trylock(lock))
> @@ -857,8 +867,8 @@ static inline void queued_spin_lock_mcs_
>  		WRITE_ONCE(prev->next, node);
> =20
>  		/* Wait for mcs node lock to be released */
> -		if (paravirt)
> -			pv_wait_node(node, prev);
> +		if (ops && ops->wait_node)
> +			ops->wait_node(node, prev);
>  		else
>  			smp_cond_load_acquire(&node->locked, VAL);
> =20
> @@ -893,12 +903,11 @@ static inline void queued_spin_lock_mcs_
>  	 * If PV isn't active, 0 will be returned instead.
>  	 *
>  	 */
> -	if (paravirt) {
> -		pv_wait_head_or_lock(lock, node);
> -		val =3D atomic_read(&lock->val);
> +	if (ops && ops->wait_head_or_lock) {
> +		val =3D ops->wait_head_or_lock(lock, node);
>  	} else {
>  		val =3D atomic_cond_read_acquire(&lock->val,
> -				!(VAL & _Q_LOCKED_PENDING_MASK));
> +					       !(VAL & _Q_LOCKED_PENDING_MASK));
>  	}
> =20
>  	/*
> @@ -1049,14 +1058,14 @@ void queued_spin_lock_slowpath(struct qs
>  	 */
>  queue:
>  	lockevent_inc(lock_slowpath);
> -	queued_spin_lock_mcs_queue(lock, false);
> +	queued_spin_lock_mcs_queue(lock, NULL);
>  }
>  EXPORT_SYMBOL(queued_spin_lock_slowpath);
> =20
>  #ifdef CONFIG_PARAVIRT_SPINLOCKS
>  void __pv_queued_spin_lock_slowpath(struct qspinlock *lock, u32 val)
>  {
> -	queued_spin_lock_mcs_queue(lock, true);
> +	queued_spin_lock_mcs_queue(lock, &pv_ops);
>  }
>  EXPORT_SYMBOL(__pv_queued_spin_lock_slowpath);
> =20
>=20
