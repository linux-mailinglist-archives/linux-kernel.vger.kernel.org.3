Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A64BF5814CA
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Jul 2022 16:08:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238860AbiGZOIW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Jul 2022 10:08:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48296 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230430AbiGZOIU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Jul 2022 10:08:20 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD20025C4D;
        Tue, 26 Jul 2022 07:08:19 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 71BBA615E6;
        Tue, 26 Jul 2022 14:08:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EB1C8C433C1;
        Tue, 26 Jul 2022 14:08:17 +0000 (UTC)
Date:   Tue, 26 Jul 2022 10:08:16 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Kajetan Puchalski <kajetan.puchalski@arm.com>
Cc:     linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Ingo Molnar <mingo@redhat.com>, lukasz.luba@arm.com,
        Dietmar.Eggemann@arm.com
Subject: Re: [PATCH] cpuidle: Add cpu_idle_miss trace event
Message-ID: <20220726100816.3e37ed97@gandalf.local.home>
In-Reply-To: <Yt/AxPFi88neW7W5@e126311.manchester.arm.com>
References: <Yt/AxPFi88neW7W5@e126311.manchester.arm.com>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 26 Jul 2022 11:24:04 +0100
Kajetan Puchalski <kajetan.puchalski@arm.com> wrote:

> --- a/include/trace/events/power.h
> +++ b/include/trace/events/power.h
> @@ -40,6 +40,28 @@ DEFINE_EVENT(cpu, cpu_idle,
>  	TP_ARGS(state, cpu_id)
>  );
>  
> +TRACE_EVENT(cpu_idle_miss,
> +
> +	TP_PROTO(unsigned int cpu_id, unsigned int state, bool below),
> +
> +	TP_ARGS(cpu_id, state, below),
> +
> +	TP_STRUCT__entry(
> +		__field(u32,		cpu_id)
> +		__field(u32,		state)
> +		__field(bool,		below)
> +	),
> +
> +	TP_fast_assign(
> +		__entry->cpu_id = cpu_id;
> +		__entry->state = state;
> +		__entry->below = below;
> +	),
> +
> +	TP_printk("cpu_id=%lu state=%lu type=%s", (unsigned long)__entry->cpu_id,
> +		(unsigned long)__entry->state, (__entry->below)?"below":"above")
> +);
> +
>  TRACE_EVENT(powernv_throttle,
>  
>   	TP_PROTO(int chip_id, const char *reason, int pmax),

For the tracing POV,

Reviewed-by: Steven Rostedt (Google) <rostedt@goodmis.org>

-- Steve
