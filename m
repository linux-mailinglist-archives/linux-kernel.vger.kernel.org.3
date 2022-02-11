Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5487E4B23AF
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Feb 2022 11:48:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349156AbiBKKse (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Feb 2022 05:48:34 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:53830 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238232AbiBKKsd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Feb 2022 05:48:33 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1BDE7D56;
        Fri, 11 Feb 2022 02:48:32 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id B6EB1B82953;
        Fri, 11 Feb 2022 10:48:30 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1E74BC340E9;
        Fri, 11 Feb 2022 10:48:29 +0000 (UTC)
Authentication-Results: smtp.kernel.org;
        dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="ACcnPW7D"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zx2c4.com; s=20210105;
        t=1644576507;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=ZM8XXk1BN3u3et6AszmG+WL2WNoVHBsIcVM8Smp4IK4=;
        b=ACcnPW7Dlh3MSdQ+NjBiQTdshInZ46iWQQD1SA1NTMh6OYsnWrP+rtRHVT69GLmxV3WnMI
        Tup01K17b9CJl7Hh9PZ2iRqiuclh6FfIM19qtqn+LDxqL7NqM0wDEzt6LRPe/WPNWG2z7F
        f5MwaUdRyz/HcGY8mTDm3qpy1Zlqw4M=
Received: by mail.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id e9b502fe (TLSv1.3:AEAD-AES256-GCM-SHA384:256:NO);
        Fri, 11 Feb 2022 10:48:27 +0000 (UTC)
Received: by mail-yb1-f178.google.com with SMTP id x136so21802989ybe.11;
        Fri, 11 Feb 2022 02:48:27 -0800 (PST)
X-Gm-Message-State: AOAM530D3aZ7qh+giY8ydMJN66K6wCnIq5Wl1m89JOOLg9VgF2ixn5ar
        PZ7yI8f+fpluJ1bWuWR8JyHSuXCDtI1QTdis81M=
X-Google-Smtp-Source: ABdhPJyXDR5fARD+LuB9d7lHVoXg6cTkYkL2z1R7eSP9z0NJttC1OdMWs5Zvz+9na5lyeFJDfV/Gi/vFVShZVIAdsXM=
X-Received: by 2002:a81:1b54:: with SMTP id b81mr990452ywb.404.1644576506428;
 Fri, 11 Feb 2022 02:48:26 -0800 (PST)
MIME-Version: 1.0
References: <CAHmME9pGwyZKu=9yCben-V30hR+zEjb9iZGWr5_RAE-uXt_Ofw@mail.gmail.com>
 <20220211011446.392673-1-Jason@zx2c4.com> <YgYbRa+5cC0ivWrK@linutronix.de>
In-Reply-To: <YgYbRa+5cC0ivWrK@linutronix.de>
From:   "Jason A. Donenfeld" <Jason@zx2c4.com>
Date:   Fri, 11 Feb 2022 11:48:15 +0100
X-Gmail-Original-Message-ID: <CAHmME9oBCt=bvjQLwmppr29W9FdJ612+d1a8gUExyWZuZHVWZw@mail.gmail.com>
Message-ID: <CAHmME9oBCt=bvjQLwmppr29W9FdJ612+d1a8gUExyWZuZHVWZw@mail.gmail.com>
Subject: Re: [PATCH] random: ensure mix_interrupt_randomness() is consistent
To:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Linux Crypto Mailing List <linux-crypto@vger.kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        "Theodore Ts'o" <tytso@mit.edu>,
        Dominik Brodowski <linux@dominikbrodowski.net>,
        Sultan Alsawaf <sultan@kerneltoast.com>
Content-Type: text/plain; charset="UTF-8"
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

On Fri, Feb 11, 2022 at 9:16 AM Sebastian Andrzej Siewior
<bigeasy@linutronix.de> wrote:
> But I'm trying to avoid the migrate_disable(), so:
> To close the racy with losing the workqueue bit, wouldn't it be
> sufficient to set it to zero via atomic_cmpxchg()? Also if the counter
> before the memcpy() and after (at cmpxchg time) didn't change then the
> pool wasn't modified. So basically
>
>  do {
>         counter = atomic_read(&fast_pool->count); // no need to cast
>         memcpy(pool, fast_pool->pool_long, ARRAY_SIZE(pool));
>     } while (atomic_cmpxchg(&fast_pool->count, counter, 0) != counter);
>
>
> then it also shouldn't matter if we are _accidentally_ on the wrong CPU.

This won't work. If we're executing on a different CPU, the CPU
mutating the pool won't necessarily update the count at the right
time. This isn't actually a seqlock or something like that. Rather, it
depends on running on the same CPU, where the interrupting irq handler
runs in full before giving control back, so that count and pool are
either both updated or not at all. Making this work across CPUs makes
things a lot more complicated and I'd rather not do that.

Actually, though, a nicer fix would be to just disable local
interrupts for that *2 word copy*. That's a tiny period of time. If
you permit me, that seems nicer. But if you don't like that, I'll keep
that loop.

Unfortunately, though, I think disabling migration is required. Sultan
(CC'd) found that these workqueues can migrate even midway through
running. And generally the whole idea is to keep this on the *same*
CPU so that we don't have to introduce locks and synchronization.

I'll add comments around the acquire/release. The remaining question
I believe is: would you prefer disabing irqs during the 2 word memcpy,
or this counter double read loop?


Jason
