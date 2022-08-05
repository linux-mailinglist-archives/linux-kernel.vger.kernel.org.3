Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0CA5F58A482
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Aug 2022 03:37:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235447AbiHEBfR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 Aug 2022 21:35:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47326 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230442AbiHEBfN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Aug 2022 21:35:13 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0CBB9DA1
        for <linux-kernel@vger.kernel.org>; Thu,  4 Aug 2022 18:35:13 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 99D9061986
        for <linux-kernel@vger.kernel.org>; Fri,  5 Aug 2022 01:35:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 02C76C433D6;
        Fri,  5 Aug 2022 01:35:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1659663312;
        bh=63S+jpOJ/Sl6zEIpGxgfrLl6kaVn48gxUh77qMDVQag=;
        h=From:To:Cc:Subject:Date:From;
        b=RjaQviXtuXD6NbNDIX5bh4A+sNPFN5E6rwdTduTJEqrJS8thdbaabAElyPMpJjqKQ
         fkr3VACHI5XmdExlip+Jo1eGomU7MgmsxdQJLelYfmsu9Jir/hnkYOMmV2TalgKA4b
         rld/j4dAG8WWfGfYbcXDpHRbgwLYyjFICzGLinLV7NaumdkjF5WCCVyW3DkEmKC47L
         R4EnVRP5BEVjqON0lH+HHrHlsX1DECvcyGpPkGox+5kiabKych+1/uMJQ+iu855kDn
         5zCv1OxUSYaedfHUtG8mAV6vpQYoRM+4NGJji4Bx+2AmzVjJIzRqspzB1HIjh1nfxY
         RmPiEIusCyTsg==
From:   "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     Tom Zanussi <zanussi@kernel.org>, Ingo Molnar <mingo@redhat.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 0/2] tracing/hist: Add percentage histogram suffixes
Date:   Fri,  5 Aug 2022 10:35:07 +0900
Message-Id: <165966330764.3826604.9358384228095103695.stgit@devnote2>
X-Mailer: git-send-email 2.25.1
User-Agent: StGit/0.19
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Here is the 2nd version of .percent and .graph suffixes for histogram
trigger to show the value in percentage and in bar-graph respectively.

This version uses div64_*() for calculating percentages and show an
error if it fails to calculate it.

This will help us to check the trend of the histogram instantly
without the post processing tool.

Here shows the example of the percentage and the bar graph of
the runtime of the running tasks.

/sys/kernel/tracing # echo hist:keys=pid:vals=runtime.percent,runtime.graph:sort
=pid >> events/sched/sched_stat_runtime/trigger
/sys/kernel/tracing # sleep 10
/sys/kernel/tracing # cat events/sched/sched_stat_runtime/hist
# event histogram
#
# trigger info: hist:keys=pid:vals=hitcount,runtime.percent,runtime.graph:sort=pid:size=2048 [active]
#

{ pid:          8 } hitcount:         11  runtime:       4.11  runtime: #                   
{ pid:          9 } hitcount:          4  runtime:       1.28  runtime:                     
{ pid:         14 } hitcount:         10  runtime:       2.22  runtime:                     
{ pid:         15 } hitcount:          1  runtime:       0.07  runtime:                     
{ pid:         16 } hitcount:         21  runtime:       3.35  runtime: #                   
{ pid:         57 } hitcount:          6  runtime:       2.41  runtime: #                   
{ pid:         61 } hitcount:         42  runtime:       9.79  runtime: ####                
{ pid:         66 } hitcount:          5  runtime:       0.69  runtime:                     
{ pid:        147 } hitcount:         36  runtime:      45.33  runtime: ####################
{ pid:       8548 } hitcount:          9  runtime:      17.25  runtime: #######             
{ pid:       8549 } hitcount:          8  runtime:      13.43  runtime: #####               

Totals:
    Hits: 153
    Entries: 11
    Dropped: 0


Thank you,

---

Masami Hiramatsu (Google) (2):
      tracing: Add .percent suffix option to histogram values
      tracing: Add .graph suffix option to histogram value


 kernel/trace/trace.c             |    3 +
 kernel/trace/trace_events_hist.c |  129 ++++++++++++++++++++++++++++++++++++--
 2 files changed, 124 insertions(+), 8 deletions(-)

--
Masami Hiramatsu (Google) <mhiramat@kernel.org>
