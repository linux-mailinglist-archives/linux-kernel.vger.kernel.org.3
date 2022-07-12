Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9B65F570E98
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Jul 2022 02:07:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229785AbiGLAHI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Jul 2022 20:07:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43060 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231339AbiGLAHC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Jul 2022 20:07:02 -0400
Received: from mail-pl1-x62b.google.com (mail-pl1-x62b.google.com [IPv6:2607:f8b0:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 449AB3A4A8
        for <linux-kernel@vger.kernel.org>; Mon, 11 Jul 2022 17:07:00 -0700 (PDT)
Received: by mail-pl1-x62b.google.com with SMTP id c15so981943pla.6
        for <linux-kernel@vger.kernel.org>; Mon, 11 Jul 2022 17:07:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:subject:to:cc:references:in-reply-to:mime-version
         :message-id:content-transfer-encoding;
        bh=l0Lh4zOsKuDrUOlIbOScuYAwC9N5+50LAQTNBFJ4aK8=;
        b=MaV3Ksmw2gWfoYnUrvnfVf75xR6xX5O8omN8fVRbz/6wkQn9PH0cnqlub/ntVgUmN9
         jEBpqIoq1Siydpq7sIU8f4eZZobcA756nsDCJu460zmzQDVP1S7ne36I1G2imCyaXkxh
         lfK1VLPi4qs3FdFIITp/xbQ+kW8qKX5bkXZHWlybz20fDftmGydLZ1GDcP3VtrrvidbJ
         ZlpKDas7XLleelN5A1Sz0rm9fLxe8QCzTXzlyBARCnTw8A1CvLJ4oEveFe3XNjYPqZlz
         ZcYguShF/Pai4POFG4B9vK6k/WiWlUMD5RvIENYHP2Uy+OQmCO5QP4o9S/lhRH8YlM7e
         P5AQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:subject:to:cc:references:in-reply-to
         :mime-version:message-id:content-transfer-encoding;
        bh=l0Lh4zOsKuDrUOlIbOScuYAwC9N5+50LAQTNBFJ4aK8=;
        b=33259ov8kJJ9zjN0ab9VwRPnbglY/97LZWjnHMP6YOuhasBSQV8X8+SSUrnpbTine/
         HDwOJjKwwiqBaGKLJAbB+qP72NA5Mu0ILDtZxM3CzVMnweZUTI/9P37vYAZqIrNQQqeI
         M25M/Q03UV3d9O6b1D00rD/c9rYRqQbSr/18t2g3O3RVzOZ0EwDct2pHtBROA7pp9q7f
         G15i//6ghqZVFwI4DUqWoyyN6TV/wZyer6ljII6Hmxasug5LTbYGFsvJET8ytTuzl/Je
         EgvC8xdGyD9uBBZmquPr/VpezOG4TU/N4h351AgINc9wYHt6tonSKrg+Dvua+dR/Mx8x
         dEhQ==
X-Gm-Message-State: AJIora/FTSGfZ30Qsp5+ZlOydEYraik8BAOuerQ/d6ZcKMBmbdRih2to
        VepuwywnqAb6wOjwJT0U7UQ=
X-Google-Smtp-Source: AGRyM1u++mEJWbaNX9r3CkIgpuF7DvdgPFkkwZ68RFUZinE1KNsoy1pB8qFH72tzDNs7R34qtjMkfA==
X-Received: by 2002:a17:90a:ba97:b0:1ef:91ab:de1e with SMTP id t23-20020a17090aba9700b001ef91abde1emr997501pjr.237.1657584419524;
        Mon, 11 Jul 2022 17:06:59 -0700 (PDT)
Received: from localhost (193-116-203-247.tpgi.com.au. [193.116.203.247])
        by smtp.gmail.com with ESMTPSA id 200-20020a6219d1000000b00528d7d27211sm5420305pfz.178.2022.07.11.17.06.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Jul 2022 17:06:58 -0700 (PDT)
Date:   Tue, 12 Jul 2022 10:06:52 +1000
From:   Nicholas Piggin <npiggin@gmail.com>
Subject: Re: [PATCH 02/13] locking/qspinlock: inline mcs_spinlock functions
 into qspinlock
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Boqun Feng <boqun.feng@gmail.com>, linux-kernel@vger.kernel.org,
        Waiman Long <longman@redhat.com>,
        Ingo Molnar <mingo@redhat.com>, Will Deacon <will@kernel.org>
References: <20220704143820.3071004-1-npiggin@gmail.com>
        <20220704143820.3071004-3-npiggin@gmail.com>
        <YsRtaOnO9vlxJvLi@worktop.programming.kicks-ass.net>
In-Reply-To: <YsRtaOnO9vlxJvLi@worktop.programming.kicks-ass.net>
MIME-Version: 1.0
Message-Id: <1657584250.pjnraozr5g.astroid@bobo.none>
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

Excerpts from Peter Zijlstra's message of July 6, 2022 2:57 am:
> On Tue, Jul 05, 2022 at 12:38:09AM +1000, Nicholas Piggin wrote:
>> qspinlock uses mcs_spinlock for the struct type (.next, .locked, and the
>> misplaced .count), and arch_mcs_spin_{un}lock_contended(). These can be
>> trivially inlined into qspinlock, and the unused mcs_spinlock code
>> removed.
>>=20
>> Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
>> ---
>=20
>>  arch/arm/include/asm/mcs_spinlock.h |  24 ------
>=20
>> --- a/arch/arm/include/asm/mcs_spinlock.h
>> +++ /dev/null
>> @@ -1,24 +0,0 @@
>> -/* SPDX-License-Identifier: GPL-2.0 */
>> -#ifndef __ASM_MCS_LOCK_H
>> -#define __ASM_MCS_LOCK_H
>> -
>> -#ifdef CONFIG_SMP
>> -#include <asm/spinlock.h>
>> -
>> -/* MCS spin-locking. */
>> -#define arch_mcs_spin_lock_contended(lock)				\
>> -do {									\
>> -	/* Ensure prior stores are observed before we enter wfe. */	\
>> -	smp_mb();							\
>> -	while (!(smp_load_acquire(lock)))				\
>> -		wfe();							\
>> -} while (0)								\
>> -
>> -#define arch_mcs_spin_unlock_contended(lock)				\
>> -do {									\
>> -	smp_store_release(lock, 1);					\
>> -	dsb_sev();							\
>> -} while (0)
>> -
>> -#endif	/* CONFIG_SMP */
>> -#endif	/* __ASM_MCS_LOCK_H */
>=20
>> @@ -475,7 +476,8 @@ void queued_spin_lock_slowpath(struct qspinlock *loc=
k, u32 val)
>>  		WRITE_ONCE(prev->next, node);
>> =20
>>  		pv_wait_node(node, prev);
>> -		arch_mcs_spin_lock_contended(&node->locked);
>> +		/* Wait for mcs node lock to be released */
>> +		smp_cond_load_acquire(&node->locked, VAL);
>> =20
>>  		/*
>>  		 * While waiting for the MCS lock, the next pointer may have
>> @@ -554,7 +556,7 @@ void queued_spin_lock_slowpath(struct qspinlock *loc=
k, u32 val)
>>  	if (!next)
>>  		next =3D smp_cond_load_relaxed(&node->next, (VAL));
>> =20
>> -	arch_mcs_spin_unlock_contended(&next->locked);
>> +	smp_store_release(&next->locked, 1); /* unlock the mcs node lock */
>=20
> These are not equivalent. Now it so happens that ARM doesn't use
> qspinlock and the other mcs lock users are gone by now, but something
> like this should at least have been called out in the Changelog I think.
>=20

Yeah I could mention it in the changelog, I just didn't because it is
practically equivalent.

Thanks,
Nick
