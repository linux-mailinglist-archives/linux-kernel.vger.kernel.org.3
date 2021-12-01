Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E1A494643FB
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Dec 2021 01:37:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345829AbhLAAkX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Nov 2021 19:40:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55430 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345797AbhLAAkV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Nov 2021 19:40:21 -0500
Received: from mail-io1-xd31.google.com (mail-io1-xd31.google.com [IPv6:2607:f8b0:4864:20::d31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5563AC061574
        for <linux-kernel@vger.kernel.org>; Tue, 30 Nov 2021 16:37:01 -0800 (PST)
Received: by mail-io1-xd31.google.com with SMTP id x6so28342884iol.13
        for <linux-kernel@vger.kernel.org>; Tue, 30 Nov 2021 16:37:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=6KT7YyaxqjVs5mSuQwjMampQZClAeRv4K4OAPJNJd20=;
        b=ZSeoFG71k5erKk/MKPfg36Ze35fwc7Cua8svHc9JAorrJC+frFECdyJzDHIzZKGRce
         wYUG3w6YTmcSVnoOmf3s5zPBgrqTHph+DcndRt3PAClRXL+NnbMT+bW9nd8VwWkMWH8U
         aGhALR3nY0eGcGQCmuuxO199U29F0+oFV8xSwDq55/+z17KERuy3l7FSBdhZ+mbqpw9A
         isN+7VlTAQf9JRT63HkP7fcl4h1A07jZ2jhFy6V0+j3olZkT8vpL9Vk8LNKylPHf6+FJ
         x6da5lqrPnBq16RL+m1Ig0BVHuCWFgMJhsON6MtHwUM/x1mKWbLAaBOELMGr1hYQML5h
         eUpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=6KT7YyaxqjVs5mSuQwjMampQZClAeRv4K4OAPJNJd20=;
        b=hmVoGkQfiKetCOPUHjElGJRwjDwWSHYdwiWZGd7OsXPqIRfFiSCUQAp0+zESJOySfv
         S6MfyBIBZcM6/qSauHzcCqQEpgN7eGM83MRocYU/I7z5pEkX/p/5PuxzisKBjWaiBVoe
         2PnV6jjYFU+RcQGY6wcQLuxMxD6UTsxbkigmpzNRn6W7HZckXvAHZQr+5a76ImjuE7zA
         TYV8jUZVF+csnFZCZkEG43AUXAu/cDtFoGdI09ePndeq7M9XLbbN3NLO0ymdNhXcjSDj
         GCD2xwfyfnxC7Berci3HVLvjFzPqiaP32HXI0keDGjI15wFzzzHrszUtZnEr5Vxj6nVO
         ghIQ==
X-Gm-Message-State: AOAM5310K9d0hjMmrVUAxCmFY5gEACJMuZLXOOChfDTNQyy7Pz9Dpm8G
        ZjiVtmiGzf0J5QZkbkfIih0iavgt8ptlpBhP4wBM4w==
X-Google-Smtp-Source: ABdhPJxEWWGRI9CkNjtOLdkRHCbCAy0RCyi3Yn1qBz5cJ/XJJEFadsnDmkChbvW9Dh+395dbt1IVilO9VUKyXyTDpTo=
X-Received: by 2002:a5d:9492:: with SMTP id v18mr3969213ioj.158.1638319020517;
 Tue, 30 Nov 2021 16:37:00 -0800 (PST)
MIME-Version: 1.0
References: <20211129231830.1117781-1-namhyung@kernel.org> <YaY3JqOQ2XE22VId@kernel.org>
 <CAM9d7cjXncRRsH1Zf_yVrLeaYiHXLFM29sx0MYPAZ8HAsZaggw@mail.gmail.com>
In-Reply-To: <CAM9d7cjXncRRsH1Zf_yVrLeaYiHXLFM29sx0MYPAZ8HAsZaggw@mail.gmail.com>
From:   Stephane Eranian <eranian@google.com>
Date:   Tue, 30 Nov 2021 16:36:49 -0800
Message-ID: <CABPqkBQgr3ck_jnFbdLOKgpzrz4RhE3svTvkiOLY9KgvjQjU9w@mail.gmail.com>
Subject: Re: [RFC/PATCHSET 0/5] perf ftrace: Implement function latency
 histogram (v1)
To:     Namhyung Kim <namhyung@kernel.org>
Cc:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Jiri Olsa <jolsa@redhat.com>, Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Andi Kleen <ak@linux.intel.com>,
        Ian Rogers <irogers@google.com>,
        Song Liu <songliubraving@fb.com>,
        Changbin Du <changbin.du@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 30, 2021 at 2:58 PM Namhyung Kim <namhyung@kernel.org> wrote:
>
> Hi Arnaldo,
>
> On Tue, Nov 30, 2021 at 6:37 AM Arnaldo Carvalho de Melo
> <acme@kernel.org> wrote:
> >
> > Em Mon, Nov 29, 2021 at 03:18:25PM -0800, Namhyung Kim escreveu:
> > > Hello,
> > >
> > > I've implemented 'latency' subcommand in the perf ftrace command to
> > > show a histogram of function latency.
> > >
> > > To handle new subcommands, the existing functionality is moved to
> > > 'trace' subcommand while preserving backward compatibility of not
> > > having a subcommand at all (defaults to 'trace').
> > >
> > > The latency subcommand accepts a target (kernel, for now) function
> > > with -T option and shows a histogram like below:
> >
> > Humm, wouldn't be interesting to shorten this by having a new 'perf
> > flat' (function latency) tool, on the same level as 'perf ftrace' and
> > leave 'perf ftrace' to just being a convenient perf interface to what
> > ftrace provides?
>
> That would be fine.  I also think 'perf ftrace latency' is
> bit too long.  But if we would add a new feature
> like argdist (in BCC) later, I thought it'd be nice being
> a subcommand in the perf ftrace together.
>
> But it's up to you.  I'll make a change if you prefer
> 'flat' (or how about 'fnlat' instead?).
>
I am not too fond of the flat option because as we had more bpf tools
like function latency, then we keep extending the list of commands
each with a small span which is different
from what we have right now.
