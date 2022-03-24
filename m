Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BFC9D4E69E6
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Mar 2022 21:36:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353443AbiCXUi1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Mar 2022 16:38:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49194 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346156AbiCXUiZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Mar 2022 16:38:25 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 49622B0D37;
        Thu, 24 Mar 2022 13:36:53 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id D8DF760F88;
        Thu, 24 Mar 2022 20:36:52 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1B981C340EC;
        Thu, 24 Mar 2022 20:36:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1648154212;
        bh=Kx6tBROKdcOdeiKP7X4AbU2NzC0vd6LCDCQ6b1g3bQk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=SvPapQeGsj/0s8K1VaONuL2jEDQcMsPYMoapQ4/y5R3vHXZqkq3cpWbj4lY2BaTX1
         eEIjoAH7+ICIjcDFwNx1vpv/yu5O/ju51k7VNa1kZhw5C/TfvFGdox6eC3CtCD7zBV
         1lP9nAQU4U6OjjmvQmZX0U5aNXQRsKRhKmUwgw3nLrn+jCpmy+BrcpgLgY6CSBXhud
         ViNkzdJsjcaEJJVcFVRxNlgVGTXlUAiEkw+PN4SQEJODMIFjHmyxUO3oiyIthH4VuV
         lTfI4FGlB438hp4zx33DAfcgOsKkIV74Z5TkulgmVtPP8b3DyuO4D08qCMnaN96j3y
         YchcITBpma4pQ==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 10E8C40407; Thu, 24 Mar 2022 17:36:50 -0300 (-03)
Date:   Thu, 24 Mar 2022 17:36:50 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Namhyung Kim <namhyung@kernel.org>
Cc:     Jiri Olsa <olsajiri@gmail.com>,
        Thomas Richter <tmricht@linux.ibm.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        linux-perf-users <linux-perf-users@vger.kernel.org>,
        gor@linux.ibm.com, Arnaldo Carvalho de Melo <acme@redhat.com>,
        Sven Schnelle <svens@linux.ibm.com>, sumanthk@linux.ibm.com,
        Heiko Carstens <hca@linux.ibm.com>
Subject: Re: [PATCH] perf/stat: Fix perf stat for forked applications
Message-ID: <YjzWYjO06FwP6Mgy@kernel.org>
References: <20220317155346.577384-1-tmricht@linux.ibm.com>
 <Yjr/X+Cuunyo84S3@krava>
 <CAM9d7cgkwDQCEWRFT2G87fba7MLPR2OtEn6pvHDzpegpR-AMSA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAM9d7cgkwDQCEWRFT2G87fba7MLPR2OtEn6pvHDzpegpR-AMSA@mail.gmail.com>
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

Em Wed, Mar 23, 2022 at 01:54:23PM -0700, Namhyung Kim escreveu:
> On Wed, Mar 23, 2022 at 4:07 AM Jiri Olsa <olsajiri@gmail.com> wrote:
> >
> > On Thu, Mar 17, 2022 at 04:53:46PM +0100, Thomas Richter wrote:
> > > I have run into the following issue:
> > >
> > >  # perf stat -a -e new_pmu/INSTRUCTION_7/ --  mytest -c1 7
> > >
> > >  Performance counter stats for 'system wide':
> > >
> > >                  0      new_pmu/INSTRUCTION_7/
> > >
> > >        0.000366428 seconds time elapsed
> > >  #
> > >
> > > The new PMU for s390 counts the execution of certain CPU instructions.
> > > The root cause is the extremely small run time of the
> > > mytest program. It just executes some assembly instructions
> > > and then exits. In above invocation the instruction is executed
> > > exactly one time (-c1 option). The PMU is expected to report this one
> > > time execution by a counter value of one, but fails to do so
> > > in some cases, not all.
> > >
> > > Debugging reveals the invocation of the child process is done
> > > *before* the counter events are installed and enabled. Tracing
> > > reveals that sometimes the child process starts and exits before
> > > the event is installed on all CPUs. The more CPUs the machine has,
> > > the more often this miscount happens.
> > >
> > > Fix this by reversing the start of the work load after the events
> > > have been installed on the specified CPUs. Now the comment also
> > > matches the code.
> > >
> > > Output after:
> > >  # perf stat -a -e new_pmu/INSTRUCTION_7/ --  mytest -c1 7
> > >
> > >  Performance counter stats for 'system wide':
> > >
> > >                  1      new_pmu/INSTRUCTION_7/
> > >
> > >        0.000366428 seconds time elapsed
> > >  #
> > >
> > > Now the correct result is reported rock solid all the time regardless
> > > how many CPUs are online.
> > >
> > > Fixes:  acf2892270dc ("perf stat: Use perf_evlist__prepare/start_workload())
> > >
> > > Signed-off-by: Thomas Richter <tmricht@linux.ibm.com>
> > > Acked-by: Sumanth Korikkar <sumanthk@linux.ibm.com>
> > > Cc: Namhyung Kim <namhyung@kernel.org>
> > > ---
> > >  tools/perf/builtin-stat.c | 2 +-
> > >  1 file changed, 1 insertion(+), 1 deletion(-)
> > >
> > > diff --git a/tools/perf/builtin-stat.c b/tools/perf/builtin-stat.c
> > > index 3f98689dd687..60baa3dadc4b 100644
> > > --- a/tools/perf/builtin-stat.c
> > > +++ b/tools/perf/builtin-stat.c
> > > @@ -955,10 +955,10 @@ static int __run_perf_stat(int argc, const char **argv, int run_idx)
> > >        * Enable counters and exec the command:
> > >        */
> > >       if (forks) {
> > > -             evlist__start_workload(evsel_list);
> > >               err = enable_counters();
> > >               if (err)
> > >                       return -1;
> > > +             evlist__start_workload(evsel_list);
> >
> > right, without -a the event has enable_on_exec so the race does not
> > matter, but it's a problem for system wide with fork
> 
> Agreed.  Also we may move the enable_counters() and the
> clock code out of the if block to be shared with the else block.
> 
> Acked-by: Namhyung Kim <namhyung@kernel.org>

Thanks, applied and added your comments as "Reviewer notes", and please
consider using the Reviewed-by tag instead of the Acked-by ones.

Thanks anyways, as always!

- Arnaldo
