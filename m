Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 19ADE50EDEF
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Apr 2022 03:06:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240288AbiDZBJh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Apr 2022 21:09:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50584 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229662AbiDZBJe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Apr 2022 21:09:34 -0400
Received: from smtp-relay-canonical-0.canonical.com (smtp-relay-canonical-0.canonical.com [185.125.188.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 51BFD113C98;
        Mon, 25 Apr 2022 18:06:28 -0700 (PDT)
Received: from [192.168.192.153] (unknown [50.126.114.69])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-canonical-0.canonical.com (Postfix) with ESMTPSA id 92E903F1BD;
        Tue, 26 Apr 2022 01:06:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1650935186;
        bh=6iRMHHd4e+Prm88WJ2yXO8vZmFOYZG76cw/DywYJNpw=;
        h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
         In-Reply-To:Content-Type;
        b=ZfxhHLqrbNH+x3oMxaqjJQNcIOD/YhWvQKFV6Jyk+T74MWF3HTaVnxxFTklJc/W0/
         rEEU727CTEiLty5JiukLLtHLVsIvlJ+ogWIRLQ/1Jv1PfZn1cF+aPSnEHrT07F9A/X
         vDwkbfzW3qVZRV4E7X0ukuYx20Z3qnoInUKJtSajqGoLvtc5bOZ8s4UTZYUTB/vU8y
         Jswp7/TbTOV/Zrf/JR5hjNDXIBOP2CygJC+hGoJjU//EHIlGmlt0wSl224W+vHCWyq
         mOIYvYxBxdatamNVQneoZZdXHpgH625jrI7eNo4tVrZG/Ehc0S5KFgf301F7AMhJ5+
         2df4k8MhOgzAQ==
Message-ID: <81c9f88f-7e8f-0ca6-56b8-049571af6809@canonical.com>
Date:   Mon, 25 Apr 2022 18:06:13 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH v35 25/29] Audit: Allow multiple records in an
 audit_buffer
Content-Language: en-US
To:     Casey Schaufler <casey@schaufler-ca.com>,
        casey.schaufler@intel.com, jmorris@namei.org,
        linux-security-module@vger.kernel.org, selinux@vger.kernel.org
Cc:     linux-audit@redhat.com, keescook@chromium.org,
        penguin-kernel@i-love.sakura.ne.jp, paul@paul-moore.com,
        stephen.smalley.work@gmail.com, linux-kernel@vger.kernel.org
References: <20220418145945.38797-1-casey@schaufler-ca.com>
 <20220418145945.38797-26-casey@schaufler-ca.com>
From:   John Johansen <john.johansen@canonical.com>
Organization: Canonical
In-Reply-To: <20220418145945.38797-26-casey@schaufler-ca.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/18/22 07:59, Casey Schaufler wrote:
> Replace the single skb pointer in an audit_buffer with
> a list of skb pointers. Add the audit_stamp information
> to the audit_buffer as there's no guarantee that there
> will be an audit_context containing the stamp associated
> with the event. At audit_log_end() time create auxiliary
> records (none are currently defined) as have been added
> to the list.
> 
> Suggested-by: Paul Moore <paul@paul-moore.com>
> Signed-off-by: Casey Schaufler <casey@schaufler-ca.com>

I agree with Paul that audit_buffer_aux_new() and
audit_buffer_aux_end() belong in this patch


> ---
>  kernel/audit.c | 62 +++++++++++++++++++++++++++++++-------------------
>  1 file changed, 39 insertions(+), 23 deletions(-)
> 
> diff --git a/kernel/audit.c b/kernel/audit.c
> index 6b6c089512f7..4d44c05053b0 100644
> --- a/kernel/audit.c
> +++ b/kernel/audit.c
> @@ -197,8 +197,10 @@ static struct audit_ctl_mutex {
>   * to place it on a transmit queue.  Multiple audit_buffers can be in
>   * use simultaneously. */
>  struct audit_buffer {
> -	struct sk_buff       *skb;	/* formatted skb ready to send */
> +	struct sk_buff       *skb;	/* the skb for audit_log functions */
> +	struct sk_buff_head  skb_list;	/* formatted skbs, ready to send */
>  	struct audit_context *ctx;	/* NULL or associated context */
> +	struct audit_stamp   stamp;	/* audit stamp for these records */
>  	gfp_t		     gfp_mask;
>  };
>  
> @@ -1765,10 +1767,13 @@ __setup("audit_backlog_limit=", audit_backlog_limit_set);
>  
>  static void audit_buffer_free(struct audit_buffer *ab)
>  {
> +	struct sk_buff *skb;
> +
>  	if (!ab)
>  		return;
>  
> -	kfree_skb(ab->skb);
> +	while((skb = skb_dequeue(&ab->skb_list)))
> +		kfree_skb(skb);

we still have and ab->skb can we have a debug check that its freed by walking the queue?

>  	kmem_cache_free(audit_buffer_cache, ab);
>  }
>  
> @@ -1784,8 +1789,12 @@ static struct audit_buffer *audit_buffer_alloc(struct audit_context *ctx,
>  	ab->skb = nlmsg_new(AUDIT_BUFSIZ, gfp_mask);
>  	if (!ab->skb)
>  		goto err;
> +
> +	skb_queue_head_init(&ab->skb_list);
> +	skb_queue_tail(&ab->skb_list, ab->skb);
> +
>  	if (!nlmsg_put(ab->skb, 0, 0, type, 0, 0))
> -		goto err;
> +		kfree_skb(ab->skb);

why is this no longer an error?

>  
>  	ab->ctx = ctx;
>  	ab->gfp_mask = gfp_mask;
> @@ -1849,7 +1858,6 @@ struct audit_buffer *audit_log_start(struct audit_context *ctx, gfp_t gfp_mask,
>  				     int type)
>  {
>  	struct audit_buffer *ab;
> -	struct audit_stamp stamp;
>  
>  	if (audit_initialized != AUDIT_INITIALIZED)
>  		return NULL;
> @@ -1904,14 +1912,14 @@ struct audit_buffer *audit_log_start(struct audit_context *ctx, gfp_t gfp_mask,
>  		return NULL;
>  	}
>  
> -	audit_get_stamp(ab->ctx, &stamp);
> +	audit_get_stamp(ab->ctx, &ab->stamp);
>  	/* cancel dummy context to enable supporting records */
>  	if (ctx)
>  		ctx->dummy = 0;
>  	audit_log_format(ab, "audit(%llu.%03lu:%u): ",
> -			 (unsigned long long)stamp.ctime.tv_sec,
> -			 stamp.ctime.tv_nsec/1000000,
> -			 stamp.serial);
> +			 (unsigned long long)ab->stamp.ctime.tv_sec,
> +			 ab->stamp.ctime.tv_nsec/1000000,
> +			 ab->stamp.serial);
>  
>  	return ab;
>  }
> @@ -2402,26 +2410,14 @@ int audit_signal_info(int sig, struct task_struct *t)
>  }
>  
>  /**
> - * audit_log_end - end one audit record
> - * @ab: the audit_buffer
> - *
> - * We can not do a netlink send inside an irq context because it blocks (last
> - * arg, flags, is not set to MSG_DONTWAIT), so the audit buffer is placed on a
> - * queue and a kthread is scheduled to remove them from the queue outside the
> - * irq context.  May be called in any context.
> + * __audit_log_end - enqueue one audit record
> + * @skb: the buffer to send
>   */
> -void audit_log_end(struct audit_buffer *ab)
> +static void __audit_log_end(struct sk_buff *skb)
>  {
> -	struct sk_buff *skb;
>  	struct nlmsghdr *nlh;
>  
> -	if (!ab)
> -		return;
> -
>  	if (audit_rate_check()) {
> -		skb = ab->skb;
> -		ab->skb = NULL;
> -
>  		/* setup the netlink header, see the comments in
>  		 * kauditd_send_multicast_skb() for length quirks */
>  		nlh = nlmsg_hdr(skb);
> @@ -2432,6 +2428,26 @@ void audit_log_end(struct audit_buffer *ab)
>  		wake_up_interruptible(&kauditd_wait);
>  	} else
>  		audit_log_lost("rate limit exceeded");
> +}
> +
> +/**
> + * audit_log_end - end one audit record
> + * @ab: the audit_buffer
> + *
> + * We can not do a netlink send inside an irq context because it blocks (last
> + * arg, flags, is not set to MSG_DONTWAIT), so the audit buffer is placed on a
> + * queue and a kthread is scheduled to remove them from the queue outside the
> + * irq context.  May be called in any context.
> + */
> +void audit_log_end(struct audit_buffer *ab)
> +{
> +	struct sk_buff *skb;
> +
> +	if (!ab)
> +		return;
> +
> +	while ((skb = skb_dequeue(&ab->skb_list)))
> +		__audit_log_end(skb);
>  
>  	audit_buffer_free(ab);
>  }

