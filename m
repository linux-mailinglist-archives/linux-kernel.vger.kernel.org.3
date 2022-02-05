Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B788E4AA8D7
	for <lists+linux-kernel@lfdr.de>; Sat,  5 Feb 2022 13:51:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379864AbiBEMvC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 5 Feb 2022 07:51:02 -0500
Received: from ams.source.kernel.org ([145.40.68.75]:49366 "EHLO
        ams.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233550AbiBEMvA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 5 Feb 2022 07:51:00 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 6DAB0B80B86
        for <linux-kernel@vger.kernel.org>; Sat,  5 Feb 2022 12:50:59 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F2A95C340EF
        for <linux-kernel@vger.kernel.org>; Sat,  5 Feb 2022 12:50:57 +0000 (UTC)
Authentication-Results: smtp.kernel.org;
        dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="NYo4uMSI"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zx2c4.com; s=20210105;
        t=1644065455;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Tg5AZLGIn8MkxSEe8OP8pxy3cet7YfAGJEuYNNSj2ag=;
        b=NYo4uMSINmznCkqPshn0vT03tToNit1LebywaOZwOcDXi4VOaoVa67OXgiZ2EpFqJctNbe
        nFK6FTW57XvqMFli2DRf6QliK+5IrCguu9w9GHHXYmvvkzTG+qeCWRYNoZiyG+L8Ex4L2B
        fH465alzoYpWA9LpqrOcPLvwsljwIWo=
Received: by mail.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id a9c7c32a (TLSv1.3:AEAD-AES256-GCM-SHA384:256:NO)
        for <linux-kernel@vger.kernel.org>;
        Sat, 5 Feb 2022 12:50:54 +0000 (UTC)
Received: by mail-yb1-f173.google.com with SMTP id y6so11968475ybc.5
        for <linux-kernel@vger.kernel.org>; Sat, 05 Feb 2022 04:50:54 -0800 (PST)
X-Gm-Message-State: AOAM530aNUXeFAzPk4yLw3MVLj02vk+G0luBs6il8cj+4roFQFC2za30
        m/ZrYMANRsXziZG/LUN/Ysv8zqaDNIzmUdPM2+I=
X-Google-Smtp-Source: ABdhPJxRJYyFqIQ+/7wkFybJYNx2lJVXfFzo5dXU0TDpaZbqOZWeZ+rJEAdNJytgQOB0pJl21mKR5EjHCFazS6wtYUE=
X-Received: by 2002:a81:1b54:: with SMTP id b81mr3479295ywb.404.1644065453446;
 Sat, 05 Feb 2022 04:50:53 -0800 (PST)
MIME-Version: 1.0
References: <YfgPWatDzkn2ozhm@linutronix.de> <20220204153149.51428-1-Jason@zx2c4.com>
 <Yf2Q25T04cAxJY3H@linutronix.de> <Yf320i+tVl6MXnD7@sultan-box.localdomain>
In-Reply-To: <Yf320i+tVl6MXnD7@sultan-box.localdomain>
From:   "Jason A. Donenfeld" <Jason@zx2c4.com>
Date:   Sat, 5 Feb 2022 13:50:42 +0100
X-Gmail-Original-Message-ID: <CAHmME9q1bdSeX5Eu+sNfJkch+odKTWFZ53Jo-ma98SDqouEF6w@mail.gmail.com>
Message-ID: <CAHmME9q1bdSeX5Eu+sNfJkch+odKTWFZ53Jo-ma98SDqouEF6w@mail.gmail.com>
Subject: Re: [PATCH RFC v1] random: do not take spinlocks in irq handler
To:     Sultan Alsawaf <sultan@kerneltoast.com>
Cc:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        LKML <linux-kernel@vger.kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>,
        "Theodore Ts'o" <tytso@mit.edu>,
        =?UTF-8?Q?Jonathan_Neusch=C3=A4fer?= <j.neuschaefer@gmx.net>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Sultan,

On Sat, Feb 5, 2022 at 5:02 AM Sultan Alsawaf <sultan@kerneltoast.com> wrote:
> The __this_cpu_{ATOMIC_OP}() functions are for atomically performing a single
> per-CPU operation for the current CPU from contexts that permit CPU migration.
> Since this code is safe from CPU migrations (add_interrupt_randomness() runs in
> hardirq context), the atomic per-CPU helpers are unneeded. Instead of using
> __this_cpu_inc_return() and __this_cpu_or(), we can operate on the per-CPU
> pointer directly without any extra safety (e.g., `++fast_pool->count` can be
> used in place of `__this_cpu_inc_return(irq_randomness.count)`).

Oh, right, thanks. We're already in irq so we don't have to worried
about load,add,store being cut up in any way. I'll go back to simple
increments for v3.

Jason
