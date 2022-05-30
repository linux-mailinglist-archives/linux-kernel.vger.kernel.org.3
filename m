Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 480B15386D8
	for <lists+linux-kernel@lfdr.de>; Mon, 30 May 2022 19:37:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239720AbiE3Rh2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 May 2022 13:37:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41286 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229790AbiE3RhV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 May 2022 13:37:21 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 944AF50B30
        for <linux-kernel@vger.kernel.org>; Mon, 30 May 2022 10:37:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1653932239;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Ki6v5xLxLFY/6GL0UoRKrfzO5KtuWLGLHBkS7AIWb/o=;
        b=SOkGgUdVvQ4rl/YW3HmvSuinjFKONnibfL/cUvrYcMLgwl/ci/geHgydBDQuXuJxR99dBd
        +NdyybdLmCvcm/aKUqH40ogGMd49BL+DSL82LsWF8SIkKQPGrzxzsj+nrWJso3UBxnlShT
        w7RuBNmgprn4xN8qExTJJnlaKxf8H80=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-412-r8zveUoeMXm2RS3aS3jANA-1; Mon, 30 May 2022 13:37:16 -0400
X-MC-Unique: r8zveUoeMXm2RS3aS3jANA-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.rdu2.redhat.com [10.11.54.7])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 1134D185A794;
        Mon, 30 May 2022 17:37:16 +0000 (UTC)
Received: from fuller.cnet (ovpn-112-3.gru2.redhat.com [10.97.112.3])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id CD72C140EBD5;
        Mon, 30 May 2022 17:37:15 +0000 (UTC)
Received: by fuller.cnet (Postfix, from userid 1000)
        id C3AAE4169537; Mon, 30 May 2022 12:17:49 -0300 (-03)
Date:   Mon, 30 May 2022 12:17:49 -0300
From:   Marcelo Tosatti <mtosatti@redhat.com>
To:     Eiichi Tsukata <eiichi.tsukata@nutanix.com>
Cc:     rafael@kernel.org, daniel.lezcano@linaro.org, rostedt@goodmis.org,
        mingo@redhat.com, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, joao.m.martins@oracle.com
Subject: Re: [PATCH v4] cpuidle: haltpoll: Add trace points for
 guest_halt_poll_ns grow/shrink
Message-ID: <YpTgHeSJA4Ha3Gs4@fuller.cnet>
References: <20220527005345.189906-1-eiichi.tsukata@nutanix.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220527005345.189906-1-eiichi.tsukata@nutanix.com>
X-Scanned-By: MIMEDefang 2.85 on 10.11.54.7
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 27, 2022 at 12:53:45AM +0000, Eiichi Tsukata wrote:
> Add trace points as are implemented in KVM host halt polling.
> This helps tune guest halt polling params.
> 
> Signed-off-by: Eiichi Tsukata <eiichi.tsukata@nutanix.com>
> ---
>  drivers/cpuidle/governors/haltpoll.c |  3 +++
>  include/trace/events/power.h         | 29 ++++++++++++++++++++++++++++
>  2 files changed, 32 insertions(+)
> 
> diff --git a/drivers/cpuidle/governors/haltpoll.c b/drivers/cpuidle/governors/haltpoll.c
> index cb2a96eafc02..1dff3a52917d 100644
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
> @@ -90,6 +91,7 @@ static void adjust_poll_limit(struct cpuidle_device *dev, u64 block_ns)
>  		if (val > guest_halt_poll_ns)
>  			val = guest_halt_poll_ns;
>  
> +		trace_guest_halt_poll_ns_grow(val, dev->poll_limit_ns);
>  		dev->poll_limit_ns = val;
>  	} else if (block_ns > guest_halt_poll_ns &&
>  		   guest_halt_poll_allow_shrink) {
> @@ -100,6 +102,7 @@ static void adjust_poll_limit(struct cpuidle_device *dev, u64 block_ns)
>  			val = 0;
>  		else
>  			val /= shrink;
> +		trace_guest_halt_poll_ns_shrink(val, dev->poll_limit_ns);
>  		dev->poll_limit_ns = val;
>  	}
>  }
> diff --git a/include/trace/events/power.h b/include/trace/events/power.h
> index af5018aa9517..c708521e4ed5 100644
> --- a/include/trace/events/power.h
> +++ b/include/trace/events/power.h
> @@ -500,6 +500,35 @@ DEFINE_EVENT(dev_pm_qos_request, dev_pm_qos_remove_request,
>  
>  	TP_ARGS(name, type, new_value)
>  );
> +
> +TRACE_EVENT(guest_halt_poll_ns,
> +
> +	TP_PROTO(bool grow, unsigned int new, unsigned int old),
> +
> +	TP_ARGS(grow, new, old),
> +
> +	TP_STRUCT__entry(
> +		__field(bool, grow)
> +		__field(unsigned int, new)
> +		__field(unsigned int, old)
> +	),
> +
> +	TP_fast_assign(
> +		__entry->grow   = grow;
> +		__entry->new    = new;
> +		__entry->old    = old;
> +	),
> +
> +	TP_printk("halt_poll_ns %u (%s %u)",
> +		__entry->new,
> +		__entry->grow ? "grow" : "shrink",
> +		__entry->old)
> +);
> +
> +#define trace_guest_halt_poll_ns_grow(new, old) \
> +	trace_guest_halt_poll_ns(true, new, old)
> +#define trace_guest_halt_poll_ns_shrink(new, old) \
> +	trace_guest_halt_poll_ns(false, new, old)
>  #endif /* _TRACE_POWER_H */
>  
>  /* This part must be outside protection */
> -- 
> 2.36.1
> 
> 

Signed-off-by: Marcelo Tosatti <mtosatti@redhat.com>

