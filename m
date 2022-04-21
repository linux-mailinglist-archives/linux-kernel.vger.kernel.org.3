Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ECFB150A9DD
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Apr 2022 22:20:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1392290AbiDUUXe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Apr 2022 16:23:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44024 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232935AbiDUUXd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Apr 2022 16:23:33 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9152C36171;
        Thu, 21 Apr 2022 13:20:42 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 4D43FB8290E;
        Thu, 21 Apr 2022 20:20:41 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 49FCDC385A5;
        Thu, 21 Apr 2022 20:20:39 +0000 (UTC)
Authentication-Results: smtp.kernel.org;
        dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="CXoE+Cc0"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zx2c4.com; s=20210105;
        t=1650572437;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=AOnL2h4VjVIz9OJWMKbJ/CWQbIxRNPBwFjf/MNHCgKk=;
        b=CXoE+Cc0sY67hYi7NqwUUGDxSv6pcZTnS6LCm7VH15g6E9nGKYm9P8kLremZ666ri3W6HM
        +eD2wrhREOQkbLwqYk15t+cdbnaK0fkppCJBrD1Je6k32SNSiazMAW3YCB6c9DGf5fo5nK
        gye2OchubXp3bYga2HjwAX2V76422Ik=
Received: by mail.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id e61353f9 (TLSv1.3:AEAD-AES256-GCM-SHA384:256:NO);
        Thu, 21 Apr 2022 20:20:37 +0000 (UTC)
Date:   Thu, 21 Apr 2022 22:20:35 +0200
From:   "Jason A. Donenfeld" <Jason@zx2c4.com>
To:     Eric Biggers <ebiggers@kernel.org>
Cc:     Theodore Ts'o <tytso@mit.edu>, linux-kernel@vger.kernel.org,
        linux-crypto@vger.kernel.org, Andy Polyakov <appro@cryptogams.org>
Subject: Re: [PATCH] random: avoid mis-detecting a slow counter as a cycle
 counter
Message-ID: <YmG8k1JrVexBGmJL@zx2c4.com>
References: <20220421192939.250680-1-ebiggers@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20220421192939.250680-1-ebiggers@kernel.org>
X-Spam-Status: No, score=-6.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Eric,

On Thu, Apr 21, 2022 at 9:30 PM Eric Biggers <ebiggers@kernel.org> wrote:
> The method that try_to_generate_entropy() uses to detect a cycle counter
> is to check whether two calls to random_get_entropy() return different
> values.  This is uncomfortably prone to false positives if
> random_get_entropy() is a slow counter, as the two calls could return
> different values if the counter happens to be on the cusp of a change.
> Making things worse, the task can be preempted between the calls.
>
> This is problematic because try_to_generate_entropy() doesn't do any
> real entropy estimation later; it always credits 1 bit per loop
> iteration.  To avoid crediting garbage, it relies entirely on the
> preceding check for whether a cycle counter is present.
>
> Therefore, increase the number of counter comparisons from 1 to 3, to
> greatly reduce the rate of false positive cycle counter detections.

Thanks for the patch. It seems like this at least is not worse than
before. But before I commit this and we forget about the problem for a
while, I was also wondering if we can do much, much better than before,
and actually make this "work" with slow counters. Right now, the core
algorithm is:

    while (!crng_ready()) {
        if (no timer) mod_timer(jiffies + 1);
	mix(sample);
	schedule();    // <---- calls the timer, which does credit_entry_bits(1)
	sample = rdtsc;
    }

So we credit 1 bit every time that timer fires. What if the timer
instead did this:

    static void entropy_timer(struct timer_list *t)
    {
        struct timer_state *s = container_of(...t...);
        if (++s->samples == s->samples_per_bit) {
            credit_entropy_bits(1);
            s->samples = 0;
        }
    }

Currently, samples_per_bit is 1. What if we make it >1 on systems with
slow cycle counters? The question then is: how do we relate some
information about cycle counter samples to the samples_per_bit estimate?
The jitter stuff in crypto/ does something. Andy (CC'd) mentioned to me
last week that he did something some time ago computing FFTs on the fly
or something like that. And maybe there are other ideas still. I wonder
if we can find something appropriate for the kernel here.

Any thoughts on that direction?

Jason
