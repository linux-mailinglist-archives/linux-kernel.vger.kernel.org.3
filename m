Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 16657525FC8
	for <lists+linux-kernel@lfdr.de>; Fri, 13 May 2022 12:39:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379328AbiEMKSD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 May 2022 06:18:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37156 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346376AbiEMKSC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 May 2022 06:18:02 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 67D1520F47;
        Fri, 13 May 2022 03:18:01 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 2B562B82B97;
        Fri, 13 May 2022 10:18:00 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 73559C34100;
        Fri, 13 May 2022 10:17:58 +0000 (UTC)
Authentication-Results: smtp.kernel.org;
        dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="Z6r8D4Ml"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zx2c4.com; s=20210105;
        t=1652437077;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=VovRtYSRUSXbGlmxvrCITWEXGUgOyw5jefLauvHrUQk=;
        b=Z6r8D4MlmeADkeaZA9HvoYqtYuIydFihD0iXPqMxFpofa3kw++3++8SXB9jyjDMptBeZIR
        Cpjvai7SJRSl0HQF/wFXgYLnDnAY9zzgvXZIkRTKxzZ4/4XjlQSEpIrJtopudGVn05WHW2
        leLY9BAtNn0kk3Lu3nCK4mrhqzy2PU0=
Received: by mail.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id 1fb61103 (TLSv1.3:AEAD-AES256-GCM-SHA384:256:NO);
        Fri, 13 May 2022 10:17:56 +0000 (UTC)
Date:   Fri, 13 May 2022 12:17:55 +0200
From:   "Jason A. Donenfeld" <Jason@zx2c4.com>
To:     Dominik Brodowski <linux@dominikbrodowski.net>
Cc:     linux-kernel@vger.kernel.org, linux-crypto@vger.kernel.org
Subject: Re: [PATCH v3] random: use first 128 bits of input as fast init
Message-ID: <Yn4wUxYYYm8adCrN@zx2c4.com>
References: <20220503131204.571547-1-Jason@zx2c4.com>
 <20220504111644.284927-1-Jason@zx2c4.com>
 <Yn35LG3pz9BNsSS3@owl.dominikbrodowski.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <Yn35LG3pz9BNsSS3@owl.dominikbrodowski.net>
X-Spam-Status: No, score=-6.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Dominik,

On Fri, May 13, 2022 at 08:22:36AM +0200, Dominik Brodowski wrote:
> Am Wed, May 04, 2022 at 01:16:44PM +0200 schrieb Jason A. Donenfeld:
> > Before, the first 64 bytes of input, regardless of how entropic it was,
> > would be used to mutate the crng base key directly, and none of those
> > bytes would be credited as having entropy. Then 256 bits of credited
> > input would be accumulated, and only then would the rng transition from
> > the earlier "fast init" phase into being actually initialized.
> > 
> > The thinking was that by mixing and matching fast init and real init, an
> > attacker who compromised the fast init state, considered easy to do
> > given how little entropy might be in those first 64 bytes, would then be
> > able to bruteforce bits from the actual initialization. By keeping these
> > separate, bruteforcing became impossible.
> > 
> > However, by not crediting potentially creditable bits from those first 64
> > bytes of input, we delay initialization, and actually make the problem
> > worse, because it means the user is drawing worse random numbers for a
> > longer period of time.
> > 
> > Instead, we can take the first 128 bits as fast init, and allow them to
> > be credited, and then hold off on the next 128 bits until they've
> > accumulated. This is still a wide enough margin to prevent bruteforcing
> > the rng state, while still initializing much faster.
> > 
> > Then, rather than trying to piecemeal inject into the base crng key at
> > various points, instead just extract from the pool when we need it, for
> > the crng_init==0 phase. Performance may even be better for the various
> > inputs here, since there are likely more calls to mix_pool_bytes() then
> > there are to get_random_bytes() during this phase of system execution.
> 
> Have you evaluated this closer, also for systems where it takes ages to
> reach crng_init = 1? And might it make sense to only call extract_entropy()
> if there has been new input between two calls to get_random_bytes()?

Yes. On those systems, the extra calls to extract_entropy() are actually
helping the otherwise abysmal state, because they're adding in some new
cycle counter values on every call. Performance-wise, it's not really
that bad. Actually, by *far* the most expensive thing that
extract_entropy() does is RDSEED/RDRAND, but systems that have those
instructions don't stay in crng_init==CRNG_EARLY for very long anyway.
So all and all, it works out quite nicely.

Jason
