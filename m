Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E3CE54D5D95
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Mar 2022 09:36:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234503AbiCKIg6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Mar 2022 03:36:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58536 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233180AbiCKIg4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Mar 2022 03:36:56 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3B7B31BA14B
        for <linux-kernel@vger.kernel.org>; Fri, 11 Mar 2022 00:35:53 -0800 (PST)
Date:   Fri, 11 Mar 2022 09:35:49 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1646987751;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=09zv/YWqFmnjIad7bvkoBTRQjQofFPvijtp9CNjGK5g=;
        b=d5iJPaGnk8plhhGqLLUoqJ4w0i9Ja4ZTOiPnood3+vXz+tQM2+MJY1WToDvL/qzHycFaSh
        Eq9i0dYaAh1Ft81IOU3+lLrkwu6jbWNtSIVE8y2S1C2TuhBNiirkmY/MICwQTER5TXSgYv
        TlTbdr4QVwa0KH7gtGiQQBVavpdf7kfBNDVJsbEGS9pupdfZiKgXty2aU903IMCTsi+HP4
        r+cVtQwHnkAb4W2ywGIAwfbRMsTrCWaixVhJWk0exMbR68p+KyrMDZQ/umbC80GmqwMbk8
        vmVcCyG9tQOenxwelL6T0jfk/sPNkUvBC2st1ImTzBZ+DcLiSWtuE83ZVaVArw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1646987751;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=09zv/YWqFmnjIad7bvkoBTRQjQofFPvijtp9CNjGK5g=;
        b=lMU2R1KI6O6Y97Z5G2ihSkHYEvM8XSW82A9fhyOz4RCLWmuOEddNSo0OvBAgR6Hm4t6X78
        64kHuJGzqk2mKSBQ==
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Marcelo Tosatti <mtosatti@redhat.com>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Minchan Kim <minchan@kernel.org>,
        Matthew Wilcox <willy@infradead.org>,
        Mel Gorman <mgorman@techsingularity.net>,
        Nicolas Saenz Julienne <nsaenzju@redhat.com>,
        Juri Lelli <juri.lelli@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Daniel Bristot de Oliveira <bristot@redhat.com>
Subject: Re: [patch v5] mm: lru_cache_disable: replace work queue
 synchronization with synchronize_rcu
Message-ID: <YisJ5SLBijAbcwHD@linutronix.de>
References: <YhUI1wUtV8yguijO@fuller.cnet>
 <YhUKRzEKxMvlGQ5n@fuller.cnet>
 <YiI+a9gTr/UBCf0X@fuller.cnet>
 <20220304163554.8872fe5d5a9d634f7a2884f5@linux-foundation.org>
 <Yin7hDxdt0s/x+fp@fuller.cnet>
 <20220310182326.5b375da6b86e95f7e71acd90@linux-foundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20220310182326.5b375da6b86e95f7e71acd90@linux-foundation.org>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

+ sched division

On 2022-03-10 18:23:26 [-0800], Andrew Morton wrote:
> On Thu, 10 Mar 2022 10:22:12 -0300 Marcelo Tosatti <mtosatti@redhat.com> =
wrote:
> > On systems that run FIFO:1 applications that busy loop,
> > any SCHED_OTHER task that attempts to execute
> > on such a CPU (such as work threads) will not
> > be scheduled, which leads to system hangs.
=E2=80=A6
>=20
> Permitting a realtime thread to hang the entire system warrants a
> -stable backport, I think.  That's just rude.

I'm not sure if someone is not willingly breaking the system. Based on
my experience, a thread with an elevated priority (that FIFO, RR or DL)
should not hog the CPU. A normal user (!root && !CAP_SYS_NICE) can't
increase the priority of the task.
To avoid a system hangup there is sched_rt_runtime_us which ensures that
all RT threads are throttled once the RT class exceed a certain amount
of runtime. This has been relaxed a little on systems with more CPUs so
that the RT runtime can be shared but this sharing (RT_RUNTIME_SHARE)
has been disabled by default a while ago. That safe switch
(sched_rt_runtime_us) can be disabled and is usually disabled on RT
system since the RT tasks usually run longer especially in corner cases.

People often isolate CPUs and have busy-loop tasks running with
SCHED_OTHER given that there is nothing else going on there will be no
preemption. In this case, the worker would preempt the task.
In this scenario I _can_ understand that one wants to avoid that
preemption and try things differently like this patch suggests. We can
even offload RCU thread from isolated CPUs.
But I wouldn't say this requires a backport because there is way for a
RT thread, that claims 100% of the CPU, to break the system.

Sebastian
