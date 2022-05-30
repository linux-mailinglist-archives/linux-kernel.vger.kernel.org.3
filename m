Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A04BA537B49
	for <lists+linux-kernel@lfdr.de>; Mon, 30 May 2022 15:22:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236474AbiE3NVz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 May 2022 09:21:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51476 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231299AbiE3NVr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 May 2022 09:21:47 -0400
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com [IPv6:2a00:1450:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9BECC1092
        for <linux-kernel@vger.kernel.org>; Mon, 30 May 2022 06:21:46 -0700 (PDT)
Received: by mail-wm1-x331.google.com with SMTP id d5-20020a05600c34c500b0039776acee62so4464123wmq.1
        for <linux-kernel@vger.kernel.org>; Mon, 30 May 2022 06:21:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=KSDG0U/1IGZ7kluecMX3prlFwmehmdHTdLX0wbLPlIQ=;
        b=CTPzIl/SwkN6uFzKkt0yVkMrGn40XVdsQxpOnk5/4EBhO07WjBX5Am0zFchnMY97a8
         F1JyUP2gfFeNojp2ICfmSK81ILDiZz4IQ68ddZzZ+Mupt54t/un/nYux/P2DLP5c0nYW
         A8o2V0Hv6z5nLySq9C43Y/uJJ8kEGZ9GsgPYEDa8HNfDBHJkUZzu5IMggRW5ljaq8+s6
         9yJbqdPpGvg7PtnxWVsrpjxQMEJwxT1f41KpmR4kMESbpV59oyR1Do5uySOJ1p3BWdC6
         032TOcPWjuN4p/1ZsYgNcuQiLuRNu2bw4vTVO8LNwbj1JdJMH4//FcJnoeYXroimV7fi
         vH3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=KSDG0U/1IGZ7kluecMX3prlFwmehmdHTdLX0wbLPlIQ=;
        b=oT+PW6T2+4dP5zAFtcyHXjTIvlILqyPh8U3Xwvrtvh8enULgZaVrfJWM7AFajgaoOG
         RU+j7WF4VFpO/gdHbQpmYpwpw/6W9psUWaFH2oACgSo0+NV6BF0nXMkYccDMbjKfm1X2
         IPA3Rce9FoY5Tr1QJZTbCx9gmFOpy7SyRVHM1pTkEj8FU+TNbN6sOMeSAW6pWXWKqhQ6
         tBUHaWVHPD4dwvCVZP7MTnViLD6jefcEn6OYmKW1DrFnTJ9kg5RwZkVIR68yLY3QcjaJ
         jDdZi5+j5QxXpy2pBAkQEaYbBAV5lricLyW6xASagKacAymvnsWfBTJ/Z1aU1ovzd1+4
         uuIg==
X-Gm-Message-State: AOAM530gP/ppv2WfjLJZcWzGqbYLE4WCahiNTxYUnD7KA1VuElLXN14u
        YCMiMLJi871JCXMtlIYXnFH1zA==
X-Google-Smtp-Source: ABdhPJzV3KDqUNmfgjA421DMwTXIrMmm8oPMs2OygyRZysZ922uLjHWXV68osV9j7j0U4HYOtUuZ8A==
X-Received: by 2002:a7b:c3c2:0:b0:394:9229:3b40 with SMTP id t2-20020a7bc3c2000000b0039492293b40mr19359442wmj.195.1653916904958;
        Mon, 30 May 2022 06:21:44 -0700 (PDT)
Received: from elver.google.com ([2a00:79e0:9c:201:c918:d0ea:5b07:e1c3])
        by smtp.gmail.com with ESMTPSA id l36-20020a05600c08a400b003942a244f48sm9778734wmp.33.2022.05.30.06.21.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 May 2022 06:21:44 -0700 (PDT)
Date:   Mon, 30 May 2022 15:21:37 +0200
From:   Marco Elver <elver@google.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     x86@kernel.org, jpoimboe@redhat.com, linux-kernel@vger.kernel.org,
        jbaron@akamai.com, rostedt@goodmis.org, ardb@kernel.org,
        mark.rutland@arm.com
Subject: Re: [PATCH 6/7] x86: Always inline on_thread_stack() and
 current_top_of_stack()
Message-ID: <YpTE4YUoTvtGB/6Y@elver.google.com>
References: <20220526105252.440440893@infradead.org>
 <20220526105958.071435483@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220526105958.071435483@infradead.org>
User-Agent: Mutt/2.1.4 (2021-12-11)
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 26, 2022 at 12:52PM +0200, Peter Zijlstra wrote:
> Becaues GCC clearly lost it's marbles again...
> 

This must have been with some of the big sanitizers though, right?

> vmlinux.o: warning: objtool: enter_from_user_mode+0x4e: call to on_thread_stack() leaves .noinstr.text section
> vmlinux.o: warning: objtool: syscall_enter_from_user_mode+0x53: call to on_thread_stack() leaves .noinstr.text section
> vmlinux.o: warning: objtool: syscall_enter_from_user_mode_prepare+0x4e: call to on_thread_stack() leaves .noinstr.text section
> vmlinux.o: warning: objtool: irqentry_enter_from_user_mode+0x4e: call to on_thread_stack() leaves .noinstr.text section
> 
> vmlinux.o: warning: objtool: enter_from_user_mode+0x4e: call to current_top_of_stack() leaves .noinstr.text section
> vmlinux.o: warning: objtool: syscall_enter_from_user_mode+0x53: call to current_top_of_stack() leaves .noinstr.text section
> vmlinux.o: warning: objtool: syscall_enter_from_user_mode_prepare+0x4e: call to current_top_of_stack() leaves .noinstr.text section
> vmlinux.o: warning: objtool: irqentry_enter_from_user_mode+0x4e: call to current_top_of_stack() leaves .noinstr.text section
> 
> Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>

Acked-by: Marco Elver <elver@google.com>

> ---
>  arch/x86/include/asm/processor.h |    4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> --- a/arch/x86/include/asm/processor.h
> +++ b/arch/x86/include/asm/processor.h
> @@ -559,7 +559,7 @@ static __always_inline void native_swapg
>  #endif
>  }
>  
> -static inline unsigned long current_top_of_stack(void)
> +static __always_inline unsigned long current_top_of_stack(void)
>  {
>  	/*
>  	 *  We can't read directly from tss.sp0: sp0 on x86_32 is special in
> @@ -569,7 +569,7 @@ static inline unsigned long current_top_
>  	return this_cpu_read_stable(cpu_current_top_of_stack);
>  }
>  
> -static inline bool on_thread_stack(void)
> +static __always_inline bool on_thread_stack(void)
>  {
>  	return (unsigned long)(current_top_of_stack() -
>  			       current_stack_pointer) < THREAD_SIZE;
> 
> 
