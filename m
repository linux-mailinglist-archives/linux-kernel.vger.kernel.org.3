Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1361A5AF9B3
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Sep 2022 04:08:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229564AbiIGCI3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Sep 2022 22:08:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45634 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229477AbiIGCI2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Sep 2022 22:08:28 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 97F92857E5
        for <linux-kernel@vger.kernel.org>; Tue,  6 Sep 2022 19:08:27 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 2F8E061700
        for <linux-kernel@vger.kernel.org>; Wed,  7 Sep 2022 02:08:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E601EC433D6;
        Wed,  7 Sep 2022 02:08:25 +0000 (UTC)
Date:   Tue, 6 Sep 2022 22:09:04 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
Cc:     Tom Zanussi <zanussi@kernel.org>, Ingo Molnar <mingo@redhat.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5 2/6] tracing: Fix to check event_mutex is held while
 accessing trigger list
Message-ID: <20220906220904.1abd4610@gandalf.local.home>
In-Reply-To: <166226474977.223837.1992182913048377113.stgit@devnote2>
References: <166226473132.223837.9011128463174539022.stgit@devnote2>
        <166226474977.223837.1992182913048377113.stgit@devnote2>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun,  4 Sep 2022 13:12:29 +0900
"Masami Hiramatsu (Google)" <mhiramat@kernel.org> wrote:

> From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
> 
> Since the check_user_trigger() is called outside of RCU
> read lock, this list_for_each_entry_rcu() caused a suspicious
> RCU usage warning.
> 
>  # echo hist:keys=pid > events/sched/sched_stat_runtime/trigger
>  # cat events/sched/sched_stat_runtime/trigger
> [   43.167032]
> [   43.167418] =============================
> [   43.167992] WARNING: suspicious RCU usage
> [   43.168567] 5.19.0-rc5-00029-g19ebe4651abf #59 Not tainted
> [   43.169283] -----------------------------
> [   43.169863] kernel/trace/trace_events_trigger.c:145 RCU-list traversed in non-reader section!!
> ...
> 
> However, this file->triggers list is safe when it is accessed
> under event_mutex is held.
> To fix this warning, adds a lockdep_is_held check to the
> list_for_each_entry_rcu().
> 
> Fixes: 7491e2c44278 ("tracing: Add a probe that attaches to trace events")
> Signed-off-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
> ---

I'm going to pull this patch out of these series, mark it for stable, and
add it to my queue that is going to Linus.

-- Steve
