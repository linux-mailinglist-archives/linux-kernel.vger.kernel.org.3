Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7F942585CBD
	for <lists+linux-kernel@lfdr.de>; Sun, 31 Jul 2022 02:24:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233079AbiGaAYC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 30 Jul 2022 20:24:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40154 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229737AbiGaAX7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 30 Jul 2022 20:23:59 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 49EE51400C;
        Sat, 30 Jul 2022 17:23:58 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id CA911B80C85;
        Sun, 31 Jul 2022 00:23:56 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 476EBC433D6;
        Sun, 31 Jul 2022 00:23:54 +0000 (UTC)
Authentication-Results: smtp.kernel.org;
        dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="VyTLLn82"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zx2c4.com; s=20210105;
        t=1659227032;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=27908CkDTCkHGm34su8KkauoS3hA0gJGr/pZJ+wqutM=;
        b=VyTLLn829hnIWtizj6XvTyYJpAwMvhg3tRSzGUX1NkczihOKfrQX5dVLRtpfFGg+ETgCTz
        87gNFzZ8snfNdyglSWE3X1I0XzsCTm//en0RigzOHU59oO0x/KOKiMkPv6RJwQ6DwH2AHz
        HHezJoIJUxJ6j3aJXvJzMYu6PP95cWs=
Received: by mail.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id 858c0c7c (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
        Sun, 31 Jul 2022 00:23:52 +0000 (UTC)
Date:   Sun, 31 Jul 2022 02:23:49 +0200
From:   "Jason A. Donenfeld" <Jason@zx2c4.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, linux-crypto@vger.kernel.org,
        x86@kernel.org, Nadia Heninger <nadiah@cs.ucsd.edu>,
        Thomas Ristenpart <ristenpart@cornell.edu>,
        Theodore Ts'o <tytso@mit.edu>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        Adhemerval Zanella Netto <adhemerval.zanella@linaro.org>,
        Florian Weimer <fweimer@redhat.com>
Subject: Re: [PATCH RFC v1] random: implement getrandom() in vDSO
Message-ID: <YuXLlUZ8EzvZB43U@zx2c4.com>
References: <20220729145525.1729066-1-Jason@zx2c4.com>
 <CAHk-=wiLwz=9h9LD1-_yb1+T+u59a2EjTmMvCiGj4A-ZsPN1wA@mail.gmail.com>
 <YuXCpyULk6jFgGV5@zx2c4.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <YuXCpyULk6jFgGV5@zx2c4.com>
X-Spam-Status: No, score=-6.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jul 31, 2022 at 01:45:43AM +0200, Jason A. Donenfeld wrote:
> So, anyway, if I do muster a v2 of this (perhaps just to see the idea
> through), the API might split in two to something like:
> 
>   void *getrandom_allocate_states([inout] size_t *number_of_states, [out] size_t *length_per_state);
>   ssize_t getrandom(void *state, void *buffer, size_t len, unsigned long flags);
> 
> User code will call getrandom_allocate_state(), which will allocate
> enough pages to hold *number_of_states, and return the size of each one
> in length_per_state and the number actually allocated back in
> number_of_states. The result can then be sliced up by that size, and
> passed to getrandom(). So glibc or whatever would presumably allocate
> one per thread, and handle any reentrancy/locking around it.
> 
> Or some other variation on that. I'm sure you hate those function
> signatures. Everybody loves to bikeshed APIs, right? There's plenty to
> be tweaked. But that's anyhow about where my thinking is for a potential
> v2.

Doing this also doubled performance, perhaps unsurprisingly, as that
getcpu() operation wasn't free.

For uint32_t generation:

   vdso: 25000000 times in 0.289876265 seconds
syscall: 25000000 times in 4.296636025 seconds
