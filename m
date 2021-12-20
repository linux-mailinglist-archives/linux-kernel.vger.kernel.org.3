Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9347047A77C
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Dec 2021 10:55:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230263AbhLTJzV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Dec 2021 04:55:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50782 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230251AbhLTJzU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Dec 2021 04:55:20 -0500
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EBC00C061574
        for <linux-kernel@vger.kernel.org>; Mon, 20 Dec 2021 01:55:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=BRrPof0mppY9AQ3Ugp9hmxTDBOGMRDNQoYQFln1TEsY=; b=QsjVouksXk4fJ2jHz5DN0/buWz
        Mq7SGfQI7nk0jvzO+dSwkslGcNA2hD/evDf4k3LI2JM3fE8ZFStGUxwBjSXDB/TBUMiqNVcT0zg3h
        k2OHxMPrDuJiN4o2gx6W2iYvNNc9kg6zKg7hJ5CiJMDYQ3NnLsXqFXDQlDwk3WJD8bSak5xHpOiOc
        PJXNPL5cuEopRsjDY9/oHe/edmJLUE3TrVBpjrV0VreaeUUsst/e45UJwCoGukG8RfOCdQKO6iYnP
        dluOzQK7oM+NZfvOJsagFvFBvU79npNM2AbCr7O/SlIbO2b4XWhwZkzQSvvwsFu7dxPVqmyfQlykm
        01B+/rFA==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mzFNg-002TNm-8r; Mon, 20 Dec 2021 09:54:56 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 77C3830003C;
        Mon, 20 Dec 2021 10:54:55 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 566812C9B91DE; Mon, 20 Dec 2021 10:54:55 +0100 (CET)
Date:   Mon, 20 Dec 2021 10:54:55 +0100
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
Message-ID: <YcBS75PpjOujBTUe@hirez.programming.kicks-ass.net>
References: <20211205224843.1503081-1-namhyung@kernel.org>
 <YbHn6JaaOo3b5GLO@hirez.programming.kicks-ass.net>
 <CAM9d7ciJTJB1rumzmxGeJrAdeE9R4eXhtJRUQGj9y6DBN-ovig@mail.gmail.com>
 <20211210103341.GS16608@worktop.programming.kicks-ass.net>
 <Yby8Su+fVA1lqVjT@hirez.programming.kicks-ass.net>
 <7A415BC0-E6F2-4ED2-8996-8F5871ED8001@fb.com>
 <YcBNOsMG3aGVpnWK@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YcBNOsMG3aGVpnWK@hirez.programming.kicks-ass.net>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 20, 2021 at 10:30:34AM +0100, Peter Zijlstra wrote:
> On Sat, Dec 18, 2021 at 09:09:05AM +0000, Song Liu wrote:

> > Unfortunately, this change bring the bug back. For time_enabled in rdpmc
> > case to work properly, we have to touch all the enabled but not running 
> > events, right?
> 
> Ohh.. argh. I think I see why, it looses the context time enable edge,
> and because this is all strictly per-event in the uapi (there is no ctx
> representation) it can't be cured by improving ctx time handling :/
> 
> Bah, I so hate this.

For now I've added this then ...

+/*
+ * Because the userpage is strictly per-event (there is no concept of context,
+ * so there cannot be a context indirection), every userpage must be updated
+ * when context time starts :-(
+ *
+ * IOW, we must not miss EVENT_TIME edges.
+ */
 static inline bool event_update_userpage(struct perf_event *event)


But that same is not true for perf_event_read_local(), that *has* access
to the context and so must be able to DTRT.
