Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1769947A3B6
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Dec 2021 03:57:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237297AbhLTC5E (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 19 Dec 2021 21:57:04 -0500
Received: from helcar.hmeau.com ([216.24.177.18]:58288 "EHLO fornost.hmeau.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231167AbhLTC5D (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 19 Dec 2021 21:57:03 -0500
Received: from gwarestrin.arnor.me.apana.org.au ([192.168.103.7])
        by fornost.hmeau.com with smtp (Exim 4.92 #5 (Debian))
        id 1mz8rA-0001rt-Ak; Mon, 20 Dec 2021 13:56:57 +1100
Received: by gwarestrin.arnor.me.apana.org.au (sSMTP sendmail emulation); Mon, 20 Dec 2021 13:56:56 +1100
Date:   Mon, 20 Dec 2021 13:56:56 +1100
From:   Herbert Xu <herbert@gondor.apana.org.au>
To:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc:     Jason@zx2c4.com, linux-kernel@vger.kernel.org, tytso@mit.edu,
        tglx@linutronix.de, peterz@infradead.org
Subject: Re: [PATCH 5/5] random: Defer processing of randomness on PREEMPT_RT.
Message-ID: <20211220025656.GB20311@gondor.apana.org.au>
References: <20211207201037.h46573oa5nfj33xq@linutronix.de>
 <20211217022338.GA19411@gondor.apana.org.au>
 <YbxRxPdBDMu8KIy6@linutronix.de>
 <20211218032409.GA11425@gondor.apana.org.au>
 <Yb7/3JUcDENyYySN@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <Yb7/3JUcDENyYySN@linutronix.de>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Dec 19, 2021 at 10:48:12AM +0100, Sebastian Andrzej Siewior wrote:
>
> That one. I find the semantic difficult to understand. Some BH-user
> check sock_owned_by_user(), some don't.
> However, a semaphore should work. The atomic user would do
> down_trylock() while preemptible caller would invoke down() and sleep
> until the lock is available. Let me check if that works here…

Right, if your atomic user can simply discard the work then this
is enough.

In the network case, we can't just discard the packet so that's
why there is a backlog queue which the atomic user appends to
if the lock isn't available.

Cheers,
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
