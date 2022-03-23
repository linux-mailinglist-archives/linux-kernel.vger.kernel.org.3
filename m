Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1D3584E5100
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Mar 2022 12:07:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235553AbiCWLIu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Mar 2022 07:08:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49436 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230491AbiCWLIr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Mar 2022 07:08:47 -0400
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com [IPv6:2a00:1450:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 01CBF4E3A6;
        Wed, 23 Mar 2022 04:07:16 -0700 (PDT)
Received: by mail-wm1-x32e.google.com with SMTP id bi13-20020a05600c3d8d00b0038c2c33d8f3so5059282wmb.4;
        Wed, 23 Mar 2022 04:07:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=hq6nUZV0XlZ/RqsQtO+1fxY1+aGbEavx3CUfaMrCtqI=;
        b=W5Lm58iCHqMzkYrrimwPH4ozcanhfBCwxVoWXLB3TKywim4JmnNxkC2aMaZAcxxDcn
         sjgb+85gwS5Ks/tUfac9K5ZWTJwEOchKr/fZhqdmkMKHU8WchPd3MgUkkQ2qEYOFq1bD
         lMYSHd8zcldJuKE+FdcWS4erfzg6WyduWKyBdTC/Lx2UZCx4Hn2p1nA+oORpW2D+jL7c
         sEjRhjHEwPnf6H8LFCPGCHQ5Nh0FU6bx4Nj+ygsskIA+jNDnyxc6FGXadtFLiNXZbd2W
         sfQ5n36w6SZ9Tkli1QJ8/gzZhlSwvD7W4b5kUQKyCx1E7o0hj8rzh2W5cx6W1loqhDPz
         6nxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=hq6nUZV0XlZ/RqsQtO+1fxY1+aGbEavx3CUfaMrCtqI=;
        b=Og+Qk65aXb5JUSFFHivAHiiXI1JeVPx9phUuBSIuPzqWQ4TDQOpgqvn4v7BLF/WKxV
         OOjclHOPsJb3K32FR7WCDnKsiqcM5Rs8e8zfRV+duNgrV0Tq4x5mFADh8GLdMrITpral
         OCu7nklwCTpc1sT/atA+oAl6XXTOuQj/suGr/hnoPWDuWl0cxj2SR2eauRts3AfeUBSG
         3X997y00jMvdax2iNv6TfYDjPK8P25dR9fgTusV9YUHeVQGshziGASfh96zNGjlVQXm2
         PE104NiWzazA8Pmss2utqrenSylOkLtb9Swjska13Tx1KMfQUSNbSLTiBVor1+z766iw
         1tzg==
X-Gm-Message-State: AOAM533RtA5rkghHKSDxHc4Z0+xLEHMnkhdCan5ss0B0vqrLf2dOeo0S
        RcJMUp+oUOScfp/BQBdm5lo=
X-Google-Smtp-Source: ABdhPJyTUuxn6mww8BxvM5Gj2TBPwrcWMqm4VQUhQpPOG3lvoLzN1+5YHIhEOh6ocsHUs/6zcHGbtA==
X-Received: by 2002:a7b:ce02:0:b0:381:2007:f75c with SMTP id m2-20020a7bce02000000b003812007f75cmr8885502wmc.6.1648033635128;
        Wed, 23 Mar 2022 04:07:15 -0700 (PDT)
Received: from krava (80-254-69-70.dynamic.monzoon.net. [80.254.69.70])
        by smtp.gmail.com with ESMTPSA id 189-20020a1c02c6000000b0038c57df82aasm3880723wmc.20.2022.03.23.04.07.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Mar 2022 04:07:14 -0700 (PDT)
Date:   Wed, 23 Mar 2022 12:07:11 +0100
From:   Jiri Olsa <olsajiri@gmail.com>
To:     Thomas Richter <tmricht@linux.ibm.com>
Cc:     linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        acme@kernel.org, namhyung@kernel.org, gor@linux.ibm.com,
        acme@redhat.com, svens@linux.ibm.com, sumanthk@linux.ibm.com,
        hca@linux.ibm.com
Subject: Re: [PATCH] perf/stat: Fix perf stat for forked applications
Message-ID: <Yjr/X+Cuunyo84S3@krava>
References: <20220317155346.577384-1-tmricht@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220317155346.577384-1-tmricht@linux.ibm.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 17, 2022 at 04:53:46PM +0100, Thomas Richter wrote:
> I have run into the following issue:
> 
>  # perf stat -a -e new_pmu/INSTRUCTION_7/ --  mytest -c1 7
> 
>  Performance counter stats for 'system wide':
> 
>                  0      new_pmu/INSTRUCTION_7/
> 
>        0.000366428 seconds time elapsed
>  #
> 
> The new PMU for s390 counts the execution of certain CPU instructions.
> The root cause is the extremely small run time of the
> mytest program. It just executes some assembly instructions
> and then exits. In above invocation the instruction is executed
> exactly one time (-c1 option). The PMU is expected to report this one
> time execution by a counter value of one, but fails to do so
> in some cases, not all.
> 
> Debugging reveals the invocation of the child process is done
> *before* the counter events are installed and enabled. Tracing
> reveals that sometimes the child process starts and exits before
> the event is installed on all CPUs. The more CPUs the machine has,
> the more often this miscount happens.
> 
> Fix this by reversing the start of the work load after the events
> have been installed on the specified CPUs. Now the comment also
> matches the code.
> 
> Output after:
>  # perf stat -a -e new_pmu/INSTRUCTION_7/ --  mytest -c1 7
> 
>  Performance counter stats for 'system wide':
> 
>                  1      new_pmu/INSTRUCTION_7/
> 
>        0.000366428 seconds time elapsed
>  #
> 
> Now the correct result is reported rock solid all the time regardless
> how many CPUs are online.
> 
> Fixes:  acf2892270dc ("perf stat: Use perf_evlist__prepare/start_workload())
> 
> Signed-off-by: Thomas Richter <tmricht@linux.ibm.com>
> Acked-by: Sumanth Korikkar <sumanthk@linux.ibm.com>
> Cc: Namhyung Kim <namhyung@kernel.org>
> ---
>  tools/perf/builtin-stat.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/tools/perf/builtin-stat.c b/tools/perf/builtin-stat.c
> index 3f98689dd687..60baa3dadc4b 100644
> --- a/tools/perf/builtin-stat.c
> +++ b/tools/perf/builtin-stat.c
> @@ -955,10 +955,10 @@ static int __run_perf_stat(int argc, const char **argv, int run_idx)
>  	 * Enable counters and exec the command:
>  	 */
>  	if (forks) {
> -		evlist__start_workload(evsel_list);
>  		err = enable_counters();
>  		if (err)
>  			return -1;
> +		evlist__start_workload(evsel_list);

right, without -a the event has enable_on_exec so the race does not
matter, but it's a problem for system wide with fork

Acked-by: Jiri Olsa <jolsa@kernel.org>

thanks,
jirka

>  
>  		t0 = rdclock();
>  		clock_gettime(CLOCK_MONOTONIC, &ref_time);
> -- 
> 2.35.1
> 
