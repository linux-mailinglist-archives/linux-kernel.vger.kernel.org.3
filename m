Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BF48C597075
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Aug 2022 16:09:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240032AbiHQOEn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 Aug 2022 10:04:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52032 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237149AbiHQOEF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Aug 2022 10:04:05 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 569C4615C
        for <linux-kernel@vger.kernel.org>; Wed, 17 Aug 2022 07:03:25 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 150A761469
        for <linux-kernel@vger.kernel.org>; Wed, 17 Aug 2022 14:03:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8662BC4314C;
        Wed, 17 Aug 2022 14:03:22 +0000 (UTC)
Date:   Wed, 17 Aug 2022 10:03:31 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Krister Johansen <kjlx@templeofstupid.com>
Cc:     LKML <linux-kernel@vger.kernel.org>, Jiri Olsa <jolsa@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Frederic Weisbecker <fweisbec@gmail.com>,
        Ingo Molnar <mingo@kernel.org>,
        David Reaver <me@davidreaver.com>,
        Masami Hiramatsu <mhiramat@kernel.org>
Subject: Re: [PATCH] tracing/perf: Fix double put of trace event when init
 fails
Message-ID: <20220817100331.0851f7a2@gandalf.local.home>
In-Reply-To: <20220817044656.GA1941@templeofstupid.com>
References: <20220816192817.43d5e17f@gandalf.local.home>
        <20220817044656.GA1941@templeofstupid.com>
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

On Tue, 16 Aug 2022 21:46:56 -0700
Krister Johansen <kjlx@templeofstupid.com> wrote:

> Thanks again, Steven.  Is this one that you would consider tagging for a
> backport to stable at the appropriate time? I believe this one showed up
> in 5.15, if it's any help.

So the warning started with this commit:

   1d18538e6a092 ("tracing: Have dynamic events have a ref counter")

Which switched the module_put() to the trace_event_put(). I guess the
difference is that module_put() has

	ret = atomic_dec_if_positive(&module->refcnt);

Where it could be called more than once after reaching zero and not warn
about it. But the trace_event_put() will warn if you call it after it
reaches zero.

I'll add a stable tag.

-- Steve
