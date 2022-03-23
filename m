Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B5FE34E5A41
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Mar 2022 21:54:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344840AbiCWU4J (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Mar 2022 16:56:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33086 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244002AbiCWU4I (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Mar 2022 16:56:08 -0400
Received: from mail-lf1-f45.google.com (mail-lf1-f45.google.com [209.85.167.45])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E21338BF15;
        Wed, 23 Mar 2022 13:54:36 -0700 (PDT)
Received: by mail-lf1-f45.google.com with SMTP id bt26so4744068lfb.3;
        Wed, 23 Mar 2022 13:54:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=PsL8QsEp/CuRBHIlYfHFpv5xpQDqvATabhPlJFg6D18=;
        b=w8A+ABiQz3SR3oWquM8y/Z4/b/F0HrS/YHNgSXf9TDUmIoTdK/gbGLYY+FeZQ44qmS
         V9SeTeNnunzXekutPDl5oMUHA8YFNDQ18jUf6O7DFZDvD3bmZsUXDgwlNoTcFGUoa6Xo
         h3pZfPljm1UaEFa4bomIs58GE0Ko6gokDYD94u5Hz0MGia0xZLs4DTDbb0JJYdU2jj6+
         otwDV0ODsCSTltvtx+h5BUVX401GsxHQDSbreZolhurMnV1acRBRSA8fzASDR/WwqVz1
         InBGPOdXlIuVoryzZnjYYxmxZ75+YDb9C7b07QqWq/wMj934uT/YPuFusxRWOXkSsdTP
         JXWg==
X-Gm-Message-State: AOAM5309KmARzUymRTanpS5LiRvPffVaXGGlSJ55ofOvVvgKS2TNb0Gu
        Hu09TySEnRQyqtuf8LNjx+SSzakqsreaAdkFexaBHiL6
X-Google-Smtp-Source: ABdhPJyx4RD0OigisgS3C9D66vjkzcPeC7rPv4U8Ard06XHOzvE+BtP6nvSHOEIPvkY9ldL4xFdwrixerGDN1jduk6Y=
X-Received: by 2002:a05:6512:3404:b0:44a:310f:72f7 with SMTP id
 i4-20020a056512340400b0044a310f72f7mr1321451lfr.47.1648068875123; Wed, 23 Mar
 2022 13:54:35 -0700 (PDT)
MIME-Version: 1.0
References: <20220317155346.577384-1-tmricht@linux.ibm.com> <Yjr/X+Cuunyo84S3@krava>
In-Reply-To: <Yjr/X+Cuunyo84S3@krava>
From:   Namhyung Kim <namhyung@kernel.org>
Date:   Wed, 23 Mar 2022 13:54:23 -0700
Message-ID: <CAM9d7cgkwDQCEWRFT2G87fba7MLPR2OtEn6pvHDzpegpR-AMSA@mail.gmail.com>
Subject: Re: [PATCH] perf/stat: Fix perf stat for forked applications
To:     Jiri Olsa <olsajiri@gmail.com>
Cc:     Thomas Richter <tmricht@linux.ibm.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        linux-perf-users <linux-perf-users@vger.kernel.org>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        gor@linux.ibm.com, Arnaldo Carvalho de Melo <acme@redhat.com>,
        Sven Schnelle <svens@linux.ibm.com>, sumanthk@linux.ibm.com,
        Heiko Carstens <hca@linux.ibm.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 23, 2022 at 4:07 AM Jiri Olsa <olsajiri@gmail.com> wrote:
>
> On Thu, Mar 17, 2022 at 04:53:46PM +0100, Thomas Richter wrote:
> > I have run into the following issue:
> >
> >  # perf stat -a -e new_pmu/INSTRUCTION_7/ --  mytest -c1 7
> >
> >  Performance counter stats for 'system wide':
> >
> >                  0      new_pmu/INSTRUCTION_7/
> >
> >        0.000366428 seconds time elapsed
> >  #
> >
> > The new PMU for s390 counts the execution of certain CPU instructions.
> > The root cause is the extremely small run time of the
> > mytest program. It just executes some assembly instructions
> > and then exits. In above invocation the instruction is executed
> > exactly one time (-c1 option). The PMU is expected to report this one
> > time execution by a counter value of one, but fails to do so
> > in some cases, not all.
> >
> > Debugging reveals the invocation of the child process is done
> > *before* the counter events are installed and enabled. Tracing
> > reveals that sometimes the child process starts and exits before
> > the event is installed on all CPUs. The more CPUs the machine has,
> > the more often this miscount happens.
> >
> > Fix this by reversing the start of the work load after the events
> > have been installed on the specified CPUs. Now the comment also
> > matches the code.
> >
> > Output after:
> >  # perf stat -a -e new_pmu/INSTRUCTION_7/ --  mytest -c1 7
> >
> >  Performance counter stats for 'system wide':
> >
> >                  1      new_pmu/INSTRUCTION_7/
> >
> >        0.000366428 seconds time elapsed
> >  #
> >
> > Now the correct result is reported rock solid all the time regardless
> > how many CPUs are online.
> >
> > Fixes:  acf2892270dc ("perf stat: Use perf_evlist__prepare/start_workload())
> >
> > Signed-off-by: Thomas Richter <tmricht@linux.ibm.com>
> > Acked-by: Sumanth Korikkar <sumanthk@linux.ibm.com>
> > Cc: Namhyung Kim <namhyung@kernel.org>
> > ---
> >  tools/perf/builtin-stat.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/tools/perf/builtin-stat.c b/tools/perf/builtin-stat.c
> > index 3f98689dd687..60baa3dadc4b 100644
> > --- a/tools/perf/builtin-stat.c
> > +++ b/tools/perf/builtin-stat.c
> > @@ -955,10 +955,10 @@ static int __run_perf_stat(int argc, const char **argv, int run_idx)
> >        * Enable counters and exec the command:
> >        */
> >       if (forks) {
> > -             evlist__start_workload(evsel_list);
> >               err = enable_counters();
> >               if (err)
> >                       return -1;
> > +             evlist__start_workload(evsel_list);
>
> right, without -a the event has enable_on_exec so the race does not
> matter, but it's a problem for system wide with fork

Agreed.  Also we may move the enable_counters() and the
clock code out of the if block to be shared with the else block.

Acked-by: Namhyung Kim <namhyung@kernel.org>

Thanks,
Namhyung
