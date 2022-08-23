Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2DD9E59CEEC
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Aug 2022 04:59:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239479AbiHWC6v (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Aug 2022 22:58:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51516 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237982AbiHWC6r (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Aug 2022 22:58:47 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F6C51C938
        for <linux-kernel@vger.kernel.org>; Mon, 22 Aug 2022 19:58:45 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 010BA6123B
        for <linux-kernel@vger.kernel.org>; Tue, 23 Aug 2022 02:58:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3F53DC433C1;
        Tue, 23 Aug 2022 02:58:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1661223524;
        bh=Ce69PUutVH/SEeGBbd6A5zVnk5G9kEFt2L5WT6fgUkM=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=Nlw7nL+AfpiIyX3ofwnbSxVahagCM3/C8kq0OErrDEbTiCkisTLjhhMiTHYOJSeaX
         VQ2xII8CEA3nmS5LylK6oSgI6lYsm6DoyZkqu8umiM5uiRU8h+wJBAW5eGemz/3hw0
         QAEj+cA+sJ9BwNhHfF5BbkJZHetm6bekfA4vhpp58X+jfnMQo7OnOO5/Q+joXOhTSl
         POYu2ryWNOTADbxCbqZAUuMaYL0GGgo/DCp3mDU2jEJ0Kx0YAg64EqTy3uTTNhZ38e
         AjMoXw0BBxIgTFKzxANu/SG+xqbamIXA1qlEjvsHLdMrE/+xcBQ5YfsOTGX75zT6eN
         dC5WTDjY70i9g==
Date:   Tue, 23 Aug 2022 11:58:40 +0900
From:   Masami Hiramatsu (Google) <mhiramat@kernel.org>
To:     Tom Zanussi <zanussi@kernel.org>
Cc:     Steven Rostedt <rostedt@goodmis.org>,
        Ingo Molnar <mingo@redhat.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 0/2] tracing/hist: Add percentage histogram suffixes
Message-Id: <20220823115840.4b1564545100bf7816241dba@kernel.org>
In-Reply-To: <6d8d1278ca1250313096accc4ca8967240d57677.camel@kernel.org>
References: <165966330764.3826604.9358384228095103695.stgit@devnote2>
        <40899e91a5a42f777111405fc2638a774f2ad6a4.camel@kernel.org>
        <20220820113105.1c3b1dd3bea8a3d6d297de31@kernel.org>
        <6d8d1278ca1250313096accc4ca8967240d57677.camel@kernel.org>
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

On Sun, 21 Aug 2022 14:35:00 -0500
Tom Zanussi <zanussi@kernel.org> wrote:

> On Sat, 2022-08-20 at 11:31 +0900, Masami Hiramatsu wrote:
> > On Thu, 18 Aug 2022 15:41:30 -0500
> > Tom Zanussi <zanussi@kernel.org> wrote:
> > 
> > > Hi Masami,
> > > 
> > > On Fri, 2022-08-05 at 10:35 +0900, Masami Hiramatsu (Google) wrote:
> > > > Hi,
> > > > 
> > > > Here is the 2nd version of .percent and .graph suffixes for
> > > > histogram
> > > > trigger to show the value in percentage and in bar-graph
> > > > respectively.
> > > > 
> > > > This version uses div64_*() for calculating percentages and show
> > > > an
> > > > error if it fails to calculate it.
> > > > 
> > > 
> > > > This will help us to check the trend of the histogram instantly
> > > > without the post processing tool.
> > > > 
> > > > Here shows the example of the percentage and the bar graph of
> > > > the runtime of the running tasks.
> > > > 
> > > > /sys/kernel/tracing # echo
> > > > hist:keys=pid:vals=runtime.percent,runtime.graph:sort
> > > > =pid >> events/sched/sched_stat_runtime/trigger
> > > > /sys/kernel/tracing # sleep 10
> > > > /sys/kernel/tracing # cat events/sched/sched_stat_runtime/hist
> > > > # event histogram
> > > > #
> > > > # trigger info:
> > > > hist:keys=pid:vals=hitcount,runtime.percent,runtime.graph:sort=pi
> > > > d:size=2048 [active]
> > > > #
> > > > 
> > > > { pid:          8 } hitcount:         11  runtime:       4.11 
> > > > runtime: #                   
> > > > { pid:          9 } hitcount:          4  runtime:       1.28 
> > > > runtime:                     
> > > > { pid:         14 } hitcount:         10  runtime:       2.22 
> > > > runtime:                     
> > > > { pid:         15 } hitcount:          1  runtime:       0.07 
> > > > runtime:                     
> > > > { pid:         16 } hitcount:         21  runtime:       3.35 
> > > > runtime: #                   
> > > > { pid:         57 } hitcount:          6  runtime:       2.41 
> > > > runtime: #                   
> > > > { pid:         61 } hitcount:         42  runtime:       9.79 
> > > > runtime: ####                
> > > > { pid:         66 } hitcount:          5  runtime:       0.69 
> > > > runtime:                     
> > > > { pid:        147 } hitcount:         36  runtime:      45.33 
> > > > runtime: ####################
> > > > { pid:       8548 } hitcount:          9  runtime:      17.25 
> > > > runtime: #######             
> > > > { pid:       8549 } hitcount:          8  runtime:      13.43 
> > > > runtime: #####    
> > > > 
> > > 
> > > This is a really nice new feature, thanks for adding it!
> > 
> > Thanks!
> > 
> > > 
> > > I did notice some anomalies when it comes to hitcount, though.  For
> > > instance, If I do similar to above with hitcount:
> > > 
> > >   # echo
> > > 'hist:keys=pid:vals=hitcount.percent,hitcount.graph:sort=pid'
> > >     >>
> > > sys/kernel/debug/tracing/events/sched/sched_stat_runtime/trigger
> > >   
> > >   # cat hist
> > > 
> > >   # event histogram
> > >   #
> > >   # trigger info: hist:keys=pid:vals=hitcount:sort=pid:size=2048
> > > [active]
> > >   { pid:         16 } hitcount:       2.11
> > >   { pid:         63 } hitcount:       6.33
> > >   { pid:         64 } hitcount:       6.33
> > > 
> > > it only shows one column with percent, no graph.
> > 
> > Hmm, curious. Also, the trigger info seems odd.
> > 
> > > 
> > > Similarly, if I do just hitcount and hitcount.graph, I only get the
> > > graph,
> > > no straight hitcount:
> > > 
> > >   # echo 'hist:keys=pid:vals=hitcount,hitcount.graph:sort=pid'
> > >     >>
> > > sys/kernel/debug/tracing/events/sched/sched_stat_runtime/trigger
> > > 
> > >   # cat hist
> > >   # event histogram
> > >   #
> > >   # trigger info: hist:keys=pid:vals=hitcount:sort=pid:size=2048
> > > active]
> > >   #
> > > 
> > >   { pid:         16 } hitcount: ######              
> > >   { pid:         63 } hitcount: ##########          
> > >   { pid:         64 } hitcount: ##########
> > > 
> > > I think it's because there's only one hitcount variable serving
> > > both
> > > PERCENT and GRAPH flags, and never gets to GRAPH if both are set. 
> > > So
> > > needs to iterate over both flags for hitcount to see which or if
> > > both
> > > are set.
> > 
> > Ah, I thought if I specify the hitcount twice, there would be 2
> > hitcount
> > fields, but actually it is not.
> > 
> > >  Also, in order to just print the straight hitcount if one of
> > > the other flags is set probably needs another flag for that case.
> > 
> > Yes, because hitcount is shown only once.
> > 
> > > 
> > > Also, the trigger info string always only shows 'vals=hitcount'
> > > even if
> > > percent or graph is set.
> > 
> > yes, the hitcount seeems to be special. Would you know why hitcount
> > is always shown and handled in such unique way?
> > (If user skips setting vals, it is natual to use hitcount by default,
> > but
> >  if user specifies any vals, I would like to drop hitcount...) 
> 
> It was just assumed that you'd always want to see the hitcount, so it
> was added unconditionally as the first value.  I don't think we can
> just drop it at this point if another value is specified and the
> hitcount isn't, but we could add another section that could be used to
> tailor the display to get rid of it e.g.
> 
>  echo hist:keys=pid:vals=hitcount:sort=pid:size=2048:display=no_hitcount,...
> 
> The display= section could be used to add other customization
> possibilities in the future.
> 
> What do you think?

