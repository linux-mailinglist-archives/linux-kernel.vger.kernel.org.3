Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6EE075856C1
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Jul 2022 00:06:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238928AbiG2WGk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Jul 2022 18:06:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43626 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231449AbiG2WGi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Jul 2022 18:06:38 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3493761D84;
        Fri, 29 Jul 2022 15:06:37 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id D1450B829BD;
        Fri, 29 Jul 2022 22:06:35 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 65646C433D6;
        Fri, 29 Jul 2022 22:06:33 +0000 (UTC)
Authentication-Results: smtp.kernel.org;
        dkim=fail reason="signature verification failed" (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="Dm3EdRpJ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zx2c4.com; s=20210105;
        t=1659132391;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=aK+gfCA4YdshP55tSpv431gnfgm7OADGPtVgLaLQpbo=;
        b=Dm3EdRpJ2eK0VBWtv4UY/wRg7VhnfADEGldFSyYWXSbdqsyy1fXhdniCsaWF65BfIiZdcK
        O9suhulJfzEMOeSyi5hwdnh7RmutX4o9AJwW+grGLdD38v8jW5Axji9TwyFW4DBrhOTwII
        30P2zo89XD2NehbGFNpyDAWCBVGF34I=
Received: by mail.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id 9ce959eb (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
        Fri, 29 Jul 2022 22:06:31 +0000 (UTC)
Date:   Sat, 30 Jul 2022 00:06:26 +0200
From:   "Jason A. Donenfeld" <Jason@zx2c4.com>
To:     Florian Weimer <fweimer@redhat.com>
Cc:     linux-kernel@vger.kernel.org, linux-crypto@vger.kernel.org,
        x86@kernel.org, Nadia Heninger <nadiah@cs.ucsd.edu>,
        Thomas Ristenpart <ristenpart@cornell.edu>,
        Theodore Ts'o <tytso@mit.edu>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        Adhemerval Zanella Netto <adhemerval.zanella@linaro.org>
Subject: Re: [PATCH RFC v1] random: implement getrandom() in vDSO
Message-ID: <YuRZ4tC+GY+hymFd@zx2c4.com>
References: <20220729145525.1729066-1-Jason@zx2c4.com>
 <87a68r4qpy.fsf@oldenburg.str.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <87a68r4qpy.fsf@oldenburg.str.redhat.com>
X-Spam-Status: No, score=-6.5 required=5.0 tests=BAYES_00,DKIM_INVALID,
        DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hey Florian,

Thanks for the feedback.

On Fri, Jul 29, 2022 at 10:19:05PM +0200, Florian Weimer wrote:
> > +	if (getcpu(&start, NULL, NULL) == 0)
> > +		start %= NUM_BUCKETS;
> 
> getcpu is not available everywhere.  Userspace/libc should probably
> provide a CPU number hint as an additional argument during the vDSO
> call.  We can load that easily enough from rseq.  That's going to be
> faster on x86, too (the LSL instruction is quite slow).  The only
> advantage of using getcpu like this is that it's compatible with a libc
> that isn't rseq-enabled.

Actually, the only requirement is that it's somewhat stable and somehow
separates threads most of the time. So a per-thread ID or even a
per-thread address would work fine too. Adhemerval suggested on IRC this
afternoon that there's a thread pointer register value that would be
usable for this purpose. I think what I'll do for v2 is abstract this
out to a __arch_get_bucket_hint() function, or similar, which the
different archs can fill in.

> > +	for (i = start;;) {
> > +		struct getrandom_state *state = &buckets[i];
> > +
> > +		if (cmpxchg(&state->in_use, false, true) == false)
> > +			return state;
> > +
> > +		i = i == NUM_BUCKETS - 1 ? 0 : i + 1;
> > +		if (i == start)
> > +			break;
> > +	}
> 
> Surely this scales very badly once the number of buckets is smaller than
> the system processor count?

Right, and there are a few ways that observation can go:

1) It doesn't matter, because who has > 28 threads all churning at once
   here? Is that something real?

2) The state variable is controllable by userspace, so in theory
   different ones could be passed. I don't like this idea though - hard
   to manage and not enough information to do it well.

3) Since we know when this kind of contention is hit, it should be
   possible to just expand the map size. Seems a bit complicated.

4) Simply allocate a number of pages relative to the number of CPUs, so
   that this isn't actually a problem. This seems like the simplest
   approach and seems fine.

Jason 
