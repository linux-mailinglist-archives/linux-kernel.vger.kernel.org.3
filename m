Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DE42C5674E7
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Jul 2022 18:57:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232303AbiGEQ5c (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Jul 2022 12:57:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48912 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232279AbiGEQ5X (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Jul 2022 12:57:23 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EFFF513CC2
        for <linux-kernel@vger.kernel.org>; Tue,  5 Jul 2022 09:57:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=5vQZps2hLT06Gg0WMvWhDpqaQh57g2cL4wmVGC68VbY=; b=tu8XZMGBLD6QapP13aP7ktSdtu
        EN947+AblOhuTCa+0nNCEB72ZPsbOR8RiZeADZLjSnBW9jceWNeMSG1guJfVenI0XXibAM3pMF6IZ
        LwreP16y75aHYn2teKrP/rF3gCSp9fxQ8tP/L/iM/C1Tv2eUu3JGmDYafs2YsvXXjTS73iFv4Ttqe
        qH5u80j11IQViW572Ue7c5wGltGLgS07AVws029CbMmP65AV1TCHOPr5xslYRC6w9QhBLvLA78VY7
        TVJw3KG1DjdQC3hrSe6wHzhPDMKf6LlpJ4PiTOEl66dyAsibTElzOHtqI+oLlR+qDvTXtP4QV81pD
        Tl3pKevA==;
Received: from dhcp-077-249-017-003.chello.nl ([77.249.17.3] helo=worktop.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1o8lrP-000l5G-7F; Tue, 05 Jul 2022 16:57:15 +0000
Received: by worktop.programming.kicks-ass.net (Postfix, from userid 1000)
        id 2DE95980059; Tue,  5 Jul 2022 18:57:13 +0200 (CEST)
Date:   Tue, 5 Jul 2022 18:57:12 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Nicholas Piggin <npiggin@gmail.com>
Cc:     Ingo Molnar <mingo@redhat.com>, Will Deacon <will@kernel.org>,
        Waiman Long <longman@redhat.com>,
        Boqun Feng <boqun.feng@gmail.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 02/13] locking/qspinlock: inline mcs_spinlock functions
 into qspinlock
Message-ID: <YsRtaOnO9vlxJvLi@worktop.programming.kicks-ass.net>
References: <20220704143820.3071004-1-npiggin@gmail.com>
 <20220704143820.3071004-3-npiggin@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220704143820.3071004-3-npiggin@gmail.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 05, 2022 at 12:38:09AM +1000, Nicholas Piggin wrote:
> qspinlock uses mcs_spinlock for the struct type (.next, .locked, and the
> misplaced .count), and arch_mcs_spin_{un}lock_contended(). These can be
> trivially inlined into qspinlock, and the unused mcs_spinlock code
> removed.
> 
> Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
> ---

>  arch/arm/include/asm/mcs_spinlock.h |  24 ------

> --- a/arch/arm/include/asm/mcs_spinlock.h
> +++ /dev/null
> @@ -1,24 +0,0 @@
> -/* SPDX-License-Identifier: GPL-2.0 */
> -#ifndef __ASM_MCS_LOCK_H
> -#define __ASM_MCS_LOCK_H
> -
> -#ifdef CONFIG_SMP
> -#include <asm/spinlock.h>
> -
> -/* MCS spin-locking. */
> -#define arch_mcs_spin_lock_contended(lock)				\
> -do {									\
> -	/* Ensure prior stores are observed before we enter wfe. */	\
> -	smp_mb();							\
> -	while (!(smp_load_acquire(lock)))				\
> -		wfe();							\
> -} while (0)								\
> -
> -#define arch_mcs_spin_unlock_contended(lock)				\
> -do {									\
> -	smp_store_release(lock, 1);					\
> -	dsb_sev();							\
> -} while (0)
> -
> -#endif	/* CONFIG_SMP */
> -#endif	/* __ASM_MCS_LOCK_H */

> @@ -475,7 +476,8 @@ void queued_spin_lock_slowpath(struct qspinlock *lock, u32 val)
>  		WRITE_ONCE(prev->next, node);
>  
>  		pv_wait_node(node, prev);
> -		arch_mcs_spin_lock_contended(&node->locked);
> +		/* Wait for mcs node lock to be released */
> +		smp_cond_load_acquire(&node->locked, VAL);
>  
>  		/*
>  		 * While waiting for the MCS lock, the next pointer may have
> @@ -554,7 +556,7 @@ void queued_spin_lock_slowpath(struct qspinlock *lock, u32 val)
>  	if (!next)
>  		next = smp_cond_load_relaxed(&node->next, (VAL));
>  
> -	arch_mcs_spin_unlock_contended(&next->locked);
> +	smp_store_release(&next->locked, 1); /* unlock the mcs node lock */

These are not equivalent. Now it so happens that ARM doesn't use
qspinlock and the other mcs lock users are gone by now, but something
like this should at least have been called out in the Changelog I think.
