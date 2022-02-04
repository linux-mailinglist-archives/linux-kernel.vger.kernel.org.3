Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 82AAF4A966F
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Feb 2022 10:26:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1358226AbiBDJZ4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Feb 2022 04:25:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60986 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1357593AbiBDJYa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Feb 2022 04:24:30 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B7C4C061759;
        Fri,  4 Feb 2022 01:24:30 -0800 (PST)
Date:   Fri, 4 Feb 2022 10:24:25 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1643966667;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=A1OquCNeqBrmSz1l+c7aggW4kgLy2MKoprxou4C3Lds=;
        b=gPEs6AT/BsmdvBXVrkFPpf1gIUZh4ZepiJtkxEXOQI+h4zPxl7Ewut4c/sti4Cv6QvyLo5
        qQS7Fh9I25FxXiXjvgYtGUKqQtrAfEF7hcrC9g9ozeoAywRT+Vpboq77CsEaOq9WWEjsHC
        LLWAUEAeF53XOOX9GxzW4yKyW6oaGd6Bt9csn9kDqBo697qkM/Ceij65ZIVE1/b0EYvvI6
        p8cKl8q3WOIDwE7Lji6ZZBy6wpx2PYhUsHFnD5YbioKZEtHYD7HsssaRWTywavro8GuZPr
        SDVJHE6Xev9tPagiuDV0CyjqE1FyYdb598WpjE+3UPE18Ki807iB9om+B5MAKQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1643966667;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=A1OquCNeqBrmSz1l+c7aggW4kgLy2MKoprxou4C3Lds=;
        b=ohfrdA8XNt14v/qtvuGcHuIt9fP7Ul8cAktixgFJE1U1guZl3f9HoU+g3end07R64deWKT
        isP5+PQiTyB7CuCA==
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
Message-ID: <YfzwycgvDlVSGrB1@linutronix.de>
References: <20210811201354.1976839-1-valentin.schneider@arm.com>
 <20210811201354.1976839-3-valentin.schneider@arm.com>
 <20210817170925.2jwqvgvmqab2glwu@linutronix.de>
 <87czq573et.mognet@arm.com>
 <YfF9I5PcZJA5532B@linutronix.de>
 <87v8y5nflv.mognet@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <87v8y5nflv.mognet@arm.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2022-01-27 19:27:56 [+0000], Valentin Schneider wrote:

Sorry, got distracted.

> While I'm at it, I see you're still carrying
> 
>   6ab5bb09040d arm64/sve: Make kernel FPU protection RT friendly
> 
> If you're OK with it, I'll repost that:
> https://lore.kernel.org/lkml/20210722175157.1367122-1-valentin.schneider@arm.com/

I'm not too keen about preempt_enable_bh(). I would prefer the current
approach maybe with a comment why BH here and preemption there is
correct.
 
Sebastian
