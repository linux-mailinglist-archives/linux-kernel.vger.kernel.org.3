Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 53FDA4A8009
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Feb 2022 08:58:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240962AbiBCH6U (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Feb 2022 02:58:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53758 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233434AbiBCH6R (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Feb 2022 02:58:17 -0500
Received: from mail-yb1-xb36.google.com (mail-yb1-xb36.google.com [IPv6:2607:f8b0:4864:20::b36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0037CC06173B
        for <linux-kernel@vger.kernel.org>; Wed,  2 Feb 2022 23:58:16 -0800 (PST)
Received: by mail-yb1-xb36.google.com with SMTP id i62so6387474ybg.5
        for <linux-kernel@vger.kernel.org>; Wed, 02 Feb 2022 23:58:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=G8te9fm9uBsrUaVWugKAeTKH1DeJ7u2Cxa+zpUpsAWk=;
        b=RLc26mKlJKGqZaYbJsxgavP6u0h8bb7n9zOgi5x58ejo4XgMD9YC4BXyaVfQAdQNnq
         5QWxjDPw3yasqw1Jodx+qeAAcLoq26zWwgn21daH+X9CqH/nXsCTVyd0Xcmy5ffujHUn
         HIGuAqzCjc5OVJ9cMp3dwzTK9f/+QjEX1TWZzzqvhZgXoeztVAM0+6k9x2PWc7va8rTR
         GcJxbDQszD6uMX1/GF3RCs1tjHUgDXGDZKKmEQkHFZth85kOgEY/XUQiri8DqA1jn9Ux
         UXBJPTSw2uS3LfDzUvSUp605Ldtqn3beQ0aYBlibra4/a0GeRL3bb25537zoOwQJSnYf
         11Hw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=G8te9fm9uBsrUaVWugKAeTKH1DeJ7u2Cxa+zpUpsAWk=;
        b=O7cEe6EboBjrQ1umdxAo1lvwSlvZDOZpv9YTjSL9Lx7hgxGtKcsKjOlqd4OezU1rRF
         AtxcwUoE17bkPAysJdqf+Rtj9VMsLFtY2viH898/a19Uk99qivFpYcTE+ndC9fYLMFWL
         WaYA9ugb+WvJ/sh34VyePJJb5dUau8bLNjZO0MOMB3+cQwxSbzMSTg6SZ3faQbrAuwwH
         XIQRjzkyY7VjJ5VxOG0Bw/sfJ8JYKsAqgWHE2errmQn4aWrghUHuGjez8lIxRBmYioDz
         juRshg9JPHkiTTDtGLTGEZIn0+PVCScQrpHQ8NoTwI4pBWdLrQvvbyIwLIuUZXPijhpU
         RJzw==
X-Gm-Message-State: AOAM5302wDlSzh74IncZdSg/BT/nNes1FMwA4I63tnwiX7whynn4ubq7
        8RMGLwtmmMtKxKhp9wkti2jdQuGPXhakImUiJDAUkg==
X-Google-Smtp-Source: ABdhPJwnTVuAbGhU4ghxbR17XGHR6LbAuYdyp2GDmnyM2pBL5JGzJZEJ32zBjc8CW4T6ZpuExgEmCpmR9NwjTi9RMMQ=
X-Received: by 2002:a0d:d6c5:: with SMTP id y188mr3267883ywd.188.1643875095965;
 Wed, 02 Feb 2022 23:58:15 -0800 (PST)
MIME-Version: 1.0
References: <20220203010746.610494-1-irogers@google.com> <ac97246f-0dbe-6118-dab6-dbc562e3c82c@linux.intel.com>
In-Reply-To: <ac97246f-0dbe-6118-dab6-dbc562e3c82c@linux.intel.com>
From:   Ian Rogers <irogers@google.com>
Date:   Wed, 2 Feb 2022 23:58:02 -0800
Message-ID: <CAP-5=fVxFy36wZKu+M199qic1VYWo_Z9GQ+jBAp6ZkBHTHv4Ww@mail.gmail.com>
Subject: Re: [PATCH] perf metrics: Add literal for system TSC frequency
To:     Andi Kleen <ak@linux.intel.com>
Cc:     vineet.singh@intel.com, perry.taylor@intel.com,
        caleb.biggers@intel.com, asaf.yaffe@intel.com,
        kshipra.bopardikar@intel.com,
        Kan Liang <kan.liang@linux.intel.com>,
        Zhengjun Xing <zhengjun.xing@linux.intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        James Clark <james.clark@arm.com>,
        John Garry <john.garry@huawei.com>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        Stephane Eranian <eranian@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 2, 2022 at 7:59 PM Andi Kleen <ak@linux.intel.com> wrote:
>
>
> On 2/2/2022 5:07 PM, Ian Rogers wrote:
> > Such a literal is useful to calculate things like the average frequency
> > [1]. The TSC frequency isn't exposed by sysfs although some experimental
> > drivers look to add it [2]. This change computes the value using the
> > frequency in /proc/cpuinfo which is accruate at least on Intel
> > processors.
>
> FWIW the information in /proc/cpuinfo is going away.
>
> You should really use CPUID for this, which has a new leaf for this.
> Unfortunately there
>
> were a few systems were it was inaccurate, but I suppose you could still
> prefer /proc/cpuinfo
>
> Also your method will not work when the metrics are used through perf
> stat report or perf script
>
> and run on another system. For the perf script case there is support for
> putting the TSC into
>
> perf.data (that is needed for PT), but the header is not dumped by
> default unfortunately.
>
> So likely you would need some new mechanism for that.

Thanks Andi,

yep metrics with perf stat record are broken on a number of fronts and
this will be another that will need a fix. It looks like the cpuid
approach won't work pre-Skylake so sysfs could act as a fallback, but
I don't have an ETA on when that will be available. We could have
additional warnings when reading /proc/cpuinfo fails. Wdyt?

Thanks,
Ian

> -Andi
>
