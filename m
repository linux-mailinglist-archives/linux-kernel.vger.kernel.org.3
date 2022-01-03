Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 33235482F78
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Jan 2022 10:31:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231249AbiACJbG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Jan 2022 04:31:06 -0500
Received: from gateway24.websitewelcome.com ([192.185.51.162]:30745 "EHLO
        gateway24.websitewelcome.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229516AbiACJbE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Jan 2022 04:31:04 -0500
X-Greylist: delayed 1449 seconds by postgrey-1.27 at vger.kernel.org; Mon, 03 Jan 2022 04:31:04 EST
Received: from cm10.websitewelcome.com (cm10.websitewelcome.com [100.42.49.4])
        by gateway24.websitewelcome.com (Postfix) with ESMTP id B68D5364A3
        for <linux-kernel@vger.kernel.org>; Mon,  3 Jan 2022 03:06:54 -0600 (CST)
Received: from gator4132.hostgator.com ([192.185.4.144])
        by cmsmtp with SMTP
        id 4JIsnhXv9Rnrr4JIsnB4a2; Mon, 03 Jan 2022 03:06:54 -0600
X-Authority-Reason: nr=8
Received: from host-79-52-207-139.retail.telecomitalia.it ([79.52.207.139]:57842 helo=[10.0.0.65])
        by gator4132.hostgator.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
        (Exim 4.94.2)
        (envelope-from <bristot@kernel.org>)
        id 1n4JIs-003Y07-39; Mon, 03 Jan 2022 03:06:54 -0600
Message-ID: <cf4347ed-45f5-5910-a19b-3b8a339bb7a3@kernel.org>
Date:   Mon, 3 Jan 2022 10:06:50 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.0
Subject: Re: [PATCH] trace/osnoise: fix event unhooking
Content-Language: en-US
To:     Nikita Yushchenko <nikita.yushchenko@virtuozzo.com>
Cc:     linux-kernel@vger.kernel.org, kernel@openvz.org,
        Steven Rostedt <rostedt@goodmis.org>,
        Ingo Molnar <mingo@redhat.com>
References: <20211228140727.2467771-1-nikita.yushchenko@virtuozzo.com>
From:   Daniel Bristot de Oliveira <bristot@kernel.org>
In-Reply-To: <20211228140727.2467771-1-nikita.yushchenko@virtuozzo.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - gator4132.hostgator.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - kernel.org
X-BWhitelist: no
X-Source-IP: 79.52.207.139
X-Source-L: No
X-Exim-ID: 1n4JIs-003Y07-39
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: host-79-52-207-139.retail.telecomitalia.it ([10.0.0.65]) [79.52.207.139]:57842
X-Source-Auth: kernel@bristot.me
X-Email-Count: 4
X-Source-Cap: YnJpc3RvdG1lO2JyaXN0b3RtZTtnYXRvcjQxMzIuaG9zdGdhdG9yLmNvbQ==
X-Local-Domain: no
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Nikita

On 12/28/21 15:07, Nikita Yushchenko wrote:
> If start_per_cpu_kthreads() called from osnoise_workload_start() returns
> error, event hooks are left in broken state: unhook_irq_events() called
> but unhook_thread_events() and unhook_softirq_events() not called, and
> trace_osnoise_callback_enabled flag not cleared.
> 
> On the next tracer enable, hooks get not installed due to
> trace_osnoise_callback_enabled flag.
> 
> And on the further tracer disable an attempt to remove non-installed
> hooks happened, hitting a WARN_ON_ONCE() in tracepoint_remove_func().
> 
> Fix the error path by adding the missing part of cleanup.

Regarding the subject:

 - use tracing/ as subsystem (yeah, I also made this mistake in the original
   osnoise series).
 - use a capital after the "tracing/osnoise:"

Using your subject as example, it should be:
    tracing/osnoise: Fix event unhooking

Anyway, I suggest using something more precise, like:

  tracing/osnoise: Properly unhook events if start_per_cpu_kthreads() fails

or something like that.

> While at this, introduce osnoise_unhook_events() to avoid code
> duplication between this error path and notmal tracer disable.

s/notmal/normal/

> 
> Fixes: bce29ac9ce0b ("trace: Add osnoise tracer")
> Signed-off-by: Nikita Yushchenko <nikita.yushchenko@virtuozzo.com>
> ---
>  kernel/trace/trace_osnoise.c | 14 ++++++++++----
>  1 file changed, 10 insertions(+), 4 deletions(-)
> 
> diff --git a/kernel/trace/trace_osnoise.c b/kernel/trace/trace_osnoise.c
> index 7520d43aed55..aa6f26612ccc 100644
> --- a/kernel/trace/trace_osnoise.c
> +++ b/kernel/trace/trace_osnoise.c
> @@ -2123,6 +2123,13 @@ static int osnoise_hook_events(void)
>  	return -EINVAL;
>  }
>  
> +static void osnoise_unhook_events(void)
> +{
> +	unhook_thread_events();
> +	unhook_softirq_events();
> +	unhook_irq_events();
> +}
> +
>  /*
>   * osnoise_workload_start - start the workload and hook to events
>   */
> @@ -2155,7 +2162,8 @@ static int osnoise_workload_start(void)
>  
>  	retval = start_per_cpu_kthreads();
>  	if (retval) {
> -		unhook_irq_events();
> +		trace_osnoise_callback_enabled = false;

we need a barrier here, like:

		/*
		 * Make sure that ftrace_nmi_enter/exit() see
		 * trace_osnoise_callback_enabled as false before continuing.
		 */
		barrier();

> +		osnoise_unhook_events();
>  		return retval;
>  	}
>  

Thanks!

-- Daniel
