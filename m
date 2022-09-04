Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 591B85AC23B
	for <lists+linux-kernel@lfdr.de>; Sun,  4 Sep 2022 06:12:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231430AbiIDEMU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 4 Sep 2022 00:12:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37550 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229537AbiIDEMS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 4 Sep 2022 00:12:18 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D16B44A82F
        for <linux-kernel@vger.kernel.org>; Sat,  3 Sep 2022 21:12:17 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 7B90EB80C9E
        for <linux-kernel@vger.kernel.org>; Sun,  4 Sep 2022 04:12:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ED021C433D6;
        Sun,  4 Sep 2022 04:12:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1662264735;
        bh=IWWPZIai/pvtQVuXW9h1u1Got8bnOquJuZBLkLLQPmg=;
        h=From:To:Cc:Subject:Date:From;
        b=rblN8ctr3Z0JY9PfKAt+vFY/f5haM9FtiNSIJtZgqii9y7xKM2I66cQS9Xgva/FpB
         LtmLv8OLvKHytis437zIiqW04nEUi9EOfSIis5CRCg81fA8bjBM9wWMaUiXud/OqYz
         iCvTFyN3Ws024HV98o2qSCNt795ZiRcoaD1GxMKzm0xrOUijcMpFG5VolN+MbhnYO1
         7AxyDPg6U2+I2vMrEjPckEj7AQ9b2AnGzw0hvI/lFKYCtF6XcD+b9TA7ONQiH7jZ1D
         gbM632lwj1BYe1KjEK+DHln/BMVIqv6WXFluCusKXv+6KnFcRV5Y6GYva6NsNN2mYG
         hkv6I/0AsxgbQ==
From:   "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     Tom Zanussi <zanussi@kernel.org>, Ingo Molnar <mingo@redhat.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v5 0/6] tracing/hist: Add percentage histogram suffixes
Date:   Sun,  4 Sep 2022 13:12:11 +0900
Message-Id: <166226473132.223837.9011128463174539022.stgit@devnote2>
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

Here is the 5th version of .percent and .graph suffixes for histogram
trigger to show the value in percentage and in bar-graph respectively.
The previous version is here;

https://lore.kernel.org/all/166157298537.348924.2537162090505397377.stgit@devnote2

This version updated the last patch to add "nohitcount" option for
supressing display of hitcount according to Tom's suggestion[5/6],
fix README file[4/6], and update the histogram document[6/6].

This will help us to check the trend of the histogram instantly
without any post processing tool.

Here shows an example of the percentage and the bar graph of
the runtime of the running tasks without raw hitcount field.

  # cd /sys/kernel/debug/tracing/
  # echo hist:keys=pid:vals=hitcount.percent,hitcount.graph:sort=pid:NOHC > \
        events/sched/sched_stat_runtime/trigger
  # sleep 10
  # cat events/sched/sched_stat_runtime/hist
 # event histogram
 #
 # trigger info: hist:keys=pid:vals=hitcount.percent,hitcount.graph:sort=pid:size=2048:nohitcount [active]
 #
 
 { pid:         14 }  hitcount (%):   6.91  hitcount: ##                  
 { pid:         16 }  hitcount (%):   1.13  hitcount:                     
 { pid:         57 }  hitcount (%):   6.99  hitcount: ##                  
 { pid:         61 }  hitcount (%):  55.28  hitcount: ####################
 { pid:         67 }  hitcount (%):   5.52  hitcount: ##                  
 { pid:         69 }  hitcount (%):  20.08  hitcount: #######             
 { pid:         71 }  hitcount (%):   0.40  hitcount:                     
 { pid:         77 }  hitcount (%):   0.97  hitcount:                     
 { pid:         78 }  hitcount (%):   0.56  hitcount:                     
 { pid:        145 }  hitcount (%):   1.13  hitcount:                     
 { pid:        153 }  hitcount (%):   0.48  hitcount:                     
 { pid:        154 }  hitcount (%):   0.48  hitcount:                     
 
 Totals:
     Hits: 1230
     Entries: 12
     Dropped: 0


With the NOHC (or nohitcount) option, the histogram will skip
display of raw hitcount, but it will allow to display percent
and graph of hitcount.

Trigger                      Result
val=runtime               -> Show hitcount and runtime
val=runtime:NOHC          -> Show runtime
val=hitcount:NOHC         -> Error
(noval)                   -> show hitcount
(noval):NOHC              -> Error
val=hitcount.parcent      -> show hitcount and hitcount%
val=hitcount.parcent:NOHC -> show hitcount%

Thank you,

---

Masami Hiramatsu (Google) (5):
      tracing: Fix to check event_mutex is held while accessing trigger list
      tracing: Add .percent suffix option to histogram values
      tracing: Add .graph suffix option to histogram value
      tracing: Add nohitcount option for suppressing display of raw hitcount
      tracing: docs: Update histogram doc for .percent/.graph and 'nohitcount'

Tom Zanussi (1):
      tracing: Allow multiple hitcount values in histograms


 Documentation/trace/histogram.rst   |   10 ++
 kernel/trace/trace.c                |    7 +
 kernel/trace/trace_events_hist.c    |  177 ++++++++++++++++++++++++++++++-----
 kernel/trace/trace_events_trigger.c |    3 -
 4 files changed, 171 insertions(+), 26 deletions(-)

--
Masami Hiramatsu (Google) <mhiramat@kernel.org>
