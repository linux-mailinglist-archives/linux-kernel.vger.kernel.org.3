Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0FB8D570F13
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Jul 2022 02:48:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231216AbiGLAsv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Jul 2022 20:48:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50880 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229523AbiGLAst (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Jul 2022 20:48:49 -0400
Received: from mail-pj1-x1034.google.com (mail-pj1-x1034.google.com [IPv6:2607:f8b0:4864:20::1034])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C2C0EE088
        for <linux-kernel@vger.kernel.org>; Mon, 11 Jul 2022 17:48:48 -0700 (PDT)
Received: by mail-pj1-x1034.google.com with SMTP id s21so6223106pjq.4
        for <linux-kernel@vger.kernel.org>; Mon, 11 Jul 2022 17:48:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:subject:to:cc:references:in-reply-to:mime-version
         :message-id:content-transfer-encoding;
        bh=5AhaFouDld5Dx+OnGlrmj5hm9p924AZwnkq33O/wx6U=;
        b=jiZ17JfXp2LgJslC1JdlJTkb2ik1hffdxQXLgj5iMH/0i1mjxwyVOE63Uctab+fV8T
         FH/hP/tM7mZl6OPHMMTBR7ShW5/7aiexyw/Cr4Bk5LAoRnGmSX/X19OoseFFA4mc84Uw
         +SoBv+dFixzezhy30xDWHXcucFbOMPb+Am7zu0WcaH+J0VFAjoGpQtzctqHfKMVq5Rvm
         M04zS8nJuJwzwgs30VA5eGKZk/3EGXZ2QiBUaUYrU0ZmnqrIW5v82oDR+xTXvHtWkMfD
         yKGX93Ti5POWuMe0iAfRSEMBjhbH3EDv0nCg+R5/rRchbX0ZWg05nGNuUWdUPf+Il0be
         nUDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:subject:to:cc:references:in-reply-to
         :mime-version:message-id:content-transfer-encoding;
        bh=5AhaFouDld5Dx+OnGlrmj5hm9p924AZwnkq33O/wx6U=;
        b=yCf8NMYixr01EOfoBmoUsFADbHJTo+O/YIs8wGYzbTYyvpoU8QKFpsqEnu20vbK9Rc
         xRG9W1aNgMTj17FgPUXdURRYWwqUGVc78rVmUs4K9IqfLtXblIDNkvXb9BdWgKwGR7Fd
         Mh6uZYrvhdGkWEGhbibCrtBovWPbl91X7V6WkSgvE6upzXFoyfz4Vwu1WRoNmyaonsRp
         NDryKfiMi/Cd3Fdv0+Xd4GGpBKWBjknBIPXuWIgxUqfLRD04OYEzYpmaYwW+gDddlKfh
         kG46uDK0tF46chGSNeDIr0Q+qXAY4//FoD/6dc3P3+6NnTTgG8DOUbYGOlerS7hmBZ86
         V8nQ==
X-Gm-Message-State: AJIora+BvlxAIuglMIns0aZ0lbiOJzvXIqVtMJeY+pqudRWMM0GtYQDY
        nMGayv8cO6GFhQmpOWEvoPE=
X-Google-Smtp-Source: AGRyM1uMPMZb0GAkyoR6936cAJ0NAKKrV8A/tFCp4IrNVD2F5CJ7ePu2xgzMLF8nFVslV3NWFJoaGg==
X-Received: by 2002:a17:902:e945:b0:16a:1c41:f66 with SMTP id b5-20020a170902e94500b0016a1c410f66mr21120151pll.129.1657586928273;
        Mon, 11 Jul 2022 17:48:48 -0700 (PDT)
Received: from localhost (193-116-203-247.tpgi.com.au. [193.116.203.247])
        by smtp.gmail.com with ESMTPSA id y10-20020a170902d64a00b0016c48c52ce4sm2762140plh.204.2022.07.11.17.48.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Jul 2022 17:48:47 -0700 (PDT)
Date:   Tue, 12 Jul 2022 10:48:42 +1000
From:   Nicholas Piggin <npiggin@gmail.com>
Subject: Re: [PATCH 11/13] locking/qspinlock: Use queued_spin_trylock in
 pv_hybrid_queued_unfair_trylock
To:     Waiman Long <longman@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>
Cc:     Boqun Feng <boqun.feng@gmail.com>, linux-kernel@vger.kernel.org,
        Ingo Molnar <mingo@redhat.com>, Will Deacon <will@kernel.org>
References: <20220704143820.3071004-1-npiggin@gmail.com>
        <20220704143820.3071004-12-npiggin@gmail.com>
        <8cdfa77a-87f3-71eb-4dd7-0ac474632327@redhat.com>
In-Reply-To: <8cdfa77a-87f3-71eb-4dd7-0ac474632327@redhat.com>
MIME-Version: 1.0
Message-Id: <1657586866.8wicjauxwp.astroid@bobo.none>
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

Excerpts from Waiman Long's message of July 6, 2022 6:15 am:
> On 7/4/22 10:38, Nicholas Piggin wrote:
>> Rather than open-code it as necessitated by the old function-renaming
>> code generation that rendered queued_spin_trylock unavailable to use
>> here.
>>
>> Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
>> ---
>>   kernel/locking/qspinlock.c | 2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/kernel/locking/qspinlock.c b/kernel/locking/qspinlock.c
>> index cef0ca7d94e1..9db168753124 100644
>> --- a/kernel/locking/qspinlock.c
>> +++ b/kernel/locking/qspinlock.c
>> @@ -357,7 +357,7 @@ static inline bool pv_hybrid_queued_unfair_trylock(s=
truct qspinlock *lock)
>>   		int val =3D atomic_read(&lock->val);
>>  =20
>>   		if (!(val & _Q_LOCKED_PENDING_MASK) &&
>> -		   (cmpxchg_acquire(&lock->locked, 0, _Q_LOCKED_VAL) =3D=3D 0)) {
>> +				queued_spin_trylock(lock)) {
>>   			lockevent_inc(pv_lock_stealing);
>>   			return true;
>>   		}
>=20
> I am not sure if the compiler will eliminate the duplicated=20
> atomic_read() in queued_spin_trylock(). So unless it can generate the=20
> same code, I would prefer to leave this alone.

Ah you're right, I had that read removed in my tree but then dropped
that change before submitting. This should have been dropped as well.

Thanks,
Nick
