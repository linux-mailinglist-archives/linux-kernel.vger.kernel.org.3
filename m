Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 29A2F53540F
	for <lists+linux-kernel@lfdr.de>; Thu, 26 May 2022 21:45:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348805AbiEZTpN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 May 2022 15:45:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50304 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347797AbiEZTpI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 May 2022 15:45:08 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 8BBDE6A063
        for <linux-kernel@vger.kernel.org>; Thu, 26 May 2022 12:45:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1653594303;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=wGw3S4Q9Vcbsrn/loM6Su2TerHvvfSdMEurV8a8JpS4=;
        b=WHCbOQi3YCpmULupJqbys9ph7x6GZgl3hyhkyplzF9CwJlCTeHQX+Ts89YXVtxat5BBPl6
        Dac4deE1S8ym53PstiaXkXltvMnC9x9rTwO4IgkLNpZuQ09wjtqIcH1fs0aF1YYbzgLiha
        F2ZqGXSV1MzFhnvqo7a2wbtw+pTs2T4=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-574-s_2j5mSHMUeeFkrfH07JZQ-1; Thu, 26 May 2022 15:44:59 -0400
X-MC-Unique: s_2j5mSHMUeeFkrfH07JZQ-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com [10.11.54.6])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 57AF280418B;
        Thu, 26 May 2022 19:44:59 +0000 (UTC)
Received: from fuller.cnet (ovpn-112-2.gru2.redhat.com [10.97.112.2])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 2833A2166B26;
        Thu, 26 May 2022 19:44:59 +0000 (UTC)
Received: by fuller.cnet (Postfix, from userid 1000)
        id 5EA67416F574; Wed, 25 May 2022 14:31:29 -0300 (-03)
Date:   Wed, 25 May 2022 14:31:29 -0300
From:   Marcelo Tosatti <mtosatti@redhat.com>
To:     Eiichi Tsukata <eiichi.tsukata@nutanix.com>
Cc:     rafael@kernel.org, daniel.lezcano@linaro.org, rostedt@goodmis.org,
        mingo@redhat.com, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, joao.m.martins@oracle.com
Subject: Re: [PATCH v2] cpuidle: haltpoll: Add trace points for
 guest_halt_poll_ns grow/shrink
Message-ID: <Yo5n8TsSuU9/IxEh@fuller.cnet>
References: <20220523235332.162966-1-eiichi.tsukata@nutanix.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220523235332.162966-1-eiichi.tsukata@nutanix.com>
X-Scanned-By: MIMEDefang 2.78 on 10.11.54.6
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DATE_IN_PAST_24_48,
        DKIMWL_WL_HIGH,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 23, 2022 at 11:53:32PM +0000, Eiichi Tsukata wrote:
> Add trace points as are implemented in KVM host halt polling.
> This helps tune guest halt polling params.
> 
> Signed-off-by: Eiichi Tsukata <eiichi.tsukata@nutanix.com>
> ---
>  drivers/cpuidle/governors/haltpoll.c | 15 ++++++++-----
>  include/trace/events/power.h         | 33 ++++++++++++++++++++++++++++
>  2 files changed, 43 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/cpuidle/governors/haltpoll.c b/drivers/cpuidle/governors/haltpoll.c
> index cb2a96eafc02..a5b6ad32956c 100644
> --- a/drivers/cpuidle/governors/haltpoll.c
> +++ b/drivers/cpuidle/governors/haltpoll.c
> @@ -19,6 +19,7 @@
>  #include <linux/sched.h>
>  #include <linux/module.h>
>  #include <linux/kvm_para.h>
> +#include <trace/events/power.h>
>  
>  static unsigned int guest_halt_poll_ns __read_mostly = 200000;
>  module_param(guest_halt_poll_ns, uint, 0644);
> @@ -77,13 +78,16 @@ static int haltpoll_select(struct cpuidle_driver *drv,
>  
>  static void adjust_poll_limit(struct cpuidle_device *dev, u64 block_ns)
>  {
> -	unsigned int val;
> +	unsigned int val, old;
>  
> -	/* Grow cpu_halt_poll_us if
> -	 * cpu_halt_poll_us < block_ns < guest_halt_poll_us
> +	val = dev->poll_limit_ns;
> +	old = val;
> +
> +	/* Grow poll_limit_ns if
> +	 * poll_limit_ns < block_ns < guest_halt_poll_ns
>  	 */
>  	if (block_ns > dev->poll_limit_ns && block_ns <= guest_halt_poll_ns) {
> -		val = dev->poll_limit_ns * guest_halt_poll_grow;
> +		val *= guest_halt_poll_grow;
>  
>  		if (val < guest_halt_poll_grow_start)
>  			val = guest_halt_poll_grow_start;
> @@ -91,16 +95,17 @@ static void adjust_poll_limit(struct cpuidle_device *dev, u64 block_ns)
>  			val = guest_halt_poll_ns;
>  

Can do it before the assignment:

		trace_guest_halt_poll_ns_grow(val, dev->poll_limit_ns);

>  		dev->poll_limit_ns = val;
> +		trace_guest_halt_poll_ns_grow(smp_processor_id(), val, old);
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
> +#define trace_guest_halt_poll_ns_grow(cpu_id, new, old) \
> +	trace_guest_halt_poll_ns(true, cpu_id, new, old)
> +#define trace_guest_halt_poll_ns_shrink(cpu_id, new, old) \
> +	trace_guest_halt_poll_ns(false, cpu_id, new, old)
>  #endif /* _TRACE_POWER_H */
>  
>  /* This part must be outside protection */
> -- 
> 2.36.1
> 
> 

