Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2AE6E586B62
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Aug 2022 14:53:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235156AbiHAMxr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 Aug 2022 08:53:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56724 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234930AbiHAMx0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Aug 2022 08:53:26 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C0AECBC3A;
        Mon,  1 Aug 2022 05:49:24 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 47AAD611D3;
        Mon,  1 Aug 2022 12:49:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 93F1FC433D6;
        Mon,  1 Aug 2022 12:49:22 +0000 (UTC)
Authentication-Results: smtp.kernel.org;
        dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="C8ZZyIw5"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zx2c4.com; s=20210105;
        t=1659358161;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=I8SOm4QQsrw/iOq/I1WLOyZevVrgDkQwsQfuNCOYHDI=;
        b=C8ZZyIw5bIt3TkMDIIpAeJ4D1qAgBXv3WOGSdolnCRBZ3Vo3PWazMIAgbVnoVJoCDzzejW
        +huenHAa6ymCmcEOAaEk3TYAfAAI2nWnWUVU6zDPKQvgHinPxXk4qfMAFevH2/4vOSe+Og
        JNqr3cEkU3QziwnDOUBkf9ZLmS9p1Hg=
Received: by mail.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id 0f839804 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
        Mon, 1 Aug 2022 12:49:20 +0000 (UTC)
Date:   Mon, 1 Aug 2022 14:49:17 +0200
From:   "Jason A. Donenfeld" <Jason@zx2c4.com>
To:     Florian Weimer <fweimer@redhat.com>
Cc:     linux-kernel@vger.kernel.org, linux-crypto@vger.kernel.org,
        x86@kernel.org, Nadia Heninger <nadiah@cs.ucsd.edu>,
        Thomas Ristenpart <ristenpart@cornell.edu>,
        Theodore Ts'o <tytso@mit.edu>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        Adhemerval Zanella Netto <adhemerval.zanella@linaro.org>,
        Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [PATCH RFC v2] random: implement getrandom() in vDSO
Message-ID: <YufLzQkmaERnJMOs@zx2c4.com>
References: <YuXLlUZ8EzvZB43U@zx2c4.com>
 <20220731013125.2103601-1-Jason@zx2c4.com>
 <871qu0qri6.fsf@oldenburg.str.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <871qu0qri6.fsf@oldenburg.str.redhat.com>
X-Spam-Status: No, score=-6.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hey Florian,

On Mon, Aug 01, 2022 at 10:48:01AM +0200, Florian Weimer wrote:
> * Jason A. Donenfeld:
> 
> > API-wise, vDSO getrandom has a pair of functions:
> >
> >   ssize_t getrandom(void *state, void *buffer, size_t len, unsigned int flags);
> >   void *getrandom_alloc([inout] size_t *num, [out] size_t *size_per_each);
> >
> > In the first function, the return value and the latter 3 arguments are
> > the same as ordinary getrandom(), while the first argument is a pointer
> > to some state allocated with getrandom_alloc(). getrandom_alloc() takes
> > the desired number of states, and returns an array of states, the number
> > actually allocated, and the size in bytes of each one, enabling a libc
> > to use one per thread. We very intentionally do *not* leave state
> > allocation up to the caller. There are too many weird things that can go
> > wrong, and it's important that vDSO does not provide too generic of a
> > mechanism. It's not going to store its state in just any old memory
> > address. It'll do it only in ones it allocates.
> 
> I still don't see why this couldn't be per-thread state (if you handle
> fork generations somehow).

That actually *is* the intent of this v2. Specifically, you call
getrandom_alloc and you get an *array* of states, which you can then
pass off to various threads. Since we have to allocate in page sizes, we
can't do this piecemeal, so this is a mechanism for giving out chunks of
them (~28 at a time), which you'd then give to threads as they're
created, making more as needed.

> I also think it makes sense to introduce batching for the system call
> implementation first, and tie that to the vDSO acceleration.  I expect a
> large part of the benefit comes from the batching, not the system call
> avoidance.

What I understand you to mean is that *instead of* doing vDSO, we could
just batch in the kernel, and reap most of the performance benefits. If
that turns out to be true, and then we don't even need this vDSO stuff,
I'd be really happy. So I'll give this a try.

One question is where to store that batch. On the surface, per-cpu seems
appealing, like what we do for get_random_u32() and such for kernel
callers. But per-cpu means disabling preemption, which then becomes a
problem when copying into userspace, where the copies can fault. So
maybe something more sensible is, like above, just doing this per-task.
I'll give it a stab and will let you know what it looks like.

Jason
