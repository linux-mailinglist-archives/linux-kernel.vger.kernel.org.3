Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3E688570EF3
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Jul 2022 02:34:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231356AbiGLAeH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Jul 2022 20:34:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41074 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230255AbiGLAeF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Jul 2022 20:34:05 -0400
Received: from mail-pj1-x102f.google.com (mail-pj1-x102f.google.com [IPv6:2607:f8b0:4864:20::102f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 97BC71EED4
        for <linux-kernel@vger.kernel.org>; Mon, 11 Jul 2022 17:34:04 -0700 (PDT)
Received: by mail-pj1-x102f.google.com with SMTP id t5-20020a17090a6a0500b001ef965b262eso6412178pjj.5
        for <linux-kernel@vger.kernel.org>; Mon, 11 Jul 2022 17:34:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:subject:to:cc:references:in-reply-to:mime-version
         :message-id:content-transfer-encoding;
        bh=JX2UObPabaMYYMFeU7ZxcyeR/WzSm/0h6NzAdBccZ/Y=;
        b=k6JEvHvAyYwN5FABh74gDc11TzwEf1ysjWRYKzVa1jJZqEOP1MMjktiGYboW9KQK4O
         aMSZW3Mk+2pkfTMC4bXwO3Dc9cRhMUhNjlvfZjJJtlQ9AKjnVuVzOEEVzhA6jI1lW/5z
         dAbC7evWFYG8edNZL3OOwAbfZBLu4cmIS5i4POT1hYOa696mLWaWcLyqUiFHRpERJp68
         AeXqp0fQsg7cBy24XAcHHphD+BbWj3XVBF+WzocowKOTa2Sp6/xVHN1k2QDQAHy74z8a
         pzuQJPLDVZ2g8zQYXeD3gP0CW8pKH/W8x576fTDAfL3ojZUMVTQNA2coFNnfH7laVr38
         mXBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:subject:to:cc:references:in-reply-to
         :mime-version:message-id:content-transfer-encoding;
        bh=JX2UObPabaMYYMFeU7ZxcyeR/WzSm/0h6NzAdBccZ/Y=;
        b=EfZi3KGVipJsKZ51QkleCUaicjZaz2c9OWT1hDHwSMiFzVDm7cs6bMiF08H68nidN8
         Rdkdu7rVfT4EptiVJMlw0n4B4HD57Iz6BQbt2e+xbNcS7gOx67yBTY7ii5L2XYtnTaWf
         IeexvVZ86k5z8V17jwMtz5kCFyvHMiCim615tvHTW0/HQ9fgufptLm9JzNARGL9bvoww
         BLnriLJvfYIKVmQykn15Oo3IM1axh+xdjtVvU/Z0fPh4KPtnOfUzC6pStbAfMFw6wwK9
         U1UEvsZj8Ov1wI1+O+g/W+Hu4wcUSWmPxp5ErAJxRCyyapiMVd47xZI7Q8VByGlg9UP5
         3FAA==
X-Gm-Message-State: AJIora//O3LRwNM4zTWnUKPZr0n1ONJrQnQ8TLqn/vOn9R+GdpOQz1uk
        cnrkz422gEJevopBcmr4K9Y=
X-Google-Smtp-Source: AGRyM1voH7KnvuOcZxR1Seoeb8gMUgIRbNlu/BQX1hjifgfglCgJP38Gmze2Z+0B/e/ir7OubH+p3A==
X-Received: by 2002:a17:902:d4ce:b0:16c:3d9a:e25d with SMTP id o14-20020a170902d4ce00b0016c3d9ae25dmr11540567plg.15.1657586044072;
        Mon, 11 Jul 2022 17:34:04 -0700 (PDT)
Received: from localhost (193-116-203-247.tpgi.com.au. [193.116.203.247])
        by smtp.gmail.com with ESMTPSA id m6-20020a170902768600b0016b8746132esm5317678pll.105.2022.07.11.17.34.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Jul 2022 17:34:03 -0700 (PDT)
Date:   Tue, 12 Jul 2022 10:33:57 +1000
From:   Nicholas Piggin <npiggin@gmail.com>
Subject: Re: [PATCH 05/13] locking/qspinlock: be less clever with the
 preprocessor
To:     Waiman Long <longman@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>
Cc:     Boqun Feng <boqun.feng@gmail.com>, linux-kernel@vger.kernel.org,
        Ingo Molnar <mingo@redhat.com>, Will Deacon <will@kernel.org>
References: <20220704143820.3071004-1-npiggin@gmail.com>
        <20220704143820.3071004-6-npiggin@gmail.com>
        <9bb0e3b3-288f-31d2-ef82-684386265b3e@redhat.com>
In-Reply-To: <9bb0e3b3-288f-31d2-ef82-684386265b3e@redhat.com>
MIME-Version: 1.0
Message-Id: <1657585768.2fggybh789.astroid@bobo.none>
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

Excerpts from Waiman Long's message of July 6, 2022 6:02 am:
> On 7/4/22 10:38, Nicholas Piggin wrote:
>> Stop qspinlock.c including itself and avoid most of the function
>> renaming with the preprocessor.
>>
>> This is mostly done by having the common slowpath code take a 'bool
>> paravirt' argument and adjusting code based on that.
>>
>> Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
>> ---
>>   kernel/locking/qspinlock.c          | 116 ++++++++++++----------------
>>   kernel/locking/qspinlock_paravirt.h |  10 +--
>>   2 files changed, 52 insertions(+), 74 deletions(-)
>>
>> diff --git a/kernel/locking/qspinlock.c b/kernel/locking/qspinlock.c
>> index 8f2173e22479..b96c58ca51de 100644
>> --- a/kernel/locking/qspinlock.c
>> +++ b/kernel/locking/qspinlock.c
>> @@ -11,8 +11,6 @@
>>    *          Peter Zijlstra <peterz@infradead.org>
>>    */
>>  =20
>> -#ifndef _GEN_PV_LOCK_SLOWPATH
>> -
>>   #include <linux/smp.h>
>>   #include <linux/bug.h>
>>   #include <linux/cpumask.h>
>> @@ -285,35 +283,21 @@ static __always_inline void set_locked(struct qspi=
nlock *lock)
>>   	WRITE_ONCE(lock->locked, _Q_LOCKED_VAL);
>>   }
>>  =20
>> -
>> -/*
>> - * Generate the native code for queued_spin_unlock_slowpath(); provide =
NOPs for
>> - * all the PV callbacks.
>> - */
>> -
>> -static __always_inline void __pv_init_node(struct qnode *node) { }
>> -static __always_inline void __pv_wait_node(struct qnode *node,
>> -					   struct qnode *prev) { }
>> -static __always_inline void __pv_kick_node(struct qspinlock *lock,
>> -					   struct qnode *node) { }
>> -static __always_inline u32  __pv_wait_head_or_lock(struct qspinlock *lo=
ck,
>> -						   struct qnode *node)
>> -						   { return 0; }
>> -
>> -#define pv_enabled()		false
>> -
>> -#define pv_init_node		__pv_init_node
>> -#define pv_wait_node		__pv_wait_node
>> -#define pv_kick_node		__pv_kick_node
>> -#define pv_wait_head_or_lock	__pv_wait_head_or_lock
>> -
>>   #ifdef CONFIG_PARAVIRT_SPINLOCKS
>> -#define queued_spin_lock_slowpath	native_queued_spin_lock_slowpath
>> -#endif
>> -
>> -#endif /* _GEN_PV_LOCK_SLOWPATH */
>> +#include "qspinlock_paravirt.h"
>> +#else /* CONFIG_PARAVIRT_SPINLOCKS */
>> +static __always_inline void pv_init_node(struct qnode *node) { }
>> +static __always_inline void pv_wait_node(struct qnode *node,
>> +					 struct qnode *prev) { }
>> +static __always_inline void pv_kick_node(struct qspinlock *lock,
>> +					 struct qnode *node) { }
>> +static __always_inline u32  pv_wait_head_or_lock(struct qspinlock *lock=
,
>> +						 struct qnode *node)
>> +						   { return 0; }
>> +static __always_inline bool pv_hybrid_queued_unfair_trylock(struct qspi=
nlock *lock) { BUILD_BUG(); }
>> +#endif /* CONFIG_PARAVIRT_SPINLOCKS */
>>  =20
>> -static inline void queued_spin_lock_mcs_queue(struct qspinlock *lock)
>> +static inline void queued_spin_lock_mcs_queue(struct qspinlock *lock, b=
ool paravirt)
>=20
> Using "const bool paravirt" may help the compiler generating better code=20
> by eliminating dead one, if it is not doing that already.

I think adding always_inline per Peter's suggestion should be enough.
The compiler should be able to see it's constant. Actually I'm surprised
attribute pure is helpful within a compilation unit, I would think the
compiler should be able to deduce that too.

That said, no problem with massaging things to help the compiler DTRT.

>=20
>>   {
>>   	struct qnode *prev, *next, *node;
>>   	u32 val, old, tail;
>> @@ -338,8 +322,13 @@ static inline void queued_spin_lock_mcs_queue(struc=
t qspinlock *lock)
>>   	 */
>>   	if (unlikely(idx >=3D MAX_NODES)) {
>>   		lockevent_inc(lock_no_node);
>> -		while (!queued_spin_trylock(lock))
>> -			cpu_relax();
>> +		if (paravirt) {
>> +			while (!pv_hybrid_queued_unfair_trylock(lock))
>> +				cpu_relax();
>> +		} else {
>> +			while (!queued_spin_trylock(lock))
>> +				cpu_relax();
>> +		}
>=20
> The code will look a bit better if you add the following helper function=20
> and use it instead.
>=20
> static inline bool queued_spin_trylock_common(struct qspinlock *lock,=20
> const bool paravirt)
> {
>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (paravirt)
>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 return pv_hybrid_queued_unfair_trylock(lock);
>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 else
>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 return queued_spin_trylock(lock);
> }

I did change that later on actually to always just use the basic=20
trylock. This was trying to be a more mechanical conversion that didn't=20
change too much.

Thanks,
Nick
