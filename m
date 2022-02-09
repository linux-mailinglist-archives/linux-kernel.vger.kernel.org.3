Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2C5174AFCF0
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Feb 2022 20:10:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231624AbiBITK0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Feb 2022 14:10:26 -0500
Received: from gmail-smtp-in.l.google.com ([23.128.96.19]:50092 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229683AbiBITKX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Feb 2022 14:10:23 -0500
Received: from mail-oi1-x231.google.com (mail-oi1-x231.google.com [IPv6:2607:f8b0:4864:20::231])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4EFD5C03C1AA;
        Wed,  9 Feb 2022 11:10:15 -0800 (PST)
Received: by mail-oi1-x231.google.com with SMTP id v67so3476195oie.9;
        Wed, 09 Feb 2022 11:10:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:user-agent:in-reply-to:references
         :message-id:mime-version:content-transfer-encoding;
        bh=Au/efsKl227W+HSNevOdcFtGZUbvTdCOpmyCg2tVPeU=;
        b=n32WNFQqk72P9Dbjjr/AFdfiFpiBXY+UdlwPOJMtICRgS2FnsaLcDda6gsHuyn6/DX
         13K9/9DdQFegRFCeSqULn6hlcWFxj1QmD8MWvvEi5wSIx1W6lvGxJsyAPz2PWylZ33BK
         eASxTJM1PgZXUfeOSZupnb/UY1ibSDDLg8EaJfnykgUzqG6V40dwB9G7rY10ml+Xp587
         Y5k+FwL2zlETZyJK7CCziq00WgSx7gfTq3lRtmqL8/c129M2owDtzVzE+vOB8ZM1DTyk
         uvp3o8YSIAVAdTrg3OsMVLTMT7imnRGMTC8TBSWRH4F3uyBdYcTGkAUn4EMsAesTBXKJ
         Cipg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:user-agent:in-reply-to
         :references:message-id:mime-version:content-transfer-encoding;
        bh=Au/efsKl227W+HSNevOdcFtGZUbvTdCOpmyCg2tVPeU=;
        b=nH9VFjb8m0hbz2zF5eU41pnyNzvNUFhto+H1Z3CIjSi0LVt4a49G3gK3PR7qimNY0Y
         JB6Axl5+NUl90JnXlI29xbeghYVRz2jcEiiegwruYlTbnya3TvLCRRXPqP3VgBHCr6xO
         64JEMxy9zHGjDYZ2qxWqPlw0XeY134U4KjIFTQWq+Uh7aHNb4tucW2nx7jOTjYRTVDkt
         IH88YOkI2EtOSC/sALrp/cZToPpAUPT/sETsQgr6EYfBBu/U6RfbkIYjZri9MKDazcxu
         vDonSvUrewHE/licSswK4oBAlGNiquf3LiuKicB83MJ/dIHvbx7nF4N+NxgI9dyFg4Rs
         bEGw==
X-Gm-Message-State: AOAM533I8ORAQMJ/T1FyXsgJEJ2jB2obNf4SM2MbgTyDp0a30+FplI6d
        eOYPgAE8Fa4Kkg+1u/gwS4BF9Vc31go=
X-Google-Smtp-Source: ABdhPJwkmrJWpaGSpmCaaJsQuwBbhZzunEOqgX//M49n3lml26Jz17mHQdBLhhfWOPvurbJf4f48gg==
X-Received: by 2002:a05:6808:1286:: with SMTP id a6mr2063371oiw.318.1644433800693;
        Wed, 09 Feb 2022 11:10:00 -0800 (PST)
Received: from [127.0.0.1] ([179.97.37.151])
        by smtp.gmail.com with ESMTPSA id x31sm1772487otb.55.2022.02.09.11.09.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 09 Feb 2022 11:10:00 -0800 (PST)
Date:   Wed, 09 Feb 2022 16:08:51 -0300
From:   Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>
To:     Jiri Olsa <olsajiri@gmail.com>
CC:     Changbin Du <changbin.du@gmail.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: =?US-ASCII?Q?Re=3A_=5BPATCH=5D_perf_trace=3A_Avoid_early_exit?= =?US-ASCII?Q?_due_SIGCHLD_from_non-workload_processes?=
User-Agent: K-9 Mail for Android
In-Reply-To: <YgQNw2F14IimhiCl@krava>
References: <20220208140725.3947-1-changbin.du@gmail.com> <YgPXTe7LlTfh+z4S@krava> <YgPir+Um+a2ZQ2gz@kernel.org> <YgQNw2F14IimhiCl@krava>
Message-ID: <3F9FD4A7-DF13-478F-9E4E-AAC6E6C1793D@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On February 9, 2022 3:53:55 PM GMT-03:00, Jiri Olsa <olsajiri@gmail=2Ecom>=
 wrote:
>On Wed, Feb 09, 2022 at 12:50:07PM -0300, Arnaldo Carvalho de Melo wrote:
>> Em Wed, Feb 09, 2022 at 04:01:33PM +0100, Jiri Olsa escreveu:
>> > On Tue, Feb 08, 2022 at 10:07:25PM +0800, Changbin Du wrote:
>> > > The function trace__symbols_init() runs "perf-read-vdso32" and that=
 ends up
>> > > with a SIGCHLD delivered to 'perf'=2E And this SIGCHLD make perf ex=
it early=2E
>> > >=20
>> > > 'perf trace' should exit only if the SIGCHLD is from our workload p=
rocess=2E
>> > > So let's use sigaction() instead of signal() to match such conditio=
n=2E
>> > >=20
>> > > Signed-off-by: Changbin Du <changbin=2Edu@gmail=2Ecom>
>> >=20
>> > good idea, I tested with the reproducer for:
>> >   f06a82f9d31a perf trace: Avoid early exit due to running SIGCHLD ha=
ndler before it makes sense to
>> >=20
>> > and it's working properly
>> >=20
>> > Acked-by: Jiri Olsa <jolsa@kernel=2Eorg>
>>=20
>> So can I replace this with the stronger:
>>=20
>> Tested-by: Jiri Olsa <jolsa@kernel=2Eorg>
>
>I did not see the case described in the changelog,
>just checked the other one was fine=2E=2E

Ok, I'll keep it as an acked-by then=2E

- Arnaldo
>
>jirka
>
>>=20
>> ?
>>=20
>> - Arnaldo
>> =20
>> > thanks,
>> > jirka
>> >=20
>> > > ---
>> > >  tools/perf/builtin-trace=2Ec | 21 ++++++++++++++++-----
>> > >  1 file changed, 16 insertions(+), 5 deletions(-)
>> > >=20
>> > > diff --git a/tools/perf/builtin-trace=2Ec b/tools/perf/builtin-trac=
e=2Ec
>> > > index 32844d8a0ea5=2E=2Ed03556c14b0a 100644
>> > > --- a/tools/perf/builtin-trace=2Ec
>> > > +++ b/tools/perf/builtin-trace=2Ec
>> > > @@ -1536,13 +1536,20 @@ static size_t trace__fprintf_tstamp(struct =
trace *trace, u64 tstamp, FILE *fp)
>> > >  	return fprintf(fp, "         ? ");
>> > >  }
>> > > =20
>> > > +static pid_t workload_pid =3D -1;
>> > >  static bool done =3D false;
>> > >  static bool interrupted =3D false;
>> > > =20
>> > > -static void sig_handler(int sig)
>> > > +static void sighandler_interrupt(int sig __maybe_unused)
>> > >  {
>> > > -	done =3D true;
>> > > -	interrupted =3D sig =3D=3D SIGINT;
>> > > +	done =3D interrupted =3D true;
>> > > +}
>> > > +
>> > > +static void sighandler_chld(int sig __maybe_unused, siginfo_t *inf=
o,
>> > > +			    void *context __maybe_unused)
>> > > +{
>> > > +	if (info->si_pid =3D=3D workload_pid)
>> > > +		done =3D true;
>> > >  }
>> > > =20
>> > >  static size_t trace__fprintf_comm_tid(struct trace *trace, struct =
thread *thread, FILE *fp)
>> > > @@ -3938,7 +3945,6 @@ static int trace__run(struct trace *trace, in=
t argc, const char **argv)
>> > >  	bool draining =3D false;
>> > > =20
>> > >  	trace->live =3D true;
>> > > -	signal(SIGCHLD, sig_handler);
>> > > =20
>> > >  	if (!trace->raw_augmented_syscalls) {
>> > >  		if (trace->trace_syscalls && trace__add_syscall_newtp(trace))
>> > > @@ -4018,6 +4024,7 @@ static int trace__run(struct trace *trace, in=
t argc, const char **argv)
>> > >  			fprintf(trace->output, "Couldn't run the workload!\n");
>> > >  			goto out_delete_evlist;
>> > >  		}
>> > > +		workload_pid =3D evlist->workload=2Epid;
>> > >  	}
>> > > =20
>> > >  	err =3D evlist__open(evlist);
>> > > @@ -4887,10 +4894,14 @@ int cmd_trace(int argc, const char **argv)
>> > >  	const char * const trace_subcommands[] =3D { "record", NULL };
>> > >  	int err =3D -1;
>> > >  	char bf[BUFSIZ];
>> > > +	struct sigaction sigchld_act =3D { 0 };
>> > > =20
>> > >  	signal(SIGSEGV, sighandler_dump_stack);
>> > >  	signal(SIGFPE, sighandler_dump_stack);
>> > > -	signal(SIGINT, sig_handler);
>> > > +	signal(SIGINT, sighandler_interrupt);
>> > > +	sigchld_act=2Esa_flags =3D SA_SIGINFO;
>> > > +	sigchld_act=2Esa_sigaction =3D sighandler_chld;
>> > > +	sigaction(SIGCHLD, &sigchld_act, NULL);
>> > > =20
>> > >  	trace=2Eevlist =3D evlist__new();
>> > >  	trace=2Esctbl =3D syscalltbl__new();
>> > > --=20
>> > > 2=2E25=2E1
>> > >=20
>>=20
>> --=20
>>=20
>> - Arnaldo
