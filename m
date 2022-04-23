Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ED7E250C9D7
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Apr 2022 14:16:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235394AbiDWMTK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 23 Apr 2022 08:19:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57838 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234127AbiDWMTI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 23 Apr 2022 08:19:08 -0400
Received: from euporie.uberspace.de (euporie.uberspace.de [185.26.156.232])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A9A257C16A
        for <linux-kernel@vger.kernel.org>; Sat, 23 Apr 2022 05:16:09 -0700 (PDT)
Received: (qmail 10142 invoked by uid 989); 23 Apr 2022 12:16:07 -0000
Authentication-Results: euporie.uberspace.de;
        auth=pass (plain)
Date:   Sat, 23 Apr 2022 14:15:57 +0200
From:   Florian Fischer <florian.fischer@muhq.space>
To:     Namhyung Kim <namhyung@gmail.com>
Cc:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        linux-perf-users <linux-perf-users@vger.kernel.org>,
        Ian Rogers <irogers@google.com>,
        Xing Zhengjun <zhengjun.xing@linux.intel.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>
Subject: Re: [PATCHSET v4 next 0/3] perf stat: add user_time and system_time
 tool events
Message-ID: <20220423121557.z5gzbqadonmrg6ef@pasture>
References: <20220420102354.468173-1-florian.fischer@muhq.space>
 <YmA48V09iBbqy6su@kernel.org>
 <CAM9d7cjcA0aYC1otY4WvCJ_h71P9wiHu42GK7iyv3=i01rQ26Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAM9d7cjcA0aYC1otY4WvCJ_h71P9wiHu42GK7iyv3=i01rQ26Q@mail.gmail.com>
X-Rspamd-Bar: /
X-Rspamd-Report: MIME_GOOD(-0.1) MID_RHS_NOT_FQDN(0.5) BAYES_HAM(-0.639367)
X-Rspamd-Score: -0.239367
Received: from unknown (HELO unkown) (::1)
        by euporie.uberspace.de (Haraka/2.8.28) with ESMTPSA; Sat, 23 Apr 2022 14:16:07 +0200
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,
        MSGID_FROM_MTA_HEADER,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 22.04.2022 16:52, Namhyung Kim wrote:
> Hello,
> 
> On Fri, Apr 22, 2022 at 3:05 PM Arnaldo Carvalho de Melo
> <acme@kernel.org> wrote:
> >
> > Em Wed, Apr 20, 2022 at 12:23:51PM +0200, Florian Fischer escreveu:
> > > This patch series adds new internal events to perf stat exposing the times spend
> > > in user and kernel mode in nanoseconds reported by rusage.
> > >
> > > During some benchmarking using perf it bothered me that I could not easily
> > > retrieve those times from perf stat when using the machine readable output.
> > >
> > > But perf definitely knows about those values because in the human readable output
> > > they are present.
> > >
> > > Therefore I exposed the times reported by rusage via the new tool events:
> > > user_time and system_time.
> > >
> > > This allows to retrieved them in machine-readable output:
> > >
> > > $ ./perf stat -x, -e duration_time,user_time,system_time,cache-misses -- grep -q -r duration_time tools/perf
> > > 72134524,ns,duration_time:u,72134524,100.00,,
> > > 65225000,ns,user_time:u,65225000,100.00,,
> > > 6865000,ns,ssystem_time:u,6865000,100.00,,
> 
> ssystem?  Looks like a typo.

Yes thanks. Fortunately I fixed it in the commit that got applied [1].

> 
> Anyway it looks a little bit strange to me if we can get
> system time in user mode only (the 'u' modifier).

Sorry but I don't really understand what you mean.
The system_time is reported to userspace via rusage filled by wait4(2).
It will always report the value reported to the user space regardless of what
counters perf has access to.

If you run perf as user you get the same system_time (but with the ':u' suffix)
as when you run perf as root or lower kernel.perf_event_paranoid to allow access
to more counters.

$ perf stat -x, -e system_time sync
31246000,ns,system_time:u,31246000,100.00,,

# perf stat -x, -e system_time sync
33794000,ns,system_time,33794000,100.00,,

> 
> Thanks,
> Namhyung
> 

Flo Fischer

[1] https://git.kernel.org/pub/scm/linux/kernel/git/acme/linux.git/commit/?h=tmp.perf/core&id=b03b89b350034f220cc24fc77c56990a97a796b2
