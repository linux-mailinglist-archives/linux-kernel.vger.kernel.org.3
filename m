Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A7B9948E81B
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jan 2022 11:11:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239765AbiANKLO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Jan 2022 05:11:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47808 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237136AbiANKLN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Jan 2022 05:11:13 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE7ADC061574
        for <linux-kernel@vger.kernel.org>; Fri, 14 Jan 2022 02:11:12 -0800 (PST)
Date:   Fri, 14 Jan 2022 11:11:08 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1642155069;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=YBAR5NIOmDf5qnKD4hyx2TjuDLy6wB12BZmUQJP6zjw=;
        b=UCYoq6ccuuMeZABCE0o+MnwZbR793beYJKBMXlZAjYS1hhEF4MOJX04KjcGOXEAXRvU8PG
        hJgwI67gWczHRbfRSTxTHEkFXqivSL6tInvZWwL9vGjoB2qFbCyzHx/5TfJ3SPL7dJZwo3
        tGSZmko3qXuMEl0G0su3fVVD3+HY7jq58degQRqrOoC5r8qxVT//0ZKSsMQ2MVn6YjSHbx
        9hPffC7CNnQiQ8aUTkqry6qm0KO1MyM6AAyMftOYRtxANkXr3L8IJCbvuRzDHZPLnUSgCO
        V4khVjUNhKM5DdacTyzLh+ojN0uginicwSf2Q9G26GA+u+LckKHYuE5CryYrwA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1642155069;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=YBAR5NIOmDf5qnKD4hyx2TjuDLy6wB12BZmUQJP6zjw=;
        b=talrS41lrsvYiSxhxLRvilcCgKLvUf3Se8wxYf5u5WHRsjrK9ZeYIUudlR7mBSWPhv7A1t
        lN542WSdmyDJv0DA==
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     Valentin Schneider <valentin.schneider@arm.com>
Cc:     linux-kernel@vger.kernel.org,
        Abhijeet Dharmapurikar <adharmap@quicinc.com>,
        Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Juri Lelli <juri.lelli@redhat.com>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Kees Cook <keescook@chromium.org>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [RFC PATCH 2/2] sched/tracing: Add TASK_RTLOCK_WAIT to
 TASK_REPORT
Message-ID: <YeFMPNnCpiw9fs7e@linutronix.de>
References: <20211129123601.2101873-1-valentin.schneider@arm.com>
 <20211129123601.2101873-3-valentin.schneider@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20211129123601.2101873-3-valentin.schneider@arm.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2021-11-29 12:36:01 [+0000], Valentin Schneider wrote:
> TASK_RTLOCK_WAIT currently isn't part of TASK_REPORT, thus a task blocking
> on an rtlock will appear as having a task state == 0, IOW TASK_RUNNING.
> 
> The actual state is saved in p->saved_state, but reading it after reading
> p->__state has a few issues:
> o that could still be TASK_RUNNING in the case of e.g. rt_spin_lock
> o ttwu_state_match() might have changed that to TASK_RUNNING
> 
> Add TASK_RTLOCK_WAIT to TASK_REPORT.
> 
> Signed-off-by: Valentin Schneider <valentin.schneider@arm.com>

We used to have the D state which was used in the locked case and was
sufficient. With the rework to TASK_RTLOCK_WAIT (which made other things
easier) we lost that. It makes debuging/ looking into the system more
obvious or does not hide things so why not.

Reviewed-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>

Sebastian
