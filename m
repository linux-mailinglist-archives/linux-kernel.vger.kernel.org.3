Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 903E247A707
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Dec 2021 10:31:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230182AbhLTJa6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Dec 2021 04:30:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45066 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229550AbhLTJa5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Dec 2021 04:30:57 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7CF83C061574
        for <linux-kernel@vger.kernel.org>; Mon, 20 Dec 2021 01:30:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=vQ/+G+wMkNfXl75KOzcYvN1wxxQzG2BQjplN5zLRrOM=; b=q0rb2yfnDBauZA3s8qPD/AU6Hg
        zgmsGSLpJi0x7gObxMn/GPm7u9CFyPHSmOrnPHf0dx8t5kflpdhHiccNi62ltEJDCrVCdarqMBe/H
        s6sl6yRUJ/cdld3rtpkX/F9sqbY7IGT3OIBUJWvIXDkZmfv9LvAGSaoAkRJ96Swu0DVClR4ID+yHq
        fOYdLVQYqri82Ob4t8ShmPgtCsNuOqxBmjR6fxaFPPbo1agFFe3FlrvbWxaiGyeZ6e23cDZziqY0F
        uN8606zH+OPyQaAojb10UQnRzIDeQRfIugAnBSKArCQa1mVJ/ONtgUl92bo4kgk3+xG7Z9tkjQMav
        09y2VRrA==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mzF07-001QdY-Is; Mon, 20 Dec 2021 09:30:35 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 40E3B3002AE;
        Mon, 20 Dec 2021 10:30:34 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 1480E2019D9B6; Mon, 20 Dec 2021 10:30:34 +0100 (CET)
Date:   Mon, 20 Dec 2021 10:30:34 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Song Liu <songliubraving@fb.com>
Cc:     Namhyung Kim <namhyung@kernel.org>, Ingo Molnar <mingo@kernel.org>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Jiri Olsa <jolsa@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Stephane Eranian <eranian@google.com>,
        Andi Kleen <ak@linux.intel.com>,
        Ian Rogers <irogers@google.com>
Subject: Re: [PATCH v3] perf/core: Set event shadow time for inactive events
 too
Message-ID: <YcBNOsMG3aGVpnWK@hirez.programming.kicks-ass.net>
References: <20211205224843.1503081-1-namhyung@kernel.org>
 <YbHn6JaaOo3b5GLO@hirez.programming.kicks-ass.net>
 <CAM9d7ciJTJB1rumzmxGeJrAdeE9R4eXhtJRUQGj9y6DBN-ovig@mail.gmail.com>
 <20211210103341.GS16608@worktop.programming.kicks-ass.net>
 <Yby8Su+fVA1lqVjT@hirez.programming.kicks-ass.net>
 <7A415BC0-E6F2-4ED2-8996-8F5871ED8001@fb.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7A415BC0-E6F2-4ED2-8996-8F5871ED8001@fb.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Dec 18, 2021 at 09:09:05AM +0000, Song Liu wrote:
> 
> 
> > On Dec 17, 2021, at 8:35 AM, Peter Zijlstra <peterz@infradead.org> wrote:
> > 
> > On Fri, Dec 10, 2021 at 11:33:41AM +0100, Peter Zijlstra wrote:
> > 
> >> I'm thinking this is a cgroup specific thing. Normally the shadow_time
> >> thing is simply a relative displacement between event-time and the
> >> global clock. That displacement never changes, except when you do
> >> IOC_DISABLE/IOC_ENABLE.
> >> 
> >> However, for cgroup things are different, since the cgroup events aren't
> >> unconditionally runnable, that is, the enabled time should only count
> >> when the cgroup is active, right?
> >> 
> >> So perhaps perf_event_read_local() should use a cgroup clock instead of
> >> perf_clock() for cgroup events.
> >> 
> >> Let me think about that some more...
> > 
> > How's this then? Song, could you also please test and or better explain
> > the problem f79256532682 pretends to cure? Because the below is
> > reverting that, I *really* hate having to touch the events we're not
> > scheduling.
> 
> Unfortunately, this change bring the bug back. For time_enabled in rdpmc
> case to work properly, we have to touch all the enabled but not running 
> events, right?

Ohh.. argh. I think I see why, it looses the context time enable edge,
and because this is all strictly per-event in the uapi (there is no ctx
representation) it can't be cured by improving ctx time handling :/

Bah, I so hate this.

