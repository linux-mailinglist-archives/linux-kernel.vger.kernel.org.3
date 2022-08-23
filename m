Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7BCC059EE71
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Aug 2022 23:51:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229511AbiHWVvi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 Aug 2022 17:51:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54440 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231625AbiHWVvZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Aug 2022 17:51:25 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 99BA53DBC1
        for <linux-kernel@vger.kernel.org>; Tue, 23 Aug 2022 14:51:21 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 16B06615C6
        for <linux-kernel@vger.kernel.org>; Tue, 23 Aug 2022 21:51:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7855FC433D6;
        Tue, 23 Aug 2022 21:51:20 +0000 (UTC)
Received: from rostedt by gandalf.local.home with local (Exim 4.96)
        (envelope-from <rostedt@goodmis.org>)
        id 1oQboB-009zst-17;
        Tue, 23 Aug 2022 17:51:39 -0400
Message-ID: <20220823214606.344269352@goodmis.org>
User-Agent: quilt/0.66
Date:   Tue, 23 Aug 2022 17:46:06 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     linux-kernel@vger.kernel.org
Cc:     Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Tom Zanussi <zanussi@kernel.org>
Subject: [PATCH 0/4] tracing: Have filters and histograms use a call table instead of pointers
X-Spam-Status: No, score=-6.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

While looking at the histogram and filter code, I realized that it's filled
with function pointers. With retpolines causing a big slowdown, I thought
that was problematic. Thus, I decided to see what would happen if I changed
the function pointers into enums, and instead called a single function
that did a switch on those enums and called the necessary functions
directly. The results were pretty clear.

The first patch was to update the trace event benchmark event to include
a integer value "delta" of the delta that it took to complete
(it currently only shows the delta as part of a string). By doing
so, I could benchmark the histogram and filter logic with it.

Before this series, the histogram with a single filter (to ignore the
first event, which has a delta of zero), had:

# event histogram
#
# trigger info: hist:keys=delta:vals=hitcount:sort=delta:size=2048 if delta > 0 [active]
#

{ delta:        129 } hitcount:       2213
{ delta:        130 } hitcount:     285965
{ delta:        131 } hitcount:    1146545
{ delta:        132 } hitcount:    5185432
{ delta:        133 } hitcount:   19896215
{ delta:        134 } hitcount:   53118616
{ delta:        135 } hitcount:   83816709
{ delta:        136 } hitcount:   68329562
{ delta:        137 } hitcount:   41859349
{ delta:        138 } hitcount:   46257797
{ delta:        139 } hitcount:   54400831
{ delta:        140 } hitcount:   72875007
{ delta:        141 } hitcount:   76193272
{ delta:        142 } hitcount:   49504263
{ delta:        143 } hitcount:   38821072
{ delta:        144 } hitcount:   47702679
{ delta:        145 } hitcount:   41357297
{ delta:        146 } hitcount:   22058238
{ delta:        147 } hitcount:    9720002
{ delta:        148 } hitcount:    3193542
{ delta:        149 } hitcount:     927030
{ delta:        150 } hitcount:     850772
{ delta:        151 } hitcount:    1477380
{ delta:        152 } hitcount:    2687977
{ delta:        153 } hitcount:    2865985
{ delta:        154 } hitcount:    1977492
{ delta:        155 } hitcount:    2475607
{ delta:        156 } hitcount:    3403612
{ delta:        157 } hitcount:    2264011
{ delta:        158 } hitcount:    1096214
{ delta:        159 } hitcount:     504653
{ delta:        160 } hitcount:     218869
{ delta:        161 } hitcount:     103246
[..]

Where the bulk was around 142ns, and the fastest time was 129ns.

After this series:

# event histogram
#
# trigger info: hist:keys=delta:vals=hitcount:sort=delta:size=2048 if delta > 0 [active]
#

{ delta:        103 } hitcount:         60
{ delta:        104 } hitcount:      16966
{ delta:        105 } hitcount:     396625
{ delta:        106 } hitcount:    3223400
{ delta:        107 } hitcount:   12053754
{ delta:        108 } hitcount:   20241711
{ delta:        109 } hitcount:   14850200
{ delta:        110 } hitcount:    4946599
{ delta:        111 } hitcount:    3479315
{ delta:        112 } hitcount:   18698299
{ delta:        113 } hitcount:   62388733
{ delta:        114 } hitcount:   95803834
{ delta:        115 } hitcount:   58278130
{ delta:        116 } hitcount:   15364800
{ delta:        117 } hitcount:    5586866
{ delta:        118 } hitcount:    2346880
{ delta:        119 } hitcount:    1131091
{ delta:        120 } hitcount:     620896
{ delta:        121 } hitcount:     236652
{ delta:        122 } hitcount:     105957
{ delta:        123 } hitcount:     119107
{ delta:        124 } hitcount:      54494
{ delta:        125 } hitcount:      63856
{ delta:        126 } hitcount:      64454
{ delta:        127 } hitcount:      34818
{ delta:        128 } hitcount:      41446
{ delta:        129 } hitcount:      51242
{ delta:        130 } hitcount:      28361
{ delta:        131 } hitcount:      23926
{ delta:        132 } hitcount:      22253
{ delta:        133 } hitcount:      16994
{ delta:        134 } hitcount:      14970
{ delta:        135 } hitcount:      13464
{ delta:        136 } hitcount:      11452
{ delta:        137 } hitcount:      12212
{ delta:        138 } hitcount:      12280
{ delta:        139 } hitcount:       9127
{ delta:        140 } hitcount:       9553

Where the bulk was around 114ns and the fast time was 103ns.

That's almost a 20% speedup!!!


Steven Rostedt (Google) (4):
      tracing: Add numeric delta time to the trace event benchmark
      tracing/hist: Call hist functions directly via a switch statement
      tracing: Move struct filter_pred into trace_events_filter.c
      tracing/filter: Call filter predicate functions directly via a switch statement

----
 kernel/trace/trace.h               |  13 --
 kernel/trace/trace_benchmark.c     |   2 +-
 kernel/trace/trace_benchmark.h     |   8 +-
 kernel/trace/trace_events_filter.c | 239 +++++++++++++++++++++++++-----------
 kernel/trace/trace_events_hist.c   | 244 +++++++++++++++++++++++++------------
 5 files changed, 342 insertions(+), 164 deletions(-)
