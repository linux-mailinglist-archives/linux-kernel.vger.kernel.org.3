Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7341F49DEBC
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jan 2022 11:07:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238932AbiA0KHa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Jan 2022 05:07:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43490 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231903AbiA0KH3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jan 2022 05:07:29 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C4A26C061714;
        Thu, 27 Jan 2022 02:07:28 -0800 (PST)
Date:   Thu, 27 Jan 2022 11:07:25 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1643278047;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=BYR/PyGx3Is3z5vyQ7uQWePnywgy3STS2Zjh/6oWB0g=;
        b=3+jlgIGZnwa7n1WXDDDEEw2Ii2QECYNqe0NSkpNOyQa0ccXogPSRQVQlY0JP9w/VOOLbY3
        XO4sO6UZGNagabhsBj4oKGt/QOAeK6eQ89GS/GEiC6CvsSursMfYyvzfl3fHOZ3fcYd/iE
        /yVypAZLNeNcJLH7bd2g2JiwD8d/IOKyovEg8LuO933QoPh9y9jFUE6NvcU7XjxMuBPIHy
        gDLKJlxyvw0iuTk1nWJxwDw/byAdRbSXMli6CDm43Ank0LGP1a6DmxdbFiwHw6q0MrvQ7v
        IPdJouVa3nk0AUmrUgD4A8m5UX3ygaOT9gMH16Pkk8F0G+3YJm9ZdW3IsS5xow==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1643278047;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=BYR/PyGx3Is3z5vyQ7uQWePnywgy3STS2Zjh/6oWB0g=;
        b=5zGFD1PQXG0Ly0F6dyiuD/oNCcrKyXOQdoSoXU26xwYejsI2F9UnIvYnCJJyiruCS3gzBE
        U1LW0uCPDzDycSAQ==
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     Valentin Schneider <valentin.schneider@arm.com>
Cc:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        rcu@vger.kernel.org, linux-rt-users@vger.kernel.org,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Steven Rostedt <rostedt@goodmis.org>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Frederic Weisbecker <frederic@kernel.org>,
        Josh Triplett <josh@joshtriplett.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Davidlohr Bueso <dave@stgolabs.net>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Joel Fernandes <joel@joelfernandes.org>,
        Anshuman Khandual <anshuman.khandual@arm.com>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        Steven Price <steven.price@arm.com>,
        Ard Biesheuvel <ardb@kernel.org>,
        Boqun Feng <boqun.feng@gmail.com>,
        Mike Galbraith <efault@gmx.de>
Subject: Re: [PATCH v3 2/4] sched: Introduce migratable()
Message-ID: <YfJu3Z9wKOAjLuad@linutronix.de>
References: <20210811201354.1976839-1-valentin.schneider@arm.com>
 <20210811201354.1976839-3-valentin.schneider@arm.com>
 <20210817170925.2jwqvgvmqab2glwu@linutronix.de>
 <87czq573et.mognet@arm.com>
 <YfF9I5PcZJA5532B@linutronix.de>
 <87r18u2wr8.mognet@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <87r18u2wr8.mognet@arm.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2022-01-26 18:10:51 [+0000], Valentin Schneider wrote:
> > | 2021-08-11 21:13 +0100 Valentin Schneider    =E2=88=99 sched: Introdu=
ce migratable()
> > | 2021-08-11 21:13 +0100 Valentin Schneider    =E2=88=99 arm64: mm: Mak=
e arch_faults_on_old_pte() check for migratability
=E2=80=A6
> Heh, had forgotten about those - I'm happy to repost with the
> s/migratable/is_migratable/. I also need to go back to those splats I got
> on my emag and fix the PMU/GPIO warnings...

Now that I look at it gain, you might want to drop #1 and then #2 would
switch to cant_migrate(). This might work=E2=80=A6

Sebastian
