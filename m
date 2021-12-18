Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 63EE5479863
	for <lists+linux-kernel@lfdr.de>; Sat, 18 Dec 2021 04:24:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231866AbhLRDYQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Dec 2021 22:24:16 -0500
Received: from helcar.hmeau.com ([216.24.177.18]:58106 "EHLO fornost.hmeau.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231734AbhLRDYP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Dec 2021 22:24:15 -0500
Received: from gwarestrin.arnor.me.apana.org.au ([192.168.103.7])
        by fornost.hmeau.com with smtp (Exim 4.92 #5 (Debian))
        id 1myQKP-0002bk-PM; Sat, 18 Dec 2021 14:24:10 +1100
Received: by gwarestrin.arnor.me.apana.org.au (sSMTP sendmail emulation); Sat, 18 Dec 2021 14:24:09 +1100
Date:   Sat, 18 Dec 2021 14:24:09 +1100
From:   Herbert Xu <herbert@gondor.apana.org.au>
To:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc:     Jason@zx2c4.com, linux-kernel@vger.kernel.org, tytso@mit.edu,
        tglx@linutronix.de, peterz@infradead.org
Subject: Re: [PATCH 5/5] random: Defer processing of randomness on PREEMPT_RT.
Message-ID: <20211218032409.GA11425@gondor.apana.org.au>
References: <20211207201037.h46573oa5nfj33xq@linutronix.de>
 <20211217022338.GA19411@gondor.apana.org.au>
 <YbxRxPdBDMu8KIy6@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YbxRxPdBDMu8KIy6@linutronix.de>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 17, 2021 at 10:00:52AM +0100, Sebastian Andrzej Siewior wrote:
>
> I'm sorry, I can't connect the dots here. I was trying to explain that
> for the lock in question it is not possible to spin-wait without
> disabling interrupts first.

That's precisely the problem the socket lock was designed to
solve.

The way it works is that the interrupt path obtains a normal
spin lock, then tests if the sleepable side is holding the resource
or not.  If it is, then the interrupt-path work is added to a
linked list to be processed later.

On the sleepable side, you first obtain the spin lock, then
you check whether the resource is held (by another thread), if
it is you then add yourself to a wait queue and sleep (this is
essentially a home-made mutex).

The tricky bit is in the unlock path on the sleepable side, you
check whether any interrupt-path work has been postponed while
you were holding the resource and process them if they have been.

Take a look at lock_sock/release_sock and bh_lock_sock/bh_unlock_sock
in net/core/sock.c.

Cheers,
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
