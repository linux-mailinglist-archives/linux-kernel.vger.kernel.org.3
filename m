Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6FB4151B51F
	for <lists+linux-kernel@lfdr.de>; Thu,  5 May 2022 03:11:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234840AbiEEBPW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 May 2022 21:15:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60638 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230176AbiEEBPV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 May 2022 21:15:21 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0769C4EF54;
        Wed,  4 May 2022 18:11:44 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A110061D84;
        Thu,  5 May 2022 01:11:43 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 37832C385A5;
        Thu,  5 May 2022 01:11:42 +0000 (UTC)
Authentication-Results: smtp.kernel.org;
        dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="gT/rWxJQ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zx2c4.com; s=20210105;
        t=1651713099;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=4061S/kFTComde7Tg1Wgw643gLcEFT1H9RHECRHeAAY=;
        b=gT/rWxJQnX+UgZh7rEb0RHwy0zaoA4hyyJA4GWpBj5lVIKXnR6z9Dqny0BBudMfSOdPfLn
        O31Q2llHXyzHe3ZWczwcxijSSEcK8DlKTZuKyKNgbhUlgERcgIEz0qL3hnZCi3zMdSDi4P
        t3O+kQvHRT0sbhfnHRU3Qo1VCSb43uE=
Received: by mail.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id ab4be267 (TLSv1.3:AEAD-AES256-GCM-SHA384:256:NO);
        Thu, 5 May 2022 01:11:39 +0000 (UTC)
Date:   Thu, 5 May 2022 03:11:32 +0200
From:   "Jason A. Donenfeld" <Jason@zx2c4.com>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Borislav Petkov <bp@alien8.de>,
        LKML <linux-kernel@vger.kernel.org>, x86@kernel.org,
        Filipe Manana <fdmanana@suse.com>, linux-crypto@vger.kernel.org
Subject: Re: [patch 3/3] x86/fpu: Make FPU protection more robust
Message-ID: <YnMkRLcxczMxdE5z@zx2c4.com>
References: <Ym/sHqKqmLOJubgE@zn.tnic>
 <87k0b4lydr.ffs@tglx>
 <YnDwjjdiSQ5Yml6E@hirez.programming.kicks-ass.net>
 <87fslpjomx.ffs@tglx>
 <YnKh96isoB7jiFrv@zx2c4.com>
 <87czgtjlfq.ffs@tglx>
 <YnLOXZp6WgH7ULVU@zx2c4.com>
 <87wnf1huwj.ffs@tglx>
 <YnMRwPFfvB0RlBow@zx2c4.com>
 <87mtfwiyqp.ffs@tglx>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <87mtfwiyqp.ffs@tglx>
X-Spam-Status: No, score=-6.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Thomas,

On Thu, May 05, 2022 at 02:55:58AM +0200, Thomas Gleixner wrote:
> > So if truly the only user of this is random.c as of 5.18 (is it? I'm
> > assuming from a not very thorough survey...), and if the performance
> > boost doesn't even exist, then yeah, I think it'd make sense to just get
> > rid of it, and have kernel_fpu_usable() return false in those cases.
> >
> > I'll run some benchmarks on a little bit more hardware in representative
> > cases and see.
> 
> Find below a combo patch which makes use of strict softirq serialization
> for the price of not supporting the hardirq FPU usage. 

Thanks, I'll give it a shot in the morning (3am) when trying to do a
more realistic benchmark. But just as a synthetic thing, I ran the
numbers in kBench900 and am getting:

     generic:    430 cycles per call
       ssse3:    315 cycles per call
      avx512:    277 cycles per call

for a single call to the compression function, which is the most any of
those mix_pool_bytes() calls do from add_{input,disk}_randomness(), on
Tiger Lake, using RDPMC from kernel space.

This _doesn't_ take into account the price of calling kernel_fpu_begin().
That's a little hard to bench synthetically by running it in a loop and
taking medians because of the lazy restoration. But that's an indication
anyway that I should be looking at the cost of the actual function as
its running in random.c, rather than the synthetic test. Will keep this
thread updated.

Jason
