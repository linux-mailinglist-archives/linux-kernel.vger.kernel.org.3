Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 57F41524BFB
	for <lists+linux-kernel@lfdr.de>; Thu, 12 May 2022 13:47:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353401AbiELLrS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 May 2022 07:47:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51028 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343585AbiELLrP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 May 2022 07:47:15 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7357845AFC;
        Thu, 12 May 2022 04:47:14 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 0ECAF61ED5;
        Thu, 12 May 2022 11:47:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C7F03C385B8;
        Thu, 12 May 2022 11:47:11 +0000 (UTC)
Authentication-Results: smtp.kernel.org;
        dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="HtE+E+oA"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zx2c4.com; s=20210105;
        t=1652356030;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=zxruO9PsiII+NJhVO9d2fEBKWrj37iPSHh5ESp8TptA=;
        b=HtE+E+oA4NfDBLMTfnGGX/Vptjg7XiNdQs3PNUb9laRz+b69m8tCWmLpnue9MlHDT0CYLP
        639NYXjR30DiQmDeleoBUVGj5bGBXB5HXhrSovVX1JCIOlavcFLbHDFJgpXqB0flK/8BcS
        GXB4+IZabqM5Ji1IKS1Gxf/vkaBqD/Y=
Received: by mail.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id 98922b50 (TLSv1.3:AEAD-AES256-GCM-SHA384:256:NO);
        Thu, 12 May 2022 11:47:09 +0000 (UTC)
Date:   Thu, 12 May 2022 13:47:06 +0200
From:   "Jason A. Donenfeld" <Jason@zx2c4.com>
To:     Thomas Ristenpart <ristenpart@cornell.edu>
Cc:     Yevgeniy Dodis <dodis@cs.nyu.edu>, tytso <tytso@mit.edu>,
        Nadia Heninger <nadiah@cs.ucsd.edu>,
        Noah Stephens-Dawidowitz <noahsd@gmail.com>,
        Stefano Tessaro <tessaro@cs.washington.edu>,
        "torvalds@linux-foundation.org" <torvalds@linux-foundation.org>,
        "D. J. Bernstein" <djb@cr.yp.to>,
        "jeanphilippe.aumasson@gmail.com" <jeanphilippe.aumasson@gmail.com>,
        "jann@thejh.net" <jann@thejh.net>,
        "keescook@chromium.org" <keescook@chromium.org>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        Peter Schwabe <peter@cryptojedi.org>,
        "linux-crypto@vger.kernel.org" <linux-crypto@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: is "premature next" a real world rng concern, or just an
 academic exercise?
Message-ID: <YnzzuuLPssc3/tVe@zx2c4.com>
References: <YmlMGx6+uigkGiZ0@zx2c4.com>
 <Ym3ZM1P+uYYABtRm@mit.edu>
 <Ym5sICj5iBMn2w/E@zx2c4.com>
 <CAMvzKsiA52Si=PzOJXYwGSA1WUz-1S0A8cpgRJWDzpMkfFbX+Q@mail.gmail.com>
 <CAMvzKsiMY_+8HZqeFqD3tR65a3-JB0LG=+0jBBy1zF4GanrsGA@mail.gmail.com>
 <7EB51D84-90A4-4C97-9A81-14A8C32990F7@cornell.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <7EB51D84-90A4-4C97-9A81-14A8C32990F7@cornell.edu>
X-Spam-Status: No, score=-6.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Tom,

On Wed, May 11, 2022 at 08:26:08PM +0000, Thomas Ristenpart wrote:
> To me the high-level design features that seems to check all the
> boxes, including importantly simplicity:
> 
> 1) A single pool where opportunistic entropy measurements (interrupt
> timings, etc.) are folded in and that is used to generate outputs.
>
> 2) An explicit “generate entropy” routine that attempts to quickly
> generate  a large amount of entropy. Use this to (re)initialize the
> state upon system events like boot and VM resumption. The CPU jitter
> dance type mechanisms are a good bet, though someone should probably
> check that these work on low-end systems. 
> 
> Also I would advocate always folding in other sources of entropy
> (e.g., RDRAND) when available, performance allowing, in both 1 and 2.
> Given the above discussion, I don’t think it’s very important, but an
> extension of the above to provide some limitation of premature next
> concerns would be:

