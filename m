Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6FCDC589959
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Aug 2022 10:37:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239373AbiHDIhx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 Aug 2022 04:37:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44540 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229823AbiHDIhv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Aug 2022 04:37:51 -0400
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com [IPv6:2a00:1450:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 52E181EAC9;
        Thu,  4 Aug 2022 01:37:50 -0700 (PDT)
Received: by mail-ej1-x62b.google.com with SMTP id a7so22640556ejp.2;
        Thu, 04 Aug 2022 01:37:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=T/0bG5lG5mVavxawraIugcCbO1nWup7v9jx/vcYnyeY=;
        b=JMPv5ZGasYvfYpBkYSdh26U3kxKySxYUJDDhNKYJJA8TFP9qn+9ppE6mKUnVtOc+ZW
         oxPDR6d2mPXikdjz05x/0r0Bfr+S5AVD3zmDeyl7xCAnBCql6L9i4yF95koD29/exmDB
         VuzW/XOT2cSokdDXX53XI5JiN9eCEWxT2qPSNF/84IiVwGwj5QFk9sz/FXJ2oQxg8w6A
         mEHR8IoPx3tuprmLf6ebE3DNFHlO6uIlUv7KDQpTEP7k1jFV2DjrYPJ+YaCJnSsXE5+C
         AcQcXNuYcaabyaDow0nZoAMT5ZfNrRWS4ybMSvt4qXWFyheZCAWFUFNywwwF5OpPi6QB
         yfJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=T/0bG5lG5mVavxawraIugcCbO1nWup7v9jx/vcYnyeY=;
        b=TQMdRk8FDWRLBTbHBoSfDNKcgfVSW93nQ83s0zk9iY6pWT/s3KyJ9MU948O1t7rG22
         XqN02UtWhkaNtQnd03rCcJt/Jo+05WDSrj1sI2SXXkyfY0M2ttT3sSMdK/ZIN2pUNYuN
         JFa64dR0ERlddLpeoEXGBdz+mkP5HInOwVgJs9kt3BEa4Uez7hGDPaShUkRq7Z4jBmFo
         IJg8twB3+9g/G2a1gVuRJY7lEIWl2VY7qB47xntGutZTk73AULH1nHslrMSAaYjnFy2s
         lzDdEdLO+IZRobOnEJ1tKfOgiXYn67qduU8zkxoF2dZp4XzseiGo4M1r+T2jKacbyLJP
         G0WQ==
X-Gm-Message-State: ACgBeo37WnkUW7EADPo9xy8+5yLcE3VyF4U4Rowj+UNcUdb6R9VczsWO
        jWXNuKo77IFxp4Zd3+9z3xo=
X-Google-Smtp-Source: AA6agR7s0o6fBUxHjfWL8UV2PCf6eesu3ViADh5vpioXKXgjFXYgFXd1jggMOKwEpmMX75VfiWceMQ==
X-Received: by 2002:a17:907:8a16:b0:72b:9196:f029 with SMTP id sc22-20020a1709078a1600b0072b9196f029mr618003ejc.359.1659602268807;
        Thu, 04 Aug 2022 01:37:48 -0700 (PDT)
Received: from gmail.com (195-38-112-141.pool.digikabel.hu. [195.38.112.141])
        by smtp.gmail.com with ESMTPSA id s21-20020a1709066c9500b0071cbc7487e1sm108680ejr.69.2022.08.04.01.37.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Aug 2022 01:37:48 -0700 (PDT)
Sender: Ingo Molnar <mingo.kernel.org@gmail.com>
Date:   Thu, 4 Aug 2022 10:37:46 +0200
From:   Ingo Molnar <mingo@kernel.org>
To:     Namhyung Kim <namhyung@kernel.org>
Cc:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Jiri Olsa <jolsa@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Ian Rogers <irogers@google.com>,
        linux-perf-users <linux-perf-users@vger.kernel.org>,
        Will Deacon <will@kernel.org>,
        Waiman Long <longman@redhat.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        Davidlohr Bueso <dave@stgolabs.net>
Subject: Re: [PATCHSET 0/6] perf lock: Add contention subcommand (v1)
Message-ID: <YuuFWr2435kd0CYl@gmail.com>
References: <20220721043644.153718-1-namhyung@kernel.org>
 <YupFEkzCDxpFUyeD@gmail.com>
 <CAM9d7cjhVwRhVTiJM6hX8Y75SGJhpwYgMtSc_9PB0tzysJjVgQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAM9d7cjhVwRhVTiJM6hX8Y75SGJhpwYgMtSc_9PB0tzysJjVgQ@mail.gmail.com>
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        FSL_HELO_FAKE,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


* Namhyung Kim <namhyung@kernel.org> wrote:

> Hi Ingo,
> 
> On Wed, Aug 3, 2022 at 2:51 AM Ingo Molnar <mingo@kernel.org> wrote:
> >
> >
> > * Namhyung Kim <namhyung@kernel.org> wrote:
> >
> > > Hello,
> > >
> > > It's to add a new subcommand 'contention' (shortly 'con') to perf lock.
> > >
> > > The new subcommand is to handle the new lock:contention_{begin,end}
> > > tracepoints and shows lock type and caller address like below:
> > >
> > >   $ perf lock contention
> > >    contended   total wait     max wait     avg wait         type   caller
> > >
> > >          238      1.41 ms     29.20 us      5.94 us     spinlock   update_blocked_averages+0x4c
> > >            1    902.08 us    902.08 us    902.08 us      rwsem:R   do_user_addr_fault+0x1dd
> > >           81    330.30 us     17.24 us      4.08 us     spinlock   _nohz_idle_balance+0x172
> > >            2     89.54 us     61.26 us     44.77 us     spinlock   do_anonymous_page+0x16d
> > >           24     78.36 us     12.27 us      3.27 us        mutex   pipe_read+0x56
> > >            2     71.58 us     59.56 us     35.79 us     spinlock   __handle_mm_fault+0x6aa
> > >            6     25.68 us      6.89 us      4.28 us     spinlock   do_idle+0x28d
> > >            1     18.46 us     18.46 us     18.46 us      rtmutex   exec_fw_cmd+0x21b
> > >            3     15.25 us      6.26 us      5.08 us     spinlock   tick_do_update_jiffies64+0x2c
> > >    ...
> >
> > Wouldn't it also be useful to display a lock contention percentage value,
> > the ratio of fastpath vs. contended/wait events?
> >
> > That's usually the first-approximation metric to see how contended
> > different locks are, and the average wait time quantifies it.
> 
> Yeah, that'd be nice to have.  But it requires some action in the fast 
> path which I don't want because I'd like to use this in production.  So 
> these new tracepoints were added only in the slow path.

Yeah. Might make sense to re-measure the impact of possibly doing that 
though: most of the locking fast-patch is out of line already and could be 
instrumented, with only a handful of inlined primitives - 
CONFIG_UNINLINE_SPIN_UNLOCK in particular.

How many additional inlined NOP sequences does this add in a defconfig 
kernel? How much is the bloat, and would it be acceptable for production 
kernels?

The other question is to keep tracing overhead low in production systems.

For that we'd have to implement some concept of 'sampling tracepoints', 
which generate only one event for every 128 fast path invocations or so, 
but stay out of the way & don't slow down the system otherwise.

OTOH frequently used locking fastpaths are measured via regular PMU 
sampling based profiling already.

> Instead, I think we can display the ratio of (total) contended time vs. 
> wall clock time.  What do you think?

That looks useful too - but also the time spent waiting/spinning in a 
thread vs. the time spent actually running and executing real stuff.

That ratio could easily get over 100%, for wait-dominated workloads - so 
ordering by that ratio would highlight the tasks that make the least amount 
of real progress. Measuring the ratio based only on wall clock time would 
hide this aspect.

Thanks,

	Ingo
