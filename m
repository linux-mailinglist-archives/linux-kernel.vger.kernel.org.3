Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ADC11550023
	for <lists+linux-kernel@lfdr.de>; Sat, 18 Jun 2022 00:47:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348824AbiFQWr3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Jun 2022 18:47:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53960 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236917AbiFQWrZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Jun 2022 18:47:25 -0400
Received: from sin.source.kernel.org (sin.source.kernel.org [145.40.73.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 78D443E0C7
        for <linux-kernel@vger.kernel.org>; Fri, 17 Jun 2022 15:47:24 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id C06B9CE2C6F
        for <linux-kernel@vger.kernel.org>; Fri, 17 Jun 2022 22:47:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 309A5C3411B;
        Fri, 17 Jun 2022 22:47:20 +0000 (UTC)
Authentication-Results: smtp.kernel.org;
        dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="hw5zLeZQ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zx2c4.com; s=20210105;
        t=1655506038;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=JTxEPc10VTQAiywno/ofScrkrwItQkMa1qfpSm/Mqbw=;
        b=hw5zLeZQQogn99UwfTnqbleDw/VokAli19/4qlAR5CSyJZGZjoH8b56KOMbgjPxhLCOQxh
        54hcGbfLTPXMWcNTNM9lyh+UB+HFmV1GJryzencYVCSm9rKqbVq7qe4mqYX0rm0ioMSd7i
        qlSuqbo/YpVDafF+BiXhp7Xk5R8jqbM=
Received: by mail.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id b2e85dcd (TLSv1.3:AEAD-AES256-GCM-SHA384:256:NO);
        Fri, 17 Jun 2022 22:47:18 +0000 (UTC)
Date:   Sat, 18 Jun 2022 00:47:12 +0200
From:   "Jason A. Donenfeld" <Jason@zx2c4.com>
To:     Sebastian Siewior <bigeasy@linutronix.de>
Cc:     Jann Horn <jannh@google.com>, Theodore Ts'o <tytso@mit.edu>,
        LKML <linux-kernel@vger.kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [PATCH] random: Fix signal_pending() usage
Message-ID: <Yq0EcG9GsAkoiF3H@zx2c4.com>
References: <20220405163931.1108442-1-jannh@google.com>
 <CAHmME9pW6heXtPrfCP7J6ODgSc8sotsv6E3dnJoVBaPi+Ph=HA@mail.gmail.com>
 <YqywapDM7NPC/X+E@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <YqywapDM7NPC/X+E@linutronix.de>
X-Spam-Status: No, score=-6.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Sebastian,

On Fri, Jun 17, 2022 at 06:48:42PM +0200, Sebastian Siewior wrote:
> On 2022-04-05 20:07:27 [+0200], Jason A. Donenfeld wrote:
> > One funny aspect of the fact that signal_pending() hasn't worked right
> > since the genesis commit is that this has probably led to a lot of
> > userspace code that doesn't check the result from read() or
> > getrandom(), and that code has worked mostly fine.
> 
> :)
> 
> > I wonder if we should do something about that. Worth noting is that
> > we're no longer contending with /dev/random periodically blocking as
> > the "entropy runs out" nonsense. I can think of two possible changes,
> > which maybe aren't mutually exclusive:
> > 
> > 1) Turn signal_pending() into fatal_signal_pending() throughout the file.
> > 2) Rather than not checking signal_pending() for reads of length <=
> > 256, we could not check for signal_pending() for the first 256 bytes
> > of any length read.
> > 
> > Both of these would be changing userspace behavior, so it should
> > probably be considered carefully. Any thoughts?
> 
> You are not doing any blocking as far as I can tell so there won't be
> any wake up via TASK_INTERRUPTIBLE for you here.
> You check for the signal_pending() every PAGE_SIZE so there will be at
> least 4KiB of data, not sure where this 256 is coming from.
> Since you always return the number of bytes, there won't be any visible
> change for requests < PAGE_SIZE. And for requests > PAGE_SIZE your
> getrandom() invocation may return less than asked for. This is _now_.
> 
> If you drop that signal_pending() check then the user will always get
> the number of bytes he asked for. Given that this is *quick* as in
> no blocking, then there should be no harm in dropping this signal check.

You're a bit late to the thread :). It used to be 256. Now it's page
size. PAGE_SIZE is also what /dev/zero and others in mem.c use.

As for your suggestion to drop it entirely: that'd be nice, in that it'd
add a guarantee that currently doesn't exist. But it can lead to
somewhat large delays if somebody tries to read 2 gigabytes at a time
and hits Ctrl+C during it. That seems potentially bad?

Or that's not bad, which would be quite nice, as I would really love to
add that guarantee. So if you have an argument that not responding to
signals for that amount of time is fine, I'd be interested to hear it.

Jason
