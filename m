Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E4979496DFB
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Jan 2022 21:24:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231350AbiAVUY2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 22 Jan 2022 15:24:28 -0500
Received: from ams.source.kernel.org ([145.40.68.75]:37976 "EHLO
        ams.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231252AbiAVUY1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 22 Jan 2022 15:24:27 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id DA5C3B80AD8;
        Sat, 22 Jan 2022 20:24:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 580ABC004E1;
        Sat, 22 Jan 2022 20:24:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1642883064;
        bh=J7d62QJaNgCNwU/L/WAxtc1M4v8AXpbCa/rwZzH4Qo0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=YqFvwQxQeRpZak5KkoNehcEftfSvz0CFBnCU5TSzRiWZg04jApG29obtOza5iDeLA
         iRVnglTw45Jkwfo4deAdioXWQc67ONzZ/b68itYBDRRzi7uD+x+QlBmai2L7jwpC/M
         I60LAkDWYjONxNEVt+0pBMJkVBKqM01BIVSKw7+z4zibN8iGgMSfp5qd1tM3Fl9g0u
         wS6SJYyQ8Lgtl7ph5YK6NAszKWV58zc33okzErmemB0EsisAx3IlzFlRI7nEjCnL8Q
         LBNN1CFDD/BiX1OJIlWPMHCgz08O/Mm01jHvqrMHYNiuA/bjVtgO53aqSn2RU/18EE
         t7C3bmFrtCTSA==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 56D4B40C99; Sat, 22 Jan 2022 17:22:22 -0300 (-03)
Date:   Sat, 22 Jan 2022 17:22:22 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ian Rogers <irogers@google.com>
Cc:     John Garry <john.garry@huawei.com>, peterz@infradead.org,
        mingo@redhat.com, mark.rutland@arm.com,
        alexander.shishkin@linux.intel.com, jolsa@redhat.com,
        namhyung@kernel.org, kjain@linux.ibm.com,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
        linuxarm@huawei.com, liuqi115@huawei.com,
        zhangshaokun@hisilicon.com
Subject: Re: [PATCH 0/3] perf: Support event alias in form foo-bar-baz
Message-ID: <YexnfryaVyyYVuIi@kernel.org>
References: <1642432215-234089-1-git-send-email-john.garry@huawei.com>
 <CAP-5=fXONfbx6GzWaT21XzDyCcPkSR2hjEOO0ARVhwiSY5oKjA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAP-5=fXONfbx6GzWaT21XzDyCcPkSR2hjEOO0ARVhwiSY5oKjA@mail.gmail.com>
X-Url:  http://acmel.wordpress.com
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Mon, Jan 17, 2022 at 08:21:42AM -0800, Ian Rogers escreveu:
> On Mon, Jan 17, 2022 at 7:15 AM John Garry <john.garry@huawei.com> wrote:
> >
> > Currently event aliases in the form foo-bar-baz are not supported.
> >
> > The HiSilicon D06 platform has uncore event aliases in that form, and
> > using those aliases fail:
> >
> > $ ./perf list sdir-home-migrate
> >
> > List of pre-defined events (to be used in -e):
> >
> > uncore hha:
> >   sdir-home-migrate
> >  [Unit: hisi_sccl,hha]
> >
> > $ sudo ./perf stat -e sdir-home-migrate
> > event syntax error: 'sdir-home-migrate'
> >                         \___ parser error
> > Run 'perf list' for a list of valid events
> >
> >  Usage: perf stat [<options>] [<command>]
> >
> >  -e, --event <event>event selector. use 'perf list' to list available events
> >
> > This series added support for such an event alias form.
> >
> > I am no expert on l+y, so any and all review here would be appreciated,
> > especially the last patch which is marked as RFC (for that same reason).
> >
> > The series is based on acme perf/core @ 9bce13ea88f8.
> >
> > John Garry (3):
> >   perf parse-events: Support event alias in form foo-bar-baz
> >   perf test: Add pmu-events test for aliases with hyphens
> >   perf test: Add parse-events test for aliases with hyphens
> 
> The whole set:
> 
> Acked-by: Ian Rogers <irogers@google.com>
> 
> The additional code is no worse than the existing code. The testing is
> a great addition!

Indeed, thanks a lot!

Thanks, applied.

- Arnaldo

 
> Thanks,
> Ian
> 
> >  .../arch/test/test_soc/cpu/uncore.json        | 16 +++++
> >  tools/perf/tests/parse-events.c               | 49 ++++++++++++++
> >  tools/perf/tests/pmu-events.c                 | 32 +++++++++
> >  tools/perf/util/parse-events.c                | 67 ++++++++++++++++---
> >  tools/perf/util/parse-events.h                |  1 +
> >  tools/perf/util/parse-events.l                |  2 +
> >  tools/perf/util/parse-events.y                | 17 ++++-
> >  7 files changed, 171 insertions(+), 13 deletions(-)
> >
> > --
> > 2.26.2
> >

-- 

- Arnaldo
