Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A69D950F73F
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Apr 2022 11:39:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347664AbiDZJmQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Apr 2022 05:42:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49042 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347923AbiDZJeZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Apr 2022 05:34:25 -0400
Received: from euporie.uberspace.de (euporie.uberspace.de [185.26.156.232])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B34ED1C65C0
        for <linux-kernel@vger.kernel.org>; Tue, 26 Apr 2022 01:58:39 -0700 (PDT)
Received: (qmail 29195 invoked by uid 989); 26 Apr 2022 08:58:37 -0000
Authentication-Results: euporie.uberspace.de;
        auth=pass (plain)
Date:   Tue, 26 Apr 2022 10:58:26 +0200
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
Message-ID: <20220426085826.f4jfu4cszbmjlafw@pasture>
References: <20220420102354.468173-1-florian.fischer@muhq.space>
 <YmA48V09iBbqy6su@kernel.org>
 <CAM9d7cjcA0aYC1otY4WvCJ_h71P9wiHu42GK7iyv3=i01rQ26Q@mail.gmail.com>
 <20220423121557.z5gzbqadonmrg6ef@pasture>
 <CAM9d7cgcx42xD8QxOB+JBEL85mZU_va8FMiF31SRxABH8CakLg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAM9d7cgcx42xD8QxOB+JBEL85mZU_va8FMiF31SRxABH8CakLg@mail.gmail.com>
X-Rspamd-Bar: /
X-Rspamd-Report: MIME_GOOD(-0.1) MID_RHS_NOT_FQDN(0.5) BAYES_HAM(-1.363996)
X-Rspamd-Score: -0.963996
Received: from unknown (HELO unkown) (::1)
        by euporie.uberspace.de (Haraka/2.8.28) with ESMTPSA; Tue, 26 Apr 2022 10:58:37 +0200
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,
        MSGID_FROM_MTA_HEADER,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 25.04.2022 12:06, Namhyung Kim wrote:
> On Sat, Apr 23, 2022 at 5:16 AM Florian Fischer
> <florian.fischer@muhq.space> wrote:
> >
> > On 22.04.2022 16:52, Namhyung Kim wrote:
> > > Hello,
> > >
> > > On Fri, Apr 22, 2022 at 3:05 PM Arnaldo Carvalho de Melo
> > > <acme@kernel.org> wrote:
> > > >
> > > > Em Wed, Apr 20, 2022 at 12:23:51PM +0200, Florian Fischer escreveu:
> > > > > This patch series adds new internal events to perf stat exposing the times spend
> > > > > in user and kernel mode in nanoseconds reported by rusage.
> > > > >
> > > > > During some benchmarking using perf it bothered me that I could not easily
> > > > > retrieve those times from perf stat when using the machine readable output.
> > > > >
> > > > > But perf definitely knows about those values because in the human readable output
> > > > > they are present.
> > > > >
> > > > > Therefore I exposed the times reported by rusage via the new tool events:
> > > > > user_time and system_time.
> > > > >
> > > > > This allows to retrieved them in machine-readable output:
> > > > >
> > > > > $ ./perf stat -x, -e duration_time,user_time,system_time,cache-misses -- grep -q -r duration_time tools/perf
> > > > > 72134524,ns,duration_time:u,72134524,100.00,,
> > > > > 65225000,ns,user_time:u,65225000,100.00,,
> > > > > 6865000,ns,ssystem_time:u,6865000,100.00,,
> 
> > > Anyway it looks a little bit strange to me if we can get
> > > system time in user mode only (the 'u' modifier).
> >
> > Sorry but I don't really understand what you mean.
> > The system_time is reported to userspace via rusage filled by wait4(2).
> > It will always report the value reported to the user space regardless of what
> > counters perf has access to.
> >
> > If you run perf as user you get the same system_time (but with the ':u' suffix)
> > as when you run perf as root or lower kernel.perf_event_paranoid to allow access
> > to more counters.
> 
> The ':u' modifier means that the event should count only in user mode.
> So I think system_time:u should be 0 by definition.
> Likewise, user_time:k should be handled as such.

Not sure if this logic applies to tool events because the time spend in user mode
or kernel mdoe stays the same regardless of where you count it.

This is consistent with how duration_time works currently in perf stat.

./perf stat -e duration_time,duration_time:u,duration_time:k -- grep -q -r duration_time .

 Performance counter stats for 'grep -q -r duration_time .':

        29,012,558 ns   duration_time
        29,012,558 ns   duration_time:u
        29,012,558 ns   duration_time:k

       0.029012558 seconds time elapsed

       0.029088000 seconds user
       0.000000000 seconds sys

> 
> But as I said before, we already have the task-clock event, so it's not
> clear why we need this too.  Also these tool events won't work for
> other use cases like perf record.

Maybe I do not know enough about perf but I think this is not exactly how those
suffixes work. This is the output of perf of next-20220420 and my rusage tool
event patches applied:

$ sysctl kernel.perf_event_paranoid
kernel.perf_event_paranoid = -1

linux/tools/perf$ ./perf stat -e task-clock,task-clock:u,task-clock:k,\
                                 duration_time,duration_time:u,duration_time:k,\
                                 system_time,system_time:u,system_time:k,\
                                 user_time,user_time:u,user_time:k -- grep -q -r duration_time .

 Performance counter stats for 'grep -q -r duration_time .':

             42.30 msec task-clock                #    0.483 CPUs utilized
             42.30 msec task-clock:u              #    0.483 CPUs utilized
             42.30 msec task-clock:k              #    0.483 CPUs utilized
        87,533,340 ns   duration_time             #    2.069 G/sec
        87,533,340 ns   duration_time:u           #    2.069 G/sec
        87,533,340 ns   duration_time:k           #    2.069 G/sec
        12,841,000 ns   system_time               #  303.547 M/sec
        12,841,000 ns   system_time:u             #  303.547 M/sec
        12,841,000 ns   system_time:k             #  303.547 M/sec
        30,820,000 ns   user_time                 #  728.550 M/sec
        30,820,000 ns   user_time:u               #  728.550 M/sec
        30,820,000 ns   user_time:k               #  728.550 M/sec

       0.087533340 seconds time elapsed

       0.030820000 seconds user
       0.012841000 seconds sys


So task-clock regardless of its ':u' or ':k' suffix shows approximately the wall
clock time.

But for my experiments on a shared system where kernel.perf_event_paranoid is
not set to -1 and I feel uncomfortable to test research prototypes as root I
would like a simple and fast way to tell where my program spends its time.

This can be achieved by using user_time and system_time.
Which are reported in the human readable output anyway.

Maybe I am doing something wrong here but as shown above task-clock does not
provide the information I am interested in.

Florian Fischer
