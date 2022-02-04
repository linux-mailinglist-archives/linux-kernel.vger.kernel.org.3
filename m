Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6C3694A9ABC
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Feb 2022 15:11:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1359205AbiBDOLx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Feb 2022 09:11:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43134 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232803AbiBDOLw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Feb 2022 09:11:52 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BCA75C061714
        for <linux-kernel@vger.kernel.org>; Fri,  4 Feb 2022 06:11:52 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 74B3160C09
        for <linux-kernel@vger.kernel.org>; Fri,  4 Feb 2022 14:11:51 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9B22AC340E9
        for <linux-kernel@vger.kernel.org>; Fri,  4 Feb 2022 14:11:50 +0000 (UTC)
Authentication-Results: smtp.kernel.org;
        dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="N2whDa6P"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zx2c4.com; s=20210105;
        t=1643983907;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=OeJsq+4IasIrFGg0OXj6RdIsVHdb3/r+NoA3dw1M+b8=;
        b=N2whDa6PnIqA5ykUmCT6YAFPwmDsJeLrjG2y1DK/gbwbfk46RC0Fw6nvkZTtKolu43LTNV
        VEeNCQyX+nxNUYAvIQuViNDjqKHcXTu6p/R3F5AGzfWYK/A/kG6dBkeDgv/s6od/wOWFOT
        GsfxI1MSbIElqoOi+3HaWg2v6uQImzQ=
Received: by mail.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id a163478c (TLSv1.3:AEAD-AES256-GCM-SHA384:256:NO)
        for <linux-kernel@vger.kernel.org>;
        Fri, 4 Feb 2022 14:11:47 +0000 (UTC)
Received: by mail-yb1-f178.google.com with SMTP id w81so18967691ybg.12
        for <linux-kernel@vger.kernel.org>; Fri, 04 Feb 2022 06:11:46 -0800 (PST)
X-Gm-Message-State: AOAM530238KQZ4IGD2vOe3iA8bReLcrkC5dSexx0k0lU9VMgt0GQEWgj
        QIMiOKI435hugiWMPeCKyqbjR954WnTSb2BLZi0=
X-Google-Smtp-Source: ABdhPJzcyhDrdy62YhCtldRfRsEXSZqOuTn1RKj+key+c0AMMPyjTmYN5KV8F/LWTOQpNTF4XuNyzWIPsV5vksajy9o=
X-Received: by 2002:a25:9088:: with SMTP id t8mr2753751ybl.113.1643983905375;
 Fri, 04 Feb 2022 06:11:45 -0800 (PST)
MIME-Version: 1.0
References: <CAHmME9pe2BEJV4WiZNHmDmH_XK621Qqr1JCBdgTNZmr4JGBA4w@mail.gmail.com>
 <20220128223548.97807-1-Jason@zx2c4.com> <CAHmME9qtjZX2kVNSQqUsTrZv1cdR8y6n3yZS-RnpVCCzX9okcA@mail.gmail.com>
 <Yf0JlXf3ARsBpL9K@linutronix.de> <CAHmME9r0XxX3LqNLpVeqAjDQ_OVskPf15QOwxtZYy0tb_x_7HQ@mail.gmail.com>
 <Yf0xy4kZ2Mn65yp8@linutronix.de>
In-Reply-To: <Yf0xy4kZ2Mn65yp8@linutronix.de>
From:   "Jason A. Donenfeld" <Jason@zx2c4.com>
Date:   Fri, 4 Feb 2022 15:11:34 +0100
X-Gmail-Original-Message-ID: <CAHmME9oOMhRVybTgHXT+oOXhMkdx7FVY7oSc-rHr=6AvZCVo=w@mail.gmail.com>
Message-ID: <CAHmME9oOMhRVybTgHXT+oOXhMkdx7FVY7oSc-rHr=6AvZCVo=w@mail.gmail.com>
Subject: Re: [PATCH v2] random: remove batched entropy locking
To:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc:     Andy Lutomirski <luto@amacapital.net>,
        Boqun Feng <boqun.feng@gmail.com>,
        Will Deacon <will@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Waiman Long <longman@redhat.com>,
        Sultan Alsawaf <sultan@kerneltoast.com>,
        "Theodore Ts'o" <tytso@mit.edu>, Andy Lutomirski <luto@kernel.org>,
        =?UTF-8?Q?Jonathan_Neusch=C3=A4fer?= <j.neuschaefer@gmx.net>,
        LKML <linux-kernel@vger.kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Sebastian,

On Fri, Feb 4, 2022 at 3:02 PM Sebastian Andrzej Siewior
<bigeasy@linutronix.de> wrote:
> The commit in tree you cited is b43db859a36cb553102c9c80431fc44618703bda.
> It does not mention anything regarding faster nor the performance
> improvement and conditions (hoth path, etc). It still has a stable tag.

It dropped the Cc: stable@. It still has the Fixes:. I can get rid of
the Fixes: too. I'll improve that message a bunch for a potential v3.

> > Maybe it'd be best to retain the spinlock_t, which will amount to
> > disabling interrupts on !PREEMPT_RT, since it'll never be contended,
> > but will turn into a mutex on PREEMPT_RT, where it'll do the right
> > thing from an exclusivity perspective. Would this be reasonable?
>
> what does retain the spinlock_t mean since we already have a spinlock_t?

The idea would be to keep using spinlock_t like we do now -- no change
there -- but move to using this atomic generation counter so that
there's never any contention. Actually, though, I worry that that
approach would throw out the gains we're getting by chucking the
spinlock in the first place.

What if we keep a spinlock_t there on PREEMPT_RT but stick with
disabling interrupts on !PREEMPT_RT? I wish there was a solution or an
API that amounted to the same thing so there wouldn't need to be an
#ifdef, but I don't know what that'd be.

Jason
