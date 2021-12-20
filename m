Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CE36D47A752
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Dec 2021 10:40:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229903AbhLTJkB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Dec 2021 04:40:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47236 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229842AbhLTJkA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Dec 2021 04:40:00 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2BA06C061574
        for <linux-kernel@vger.kernel.org>; Mon, 20 Dec 2021 01:40:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=SCrJl+mA3XNgJT5wjfD3E6ACuMQWYHkEg7dcI0G+7BE=; b=lTwXfgKqPl5kgVY92j2hia4thA
        3qeBfW2DO+vyxdaHL6OYjRGTb6SV8qKEtTCvSS18KFlaWMp06e9xtbctVmyehkMGXi9WH//9Ap+po
        rHI1v6+zyXTYuq7ZH9/FJgCPtpmTrw1xQAeV5diN/a7Tc/SmDSEkWp3tlPL2XD/oYqjhe3mlQg2LC
        wxBfvEVkTsWl5iJueeELh18VOzFiRFHaFhjXUPaRQ6Q0YDMIJZtXku2SsqcPVGJfwa7XoN9uHmbVe
        Kp5p3uqjVYoadRx747bih2SBMbSMp8POcNh68TYNzqPZTfmRlhO3XcWIaEo5pPQSShsBS8zEqTUk4
        W84OOivg==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mzF93-001R3N-RF; Mon, 20 Dec 2021 09:39:49 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 6EF9E3002BE;
        Mon, 20 Dec 2021 10:39:49 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 302AA2C9B91DE; Mon, 20 Dec 2021 10:39:49 +0100 (CET)
Date:   Mon, 20 Dec 2021 10:39:49 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Namhyung Kim <namhyung@kernel.org>
Cc:     Ingo Molnar <mingo@kernel.org>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Jiri Olsa <jolsa@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Stephane Eranian <eranian@google.com>,
        Andi Kleen <ak@linux.intel.com>,
        Ian Rogers <irogers@google.com>,
        Song Liu <songliubraving@fb.com>
Subject: Re: [PATCH v3] perf/core: Set event shadow time for inactive events
 too
Message-ID: <YcBPZXtu0OOesleq@hirez.programming.kicks-ass.net>
References: <20211205224843.1503081-1-namhyung@kernel.org>
 <YbHn6JaaOo3b5GLO@hirez.programming.kicks-ass.net>
 <YbHp2MXmP1V5WE4B@hirez.programming.kicks-ass.net>
 <CAM9d7chMn7Gmc4FYn_ZjMiojUCao90e80Zg5+hNXQ7MTeHrK_A@mail.gmail.com>
 <20211210101950.GR16608@worktop.programming.kicks-ass.net>
 <CAM9d7cgugnvrv5CJPe_EP_M8pp8h+GsCCW3-RDmyrd+JDGYJrQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAM9d7cgugnvrv5CJPe_EP_M8pp8h+GsCCW3-RDmyrd+JDGYJrQ@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 10, 2021 at 10:59:49AM -0800, Namhyung Kim wrote:

> > You're doing that bpf-cgroup crud, right? Where exactly do you hook into
> > to do the counter reads?
> 
> That's true but it doesn't use cgroup events actually.  They are plain cpu
> events and BPF is called from a separate 'cgroup-switches' event to
> read out the counters.

Oh, right.

> > > Maybe because the event is enabled from the beginning.
> > > Then it might miss set_state/update_time at all.
> >
> > Even then, it's set to INACTIVE and any state change thereafter needs to
> > go through perf_event_set_state() and update the relevant timestamps.
> 
> Right, but the problem happens when you read the event *before*
> any state change.

But the per-cpu event should be the simplest case ever, the cpu context
is *always* active, enabled time always runs.
