Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 612DA49C3F7
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jan 2022 08:01:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237538AbiAZHBf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Jan 2022 02:01:35 -0500
Received: from ams.source.kernel.org ([145.40.68.75]:60578 "EHLO
        ams.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229979AbiAZHBe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jan 2022 02:01:34 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 4A5BAB81C0C;
        Wed, 26 Jan 2022 07:01:32 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9DB70C340E3;
        Wed, 26 Jan 2022 07:01:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1643180491;
        bh=DnMOT2vlu2opZbnfCdapvRfBKqFGLQL1Y5Zbwh5314g=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=SE8ra/wvzUJDhk8ChNZk2kYH5wi9CXIf7KYV1Uw7XnNNJEqrL5Oetr1kfhbYIvxvw
         3AFkP2fG6WYk8p52Kuq6z3cfAzvUaP4GXrkTcR4FR8iFnJttDl/B63UnLdex/TR+9B
         HwpU+D5MjDB9Jw3ijrM2E+SyCyOMnngJuio3fdS3hB54xtXltggj67kAaNM7wj7+S+
         qALdsuInsQAV3jRiqjS4tQV8bO54rfZPuuFqENyysCizjCFFD0JLJeAqSEJ9iFeRJ8
         Tz0RnBtRM7+WdNrvAEEeJHegTUcFyfoIumaZ5pPWO7cVaWpz2nMNPZUqvDyCu/cVlD
         jRWY/DGC5WlSw==
Date:   Wed, 26 Jan 2022 16:01:27 +0900
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     Kees Cook <keescook@chromium.org>
Cc:     Steven Rostedt <rostedt@goodmis.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        linux-next@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-hardening@vger.kernel.org
Subject: Re: [PATCH] perf: Avoid -Warray-bounds warning for __rel_loc macro
Message-Id: <20220126160127.f3deb7f73e87066e94218a48@kernel.org>
In-Reply-To: <20220125220037.2738923-1-keescook@chromium.org>
References: <20220125220037.2738923-1-keescook@chromium.org>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 25 Jan 2022 14:00:37 -0800
Kees Cook <keescook@chromium.org> wrote:

> As done for trace_events.h, also fix the __rel_loc macro in perf.h,
> which silences the -Warray-bounds warning:
> 
> In file included from ./include/linux/string.h:253,
>                  from ./include/linux/bitmap.h:11,
>                  from ./include/linux/cpumask.h:12,
>                  from ./include/linux/mm_types_task.h:14,
>                  from ./include/linux/mm_types.h:5,
>                  from ./include/linux/buildid.h:5,
>                  from ./include/linux/module.h:14,
>                  from samples/trace_events/trace-events-sample.c:2:
> In function '__fortify_strcpy',
>     inlined from 'perf_trace_foo_rel_loc' at samples/trace_events/./trace-events-sample.h:519:1:
> ./include/linux/fortify-string.h:47:33: warning: '__builtin_strcpy' offset 12 is out of the bounds [
> 0, 4] [-Warray-bounds]
>    47 | #define __underlying_strcpy     __builtin_strcpy
>       |                                 ^
> ./include/linux/fortify-string.h:445:24: note: in expansion of macro '__underlying_strcpy'
>   445 |                 return __underlying_strcpy(p, q);
>       |                        ^~~~~~~~~~~~~~~~~~~
> 
> Also make __data struct member a proper flexible array to avoid future
> problems.
> 

This looks good to me.

Reviewed-by: Masami Hiramatsu <mhiramat@kernel.org>

BTW, same macro is in the include/trace/bpf_probe.h.
I'm not sure bpf using this macro, should we update it for
consistency?

> Cc: Steven Rostedt <rostedt@goodmis.org>
> Cc: Masami Hiramatsu <mhiramat@kernel.org>
> Reported-by: Stephen Rothwell <sfr@canb.auug.org.au>
> Signed-off-by: Kees Cook <keescook@chromium.org>
> ---
>  include/trace/perf.h         | 5 +++--
>  include/trace/trace_events.h | 2 +-
>  2 files changed, 4 insertions(+), 3 deletions(-)
> 
> diff --git a/include/trace/perf.h b/include/trace/perf.h
> index b77d09c70a93..5800d13146c3 100644
> --- a/include/trace/perf.h
> +++ b/include/trace/perf.h
> @@ -26,8 +26,9 @@
>  
>  #undef __get_rel_dynamic_array
>  #define __get_rel_dynamic_array(field)	\
> -		((void *)(&__entry->__rel_loc_##field) +	\
> -		 sizeof(__entry->__rel_loc_##field) +		\
> +		((void *)__entry +					\
> +		 offsetof(typeof(*__entry), __rel_loc_##field) +	\
> +		 sizeof(__entry->__rel_loc_##field) +			\
>  		 (__entry->__rel_loc_##field & 0xffff))
>  
>  #undef __get_rel_dynamic_array_len
> diff --git a/include/trace/trace_events.h b/include/trace/trace_events.h
> index cefefed18e85..7c86cc541c7a 100644
> --- a/include/trace/trace_events.h
> +++ b/include/trace/trace_events.h
> @@ -134,7 +134,7 @@ TRACE_MAKE_SYSTEM_STR();
>  	struct trace_event_raw_##name {					\
>  		struct trace_entry	ent;				\
>  		tstruct							\
> -		char			__data[0];			\
> +		char			__data[];			\
>  	};								\
>  									\
>  	static struct trace_event_class event_class_##name;
> -- 
> 2.30.2
> 


-- 
Masami Hiramatsu <mhiramat@kernel.org>
