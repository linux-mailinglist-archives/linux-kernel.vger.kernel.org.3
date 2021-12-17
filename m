Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2EF4F47831C
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Dec 2021 03:23:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231268AbhLQCXq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Dec 2021 21:23:46 -0500
Received: from helcar.hmeau.com ([216.24.177.18]:58046 "EHLO fornost.hmeau.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230464AbhLQCXq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Dec 2021 21:23:46 -0500
Received: from gwarestrin.arnor.me.apana.org.au ([192.168.103.7])
        by fornost.hmeau.com with smtp (Exim 4.92 #5 (Debian))
        id 1my2uI-0005L4-6K; Fri, 17 Dec 2021 13:23:39 +1100
Received: by gwarestrin.arnor.me.apana.org.au (sSMTP sendmail emulation); Fri, 17 Dec 2021 13:23:38 +1100
Date:   Fri, 17 Dec 2021 13:23:38 +1100
From:   Herbert Xu <herbert@gondor.apana.org.au>
To:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc:     Jason@zx2c4.com, linux-kernel@vger.kernel.org, tytso@mit.edu,
        tglx@linutronix.de, peterz@infradead.org
Subject: Re: [PATCH 5/5] random: Defer processing of randomness on PREEMPT_RT.
Message-ID: <20211217022338.GA19411@gondor.apana.org.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211207201037.h46573oa5nfj33xq@linutronix.de>
X-Newsgroups: apana.lists.os.linux.kernel
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Sebastian Andrzej Siewior <bigeasy@linutronix.de> wrote:
>
> Even the IOCTL path must spin with disabled interrupts to avoid dead
> locks. Therefore it makes no sense if attempt acquire the lock from
> process or IRQ context. Something like
>        while (!raw_spin_trylock_irqsave())
>                cpu_relax()

What about the TCP socket locking model?

IOW, the user-space slow path will add itself to a backlog queue
during contention, and the interrupt fast path will schedule work
to process any user-space backlog on exit.

Cheers,
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
