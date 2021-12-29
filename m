Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7E0DB4817D2
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Dec 2021 00:56:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233485AbhL2XxJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Dec 2021 18:53:09 -0500
Received: from ams.source.kernel.org ([145.40.68.75]:57784 "EHLO
        ams.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231881AbhL2XxI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Dec 2021 18:53:08 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id CB3C0B819C4
        for <linux-kernel@vger.kernel.org>; Wed, 29 Dec 2021 23:53:07 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D812CC36AEA;
        Wed, 29 Dec 2021 23:53:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
        s=korg; t=1640821986;
        bh=Va1wahRPO8vBMlP2UabmSRApv7q4Gzh6J6565PyyoAU=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=0Q0sEk4WN67trJ2hf1/NT/kCV37G5Y/Cu3IyZ6/dTQ56fm0xGj1+4a+e6rj6qXPUe
         AncqRnyinYMk+r6N6vtvNBZDp6iM7HyoQ1AZvRmKcjCzio6FxJxQM1g8E7dCAGTfHN
         UnFK/5pY9+X5UkhqQr98fle4JsiubxMJh9mC7ooY=
Date:   Wed, 29 Dec 2021 15:53:05 -0800
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Calvin Liao <calvin.liao@gmail.com>
Cc:     Matthias Brugger <matthias.bgg@gmail.com>,
        "Eric W . Biederman" <ebiederm@xmission.com>,
        "Peter Zijlstra" <peterz@infradead.org>,
        Christian Brauner <christian.brauner@ubuntu.com>,
        Jens Axboe <axboe@kernel.dk>,
        Alexey Gladkov <legion@kernel.org>,
        Mike Christie <michael.christie@oracle.com>,
        "David Hildenbrand" <david@redhat.com>,
        Rolf Eike Beer <eb@emlix.com>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>,
        wsd_upstream <wsd_upstream@mediatek.com>,
        "calvin.liao" <calvin.liao@mediatek.com>,
        Andrea Arcangeli <aarcange@redhat.com>
Subject: Re: [PATCH 1/1] seccomp: release seccomp after killing terminate
 clone/fork
Message-Id: <20211229155305.eb4e3cf76fc9e811bb2b3bfc@linux-foundation.org>
In-Reply-To: <20211228053421.26825-1-calvin.liao@gmail.com>
References: <20211228053421.26825-1-calvin.liao@gmail.com>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 28 Dec 2021 13:34:21 +0800 Calvin Liao <calvin.liao@gmail.com> wrote:

> From: "calvin.liao" <calvin.liao@mediatek.com>
> 
> Add to release seccomp after killing terminate clone/fork to avoid
> memory leak when enabling CONFIG_SECCOMP.
> 

Help us out here - where was this filter allocated?  Please describe
the code flow which led to this leak.  Rather than simply saying "there
is a leak".

> --- a/kernel/fork.c
> +++ b/kernel/fork.c
> @@ -1698,6 +1698,13 @@ static void copy_seccomp(struct task_struct *p)
>  #endif
>  }
>  
> +static void release_seccomp(struct task_struct *p)
> +{
> +#ifdef CONFIG_SECCOMP
> +	seccomp_filter_release(p);
> +#endif

ifdefs aren't needed?

> +}
> +
>  SYSCALL_DEFINE1(set_tid_address, int __user *, tidptr)
>  {
>  	current->clear_child_tid = tidptr;
> @@ -2405,6 +2412,7 @@ static __latent_entropy struct task_struct *copy_process(
>  	return p;
>  
>  bad_fork_cancel_cgroup:
> +	release_seccomp(p);

Why not simply call seccomp_filter_release() here, without ifdefs?

>  	sched_core_free(p);
>  	spin_unlock(&current->sighand->siglock);
>  	write_unlock_irq(&tasklist_lock);

