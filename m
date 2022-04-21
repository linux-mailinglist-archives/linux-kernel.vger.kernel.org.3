Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2B9E750AA54
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Apr 2022 22:50:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1392558AbiDUUxA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Apr 2022 16:53:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34720 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1392592AbiDUUwu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Apr 2022 16:52:50 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F09462DEF;
        Thu, 21 Apr 2022 13:49:58 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id B0C92B828D8;
        Thu, 21 Apr 2022 20:49:57 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4F176C385A7;
        Thu, 21 Apr 2022 20:49:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1650574196;
        bh=J55gWEdyZI84vCX5T8ZM2ZIVMQXFYIyDtR8Uq8FyZRI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=WnRwW7zR+8V3SzpJqk3LWNBW5IaUeqHC/7kVIE+s+yvdtq9pZn4nbadjnOnewY+ig
         CQsq1XmQRmsx67R3ngUswLM7NJMJLSqKxYdFIvetp6+jzhd5j3WqOw+WbBubV8qopV
         UIUpLjOighiwKmUOm05uqsJ4SSHFh1SafdlvnHvW75n1TkGSh1S7l8uI5+R75c1mGK
         Wjy8nDL1vX9FyzunTAf14qoP+eQ4trKm5riZrU31xl+cEF0f4SvbBkiWT8EMqvkGjJ
         58CRVNapFhxkMBbRns5LF7ehp7r8l9h9emyzVwnAStZKTeB3tqlUHkrcP+WXBjSj1a
         TDqoJiMndeuhw==
Date:   Thu, 21 Apr 2022 13:49:54 -0700
From:   Eric Biggers <ebiggers@kernel.org>
To:     "Jason A. Donenfeld" <Jason@zx2c4.com>
Cc:     Theodore Ts'o <tytso@mit.edu>, linux-kernel@vger.kernel.org,
        linux-crypto@vger.kernel.org, Andy Polyakov <appro@cryptogams.org>
Subject: Re: [PATCH] random: avoid mis-detecting a slow counter as a cycle
 counter
Message-ID: <YmHDctbEAmJhinoz@sol.localdomain>
References: <20220421192939.250680-1-ebiggers@kernel.org>
 <YmG8k1JrVexBGmJL@zx2c4.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YmG8k1JrVexBGmJL@zx2c4.com>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 21, 2022 at 10:20:35PM +0200, Jason A. Donenfeld wrote:
> Hi Eric,
> 
> On Thu, Apr 21, 2022 at 9:30 PM Eric Biggers <ebiggers@kernel.org> wrote:
> > The method that try_to_generate_entropy() uses to detect a cycle counter
> > is to check whether two calls to random_get_entropy() return different
> > values.  This is uncomfortably prone to false positives if
> > random_get_entropy() is a slow counter, as the two calls could return
> > different values if the counter happens to be on the cusp of a change.
> > Making things worse, the task can be preempted between the calls.
> >
> > This is problematic because try_to_generate_entropy() doesn't do any
> > real entropy estimation later; it always credits 1 bit per loop
> > iteration.  To avoid crediting garbage, it relies entirely on the
> > preceding check for whether a cycle counter is present.
> >
> > Therefore, increase the number of counter comparisons from 1 to 3, to
> > greatly reduce the rate of false positive cycle counter detections.
> 
> Thanks for the patch. It seems like this at least is not worse than
> before. But before I commit this and we forget about the problem for a
> while, I was also wondering if we can do much, much better than before,
> and actually make this "work" with slow counters. Right now, the core
> algorithm is:
> 
>     while (!crng_ready()) {
>         if (no timer) mod_timer(jiffies + 1);
> 	mix(sample);
> 	schedule();    // <---- calls the timer, which does credit_entry_bits(1)
> 	sample = rdtsc;
>     }
> 
> So we credit 1 bit every time that timer fires. What if the timer
> instead did this:
> 
>     static void entropy_timer(struct timer_list *t)
>     {
>         struct timer_state *s = container_of(...t...);
>         if (++s->samples == s->samples_per_bit) {
>             credit_entropy_bits(1);
>             s->samples = 0;
>         }
>     }
> 
> Currently, samples_per_bit is 1. What if we make it >1 on systems with
> slow cycle counters? The question then is: how do we relate some
> information about cycle counter samples to the samples_per_bit estimate?
> The jitter stuff in crypto/ does something. Andy (CC'd) mentioned to me
> last week that he did something some time ago computing FFTs on the fly
> or something like that. And maybe there are other ideas still. I wonder
> if we can find something appropriate for the kernel here.
> 
> Any thoughts on that direction?
> 

I think we'll need to go there eventually, along with fixing
add_timer_randomness() and add_interrupt_randomness() to credit entropy more
accurately.  I do not think there is an easy fix, though; this is mostly an open
research area.  Looking into research papers and what has been done for other
jitter entropy implementations would be useful.

- Eric
