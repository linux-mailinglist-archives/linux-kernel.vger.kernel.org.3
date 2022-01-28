Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F23EC4A002F
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jan 2022 19:34:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350585AbiA1Sed (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Jan 2022 13:34:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43822 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229827AbiA1Se3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Jan 2022 13:34:29 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA07AC061714
        for <linux-kernel@vger.kernel.org>; Fri, 28 Jan 2022 10:34:29 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 47D2761CEC
        for <linux-kernel@vger.kernel.org>; Fri, 28 Jan 2022 18:34:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C665BC340EA;
        Fri, 28 Jan 2022 18:34:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1643394868;
        bh=qc2srDJ/Tr/4ioZ7NvjqTJDjb9MXIJRHw3QP9k8RdMM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=u5OjJY5X3oKqZEg+u4pRnQLY6p6bUrZUtD3XGdF5VuT+Ig+6nkvSCPF2JzFnxFFj+
         HYTNj4Vpxq+xe4R8rVScMZdLvYAYxnjpqQNEZEisUuPZOiHLkqIrlGr61D5UYIF2IY
         YI7Nfrd2YctZE9ohtuwiJ61n7viksHkGEA4/Yv04RnX/OdGDk8ncasrqx1vzVxRHgx
         pX0ZgK9ZOaVMtXBJVIqXv6CfEd3trjfyCQTw+pIKeTnn1pOpqZu7nyoJNlwtC1T2zp
         kSSdj7/RSzN8tEVKPOPYaYPVp1FuvUf7yPK0/8D4jKOqzanG+AC3q6Op2kQ91nZ+bB
         ZD1xTZ5dVFEug==
Date:   Fri, 28 Jan 2022 19:34:23 +0100
From:   Christian Brauner <brauner@kernel.org>
To:     "Eric W. Biederman" <ebiederm@xmission.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org, Alexey Gladkov <legion@kernel.org>,
        Qian Cai <quic_qiancai@quicinc.com>,
        Mathias Krause <minipli@grsecurity.net>,
        Linux Containers <containers@lists.linux.dev>
Subject: Re: [GIT PULL] ucount rlimit fixes for v5.17-rc2
Message-ID: <20220128183423.d5z7v46opgphrbdb@wittgenstein>
References: <871r0rss9q.fsf@email.froward.int.ebiederm.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <871r0rss9q.fsf@email.froward.int.ebiederm.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 28, 2022 at 11:07:45AM -0600, Eric W. Biederman wrote:
> 
> Linus,
> 
> Please pull the ucount-rlimit-fixes-for-v5.17-rc2 branch from the git tree:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/ebiederm/user-namespace.git ucount-rlimit-fixes-for-v5.17-rc2
>   HEAD: f9d87929d451d3e649699d0f1d74f71f77ad38f5 ucount:  Make get_ucount a safe get_user replacement
> 
> 
> From: "Eric W. Biederman" <ebiederm@xmission.com>
> Date: Mon, 24 Jan 2022 12:46:50 -0600
> Subject: [PATCH] ucount:  Make get_ucount a safe get_user replacement
> 
> When the ucount code was refactored to create get_ucount it was missed
> that some of the contexts in which a rlimit is kept elevated can be
> the only reference to the user/ucount in the system.
> 
> Ordinary ucount references exist in places that also have a reference
> to the user namspace, but in POSIX message queues, the SysV shm code,
> and the SIGPENDING code there is no independent user namespace
> reference.
> 
> Inspection of the the user_namespace show no instance of circular
> references between struct ucounts and the user_namespace.  So
> hold a reference from struct ucount to it's user_namespace to
> resolve this problem.
> 
> Link: https://lore.kernel.org/lkml/YZV7Z+yXbsx9p3JN@fixkernel.com/
> Reported-by: Qian Cai <quic_qiancai@quicinc.com>
> Reported-by: Mathias Krause <minipli@grsecurity.net>
> Tested-by: Mathias Krause <minipli@grsecurity.net>
> Reviewed-by: Mathias Krause <minipli@grsecurity.net>
> Reviewed-by: Alexey Gladkov <legion@kernel.org>
> Fixes: d64696905554 ("Reimplement RLIMIT_SIGPENDING on top of ucounts")
> Fixes: 6e52a9f0532f ("Reimplement RLIMIT_MSGQUEUE on top of ucounts")
> Fixes: d7c9e99aee48 ("Reimplement RLIMIT_MEMLOCK on top of ucounts")
> Cc: stable@vger.kernel.org
> Signed-off-by: "Eric W. Biederman" <ebiederm@xmission.com>
> ---

Hey,

Please ensure that next time a security issue is reported to
security@kernel.org for userns such as this UAF that the pull request
that gets sent to fix this issue Ccs the containers development list.

This whole ucount conversion has been quite problematic so far. And
that's not the problem, bugs happen. But fixes for bugs that were
reported as security issues should at least have visibility on the right
lists so people don't go and get pinged about them on Twitter [1].

A Cc for the oss-security list would've also sufficed where most of us
are subscribed. None of this is pleasant, I very much sympathise.
Thanks for fixing this, and thanks to Mathias for the report.

[1]: https://twitter.com/grsecurity/status/1487119590425600005


>  kernel/ucount.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/kernel/ucount.c b/kernel/ucount.c
> index 7b32c356ebc5..65b597431c86 100644
> --- a/kernel/ucount.c
> +++ b/kernel/ucount.c
> @@ -190,6 +190,7 @@ struct ucounts *alloc_ucounts(struct user_namespace *ns, kuid_t uid)
>  			kfree(new);
>  		} else {
>  			hlist_add_head(&new->node, hashent);
> +			get_user_ns(new->ns);
>  			spin_unlock_irq(&ucounts_lock);
>  			return new;
>  		}
> @@ -210,6 +211,7 @@ void put_ucounts(struct ucounts *ucounts)
>  	if (atomic_dec_and_lock_irqsave(&ucounts->count, &ucounts_lock, flags)) {
>  		hlist_del_init(&ucounts->node);
>  		spin_unlock_irqrestore(&ucounts_lock, flags);
> +		put_user_ns(ucounts->ns);
>  		kfree(ucounts);
>  	}
>  }
> -- 
> 2.29.2
> 
> eric
> 
