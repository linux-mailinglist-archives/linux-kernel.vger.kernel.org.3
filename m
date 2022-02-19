Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 82B4B4BC6CE
	for <lists+linux-kernel@lfdr.de>; Sat, 19 Feb 2022 08:47:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241674AbiBSHsA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 19 Feb 2022 02:48:00 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:52512 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229691AbiBSHr5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 19 Feb 2022 02:47:57 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F40A135706;
        Fri, 18 Feb 2022 23:47:37 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 5A72CB8009F;
        Sat, 19 Feb 2022 07:47:36 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6956DC004E1;
        Sat, 19 Feb 2022 07:47:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1645256855;
        bh=qCGduI+nbQPpild24XqAbJmYlbB6XDbmDsT34SRckpA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=XJSt8o98FqXXUcQYQw+t2D/HTPHyEQMWQQCws5AhC3nZXKXz4Fe5+H+EzDkHt+w7X
         xmZclle+WSpyO5H1u26EiVoDgRpwAse4aIxYci2SXOR+w0VUnnCw2zxYrdsS/IW+6f
         3SymdfNl9+z+r8dooIA8nNHZZ98T4YAWlXSPkWd4=
Date:   Sat, 19 Feb 2022 08:47:28 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     "Jason A. Donenfeld" <Jason@zx2c4.com>
Cc:     linux-kernel@vger.kernel.org, linux-crypto@vger.kernel.org,
        Theodore Ts'o <tytso@mit.edu>
Subject: Re: [PATCH] random: use max-period linear interrupt extractor
Message-ID: <YhCgkL7ZMzyIumFf@kroah.com>
References: <20220218121054.45304-1-Jason@zx2c4.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220218121054.45304-1-Jason@zx2c4.com>
X-Spam-Status: No, score=-7.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 18, 2022 at 01:10:54PM +0100, Jason A. Donenfeld wrote:
> The current fast_mix() function is a piece of classic mailing list
> crypto, where it just sort of sprung up without a lot of real analysis
> of what precisely it was accomplishing. As an ARX permutation of only
> two rounds, there are some easily searchable differential trails in it,
> and as a means of preventing malicious interrupts, it completely fails,
> since it xors new data into the entire state every time. It can't really
> be analyzed as a random permutation, because it clearly isn't, and it
> can't be analyzed as an interesting linear algebraic structure either,
> because it's also not that. There really is very little one can say
> about it in terms of entropy accumulation. It might diffuse bits, some
> of the time, maybe, we hope, I guess. But for the most part, it fails to
> accomplish anything concrete.
> 
> As a reminder, the simple goal of add_interrupt_randomness() is to
> simply accumulate entropy until ~64 interrupts have elapsed, and then
> dump it into the main input pool, which uses a cryptographic hash.
> 
> It would be nice to have something cryptographically strong in the
> interrupt handler itself, in case a malicious interrupt compromises a
> per-cpu fast pool within the 64 interrupts / 1 second window, and then
> inside of that same window somehow can control its return address and
> cycle counter, even if that's a bit far fetched. However, with a very
> CPU-limited budget, actually doing that remains an active research
> project (and perhaps there'll be something useful for Linux to come out
> of it). And while the abundance of caution would be nice, this isn't
> *currently* the security model, and we don't yet have a fast enough
> solution to make it our security model.  Plus there's not exactly a
> pressing need to do that. (And for the avoidance of doubt, the actual
> cluster of 64 accumulated interrupts still gets dumped into our
> cryptographically secure input pool.)
> 
> So, for now we are going to stick with the existing interrupt security
> model, which assumes that each cluster of 64 interrupt data samples is
> mostly non-malicious and not colluding with an infoleaker. With this as
> our goal, we can then endeavor to simply accumulate entropy linearly,
> discarding the least amount of it, and make sure that accumulation is
> sound, unlike the case with the current fast_mix().
> 
> It turns out that this security model is also the trade off that other
> operating systems have taken. The NT kernel, for example, uses something
> very simple to accumulate entropy in interrupts, `s = ror32(s, 5) ^ x`.
> Dodis et al. analyzed this in <https://eprint.iacr.org/2021/523>, and
> found that rotation by 7 would have been better than 5, but that
> otherwise, simple linear constructions like this can be used as an
> entropy collector for 2-monotone distributions.
> 
> However, when considering this for our four-word accumulation, versus
> NT's one-word, we run into potential problems because the words don't
> contribute to each other, and some may well be fixed, which means we'd
> need something to schedule on top. And more importantly, our
> distribution is not 2-monotone like NT's, because in addition to the
> cycle counter, we also include in those 4 words a register value, a
> return address, and an inverted jiffies. (Whether capturing anything
> beyond the cycle counter in the interrupt handler is even adding much of
> value is a question for a different time.)
> 
> So since we have 4 words, and not all of them are 2-monotone, we instead
> look for a proven linear extractor that works for more complex
> distributions. It turns out that a max-period linear feedback shift
> register fits this bill quite well, easily extending to the larger state
> size and to the fact that we're mixing in more than just the cycle
> counter. By picking a linear function with no non-trivial invariant
> subspace, unlike NT's rotate-xor, we benefit from the analysis of
> <https://eprint.iacr.org/2021/1002>.  This paper proves that those types
> of linear functions, used in the form `s = f(s) ^ x`, make very good
> entropy extractors for the type of complex distributions that we have.
> 
> This commit implements one such very fast and high diffusion max-period
> linear function in a Feistel-like fashion, which pipelines quite well.
> On an i7-11850H, this takes 34 cycles, versus the original's 65 cycles.
> (Though, as a note for posterity: if later this is replaced with some
> sort of cryptographic hash function, I'll still be keeping 65 cycles as
> my target 😋.) This Magma script, <https://א.cc/TiMyEpmr>, proves that
> this construction does indeed yield a linear function of order 2^128-1
> whose minimal polynomial is primitive, fitting exactly what we need.
> 
> I mention "high diffusion" above, because that apparently was the single
> discernible design goal of the original fast_mix(), even though that
> didn't wind up helping anything with it. Nonetheless, we take care to
> choose a function with pretty high diffusion, even higher than the
> original fast_mix(). In other words, we probably don't regress at all
> from a perspective of diffusion, even if it's not really the goal here
> anyway.
> 
> In sum, the security model of this is unchanged from before, yet its
> implementation now matches that model much more rigorously. And the
> performance is better, which perhaps matters in interrupt context. I
> would like to emphasize, again, that the purpose of this commit is to
> improve the existing design, by making it analyzable, without changing
> anything fundamental to the existing design. There may well be value
> down the road in changing up the existing design, using something
> cryptographic, or simply using a ring buffer of samples rather than
> having a fast_mix() at all , or changing which and how much data we
> collect each interrupt, or a variety of other ideas. This commit does
> not invalidate the potential for those in the future.
> 
> As a final note, the previous fast_mix() was contributed on the mailing
> list by an anonymous author, which violates the kernel project's "real
> name" policy and has ruffled the feathers of legally-minded people.
> Replacing this function should clear up those concerns.
> 
> Cc: Theodore Ts'o <tytso@mit.edu>
> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Signed-off-by: Jason A. Donenfeld <Jason@zx2c4.com>
> ---
>  drivers/char/random.c | 69 +++++++++++++++++++------------------------
>  1 file changed, 31 insertions(+), 38 deletions(-)

Very nice summary, thanks for all of that.  And the patch seems
straightforward as well, nice work:

Reviewed-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
