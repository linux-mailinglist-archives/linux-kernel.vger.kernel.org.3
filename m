Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9A10051E243
	for <lists+linux-kernel@lfdr.de>; Sat,  7 May 2022 01:40:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1444800AbiEFWiN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 May 2022 18:38:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45064 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1444794AbiEFWiJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 May 2022 18:38:09 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED4365DE7E;
        Fri,  6 May 2022 15:34:24 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 8B4AF61761;
        Fri,  6 May 2022 22:34:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 12166C385A9;
        Fri,  6 May 2022 22:34:22 +0000 (UTC)
Authentication-Results: smtp.kernel.org;
        dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="GoGUMMZE"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zx2c4.com; s=20210105;
        t=1651876461;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=BSjhwQnArHmmHj5yD1qrUrLqAn72JVs7ByJm5ucFFxw=;
        b=GoGUMMZEdqURVwXT2muPgR8mHScu2BmbRGqJkdaPZ1TTz4s+c6iAaTbfoog8T1hjc4gwqO
        P0HLLXsW1hF9Gr2+49v9Wa5ehQcdE+X3AJYNUN+VKSOWJY5DVbUqVuYyKn+78k/r1nwJzv
        w1EFITWZachNDaB26GOLQErREclfKno=
Received: by mail.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id ecf7288d (TLSv1.3:AEAD-AES256-GCM-SHA384:256:NO);
        Fri, 6 May 2022 22:34:21 +0000 (UTC)
Date:   Sat, 7 May 2022 00:34:18 +0200
From:   "Jason A. Donenfeld" <Jason@zx2c4.com>
To:     David Laight <David.Laight@ACULAB.COM>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Borislav Petkov <bp@alien8.de>,
        LKML <linux-kernel@vger.kernel.org>,
        "x86@kernel.org" <x86@kernel.org>,
        Filipe Manana <fdmanana@suse.com>,
        "linux-crypto@vger.kernel.org" <linux-crypto@vger.kernel.org>
Subject: Re: [patch 3/3] x86/fpu: Make FPU protection more robust
Message-ID: <YnWiasChfzbEP67C@zx2c4.com>
References: <YnKh96isoB7jiFrv@zx2c4.com>
 <87czgtjlfq.ffs@tglx>
 <YnLOXZp6WgH7ULVU@zx2c4.com>
 <87wnf1huwj.ffs@tglx>
 <YnMRwPFfvB0RlBow@zx2c4.com>
 <87mtfwiyqp.ffs@tglx>
 <YnMkRLcxczMxdE5z@zx2c4.com>
 <87h764ixjs.ffs@tglx>
 <YnOuqh4YZT8ww96W@zx2c4.com>
 <1f4918f734d14e3896071d3c7de1441d@AcuMS.aculab.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1f4918f734d14e3896071d3c7de1441d@AcuMS.aculab.com>
X-Spam-Status: No, score=-6.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi David,

On Thu, May 05, 2022 at 11:34:40AM +0000, David Laight wrote:
> OTOH the entropy mixing is very likely to be 'cold cache'
> and all the unrolling in blakes7 will completely kill
> performance.

I've seen you mention the BLAKE2s unrolling in like 8 different threads
now, and I'm not convinced that you're entirely wrong, nor am I
convinced that you're entirely right. My response to you is the same as
always: please send a patch with some measurements! I'd love to get this
worked out in a real way.

The last time I went benching these, the unrolled code was ~100 cycles
faster, if I recall correctly, than the rolled code, when used from
WireGuard's hot path. I don't doubt that a cold path would be more
fraught, though, as that's a decent amount of code. So the question is
how to re-roll the rounds without sacrificing those 100 cycles.

In order to begin to figure that out, we have to look at why the
re-rolled loop is slow and the unrolled loop fast. It's not because of
complicated pipeline things. It's because the BLAKE2s permutation is
actually 10 different permutations, one for each round. Take a look at
the core function, G, and its uses of the round number, r:

    #define G(r, i, a, b, c, d) do { \
        a += b + m[blake2s_sigma[r][2 * i + 0]]; \
        d = ror32(d ^ a, 16); \
        c += d; \
        b = ror32(b ^ c, 12); \
        a += b + m[blake2s_sigma[r][2 * i + 1]]; \
        d = ror32(d ^ a, 8); \
        c += d; \
        b = ror32(b ^ c, 7); \
    } while (0)

The blake2s_sigma array is a `static const u8 blake2s_sigma[10][16]`,
with a row for every one of the 10 rounds. What this is actually doing
is reading the message words in a different order each round, so that
the whole permutation is different.

When the loop is unrolled, blake2s_sigma gets inlined, and then there
are no memory accesses. When it's re-rolled, every round accesses
blake2s_sigma 16 times, which hinders performance.

You'll notice, on the other hand, that the SIMD hand coded assembly
implementations do not unroll. The trick is to hide the cost of the
blake2s_sigma indirection in the data dependencies, so that performance
isn't affected. Naively re-rolling the generic code does not inspire the
compiler to do that. But maybe you can figure something out?

Anyway, that's about where my thinking is on this, but I'd love to see
some patches from you at some point if you're interested.

Jason
