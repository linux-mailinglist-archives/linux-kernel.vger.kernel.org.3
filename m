Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 965C446FC44
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Dec 2021 09:04:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238128AbhLJIIQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Dec 2021 03:08:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50918 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238114AbhLJIIP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Dec 2021 03:08:15 -0500
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F319C061746;
        Fri, 10 Dec 2021 00:04:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=7L65AS+iimZqb2KNq4M1+cHyGgzNH5bSSF+sipkws9Q=; b=QgAue25EBlx6PiAjs8AnPi7N/X
        noz9jSlC5ezpQEgdvmE87qwlmv9m/UJgTm8IBWVidNZdxmPVsuhW2ShH0bnDZaFWJGu2pAaQCVnTv
        AQ5ny/2c9qZpL/7Cqi1SpiWt1/+ntRdVRkm0/0jqPrfWfEQAHcGcDyLJxe+G9/SbI8gx7VpGBs0K5
        QsRrrtHcgibnmzompha8Y9T63Ngnbe0zMXdCGJe1DqIzj4SEkG2V38HCzn+lpcdAFrvNf9XyjUtvr
        H9TVN1Rw4cZdJyIUSLdSebEg9rwrlIvHSHVOL0LaCGem9hBcJw7wcl3A9mNRmHg8ltTA+iM+e40O/
        /VnCSzcw==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=worktop.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mvatE-000Wrg-TR; Fri, 10 Dec 2021 08:04:25 +0000
Received: by worktop.programming.kicks-ass.net (Postfix, from userid 1000)
        id 227079817E0; Fri, 10 Dec 2021 09:04:25 +0100 (CET)
Date:   Fri, 10 Dec 2021 09:04:25 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Jiri Olsa <jolsa@redhat.com>
Cc:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        lkml <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Michael Petlan <mpetlan@redhat.com>,
        Ian Rogers <irogers@google.com>,
        linux-perf-users@vger.kernel.org,
        "Frank Ch. Eigler" <fche@redhat.com>
Subject: Re: [RFC] perf record: Disable debuginfod by default
Message-ID: <20211210080425.GO16608@worktop.programming.kicks-ass.net>
References: <20211209200425.303561-1-jolsa@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211209200425.303561-1-jolsa@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 09, 2021 at 09:04:25PM +0100, Jiri Olsa wrote:
> hi,
> after migrating to fedora 35 I found perf record hanging on exit
> and it's because fedora 35 sets DEBUGINFOD_URLS that triggers
> debuginfod query which might take long time to process.
> 
> I discussed this briefly with Frank and I'm sending the change
> to disable debuginfod by default in perf record.
> 
> Frank had other idea we could discuss here to fork or just spawn
> "/usr/bin/debuginfod-find ...." into background after perf record.
> 
> Perhaps there are other ways as well, hence this is RFC ;-)
> 
> thanks,
> jirka
> 
> 
> ---
> Fedora 35 sets by default DEBUGINFOD_URLS, which might lead
> to unexpected stalls in perf record exit path, when we try
> to cache profiled binaries.
> 
>   # DEBUGINFOD_PROGRESS=1 ./perf record -a
>   ^C[ perf record: Woken up 1 times to write data ]
>   Downloading from https://debuginfod.fedoraproject.org/ 447069
>   Downloading from https://debuginfod.fedoraproject.org/ 1502175
>   Downloading \^Z
> 
> Disabling DEBUGINFOD_URLS by default in perf record and adding
> debuginfod option and .perfconfig variable support to enable id.
> 
>   Default without debuginfo processing:
>   # perf record -a
> 
>   Using system debuginfod setup:
>   # perf record -a --debuginfod
> 
>   Using custom debuginfd url:
>   # perf record -a --debuginfod='https://evenbetterdebuginfodserver.krava'
> 
> Adding single perf_debuginfod_setup function and using
> it also in perf buildid-cache command.

I'm still running with --no-buildid --no-buildid-cache or something like
that by default. As long as that remains working I'm good.
