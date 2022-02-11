Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 43E294B2464
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Feb 2022 12:35:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349502AbiBKLfJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Feb 2022 06:35:09 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:49672 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349501AbiBKLfH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Feb 2022 06:35:07 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D608EE98
        for <linux-kernel@vger.kernel.org>; Fri, 11 Feb 2022 03:35:05 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 5E857B829BA
        for <linux-kernel@vger.kernel.org>; Fri, 11 Feb 2022 11:35:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0EEF4C340E9;
        Fri, 11 Feb 2022 11:34:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1644579299;
        bh=Hkq+PjlCr3pDzQXkTzPaoKSKMj7BpYkg+PrnI/b4/MU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=KnNfQZjzUMvvi2chGInhFImPDpCWVQSo1rmWsNU2OCSBnssJdJqxuUMbdueSyT5Xn
         RGLbOsoBD6s/pMtziKtPwLL5E5QTBQPLgbqLkcnlc/9ALrLT2JnkZmDB1+s0vIrVA9
         mOR5o8PJVLaXWkRaCtDedQpfRiTiqewFrwtwnru3VI5y1ZmIv7tRcU51bUJRHqbRcp
         YkSjueOlqRanaXKLRBmxRL4RSIgOEwCpCgX5hwTe0OPh0jY5ulfk7kkJiuREJnI4NA
         rLyDfJStoQVGc9Di89DwXhbi38DA4AuEnnoBxXyMSu6a5TyCuyThgPNEhAWOBUgKW6
         XGL8TDDkgBzvA==
Date:   Fri, 11 Feb 2022 12:34:54 +0100
From:   Alexey Gladkov <legion@kernel.org>
To:     "Eric W. Biederman" <ebiederm@xmission.com>
Cc:     linux-kernel@vger.kernel.org, Kees Cook <keescook@chromium.org>,
        Shuah Khan <shuah@kernel.org>,
        Christian Brauner <brauner@kernel.org>,
        Solar Designer <solar@openwall.com>,
        Ran Xiaokai <ran.xiaokai@zte.com.cn>,
        containers@lists.linux-foundation.org,
        Michal =?utf-8?Q?Koutn=C3=BD?= <mkoutny@suse.com>
Subject: Re: [PATCH 6/8] ucounts: Handle inc_rlimit_ucounts wrapping in fork
Message-ID: <20220211113454.socmlrne5heux7q7@example.org>
References: <87o83e2mbu.fsf@email.froward.int.ebiederm.org>
 <20220211021324.4116773-6-ebiederm@xmission.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220211021324.4116773-6-ebiederm@xmission.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 10, 2022 at 08:13:22PM -0600, Eric W. Biederman wrote:
> Move inc_rlimit_ucounts from copy_creds into copy_process immediately
> after copy_creds where it can be called exactly once.  Test for and
> handle it when inc_rlimit_ucounts returns LONG_MAX indicating the
> count has wrapped.
> 
> This is good hygenine and fixes a theoretical bug.  In practice
> PID_MAX_LIMIT is at most 2^22 so there is not a chance the number of
> processes would ever wrap even on an architecture with a 32bit long.
> 
> Fixes: 21d1c5e386bc ("Reimplement RLIMIT_NPROC on top of ucounts")
> Signed-off-by: "Eric W. Biederman" <ebiederm@xmission.com>
> ---
>  kernel/cred.c | 2 --
>  kernel/fork.c | 2 ++
>  2 files changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/kernel/cred.c b/kernel/cred.c
> index 229cff081167..96d5fd6ff26f 100644
> --- a/kernel/cred.c
> +++ b/kernel/cred.c
> @@ -358,7 +358,6 @@ int copy_creds(struct task_struct *p, unsigned long clone_flags)
>  		kdebug("share_creds(%p{%d,%d})",
>  		       p->cred, atomic_read(&p->cred->usage),
>  		       read_cred_subscribers(p->cred));
> -		inc_rlimit_ucounts(task_ucounts(p), UCOUNT_RLIMIT_NPROC, 1);
>  		return 0;
>  	}
>  
> @@ -395,7 +394,6 @@ int copy_creds(struct task_struct *p, unsigned long clone_flags)
>  #endif
>  
>  	p->cred = p->real_cred = get_cred(new);
> -	inc_rlimit_ucounts(task_ucounts(p), UCOUNT_RLIMIT_NPROC, 1);
>  	alter_cred_subscribers(new, 2);
>  	validate_creds(new);
>  	return 0;
> diff --git a/kernel/fork.c b/kernel/fork.c
> index 6f62d37f3650..69333078259c 100644
> --- a/kernel/fork.c
> +++ b/kernel/fork.c
> @@ -2026,6 +2026,8 @@ static __latent_entropy struct task_struct *copy_process(
>  		goto bad_fork_free;
>  
>  	retval = -EAGAIN;
> +	if (inc_rlimit_ucounts(task_ucounts(p), UCOUNT_RLIMIT_NPROC, 1) == LONG_MAX)
> +		goto bad_fork_cleanup_count;
>  	if (is_ucounts_overlimit(task_ucounts(p), UCOUNT_RLIMIT_NPROC, rlimit(RLIMIT_NPROC))) {
>  		if ((task_ucounts(p) != &init_ucounts) &&
>  		    !capable(CAP_SYS_RESOURCE) && !capable(CAP_SYS_ADMIN))

It might make sense to do something like:

	if (inc_rlimit_ucounts_overlimit(task_ucounts(p), UCOUNT_RLIMIT_NPROC, 1, rlimit(RLIMIT_NPROC)) == LONG_MAX) {
		if ((task_ucounts(p) != &init_ucounts) &&
		    !capable(CAP_SYS_RESOURCE) && !capable(CAP_SYS_ADMIN))

and the new function:

long inc_rlimit_ucounts_overlimit(struct ucounts *ucounts, enum ucount_type type, long v, unsigned long rlimit)
{
	struct ucounts *iter;
	long ret = 0;
	long max = rlimit;
	if (rlimit > LONG_MAX)
		max = LONG_MAX;
	for (iter = ucounts; iter; iter = iter->ns->ucounts) {
		long new = atomic_long_add_return(v, &iter->ucount[type]);
		if (new < 0 || new > max)
			ret = LONG_MAX;
		else if (iter == ucounts)
			ret = new;
		max = READ_ONCE(iter->ns->ucount_max[type]);
	}
	return ret;
}

This will avoid double checking the same userns tree.

Or even modify inc_rlimit_ucounts. This function is used elsewhere like
this:


msgqueue = inc_rlimit_ucounts(info->ucounts, UCOUNT_RLIMIT_MSGQUEUE, mq_bytes);
if (msgqueue == LONG_MAX || msgqueue > rlimit(RLIMIT_MSGQUEUE)) {


memlock = inc_rlimit_ucounts(ucounts, UCOUNT_RLIMIT_MEMLOCK, locked);
if (!allowed && (memlock == LONG_MAX || memlock > lock_limit) && !capable(CAP_IPC_LOCK)) {


In all cases, we have max value for comparison.

-- 
Rgrds, legion

