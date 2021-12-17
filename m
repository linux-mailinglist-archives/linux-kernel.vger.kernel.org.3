Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 851274786A0
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Dec 2021 10:00:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233974AbhLQJA4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Dec 2021 04:00:56 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:60260 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233949AbhLQJAz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Dec 2021 04:00:55 -0500
Date:   Fri, 17 Dec 2021 10:00:52 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1639731654;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=maf8nPMRJ6DrBvqOhBhRCyRPeu03+nS+T1da3FRceLE=;
        b=1zrNjR0L9OcSCYfXKkZTnQmQ+QoG7aehgsWn9iU0cG9A6ACexN+HEmcTgCHLaMAZLedx2U
        tiJbgJwJG+IkpkaGu4CW1HBfq3lpMQADIxvJWWPh9utvcq/VPFSKhKoHH02Ybo40+dcmN/
        0JyxzoqSMF6+3/qsDYdsqle9J6qTP/64vtdCb18FqX7YmnV3CkvRpJAN2SVKaJlIA9JX7I
        rkMHu/zPo/+Te5FkkedXXufNslTzLsM2yFifLN8KpX3gkTINKy7emhpgTAdGbAK5WgUQx5
        hI85dD85cA2BxdI/v1bkqCboL483+w+CHRQ8LANqrYJLASfsqArJbulG6YF5Dw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1639731654;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=maf8nPMRJ6DrBvqOhBhRCyRPeu03+nS+T1da3FRceLE=;
        b=bd3aKYZFVR2TRdHLtrWynMih4nTLdJtuvJh1P/p3m2Xj38Hi+rBBsu5ydoAO5XpgIEYyV8
        /8S9rsH9fz7VixBQ==
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     Herbert Xu <herbert@gondor.apana.org.au>
Cc:     Jason@zx2c4.com, linux-kernel@vger.kernel.org, tytso@mit.edu,
        tglx@linutronix.de, peterz@infradead.org
Subject: Re: [PATCH 5/5] random: Defer processing of randomness on PREEMPT_RT.
Message-ID: <YbxRxPdBDMu8KIy6@linutronix.de>
References: <20211207201037.h46573oa5nfj33xq@linutronix.de>
 <20211217022338.GA19411@gondor.apana.org.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20211217022338.GA19411@gondor.apana.org.au>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2021-12-17 13:23:38 [+1100], Herbert Xu wrote:
> Sebastian Andrzej Siewior <bigeasy@linutronix.de> wrote:
> >
> > Even the IOCTL path must spin with disabled interrupts to avoid dead
> > locks. Therefore it makes no sense if attempt acquire the lock from
> > process or IRQ context. Something like
> >        while (!raw_spin_trylock_irqsave())
> >                cpu_relax()
> 
> What about the TCP socket locking model?
> 
> IOW, the user-space slow path will add itself to a backlog queue
> during contention, and the interrupt fast path will schedule work
> to process any user-space backlog on exit.

I'm sorry, I can't connect the dots here. I was trying to explain that
for the lock in question it is not possible to spin-wait without
disabling interrupts first.

> Cheers,

Sebastian
