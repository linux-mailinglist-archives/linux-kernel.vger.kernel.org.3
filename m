Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3F5404A9C8F
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Feb 2022 16:59:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344802AbiBDP7P (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Feb 2022 10:59:15 -0500
Received: from dfw.source.kernel.org ([139.178.84.217]:57718 "EHLO
        dfw.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239812AbiBDP7N (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Feb 2022 10:59:13 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 51C966189B
        for <linux-kernel@vger.kernel.org>; Fri,  4 Feb 2022 15:59:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8EEC9C340EF
        for <linux-kernel@vger.kernel.org>; Fri,  4 Feb 2022 15:59:12 +0000 (UTC)
Authentication-Results: smtp.kernel.org;
        dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="PadrEfyM"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zx2c4.com; s=20210105;
        t=1643990351;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=B+R6OUdEJRf2p4gtYVGemz3QvnaeTdLc8VycaTIIZtA=;
        b=PadrEfyMkLZTS+4mN7znqfFBQgDRIrsL0foO3EEQcVduvWjGupqzF0FAcjx9t2v7DjzoNm
        goSTC6owAEFbVDzsUMDKFk0PQHolpz7Wu2j3fmp+9x98tQ3HnyjyVF0mfRcHEXozII/7bp
        yz3BSckDRtrI6lJy2d5zKJLL1hpd88U=
Received: by mail.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id ba3a46e1 (TLSv1.3:AEAD-AES256-GCM-SHA384:256:NO)
        for <linux-kernel@vger.kernel.org>;
        Fri, 4 Feb 2022 15:59:10 +0000 (UTC)
Received: by mail-yb1-f169.google.com with SMTP id y6so5336287ybc.5
        for <linux-kernel@vger.kernel.org>; Fri, 04 Feb 2022 07:59:10 -0800 (PST)
X-Gm-Message-State: AOAM532NLU443FVVt+GVlIsIO1KLaAbkmx+eQTF7DAlIviwxNMhTTa27
        Gvta3AghHxYaQuKxSNHB4LTgu7RJf4amfr6pnk4=
X-Google-Smtp-Source: ABdhPJz8JEJ2rRHH/861j1cgGmg4khJWU/DSntKf0Wc4Pi57cvODFtsI88Nd6F7CHiHtJLNIDdA+920oNVHw/vCQWJ8=
X-Received: by 2002:a25:9088:: with SMTP id t8mr3217898ybl.113.1643990349212;
 Fri, 04 Feb 2022 07:59:09 -0800 (PST)
MIME-Version: 1.0
References: <YfgPWatDzkn2ozhm@linutronix.de> <20220204153149.51428-1-Jason@zx2c4.com>
In-Reply-To: <20220204153149.51428-1-Jason@zx2c4.com>
From:   "Jason A. Donenfeld" <Jason@zx2c4.com>
Date:   Fri, 4 Feb 2022 16:58:58 +0100
X-Gmail-Original-Message-ID: <CAHmME9pucLWXDofvOgHEau3y-7RmdtU91_jQHSt7psuR22eXBg@mail.gmail.com>
Message-ID: <CAHmME9pucLWXDofvOgHEau3y-7RmdtU91_jQHSt7psuR22eXBg@mail.gmail.com>
Subject: Re: [PATCH RFC v1] random: do not take spinlocks in irq handler
To:     LKML <linux-kernel@vger.kernel.org>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>,
        "Theodore Ts'o" <tytso@mit.edu>,
        Sultan Alsawaf <sultan@kerneltoast.com>,
        =?UTF-8?Q?Jonathan_Neusch=C3=A4fer?= <j.neuschaefer@gmx.net>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

FWIW, the biggest issue with this

On Fri, Feb 4, 2022 at 4:32 PM Jason A. Donenfeld <Jason@zx2c4.com> wrote:
> +static void mix_interrupt_randomness(struct work_struct *work)
> +{
[...]
> +       if (unlikely(crng_init == 0)) {
> +               if (crng_fast_load((u8 *)&fast_pool->pool, sizeof(fast_pool->pool)) > 0)
> +                       atomic_set(&fast_pool->count, 0);
> +               else
> +                       atomic_and(~FAST_POOL_MIX_INFLIGHT, &fast_pool->count);
> +               return;
> +       }
[...]
>  void add_interrupt_randomness(int irq)
> -       if (unlikely(crng_init == 0)) {
> -               if ((fast_pool->count >= 64) &&
> -                   crng_fast_load((u8 *)fast_pool->pool, sizeof(fast_pool->pool)) > 0) {
> -                       fast_pool->count = 0;
> -                       fast_pool->last = now;
> -               }
> -               return;

The point of crng_fast_load is to shuffle bytes into the crng as fast
as possible for very early boot usage. Deferring that to a workqueue
seems problematic. So I think at the very least _that_ part will have
to stay in the IRQ handler. That means we've still got a spinlock. But
at least it's a less problematic one than the input pool spinlock, and
perhaps we can deal with that some other way than this patch's
approach.

In other words, this approach for the calls to mix_pool_bytes, and a
different approach for that call to crng_fast_load.

Jason
