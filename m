Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 16A4B4984D6
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jan 2022 17:30:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243760AbiAXQaY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Jan 2022 11:30:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37348 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235823AbiAXQaX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Jan 2022 11:30:23 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E5E4C06173B;
        Mon, 24 Jan 2022 08:30:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=AQ8iAQxoE6ytF+vDFrokCpxGw0h35ubWAbr1H4KlCZk=; b=GkWKk5MO3hkd1HnISgbF7ooNBR
        4RNUi+xoxcafZ/O9RDriXwXYez46q8YDWD+KYT2a2YlaQ4o34q8LHnWWdjuSvBV7qXlmcwi4Xnzfh
        AplCatGByf/aoe6vZLJrqlHgSyakf0inb1yAb2riQxc/13Ij1ONNB62Vx37hIp665qmf3B1yiJ3kQ
        9eH6WiPqpGoaPt64wija5Ij+RfRFzjmu+zXo+5svhp3vYI4ClZj8UjKf4yBwlo2wOorpMrugXxMCK
        joGe4oYrYeYtKka+oECXSMiarrqodEdBTe+KbwJ67GRrTiCCGlNCtqNOloLvFH5WYOvUCyPPrBYbz
        XslWFLlg==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nC2EJ-000uZK-4t; Mon, 24 Jan 2022 16:30:07 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 0C6C03002C5;
        Mon, 24 Jan 2022 17:30:05 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id E6E402B54C625; Mon, 24 Jan 2022 17:30:04 +0100 (CET)
Date:   Mon, 24 Jan 2022 17:30:04 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     "Liang, Kan" <kan.liang@linux.intel.com>
Cc:     Kyle Huey <me@kylehuey.com>, linux-kernel@vger.kernel.org,
        linux-perf-users@vger.kernel.org, "H. Peter Anvin" <hpa@zytor.com>,
        x86@kernel.org, Dave Hansen <dave.hansen@linux.intel.com>,
        Borislav Petkov <bp@alien8.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        Namhyung Kim <namhyung@kernel.org>,
        Jiri Olsa <jolsa@redhat.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Ingo Molnar <mingo@redhat.com>,
        Robert O'Callahan <rocallahan@gmail.com>,
        Keno Fischer <keno@juliacomputing.com>,
        Andi Kleen <ak@linux.intel.com>
Subject: Re: [PATCH] x86/perf: Default freeze_on_smi on for Comet Lake and
 later.
Message-ID: <Ye7UDFAV5/OPaE5N@hirez.programming.kicks-ass.net>
References: <20220122072644.92292-1-khuey@kylehuey.com>
 <Ye6Z31keWVPrsNWU@hirez.programming.kicks-ass.net>
 <3c35dc76-c187-8d3f-7fc9-75de32e7cbf6@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3c35dc76-c187-8d3f-7fc9-75de32e7cbf6@linux.intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 24, 2022 at 11:00:56AM -0500, Liang, Kan wrote:
> 
> 
> On 1/24/2022 7:21 AM, Peter Zijlstra wrote:
> > On Fri, Jan 21, 2022 at 11:26:44PM -0800, Kyle Huey wrote:
> > > Beginning in Comet Lake, Intel extended the concept of privilege rings to
> > > SMM.[0] A side effect of this is that events caused by execution of code
> > > in SMM are now visible to performance counters with IA32_PERFEVTSELx.USR
> > > set.
> > > 
> > > rr[1] depends on exact counts of performance events for the user space
> > > tracee, so this change in behavior is fatal for us. It is, however, easily
> > > corrected by setting IA32_DEBUGCTL.FREEZE_WHILE_SMM to 1 (visible in sysfs
> > > as /sys/devices/cpu/freeze_on_smi). While we can and will tell our users to
> > > set freeze_on_smi manually when appropriate, because observing events in
> > > SMM is rarely useful to anyone, we propose to change the default value of
> > > this switch.
> 
> + Andi
> 
> From we heard many times from sophisticated customers, they really hate
> blind spots. They want to see everything. That's why we set freeze_on_smi to
> 0 as default. I think the patch breaks the principle.

Well, USR really, as in *REALLY* should not be counting SMM. That's just
plain broken.

There's maybe an argument to include it in OS, but USR is ring-3.
