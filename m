Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B6D734E7DB9
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Mar 2022 01:23:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233587AbiCYVzg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Mar 2022 17:55:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47110 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233577AbiCYVze (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Mar 2022 17:55:34 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D106F13EB7
        for <linux-kernel@vger.kernel.org>; Fri, 25 Mar 2022 14:53:58 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 5D3EB6104F
        for <linux-kernel@vger.kernel.org>; Fri, 25 Mar 2022 21:53:58 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6968EC2BBE4;
        Fri, 25 Mar 2022 21:53:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1648245237;
        bh=hruywCO7hLvpaXexVafWlwZPQ0LOjKiVRCERvjdedPE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=HCdDtrBpZZY0lSYemYpu0Jk/l5VmdP37JwCdHVui8j8txCS6PV92/5dFQCEta+Rda
         CUxQtPhI0mSu+0AUmI4ypL9f5nWYA3QOvpEoLtfwX1ZQauDnlhXac30LKVbeZLsrPs
         vSQDKvIUYpu7q/uyshlFgw5PUSL1Ed47Fft3KeEWWTqbLJw/z4TwgQ3bIsdwY7nFa9
         +Dgo1kKVjBgaBvzxiELNizn05p3Akwn1wNzRmN/BjsHd3HQKcbR3uiA6r5+dL3vcQp
         /bYdKSphxjczfeE9iIcSMQS47iYlTRC9fit+0zLdkCmZy4NgT3A61ip9SRtaQHOwuj
         o6UyaRztt//Cg==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id C731640407; Fri, 25 Mar 2022 18:53:54 -0300 (-03)
Date:   Fri, 25 Mar 2022 18:53:54 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Stephane Eranian <eranian@google.com>
Cc:     linux-kernel@vger.kernel.org, peterz@infradead.org,
        kim.phillips@amd.com, acme@redhat.com, jolsa@redhat.com,
        songliubraving@fb.com, rafael@kernel.org, ravi.bangoria@amd.com,
        sandipan.das@amd.com
Subject: Re: [PATCH v7 11/13] perf tools: Improve IBS error handling
Message-ID: <Yj458u2fMgyCO70i@kernel.org>
References: <20220322221517.2510440-1-eranian@google.com>
 <20220322221517.2510440-12-eranian@google.com>
 <Yj44ICldLB6h0Mcu@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Yj44ICldLB6h0Mcu@kernel.org>
X-Url:  http://acmel.wordpress.com
X-Spam-Status: No, score=-8.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Fri, Mar 25, 2022 at 06:46:08PM -0300, Arnaldo Carvalho de Melo escreveu:
> Em Tue, Mar 22, 2022 at 03:15:15PM -0700, Stephane Eranian escreveu:
> > From: Kim Phillips <kim.phillips@amd.com>
> > 
> > improve the error message returned on failed perf_event_open() on AMD when
> > using IBS.
> > 
> > Output of executing 'perf record -e ibs_op// true' BEFORE this patch:
> > 
> > The sys_perf_event_open() syscall returned with 22 (Invalid argument)for event (ibs_op//u).
> > /bin/dmesg | grep -i perf may provide additional information.
> > 
> > Output after:
> > 
> > AMD IBS cannot exclude kernel events.  Try running at a higher privilege level.
> 
> So the error message don't match up the BEFORE part, that didn't have a
> "u" at the end, and with this patch in:

I see, the patch description doesn't mention that the BEFORE command is
run as a NON root user, when the 'u' suffix is auto-added by perf, I'm
ammending the comment log message with this.

Now it reads:

----------------------------------------------------------------------
perf evsel: Improve AMD IBS (Instruction-Based Sampling) error handling messages

Improve the error message returned on failed perf_event_open() on AMD
systems when using IBS (Instruction-Based Sampling).

Output of executing 'perf record -e ibs_op// true' as a non root user
BEFORE this patch (perf will add the 'u' modifier at the end to exclude
kernel/hypervisor sampling):

  The sys_perf_event_open() syscall returned with 22 (Invalid argument)for event (ibs_op//u).
  /bin/dmesg | grep -i perf may provide additional information.

Output after:

  AMD IBS can't exclude kernel events.  Try running at a higher privilege level.

Output of executing 'sudo perf record -e ibs_op// true' BEFORE this patch:

  Error:
  The sys_perf_event_open() syscall returned with 22 (Invalid argument) for event (ibs_op//).
  /bin/dmesg | grep -i perf may provide additional information.

Output after:

  Error:
  Invalid event (ibs_op//) in per-thread mode, enable system wide with '-a'.

Folowing the suggestion:

  $ sudo perf record -a -e ibs_op// true
  [ perf record: Woken up 1 times to write data ]
  [ perf record: Captured and wrote 1.664 MB perf.data (194 samples) ]
  $

Signed-off-by: Kim Phillips <kim.phillips@amd.com>
Tested-by: Arnaldo Carvalho de Melo <acme@redhat.com>
----------------------------------------------------------------------

This is all with:

[root@five ~]# uname -a
Linux five 5.16.16-200.fc35.x86_64 #1 SMP PREEMPT Sat Mar 19 13:52:41 UTC 2022 x86_64 x86_64 x86_64 GNU/Linux

- Arnaldo
 
>   $ git log --oneline -1
>   ca585f91ce13df4c (HEAD -> perf/core) perf evsel: Improve AMD IBS (Instruction-Based Sampling) error handling messages
>   # perf -v
>   perf version 5.17.gca585f91ce13
>   #
>   
> On a:
> 
>   # grep -m1 "model name" /proc/cpuinfo
>   model name	: AMD Ryzen 9 5950X 16-Core Processor
>   #
> 
> If I try:
> 
>   # perf record -e ibs_op//u true
>   Error:
>   Invalid event (ibs_op//u) in per-thread mode, enable system wide with '-a'.
>   # 
> 
> So now if I try:
> 
>   # perf record -a -e ibs_op//u true
>   Error:
>   AMD IBS can't exclude kernel events.  Try running at a higher privilege level.
>   #
> 
> So the problem is with the patch description, I'm fixing it.
> 
> > Output of executing 'sudo perf record -e ibs_op// true' BEFORE this patch:
> > 
> > Error:
> > The sys_perf_event_open() syscall returned with 22 (Invalid argument) for event (ibs_op//).
> > /bin/dmesg | grep -i perf may provide additional information.
> > 
> > Output after:
> > 
> > Error:
> > AMD IBS may only be available in system-wide/per-cpu mode.  Try using -a, or -C and workload affinity
> 
> But this one is never reached:
> 
> [root@five ~]# perf record -e ibs_op// true
> Error:
> Invalid event (ibs_op//) in per-thread mode, enable system wide with '-a'
> 
> > +                             if (!evsel->core.system_wide)
> > +                                     return scnprintf(msg, size,
> > +     "AMD IBS may only be available in system-wide/per-cpu mode.  Try using -a, or -C and workload affinity");
> 
> 
> I'm applying this to make progress, the message now provides more clues.
> 
> - Arnaldo
> 
>  
> > Signed-off-by: Kim Phillips <kim.phillips@amd.com>
> > Cc: Arnaldo Carvalho de Melo <acme@redhat.com>
> > Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
> > Cc: Boris Ostrovsky <boris.ostrovsky@oracle.com>
> > Cc: Ian Rogers <irogers@google.com>
> > Cc: Ingo Molnar <mingo@redhat.com>
> > Cc: Jiri Olsa <jolsa@redhat.com>
> > Cc: Joao Martins <joao.m.martins@oracle.com>
> > Cc: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
> > Cc: Mark Rutland <mark.rutland@arm.com>
> > Cc: Michael Petlan <mpetlan@redhat.com>
> > Cc: Namhyung Kim <namhyung@kernel.org>
> > Cc: Peter Zijlstra <peterz@infradead.org>
> > Cc: Robert Richter <robert.richter@amd.com>
> > Cc: Stephane Eranian <eranian@google.com>
> > ---
> >  tools/perf/util/evsel.c | 25 +++++++++++++++++++++++++
> >  1 file changed, 25 insertions(+)
> > 
> > diff --git a/tools/perf/util/evsel.c b/tools/perf/util/evsel.c
> > index 14b0e7ffa2c7..e8ff7a4bd490 100644
> > --- a/tools/perf/util/evsel.c
> > +++ b/tools/perf/util/evsel.c
> > @@ -2847,9 +2847,23 @@ static bool find_process(const char *name)
> >  	return ret ? false : true;
> >  }
> >  
> > +static bool is_amd(const char *arch, const char *cpuid)
> > +{
> > +	return arch && !strcmp("x86", arch) && cpuid && strstarts(cpuid, "AuthenticAMD");
> > +}
> > +
> > +static bool is_amd_ibs(struct evsel *evsel)
> > +{
> > +	return evsel->core.attr.precise_ip
> > +	    || (evsel->pmu_name && !strncmp(evsel->pmu_name, "ibs", 3));
> > +}
> > +
> >  int evsel__open_strerror(struct evsel *evsel, struct target *target,
> >  			 int err, char *msg, size_t size)
> >  {
> > +	struct perf_env *env = evsel__env(evsel);
> > +	const char *arch = perf_env__arch(env);
> > +	const char *cpuid = perf_env__cpuid(env);
> >  	char sbuf[STRERR_BUFSIZE];
> >  	int printed = 0, enforced = 0;
> >  
> > @@ -2949,6 +2963,17 @@ int evsel__open_strerror(struct evsel *evsel, struct target *target,
> >  			return scnprintf(msg, size,
> >  	"Invalid event (%s) in per-thread mode, enable system wide with '-a'.",
> >  					evsel__name(evsel));
> > +		if (is_amd(arch, cpuid)) {
> > +			if (is_amd_ibs(evsel)) {
> > +				if (evsel->core.attr.exclude_kernel)
> > +					return scnprintf(msg, size,
> > +	"AMD IBS can't exclude kernel events.  Try running at a higher privilege level.");
> > +				if (!evsel->core.system_wide)
> > +					return scnprintf(msg, size,
> > +	"AMD IBS may only be available in system-wide/per-cpu mode.  Try using -a, or -C and workload affinity");
> > +			}
> > +		}
> > +
> >  		break;
> >  	case ENODATA:
> >  		return scnprintf(msg, size, "Cannot collect data source with the load latency event alone. "
> > -- 
> > 2.35.1.894.gb6a874cedc-goog
> 
> -- 
> 
> - Arnaldo

-- 

- Arnaldo
