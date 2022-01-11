Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B578448B64B
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jan 2022 20:00:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350314AbiAKTAC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Jan 2022 14:00:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36304 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350308AbiAKTAA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Jan 2022 14:00:00 -0500
Received: from mail-yb1-xb2d.google.com (mail-yb1-xb2d.google.com [IPv6:2607:f8b0:4864:20::b2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 99BA2C061748
        for <linux-kernel@vger.kernel.org>; Tue, 11 Jan 2022 11:00:00 -0800 (PST)
Received: by mail-yb1-xb2d.google.com with SMTP id i3so50037445ybh.11
        for <linux-kernel@vger.kernel.org>; Tue, 11 Jan 2022 11:00:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=atishpatra.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=6mcjefM06R1tkqX7tpt74UGpOHh5gM914x34vbidQ7U=;
        b=F+gorQ0yIwFh7cUVtQjrmOBwbnBDGysGw8+cdmXVa10toj/WPbDIRBPkFkFUNYvaU2
         R26V6akf1digOv3c6ALWePu834Rjw5UmY9eF0bNp2xiNcNT170xPRYfTwSwMfM09wQAP
         eJdid4xGZJZcoPD+hlEiKMitr3f6p3h7MILz0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=6mcjefM06R1tkqX7tpt74UGpOHh5gM914x34vbidQ7U=;
        b=WXoXJH2SPqRtEXtO9+bryfCxOVsVmQA7R9uWGZyi7AivOOdS+GdQDftUK4m8LxMVwV
         KXhQh5OTOnskvFyNeOxCcmpFheC74cejQY86TpefB26V+wG/ZUN9ynlFjn4rjStJegQV
         /5jD+7gJS5sSqDyLcjfhVMxq2OYYaHf+0DxFJsY3bayIB3EUZWMDNA2UuwK9j10T3vG+
         bYkRpYbNVlSOptSz81JyXOFVmfAWLfiHz+kOJs3eHDnQqevH1q4teZ+ZRyXwZC0NnDjs
         H3bRnTs2MqBB5usK0bLnI5WkyFhzrU/yiZG0ZbgW6sAypHkSKPv/fMGrLtyap92Vj3DM
         8YRw==
X-Gm-Message-State: AOAM531/NsVoSa6+84N4awMphfusUpcTrjgnD+j96Bg8S6gpW1+ftVfy
        cU7oeATA0JiFcKyz23KNEheJIpSbjvE/R2J0TzCh
X-Google-Smtp-Source: ABdhPJw9jESqQRPziTwI+V57RAwCz2GR3tx8f8YYGG8jsyMcn7fb2lG4mMTjKh7uAkvhExbUbAkL2EbhFloRRVNtt4c=
X-Received: by 2002:a25:3890:: with SMTP id f138mr7506325yba.703.1641927593840;
 Tue, 11 Jan 2022 10:59:53 -0800 (PST)
MIME-Version: 1.0
References: <20220111142054.18733-1-nikita.shubin@maquefel.me>
 <20220111142054.18733-2-nikita.shubin@maquefel.me> <4b655bf8-ce56-ffe6-78b6-1f949b8df11f@linux.intel.com>
In-Reply-To: <4b655bf8-ce56-ffe6-78b6-1f949b8df11f@linux.intel.com>
From:   Atish Patra <atishp@atishpatra.org>
Date:   Tue, 11 Jan 2022 10:59:43 -0800
Message-ID: <CAOnJCUKVGZ=ixXJb3d--JKA8DqSvHq4bnV9A1z4YPiQzDjzXHQ@mail.gmail.com>
Subject: Re: [RFC PATCH 1/1] perf tools: Add 'm' event modifier for counting machine
To:     Andi Kleen <ak@linux.intel.com>
Cc:     Nikita Shubin <nikita.shubin@maquefel.me>,
        Atish Patra <atishp@rivosinc.com>,
        linux-riscv <linux-riscv@lists.infradead.org>,
        linux <linux@yadro.com>, Nikita Shubin <n.shubin@yadro.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Kajol Jain <kjain@linux.ibm.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Kan Liang <kan.liang@linux.intel.com>,
        Jin Yao <yao.jin@linux.intel.com>,
        Ian Rogers <irogers@google.com>,
        John Garry <john.garry@huawei.com>,
        Riccardo Mancini <rickyman7@gmail.com>,
        Madhavan Srinivasan <maddy@linux.ibm.com>,
        Song Liu <song@kernel.org>, linux-perf-users@vger.kernel.org,
        "linux-kernel@vger.kernel.org List" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 11, 2022 at 10:53 AM Andi Kleen <ak@linux.intel.com> wrote:
>
>
> >
> >    u - user-space counting
> >    k - kernel counting
> > + m - machine counting
>
>
> You really need to explain what "machine counting" actually is, as well
> that is likely irrelevant for most CPUs.
>

Ideally, this should firmware counting instead of "machine counting"
which is a RISC-V specific terminology
(Machine mode is highest privilege mode similar to EL3 in ARM where
the firmware runs)

> I also didn't see that anywhere in the commit logs.
>
> -Andi
>
>
> _______________________________________________
> linux-riscv mailing list
> linux-riscv@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-riscv



-- 
Regards,
Atish