Ah, that's nice. But I would like to have "option" instead of "display"
so that we can add another options in the future. :)

> 
> As for the anomalies I pointed out with the hitcount in your patches,
> I'm thinking that adding a patch that allows the user to add multiple
> hitcounts as with any other value should make the problems go away -
> let me create a patch to do that and then you shouldn't have to make
> any changes to yours..

Oops, I already updated mine, let me just share the v3. Anyway I will
wait your series and update it again. :)

Thank you,

> 
> Tom
> 
> > 
> > > 
> > > Finally, I'm wondering if labeling the percent column as percent
> > > would
> > > make things clearer in cases where you have the straight value
> > > along
> > > with the percent e.g. currently we have:
> > > 
> > >   # echo hist:keys=pid:vals=runtime,runtime.percent:sort=pid 
> > >    
> > > >>/sys/kernel/debug/tracing/events/sched/sched_stat_runtime/trigger
> > >   # cat hist
> > >   # event histogram
> > >   #
> > >   # trigger info:
> > > hist:keys=pid:vals=hitcount,runtime,runtime.percent:sort=pid:size=2
> > > 048 [active]
> > >   #
> > > 
> > >   { pid:         16 } hitcount:          3  runtime:      50742 
> > > runtime:       0.36
> > >   { pid:         63 } hitcount:          6  runtime:     123394 
> > > runtime:       0.88
> > > 
> > > which seeems a little confusing, 2 runtime fields with different
> > > values.  Maybe something like?:
> > > 
> > >   { pid:         16 } hitcount:          3  runtime:      50742 
> > > runtime (%):       0.36
> > >   { pid:         63 } hitcount:          6  runtime:     123394 
> > > runtime (%):       0.88
> > > 
> > > Just a thought..
> > 
> > Ah, that's a good idea.
> > Let me update the series.
> > 
> > Thank you!
> > 
> > > 
> > > Tom
> > > 
> > > >            
> > > > 
> > > > Totals:
> > > >     Hits: 153
> > > >     Entries: 11
> > > >     Dropped: 0
> > > > 
> > > > 
> > > > Thank you,
> > > > 
> > > > ---
> > > > 
> > > > Masami Hiramatsu (Google) (2):
> > > >       tracing: Add .percent suffix option to histogram values
> > > >       tracing: Add .graph suffix option to histogram value
> > > > 
> > > > 
> > > >  kernel/trace/trace.c             |    3 +
> > > >  kernel/trace/trace_events_hist.c |  129
> > > > ++++++++++++++++++++++++++++++++++++--
> > > >  2 files changed, 124 insertions(+), 8 deletions(-)
> > > > 
> > > > --
> > > > Masami Hiramatsu (Google) <mhiramat@kernel.org>
> > > 
> > 
> > 
> 


-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>
