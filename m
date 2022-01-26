Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2A98149D01B
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jan 2022 17:56:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243350AbiAZQ4I (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Jan 2022 11:56:08 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:58172 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232405AbiAZQ4G (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jan 2022 11:56:06 -0500
Date:   Wed, 26 Jan 2022 17:56:03 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1643216165;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=0L8WSSuR0odZJs+6WFfAZW0UhB7u98hCsghYO6wbK4s=;
        b=ijFxUU7WFv4kWnpX8Wgv8O8XPf8AszJUenXeuT20Ku8wHdLHRJs4z1uZUAAvLsW0dRv47L
        k1nNy9SsGo6iMATOrHKHVFIMSLT0bvg2D/m7ti9kny4pt35XeycWzd2VCMxDecO+cNgoLf
        10jTzRXtvMvl1cb4jSIde47Bs6Ijr5o49gjNm07N/W5s1zbw7vDk15UkjDgATIcQmCidee
        WhcB0U7o3gpXp3NGofEBPmwd77qOmJMulqyQB0Qrr1wvqI7miKAA9dRTIyFuh2/QMNsXp4
        X0S2eWmFyYZlI85WYLw08zAInP19yrkFt3KahfhKzcfFFZW0L/ZE0+U7Q/JsAA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1643216165;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=0L8WSSuR0odZJs+6WFfAZW0UhB7u98hCsghYO6wbK4s=;
        b=nd9g+7eSpH4nkdDkOGhgCCTGxokksgQ45bs5vi4p/Uzk5D6wf2zNlziw58OoLv73Vw0xu7
        zrbnnnoSgjywHJDQ==
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
Message-ID: <YfF9I5PcZJA5532B@linutronix.de>
References: <20210811201354.1976839-1-valentin.schneider@arm.com>
 <20210811201354.1976839-3-valentin.schneider@arm.com>
 <20210817170925.2jwqvgvmqab2glwu@linutronix.de>
 <87czq573et.mognet@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <87czq573et.mognet@arm.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2021-08-22 19:14:18 [+0100], Valentin Schneider wrote:
> Thanks for carrying it through, I'll keep that change for the next versio=
n.

Just a quick question. This series ended with 3 patches in my queue. It
got decimated further due to Frederic series which ended up in
v5.17-rc1. I still have
| 2021-08-11 21:13 +0100 Valentin Schneider    =E2=88=99 sched: Introduce m=
igratable()
| 2021-08-11 21:13 +0100 Valentin Schneider    =E2=88=99 arm64: mm: Make ar=
ch_faults_on_old_pte() check for migratability

what do we do about these two? I could repost these two if there are no
objections=E2=80=A6
=20
Sebastian
