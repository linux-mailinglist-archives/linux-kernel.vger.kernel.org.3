Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4ED0A5A3441
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Aug 2022 06:05:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232116AbiH0EDR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 27 Aug 2022 00:03:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60668 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229449AbiH0EDM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 27 Aug 2022 00:03:12 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F37C2E398D
        for <linux-kernel@vger.kernel.org>; Fri, 26 Aug 2022 21:03:10 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 0361861DCF
        for <linux-kernel@vger.kernel.org>; Sat, 27 Aug 2022 04:03:10 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 38407C433C1;
        Sat, 27 Aug 2022 04:03:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1661572989;
        bh=ehcQFeMDwSm+yrUdn1K0FD1tIXNWCnHe2vng7L9bw0k=;
        h=From:To:Cc:Subject:Date:From;
        b=Em8MGkIvbEXYTGTv8xKdUV6L7pLx2z/iNBE2nzzZzzmoD0x411oXMvL5Sz2O9FCnc
         1QreMFXTfMwfzPs1c6567XneQWwi4IRTd3ceJxj8n5tzz+D/iixzThe/cS+8qKZc1a
         qsTSDPHwN+nmZ9zX6ljjYt0UXaNkAp5wWiDdlvXW0udkzAG8X8UkePlVl8xJPf4rLm
         mJ0Uuv4gr3fpV0DsG83ttUGs9/VpmE4lgcmnjKqRbe/7tb98ijpP0UvE8T0+U+SptD
         2kaDW1HZrf9nnHo7M1OsYDSHeeImIUQlM0/B6JSABnvxaxAORBFaChmPmdrcyWzNpe
         DWYuQlyQog4Nw==
From:   "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     Tom Zanussi <zanussi@kernel.org>, Ingo Molnar <mingo@redhat.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v4 0/5] tracing/hist: Add percentage histogram suffixes
Date:   Sat, 27 Aug 2022 13:03:05 +0900
Message-Id: <166157298537.348924.2537162090505397377.stgit@devnote2>
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

Here is the 4th version of .percent and .graph suffixes for histogram
trigger to show the value in percentage and in bar-graph respectively.

I've rebased on Tom's hitcount patch[1/5] on the series and added a patch
for supressing display of hitcount[5/5] in this version.

This will help us to check the trend of the histogram instantly
without any post processing tool.

Here shows an example of the percentage and the bar graph of
the hitcount of the running tasks.

  # cd /sys/kernel/debug/tracing/
  # echo hist:keys=pid:vals=hitcount.percent,hitcount.graph:sort=pid > \
        events/sched/sched_stat_runtime/trigger
  # sleep 10
  # cat events/sched/sched_stat_runtime/hist
 # event histogram
 #
 # trigger info: hist:keys=pid:vals=hitcount.percent,hitcount.graph:sort=pid:size=2048 [active]
 #

 { pid:         14 } hitcount (%):   4.68  hitcount: ###                 
 { pid:         16 } hitcount (%):  17.18  hitcount: ###########         
 { pid:         57 } hitcount (%):   7.81  hitcount: #####               
 { pid:         61 } hitcount (%):  31.25  hitcount: ####################
 { pid:         70 } hitcount (%):   4.68  hitcount: ###                 
 { pid:         77 } hitcount (%):   1.56  hitcount: #                   
 { pid:        145 } hitcount (%):  18.75  hitcount: ############        
 { pid:        151 } hitcount (%):   9.37  hitcount: ######              
 { pid:        152 } hitcount (%):   4.68  hitcount: ###                 

 Totals:
     Hits: 64
     Entries: 9
     Dropped: 0

Of course if you explicitly specify the hitcount, it can show the
hitcount as below;

  # cd /sys/kernel/debug/tracing/
  # echo hist:keys=pid:vals=hitcount,runtime:sort=pid > \
        events/sched/sched_stat_runtime/trigger
  # sleep 10
  # cat events/sched/sched_stat_runtime/hist
 # event histogram
 #
 # trigger info: hist:keys=pid:vals=hitcount,runtime:sort=pid:size=2048 [active]
 #

 { pid:         14 } hitcount:          2  runtime:     304876
 { pid:         16 } hitcount:          8  runtime:     300574
 { pid:         26 } hitcount:          2  runtime:      15578
 { pid:         32 } hitcount:          2  runtime:     219186
 { pid:         57 } hitcount:          3  runtime:     506003
 { pid:         61 } hitcount:         20  runtime:    1681473
 { pid:         69 } hitcount:          3  runtime:     201785
 { pid:         70 } hitcount:          4  runtime:     360608
 { pid:         77 } hitcount:          8  runtime:    4146935
 { pid:        145 } hitcount:         13  runtime:    7537994
 { pid:        155 } hitcount:          4  runtime:    2511937
 { pid:        156 } hitcount:          2  runtime:    1398886

 Totals:
     Hits: 71
     Entries: 12
     Dropped: 0


Thank you,

---

Masami Hiramatsu (Google) (4):
      tracing: Fix to check event_mutex is held while accessing trigger list
      tracing: Add .percent suffix option to histogram values
      tracing: Add .graph suffix option to histogram value
      tracing: Show hitcount value only when specified

Tom Zanussi (1):
      tracing: Allow multiple hitcount values in histograms


 kernel/trace/trace.c                |    3 -
 kernel/trace/trace_events_hist.c    |  176 ++++++++++++++++++++++++++++++-----
 kernel/trace/trace_events_trigger.c |    3 -
 3 files changed, 156 insertions(+), 26 deletions(-)

--
Masami Hiramatsu (Google) <mhiramat@kernel.org>
