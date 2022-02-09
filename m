Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3FC614AF498
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Feb 2022 16:01:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235412AbiBIPBh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Feb 2022 10:01:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48582 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235398AbiBIPBf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Feb 2022 10:01:35 -0500
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com [IPv6:2a00:1450:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 21A36C05CB82;
        Wed,  9 Feb 2022 07:01:38 -0800 (PST)
Received: by mail-ed1-x534.google.com with SMTP id co28so5736401edb.1;
        Wed, 09 Feb 2022 07:01:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=59r6R8CamhNOPJf3ecn98Vx3RC5ol7vbLhaSn6mMvIo=;
        b=pDois4WM2LuDFwB6uV9Teb2Kp/HL9tcYymFG1NtByoNhF1AsQVwIw9j1rpCJx0qnhd
         E/I14wGx5viSrfhS/qVQbf4T4PiJY3TR1XMxgbfCUcNQBWLOqMIEiCVA+1pJu5d2AZCd
         Mz1f2fmrcyfB5wqDJmsdTBN6voCGrhsLcB2o0+i8l+Rlj+AtcYxRNrZMU8lBeIdkmDt9
         q3RHuVwna+u89qpLbMlS4ItLIOjldB1NkFOdJlIRMh6e43uJS61zSFgE9HwFDQbt92c8
         PoFHmTJFj9P2LRJ1RPbODqPWcQrUr8G0DMWc2R0c5fUIElzFBztk/GqXLenIRFYXnzud
         MZGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=59r6R8CamhNOPJf3ecn98Vx3RC5ol7vbLhaSn6mMvIo=;
        b=3KKx+fHwTnGQtJOlKifp7Y9suqpmFQyuIZ70wzzEwFBG4208OZTCzF2feNXx/lz7wR
         /GN60sAwmNDZfGcfEHUWnc9rVUgeyKNSM13uwTCGwjRoVCSurqR5Wz13futrdjQFfmAq
         xLAvNV/teIzHFx/xG9YPEJY0FJwVQjTuUR1cNRACNc6KC92dBCY7GFw8kCEym3lWhC99
         Ga2x7s5k0BSek0z3Ickx0lfsmjPtum9IgkGWQp1tr2XQvvj03YHmEdqFYVW5eMyxueqX
         vpnLApJf0/AcPFWrxfrrBFNTo8ZA3/uA2B5PFXyQW72xiSKHYqAFjW+3xZvUkXaadOAM
         3yqw==
X-Gm-Message-State: AOAM533iNWSMBKjJQtrNpp5BmGxaeI3aG74cdlxmhtUrLk1WUAd5lJD+
        thMZE9JhFdgKAgZk2Fqaf4Y=
X-Google-Smtp-Source: ABdhPJwXAxrfPJb44M4LeeNM483CiJ585siYPRo0OVr63jw5Iuz0JGdpxelD3ErnrC2t6yDfzUCDPg==
X-Received: by 2002:aa7:d84e:: with SMTP id f14mr2884470eds.46.1644418896457;
        Wed, 09 Feb 2022 07:01:36 -0800 (PST)
Received: from krava ([2a00:102a:5010:3235:47fb:6193:ef68:761d])
        by smtp.gmail.com with ESMTPSA id gu2sm6024567ejb.221.2022.02.09.07.01.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Feb 2022 07:01:36 -0800 (PST)
Date:   Wed, 9 Feb 2022 16:01:33 +0100
From:   Jiri Olsa <olsajiri@gmail.com>
To:     Changbin Du <changbin.du@gmail.com>
Cc:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] perf trace: Avoid early exit due SIGCHLD from
 non-workload processes
Message-ID: <YgPXTe7LlTfh+z4S@krava>
References: <20220208140725.3947-1-changbin.du@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220208140725.3947-1-changbin.du@gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 08, 2022 at 10:07:25PM +0800, Changbin Du wrote:
> The function trace__symbols_init() runs "perf-read-vdso32" and that ends up
> with a SIGCHLD delivered to 'perf'. And this SIGCHLD make perf exit early.
> 
> 'perf trace' should exit only if the SIGCHLD is from our workload process.
> So let's use sigaction() instead of signal() to match such condition.
> 
> Signed-off-by: Changbin Du <changbin.du@gmail.com>

good idea, I tested with the reproducer for:
  f06a82f9d31a perf trace: Avoid early exit due to running SIGCHLD handler before it makes sense to

and it's working properly

Acked-by: Jiri Olsa <jolsa@kernel.org>

thanks,
jirka

> ---
>  tools/perf/builtin-trace.c | 21 ++++++++++++++++-----
>  1 file changed, 16 insertions(+), 5 deletions(-)
> 
> diff --git a/tools/perf/builtin-trace.c b/tools/perf/builtin-trace.c
> index 32844d8a0ea5..d03556c14b0a 100644
> --- a/tools/perf/builtin-trace.c
> +++ b/tools/perf/builtin-trace.c
> @@ -1536,13 +1536,20 @@ static size_t trace__fprintf_tstamp(struct trace *trace, u64 tstamp, FILE *fp)
>  	return fprintf(fp, "         ? ");
>  }
>  
> +static pid_t workload_pid = -1;
>  static bool done = false;
>  static bool interrupted = false;
>  
> -static void sig_handler(int sig)
> +static void sighandler_interrupt(int sig __maybe_unused)
>  {
> -	done = true;
> -	interrupted = sig == SIGINT;
> +	done = interrupted = true;
> +}
> +
> +static void sighandler_chld(int sig __maybe_unused, siginfo_t *info,
> +			    void *context __maybe_unused)
> +{
> +	if (info->si_pid == workload_pid)
> +		done = true;
>  }
>  
>  static size_t trace__fprintf_comm_tid(struct trace *trace, struct thread *thread, FILE *fp)
> @@ -3938,7 +3945,6 @@ static int trace__run(struct trace *trace, int argc, const char **argv)
>  	bool draining = false;
>  
>  	trace->live = true;
> -	signal(SIGCHLD, sig_handler);
>  
>  	if (!trace->raw_augmented_syscalls) {
>  		if (trace->trace_syscalls && trace__add_syscall_newtp(trace))
> @@ -4018,6 +4024,7 @@ static int trace__run(struct trace *trace, int argc, const char **argv)
>  			fprintf(trace->output, "Couldn't run the workload!\n");
>  			goto out_delete_evlist;
>  		}
> +		workload_pid = evlist->workload.pid;
>  	}
>  
>  	err = evlist__open(evlist);
> @@ -4887,10 +4894,14 @@ int cmd_trace(int argc, const char **argv)
>  	const char * const trace_subcommands[] = { "record", NULL };
>  	int err = -1;
>  	char bf[BUFSIZ];
> +	struct sigaction sigchld_act = { 0 };
>  
>  	signal(SIGSEGV, sighandler_dump_stack);
>  	signal(SIGFPE, sighandler_dump_stack);
> -	signal(SIGINT, sig_handler);
> +	signal(SIGINT, sighandler_interrupt);
> +	sigchld_act.sa_flags = SA_SIGINFO;
> +	sigchld_act.sa_sigaction = sighandler_chld;
> +	sigaction(SIGCHLD, &sigchld_act, NULL);
>  
>  	trace.evlist = evlist__new();
>  	trace.sctbl = syscalltbl__new();
> -- 
> 2.25.1
> 
