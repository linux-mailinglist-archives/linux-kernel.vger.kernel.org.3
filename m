Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0DF534A5ADF
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Feb 2022 12:07:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237102AbiBALHd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Feb 2022 06:07:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35446 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236958AbiBALHc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Feb 2022 06:07:32 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5BC4DC061714;
        Tue,  1 Feb 2022 03:07:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=uLsDcxgkLM505bQLLfPdUrEH+ZZAWYgX9Yuu49ayqz0=; b=bGv32kesZbIyjhfnFra05FTj66
        aM5/UxXvuhlDWIf74twvb2SOrlyURwhda/InqRpU8CBPfiK+lL5GlZjSZ935X4IZTVHozGWSeRt1e
        M6e1GZb7Z86AATzXTaJQo93SWTFggI1dgmHqCa16K0mTmq3GqrvxiQPixwXuZIMQnDTH4rF960EqR
        NA+imUPqf97+SDWIZzf7BSQsDZawaO6QN80dkVCSt9HWoVQ3siXpBeM+xywbD/NJSG8WXQVIkmt4q
        c7vHzSv1WpW3Pcf+KS2y975B2rTGje73lVlPNEamPGSJMtrGfj7eCDnCRjxMEt8QL1dlzYSfF1B4X
        nkXI8BPA==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=worktop.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nEr0L-00C2ht-Gs; Tue, 01 Feb 2022 11:07:21 +0000
Received: by worktop.programming.kicks-ass.net (Postfix, from userid 1000)
        id CA91398623E; Tue,  1 Feb 2022 12:07:20 +0100 (CET)
Date:   Tue, 1 Feb 2022 12:07:20 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Dmitry Vyukov <dvyukov@google.com>
Cc:     Marco Elver <elver@google.com>, Ingo Molnar <mingo@kernel.org>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        linux-perf-users@vger.kernel.org, kasan-dev@googlegroups.com,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/3] perf: Copy perf_event_attr::sig_data on modification
Message-ID: <20220201110720.GU20638@worktop.programming.kicks-ass.net>
References: <20220131103407.1971678-1-elver@google.com>
 <CACT4Y+Zcg9Jf9p+RHWwKNDoCpfH-SBTzPpuQBBryyeopMONmEw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CACT4Y+Zcg9Jf9p+RHWwKNDoCpfH-SBTzPpuQBBryyeopMONmEw@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 01, 2022 at 08:32:45AM +0100, Dmitry Vyukov wrote:
> On Mon, 31 Jan 2022 at 11:34, Marco Elver <elver@google.com> wrote:
> >
> > The intent has always been that perf_event_attr::sig_data should also be
> > modifiable along with PERF_EVENT_IOC_MODIFY_ATTRIBUTES, because it is
> > observable by user space if SIGTRAP on events is requested.
> >
> > Currently only PERF_TYPE_BREAKPOINT is modifiable, and explicitly copies
> > relevant breakpoint-related attributes in hw_breakpoint_copy_attr().
> > This misses copying perf_event_attr::sig_data.
> >
> > Since sig_data is not specific to PERF_TYPE_BREAKPOINT, introduce a
> > helper to copy generic event-type-independent attributes on
> > modification.
> >
> > Fixes: 97ba62b27867 ("perf: Add support for SIGTRAP on perf events")
> > Reported-by: Dmitry Vyukov <dvyukov@google.com>
> > Signed-off-by: Marco Elver <elver@google.com>
> 
> Reviewed-by: Dmitry Vyukov <dvyukov@google.com>

Thanks guys! Queued for perf/urgent
