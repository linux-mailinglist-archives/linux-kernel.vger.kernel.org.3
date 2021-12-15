Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 88451475CB7
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Dec 2021 17:06:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231574AbhLOQGY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Dec 2021 11:06:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44904 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234342AbhLOQGW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Dec 2021 11:06:22 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 86191C061574;
        Wed, 15 Dec 2021 08:06:22 -0800 (PST)
Date:   Wed, 15 Dec 2021 17:06:19 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1639584381;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=QDSaHB9TQJ2eh9Qx2bgdK5GmheADWSQWVoFj7c7S0O4=;
        b=MGT9UOAzRjjH6PxGLyPMQdHyPZ4d/qRAsIK7VoWYb/9qg8UtkMu497z0GZrMWvQDZTcSED
        3ebAIchxdGVxklvxz51EY0qjn342HSQsU2j69J6QdeUx6/xWt0V7XKAVCrJXvNR84zvQYn
        FP+xbhj+97YpkY8ARleFB3qLTikBHKOY7nNDtAHdDhuOqSn8vRYMoiuVjQ44WguHiQIewq
        HxRz1v/UUs2C+cc/xYg7XAHiL/jxnWp2NomFzY5tj0HY7Rp6hah+I9+TfoS3ZOyLMJzGUa
        dQaZxysnb/Ka/6i5QtI0k3BAuMgQv3TNsMuwjko1KqpdZmbwiVjRc/F+yf7neA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1639584381;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=QDSaHB9TQJ2eh9Qx2bgdK5GmheADWSQWVoFj7c7S0O4=;
        b=2lmjYOXHh9nfnNMFm6NlR1JfTCOxIB4UU8vN+qBLSOlH4JV2c83PWMXX3FC5vcgIPkD+1h
        aYEa6LcQ+zuz+gBA==
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     Mike Galbraith <efault@gmx.de>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        LKML <linux-kernel@vger.kernel.org>,
        RT <linux-rt-users@vger.kernel.org>
Subject: Re: [rcf/patch] netpoll: Make it RT friendly
Message-ID: <YboSe4NfbCeoqF1j@linutronix.de>
References: <20211118163405.adczki7ibk22bw7e@linutronix.de>
 <773fd8246a1ec4ef79142d9e31b8ba4163a0d496.camel@gmx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <773fd8246a1ec4ef79142d9e31b8ba4163a0d496.camel@gmx.de>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2021-11-19 15:41:25 [+0100], Mike Galbraith wrote:
> --- a/net/core/netpoll.c
> +++ b/net/core/netpoll.c
> @@ -252,6 +252,7 @@ static void zap_completion_queue(void)
>  		clist = sd->completion_queue;
>  		sd->completion_queue = NULL;
>  		local_irq_restore(flags);
> +		put_cpu_var(softnet_data);
> 
>  		while (clist != NULL) {
>  			struct sk_buff *skb = clist;
> @@ -263,9 +264,8 @@ static void zap_completion_queue(void)
>  				__kfree_skb(skb);
>  			}
>  		}
> -	}
> -
> -	put_cpu_var(softnet_data);
> +	} else
> +		put_cpu_var(softnet_data);
>  }

Looking at the callers of zap_completion_queue() it seems that
get_cpu_var() could be replaced this_cpu_ptr() since the pointer is
stable at this point.

>  static struct sk_buff *find_skb(struct netpoll *np, int len, int reserve)
> @@ -365,16 +366,22 @@ static netdev_tx_t __netpoll_send_skb(st
> 
>  netdev_tx_t netpoll_send_skb(struct netpoll *np, struct sk_buff *skb)
>  {
> -	unsigned long flags;
> +	unsigned long __maybe_unused flags;
>  	netdev_tx_t ret;
> 
>  	if (unlikely(!np)) {
>  		dev_kfree_skb_irq(skb);
>  		ret = NET_XMIT_DROP;
>  	} else {
> -		local_irq_save(flags);
> +		if (!IS_ENABLED(CONFIG_PREEMPT_RT))
> +			local_irq_save(flags);
> +		else
> +			rcu_read_lock_bh();
>  		ret = __netpoll_send_skb(np, skb);
> -		local_irq_restore(flags);
> +		if (!IS_ENABLED(CONFIG_PREEMPT_RT))
> +			local_irq_restore(flags);
> +		else
> +			rcu_read_unlock_bh();
>  	}
>  	return ret;
>  }

What is the context for netpoll_send_skb()? Why do we need to disable BH
+ RCU on RT?
If interrupts are never disabled, doesn't this break the assumption made
in netpoll_tx_running()?

queue_process() is also busted.

Sebastian
