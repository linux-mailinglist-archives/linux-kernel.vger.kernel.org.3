Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 48816588844
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Aug 2022 09:50:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237079AbiHCHuY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 Aug 2022 03:50:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40938 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234663AbiHCHuW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Aug 2022 03:50:22 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB4E89FDE;
        Wed,  3 Aug 2022 00:50:20 -0700 (PDT)
Date:   Wed, 3 Aug 2022 09:50:17 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1659513019;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=dlzjMvdxHZr3wJ0ux9kQ0Lvo6AT9nnrD4nXVK3eGOeo=;
        b=rLKhQqgtu+QGgGq/PvU09fcWl3eYD5euXHH2NBkJPq4Sx20Xbf6JXJliBOzPDPUEpzoXlD
        q8fWAkLhNI4eR/Pyf7+bWGHWrI5T3DqNVzInJBSFXRC18/3fhqZHEMGMsLtwAUl4pDCBQF
        tFK4Uj4+l9MHMGzX7UGQMGJAymkACLEYHUPGZPCITvuNKK40kpgZG3qkClw5PKKSnC0Ytz
        fX8oNFINxG/PS4Vg5IUQpHq5v1pt/umxXyaVwQLj41PULo+myYbXy7J/6p3/mlYGPCztj/
        U3r3QAM3BBWQiZ0TvjRYSX6Ayl/g7M9c+HVG3OjgrR3DKSMMbcYf/RGR1nfo5w==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1659513019;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=dlzjMvdxHZr3wJ0ux9kQ0Lvo6AT9nnrD4nXVK3eGOeo=;
        b=6YtScFnQEjbBynP9OgEGNh/qIPZ3U1P17gqzwAqNtmXM6AhHbTDTIGkKvxlQcToVjLbyaZ
        uBddK5mFRwJX2dDQ==
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     Anand Je Saipureddy <s.anandje1@gmail.com>,
        "Luis Claudio R. Goncalves" <lgoncalv@redhat.com>,
        Clark Williams <williams@redhat.com>
Cc:     linux-rt-users@vger.kernel.org, linux-kernel@vger.kernel.org,
        cminyard@mvista.com, psiddaiah@mvista.com
Subject: Re: [PATCH] ftrace: Fix improper usage of __trace_stack() function.
Message-ID: <YuooucgDVO0uDPS/@linutronix.de>
References: <20220723064943.16532-1-s.anandje1@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20220723064943.16532-1-s.anandje1@gmail.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2022-07-23 12:19:43 [+0530], Anand Je Saipureddy wrote:
> In kernel/trace/trace_events_trigger.c --> stacktrace_trigger() -->
> __trace_stack() is not defined as per the function definition.
> 
> With commit edbaaa13a660
> ("tracing: Merge irqflags + preemt counter, add RT bits")
> the irqflags(flags) and preemption counter(preempt_count()) are
> now should be evaluated early by tracing_gen_ctx().
> 
> This patch replaces the irqflags and preemption counter
> with tracing_gen_ctx().
> 
> Fixes: 5e8446e3820c ("tracing: Dump stacktrace trigger to the corresponding instance")
> Signed-off-by: Anand Je Saipureddy <s.anandje1@gmail.com>
> Reviewed-by: Corey Minyard <cminyard@mvista.com>

Please use [PATCH RT v5.10] in the future.
Luis, could you please pick it up?

> ---
>  kernel/trace/trace_events_trigger.c | 8 +++-----
>  1 file changed, 3 insertions(+), 5 deletions(-)
> 
> diff --git a/kernel/trace/trace_events_trigger.c b/kernel/trace/trace_events_trigger.c
> index 75fef9fcfd0f..3c6229f16e81 100644
> --- a/kernel/trace/trace_events_trigger.c
> +++ b/kernel/trace/trace_events_trigger.c
> @@ -1220,12 +1220,10 @@ stacktrace_trigger(struct event_trigger_data *data, void *rec,
>  		   struct ring_buffer_event *event)
>  {
>  	struct trace_event_file *file = data->private_data;
> -	unsigned long flags;
>  
> -	if (file) {
> -		local_save_flags(flags);
> -		__trace_stack(file->tr, STACK_SKIP, preempt_count());
> -	} else
> +	if (file)
> +		__trace_stack(file->tr, tracing_gen_ctx(), STACK_SKIP);
> +	else
>  		trace_dump_stack(STACK_SKIP);
>  }
>  

Sebastian
