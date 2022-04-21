Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AECD550ABBE
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Apr 2022 01:00:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1392359AbiDUXCS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Apr 2022 19:02:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49990 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239972AbiDUXCR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Apr 2022 19:02:17 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2BE1E3DDD9;
        Thu, 21 Apr 2022 15:59:26 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B032B618E6;
        Thu, 21 Apr 2022 22:59:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 58D61C385A7;
        Thu, 21 Apr 2022 22:59:24 +0000 (UTC)
Authentication-Results: smtp.kernel.org;
        dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="ORIcxgQl"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zx2c4.com; s=20210105;
        t=1650581962;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=yrx6LV8BpRq8lvnB552cplMOohmgoFH5hBidu/I1mNk=;
        b=ORIcxgQluArhHZCQyuk6URe595LFJHkhk6pQjym0f5rSamsu+Yh2s4wdVcpGxaj39ZGnqz
        juGWb/LEMHwAtSC6wuhpm1vfhLdD5FDr5VO00llWZhkc+ZkGY2ADh+0WVbWQNRh//BDjK1
        SLlP0pdVHpsYZzPq5sS7T3IA7nFUAg8=
Received: by mail.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id 51bda336 (TLSv1.3:AEAD-AES256-GCM-SHA384:256:NO);
        Thu, 21 Apr 2022 22:59:22 +0000 (UTC)
Date:   Fri, 22 Apr 2022 00:59:19 +0200
From:   "Jason A. Donenfeld" <Jason@zx2c4.com>
To:     Eric Biggers <ebiggers@kernel.org>
Cc:     Theodore Ts'o <tytso@mit.edu>, linux-kernel@vger.kernel.org,
        linux-crypto@vger.kernel.org, Andy Polyakov <appro@cryptogams.org>
Subject: Re: [PATCH] random: avoid mis-detecting a slow counter as a cycle
 counter
Message-ID: <YmHhx5IrxDKeqJnc@zx2c4.com>
References: <20220421192939.250680-1-ebiggers@kernel.org>
 <YmG8k1JrVexBGmJL@zx2c4.com>
 <YmHDctbEAmJhinoz@sol.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <YmHDctbEAmJhinoz@sol.localdomain>
X-Spam-Status: No, score=-6.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hey Eric,

On Thu, Apr 21, 2022 at 01:49:54PM -0700, Eric Biggers wrote:
> I think we'll need to go there eventually, along with fixing
> add_timer_randomness() and add_interrupt_randomness() to credit entropy more
> accurately.  I do not think there is an easy fix, though; this is mostly an open
> research area.  Looking into research papers and what has been done for other
> jitter entropy implementations would be useful.

Alright, so my feeble attempt at nerd sniping you into working on this
inside of a mailing list thread didn't catch, alas. :)) But yea, I guess
this is something we'll have to look at. For add_timer_randomness(), I
actually wonder whether we could just get rid of all the estimation
stuff and credit either 1 or 0 bits per event, like all other sources.
Food for thought.

Anyway, onto your actual patch. I was just looking at this and something
didn't look right:

> +       for (i = 0; i < 3; i++) {
> +               if (stack.entropy == random_get_entropy())
> +                       return;
> +       }

So stack.entropy is set once when the function starts. Then we see if it
becomes equal to a new counter three times in a row. But if it's not
equal on the first try, it's probably not equal on the second and third,
right?

I suspect what you actually meant to do here is check adjacent counters,
the rationale being that on a system with a slow counter, you might be
[un]lucky and read the counter _just_ before it changes, and then the
new one differs, even though there's usually quite a large period of
time in between the two. For example:

| real time | cycle counter |
| --------- | ------------- |
| 3         | 5             |
| 4         | 5             |
| 5         | 5             |
| 6         | 5             |
| 7         | 5             | <--- a
| 8         | 6             | <--- b
| 9         | 6             | <--- c
| 10        | 6             | <--- d

If we read the counter at (a) and compare it to (b), we might be fooled
into thinking that it's a fast counter, when in reality it is not. The
solution is to also compare counter (b) to counter (c), on the theory
that if the counter is _actually_ slow, and (a)!=(b), then certainly
(b)==(c). And for this we probably only need two comparisons, not three.
What your code does is compare (a)==(b), (a)==(c), (a)==(d), but I don't
think that gives us much.

So maybe a different way of writing this is just:

    if (random_get_entropy() == (stack.entropy = random_get_entropy()) ||
        stack.entropy == (stack.entropy = random_get_entropy()))
            return;

Or at least something to that extent.

Jason
