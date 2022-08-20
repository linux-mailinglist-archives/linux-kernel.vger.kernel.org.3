Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3571F59AAB3
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Aug 2022 04:31:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243159AbiHTCbY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 Aug 2022 22:31:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42808 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230039AbiHTCbV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Aug 2022 22:31:21 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0348FB2DB7
        for <linux-kernel@vger.kernel.org>; Fri, 19 Aug 2022 19:31:21 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 9EA0F6194A
        for <linux-kernel@vger.kernel.org>; Sat, 20 Aug 2022 02:31:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 346DDC433D6;
        Sat, 20 Aug 2022 02:31:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1660962680;
        bh=XqVaEf6Pb9HbQonyZXyz+BEJPwtfE8MMckBWQEZKpOY=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=EZil/mIHAQViFw5hC34P4R38X8o76coYQp5NLr/lUzka7KFWwyO+XD7OUe+Gjeaky
         PkYDBHNLIr2kQkAoKlj4ihhxbgSbL29G6TkWPc5KpX6sY9TF3/+zsjD5sCwhMPa7Ow
         sTvocYX9RhkBvHWoEuwrt9R1vmYHt/oS+TwVx12aEGdrAWAh+Y/w0x7lGw2QNiZeDW
         eYcO7nKL6p0sQSYpkf4hPpGz9oF36Q9o/dJGMOXCRTti4AfgSXlc18iqO+2VpOCJ4J
         nOpFADW1bgKAg74HDREgJ5yIEUha4gfCAhzHz5CjEMgsAiu1pwz6oBKdt4El6oW9QE
         6EkP/IIh06ZQQ==
Date:   Sat, 20 Aug 2022 11:31:05 +0900
From:   Masami Hiramatsu (Google) <mhiramat@kernel.org>
To:     Tom Zanussi <zanussi@kernel.org>
Cc:     Steven Rostedt <rostedt@goodmis.org>,
        Ingo Molnar <mingo@redhat.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 0/2] tracing/hist: Add percentage histogram suffixes
Message-Id: <20220820113105.1c3b1dd3bea8a3d6d297de31@kernel.org>
In-Reply-To: <40899e91a5a42f777111405fc2638a774f2ad6a4.camel@kernel.org>
References: <165966330764.3826604.9358384228095103695.stgit@devnote2>
        <40899e91a5a42f777111405fc2638a774f2ad6a4.camel@kernel.org>
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

On Thu, 18 Aug 2022 15:41:30 -0500
Tom Zanussi <zanussi@kernel.org> wrote:

> Hi Masami,
> 
> On Fri, 2022-08-05 at 10:35 +0900, Masami Hiramatsu (Google) wrote:
> > Hi,
> > 
> > Here is the 2nd version of .percent and .graph suffixes for histogram
> > trigger to show the value in percentage and in bar-graph respectively.
> > 
> > This version uses div64_*() for calculating percentages and show an
> > error if it fails to calculate it.
> > 
> 
> > This will help us to check the trend of the histogram instantly
> > without the post processing tool.
> > 
> > Here shows the example of the percentage and the bar graph of
> > the runtime of the running tasks.
> > 
> > /sys/kernel/tracing # echo hist:keys=pid:vals=runtime.percent,runtime.graph:sort
> > =pid >> events/sched/sched_stat_runtime/trigger
> > /sys/kernel/tracing # sleep 10
> > /sys/kernel/tracing # cat events/sched/sched_stat_runtime/hist
> > # event histogram
> > #
> > # trigger info: hist:keys=pid:vals=hitcount,runtime.percent,runtime.graph:sort=pid:size=2048 [active]
> > #
> > 
> > { pid:          8 } hitcount:         11  runtime:       4.11  runtime: #                   
> > { pid:          9 } hitcount:          4  runtime:       1.28  runtime:                     
> > { pid:         14 } hitcount:         10  runtime:       2.22  runtime:                     
> > { pid:         15 } hitcount:          1  runtime:       0.07  runtime:                     
> > { pid:         16 } hitcount:         21  runtime:       3.35  runtime: #                   
> > { pid:         57 } hitcount:          6  runtime:       2.41  runtime: #                   
> > { pid:         61 } hitcount:         42  runtime:       9.79  runtime: ####                
> > { pid:         66 } hitcount:          5  runtime:       0.69  runtime:                     
> > { pid:        147 } hitcount:         36  runtime:      45.33  runtime: ####################
> > { pid:       8548 } hitcount:          9  runtime:      17.25  runtime: #######             
> > { pid:       8549 } hitcount:          8  runtime:      13.43  runtime: #####    
> > 
> 
> This is a really nice new feature, thanks for adding it!

