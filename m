Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DEB7F5876D4
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Aug 2022 07:41:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235805AbiHBFlj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 Aug 2022 01:41:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54950 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231804AbiHBFlg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Aug 2022 01:41:36 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DEED541D0F
        for <linux-kernel@vger.kernel.org>; Mon,  1 Aug 2022 22:41:35 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 6FD4E61268
        for <linux-kernel@vger.kernel.org>; Tue,  2 Aug 2022 05:41:35 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 970CCC433C1;
        Tue,  2 Aug 2022 05:41:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1659418894;
        bh=XiNVPCCjZTk5RLrsO9cH4qo3IAgxOvd2KtAeNjJF290=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=VYkk0rIwcA8d96qC8zLVkkea8moJw92aGxY3Ym09OCBDtzik1CfZLt4l/gtVtH9TV
         OSfqBNS2GfiRSDIghgxOuDrZfBI4O6RDFkrzSTgCSwlvwT2HsijMUSgqFF7MSoTV93
         rJ/mhyzGBlpHGbnNNWk2hRsZpfoo6mEB+RXZ6Vl17AxbB3tAzhhzk+Zs1yiGPXn5Id
         BR3MHWwAMet+lDNs9cRNIovzaR3OaMPyIcdOu9DSdOKfxvaZGWgxM9OZWwwhKmdPl2
         j82gi5LEizIKJKCh9yZIdpYw62jqpQaq9rZLX7KXGb3x1MwpQL/d+IyQem+G+qL23v
         Y1eiZgH/uSdkQ==
Date:   Tue, 2 Aug 2022 14:41:30 +0900
From:   Masami Hiramatsu (Google) <mhiramat@kernel.org>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     Tom Zanussi <zanussi@kernel.org>, Ingo Molnar <mingo@redhat.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/2] tracing/hist: Add percentage histogram suffixes
Message-Id: <20220802144130.52a75346b03fcb7c92f29db6@kernel.org>
In-Reply-To: <20220801165840.2fe7e5b0@gandalf.local.home>
References: <165932284025.2881436.6085809619146158354.stgit@devnote2>
        <20220801165840.2fe7e5b0@gandalf.local.home>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 1 Aug 2022 16:58:40 -0400
Steven Rostedt <rostedt@goodmis.org> wrote:

> On Mon,  1 Aug 2022 12:00:40 +0900
> "Masami Hiramatsu (Google)" <mhiramat@kernel.org> wrote:
> 
> > Here are a couple of patches to add .percent and .graph histogram
> > value suffixes to show the value in percentage and in bar-graph.
> > 
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
> > { pid:          8 } hitcount:         11  runtime:       4.11  runtime: #                   
> > { pid:          9 } hitcount:          4  runtime:       1.28  runtime:                     
> > { pid:         14 } hitcount:         10  runtime:       2.22  runtime:                     
> > { pid:         15 } hitcount:          1  runtime:       0.07  runtime:                     
> > { pid:         16 } hitcount:         21  runtime:       3.35  runtime: #                   
> > { pid:         57 } hitcount:          6  runtime:       2.41  runtime: #                   
> > { pid:         61 } hitcount:         42  runtime:       9.79  runtime: ####                
> > { pid:         66 } hitcount:          5  runtime:       0.69  runtime:                     
> > { pid:        147 } hitcount:         36  runtime:      45.33  runtime: ####################
> > { pid:       8548 } hitcount:          9  runtime:      17.25  runtime: #######             
> > { pid:       8549 } hitcount:          8  runtime:      13.43  runtime: #####               
> > 
> > Totals:
> >     Hits: 153
> >     Entries: 11
> >     Dropped: 0
> > 
> 
> Hi Masami,
> 
> Thanks for this as well. But as it's a new feature, and I freeze new
> features when the merge window starts, I'll add this to my queue for the
> next window.

Yeah, that's no problem. Please queue it for the next window :)

Thank you!

> 
> -- Steve


-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>
