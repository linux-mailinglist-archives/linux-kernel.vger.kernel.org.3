Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1DB655675CA
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Jul 2022 19:31:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231593AbiGERbk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Jul 2022 13:31:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54032 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230135AbiGERbj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Jul 2022 13:31:39 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 766AE26D
        for <linux-kernel@vger.kernel.org>; Tue,  5 Jul 2022 10:31:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=VXivCxTYmRa6L115UXB/XCu4/NjG1O3KDoyHQDdqfn8=; b=g/CWCb+Tl4E9AlK2XxK8zf7Oe4
        eIRvDKJzgEx2BdlhLnk/kePb4cx3DO0fqMqP7LJlEXLufPi0Mxkp7G3W5/TnYO6iNCZ6xHWhps1fS
        Arp2rDu+Hg0UQYdNKUtHiKwIEWv8/Mjsn4F3QZHES1ooaEOSpEFBnCf1p3eYVH0E66OZj/utnnLtf
        nbypXQSU3GCIA7QTW6dFHXvCUQj2D79vd9TDvDj7zfhmuoI1FZoxn5lzJgkTNG9m1BjVCoarH5/iB
        wkak+OXUmHILXKOoSJo88RXYuNfV46lr1wTBbTjz4iUHdO3ZFJm6ucJ+nA/rQWaik/a54ntsHOTYZ
        PZ17caMA==;
Received: from dhcp-077-249-017-003.chello.nl ([77.249.17.3] helo=worktop.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1o8mOK-0004l8-64; Tue, 05 Jul 2022 17:31:16 +0000
Received: by worktop.programming.kicks-ass.net (Postfix, from userid 1000)
        id A4A64980059; Tue,  5 Jul 2022 19:31:15 +0200 (CEST)
Date:   Tue, 5 Jul 2022 19:31:15 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Nicholas Piggin <npiggin@gmail.com>
Cc:     Ingo Molnar <mingo@redhat.com>, Will Deacon <will@kernel.org>,
        Waiman Long <longman@redhat.com>,
        Boqun Feng <boqun.feng@gmail.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 11/13] locking/qspinlock: Use queued_spin_trylock in
 pv_hybrid_queued_unfair_trylock
Message-ID: <YsR1YxKr0ySn/2Wr@worktop.programming.kicks-ass.net>
References: <20220704143820.3071004-1-npiggin@gmail.com>
 <20220704143820.3071004-12-npiggin@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220704143820.3071004-12-npiggin@gmail.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 05, 2022 at 12:38:18AM +1000, Nicholas Piggin wrote:
> Rather than open-code it as necessitated by the old function-renaming
> code generation that rendered queued_spin_trylock unavailable to use
> here.
> 
> Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
> ---
>  kernel/locking/qspinlock.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/kernel/locking/qspinlock.c b/kernel/locking/qspinlock.c
> index cef0ca7d94e1..9db168753124 100644
> --- a/kernel/locking/qspinlock.c
> +++ b/kernel/locking/qspinlock.c
> @@ -357,7 +357,7 @@ static inline bool pv_hybrid_queued_unfair_trylock(struct qspinlock *lock)
>  		int val = atomic_read(&lock->val);
>  
>  		if (!(val & _Q_LOCKED_PENDING_MASK) &&
> -		   (cmpxchg_acquire(&lock->locked, 0, _Q_LOCKED_VAL) == 0)) {
> +				queued_spin_trylock(lock)) {

Indenting went wild here; please use cino=(0:0 (if you're a vim user; I
seem to have misplaced the emacs equivalent).
