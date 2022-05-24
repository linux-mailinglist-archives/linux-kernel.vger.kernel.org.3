Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8F0CB533278
	for <lists+linux-kernel@lfdr.de>; Tue, 24 May 2022 22:29:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240540AbiEXU3U (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 May 2022 16:29:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47286 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234130AbiEXU3S (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 May 2022 16:29:18 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 581F262124
        for <linux-kernel@vger.kernel.org>; Tue, 24 May 2022 13:29:17 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 05E6DB81BB5
        for <linux-kernel@vger.kernel.org>; Tue, 24 May 2022 20:29:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D166EC34100;
        Tue, 24 May 2022 20:29:13 +0000 (UTC)
Date:   Tue, 24 May 2022 16:29:12 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Wonhyuk Yang <vvghjk1234@gmail.com>
Cc:     Ingo Molnar <mingo@redhat.com>, Baik Song An <bsahn@etri.re.kr>,
        Hong Yeon Kim <kimhy@etri.re.kr>,
        Taeung Song <taeung@reallinux.co.kr>, linuxgeek@linuxgeek.io,
        linux-kernel@vger.kernel.org, Tejun Heo <tj@kernel.org>
Subject: Re: [PATCH] workqueue: Fix type of cpu in trace event
Message-ID: <20220524162912.0133006b@gandalf.local.home>
In-Reply-To: <20220504023204.598531-1-vvghjk1234@gmail.com>
References: <20220504023204.598531-1-vvghjk1234@gmail.com>
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

On Wed,  4 May 2022 11:32:03 +0900
Wonhyuk Yang <vvghjk1234@gmail.com> wrote:

> The trace event "workqueue_queue_work" use unsigned int type for
> req_cpu, cpu. This casue confusing cpu number like below log.
> 
> $ cat /sys/kernel/debug/tracing/trace
> cat-317  [001] ...: workqueue_queue_work: ... req_cpu=8192 cpu=4294967295
> 
> So, change unsigned type to signed type in the trace event. After
> applying this patch, cpu number will be printed as -1 instead of
> 4294967295 as folllows.
> 

I was going through my backlog of pending patches and came across this.
Note, that trace events are maintained by the subsystem they belong to.
This change is for workqueues, not tracing (as your subject correctly
states).

I Cc'd Tejun here as he maintains this code.

-- Steve


> $ cat /sys/kernel/debug/tracing/trace
> cat-1338  [002] ...: workqueue_queue_work: ... req_cpu=8192 cpu=-1
> 
> Cc: Baik Song An <bsahn@etri.re.kr>
> Cc: Hong Yeon Kim <kimhy@etri.re.kr>
> Cc: Taeung Song <taeung@reallinux.co.kr>
> Cc: linuxgeek@linuxgeek.io
> Signed-off-by: Wonhyuk Yang <vvghjk1234@gmail.com>
> ---
>  include/trace/events/workqueue.h | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/include/trace/events/workqueue.h b/include/trace/events/workqueue.h
> index 6154a2e72bce..262d52021c23 100644
> --- a/include/trace/events/workqueue.h
> +++ b/include/trace/events/workqueue.h
> @@ -22,7 +22,7 @@ struct pool_workqueue;
>   */
>  TRACE_EVENT(workqueue_queue_work,
>  
> -	TP_PROTO(unsigned int req_cpu, struct pool_workqueue *pwq,
> +	TP_PROTO(int req_cpu, struct pool_workqueue *pwq,
>  		 struct work_struct *work),
>  
>  	TP_ARGS(req_cpu, pwq, work),
> @@ -31,8 +31,8 @@ TRACE_EVENT(workqueue_queue_work,
>  		__field( void *,	work	)
>  		__field( void *,	function)
>  		__string( workqueue,	pwq->wq->name)
> -		__field( unsigned int,	req_cpu	)
> -		__field( unsigned int,	cpu	)
> +		__field( int,	req_cpu	)
> +		__field( int,	cpu	)
>  	),
>  
>  	TP_fast_assign(
> @@ -43,7 +43,7 @@ TRACE_EVENT(workqueue_queue_work,
>  		__entry->cpu		= pwq->pool->cpu;
>  	),
>  
> -	TP_printk("work struct=%p function=%ps workqueue=%s req_cpu=%u cpu=%u",
> +	TP_printk("work struct=%p function=%ps workqueue=%s req_cpu=%d cpu=%d",
>  		  __entry->work, __entry->function, __get_str(workqueue),
>  		  __entry->req_cpu, __entry->cpu)
>  );

