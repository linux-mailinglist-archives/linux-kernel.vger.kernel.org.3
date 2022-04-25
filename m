Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DC0C050EC99
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Apr 2022 01:32:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238091AbiDYXfJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Apr 2022 19:35:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41318 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237992AbiDYXfE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Apr 2022 19:35:04 -0400
Received: from smtp-relay-canonical-0.canonical.com (smtp-relay-canonical-0.canonical.com [185.125.188.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B44836B09D;
        Mon, 25 Apr 2022 16:31:58 -0700 (PDT)
Received: from [192.168.192.153] (unknown [50.126.114.69])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-canonical-0.canonical.com (Postfix) with ESMTPSA id EEEA43F62C;
        Mon, 25 Apr 2022 23:31:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1650929516;
        bh=vZU9o7P+73HXfEhvvq52ZBBcLXvcmL+Dku5ZH6YO5v4=;
        h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
         In-Reply-To:Content-Type;
        b=Bb0Eu9bHYUOxTsOAi++SC3zSpmtRONaYTljhwonzE4z4H+k7RcJMkJUo071KC2tio
         uk1YG7Ode6JilYWL19phnH2xEuni1spfSqpGXifuzSNl7MO9hTlkTTcqtifpUIrKYg
         iVzLa91TH4tc2W3p/pV1WMg36jcWxKJA19hi1hWBKGFPnW0kpASvnoHkV+riKK0lpv
         0twngsOVqLTaESp5KmbjfTZouvr5ZAj8m924UOyIOpEigZ0IeGLxEZmEOoAB5sq32e
         /rE21Mkb5aj2MceGKoyWCdjz+DL3jJzKYFJqdw0pQZlS2/qBd2a0Jo5rGj4D/9FMPc
         vh6a657qgYuPw==
Message-ID: <a1702622-5980-1eb4-1cf8-b6fc6cd98b25@canonical.com>
Date:   Mon, 25 Apr 2022 16:31:44 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH v35 23/29] Audit: Create audit_stamp structure
Content-Language: en-US
To:     Casey Schaufler <casey@schaufler-ca.com>,
        casey.schaufler@intel.com, jmorris@namei.org,
        linux-security-module@vger.kernel.org, selinux@vger.kernel.org
Cc:     linux-audit@redhat.com, keescook@chromium.org,
        penguin-kernel@i-love.sakura.ne.jp, paul@paul-moore.com,
        stephen.smalley.work@gmail.com, linux-kernel@vger.kernel.org
References: <20220418145945.38797-1-casey@schaufler-ca.com>
 <20220418145945.38797-24-casey@schaufler-ca.com>
From:   John Johansen <john.johansen@canonical.com>
Organization: Canonical
In-Reply-To: <20220418145945.38797-24-casey@schaufler-ca.com>
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
> Replace the timestamp and serial number pair used in audit records
> with a structure containing the two elements.
> 
> Signed-off-by: Casey Schaufler <casey@schaufler-ca.com>
> Acked-by: Paul Moore <paul@paul-moore.com>
> ---
>  kernel/audit.c   | 17 +++++++++--------
>  kernel/audit.h   | 12 +++++++++---
>  kernel/auditsc.c | 22 +++++++++-------------
>  3 files changed, 27 insertions(+), 24 deletions(-)
> 
> diff --git a/kernel/audit.c b/kernel/audit.c
> index 28ff7a5f90bd..6b6c089512f7 100644
> --- a/kernel/audit.c
> +++ b/kernel/audit.c
> @@ -1822,11 +1822,11 @@ unsigned int audit_serial(void)
>  }
>  
>  static inline void audit_get_stamp(struct audit_context *ctx,
> -				   struct timespec64 *t, unsigned int *serial)
> +				   struct audit_stamp *stamp)
>  {
> -	if (!ctx || !auditsc_get_stamp(ctx, t, serial)) {
> -		ktime_get_coarse_real_ts64(t);
> -		*serial = audit_serial();
> +	if (!ctx || !auditsc_get_stamp(ctx, stamp)) {
> +		ktime_get_coarse_real_ts64(&stamp->ctime);
> +		stamp->serial = audit_serial();
>  	}
>  }
>  
> @@ -1849,8 +1849,7 @@ struct audit_buffer *audit_log_start(struct audit_context *ctx, gfp_t gfp_mask,
>  				     int type)
>  {
>  	struct audit_buffer *ab;
> -	struct timespec64 t;
> -	unsigned int serial;
> +	struct audit_stamp stamp;
>  
>  	if (audit_initialized != AUDIT_INITIALIZED)
>  		return NULL;
> @@ -1905,12 +1904,14 @@ struct audit_buffer *audit_log_start(struct audit_context *ctx, gfp_t gfp_mask,
>  		return NULL;
>  	}
>  
> -	audit_get_stamp(ab->ctx, &t, &serial);
> +	audit_get_stamp(ab->ctx, &stamp);
>  	/* cancel dummy context to enable supporting records */
>  	if (ctx)
>  		ctx->dummy = 0;
>  	audit_log_format(ab, "audit(%llu.%03lu:%u): ",
> -			 (unsigned long long)t.tv_sec, t.tv_nsec/1000000, serial);
> +			 (unsigned long long)stamp.ctime.tv_sec,
> +			 stamp.ctime.tv_nsec/1000000,
> +			 stamp.serial);
>  
>  	return ab;
>  }
> diff --git a/kernel/audit.h b/kernel/audit.h
> index 4af63e7dde17..260dab6e0e15 100644
> --- a/kernel/audit.h
> +++ b/kernel/audit.h
> @@ -99,6 +99,12 @@ struct audit_proctitle {
>  	char	*value;	/* the cmdline field */
>  };
>  
> +/* A timestamp/serial pair to identify an event */
> +struct audit_stamp {
> +	struct timespec64	ctime;	/* time of syscall entry */
> +	unsigned int		serial;	/* serial number for record */
> +};
> +
>  /* The per-task audit context. */
>  struct audit_context {
>  	int		    dummy;	/* must be the first element */
> @@ -108,10 +114,10 @@ struct audit_context {
>  		AUDIT_CTX_URING,	/* in use by io_uring */
>  	} context;
>  	enum audit_state    state, current_state;
> +	struct audit_stamp  stamp;	/* event identifier */
>  	unsigned int	    serial;     /* serial number for record */

shouldn't we be dropping serial from the audit_context, since we have
moved it into the audit_stamp?

>  	int		    major;      /* syscall number */
>  	int		    uring_op;   /* uring operation */
> -	struct timespec64   ctime;      /* time of syscall entry */
>  	unsigned long	    argv[4];    /* syscall arguments */
>  	long		    return_code;/* syscall return code */
>  	u64		    prio;
> @@ -265,7 +271,7 @@ extern void audit_put_tty(struct tty_struct *tty);
>  #ifdef CONFIG_AUDITSYSCALL
>  extern unsigned int audit_serial(void);
>  extern int auditsc_get_stamp(struct audit_context *ctx,
> -			      struct timespec64 *t, unsigned int *serial);
> +			     struct audit_stamp *stamp);
>  
>  extern void audit_put_watch(struct audit_watch *watch);
>  extern void audit_get_watch(struct audit_watch *watch);
> @@ -306,7 +312,7 @@ extern void audit_filter_inodes(struct task_struct *tsk,
>  				struct audit_context *ctx);
>  extern struct list_head *audit_killed_trees(void);
>  #else /* CONFIG_AUDITSYSCALL */
> -#define auditsc_get_stamp(c, t, s) 0
> +#define auditsc_get_stamp(c, s) 0
>  #define audit_put_watch(w) do { } while (0)
>  #define audit_get_watch(w) do { } while (0)
>  #define audit_to_watch(k, p, l, o) (-EINVAL)
> diff --git a/kernel/auditsc.c b/kernel/auditsc.c
> index 6fe9f2525fc1..557713954a69 100644
> --- a/kernel/auditsc.c
> +++ b/kernel/auditsc.c
> @@ -992,10 +992,10 @@ static void audit_reset_context(struct audit_context *ctx)
>  	 */
>  
>  	ctx->current_state = ctx->state;
> -	ctx->serial = 0;
> +	ctx->stamp.serial = 0;
>  	ctx->major = 0;
>  	ctx->uring_op = 0;
> -	ctx->ctime = (struct timespec64){ .tv_sec = 0, .tv_nsec = 0 };
> +	ctx->stamp.ctime = (struct timespec64){ .tv_sec = 0, .tv_nsec = 0 };
>  	memset(ctx->argv, 0, sizeof(ctx->argv));
>  	ctx->return_code = 0;
>  	ctx->prio = (ctx->state == AUDIT_STATE_RECORD ? ~0ULL : 0);
> @@ -1950,7 +1950,7 @@ void __audit_uring_entry(u8 op)
>  
>  	ctx->context = AUDIT_CTX_URING;
>  	ctx->current_state = ctx->state;
> -	ktime_get_coarse_real_ts64(&ctx->ctime);
> +	ktime_get_coarse_real_ts64(&ctx->stamp.ctime);
>  }
>  
>  /**
> @@ -2066,7 +2066,7 @@ void __audit_syscall_entry(int major, unsigned long a1, unsigned long a2,
>  	context->argv[3]    = a4;
>  	context->context = AUDIT_CTX_SYSCALL;
>  	context->current_state  = state;
> -	ktime_get_coarse_real_ts64(&context->ctime);
> +	ktime_get_coarse_real_ts64(&context->stamp.ctime);
>  }
>  
>  /**
> @@ -2535,21 +2535,17 @@ EXPORT_SYMBOL_GPL(__audit_inode_child);
>  /**
>   * auditsc_get_stamp - get local copies of audit_context values
>   * @ctx: audit_context for the task
> - * @t: timespec64 to store time recorded in the audit_context
> - * @serial: serial value that is recorded in the audit_context
> + * @stamp: timestamp to record
>   *
>   * Also sets the context as auditable.
>   */
> -int auditsc_get_stamp(struct audit_context *ctx,
> -		       struct timespec64 *t, unsigned int *serial)
> +int auditsc_get_stamp(struct audit_context *ctx, struct audit_stamp *stamp)
>  {
>  	if (ctx->context == AUDIT_CTX_UNUSED)
>  		return 0;
> -	if (!ctx->serial)
> -		ctx->serial = audit_serial();
> -	t->tv_sec  = ctx->ctime.tv_sec;
> -	t->tv_nsec = ctx->ctime.tv_nsec;
> -	*serial    = ctx->serial;
> +	if (!ctx->stamp.serial)
> +		ctx->stamp.serial = audit_serial();
> +	*stamp = ctx->stamp;
>  	if (!ctx->prio) {
>  		ctx->prio = 1;
>  		ctx->current_state = AUDIT_STATE_RECORD;

