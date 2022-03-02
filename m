Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5A37C4C9C25
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Mar 2022 04:28:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239344AbiCBD3M (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Mar 2022 22:29:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55440 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239330AbiCBD3H (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Mar 2022 22:29:07 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA52DB0C74
        for <linux-kernel@vger.kernel.org>; Tue,  1 Mar 2022 19:28:24 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 30991B81D71
        for <linux-kernel@vger.kernel.org>; Wed,  2 Mar 2022 03:28:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D7F48C340F0;
        Wed,  2 Mar 2022 03:28:21 +0000 (UTC)
Received: from rostedt by gandalf.local.home with local (Exim 4.95)
        (envelope-from <rostedt@goodmis.org>)
        id 1nPFf2-00DBie-LW;
        Tue, 01 Mar 2022 22:28:20 -0500
Message-ID: <20220302032414.503960863@goodmis.org>
User-Agent: quilt/0.66
Date:   Tue, 01 Mar 2022 22:24:14 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     linux-kernel@vger.kernel.org
Cc:     Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Joel Fernandes <joel@joelfernandes.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Tom Zanussi <zanussi@kernel.org>
Subject: [PATCH 0/2] tracing: Add a way to have custom events in the tracefs directory
X-Spam-Status: No, score=-6.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We would like to have in production a way to record sched wakeups and
sched switch, and be able to save the information in a small file
with as much available as possible. Currently the wake up and sched switch
events are 36 and 64 bytes each (plus a 4 byte ring buffer event header).

By having a custom module tap into the sched switch and waking trace points
we can bring those events down to 16 and 14 bytes respectively.

Steven Rostedt (Google) (2):
      tracing: Allow custom events to be added to the tracefs directory
      tracing: Add sample code for custom trace events

----
 kernel/trace/trace_events.c               |   2 +
 samples/Kconfig                           |   8 +-
 samples/Makefile                          |   1 +
 samples/trace_events/Makefile             |   2 +
 samples/trace_events/trace_custom_sched.c | 280 ++++++++++++++++++++++++++++++
 5 files changed, 292 insertions(+), 1 deletion(-)
 create mode 100644 samples/trace_events/trace_custom_sched.c
