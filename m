Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 138084783B4
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Dec 2021 04:38:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232524AbhLQDiS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Dec 2021 22:38:18 -0500
Received: from helcar.hmeau.com ([216.24.177.18]:58052 "EHLO fornost.hmeau.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230206AbhLQDiP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Dec 2021 22:38:15 -0500
Received: from gwarestrin.arnor.me.apana.org.au ([192.168.103.7])
        by fornost.hmeau.com with smtp (Exim 4.92 #5 (Debian))
        id 1my44K-0005zt-Ti; Fri, 17 Dec 2021 14:38:06 +1100
Received: by gwarestrin.arnor.me.apana.org.au (sSMTP sendmail emulation); Fri, 17 Dec 2021 14:38:04 +1100
Date:   Fri, 17 Dec 2021 14:38:04 +1100
From:   Herbert Xu <herbert@gondor.apana.org.au>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     peterz@infradead.org, will@kernel.org, boqun.feng@gmail.com,
        linux-kernel@vger.kernel.org, x86@kernel.org, mark.rutland@arm.com,
        elver@google.com, keescook@chromium.org, hch@infradead.org,
        axboe@kernel.dk
Subject: Re: [PATCH v2 8/9] atomic,x86: Alternative atomic_*_overflow() scheme
Message-ID: <20211217033804.GA19722@gondor.apana.org.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=wiDXWy8ekFDxVzCbudZv_3CqiWa9w+xO8mxJkk8SNmJCg@mail.gmail.com>
X-Newsgroups: apana.lists.os.linux.kernel
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Linus Torvalds <torvalds@linux-foundation.org> wrote:
>
> That said - it may not matter - I'm not sure a plain "dec" is even a
> valid operation on a ref in the first place. How could you ever
> validly decrement a ref without checking for it being the last entry?

There are actual spots in the network stack where we know we're
holding multiple reference counts to a given object and in those
cases an unconditional "dec" could make sense.  For example, we may
have an object that we obtained from a hash lookup, giving us a
reference count, which we then try to remove from a linked list,
also containing a referencnce count to it.  While still holding
the referencnce count from the hash lookup, the linked list
referencnce count could be dropped with a plain "dec".

Of course we might be better off redesigning things to eliminate
reference counts completely but such code does still exist.

Cheers,
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
