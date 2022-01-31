Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B0F4D4A494E
	for <lists+linux-kernel@lfdr.de>; Mon, 31 Jan 2022 15:28:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236013AbiAaO2S (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Jan 2022 09:28:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36540 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235914AbiAaO2R (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Jan 2022 09:28:17 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 220A5C06173D;
        Mon, 31 Jan 2022 06:28:17 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 145FAB82A59;
        Mon, 31 Jan 2022 14:28:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AFA86C340EE;
        Mon, 31 Jan 2022 14:28:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1643639293;
        bh=kfrJnOWubtdfm2g34bwjILcCqrYytFdSVBRfPr7yUeo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=E2McGu4C0bL0QtV9F/Jot/YKHUVSwMZCClcHCeHDl56FGPaJhby6eSBTZSV4sFn+0
         OHfN/IxiZFZWzVSBRT8Pf1hYg+9edwSkQ7oK7dcxMyVmDU6ZPRANeWCk235SBW37cx
         iyjsehsNJJiAxKHEx55YlCc3qxZzSKg5xIZ7PnxAeCH9ZzYD+l5VAeARbwead3+2ky
         xIogem6BkN3rrl1YitxCimj/9Us15H7zFD65oq0sCJVo+CITzYbYXKcakX8fPkgapo
         ltTcpNP/GYUe2UUleJvicESPeQmtj32MZzu8XcpMaNjHiH09d5HTn+ppxUuWB4pGX5
         fezXWEGYUs5xA==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 1B13A40466; Mon, 31 Jan 2022 11:28:11 -0300 (-03)
Date:   Mon, 31 Jan 2022 11:28:11 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Masami Hiramatsu <mhiramat@kernel.org>
Cc:     Ian Rogers <irogers@google.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Darren Hart <dvhart@infradead.org>,
        Davidlohr Bueso <dave@stgolabs.net>,
        =?iso-8859-1?Q?Andr=E9?= Almeida <andrealmeid@collabora.com>,
        James Clark <james.clark@arm.com>,
        John Garry <john.garry@huawei.com>,
        Riccardo Mancini <rickyman7@gmail.com>,
        Yury Norov <yury.norov@gmail.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Jin Yao <yao.jin@linux.intel.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Leo Yan <leo.yan@linaro.org>, Andi Kleen <ak@linux.intel.com>,
        Thomas Richter <tmricht@linux.ibm.com>,
        Kan Liang <kan.liang@linux.intel.com>,
        Madhavan Srinivasan <maddy@linux.ibm.com>,
        Shunsuke Nakamura <nakamura.shun@fujitsu.com>,
        Song Liu <song@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Miaoqian Lin <linmq006@gmail.com>,
        Stephen Brennan <stephen.s.brennan@oracle.com>,
        Kajol Jain <kjain@linux.ibm.com>,
        Alexey Bayduraev <alexey.v.bayduraev@linux.intel.com>,
        German Gomez <german.gomez@arm.com>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
        Eric Dumazet <edumazet@google.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        masami.hiramatsu.pt@hitachi.com, eranian@google.com
Subject: Re: [PATCH v2 0/4] Reference count checker and related fixes
Message-ID: <Yffx+2uarK5Y15TF@kernel.org>
References: <20220125204602.4137477-1-irogers@google.com>
 <CAP-5=fXyJeX3b3egcAOfPndmYhakrsdKu7HttnHEH2DKP-6Vxw@mail.gmail.com>
 <20220128142348.17d51894dbdb35c9a9449567@kernel.org>
 <CAP-5=fXHudKqO4+0rbO9X3Ny+Cq7+KsHbKf4P8P24SjF0S232Q@mail.gmail.com>
 <20220129003450.77116209763f7e06d285e654@kernel.org>
 <CAP-5=fVoP9MAVsj7SdrxRjkr1Jt=XZ7Vf_FAooXA7B2OrC=XMA@mail.gmail.com>
 <YfRLEel7/nxWSgIP@kernel.org>
 <20220130170418.40d812169bcae1323f8b20bf@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220130170418.40d812169bcae1323f8b20bf@kernel.org>
X-Url:  http://acmel.wordpress.com
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Sun, Jan 30, 2022 at 05:04:18PM +0900, Masami Hiramatsu escreveu:
> On Fri, 28 Jan 2022 16:59:13 -0300 Arnaldo Carvalho de Melo <acme@kernel.org> wrote:
> > I went back to that discussion and saw this part where I brainstormed
> > about doing all this in unmodified binaries:

> > https://lore.kernel.org/all/20151209134138.GB15864@kernel.org/

> > Even Alexei chimed in and replied to that thinking it was doable:

> > https://lore.kernel.org/all/20151210033139.GA10056@ast-mbp.thefacebook.com/#t

> > And nowadays we have much better BPF infrastructure, much faster probes,
> > etc.

> Yeah I think now we (will) have faster user-event[1] too. :)

> [1] https://lore.kernel.org/all/20220118204326.2169-1-beaub@linux.microsoft.com/T/#u

> So instead of allocating an indirect object on get(), we also can define
> an event and send it to the kernel, and run a BPF to analyze it.
> Note that this will *NOT* be able to detect the "use-after-put" unless
> we automatically trace the all object field access ;-)

Humm, reading https://blog.janestreet.com/magic-trace/:

"I spent a bunch of time looking for a better solution and eventually I
found a really satisfying one in the perf_event_open docs. It turns out
that perf_event_open can use hardware breakpoints and notify you when a
memory address is executed or accessed."

I.e. after the last put we could automagically add a:

  mem:<addr>[/len][:access]                          [Hardware breakpoint]

But there are only HBP_NUM hardware breakpoints (4 on x86)... So some
sort of scheduling would be needed, or after last put add it then, leave
it there for some time, then stop tracking it, reusing it for some other
object, etc. We would be able to catch some of the problems sometimes.

For things that do use-after-free straight away we would get some of
these and fix it, making this tunable (the time to track a object after
it is last put) should be possible.

> Hm, apart from this topic, isn't it good to introduce user-space trace
> event( macro)s in perf tools? :-)

Yeah, this seems to be an interesting case for that.

- Arnaldo
