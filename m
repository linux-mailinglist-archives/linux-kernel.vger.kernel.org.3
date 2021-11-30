Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 76B8A4641E3
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Nov 2021 23:58:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345076AbhK3XBn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Nov 2021 18:01:43 -0500
Received: from mail-lj1-f182.google.com ([209.85.208.182]:43938 "EHLO
        mail-lj1-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344981AbhK3XBk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Nov 2021 18:01:40 -0500
Received: by mail-lj1-f182.google.com with SMTP id 207so44116151ljf.10
        for <linux-kernel@vger.kernel.org>; Tue, 30 Nov 2021 14:58:20 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=xxM3x/GB3fVvph8o4gjpZNN8kUPRyS3Wa3LpsrvF7YQ=;
        b=D0mEyaJDLS/hSXnKC7au/zxd3QfJYQNvFKPAEyVvbXjWX8V3u6OETl9BbIjgdxeusL
         9+b1i+9Vs1/xb36yhkHp9MzZiEG6sDLBplKkmGgx0TvvoVjcC445FqMMHEX1Jj8z3kPj
         Im+eCBAmB58BfDKosvjFfVccPaq2Y9vTdyKxaUTVTt2rGlKoF1FHPY9tP+a1UdRYjnpS
         hYw3pYQWoxipn+jZVWNmAPwRxbIVN0ZKqQw8sDHVSk0FJS1vBmzLtKBtRZTpDnkwukj1
         nSqN5pL51fxb53xdajKDvLnlLvGpFoyE0RjthdMbRIf8e8nq8frzUumnl9m4j2Lgs5T4
         DVDw==
X-Gm-Message-State: AOAM531gP/vf0nj9hr6Jw37Zg9nh4wa50FrruUmx+bn4EVGzDqrQnK+V
        2xxcrJCs6MZRGNqKKKgcB4VBaFznGxeENvZ8dSA=
X-Google-Smtp-Source: ABdhPJzANiOG+K3NkO0IHJLGi1TMSSye1WbUYm+EmwyHA9Xp6hVSm8LS1pSm2yMYGhw4s9sWn0b9AsIpYB/AqsRVQYA=
X-Received: by 2002:a05:651c:545:: with SMTP id q5mr1782001ljp.202.1638313099721;
 Tue, 30 Nov 2021 14:58:19 -0800 (PST)
MIME-Version: 1.0
References: <20211129231830.1117781-1-namhyung@kernel.org> <YaY3JqOQ2XE22VId@kernel.org>
In-Reply-To: <YaY3JqOQ2XE22VId@kernel.org>
From:   Namhyung Kim <namhyung@kernel.org>
Date:   Tue, 30 Nov 2021 14:58:08 -0800
Message-ID: <CAM9d7cjXncRRsH1Zf_yVrLeaYiHXLFM29sx0MYPAZ8HAsZaggw@mail.gmail.com>
Subject: Re: [RFC/PATCHSET 0/5] perf ftrace: Implement function latency
 histogram (v1)
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Jiri Olsa <jolsa@redhat.com>, Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Andi Kleen <ak@linux.intel.com>,
        Ian Rogers <irogers@google.com>,
        Stephane Eranian <eranian@google.com>,
        Song Liu <songliubraving@fb.com>,
        Changbin Du <changbin.du@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Arnaldo,

On Tue, Nov 30, 2021 at 6:37 AM Arnaldo Carvalho de Melo
<acme@kernel.org> wrote:
>
> Em Mon, Nov 29, 2021 at 03:18:25PM -0800, Namhyung Kim escreveu:
> > Hello,
> >
> > I've implemented 'latency' subcommand in the perf ftrace command to
> > show a histogram of function latency.
> >
> > To handle new subcommands, the existing functionality is moved to
> > 'trace' subcommand while preserving backward compatibility of not
> > having a subcommand at all (defaults to 'trace').
> >
> > The latency subcommand accepts a target (kernel, for now) function
> > with -T option and shows a histogram like below:
>
> Humm, wouldn't be interesting to shorten this by having a new 'perf
> flat' (function latency) tool, on the same level as 'perf ftrace' and
> leave 'perf ftrace' to just being a convenient perf interface to what
> ftrace provides?

That would be fine.  I also think 'perf ftrace latency' is
bit too long.  But if we would add a new feature
like argdist (in BCC) later, I thought it'd be nice being
a subcommand in the perf ftrace together.

But it's up to you.  I'll make a change if you prefer
'flat' (or how about 'fnlat' instead?).


>
> But all around, nice work, cool new toyz! :-)

Thanks!
Namhyung
