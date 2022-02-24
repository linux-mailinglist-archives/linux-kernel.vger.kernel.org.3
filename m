Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 309134C268B
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Feb 2022 09:45:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230340AbiBXIo4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Feb 2022 03:44:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55520 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232073AbiBXIov (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Feb 2022 03:44:51 -0500
Received: from www.kot-begemot.co.uk (ivanoab7.miniserver.com [37.128.132.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6EE4FC4E20
        for <linux-kernel@vger.kernel.org>; Thu, 24 Feb 2022 00:44:19 -0800 (PST)
Received: from [192.168.18.6] (helo=jain.kot-begemot.co.uk)
        by www.kot-begemot.co.uk with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <anton.ivanov@cambridgegreys.com>)
        id 1nN9jO-0000IH-RI; Thu, 24 Feb 2022 08:44:14 +0000
Received: from jain.kot-begemot.co.uk ([192.168.3.3])
        by jain.kot-begemot.co.uk with esmtp (Exim 4.94.2)
        (envelope-from <anton.ivanov@cambridgegreys.com>)
        id 1nN9jK-008vBi-MW; Thu, 24 Feb 2022 08:44:09 +0000
Subject: Re: [PATCH] um: Remove unused timeval_to_ns() function
To:     David Gow <davidgow@google.com>, Jeff Dike <jdike@addtoit.com>,
        Richard Weinberger <richard@nod.at>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Kees Cook <keescook@chromium.org>
Cc:     linux-um@lists.infradead.org, llvm@lists.linux.dev,
        linux-kernel@vger.kernel.org
References: <20220224081233.1765788-1-davidgow@google.com>
From:   Anton Ivanov <anton.ivanov@cambridgegreys.com>
Message-ID: <78d6ac17-9492-7c41-d6dd-4c92dce8ce62@cambridgegreys.com>
Date:   Thu, 24 Feb 2022 08:44:06 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <20220224081233.1765788-1-davidgow@google.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Spam-Score: -2.0
X-Spam-Score: -1.0
X-Clacks-Overhead: GNU Terry Pratchett
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,KHOP_HELO_FCRDNS,
        NICE_REPLY_A,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 24/02/2022 08:12, David Gow wrote:
> The timeval_to_ns() function doesn't appear to be used anywhere, as far
> as I (or git grep) can tell, and clang throws up a warning about it:
> 
> ../arch/um/os-Linux/time.c:21:25: warning: unused function 'timeval_to_ns' [-Wunused-function]
> static inline long long timeval_to_ns(const struct timeval *tv)

Correct. Leftovers from the days when the timers subsystem was based on itimer_*() instead of POSIX timers.

>                          ^
> 1 warning generated.
> 
> Signed-off-by: David Gow <davidgow@google.com>
> ---
> 
> Warning can be reproduced under clang 13.0.1-+rc1 after applying:
> um: Allow builds with Clang -- https://lkml.org/lkml/2022/2/24/40
> 
>   arch/um/os-Linux/time.c | 6 ------
>   1 file changed, 6 deletions(-)
> 
> diff --git a/arch/um/os-Linux/time.c b/arch/um/os-Linux/time.c
> index 6c5041c5560b..4d5591d96d8c 100644
> --- a/arch/um/os-Linux/time.c
> +++ b/arch/um/os-Linux/time.c
> @@ -18,12 +18,6 @@
>   
>   static timer_t event_high_res_timer = 0;
>   
> -static inline long long timeval_to_ns(const struct timeval *tv)
> -{
> -	return ((long long) tv->tv_sec * UM_NSEC_PER_SEC) +
> -		tv->tv_usec * UM_NSEC_PER_USEC;
> -}
> -
>   static inline long long timespec_to_ns(const struct timespec *ts)
>   {
>   	return ((long long) ts->tv_sec * UM_NSEC_PER_SEC) + ts->tv_nsec;
> 

Acked-By: Anton Ivanov <anton.ivanov@cambridgegreys.com>

-- 
Anton R. Ivanov
Cambridgegreys Limited. Registered in England. Company Number 10273661
https://www.cambridgegreys.com/
