Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 54910598757
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Aug 2022 17:25:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344271AbiHRPXR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 Aug 2022 11:23:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38406 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343630AbiHRPW7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Aug 2022 11:22:59 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CDAE2B6D6D
        for <linux-kernel@vger.kernel.org>; Thu, 18 Aug 2022 08:22:57 -0700 (PDT)
Date:   Thu, 18 Aug 2022 17:22:53 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1660836175;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=8yxb0BK/v/93Xq0pa1I9UCRiP9ec/brO7gpNu4/9X1I=;
        b=N0sOwP6Y1tb0uxw/BYDqiGHTaDkmgHYONONd4OzKlQlsepQD6QwroOxuY4eaN7Gf4yaTPm
        jV+d5tas7FuBcUWJpskBib6YDNx9ne+pA6SKpgsgz/pnZjtRjxvY4qCiEwErAA5xYiqQuC
        EGVnrneAfnVcRMSppGhJsqc3TpmdJA+EPATNQyjQupTc7LcgzE6ZGljlMI1fUGHVuBemr3
        H5v51gGZAjEwVYKv6qiGoW6cAudBobHBzJNilmVdCM04W8zDBiGKg58lMHpImldTx6wC4N
        ulUZv9LfAJ85H0Tqa5ZXOgErhXs1Vy2aicTfGC+TfXg6g4Bk+QHcDo0kPAUr8Q==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1660836175;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=8yxb0BK/v/93Xq0pa1I9UCRiP9ec/brO7gpNu4/9X1I=;
        b=dmenoKVG6VL28Mv4WKSd3gfipU49QQ0XlOgJfkhoKvR2lKtquKwtrYIEc2TVlo2m8sL8GC
        xaS/J1l+pxZr3WCg==
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     Vlastimil Babka <vbabka@suse.cz>
Cc:     Christoph Lameter <cl@gentwo.de>, linux-kernel@vger.kernel.org,
        Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Matthew Wilcox <willy@infradead.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        David Rientjes <rientjes@google.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Pekka Enberg <penberg@kernel.org>, linux-mm@kvack.org
Subject: Re: [PATCH 1/9] slub: Make PREEMPT_RT support less convoluted
Message-ID: <Yv5ZTXMmk9LupRae@linutronix.de>
References: <20220817162703.728679-1-bigeasy@linutronix.de>
 <20220817162703.728679-2-bigeasy@linutronix.de>
 <alpine.DEB.2.22.394.2208181136560.1901102@gentwo.de>
 <5679405a-b3c3-6dc5-783f-7ebeda7c9bf0@suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <5679405a-b3c3-6dc5-783f-7ebeda7c9bf0@suse.cz>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2022-08-18 16:37:06 [+0200], Vlastimil Babka wrote:
> > The slub fastpath does not interfere with slow path operations and the
> 
> That's true on !PREEMPT_RT because a slowpath operation under
> local_lock_irqsave() will disable interrupts, so there can't be a
> fastpath operation in an interrupt handler appearing in the middle of a
> slowpath operation.
> 
> On PREEMPT_RT local_lock_irqsave() doesn't actually disable interrupts,
> so that can happen. IIRC we learned that the hard way when Mike
> Galbraith was testing early versions of my PREEMPT_RT changes for SLUB.

I think the point is that local_lock_irqsave() does not disable
preemption. So the lock owner (within the local_lock_irqsave() section)
can be preempted and another task can use the fast path which does not
involve the lock and things go boom from here.

Sebastian
