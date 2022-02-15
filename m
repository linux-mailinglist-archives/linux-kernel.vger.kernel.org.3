Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2E4DF4B77F7
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Feb 2022 21:51:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242186AbiBOTdZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Feb 2022 14:33:25 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:34234 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233812AbiBOTdW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Feb 2022 14:33:22 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 130DBB7C72;
        Tue, 15 Feb 2022 11:33:11 -0800 (PST)
From:   John Ogness <john.ogness@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1644953589;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=6PgsBMBaD1VL/blQ9NGFYKVy9dzfRCvZ4SmB2o7/hv0=;
        b=C3LVhzk8ug+ZT17S1HvaW+HMsdFerPa+zBeWUuRyzN32pFYEcihEuz8evEnCqtZravA1s7
        MMNQT+e5oWjqZpC8QGpUKW0FYaNNbQMAnsCwNDpygvIX/CCEor4ZJ/Y0LYYWipNWTvbFi+
        0E3pVP0SRbOqJGZEZvQ7nvUB1HjEPtxiYhKLXKRHSI4oKsX5LHYZMJE3BlTt6Sih1O6uMb
        7WoU+QR8Ucwsa5b9oN73B9yyS0zJBNtTDN7YgTcyg2htWlacWz9ffG9ZsU875Xy1g/mAV7
        GmNZC/BmfRZsTTS0GsItNoNbr0OZXEb/X/vVNq12daUUyzq8d6IfudbyoSti2A==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1644953589;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=6PgsBMBaD1VL/blQ9NGFYKVy9dzfRCvZ4SmB2o7/hv0=;
        b=r8YVCNMtnNMWlKQh6mpyzy8Lii7Hxnfat9/Yy8v7nrBFS8ZHA5jEZayKmaX1yiHQl0KEqQ
        E9128Mys8LAY+JDw==
To:     Daniel Bristot de Oliveira <bristot@kernel.org>,
        Shuah Khan <skhan@linuxfoundation.org>,
        Steven Rostedt <rostedt@goodmis.org>
Cc:     Jonathan Corbet <corbet@lwn.net>, Ingo Molnar <mingo@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Will Deacon <will@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Marco Elver <elver@google.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Gabriele Paoloni <gpaoloni@redhat.com>,
        Juri Lelli <juri.lelli@redhat.com>,
        Clark Williams <williams@redhat.com>,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-trace-devel@vger.kernel.org
Subject: Re: [RFC V2 12/21] rv/reactor: Add the printk reactor
In-Reply-To: <65172f14-bad6-37b1-d243-e91ca472d22e@kernel.org>
References: <cover.1644830251.git.bristot@kernel.org>
 <fad2d358d57dfffc084d482684ecc1d13b62b262.1644830251.git.bristot@kernel.org>
 <10cf6003-6d2b-056b-11bb-3ae9c342a369@linuxfoundation.org>
 <c1657d1c-0d2b-4aa3-c1ed-2ae6fdfcda86@kernel.org>
 <87v8xg30qc.fsf@jogness.linutronix.de>
 <45179cdb-2391-207a-2f7b-2dea828d1606@kernel.org>
 <87r1842r1m.fsf@jogness.linutronix.de>
 <65172f14-bad6-37b1-d243-e91ca472d22e@kernel.org>
Date:   Tue, 15 Feb 2022 20:39:08 +0106
Message-ID: <874k50hqmj.fsf@jogness.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-3.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,INVALID_DATE_TZ_ABSURD,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2022-02-15, Daniel Bristot de Oliveira <bristot@kernel.org> wrote:
> I am aware of printk_deferred(), and every once and while I am Cc'ed
> on patches suggesting changing printk() to printk_deferred(), but they
> are not, let's say, welcome [1]... that is why I am not using it.

Yes. printk_deferred() is a workaround until we can get printk
"PROVE_RAW_LOCK_NESTING clean". But currently there is real deadlock
potential in the kernel with printk. For the most common cases, we use
printk_deferred() to get around it. Once printk() is clean, we can
replace all printk_deferred() call sites with printk().

I haven't looked into the details of your runtime verification method,
but I assume it digs deep into some interfaces. In that case, the
deadlock potential of printk may be relatively high. (And indeed, you
have seen some.) IMHO, before warning users not to use this reactor if
locks XYZ are taken, it would be better just to use printk_deferred()
and it will always log without causing problems to the system you are
trying to verify.

> I saw deadlocks in the past, and while testing the WIP monitor some
> time ago, it seems it depends on the console type. If such restriction
> does not exist anymore, I can remove that comment, it would be even
> better!

If you say it depended on the console type, then it was probably the
framebuffer console that was at fault. The fbcon is a landmine for
deadlocks, which is why PREEMPT_RT avoids fbcon printing from
non-preemptible context. For mainline, the series is currently in
review.

Perhaps avoiding fbcon would be good enough for you to avoid deadlocks
with this reactor using printk().

John

> [1]  https://lore.kernel.org/lkml/e68888438cec9a1da53aaa1647720ade638d6ad4.1600705105.git.bristot@redhat.com/
