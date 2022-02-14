Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 54E334B5A84
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Feb 2022 20:22:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229810AbiBNTWc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Feb 2022 14:22:32 -0500
Received: from gmail-smtp-in.l.google.com ([23.128.96.19]:40272 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229455AbiBNTWZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Feb 2022 14:22:25 -0500
Received: from mail-pf1-x42e.google.com (mail-pf1-x42e.google.com [IPv6:2607:f8b0:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 33167C3C29
        for <linux-kernel@vger.kernel.org>; Mon, 14 Feb 2022 11:22:09 -0800 (PST)
Received: by mail-pf1-x42e.google.com with SMTP id i6so29013913pfc.9
        for <linux-kernel@vger.kernel.org>; Mon, 14 Feb 2022 11:22:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=C9OZ9lkGBew1Fln2B2Xqa8Kc+RoaWdl8qu2n91DF9/U=;
        b=hhAaz3l9bpuzcy32r4CyqqTbSACA3Q838DbOiDNTEimvdn8BCLkdNr5gnKXUFnJA7E
         WmlJkWt/Gm3KpnNgwkQHy8JyfGSWEXnJGwj6vfBo96JaceCoTkZgVftIge0tWeTqGcjP
         c1toamzvFbePA4yVzR5Ka5wvYFth+A+Bh5Nr5voXoUfi7JBKhWgJr2tW8kyH0BU5dFAb
         ozo9YHny4JiQx2Sn22gBZk6SrhOQ3WuzssXT5AW5gzsyWgUXmpeRU/nwqXHLONv0/i+o
         KYdQSKcXoipUtNscRkraqPirqIY/70J88Ph5+LJ75B/tD9KWO2b9Hc4U5vU9ufAlpcKI
         AAvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=C9OZ9lkGBew1Fln2B2Xqa8Kc+RoaWdl8qu2n91DF9/U=;
        b=WzMwJ8l1fdpZvYcxJ8OG/eoxDUwkKRxuCP0NmHAqQ8XCkbMeY3l6hNEMymClFbHWGp
         Rz+E8tFIXA/rMaL3TPj16WfEznMeI9VEzHd72eTOhBpVX1OuqN3URwE4JwvFWRUX5ii1
         ARy7/zMGQv7MZn5QL/NoJNjzR3t4MiNjBdjJmtfqFdW76izvSJarDcRW4qNJSa1U3rpA
         tI4QV2phTQRgnbD8dEMaC8ZkXae5bq6ziwwT5CR3rT6NL+UTryU1cAPz1MyCY1kWJdkE
         CUtlZaDGkomXZs8cYCN0JI2akeT+aNZ/1U2L8JG/vrkM1r8d1UQQTzFzUNckuAEWN/7v
         J96A==
X-Gm-Message-State: AOAM531UZm879XkuECC4Gs2+Qt1qpp08lPJGTSdotKPn5XX9zVEz0nym
        RsxLXEdVlzEBRRLC3Dgo0xw=
X-Google-Smtp-Source: ABdhPJxizpu7aO8fhZ4pszeLACJjumFlOfT1nPVUPLYHDgNJCYesNvG3Zr6w8dyny4yeBWRt+Y8Llw==
X-Received: by 2002:a63:864a:: with SMTP id x71mr439600pgd.272.1644866234650;
        Mon, 14 Feb 2022 11:17:14 -0800 (PST)
Received: from localhost (2603-800c-1a02-1bae-e24f-43ff-fee6-449f.res6.spectrum.com. [2603:800c:1a02:1bae:e24f:43ff:fee6:449f])
        by smtp.gmail.com with ESMTPSA id q12sm39114023pfk.199.2022.02.14.11.17.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Feb 2022 11:17:14 -0800 (PST)
Sender: Tejun Heo <htejun@gmail.com>
Date:   Mon, 14 Feb 2022 09:17:12 -1000
From:   Tejun Heo <tj@kernel.org>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Borislav Petkov <bp@suse.de>,
        Tadeusz Struk <tadeusz.struk@linaro.org>,
        x86-ml <x86@kernel.org>, lkml <linux-kernel@vger.kernel.org>,
        zhangqiao22@huawei.com, dietmar.eggemann@arm.com
Subject: Re: [GIT PULL] sched/urgent for 5.17-rc4
Message-ID: <YgqquDnQe3SihgJU@slm.duckdns.org>
References: <Ygj7feK+vdtPw6zj@zn.tnic>
 <CAHk-=wiHUWHHcPLCvyXQKf2wbL3L1SOQSGVuCdf-py6QZGnuqQ@mail.gmail.com>
 <YgoWoh6pIzlsQx6d@hirez.programming.kicks-ass.net>
 <YgoeCbwj5mbCR0qA@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YgoeCbwj5mbCR0qA@hirez.programming.kicks-ass.net>
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello, Peter.

On Mon, Feb 14, 2022 at 10:16:57AM +0100, Peter Zijlstra wrote:
> diff --git a/kernel/fork.c b/kernel/fork.c
> index d75a528f7b21..05faebafe2b5 100644
> --- a/kernel/fork.c
> +++ b/kernel/fork.c
> @@ -2266,6 +2266,13 @@ static __latent_entropy struct task_struct *copy_process(
>  	if (retval)
>  		goto bad_fork_put_pidfd;
>  
> +	/*
> +	 * Now that the cgroups are pinned, re-clone the parent cgroup and put
> +	 * the new task on the correct runqueue. All this *before* the task
> +	 * becomes visible.
> +	 */
> +	sched_cgroup_fork(p, args);

Would it be less confusing to comment that this isn't ->can_fork() because
scheduler task_group needs to be initialized for autogroup even when cgroup
is disabled and maybe name it sched_cgroup_can_fork() even if it always
succeeds?

> +void sched_cgroup_fork(struct task_struct *p, struct kernel_clone_args *kargs)
>  {
>  	unsigned long flags;
> -#ifdef CONFIG_CGROUP_SCHED
> -	struct task_group *tg;
> -#endif
>  
> +	/*
> +	 * Because we're not yet on the pid-hash, p->pi_lock isn't strictly
> +	 * required yet, but lockdep gets upset if rules are violated.
> +	 */
>  	raw_spin_lock_irqsave(&p->pi_lock, flags);
>  #ifdef CONFIG_CGROUP_SCHED
> -	tg = container_of(kargs->cset->subsys[cpu_cgrp_id],
> -			  struct task_group, css);
> -	p->sched_task_group = autogroup_task_group(p, tg);
> +	if (1) {
> +		struct task_group *tg;
> +		tg = container_of(kargs->cset->subsys[cpu_cgrp_id],
> +				  struct task_group, css);
> +		tg = autogroup_task_group(p, tg);
> +		p->sched_task_group = autogroup_task_group(p, tg);
> +	}

I suppose the double autogroup_task_group() call is unintentional?

Otherwise, looks good to me. The only requirement from cgroup side is that
the membership should be initialized between ->can_fork() and ->fork()
inclusively, and sans autogroup this would have been done as a part of
->can_fork() so the proposed change makes sense to me.

Thanks.

-- 
tejun
