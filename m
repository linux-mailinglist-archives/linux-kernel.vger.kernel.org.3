Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B0F5854F73B
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Jun 2022 14:07:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1382361AbiFQMHs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Jun 2022 08:07:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34142 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1381162AbiFQMHp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Jun 2022 08:07:45 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 89FEB6434
        for <linux-kernel@vger.kernel.org>; Fri, 17 Jun 2022 05:07:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=bSqfIWi7HGy3kYTObuKrpFZjb17JpjkhpemXdtBzTWg=; b=FwpwdI0eS5Zs44N52w+3sqOscY
        ciMukIP0E1Cc7kKNuZ2YoZQLZIeGygpk/5DwNRAJE7yG6W2MAU85Bt6DuJezfMm50+hrv0W5Jadr0
        Ls+6cAn91QmvAFDilccKq9TDjSMqvAE1SbbAxWb223xZKYc0EIW3jbNCiwvkfuV7oUYdn9FqqUmLD
        gP1ckOleHJ7DjHQhe5Mf4m4OxiPe45EOODoPXFwrSss5YpTb3kyJV5Mp749Sl1HTP6i2InHW2owOg
        EV9jMBMY4CLewuVsyQjxxtkUXTutdvcH5NtetPzrjCypA69gHpUSRqDIgGH7c8RuQ673wByQ4B9lM
        a8BeBUhw==;
Received: from dhcp-077-249-017-003.chello.nl ([77.249.17.3] helo=worktop.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1o2Al5-008gBI-SV; Fri, 17 Jun 2022 12:07:30 +0000
Received: by worktop.programming.kicks-ass.net (Postfix, from userid 1000)
        id 79C0F9816B5; Fri, 17 Jun 2022 14:07:27 +0200 (CEST)
Date:   Fri, 17 Jun 2022 14:07:27 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Eric Dumazet <eric.dumazet@gmail.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Eric Dumazet <edumazet@google.com>,
        Ingo Molnar <mingo@redhat.com>,
        Waiman Long <longman@redhat.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        Will Deacon <will@kernel.org>,
        Roman Penyaev <rpenyaev@suse.de>,
        Shakeel Butt <shakeelb@google.com>
Subject: Re: [PATCH] locking/rwlocks: do not starve writers
Message-ID: <YqxufxqsnHjVfQOs@worktop.programming.kicks-ass.net>
References: <20220617091039.2257083-1-eric.dumazet@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220617091039.2257083-1-eric.dumazet@gmail.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 17, 2022 at 02:10:39AM -0700, Eric Dumazet wrote:
> --- a/kernel/locking/qrwlock.c
> +++ b/kernel/locking/qrwlock.c
> @@ -23,16 +23,6 @@ void queued_read_lock_slowpath(struct qrwlock *lock)
>  	/*
>  	 * Readers come here when they cannot get the lock without waiting
>  	 */
> -	if (unlikely(in_interrupt())) {
> -		/*
> -		 * Readers in interrupt context will get the lock immediately
> -		 * if the writer is just waiting (not holding the lock yet),
> -		 * so spin with ACQUIRE semantics until the lock is available
> -		 * without waiting in the queue.
> -		 */
> -		atomic_cond_read_acquire(&lock->cnts, !(VAL & _QW_LOCKED));
> -		return;
> -	}
>  	atomic_sub(_QR_BIAS, &lock->cnts);
>  
>  	trace_contention_begin(lock, LCB_F_SPIN | LCB_F_READ);

This is known to break tasklist_lock.
