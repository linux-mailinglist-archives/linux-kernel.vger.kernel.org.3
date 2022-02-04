Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0168B4A96D6
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Feb 2022 10:31:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349272AbiBDJbw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Feb 2022 04:31:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34640 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1358880AbiBDJbK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Feb 2022 04:31:10 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A7804C0613BC;
        Fri,  4 Feb 2022 01:29:31 -0800 (PST)
Date:   Fri, 4 Feb 2022 10:29:28 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1643966970;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=/eecWjACA0rGMqqEQiDgokZRkG3UepJI5ulPZyG6uO0=;
        b=Kq3E210trmVV3cpVxMoJ0wqgmkAoAXew8RuSZaqcds1os6QjXpnmgz46wHdKI0PVoeoWZV
        S0i2vVf5tU2o0cky+cRkS34UDv2oxDo/kALrSY0PIvSbz0SfT2q1i0OuOKP2X/GtSi7YNC
        raKGH932Jo7zHOOEZuNzw1BjC07lIKJf2tWut7tH745ktB3dAvF65AyZjPH9WkQxw8nvZj
        oC40ZFV22BsIVWWo4yhtDaq1eiuKbpaCExsHNWl9OqyUKV3qGDVwwqdhaFBA1fO+ToGLCy
        hl+yYD+Rauk/817C+r5UA0EX6NwVqjr1kxa1b/a3wlH/ASxRRKLe5AlPfrm8FQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1643966970;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=/eecWjACA0rGMqqEQiDgokZRkG3UepJI5ulPZyG6uO0=;
        b=veSy3hJgJZREMiqCtupWodV6mbWqNkewKhr9cAPLZVdJcH2E4cDVZfPvx95cF/mzB5uDPC
        ezydNgc5y/tjroCw==
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     Valentin Schneider <valentin.schneider@arm.com>
Cc:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-rt-users@vger.kernel.org,
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
Subject: Re: [PATCH v4] arm64: mm: Make arch_faults_on_old_pte() check for
 migratability
Message-ID: <Yfzx+P3jUXA0Z/Y7@linutronix.de>
References: <20220127192437.1192957-1-valentin.schneider@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20220127192437.1192957-1-valentin.schneider@arm.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2022-01-27 19:24:37 [+0000], Valentin Schneider wrote:
> arch_faults_on_old_pte() relies on the calling context being
> non-preemptible. CONFIG_PREEMPT_RT turns the PTE lock into a sleepable
> spinlock, which doesn't disable preemption once acquired, triggering the
> warning in arch_faults_on_old_pte().
> 
> It does however disable migration, ensuring the task remains on the same
> CPU during the entirety of the critical section, making the read of
> cpu_has_hw_af() safe and stable.
> 
> Make arch_faults_on_old_pte() check cant_migrate() instead of preemptible().
> 
> Suggested-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
> Signed-off-by: Valentin Schneider <valentin.schneider@arm.com>
> Link: https://lore.kernel.org/r/20210811201354.1976839-5-valentin.schneider@arm.com

Let me pick that up so I can drop the other two. I hope the ARM64 folks
follow my lead ;)

Acked-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>

Sebastian
