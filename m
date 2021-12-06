Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 24E5C46A292
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Dec 2021 18:16:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234018AbhLFRUA convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Mon, 6 Dec 2021 12:20:00 -0500
Received: from mail-lf1-f41.google.com ([209.85.167.41]:41810 "EHLO
        mail-lf1-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232177AbhLFRT7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Dec 2021 12:19:59 -0500
Received: by mail-lf1-f41.google.com with SMTP id z21so4944915lfu.8
        for <linux-kernel@vger.kernel.org>; Mon, 06 Dec 2021 09:16:30 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=/CJlXexoEpgtiY8131CsbHxfhoHcgR5yDp/MTSqF7KI=;
        b=A2sQQZBeZx6YRMiY9sGbLtf8zhUmH0Sw/CumisPgiBokHt5S+PH6YkHmeN7A7oLZpg
         O8z/WlQZjO2SdQJwPedDDbnaw0Vbcw3nvyUAU7jc/AnnIIOdKyFsdduafsyOXvD3MSaG
         VswMu50XUcVPdoOlzILIF2yDid/2JFnlA4jVODgJDMhWGQ14gD1SKZwxVypgNzpc71+8
         LeC2XOP+MnWqziP52GgG4WdeR1ia9Jd84Cy4/FDcZiVlInydopBYcVoeCfwCvWaGkuZz
         AUsugbHVbzbhLV8aVxRRKyqFgkLXOREs4VH+M4gzk31G5ss6hIWIt3FMGDCGbPJte5Cr
         TfIw==
X-Gm-Message-State: AOAM533EawyO/PhuJW/y2rGnOH7cIQTUb2TD8qUIvAAHa9GecrDPgaKc
        bWa/gbYEWJkBgODUDFxl72d9NqtP5LaEZeVdOKY=
X-Google-Smtp-Source: ABdhPJxCF4RXbP+FoULbdfQ6JE6LcGZ2RfAWvNPRLW8UqjgPXKqJhm0xUCd9whWICJ5GUFL0GPyVWLUTTAXAojEcwjQ=
X-Received: by 2002:a05:6512:b8c:: with SMTP id b12mr35186158lfv.99.1638810989417;
 Mon, 06 Dec 2021 09:16:29 -0800 (PST)
MIME-Version: 1.0
References: <20211129231830.1117781-1-namhyung@kernel.org> <20211129231830.1117781-5-namhyung@kernel.org>
 <011B6FDF-15F0-411F-98F2-155E95BE7047@linux.vnet.ibm.com>
In-Reply-To: <011B6FDF-15F0-411F-98F2-155E95BE7047@linux.vnet.ibm.com>
From:   Namhyung Kim <namhyung@kernel.org>
Date:   Mon, 6 Dec 2021 09:16:18 -0800
Message-ID: <CAM9d7cgaYC9BxeA3dRtb8CP+9BnFQ7pXgG9X+ku_CZ43i=ZqGg@mail.gmail.com>
Subject: Re: [PATCH 4/5] perf ftrace: Add -b/--use-bpf option for latency subcommand
To:     Athira Rajeev <atrajeev@linux.vnet.ibm.com>
Cc:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Jiri Olsa <jolsa@redhat.com>, Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Andi Kleen <ak@linux.intel.com>,
        Ian Rogers <irogers@google.com>,
        Stephane Eranian <eranian@google.com>,
        Song Liu <songliubraving@fb.com>,
        Changbin Du <changbin.du@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Athira,

On Sun, Dec 5, 2021 at 6:24 PM Athira Rajeev
<atrajeev@linux.vnet.ibm.com> wrote:
>
>
>
> > On 30-Nov-2021, at 4:48 AM, Namhyung Kim <namhyung@kernel.org> wrote:
> >
> > The -b/--use-bpf option is to use BPF to get latency info of kernel
> > functions.  It'd have better performance impact and I observed that
> > latency of same function is smaller than before when using BPF.
> >
> > Signed-off-by: Namhyung Kim <namhyung@kernel.org>
> > ---
[SNIP]
> > @@ -1144,6 +1166,8 @@ int cmd_ftrace(int argc, const char **argv)
> >       const struct option latency_options[] = {
> >       OPT_CALLBACK('T', "trace-funcs", &ftrace.filters, "func",
> >                    "Show latency of given function", parse_filter_func),
> > +     OPT_BOOLEAN('b', "use-bpf", &ftrace.target.use_bpf,
> > +                 "Use BPF to measure function latency"),
>
>
> Hi Namhyung,
>
> Can this be inside BPF_SKEL check, similar to how we have “bpf-prog” and other options in builtin-stat.c ?
>
> #ifdef HAVE_BPF_SKEL
> <<OPT_BOOLEAN for use-bpf>>
> #endif
>
> Otherwise when using “-b” and if perf is not built with BPF_SKEL, we will just return in perf_ftrace__latency_prepare_bpf without any error messages.

Thanks for reporting this.  Yeah, it should report
error messages in such conditions.

I think it'd be better to add an error message
rather than hiding the option.

Thanks,
Namhyung
