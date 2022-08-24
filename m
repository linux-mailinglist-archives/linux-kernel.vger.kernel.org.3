Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7B2C859FB44
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Aug 2022 15:26:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238260AbiHXN0P (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 Aug 2022 09:26:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51464 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238315AbiHXNZ7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Aug 2022 09:25:59 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 819C46A4A9
        for <linux-kernel@vger.kernel.org>; Wed, 24 Aug 2022 06:25:55 -0700 (PDT)
Date:   Wed, 24 Aug 2022 15:25:51 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1661347553;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=ZfPjvzWKpgXEo+8hH6kCmmAmITetM6E4iZLw0MzmSl0=;
        b=LHoiETNrfJCJJ0OPU2TIfCShaAnPnCl2HR5cIsb4PdlDlafYFm15sVqj7IH03i+rLG5oTD
        bB2bt2AuBCAFexTKGn4yBNaq//iKDsTyGza9vwluDwjJvWo7P7lSLDhwtJCnbW9cxN0eJ0
        RPqNgnoTHclker3nNR2OfxS/nGgXwji3OUc/YP6HetUlOVBz8YbvcYW0K4ihX/6j5NG93X
        TbNdsGCp3IRTKt2OLl8DIgrTRDpNpoD4+Z7JkBMSxkiPMkGwnCNc2fUm8uFrBmGugyXGLy
        f4mBsE8K/3NRczfHsVGbX0csQ8ybI5dB/nrt+kE/o8tikXvhajurQhoBn88Lsw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1661347553;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=ZfPjvzWKpgXEo+8hH6kCmmAmITetM6E4iZLw0MzmSl0=;
        b=CblGcfGlUQaxOugnOAbiMLnlzpWS+/n+xzy4dcZClDMij3BMtlXVV7G64QhRvcwocwN/M4
        V+2AarcNvoca7dAA==
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     Vlastimil Babka <vbabka@suse.cz>
Cc:     linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Matthew Wilcox <willy@infradead.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Christoph Lameter <cl@linux.com>,
        David Rientjes <rientjes@google.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Pekka Enberg <penberg@kernel.org>, linux-mm@kvack.org
Subject: Re: [PATCH 1/9] slub: Make PREEMPT_RT support less convoluted
Message-ID: <YwYm31FKQJh/CVBn@linutronix.de>
References: <20220817162703.728679-1-bigeasy@linutronix.de>
 <20220817162703.728679-2-bigeasy@linutronix.de>
 <ffb4012b-e038-a92e-c84c-bb1d061fe29f@suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <ffb4012b-e038-a92e-c84c-bb1d061fe29f@suse.cz>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2022-08-23 19:15:43 [+0200], Vlastimil Babka wrote:
> > +#define slub_local_irq_save(flags)	local_irq_save(flags)
> > +#define slub_local_irq_restore(flags)	local_irq_restore(flags)
> 
> Note these won't be neccessary anymore after
> https://lore.kernel.org/linux-mm/20220823170400.26546-6-vbabka@suse.cz/T/#u

Okay, let me postpone that one and rebase what is left on top.

> > @@ -482,7 +488,7 @@ static inline bool __cmpxchg_double_slab(struct kmem_cache *s, struct slab *slab
> >  		void *freelist_new, unsigned long counters_new,
> >  		const char *n)
> >  {
> > -	if (!IS_ENABLED(CONFIG_PREEMPT_RT))
> > +	if (use_lockless_fast_path())
> >  		lockdep_assert_irqs_disabled();
> 
> This test would stay after the patch I referenced above. But while this
> change will keep testing the technically correct thing, the name would be
> IMHO misleading here, as this is semantically not about the lockless fast
> path, but whether we need to have irqs disabled to avoid a deadlock due to
> irq incoming when we hold the bit_spin_lock() and its handler trying to
> acquire it as well.

Color me confused. Memory is never allocated in-IRQ context on
PREEMPT_RT. Therefore I don't understand why interrupts must be disabled
for the fast path (unless that comment only applied to !RT).

It could be about preemption since spinlock, local_lock don't disable
preemption and so another allocation on the same CPU is possible. But
then you say "we hold the bit_spin_lock()" and this one disables
preemption. This means nothing can stop the bit_spin_lock() owner from
making progress and since there is no memory allocation in-IRQ, we can't
block on the same bit_spin_lock() on the same CPU.

Sebastian
