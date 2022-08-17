Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F07EF597192
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Aug 2022 16:45:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236886AbiHQOli (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 Aug 2022 10:41:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51616 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240343AbiHQOlM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Aug 2022 10:41:12 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 564DD9AFB3
        for <linux-kernel@vger.kernel.org>; Wed, 17 Aug 2022 07:41:08 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 44AF7614E9
        for <linux-kernel@vger.kernel.org>; Wed, 17 Aug 2022 14:41:07 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3F38DC433D6;
        Wed, 17 Aug 2022 14:41:06 +0000 (UTC)
Date:   Wed, 17 Aug 2022 10:41:15 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Yang Jihong <yangjihong1@huawei.com>
Cc:     <mingo@redhat.com>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] ftrace: Fix NULL pointer dereference in
 is_ftrace_trampoline when ftrace is dead
Message-ID: <20220817104115.0ec6b90b@gandalf.local.home>
In-Reply-To: <20220804021610.209791-1-yangjihong1@huawei.com>
References: <20220804021610.209791-1-yangjihong1@huawei.com>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 4 Aug 2022 10:16:10 +0800
Yang Jihong <yangjihong1@huawei.com> wrote:

> @@ -2922,24 +2922,36 @@ int ftrace_startup(struct ftrace_ops *ops, int command)
>  	ops->flags |= FTRACE_OPS_FL_ENABLED | FTRACE_OPS_FL_ADDING;
>  
>  	ret = ftrace_hash_ipmodify_enable(ops);
> -	if (ret < 0) {
> -		/* Rollback registration process */
> -		__unregister_ftrace_function(ops);
> -		ftrace_start_up--;
> -		ops->flags &= ~FTRACE_OPS_FL_ENABLED;
> -		if (ops->flags & FTRACE_OPS_FL_DYNAMIC)
> -			ftrace_trampoline_free(ops);
> -		return ret;

This should stay as is.

> -	}
> +	if (ret < 0)
> +		goto out_rollback_registration;
>  
>  	if (ftrace_hash_rec_enable(ops, 1))
>  		command |= FTRACE_UPDATE_CALLS;
>  
>  	ftrace_startup_enable(command);
>  
> +	/*
> +	 * If ftrace_startup_enable fails,
> +	 * we need to rollback registration process.
> +	 */
> +	if (unlikely(ftrace_disabled)) {
> +		ret = -ENODEV;
> +		goto out_rollback_registration;

The only thing to do here is the _unregister_ftrace_function(ops);
And that may not even be safe.


> +	}
> +
>  	ops->flags &= ~FTRACE_OPS_FL_ADDING;
>  
>  	return 0;
> +
> +out_rollback_registration:
> +	/* Rollback registration process */
> +	__unregister_ftrace_function(ops);
> +	ftrace_start_up--;
> +	ops->flags &= ~FTRACE_OPS_FL_ENABLED;
> +	if (ops->flags & FTRACE_OPS_FL_DYNAMIC)
> +		ftrace_trampoline_free(ops);
> +

When ftrace_disabled is set, ftrace is in an undefined state, and a reboot
should be done ASAP. Because we have no idea what went wrong. It means
something happened that ftrace was not designed for.

That means, we do not know if the trampoline can still be called or not.
Maybe it enabled some of the functions, but not all. And maybe those
functions call the dynamic trampoline directly.

Thus, on ftrace_disable being set, only do the bare minimum, as ftrace has
now "shutdown" and will not do any more work.

Basically, this patch is trying to mitigate a kernel that broke and needs
a reboot immediately.

-- Steve


> +	return ret;
>  }
>  
>  int ftrace_shutdown(struct ftrace_ops *ops, int command)
> -- 