Thanks!

> 
> I did notice some anomalies when it comes to hitcount, though.  For
> instance, If I do similar to above with hitcount:
> 
>   # echo 'hist:keys=pid:vals=hitcount.percent,hitcount.graph:sort=pid'
>     >> sys/kernel/debug/tracing/events/sched/sched_stat_runtime/trigger
>   
>   # cat hist
> 
>   # event histogram
>   #
>   # trigger info: hist:keys=pid:vals=hitcount:sort=pid:size=2048 [active]
>   { pid:         16 } hitcount:       2.11
>   { pid:         63 } hitcount:       6.33
>   { pid:         64 } hitcount:       6.33
> 
> it only shows one column with percent, no graph.

Hmm, curious. Also, the trigger info seems odd.

> 
> Similarly, if I do just hitcount and hitcount.graph, I only get the graph,
> no straight hitcount:
> 
>   # echo 'hist:keys=pid:vals=hitcount,hitcount.graph:sort=pid'
>     >> sys/kernel/debug/tracing/events/sched/sched_stat_runtime/trigger
> 
>   # cat hist
>   # event histogram
>   #
>   # trigger info: hist:keys=pid:vals=hitcount:sort=pid:size=2048 active]
>   #
> 
>   { pid:         16 } hitcount: ######              
>   { pid:         63 } hitcount: ##########          
>   { pid:         64 } hitcount: ##########
> 
> I think it's because there's only one hitcount variable serving both
> PERCENT and GRAPH flags, and never gets to GRAPH if both are set.  So
> needs to iterate over both flags for hitcount to see which or if both
> are set.

Ah, I thought if I specify the hitcount twice, there would be 2 hitcount
fields, but actually it is not.

>  Also, in order to just print the straight hitcount if one of
> the other flags is set probably needs another flag for that case.

Yes, because hitcount is shown only once.

> 
> Also, the trigger info string always only shows 'vals=hitcount' even if
> percent or graph is set.

yes, the hitcount seeems to be special. Would you know why hitcount
is always shown and handled in such unique way?
(If user skips setting vals, it is natual to use hitcount by default, but
 if user specifies any vals, I would like to drop hitcount...) 

> 
> Finally, I'm wondering if labeling the percent column as percent would
> make things clearer in cases where you have the straight value along
> with the percent e.g. currently we have:
> 
>   # echo hist:keys=pid:vals=runtime,runtime.percent:sort=pid 
>     >>/sys/kernel/debug/tracing/events/sched/sched_stat_runtime/trigger
>   # cat hist
>   # event histogram
>   #
>   # trigger info: hist:keys=pid:vals=hitcount,runtime,runtime.percent:sort=pid:size=2048 [active]
>   #
> 
>   { pid:         16 } hitcount:          3  runtime:      50742  runtime:       0.36
>   { pid:         63 } hitcount:          6  runtime:     123394  runtime:       0.88
> 
> which seeems a little confusing, 2 runtime fields with different values.  Maybe something like?:
> 
>   { pid:         16 } hitcount:          3  runtime:      50742  runtime (%):       0.36
>   { pid:         63 } hitcount:          6  runtime:     123394  runtime (%):       0.88
> 
> Just a thought..

Ah, that's a good idea.
Let me update the series.

Thank you!

> 
> Tom
> 
> >            
> > 
> > Totals:
> >     Hits: 153
> >     Entries: 11
> >     Dropped: 0
> > 
> > 
> > Thank you,
> > 
> > ---
> > 
> > Masami Hiramatsu (Google) (2):
> >       tracing: Add .percent suffix option to histogram values
> >       tracing: Add .graph suffix option to histogram value
> > 
> > 
> >  kernel/trace/trace.c             |    3 +
> >  kernel/trace/trace_events_hist.c |  129 ++++++++++++++++++++++++++++++++++++--
> >  2 files changed, 124 insertions(+), 8 deletions(-)
> > 
> > --
> > Masami Hiramatsu (Google) <mhiramat@kernel.org>
> 


-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>
