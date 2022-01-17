Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 009CD490C65
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jan 2022 17:21:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241059AbiAQQV5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Jan 2022 11:21:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36244 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237650AbiAQQV4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jan 2022 11:21:56 -0500
Received: from mail-il1-x131.google.com (mail-il1-x131.google.com [IPv6:2607:f8b0:4864:20::131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E63BAC06161C
        for <linux-kernel@vger.kernel.org>; Mon, 17 Jan 2022 08:21:55 -0800 (PST)
Received: by mail-il1-x131.google.com with SMTP id x15so15189271ilc.5
        for <linux-kernel@vger.kernel.org>; Mon, 17 Jan 2022 08:21:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Sp+0eoECInU2wfkdrbVWkaKUDKICynVO7ICEtzkqDx8=;
        b=G7gYml8dmiEYly+hsWDEJkbGtJsKpyLr2bmYQH7r+pHbSZBANaq3j/K1PRU8rlVMTG
         zpOd1VFgDUX7J6RvXrbCyRUOO5bPURbgl18lr7YyP9y0LObLswmSte7COLutEbl1nkKo
         mA9CAkIhzzh9JaSFgIRXG2Oc7mYX3yWSaj8wJLkmhYOhM3FwVwSSjaLSrtYTdm7BA2yF
         YhVsTtT3j8D7IEQ8BYZBTnjdJTUN6jZB5nr7einp2i5em+F7zF/kMIT+enAwnnFT7U5I
         fySbn8gjekMICzahIiA9HNkyz4TQ3erGhTI39hl6ehrKug2L2OQw5IZ8f7fLp2pRGcFL
         5x8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Sp+0eoECInU2wfkdrbVWkaKUDKICynVO7ICEtzkqDx8=;
        b=oP1wOE9jOfdn5DBQCOQhBZ1JQ2QGR+27az1eEpW2rdMd36h+RFyvqxUnAu73XIQ7Ay
         tWrHdCsux5wlZv1ubRBFMUmpuQTzJ0Xhv5b+3cua1KteGN/4SXAGaG5vSskP0RCHVur4
         6wpnk6TI/0tWc2P1iOjOp4fWKhOBRJeo5nPinU5VJDdbs98k2an8OPsLDn8Yx/jPjZQY
         2Sl889dkbulDrqlKdSkspsBHn/5zoPCNWr9eaj/gXePN9ba6KMyvHB4ogt41shgksOTx
         kZAwEIyt0I5w2OTH4HgzBd9wIOHEGOplb2ZXFS8CQkpFEf7Cb72/F/zgS1KwxXzm7rcC
         B2iQ==
X-Gm-Message-State: AOAM530HHAelqCaYHHw9AEIW/VNemceyt3rxCa+ohdm58U0AY/JqH1eI
        MMRviNG4fXhJUCz02ot5L+OYfgx+CgCKqsnSbH2STw==
X-Google-Smtp-Source: ABdhPJxveX9u51mv7LPmfFastALckkh2LfMODqyoJi+VTjmGfs3BSYZOA8O3DwAF3uqjWOfP8CxcKlinlIF/pdO11Y8=
X-Received: by 2002:a05:6e02:19cd:: with SMTP id r13mr11713421ill.89.1642436515137;
 Mon, 17 Jan 2022 08:21:55 -0800 (PST)
MIME-Version: 1.0
References: <1642432215-234089-1-git-send-email-john.garry@huawei.com>
In-Reply-To: <1642432215-234089-1-git-send-email-john.garry@huawei.com>
From:   Ian Rogers <irogers@google.com>
Date:   Mon, 17 Jan 2022 08:21:42 -0800
Message-ID: <CAP-5=fXONfbx6GzWaT21XzDyCcPkSR2hjEOO0ARVhwiSY5oKjA@mail.gmail.com>
Subject: Re: [PATCH 0/3] perf: Support event alias in form foo-bar-baz
To:     John Garry <john.garry@huawei.com>
Cc:     peterz@infradead.org, mingo@redhat.com, acme@kernel.org,
        mark.rutland@arm.com, alexander.shishkin@linux.intel.com,
        jolsa@redhat.com, namhyung@kernel.org, kjain@linux.ibm.com,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
        linuxarm@huawei.com, liuqi115@huawei.com,
        zhangshaokun@hisilicon.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 17, 2022 at 7:15 AM John Garry <john.garry@huawei.com> wrote:
>
> Currently event aliases in the form foo-bar-baz are not supported.
>
> The HiSilicon D06 platform has uncore event aliases in that form, and
> using those aliases fail:
>
> $ ./perf list sdir-home-migrate
>
> List of pre-defined events (to be used in -e):
>
> uncore hha:
>   sdir-home-migrate
>  [Unit: hisi_sccl,hha]
>
> $ sudo ./perf stat -e sdir-home-migrate
> event syntax error: 'sdir-home-migrate'
>                         \___ parser error
> Run 'perf list' for a list of valid events
>
>  Usage: perf stat [<options>] [<command>]
>
>  -e, --event <event>event selector. use 'perf list' to list available events
>
> This series added support for such an event alias form.
>
> I am no expert on l+y, so any and all review here would be appreciated,
> especially the last patch which is marked as RFC (for that same reason).
>
> The series is based on acme perf/core @ 9bce13ea88f8.
>
> John Garry (3):
>   perf parse-events: Support event alias in form foo-bar-baz
>   perf test: Add pmu-events test for aliases with hyphens
>   perf test: Add parse-events test for aliases with hyphens

The whole set:

Acked-by: Ian Rogers <irogers@google.com>

The additional code is no worse than the existing code. The testing is
a great addition!

Thanks,
Ian

>  .../arch/test/test_soc/cpu/uncore.json        | 16 +++++
>  tools/perf/tests/parse-events.c               | 49 ++++++++++++++
>  tools/perf/tests/pmu-events.c                 | 32 +++++++++
>  tools/perf/util/parse-events.c                | 67 ++++++++++++++++---
>  tools/perf/util/parse-events.h                |  1 +
>  tools/perf/util/parse-events.l                |  2 +
>  tools/perf/util/parse-events.y                | 17 ++++-
>  7 files changed, 171 insertions(+), 13 deletions(-)
>
> --
> 2.26.2
>
