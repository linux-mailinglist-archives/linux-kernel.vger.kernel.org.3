Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8351C596024
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Aug 2022 18:27:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236330AbiHPQZ5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 Aug 2022 12:25:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44474 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236237AbiHPQZz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Aug 2022 12:25:55 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 33AD6EE0D
        for <linux-kernel@vger.kernel.org>; Tue, 16 Aug 2022 09:25:54 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id C4E1B6124E
        for <linux-kernel@vger.kernel.org>; Tue, 16 Aug 2022 16:25:53 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 350C4C433D6;
        Tue, 16 Aug 2022 16:25:52 +0000 (UTC)
Date:   Tue, 16 Aug 2022 12:25:59 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Krister Johansen <kjlx@templeofstupid.com>
Cc:     Ingo Molnar <mingo@redhat.com>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        David Reaver <me@davidreaver.com>,
        linux-kernel@vger.kernel.org, Jiri Olsa <jolsa@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Frederic Weisbecker <fweisbec@gmail.com>
Subject: Re: [PATCH 1/1] tracing: fix a WARN from trace_event_dyn_put_ref
Message-ID: <20220816122559.17869abc@gandalf.local.home>
In-Reply-To: <4e43a4eece5f382d1636397fb3c0208f2afe81fc.1660347763.git.kjlx@templeofstupid.com>
References: <cover.1660347763.git.kjlx@templeofstupid.com>
        <4e43a4eece5f382d1636397fb3c0208f2afe81fc.1660347763.git.kjlx@templeofstupid.com>
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


[ Added the authors of this code to the Cc ]

On Fri, 12 Aug 2022 17:02:20 -0700
Krister Johansen <kjlx@templeofstupid.com> wrote:

> The code in perf_trace_init takes a reference on a trace_event_call that is
> looked up as part of the function call.  If perf_trace_event_int fails,
> however, perf_trace_event_unreg can decrement that refcount from underneath
> perf_trace_init.  This means that in some failure cases, perf_trace_init
> can trigger the WARN in trace_dynevent.c which attempts to guard against
> zero reference counts going negative.
> 
> The author can reproduce this problem readily by running perf record in a
> loop against a series of uprobes with no other users.  Killing the record
> process before it can finish its setup is enough to trigger this warn
> within a few seconds.
> 
> This patch leaves the behavior in perf_trace_event_unreg unchanged, but
> moves most of the code in that function to perf_trace_event_cleanup.  The
> unreg function retains the ability to drop the refcount on the tp_event,
> but cleanup does not.  This modification is based upon the observation that
> all of the other callers of perf_trace_event_init don't bother with
> manipulating a reference count on the tp_events that they create.  For
> those callers, the trace_event_put_ref was already a no-op.
> 
> Signed-off-by: Krister Johansen <kjlx@templeofstupid.com>
> Reviewed-by: David Reaver <me@davidreaver.com>
> Fixes: 1d18538e6a092 "tracing: Have dynamic events have a ref counter"
> CC: stable@vger.kernel.org # 5.15, 5.18, 5.19
> ---
>  kernel/trace/trace_event_perf.c | 14 ++++++++++----
>  1 file changed, 10 insertions(+), 4 deletions(-)
> 
> diff --git a/kernel/trace/trace_event_perf.c b/kernel/trace/trace_event_perf.c
> index a114549720d6..7762bfd268cd 100644
> --- a/kernel/trace/trace_event_perf.c
> +++ b/kernel/trace/trace_event_perf.c
> @@ -151,13 +151,13 @@ static int perf_trace_event_reg(struct trace_event_call *tp_event,
>  	return ret;
>  }
>  
> -static void perf_trace_event_unreg(struct perf_event *p_event)
> +static void perf_trace_event_cleanup(struct perf_event *p_event)
>  {
>  	struct trace_event_call *tp_event = p_event->tp_event;
>  	int i;
>  
>  	if (--tp_event->perf_refcount > 0)
> -		goto out;
> +		return;
>  
>  	tp_event->class->reg(tp_event, TRACE_REG_PERF_UNREGISTER, NULL);
>  
> @@ -176,7 +176,13 @@ static void perf_trace_event_unreg(struct perf_event *p_event)
>  			perf_trace_buf[i] = NULL;
>  		}
>  	}
> -out:
> +}
> +
> +static void perf_trace_event_unreg(struct perf_event *p_event)
> +{
> +	struct trace_event_call *tp_event = p_event->tp_event;
> +
> +	perf_trace_event_cleanup(p_event);
>  	trace_event_put_ref(tp_event);
>  }
>  
> @@ -207,7 +213,7 @@ static int perf_trace_event_init(struct trace_event_call *tp_event,
>  
>  	ret = perf_trace_event_open(p_event);
>  	if (ret) {
> -		perf_trace_event_unreg(p_event);
> +		perf_trace_event_cleanup(p_event);

The only problem I have with this patch is the loss of symmetry. Where
perf_trace_event_reg() returns successful, so unreg() should be the
function you call on failure.

Since perf_trace_event_reg() is only called from perf_trace_event_init()
let's move the perf_trace_event_open() into the perf_trace_event_reg() and
have the unreg still do the clean up on failure.

This way we keep the symmetry between *_reg() and *_unreg().

And then the init function will not have to do any clean up, and can just
end with:

	return perf_trace_event_reg(tp_event, p_event);

Thanks,

-- Steve


>  		return ret;
>  	}
>  