RDRAND is currently mixed in during system boot and during reseeding
(which now happens after sleep resumption too, as of [1]).
Specifically, reseeding takes this HKDF-like form:

  τ = blake2s(key=last_key, input₁ ‖ input₂ ‖ … ‖ inputₙ)
  κ₁ = blake2s(key=τ, RDSEED ‖ 0x0)
  κ₂ = blake2s(key=τ, RDSEED ‖ 0x1)
  last_key = κ₁
  crng_seed = κ₂

where RDSEED here represents 256 bits of RDSEED, RDRAND, or RDTSC,
depending on what's available on the platform, operating as a sort of
salt parameter. When RDSEED or RDRAND is available, this matches your
suggestion. When only RDTSC is available, it's maybe jittery, but not
very much because it's just called in a tight loop, which brings us to
your next suggestion:

> 3) Periodically call 2. For example, when a CPU is otherwise idle.
> This would have same effect as Fortuna-style approaches without adding
> new buffers, etc. 

For systems without RDSEED or RDRAND, doing jitter entropy periodically
would at least be /something/ significant in the service of "solving"
the premature next "problem" (in addition to the more significant VM
problem in the absence of vmgenid). Your suggestion of an explicit
"generate entropy" function that can be called periodically is a similar
to Linus' point when he introduced jitter entropy, titling the commit,
"try to actively add entropy rather than passively wait for it" [2].

It's a good point. If we have a way of generating entropy directly instead of
passively waiting for it, something complicated like Fortuna isn't even
necessary. (As a silly side note: since Fortuna only claims to
/eventually/ recover from a compromise but can't tell you when, such
jitter could be done once a week and still, on paper, accomplish the
same theoretical goal...)

Jitter might not be available on all architectures that Linux supports,
though it likely is available for most deployed systems out there. And
for 5.19, I've fixed some cycle counter fallback things so that it
should hopefully be available a few more places it wasn't before.
Similarly, RDSEED/RDRAND isn't available everywhere, but it is available
most places these days.

But on the other hand, it appears that none of us really thinks that
premature next is a real problem worth complicating designs over. So
maybe we can just say that it is nice when the silicon in one way or
another helps with premature next, but maybe not an explicit must have.
So where does that leave us?

- Systems with RDSEED/RDRAND don't have premature next, due to the above
  KDF salt. This is probably the majority of systems out there these
  days. This also applies to the sleep resumption notification (and the
  vmgenid one), and I suspect that most systems with S3 or S0ix or
  whatever else these days also probably have RDRAND.

- Systems with viable jitter entropy could be in a position to not have
  premature next too, if we added periodic jitter entropy calls per your
  suggestion (3). Though, the jitter dance as it currently exists involves
  hammering on the scheduler a bit and spiking latency, so I'm not
  totally sure this is really worth it to do beyond boot time. It'd need
  a little bit more specific engineering, anyhow, to get the details
  right on it.

- Systems with no viable jitter nor RDSEED/RDRAND would need something
  like Fortuna, which doesn't seem worth it at all, given the
  discussion. These machines are probably in the first percentile of
  deployed systems too, and probably should be using something like
  seedrng [3] to initialize the RNG anyway. Plus, are these systems even
  fast enough to make condition B) viable to an attacker?

> Details would need to be worked out, of course. Hope this was helpful
> and apologies that it got long,

Very helpful, thank you. The key takeaways for me are:

- Premature next remains not a real world problem, per the reasons you
  and others cited.

- Entropy *generation* makes most of those concerns disappear anyway,
  without the complexities and security issues associated with entropy
  long- or multi- *pooling*.

Jason

[1] https://git.kernel.org/crng/random/c/7edc59743da5
[2] https://git.kernel.org/crng/random/c/50ee7529ec45
[3] https://git.zx2c4.com/seedrng/about/
