Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 49AA459CEE9
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Aug 2022 04:59:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239552AbiHWC7F (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Aug 2022 22:59:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51776 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237982AbiHWC7C (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Aug 2022 22:59:02 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3028F2ED5D
        for <linux-kernel@vger.kernel.org>; Mon, 22 Aug 2022 19:59:02 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id C324061284
        for <linux-kernel@vger.kernel.org>; Tue, 23 Aug 2022 02:59:01 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4D2CBC433D6;
        Tue, 23 Aug 2022 02:59:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1661223541;
        bh=zEGCdiCEhQgHzxLRIHt6IH/jihMqCetl8mb2h4TvxOA=;
        h=From:To:Cc:Subject:Date:From;
        b=t77SGfZU3PeW1SOXqd935mVmEY+OTY9Ww55Il4eKFf+wbcABvfyDx6Fm0DSlE5DgH
         G0jZo8RVXDo1+MXVxsXAO9Ubzv1a4UNIlHrwBKmCb6CHwT7D5Q8VUIHGjsIwVffikt
         nVyJtrtB2qKvum2ny0NZTbJhRv5g9BuNZwr3OVrfJqvDyblCxHyzvAQw+Ib3dE29mn
         NDp9F4nguEj1Odp/LnndEceTXeLjw4k0aDsQPwET5JfA0ygcjgWDHnpQ4JnbGQi+YI
         eXdtNZ01RvzX4CDj1QapYNusYiD3+/qUhlz4qw7WkjVSWNv/mkwi3HWRD7nXLBFJld
         X1Siq2eKCB3bQ==
From:   "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     Tom Zanussi <zanussi@kernel.org>, Ingo Molnar <mingo@redhat.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v3 0/3] tracing/hist: Add percentage histogram suffixes
Date:   Tue, 23 Aug 2022 11:58:57 +0900
Message-Id: <166122353724.94548.7395770385598120122.stgit@devnote2>
X-Mailer: git-send-email 2.25.1
User-Agent: StGit/0.19
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Here is the 3rd version of .percent and .graph suffixes for histogram
trigger to show the value in percentage and in bar-graph respectively.

I added one minor bugfix patch and update original patches to show
hitcount.graph and hitcount.percent correctly.

This will help us to check the trend of the histogram instantly
without the post processing tool.

Here shows the example of the percentage and the bar graph of
the hitcount of the running tasks.

  # cd /sys/kernel/debug/tracing/
  # echo hist:keys=pid:vals=hitcount.percent,hitcount.graph:sort=pid > \
        events/sched/sched_stat_runtime/trigger
  # sleep 10
  # cat events/sched/sched_stat_runtime/hist
 # event histogram
 #
 # trigger info: hist:keys=pid:vals=hitcount,hitcount.percent,hitcount.graph:sort=pid:size=2048 [active]
 #

 { pid:          8 } hitcount:          3  hitcount (%):   3.33  hitcount: ###                 
 { pid:         16 } hitcount:         10  hitcount (%):  11.11  hitcount: ##########          
 { pid:         26 } hitcount:          1  hitcount (%):   1.11  hitcount: #                   
 { pid:         57 } hitcount:          3  hitcount (%):   3.33  hitcount: ###                 
 { pid:         61 } hitcount:         20  hitcount (%):  22.22  hitcount: ####################
 { pid:         64 } hitcount:          3  hitcount (%):   3.33  hitcount: ###                 
 { pid:         69 } hitcount:          2  hitcount (%):   2.22  hitcount: ##                  
 { pid:         70 } hitcount:          1  hitcount (%):   1.11  hitcount: #                   
 { pid:         77 } hitcount:         10  hitcount (%):  11.11  hitcount: ##########          
 { pid:        124 } hitcount:          2  hitcount (%):   2.22  hitcount: ##                  
 { pid:        130 } hitcount:          2  hitcount (%):   2.22  hitcount: ##                  
 { pid:        146 } hitcount:         18  hitcount (%):  20.00  hitcount: ##################  
 { pid:        153 } hitcount:          8  hitcount (%):   8.88  hitcount: ########            
 { pid:        154 } hitcount:          7  hitcount (%):   7.77  hitcount: #######             

 Totals:
     Hits: 90
     Entries: 14
     Dropped: 0

Thank you,

---

Masami Hiramatsu (Google) (3):
      tracing: Fix to check event_mutex is held while accessing trigger list
      tracing: Add .percent suffix option to histogram values
      tracing: Add .graph suffix option to histogram value


 kernel/trace/trace.c                |    3 -
 kernel/trace/trace_events_hist.c    |  160 +++++++++++++++++++++++++++++++----
 kernel/trace/trace_events_trigger.c |    3 -
 3 files changed, 147 insertions(+), 19 deletions(-)

--
Masami Hiramatsu (Google) <mhiramat@kernel.org>
