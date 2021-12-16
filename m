Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2BC6E47730E
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Dec 2021 14:23:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237492AbhLPNXj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Dec 2021 08:23:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56066 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232110AbhLPNXi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Dec 2021 08:23:38 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 12246C061574;
        Thu, 16 Dec 2021 05:23:38 -0800 (PST)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1639661016;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=uHDlt/HgQV9SB/CETbsCPHdj+DyjQBUg5mN4biUJiq0=;
        b=uS8VK2zstKjBJALe5V5SLqq17N7d8WeWhQ31xBbSrV6xW9TiccgvBu0RtOepEIhr8VYNoj
        TO35K1pXGBFr8rwTNvCZKzJRvWC2FIvOaLeTlkltwMe5PKrUiGbwGRc9G8Uoa3zrGTiKFz
        pdLDXRvC8Vo5xii75fR5IsqbjlD5WgBGSMS7MRmS7MB+7QXlROkfV0BVl5PA4BHARARdp+
        C6ewhfJNGGkkb06EGhxNPFxJQ3Xi1EmOdpCOuKiy67nak5d131yHh9lrmmi8il95Qpyr1o
        WCsWZ96VfNK/ozy+2Np2cYyQBRqytABHImgOjuvuOSyXLFsIfXpjkIr+kUAUYQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1639661016;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=uHDlt/HgQV9SB/CETbsCPHdj+DyjQBUg5mN4biUJiq0=;
        b=lTbaVuGdSjicH5fAaadv8EWyCHPRMVu8kQRTNDafztc59q4IXBgfpI4G4ChcA6TolZv42L
        KF8M5eVZp7cGuzAQ==
To:     Peter Oskolkov <posk@google.com>,
        Peter Zijlstra <peterz@infradead.org>
Cc:     Peter Oskolkov <posk@posk.io>, Ingo Molnar <mingo@redhat.com>,
        juri.lelli@redhat.com,
        Vincent Guittot <vincent.guittot@linaro.org>,
        dietmar.eggemann@arm.com, Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, mgorman@suse.de,
        bristot@redhat.com,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Memory Management List <linux-mm@kvack.org>,
        linux-api@vger.kernel.org, x86@kernel.org,
        Paul Turner <pjt@google.com>, Andrei Vagin <avagin@google.com>,
        Jann Horn <jannh@google.com>,
        Thierry Delisle <tdelisle@uwaterloo.ca>
Subject: Re: [RFC][PATCH 0/3] sched: User Managed Concurrency Groups
In-Reply-To: <CAPNVh5cfoehYpOu2PE59L3_yxmZaXgJ6oC1eg923rmaiK4f87A@mail.gmail.com>
References: <20211214204445.665580974@infradead.org>
 <CAFTs51XRJj1pwF6q5hwdGP0jtXmY81QQmTzyuA26fHMH0zCymw@mail.gmail.com>
 <Ybm+HJzkO/0BB4Va@hirez.programming.kicks-ass.net>
 <CAFTs51Xb6m=htpWsVk577n-h_pRCpqRcBg6-OhBav8OadikHkw@mail.gmail.com>
 <YboxjUM+D9Kg52mO@hirez.programming.kicks-ass.net>
 <CAPNVh5cJy2y+sTx0cPA1BPSAg=GjXC8XGT7fLzHwzvXH2=xjmw@mail.gmail.com>
 <20211215222524.GH16608@worktop.programming.kicks-ass.net>
 <CAPNVh5cfoehYpOu2PE59L3_yxmZaXgJ6oC1eg923rmaiK4f87A@mail.gmail.com>
Date:   Thu, 16 Dec 2021 14:23:36 +0100
Message-ID: <875yrolm3r.ffs@tglx>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Peter,

On Wed, Dec 15 2021 at 15:26, Peter Oskolkov wrote:
> On Wed, Dec 15, 2021 at 2:25 PM Peter Zijlstra <peterz@infradead.org> wrote:
>> > - take a userspace (spin) lock (so the steps below are all within a
>> > single critical section):
>>
>> Don't ever suggest userspace spinlocks, they're horrible crap.
>
> This can easily be a mutex, not really important (although for very
> short critical sections with only memory reads/writes, like here, spin
> locks often perform better, in our experience).

Performance may be better, but user space spinlocks have a fundamental
problem: They are prone to live locks.

That's completely independent of the length of the critical section, it
even can be empty.

There are ways to avoid that, but that needs a very careful design on
the application/library level and at the system configuration level
(priorities, affinities ...). And even then, there are trival ways to
break that, e.g. via CPU hotplug.

So no, for something of general use, they are a complete NONO. People
who think they know what they are doing have the source and can replace
them if they feel the need to do so.

Thanks,

        tglx

