Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8E5724AF5BE
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Feb 2022 16:51:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236303AbiBIPu2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Feb 2022 10:50:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60650 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231163AbiBIPuY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Feb 2022 10:50:24 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A4AF7C0613C9;
        Wed,  9 Feb 2022 07:50:27 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 53D61B8219F;
        Wed,  9 Feb 2022 15:50:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A99BCC340E7;
        Wed,  9 Feb 2022 15:50:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1644421825;
        bh=wMNYrDXg2eHpDbxlrXn7r2hj+pvWdMuwOJy/MY0tMDg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=rOHL3v3Wkf6gp7AH52BgCfkRMhI06e+OP9ytlZElSwIuKi78ecjK/3PI7Z/lBDVt8
         xDeYXB3o5O8374P3RNUY79qg/vKyqpyk3G7MAKP29F1aJOpNn74XCq0f3t7coJOp+3
         qsoa+8f8JmBJIWa1ow3lBfse+BFBgwnDZJKLyU45hruLaYpwgQqib7S8T0R2jGvOiw
         gerlI0J4bEq7j/7VYMmTb23EP6NvsoqVpd2dnk19MMsxjCbPPRUCVcsawnbk9s3ZeW
         HodtwIviFB93fiU4Ru6f4Atm1bmU0pem/EOxLE4oPBJbBpumYNNZphYxdsG2cf2Yl5
         XR6nhjF0OPFpw==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id B910E400FE; Wed,  9 Feb 2022 12:50:07 -0300 (-03)
Date:   Wed, 9 Feb 2022 12:50:07 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Jiri Olsa <olsajiri@gmail.com>
Cc:     Changbin Du <changbin.du@gmail.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] perf trace: Avoid early exit due SIGCHLD from
 non-workload processes
Message-ID: <YgPir+Um+a2ZQ2gz@kernel.org>
References: <20220208140725.3947-1-changbin.du@gmail.com>
 <YgPXTe7LlTfh+z4S@krava>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YgPXTe7LlTfh+z4S@krava>
X-Url:  http://acmel.wordpress.com
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Wed, Feb 09, 2022 at 04:01:33PM +0100, Jiri Olsa escreveu:
> On Tue, Feb 08, 2022 at 10:07:25PM +0800, Changbin Du wrote:
> > The function trace__symbols_init() runs "perf-read-vdso32" and that ends up
> > with a SIGCHLD delivered to 'perf'. And this SIGCHLD make perf exit early.
> > 
> > 'perf trace' should exit only if the SIGCHLD is from our workload process.
> > So let's use sigaction() instead of signal() to match such condition.
> > 
> > Signed-off-by: Changbin Du <changbin.du@gmail.com>
> 
> good idea, I tested with the reproducer for:
>   f06a82f9d31a perf trace: Avoid early exit due to running SIGCHLD handler before it makes sense to
> 
> and it's working properly
> 
> Acked-by: Jiri Olsa <jolsa@kernel.org>

So can I replace this with the stronger:

Tested-by: Jiri Olsa <jolsa@kernel.org>

?

- Arnaldo
 
> thanks,
> jirka
> 
> > ---
> >  tools/perf/builtin-trace.c | 21 ++++++++++++++++-----
> >  1 file changed, 16 insertions(+), 5 deletions(-)
> > 
> > diff --git a/tools/perf/builtin-trace.c b/tools/perf/builtin-trace.c
> > index 32844d8a0ea5..d03556c14b0a 100644
> > --- a/tools/perf/builtin-trace.c
> > +++ b/tools/perf/builtin-trace.c
> > @@ -1536,13 +1536,20 @@ static size_t trace__fprintf_tstamp(struct trace *trace, u64 tstamp, FILE *fp)
> >  	return fprintf(fp, "         ? ");
> >  }
> >  
> > +static pid_t workload_pid = -1;
> >  static bool done = false;
> >  static bool interrupted = false;
> >  
> > -static void sig_handler(int sig)
> > +static void sighandler_interrupt(int sig __maybe_unused)
> >  {
> > -	done = true;
> > -	interrupted = sig == SIGINT;
> > +	done = interrupted = true;
> > +}
> > +
> > +static void sighandler_chld(int sig __maybe_unused, siginfo_t *info,
> > +			    void *context __maybe_unused)
> > +{
> > +	if (info->si_pid == workload_pid)
> > +		done = true;
> >  }
> >  
> >  static size_t trace__fprintf_comm_tid(struct trace *trace, struct thread *thread, FILE *fp)
> > @@ -3938,7 +3945,6 @@ static int trace__run(struct trace *trace, int argc, const char **argv)
> >  	bool draining = false;
> >  
> >  	trace->live = true;
> > -	signal(SIGCHLD, sig_handler);
> >  
> >  	if (!trace->raw_augmented_syscalls) {
> >  		if (trace->trace_syscalls && trace__add_syscall_newtp(trace))
> > @@ -4018,6 +4024,7 @@ static int trace__run(struct trace *trace, int argc, const char **argv)
> >  			fprintf(trace->output, "Couldn't run the workload!\n");
> >  			goto out_delete_evlist;
> >  		}
> > +		workload_pid = evlist->workload.pid;
> >  	}
> >  
> >  	err = evlist__open(evlist);
> > @@ -4887,10 +4894,14 @@ int cmd_trace(int argc, const char **argv)
> >  	const char * const trace_subcommands[] = { "record", NULL };
> >  	int err = -1;
> >  	char bf[BUFSIZ];
> > +	struct sigaction sigchld_act = { 0 };
> >  
> >  	signal(SIGSEGV, sighandler_dump_stack);
> >  	signal(SIGFPE, sighandler_dump_stack);
> > -	signal(SIGINT, sig_handler);
> > +	signal(SIGINT, sighandler_interrupt);
> > +	sigchld_act.sa_flags = SA_SIGINFO;
> > +	sigchld_act.sa_sigaction = sighandler_chld;
> > +	sigaction(SIGCHLD, &sigchld_act, NULL);
> >  
> >  	trace.evlist = evlist__new();
> >  	trace.sctbl = syscalltbl__new();
> > -- 
> > 2.25.1
> > 

-- 

- Arnaldo
