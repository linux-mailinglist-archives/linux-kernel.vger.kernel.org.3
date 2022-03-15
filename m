Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DE7804DA196
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Mar 2022 18:52:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245048AbiCORxX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Mar 2022 13:53:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50386 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237757AbiCORxW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Mar 2022 13:53:22 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 82F4B5370A
        for <linux-kernel@vger.kernel.org>; Tue, 15 Mar 2022 10:52:09 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 214A461605
        for <linux-kernel@vger.kernel.org>; Tue, 15 Mar 2022 17:52:09 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 33472C340EE;
        Tue, 15 Mar 2022 17:52:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1647366728;
        bh=GfWeXmiwatM5isjJvbWUTXTOjbzvbYRa9uSBkgcYPIo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=drjL+GR2E/9f9uHw2y8yO6WfbmxNUMNpWuDFwnQoOVYcqNQvK2PjGoLo9MWFzs2z3
         V4nd5nHUyyRkdg6+SeDsaUBADh0QHV2aPcQPcKGF6Q+s5hod+/G04JW3cp2oH0A7Pz
         huz1T8jkrFEdUSsrAR3jqdofQjQWizazbqiwP4UN9ineddm/xVeaWjTe9oCj4NteDr
         x8K8p5bhsUmUrw/NKzSgoaUjvEMwJ83y0xp4A7+hgd3RB+x3I5n6N8ou9CAThGUkut
         HRUdGdd92Tf3T3pShzzjZ2Zgnmx9yl2BetPNiNrnQEoYQy22wSfhcEdgAVwONnA8UF
         BXiMGp4fzA0Rw==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id BB6A640407; Tue, 15 Mar 2022 14:52:05 -0300 (-03)
Date:   Tue, 15 Mar 2022 14:52:05 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com>
Cc:     cclaudio@linux.ibm.com, Jiri Olsa <jolsa@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Namhyung Kim <namhyung@kernel.org>
Subject: Re: [PATCH] perf trace: Fix SIGSEGV when processing augmented args
Message-ID: <YjDSRb1wwswKpJNJ@kernel.org>
References: <20220310104741.209834-1-naveen.n.rao@linux.vnet.ibm.com>
 <Yi+9G1nK1shEIXVN@kernel.org>
 <1647364864.3xrhklc7kl.naveen@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1647364864.3xrhklc7kl.naveen@linux.ibm.com>
X-Url:  http://acmel.wordpress.com
X-Spam-Status: No, score=-8.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Tue, Mar 15, 2022 at 10:57:57PM +0530, Naveen N. Rao escreveu:
> Arnaldo Carvalho de Melo wrote:
> > Em Thu, Mar 10, 2022 at 04:17:41PM +0530, Naveen N. Rao escreveu:
> > > On powerpc, 'perf trace' is crashing with a SIGSEGV when trying to
> > > process a perf data file created with 'perf trace record -p':
> > 
> > >   #0  0x00000001225b8988 in syscall_arg__scnprintf_augmented_string <snip> at builtin-trace.c:1492
> > >   #1  syscall_arg__scnprintf_filename <snip> at builtin-trace.c:1492
> > >   #2  syscall_arg__scnprintf_filename <snip> at builtin-trace.c:1486
> > >   #3  0x00000001225bdd9c in syscall_arg_fmt__scnprintf_val <snip> at builtin-trace.c:1973
> > >   #4  syscall__scnprintf_args <snip> at builtin-trace.c:2041
> > >   #5  0x00000001225bff04 in trace__sys_enter <snip> at builtin-trace.c:2319
> > 
> > > The size captured in the augmented arg looks corrupt, resulting in the
> > > augmented arg pointer being adjusted incorrectly. Fix this by checking
> > > that the size is reasonable.
> > 
> > > Reported-by: Claudio Carvalho <cclaudio@linux.ibm.com>
> > > Signed-off-by: Naveen N. Rao <naveen.n.rao@linux.vnet.ibm.com>
> > > ---
> > > While this resolves the 'perf trace' crash, I'm not yet sure why the
> > > size for the augmented arg is corrupt. This looks to be happening when
> > > processing the sample for 'read' syscall. Any pointers?
> > 
> > Strange indeed, the augmented args code should kick in when the payload
> > for some tracepoint is bigger than what is expected, i.e. more than the
> > sum of its arguments, in which case it assumes that what is coming after
> > the expected payload comes with, say, the pathname for an open, openat,
> > etc syscall, that otherwise would be just a pointer.
> > 
> > This augmentation is done using something like
> > tools/perf/examples/bpf/augmented_raw_syscalls.c, i.e.:
> > 
> > [root@quaco ~]# perf trace -e openat sleep 1
> >      0.000 openat(dfd: CWD, filename: 0x1bbb0b6, flags: RDONLY|CLOEXEC) = 3
> >      0.021 openat(dfd: CWD, filename: 0x1bc8e80, flags: RDONLY|CLOEXEC) = 3
> >      0.201 openat(dfd: CWD, filename: 0x1b34f20, flags: RDONLY|CLOEXEC) = 3
> > [root@quaco ~]# perf trace -e ~acme/git/perf/tools/perf/examples/bpf/augmented_raw_syscalls.c,openat sleep 1
> >      0.000 openat(dfd: CWD, filename: "/etc/ld.so.cache", flags: RDONLY|CLOEXEC) = 3
> >      0.023 openat(dfd: CWD, filename: "/lib64/libc.so.6", flags: RDONLY|CLOEXEC) = 3
> >      0.225 openat(dfd: CWD, filename: "/usr/lib/locale/locale-archive", flags: RDONLY|CLOEXEC) = 3
> > [root@quaco ~]#
 
