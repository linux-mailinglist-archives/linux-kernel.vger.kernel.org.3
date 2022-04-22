Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 20C1C50B866
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Apr 2022 15:24:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1447947AbiDVN1G (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Apr 2022 09:27:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58106 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1447800AbiDVN1D (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Apr 2022 09:27:03 -0400
Received: from sin.source.kernel.org (sin.source.kernel.org [IPv6:2604:1380:40e1:4800::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA84A5839F;
        Fri, 22 Apr 2022 06:24:09 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 28575CE2973;
        Fri, 22 Apr 2022 13:24:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C8A6FC385A4;
        Fri, 22 Apr 2022 13:24:05 +0000 (UTC)
Authentication-Results: smtp.kernel.org;
        dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="VwOJbv3A"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zx2c4.com; s=20210105;
        t=1650633844;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Pch+L8M9KtX83OSfyZJfXJ4rgzqApwvB6ecz+tZfEsE=;
        b=VwOJbv3APm154VuGShXhAVWTQ4k6zVhf6cuZUqYmDO1SqUvgZhFj0HhMU1Zk6y3BU6x7eG
        1R7bixIrQxHKDxbQ3v6QVhjfD6I+4gCzXzjR2s8+xXN+H28FJbV1eEB/DYXaxnR/fjinJe
        h7PVSLU5BcpqmANRnmalD79sILM68QI=
Received: by mail.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id 80c97672 (TLSv1.3:AEAD-AES256-GCM-SHA384:256:NO);
        Fri, 22 Apr 2022 13:24:03 +0000 (UTC)
Date:   Fri, 22 Apr 2022 15:24:00 +0200
From:   "Jason A. Donenfeld" <Jason@zx2c4.com>
To:     Eric Biggers <ebiggers@kernel.org>
Cc:     Theodore Ts'o <tytso@mit.edu>, linux-kernel@vger.kernel.org,
        linux-crypto@vger.kernel.org,
        Linus Torvalds <torvalds@linuxfoundation.org>
Subject: Re: [PATCH v2] random: avoid mis-detecting a slow counter as a cycle
 counter
Message-ID: <YmKscCcGxeqikv7t@zx2c4.com>
References: <20220421233152.58522-1-ebiggers@kernel.org>
 <YmHraZcGnY3stnp9@zx2c4.com>
 <YmH4Mgbo9gs4tOp7@sol.localdomain>
 <YmJ4bJjet/QhkXZS@zx2c4.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <YmJ4bJjet/QhkXZS@zx2c4.com>
X-Spam-Status: No, score=-6.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 22, 2022 at 11:42:04AM +0200, Jason A. Donenfeld wrote:
> Hi Eric,
> 
> On Thu, Apr 21, 2022 at 05:34:58PM -0700, Eric Biggers wrote:
> > On Fri, Apr 22, 2022 at 01:40:25AM +0200, Jason A. Donenfeld wrote:
> > > Hi Eric,
> > > 
> > > Thanks. This looks better.
> > > 
> > > On Thu, Apr 21, 2022 at 04:31:52PM -0700, Eric Biggers wrote:
> > > > Therefore, increase the number of counter comparisons from 1 to 3, to
> > > > greatly reduce the rate of false positive cycle counter detections.
> > > > +	for (i = 0; i < 3; i++) {
> > > > +		unsigned long entropy = random_get_entropy();
> > >  
> > > Wondering: why do you do 3 comparisons rather than 2? What does 3 get
> > > you that 2 doesn't already? I thought the only real requirement was that
> > > in the event where (a)!=(b), (b) is read as meaningfully close as
> > > possible to when the counter changes.
> > > 
> > 
> > On CONFIG_PREEMPT kernels this code usually runs with preemption enabled, so I
> > don't think it's guaranteed that any particular number of comparisons will be
> > sufficient, since the task could get preempted for a long time between each call
> > to random_get_entropy().  However, the chance of a false positive should
> > decrease exponentially, and should be pretty small in the first place, so 3
> > comparisons seems like a good number.
> 
> Ahh, I see. So you check three times instead of disabling
> preemption/irqs, which would be awfully heavy weight. Seems like a
> reasonable compromise.
> 
> By the way, I was thinking about the assumptions we're making with this
> comparison ("two adjacent counters shouldn't be the same") in the
> context of this idea from my first reply to you:

Rather than buggy inline email code, I made a real patch out of it for
your consideration:
https://lore.kernel.org/linux-crypto/20220422132027.1267060-1-Jason@zx2c4.com/

Jason
