Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4DF984AFC2D
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Feb 2022 19:58:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236178AbiBIS4x (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Feb 2022 13:56:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51140 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242003AbiBIS40 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Feb 2022 13:56:26 -0500
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com [IPv6:2a00:1450:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 885B0C0F86BB;
        Wed,  9 Feb 2022 10:53:59 -0800 (PST)
Received: by mail-wr1-x42a.google.com with SMTP id m14so5610460wrg.12;
        Wed, 09 Feb 2022 10:53:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=BtzTMOT0+sBk3EssdjdzQc5R4rPNCZUOoytEFOC01Bo=;
        b=lYii6uB+B/88ZFyjNrobl6cN/ft299eJffsi0gG6SeXZZpYJaw4iLhgcnsl8IIejOH
         EwhN1Tw3+t7A8pBdmhCrlyCEOTVAGj07GIDC4l7x/vXo272i9cNSyomZxy31Wplg0HiM
         TLcga2CRXHsOankzSdZB9RIjU6Bx1WJhVdDbVH0esFMh1OmmhluFFw6FQ0qvZ6ngLlUk
         /b6JXi9VytfYXJK7F/VQkj8qzaohiI+6Dmjuclxsxn3MSMF2GAEbc9I3d9nb9NB35XQJ
         f0cjIvZEcsvceOD7vEuFyr2AQEpF+P+wgfcSUrxaWJC3uDwWkgSueDBV9BaWh3WEKyVZ
         xv0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=BtzTMOT0+sBk3EssdjdzQc5R4rPNCZUOoytEFOC01Bo=;
        b=giXOCv0zFmebvAFSUIMzdEnEYSEeI2ns9KMwNsFIu34dAT94mQYOupU5X3NzuMLTon
         VaiLzP+WzMZy9kQRHce+zPD4xESo2eU70JWKomljjJpzNc9QdY+3jWjnZBGDLJe/qoNV
         zP03iQtGR+eD9HskKOqo75PtoFVK8zlTRKK0P1PDm/CZbVQbUhzs4+miIWb7+CWMde9k
         V8gwO7e1cM1fp0JOIrjcE+77Elryi5reQuJ41Ca+ADGCapF0MXnWDK3cZuGwMxZ/GxMA
         5saQQyQu/vHwfnY89FDnKmx3orDPjQIWSjlvndcfPpAVpb6yalM1ISdjvhF+XIcmFKy9
         kR6g==
X-Gm-Message-State: AOAM5319XiZKfMBmjSJZl8F/YoSt+nlIWZ9AtSnw9fYq6wiHj81ySEx1
        EETWl7/Zc1KHUsBfH6M+JYM=
X-Google-Smtp-Source: ABdhPJyvzElixnNpo9JgrPbLDI6oOJkOUXiGOrsXo+AxQQafg/58wV6viJZEP+J8E091ctAinTkLsw==
X-Received: by 2002:adf:ea8f:: with SMTP id s15mr3118273wrm.547.1644432837862;
        Wed, 09 Feb 2022 10:53:57 -0800 (PST)
Received: from krava ([83.240.63.12])
        by smtp.gmail.com with ESMTPSA id t14sm5799523wmq.43.2022.02.09.10.53.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Feb 2022 10:53:57 -0800 (PST)
Date:   Wed, 9 Feb 2022 19:53:55 +0100
From:   Jiri Olsa <olsajiri@gmail.com>
To:     Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>
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
Message-ID: <YgQNw2F14IimhiCl@krava>
References: <20220208140725.3947-1-changbin.du@gmail.com>
 <YgPXTe7LlTfh+z4S@krava>
 <YgPir+Um+a2ZQ2gz@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YgPir+Um+a2ZQ2gz@kernel.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 09, 2022 at 12:50:07PM -0300, Arnaldo Carvalho de Melo wrote:
> Em Wed, Feb 09, 2022 at 04:01:33PM +0100, Jiri Olsa escreveu:
> > On Tue, Feb 08, 2022 at 10:07:25PM +0800, Changbin Du wrote:
> > > The function trace__symbols_init() runs "perf-read-vdso32" and that ends up
> > > with a SIGCHLD delivered to 'perf'. And this SIGCHLD make perf exit early.
> > > 
> > > 'perf trace' should exit only if the SIGCHLD is from our workload process.
> > > So let's use sigaction() instead of signal() to match such condition.
> > > 
> > > Signed-off-by: Changbin Du <changbin.du@gmail.com>
> > 
> > good idea, I tested with the reproducer for:
> >   f06a82f9d31a perf trace: Avoid early exit due to running SIGCHLD handler before it makes sense to
> > 
> > and it's working properly
> > 
> > Acked-by: Jiri Olsa <jolsa@kernel.org>
> 
> So can I replace this with the stronger:
> 
> Tested-by: Jiri Olsa <jolsa@kernel.org>

I did not see the case described in the changelog,
just checked the other one was fine..

jirka

> 
> ?
> 
> - Arnaldo
>  
> > thanks,
> > jirka
> > 
> > > ---
> > >  tools/perf/builtin-trace.c | 21 ++++++++++++++++-----
> > >  1 file changed, 16 insertions(+), 5 deletions(-)
> > > 
> > > diff --git a/tools/perf/builtin-trace.c b/tools/perf/builtin-trace.c
> > > index 32844d8a0ea5..d03556c14b0a 100644
> > > --- a/tools/perf/builtin-trace.c
> > > +++ b/tools/perf/builtin-trace.c
> > > @@ -1536,13 +1536,20 @@ static size_t trace__fprintf_tstamp(struct trace *trace, u64 tstamp, FILE *fp)
> > >  	return fprintf(fp, "         ? ");
> > >  }
> > >  
> > > +static pid_t workload_pid = -1;
> > >  static bool done = false;
> > >  static bool interrupted = false;
> > >  
> > > -static void sig_handler(int sig)
> > > +static void sighandler_interrupt(int sig __maybe_unused)
> > >  {
> > > -	done = true;
> > > -	interrupted = sig == SIGINT;
> > > +	done = interrupted = true;
> > > +}
> > > +
> > > +static void sighandler_chld(int sig __maybe_unused, siginfo_t *info,
> > > +			    void *context __maybe_unused)
> > > +{
> > > +	if (info->si_pid == workload_pid)
> > > +		done = true;
> > >  }
> > >  
> > >  static size_t trace__fprintf_comm_tid(struct trace *trace, struct thread *thread, FILE *fp)
> > > @@ -3938,7 +3945,6 @@ static int trace__run(struct trace *trace, int argc, const char **argv)
> > >  	bool draining = false;
> > >  
> > >  	trace->live = true;
> > > -	signal(SIGCHLD, sig_handler);
> > >  
> > >  	if (!trace->raw_augmented_syscalls) {
> > >  		if (trace->trace_syscalls && trace__add_syscall_newtp(trace))
> > > @@ -4018,6 +4024,7 @@ static int trace__run(struct trace *trace, int argc, const char **argv)
> > >  			fprintf(trace->output, "Couldn't run the workload!\n");
> > >  			goto out_delete_evlist;
> > >  		}
> > > +		workload_pid = evlist->workload.pid;
> > >  	}
> > >  
> > >  	err = evlist__open(evlist);
> > > @@ -4887,10 +4894,14 @@ int cmd_trace(int argc, const char **argv)
> > >  	const char * const trace_subcommands[] = { "record", NULL };
> > >  	int err = -1;
> > >  	char bf[BUFSIZ];
> > > +	struct sigaction sigchld_act = { 0 };
> > >  
> > >  	signal(SIGSEGV, sighandler_dump_stack);
> > >  	signal(SIGFPE, sighandler_dump_stack);
> > > -	signal(SIGINT, sig_handler);
> > > +	signal(SIGINT, sighandler_interrupt);
> > > +	sigchld_act.sa_flags = SA_SIGINFO;
> > > +	sigchld_act.sa_sigaction = sighandler_chld;
> > > +	sigaction(SIGCHLD, &sigchld_act, NULL);
> > >  
> > >  	trace.evlist = evlist__new();
> > >  	trace.sctbl = syscalltbl__new();
> > > -- 
> > > 2.25.1
> > > 
> 
> -- 
> 
> - Arnaldo