> Thanks, that clarifies things a bit. I was under the impression that
> syscalls are augmented through the bpf program by default. But, it looks
> like that isn't the case (at least on the distro where this problem was
> reported).

Its not by default at the moment.

This was an experiment in getting perf to get assistance from eBPF, but
this predates eBPF skeletons, sleepable tracepoints, tons of stuff that
it should instead be using by now.

We now have:

⬢[acme@toolbox perf]$ ls -la tools/perf/util/bpf_skel/
total 172
drwxr-xr-x. 1 acme acme  232 Mar 14 17:56 .
drwxr-xr-x. 1 acme acme 6978 Mar 14 19:15 ..
-rw-r--r--. 1 acme acme 4592 Mar 14 17:54 bperf_cgroup.bpf.c
-rw-r--r--. 1 acme acme 1764 Mar 14 17:55 bperf_follower.bpf.c
-rw-r--r--. 1 acme acme 1438 Mar 14 17:55 bperf_leader.bpf.c
-rw-r--r--. 1 acme acme  285 Mar 14 17:54 bperf_u.h
-rw-r--r--. 1 acme acme 2290 Mar 14 17:55 bpf_prog_profiler.bpf.c
-rw-r--r--. 1 acme acme 2115 Mar 14 17:56 func_latency.bpf.c
-rw-r--r--. 1 acme acme   53 Nov  6 17:43 .gitignore
⬢[acme@toolbox perf]$

'perf trace' needs to switch to using that method as well.
 
> > So it seems the perf.data file being processed is corrupted somehow...

> > Perhaps we should check if the syscall has pointer args and if not don't
> > kick in the augmented code and instead emit some warning about having
> > more payload than expected.
 
> Yes, it looks like the current check in 'perf' isn't working. The below
> patch also resolves the crash we are seeing:
 
> diff --git a/tools/perf/builtin-trace.c b/tools/perf/builtin-trace.c
> index 2f1d20553a0aa3..86b459f4ebdd61 100644
> --- a/tools/perf/builtin-trace.c
> +++ b/tools/perf/builtin-trace.c
> @@ -2326,7 +2326,7 @@ static int trace__sys_enter(struct trace *trace, struct evsel *evsel,
>         * thinking that the extra 2 u64 args are the augmented filename, so just check
>         * here and avoid using augmented syscalls when the evsel is the raw_syscalls one.
>         */
> -       if (evsel != trace->syscalls.events.sys_enter)
> +       if (strcmp(evsel__name(evsel), "raw_syscalls:sys_enter"))
>                augmented_args = syscall__augmented_args(sc, sample, &augmented_args_size, trace->raw_augmented_syscalls_args_size);
>        ttrace->entry_time = sample->time;
>        msg = ttrace->entry_str;

Interesting, that should be equivalent :-\ humm, not really, understood,
when processing perf.data files we don't setup
trace->syscalls.events.sys_enter...

switching from strcmp() to something cheaper but equivalent should be
the fix for now.

- Arnaldo
