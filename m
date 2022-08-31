Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 839835A8953
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Sep 2022 01:02:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232591AbiHaXCr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 Aug 2022 19:02:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49090 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232344AbiHaXCq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Aug 2022 19:02:46 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C4A8E68AC
        for <linux-kernel@vger.kernel.org>; Wed, 31 Aug 2022 16:02:43 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id EA8BDB8235E
        for <linux-kernel@vger.kernel.org>; Wed, 31 Aug 2022 23:02:40 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8A642C433D6;
        Wed, 31 Aug 2022 23:02:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1661986959;
        bh=U5tjn1HNNyxfrQ1lwzFhrlV2L2vNXTMTJEC4OelMCk8=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=FQiQMa1JDtq+x7KAJNL1vRMn2KNQP0uBK7kfSuoLG9edYgeN455Xiha6k2xuGeTye
         2MKZhDHu0B9ujk0OQ6mFa8i6bahyed08qTETgFP1TrRGzllyH6t9ufQT/TbBKEBkBe
         uqtkimLaX/P8Sxjgn7LW1BTRX1hyOAvcmoOfAwhjvkclyST+HuSHLpILJMi6NuzUyC
         udbpPu/fsUVecD9I2Ybu32I+VMfKeRyKDW9YIsSlFjoyRV/hVBrze8cFtewoxZSryo
         azCvB6DmuAaTCAxfHVhbyDWQxeVFWJzRvbD28Y/QEl2FJXX6/cgM54VPhcuNXf1waf
         9uadgk0pLoWnA==
Date:   Thu, 1 Sep 2022 08:02:35 +0900
From:   Masami Hiramatsu (Google) <mhiramat@kernel.org>
To:     Tom Zanussi <zanussi@kernel.org>
Cc:     Steven Rostedt <rostedt@goodmis.org>,
        Ingo Molnar <mingo@redhat.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 0/5] tracing/hist: Add percentage histogram suffixes
Message-Id: <20220901080235.20db3793534a64475a3db7be@kernel.org>
In-Reply-To: <4c7f9d2b46a02324dd4467144edaf3b2a34720b2.camel@kernel.org>
References: <166157298537.348924.2537162090505397377.stgit@devnote2>
        <4c7f9d2b46a02324dd4467144edaf3b2a34720b2.camel@kernel.org>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 31 Aug 2022 16:35:25 -0500
Tom Zanussi <zanussi@kernel.org> wrote:

> Hi Masami,
> 
> On Sat, 2022-08-27 at 13:03 +0900, Masami Hiramatsu (Google) wrote:
> > Hi,
> > 
> > Here is the 4th version of .percent and .graph suffixes for histogram
> > trigger to show the value in percentage and in bar-graph
> > respectively.
> > 
> > I've rebased on Tom's hitcount patch[1/5] on the series and added a
> > patch
> > for supressing display of hitcount[5/5] in this version.
> 
> This is a very nice patchset overall - the only question I have
> concerns patch 5 for suppressing the hitcount.  I actually think the
> patch is fine and does what it says nicely (and probably should have
> been done that way to begin with) but it looks like it would cause
> problems for anyone already doing postprocessing and whose scripts
> would be expecting the hitcount to be there.  So changing the default
> behavior would require their scripts to change, and also now that I
> look at it, the example output in Documentation/ as well.

Good catch! Yeah, this type of change will need to update the docs.
I missed that.

> 
> How about adding an option like 'nohitcount' and having that patch do
> what it does but only if that option is set?

Agreed. So something like this?

echo hist:keys=pid:vals=runtime.graph:nohitcount (or NOHC for short)

Maybe we can also add an option under <tracefs/>options/

> 
> Anyway, for the other ones, patches 2-4,
> 
>   Signed-off-by: Tom Zanussi <zanussi@kernel.org>
>   Tested-by: Tom Zanussi <zanussi@kernel.org

Thank you!

