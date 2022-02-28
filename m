Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AC2964C70E8
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Feb 2022 16:45:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237636AbiB1PqH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Feb 2022 10:46:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36164 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234135AbiB1PqH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Feb 2022 10:46:07 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E02879C79
        for <linux-kernel@vger.kernel.org>; Mon, 28 Feb 2022 07:45:28 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id E6A1AB811C2
        for <linux-kernel@vger.kernel.org>; Mon, 28 Feb 2022 15:45:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D2A3EC340F0;
        Mon, 28 Feb 2022 15:45:24 +0000 (UTC)
Date:   Mon, 28 Feb 2022 10:45:23 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Nicolas Saenz Julienne <nsaenzju@redhat.com>
Cc:     bristot@kernel.org, paulmck@kernel.org, mingo@redhat.com,
        linux-kernel@vger.kernel.org, mtosatti@redhat.com
Subject: Re: [PATCH] tracing/osnoise: Force quiescent states while tracing
Message-ID: <20220228104523.01eda61a@gandalf.local.home>
In-Reply-To: <20220228141423.259691-1-nsaenzju@redhat.com>
References: <20220228141423.259691-1-nsaenzju@redhat.com>
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

On Mon, 28 Feb 2022 15:14:23 +0100
Nicolas Saenz Julienne <nsaenzju@redhat.com> wrote:

> @@ -1386,6 +1389,22 @@ static int run_osnoise(void)
>  					osnoise_stop_tracing();
>  		}
>  
> +		/*
> +		 * Check if we're the only ones running on this nohz_full CPU
> +		 * and that we're on a PREEMPT_RCU setup. If so, let's fake a
> +		 * QS since there is no way for RCU to know we're not making
> +		 * use of it.
> +		 *
> +		 * Otherwise it'll be done through cond_resched().
> +		 */
> +		if (IS_ENABLED(CONFIG_PREEMPT_RCU) &&
> +		    !housekeeping_cpu(raw_smp_processor_id(), HK_FLAG_MISC) &&
> +		    tick_nohz_tick_stopped()) {
> +			local_irq_save(flags);
> +			rcu_momentary_dyntick_idle();
> +			local_irq_restore(flags);
> +		}
> +

This looks very specific and a corner case. Something that depends on how
RCU works. This really should be in the RCU code such that if something
changes, RCU maintainers are aware of this and can update this too.

I wonder if this is similar to what we have in trace_benchmark(). Would
using: cond_resched_tasks_rcu_qs() work for you?

-- Steve


>  		/*
