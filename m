Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 73EAE595DF0
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Aug 2022 16:03:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235750AbiHPODK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 Aug 2022 10:03:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56534 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235789AbiHPODH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Aug 2022 10:03:07 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7BEAE7F0B0
        for <linux-kernel@vger.kernel.org>; Tue, 16 Aug 2022 07:03:03 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 18F2260FB5
        for <linux-kernel@vger.kernel.org>; Tue, 16 Aug 2022 14:03:03 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ED2FBC433D6;
        Tue, 16 Aug 2022 14:03:01 +0000 (UTC)
Authentication-Results: smtp.kernel.org;
        dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="e+bGvBnb"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zx2c4.com; s=20210105;
        t=1660658580;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=UlxUyVT2PDOeWDZxuI8fYc7rJW5gk6gfvHPINj1OvPk=;
        b=e+bGvBnbPzoQdVSrnCA5bkLfOnBHLjLowxqeABj14NaPXWFX9yrJeEjGwTRvhusYVMXh/N
        L1cIQuJNCXHdES63lN0XTYfuiussjFEoHzTCByU3YvU/Fy/D3MrIjTSkECwn6D03s5rIXV
        K4y5KEFfDYwiBEAO7sTZnmKN2K1/Xx0=
Received: by mail.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id 301312b6 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
        Tue, 16 Aug 2022 14:02:59 +0000 (UTC)
Date:   Tue, 16 Aug 2022 16:02:55 +0200
From:   "Jason A. Donenfeld" <Jason@zx2c4.com>
To:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc:     linux-kernel@vger.kernel.org, tglx@linutronix.de
Subject: Re: [PATCH] random: use raw spinlocks for use on RT
Message-ID: <YvujjzfkJL2+1+9d@zx2c4.com>
References: <20220801142530.133007-1-Jason@zx2c4.com>
 <YufkZU9kGkHHUhAK@linutronix.de>
 <YvRKm/IpbUID18FK@zx2c4.com>
 <YvSsf5uds7zGgWPX@linutronix.de>
 <YvUQJTDREXSAA9J6@zx2c4.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <YvUQJTDREXSAA9J6@zx2c4.com>
X-Spam-Status: No, score=-6.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hey Sebastian,

On Thu, Aug 11, 2022 at 04:20:21PM +0200, Jason A. Donenfeld wrote:
> Hi Sebastian,
> 
> On Thu, Aug 11, 2022 at 09:15:11AM +0200, Sebastian Andrzej Siewior wrote:
> > On 2022-08-11 02:17:31 [+0200], Jason A. Donenfeld wrote:
> > > Hey Sebastian,
> > Hi Jason,
> > 
> > > > > Sebastian - I won't move forward with this without your Ack, obviously.
> > > > > What do you think of this general approach? -Jason
> > > > 
> > > > I would need to do worst-case measurements and I've been looking at this
> > > > just before writting the other email and there was a local_lock_t
> > > > somewhere which needs also change…
> > > 
> > > Did you ever come up some measurements here? It sure would be nice if I
> > > could apply this, but obviously that's contingent on you saying it's
> > > okay latency-wise on RT.
> > 
> > No, I did not. But I've been thinking a little about it. The worst case
> > latency is important now and later.
> > Looking at it, all we need is one init in vsprintf at boot time and we
> > are done. That is the third fallout that I am aware of since the rework
> > of get_random_*().
> > We managed to get rid of all memory allocations (including GFP_ATOMIC)
> > from preempt/IRQ-off section on PREEMPT_RT. Therefore I am not convinced
> > to make all locks in random core a raw_spinlock_t just to make things
> > work here as of now.
> 
> By grouping everything into "the rework of get_random_*()", you miss
> important subtleties, as I mentioned before. Importantly, in this case,
> the issue we're facing has absolutely nothing at all to do with that,
> but is rather entirely the result of removing the async notifier
> mechanism in favor of doing things more directly, more straight
> forwardly. So let's not muddle what we're discussing here.
> 
> But more generally, the RNG is supposed to be usable from any context.
> And adding wild workarounds, or worse, adding back complex async
> notifier stuff, seems bad. So far your proposals for the printk issue
> haven't been acceptable at all.
> 
> So why don't we actually fix this, so we don't have to keep coming up
> with hacks? The question is: does using raw spinlocks over this code
> result in any real issue for RT latency? If so, I'd like to know where,
> and maybe I can do something about that (or maybe I can't). If not, then
> this is a non problem and I'll apply this patch with your blessing.
> 
> If you don't want to spend time doing latency measurements, could you
> instead share a document or similar to the type of methodology you
> usually use for that, so I can do the same? And at the very least, I am
> simply curious and want to know more about the RT world.

Thought I'd ping you about this again...

Jason
