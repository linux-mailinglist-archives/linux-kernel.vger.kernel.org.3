Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1072E59AE87
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Aug 2022 15:47:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346208AbiHTNnw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 20 Aug 2022 09:43:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36320 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344987AbiHTNnt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 20 Aug 2022 09:43:49 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8026513F06
        for <linux-kernel@vger.kernel.org>; Sat, 20 Aug 2022 06:43:48 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 451B36069D
        for <linux-kernel@vger.kernel.org>; Sat, 20 Aug 2022 13:43:47 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 981C2C433D6;
        Sat, 20 Aug 2022 13:43:46 +0000 (UTC)
Received: from rostedt by gandalf.local.home with local (Exim 4.96)
        (envelope-from <rostedt@goodmis.org>)
        id 1oPOlc-005ALG-1k;
        Sat, 20 Aug 2022 09:44:00 -0400
Message-ID: <20220820134316.156058831@goodmis.org>
User-Agent: quilt/0.66
Date:   Sat, 20 Aug 2022 09:43:16 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     linux-kernel@vger.kernel.org
Cc:     Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Tzvetomir Stoyanov <tz.stoyanov@gmail.com>,
        Tom Zanussi <zanussi@kernel.org>
Subject: [PATCH v2 0/6] tracing/eprobes: Fixes for unexpected arguments
X-Spam-Status: No, score=-6.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


While using eprobes, I decided to entertain the thougth of what would
happen if I tried to get the instruction pointer "%rip", knowing full
well that eprobes do not have access to pt_regs. Well, I found out, and
it led me down a rabbit hole of bugs.

This series fixes those bugs, by not allowing register access for eprobes,
and also filling the holes of @symbol and @immediate argument.

Changes since v1: https://lore.kernel.org/all/20220820014035.531145719@goodmis.org/
  - Fixed parenthesis warning

  - Fixed comment about comm arguments

  - Made kprobes and eprobes process "$COMM" as well as "$comm"

  - Made filters consistent with histograms with "common_cpu"

Steven Rostedt (Google) (6):
      tracing/eprobes: Do not allow eprobes to use $stack, or % for regs
      tracing/eprobes: Do not hardcode $comm as a string
      tracing/eprobes: Fix reading of string fields
      tracing/eprobes: Have event probes be consistent with kprobes and uprobes
      tracing/probes: Have kprobes and uprobes use $COMM too
      tracing: Have filter accept "common_cpu" to be consistent

----
 kernel/trace/trace_eprobe.c | 91 ++++++++++++++++++++++++++++++++++++++++++---
 kernel/trace/trace_events.c |  1 +
 kernel/trace/trace_probe.c  | 29 +++++++++------
 3 files changed, 104 insertions(+), 17 deletions(-)
