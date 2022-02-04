Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 166C34A9CB1
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Feb 2022 17:12:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376393AbiBDQMg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Feb 2022 11:12:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42850 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231984AbiBDQMf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Feb 2022 11:12:35 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 99B6EC061714
        for <linux-kernel@vger.kernel.org>; Fri,  4 Feb 2022 08:12:35 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 41BEBB83829
        for <linux-kernel@vger.kernel.org>; Fri,  4 Feb 2022 16:12:32 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D4BD9C340EF
        for <linux-kernel@vger.kernel.org>; Fri,  4 Feb 2022 16:12:30 +0000 (UTC)
Authentication-Results: smtp.kernel.org;
        dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="ZQY9dWjU"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zx2c4.com; s=20210105;
        t=1643991148;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=39Ac1fM8jteFuPjKbQCeWHQDwfJyLKYnAufU7vTLW/k=;
        b=ZQY9dWjUnbu9fGfgJPM3MxAOb3qa/FyYa1q3mNUNF5KSr1wGHreeRZczNLlYgD00vDh2ge
        I1TBxicss7A3sDAKnCbvoYiFjthZRyqugvkxMpWFWagEwhayybELO4EJ5yz8FJL0g56lve
        tw8KuMEAXR7vhwj6uh793nepH/p5CAE=
Received: by mail.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id 3ca8af27 (TLSv1.3:AEAD-AES256-GCM-SHA384:256:NO)
        for <linux-kernel@vger.kernel.org>;
        Fri, 4 Feb 2022 16:12:28 +0000 (UTC)
Received: by mail-yb1-f175.google.com with SMTP id p5so20058699ybd.13
        for <linux-kernel@vger.kernel.org>; Fri, 04 Feb 2022 08:12:28 -0800 (PST)
X-Gm-Message-State: AOAM532eAivo3kuJwDgQNHyVpeMi8oHSGEPai23qo/e83q02lyckLPrX
        T2aBjU+tK7nr3j3PchGHGAwuWzle/KjLQ46EqR0=
X-Google-Smtp-Source: ABdhPJzEG0UR+chB5QWlfmw9cC9V6pcu33y+aOEvtTVVQ7mApV/cGyTeZc2l3I6xVIYswFBpBdG3KSO0PXyAj/hFQ0w=
X-Received: by 2002:a81:9902:: with SMTP id q2mr3720198ywg.499.1643991146364;
 Fri, 04 Feb 2022 08:12:26 -0800 (PST)
MIME-Version: 1.0
References: <CAHmME9pO41uwYExSROc5X2+RE=a5tZfE=c=bAxVbhCHfa7=zSA@mail.gmail.com>
 <20220204155142.56419-1-Jason@zx2c4.com> <Yf1M3YGVq71oC9BM@linutronix.de>
In-Reply-To: <Yf1M3YGVq71oC9BM@linutronix.de>
From:   "Jason A. Donenfeld" <Jason@zx2c4.com>
Date:   Fri, 4 Feb 2022 17:12:15 +0100
X-Gmail-Original-Message-ID: <CAHmME9ocuYZeG4Eh2PC37wDAgbd8K4c80NpNadXbfrJ-NoGaqQ@mail.gmail.com>
Message-ID: <CAHmME9ocuYZeG4Eh2PC37wDAgbd8K4c80NpNadXbfrJ-NoGaqQ@mail.gmail.com>
Subject: Re: [PATCH v3] random: remove batched entropy locking
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

On Fri, Feb 4, 2022 at 4:57 PM Sebastian Andrzej Siewior
<bigeasy@linutronix.de> wrote:
> Does this compile and work?

It does, yes.

> From the looks of it, this should be:
>
>         local_lock_irqsave(&batched_entropy_u64.lock, flags);
>         batch = this_cpu_ptr(&batched_entropy_u64);

I wasn't aware you could reference percpu things statically like that
without going through the ptr helper. Anyway, I'll switch to yours, as
taking that lock prior seems better anyway.

>
> and we could do s/this_cpu_ptr/raw_cpu_ptr/

Ack.

Jason
