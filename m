Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 73FC3533494
	for <lists+linux-kernel@lfdr.de>; Wed, 25 May 2022 03:07:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242957AbiEYBHU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 May 2022 21:07:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43418 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242741AbiEYBHO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 May 2022 21:07:14 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E159A62BC0
        for <linux-kernel@vger.kernel.org>; Tue, 24 May 2022 18:07:12 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 3E78660B7D
        for <linux-kernel@vger.kernel.org>; Wed, 25 May 2022 01:07:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D6717C34100;
        Wed, 25 May 2022 01:07:10 +0000 (UTC)
Date:   Tue, 24 May 2022 21:07:09 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Junwen Wu <wudaemon@163.com>
Cc:     mingo@redhat.com, tglx@linutronix.de, frederic@kernel.org,
        tannerlove@google.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1] softirq: Add tracepoint for tasklet_entry/exit
Message-ID: <20220524210709.3f0ddc3a@gandalf.local.home>
In-Reply-To: <20220508160624.48643-1-wudaemon@163.com>
References: <20220508160624.48643-1-wudaemon@163.com>
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

On Sun,  8 May 2022 16:06:24 +0000
Junwen Wu <wudaemon@163.com> wrote:

> --- a/include/trace/events/irq.h
> +++ b/include/trace/events/irq.h
> @@ -160,6 +160,38 @@ DEFINE_EVENT(softirq, softirq_raise,
>  	TP_ARGS(vec_nr)
>  );
>  
> +TRACE_EVENT(tasklet_entry,
> +
> +	TP_PROTO(void *func),
> +
> +	TP_ARGS(func),
> +
> +	TP_STRUCT__entry(
> +		__field(        void *,    func          )
> +	),
> +
> +	TP_fast_assign(
> +	__entry->func = func;
> +	),
> +
> +	TP_printk("function=%ps", __entry->func)
> +);
> +TRACE_EVENT(tasklet_exit,
> +
> +	TP_PROTO(void *func),
> +
> +	TP_ARGS(func),
> +
> +	TP_STRUCT__entry(
> +		__field(        void *,    func          )
> +	),
> +
> +	TP_fast_assign(
> +		__entry->func = func;
> +	),
> +
> +	TP_printk("function=%ps", __entry->func)

This needs an acked-by from Thomas, but regardless, the above two trace
events are identical. You need to have a DECLARE_EVENT_CLASS() followed by
two DEFINE_EVENT()s, otherwise you are wasting memory.

-- Steve


> +);
>  #endif /*  _TRACE_IRQ_H */
>  
>  /* This part must be outside protection */
> diff --git a/kernel/softirq.c b/kernel/softirq.c
> index 41f470929e99..b3bce2b3b655 100644
> --- a/kernel/softirq.c
> +++ b/kernel/softirq.c
> @@ -780,10 +780,14 @@ static void tasklet_action_common(struct softirq_action *a,
>  		if (tasklet_trylock(t)) {
>  			if (!atomic_read(&t->count)) {
>  				if (tasklet_clear_sched(t)) {
> +					trace_tasklet_entry(t->use_callback ? (void *)t->callback 
> +							: (void *)t->func);
>  					if (t->use_callback)
>  						t->callback(t);
>  					else
>  						t->func(t->data);
> +					trace_tasklet_exit(t->use_callback ? (void *)t->callback
> +							: (void *)t->func);
>  				}
>  				tasklet_unlock(t);
>  				continue;