> 
> Thanks!
> 
> Tom
> 
> > 
> > This will help us to check the trend of the histogram instantly
> > without any post processing tool.
> > 
> > Here shows an example of the percentage and the bar graph of
> > the hitcount of the running tasks.
> > 
> >   # cd /sys/kernel/debug/tracing/
> >   # echo hist:keys=pid:vals=hitcount.percent,hitcount.graph:sort=pid
> > > \
> >         events/sched/sched_stat_runtime/trigger
> >   # sleep 10
> >   # cat events/sched/sched_stat_runtime/hist
> >  # event histogram
> >  #
> >  # trigger info:
> > hist:keys=pid:vals=hitcount.percent,hitcount.graph:sort=pid:size=2048
> > [active]
> >  #
> > 
> >  { pid:         14 } hitcount (%):   4.68  hitcount:
> > ###                 
> >  { pid:         16 } hitcount (%):  17.18  hitcount:
> > ###########         
> >  { pid:         57 } hitcount (%):   7.81  hitcount:
> > #####               
> >  { pid:         61 } hitcount (%):  31.25  hitcount:
> > ####################
> >  { pid:         70 } hitcount (%):   4.68  hitcount:
> > ###                 
> >  { pid:         77 } hitcount (%):   1.56  hitcount:
> > #                   
> >  { pid:        145 } hitcount (%):  18.75  hitcount:
> > ############        
> >  { pid:        151 } hitcount (%):   9.37  hitcount:
> > ######              
> >  { pid:        152 } hitcount (%):   4.68  hitcount:
> > ###                 
> > 
> >  Totals:
> >      Hits: 64
> >      Entries: 9
> >      Dropped: 0
> > 
> > Of course if you explicitly specify the hitcount, it can show the
> > hitcount as below;
> > 
> >   # cd /sys/kernel/debug/tracing/
> >   # echo hist:keys=pid:vals=hitcount,runtime:sort=pid > \
> >         events/sched/sched_stat_runtime/trigger
> >   # sleep 10
> >   # cat events/sched/sched_stat_runtime/hist
> >  # event histogram
> >  #
> >  # trigger info:
> > hist:keys=pid:vals=hitcount,runtime:sort=pid:size=2048 [active]
> >  #
> > 
> >  { pid:         14 } hitcount:          2  runtime:     304876
> >  { pid:         16 } hitcount:          8  runtime:     300574
> >  { pid:         26 } hitcount:          2  runtime:      15578
> >  { pid:         32 } hitcount:          2  runtime:     219186
> >  { pid:         57 } hitcount:          3  runtime:     506003
> >  { pid:         61 } hitcount:         20  runtime:    1681473
> >  { pid:         69 } hitcount:          3  runtime:     201785
> >  { pid:         70 } hitcount:          4  runtime:     360608
> >  { pid:         77 } hitcount:          8  runtime:    4146935
> >  { pid:        145 } hitcount:         13  runtime:    7537994
> >  { pid:        155 } hitcount:          4  runtime:    2511937
> >  { pid:        156 } hitcount:          2  runtime:    1398886
> > 
> >  Totals:
> >      Hits: 71
> >      Entries: 12
> >      Dropped: 0
> > 
> > 
> > Thank you,
> > 
> > ---
> > 
> > Masami Hiramatsu (Google) (4):
> >       tracing: Fix to check event_mutex is held while accessing
> > trigger list
> >       tracing: Add .percent suffix option to histogram values
> >       tracing: Add .graph suffix option to histogram value
> >       tracing: Show hitcount value only when specified
> > 
> > Tom Zanussi (1):
> >       tracing: Allow multiple hitcount values in histograms
> > 
> > 
> >  kernel/trace/trace.c                |    3 -
> >  kernel/trace/trace_events_hist.c    |  176
> > ++++++++++++++++++++++++++++++-----
> >  kernel/trace/trace_events_trigger.c |    3 -
> >  3 files changed, 156 insertions(+), 26 deletions(-)
> > 
> > --
> > Masami Hiramatsu (Google) <mhiramat@kernel.org>
> 


-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>
