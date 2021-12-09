Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 03B4046E791
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Dec 2021 12:26:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236680AbhLILaU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Dec 2021 06:30:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47826 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236023AbhLILaT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Dec 2021 06:30:19 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 532E7C0617A1
        for <linux-kernel@vger.kernel.org>; Thu,  9 Dec 2021 03:26:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=Oh50ewERJxuvrPXvyRdzaZU3xR9iIrsTQGftdFhjIjc=; b=Hr+h2Y9g3Q9a6xkNiCS8FpASx4
        4VaXLHWLQiN4d27HuYcdDJVpZ6zUQmHRGV8WN2e0lGROBPeNGIf/txcGUPlv/jh9MROyBqm0tfC4A
        1kpDtJJ/NtyiB0DcOqxGlBHBS4BGvw4qJhHM5k0FFFEpZEnD6PIEFH99kBtrDE7StTo3EAcKfDP2N
        JhvuLGVe9rpjaD2gmhJMQ0P0duS3wnkyZLI/qdGkgy4vYp/2YtBst9J8NOM35aJTSqXY2+NBe+Vzu
        z+fMYJ/B7mDO39CEDgTPlOqiujIH75M8S0r3ubQ9gl1sMRIpSG8lcEvr+yuh7FER6mVm7BbTQKIIA
        XwGVxqcw==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mvHZJ-009IHI-7c; Thu, 09 Dec 2021 11:26:34 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 7BD76300079;
        Thu,  9 Dec 2021 12:26:32 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 3E36E2BB95D7C; Thu,  9 Dec 2021 12:26:32 +0100 (CET)
Date:   Thu, 9 Dec 2021 12:26:32 +0100
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
Message-ID: <YbHn6JaaOo3b5GLO@hirez.programming.kicks-ass.net>
References: <20211205224843.1503081-1-namhyung@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211205224843.1503081-1-namhyung@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Dec 05, 2021 at 02:48:43PM -0800, Namhyung Kim wrote:

> Actually 18446744069443110306 is 0xffffffff01b345a2 so it seems to
> have a negative enabled time.  In fact, bperf keeps values returned by
> bpf_perf_event_read_value() which calls perf_event_read_local(), and
> accumulates delta between two calls.  When event->shadow_ctx_time is
> not set, it'd return invalid enabled time which is bigger than normal.

*that*, how does it happen that shadow_time isn't set? It should be last
set when the event switches to INACTIVE, no? At which point the logic in
perf_event_read_local() should make @enabled move forward while @running
stays put.

Let me go rummage around a bit... either I'm missing something obvious
or something's smelly.
