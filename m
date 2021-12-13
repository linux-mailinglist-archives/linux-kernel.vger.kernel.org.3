Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0C4D04733EA
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Dec 2021 19:22:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239976AbhLMSW4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Dec 2021 13:22:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39362 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232192AbhLMSWz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Dec 2021 13:22:55 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA1EFC061574;
        Mon, 13 Dec 2021 10:22:54 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 9303C611B7;
        Mon, 13 Dec 2021 18:22:54 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CD28AC34600;
        Mon, 13 Dec 2021 18:22:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1639419774;
        bh=/z8URsSr6mo957ROYpUpoGEmX7urlXEv6NBT41IGEDw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=IY6gab16/5ywFSg7jsSYQwRBO1tC0bSXlTIYlBV1ALeZ/o/JbWlPLTp8oilYcRCgv
         rG0bYSj0Pray5X4cZ1KB6Qjg4rdQ6QqWAmWUJLsM5IIzmdrxOT6HcMy6NgSGsmymu7
         2Wv2e+3Nemug2DcLdm52z7Kk16g9tbnxhjtsNVAPI45eqGSpB+11bDAGeJGkcOKjZq
         aAPovi8oHCfRq1+gryvUXQ/FWhCv99pj4iwQRGFx1tkcZ0k1+wYzeDNmweCtJ3/V7R
         Vdq1/7sGj2DQX+St1lZNVh2CNTnoZI9nIAv7Fb4Pqwq5NhZueiu90JTC9YIuYmiAC8
         v/s0oeWbHDOLg==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 3C36B405D8; Mon, 13 Dec 2021 15:22:52 -0300 (-03)
Date:   Mon, 13 Dec 2021 15:22:52 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     German Gomez <german.gomez@arm.com>
Cc:     Athira Rajeev <atrajeev@linux.vnet.ibm.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-perf-users@vger.kernel.org,
        John Garry <john.garry@huawei.com>,
        Will Deacon <will@kernel.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Leo Yan <leo.yan@linaro.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        linux-arm-kernel@lists.infradead.org, linux-csky@vger.kernel.org,
        linux-riscv@lists.infradead.org
Subject: Re: [PATCH v1 2/4] perf script: Add "struct machine" parameter to
 process_event callback
Message-ID: <YbePfOMaiJjoDb3b@kernel.org>
References: <20211201123334.679131-1-german.gomez@arm.com>
 <20211201123334.679131-3-german.gomez@arm.com>
 <D6A3A8F3-9946-44FE-A70F-42977C6F38A1@linux.vnet.ibm.com>
 <38fd4992-63ae-4871-ddfd-27d40b5c48d2@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <38fd4992-63ae-4871-ddfd-27d40b5c48d2@arm.com>
X-Url:  http://acmel.wordpress.com
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Fri, Dec 03, 2021 at 12:00:26PM +0000, German Gomez escreveu:
> Hi Athira,
> 
> On 02/12/2021 16:03, Athira Rajeev wrote:
> >
> >> On 01-Dec-2021, at 6:03 PM, German Gomez <german.gomez@arm.com> wrote:
> >>
> >> Include a "struct machine*" parameter to the process_event callback in
> >> the scripting layer. This will allow access to the perf_env from within
> >> this callback.
> >>
> >> Followup patches will build on top of this to report the correct name of
> >> the registers in a perf.data file, consistently with the architecture
> >> the file was recorded in.
> >>
> >> Signed-off-by: German Gomez <german.gomez@arm.com>
> >> ---
> >> tools/perf/builtin-script.c                   |  2 +-
> >> .../util/scripting-engines/trace-event-perl.c |  3 ++-
> >> .../scripting-engines/trace-event-python.c    | 23 +++++++++++--------
> >> tools/perf/util/trace-event-scripting.c       |  3 ++-
> >> tools/perf/util/trace-event.h                 |  3 ++-
> >> 5 files changed, 21 insertions(+), 13 deletions(-)
> >>
> >> diff --git a/tools/perf/builtin-script.c b/tools/perf/builtin-script.c
> >> index 9434367af..711132f0b 100644
> >> --- a/tools/perf/builtin-script.c
> >> +++ b/tools/perf/builtin-script.c
> >> @@ -2256,7 +2256,7 @@ static int process_sample_event(struct perf_tool *tool,
> >> 				thread__resolve(al.thread, &addr_al, sample);
> >> 			addr_al_ptr = &addr_al;
> >> 		}
> >> -		scripting_ops->process_event(event, sample, evsel, &al, addr_al_ptr);
> >> +		scripting_ops->process_event(event, sample, evsel, &al, addr_al_ptr, machine);
> > Hi,
> >
> > Looks like the patch is using “machine” to allow access to perf_env__arch and there by to get the “arch” value.
> > But can we use from evsel, like  "perf_env__arch(evsel__env(evsel))” to get arch value instead of including new parameter for “struct machine” ?
> >
> > Thanks
> > Athira
> 
> Thanks for the suggestion. It looks like we can skip this patch if we
> can get the arch value that way.

So the first one is already upstream, will you post a v2?

- Arnaldo
