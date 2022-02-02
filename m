Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D82674A7BA4
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Feb 2022 00:21:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244957AbiBBXVv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Feb 2022 18:21:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51626 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229764AbiBBXVu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Feb 2022 18:21:50 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C209CC061714
        for <linux-kernel@vger.kernel.org>; Wed,  2 Feb 2022 15:21:50 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 7907AB82E48
        for <linux-kernel@vger.kernel.org>; Wed,  2 Feb 2022 23:21:49 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 902E1C004E1;
        Wed,  2 Feb 2022 23:21:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1643844108;
        bh=D+NrSNJGEcrj8++Y6EQPnZIWyTEi499j/U19xCKvlCI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=vLlnUtY0c6YjdaUBGbmpDEBFB7VLcnB+9wwflR9IfNN7mVXnyijAYcyXLU1fgyq2A
         WJ4dLtVf7Eq/rlL1p1Ic5k0K3qR2VbUm8VHpFhCrGu+BFvsH0Tt+5T6YJ57280neF8
         ZQyMdeIVOqy82yA7si8017Hcv7xitiXxXjZZcxHLAQDEj2eLkNT2TZYbpLM9CWBxDl
         bwWRmdKjBmDZi1DzpUrVqJZvw33P7jOvd4QktPM3yQYrCVk8coteg6mZ7iVfl9KpcQ
         FPxEF8yXOfp63xWhMOpuCW1da4+Q2hD4alXSpaRtHqj5mYfSQKQo6lQMgJHxpUDnxX
         wQh6ZSHQ31a4A==
Date:   Thu, 3 Feb 2022 00:21:45 +0100
From:   Frederic Weisbecker <frederic@kernel.org>
To:     Mark Rutland <mark.rutland@arm.com>
Cc:     linux-arm-kernel@lists.infradead.org, ardb@kernel.org,
        catalin.marinas@arm.com, juri.lelli@redhat.com,
        linux-kernel@vger.kernel.org, mingo@redhat.com,
        peterz@infradead.org, will@kernel.org
Subject: Re: [PATCH 5/6] sched/preempt: add PREEMPT_DYNAMIC using static keys
Message-ID: <20220202232145.GA461279@lothringen>
References: <20211109172408.49641-1-mark.rutland@arm.com>
 <20211109172408.49641-6-mark.rutland@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211109172408.49641-6-mark.rutland@arm.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 09, 2021 at 05:24:07PM +0000, Mark Rutland wrote:
> diff --git a/include/linux/kernel.h b/include/linux/kernel.h
> index e5359b09de1d..8a94ccfc7dc8 100644
> --- a/include/linux/kernel.h
> +++ b/include/linux/kernel.h
> @@ -93,7 +93,7 @@ struct user;
>  extern int __cond_resched(void);
>  # define might_resched() __cond_resched()
>  
> -#elif defined(CONFIG_PREEMPT_DYNAMIC)
> +#elif defined(CONFIG_PREEMPT_DYNAMIC) && defined(CONFIG_HAVE_PREEMPT_DYNAMIC_CALL)
>  
>  extern int __cond_resched(void);
>  
> @@ -104,6 +104,11 @@ static __always_inline void might_resched(void)
>  	static_call_mod(might_resched)();
>  }
>  
> +#elif defined(CONFIG_PREEMPT_DYNAMIC) && defined(CONFIG_HAVE_PREEMPT_DYNAMIC_KEY)
> +
> +extern int dynamic_might_resched(void);
> +# define might_resched() dynamic_might_resched()
> +
>  #else
>  
>  # define might_resched() do { } while (0)
> diff --git a/include/linux/sched.h b/include/linux/sched.h
> index 78c351e35fec..7710b6593c72 100644
> --- a/include/linux/sched.h
> +++ b/include/linux/sched.h
> @@ -2008,7 +2008,7 @@ static inline int test_tsk_need_resched(struct task_struct *tsk)
>  #if !defined(CONFIG_PREEMPTION) || defined(CONFIG_PREEMPT_DYNAMIC)
>  extern int __cond_resched(void);
>  
> -#ifdef CONFIG_PREEMPT_DYNAMIC
> +#if defined(CONFIG_PREEMPT_DYNAMIC) && defined(CONFIG_HAVE_PREEMPT_DYNAMIC_CALL)
>  
>  DECLARE_STATIC_CALL(cond_resched, __cond_resched);
>  
> @@ -2017,6 +2017,14 @@ static __always_inline int _cond_resched(void)
>  	return static_call_mod(cond_resched)();
>  }
>  
> +#elif defined(CONFIG_PREEMPT_DYNAMIC) && defined(CONFIG_HAVE_PREEMPT_DYNAMIC_KEY)
> +extern int dynamic_cond_resched(void);
> +
> +static __always_inline int _cond_resched(void)
> +{
> +	return dynamic_cond_resched();

So in the end this is creating an indirect call for every preemption entrypoint.
It seems to me that this loses the whole point of using static keys.

Is there something that prevents from using inlines or macros?

Thanks.
