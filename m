Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E0AD05872A9
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Aug 2022 22:59:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234880AbiHAU7a (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 Aug 2022 16:59:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57412 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234629AbiHAU7M (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Aug 2022 16:59:12 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6706E41D27
        for <linux-kernel@vger.kernel.org>; Mon,  1 Aug 2022 13:58:45 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 06443B811FB
        for <linux-kernel@vger.kernel.org>; Mon,  1 Aug 2022 20:58:44 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2D243C433D6;
        Mon,  1 Aug 2022 20:58:42 +0000 (UTC)
Date:   Mon, 1 Aug 2022 16:58:40 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
Cc:     Tom Zanussi <zanussi@kernel.org>, Ingo Molnar <mingo@redhat.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/2] tracing/hist: Add percentage histogram suffixes
Message-ID: <20220801165840.2fe7e5b0@gandalf.local.home>
In-Reply-To: <165932284025.2881436.6085809619146158354.stgit@devnote2>
References: <165932284025.2881436.6085809619146158354.stgit@devnote2>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon,  1 Aug 2022 12:00:40 +0900
"Masami Hiramatsu (Google)" <mhiramat@kernel.org> wrote:

> Here are a couple of patches to add .percent and .graph histogram
> value suffixes to show the value in percentage and in bar-graph.
> 
> This will help us to check the trend of the histogram instantly
> without the post processing tool.
> 
> Here shows the example of the percentage and the bar graph of
> the runtime of the running tasks.
> 
> /sys/kernel/tracing # echo hist:keys=pid:vals=runtime.percent,runtime.graph:sort
> =pid >> events/sched/sched_stat_runtime/trigger
> /sys/kernel/tracing # sleep 10
> /sys/kernel/tracing # cat events/sched/sched_stat_runtime/hist
> # event histogram
> #
> # trigger info: hist:keys=pid:vals=hitcount,runtime.percent,runtime.graph:sort=pid:size=2048 [active]
> #
> 
> { pid:          8 } hitcount:         11  runtime:       4.11  runtime: #                   
> { pid:          9 } hitcount:          4  runtime:       1.28  runtime:                     
> { pid:         14 } hitcount:         10  runtime:       2.22  runtime:                     
> { pid:         15 } hitcount:          1  runtime:       0.07  runtime:                     
> { pid:         16 } hitcount:         21  runtime:       3.35  runtime: #                   
> { pid:         57 } hitcount:          6  runtime:       2.41  runtime: #                   
> { pid:         61 } hitcount:         42  runtime:       9.79  runtime: ####                
> { pid:         66 } hitcount:          5  runtime:       0.69  runtime:                     
> { pid:        147 } hitcount:         36  runtime:      45.33  runtime: ####################
> { pid:       8548 } hitcount:          9  runtime:      17.25  runtime: #######             
> { pid:       8549 } hitcount:          8  runtime:      13.43  runtime: #####               
> 
> Totals:
>     Hits: 153
>     Entries: 11
>     Dropped: 0
> 

Hi Masami,

Thanks for this as well. But as it's a new feature, and I freeze new
features when the merge window starts, I'll add this to my queue for the
next window.

-- Steve
