Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AF5A45340F4
	for <lists+linux-kernel@lfdr.de>; Wed, 25 May 2022 18:03:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245135AbiEYQC4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 May 2022 12:02:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56100 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241633AbiEYQCy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 May 2022 12:02:54 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 502DFB41C0;
        Wed, 25 May 2022 09:02:52 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 898C360FCF;
        Wed, 25 May 2022 16:02:52 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 200D0C385B8;
        Wed, 25 May 2022 16:02:51 +0000 (UTC)
Date:   Wed, 25 May 2022 12:02:48 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Eiichi Tsukata <eiichi.tsukata@nutanix.com>
Cc:     rafael@kernel.org, daniel.lezcano@linaro.org, mingo@redhat.com,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        joao.m.martins@oracle.com, mtosatti@redhat.com
Subject: Re: [PATCH v2] cpuidle: haltpoll: Add trace points for
 guest_halt_poll_ns grow/shrink
Message-ID: <20220525120248.5cb37817@gandalf.local.home>
In-Reply-To: <20220523235332.162966-1-eiichi.tsukata@nutanix.com>
References: <20220523235332.162966-1-eiichi.tsukata@nutanix.com>
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

On Mon, 23 May 2022 23:53:32 +0000
Eiichi Tsukata <eiichi.tsukata@nutanix.com> wrote:

> @@ -91,16 +95,17 @@ static void adjust_poll_limit(struct cpuidle_device *dev, u64 block_ns)
>  			val = guest_halt_poll_ns;
>  
>  		dev->poll_limit_ns = val;
> +		trace_guest_halt_poll_ns_grow(smp_processor_id(), val, old);

Why are you passing in smp_processor_id()?

>  	} else if (block_ns > guest_halt_poll_ns &&
>  		   guest_halt_poll_allow_shrink) {
>  		unsigned int shrink = guest_halt_poll_shrink;
>  
> -		val = dev->poll_limit_ns;
>  		if (shrink == 0)
>  			val = 0;
>  		else
>  			val /= shrink;
>  		dev->poll_limit_ns = val;
> +		trace_guest_halt_poll_ns_shrink(smp_processor_id(), val, old);
>  	}
>  }
>  
> diff --git a/include/trace/events/power.h b/include/trace/events/power.h
> index af5018aa9517..db065af9c3c0 100644
> --- a/include/trace/events/power.h
> +++ b/include/trace/events/power.h
> @@ -500,6 +500,39 @@ DEFINE_EVENT(dev_pm_qos_request, dev_pm_qos_remove_request,
>  
>  	TP_ARGS(name, type, new_value)
>  );
> +
> +TRACE_EVENT(guest_halt_poll_ns,
> +
> +	TP_PROTO(bool grow, unsigned int cpu_id,
> +		 unsigned int new, unsigned int old),
> +
> +	TP_ARGS(grow, cpu_id, new, old),
> +
> +	TP_STRUCT__entry(
> +		__field(bool, grow)
> +		__field(unsigned int, cpu_id)
> +		__field(unsigned int, new)
> +		__field(unsigned int, old)
> +	),
> +
> +	TP_fast_assign(
> +		__entry->grow   = grow;
> +		__entry->cpu_id = cpu_id;

You are wasting space to save the cpu_id, as the trace event already knows
what CPU it occurred on.

 # echo 1 > events/sched/enable
 # cat trace
#           TASK-PID     CPU#  |||||  TIMESTAMP  FUNCTION
#              | |         |   |||||     |         |
         systemd-1       [004] .....    15.872715: ftrace_boot_snapshot: ** Boot snapshot taken **
         systemd-1       [001] .....    22.555418: initcall_start: func=fuse_len_args+0x0/0x30 [fuse]
         systemd-1       [001] .....    22.555425: initcall_finish: func=fuse_len_args+0x0/0x30 [fuse] ret=0
        modprobe-643     [006] .....    26.737355: initcall_start: func=wmidev_evaluate_method+0x46/0x100 [wmi]
        modprobe-643     [006] .....    26.742491: initcall_finish: func=wmidev_evaluate_method+0x46/0x100 [wmi] ret=0

-- Steve



> +		__entry->new    = new;
> +		__entry->old    = old;
> +	),
> +
> +	TP_printk("cpu %u: halt_poll_ns %u (%s %u)",
> +		__entry->cpu_id,
> +		__entry->new,
> +		__entry->grow ? "grow" : "shrink",
> +		__entry->old)
> +);
> +
