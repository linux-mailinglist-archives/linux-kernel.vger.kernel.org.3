Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B456946E57F
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Dec 2021 10:24:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234440AbhLIJ2K (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Dec 2021 04:28:10 -0500
Received: from smtp-out2.suse.de ([195.135.220.29]:38970 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233327AbhLIJ2K (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Dec 2021 04:28:10 -0500
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id 63EC91FCA3;
        Thu,  9 Dec 2021 09:24:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1639041876; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=KHvKhWni52gq8fTpBe8ZSLs4caJB+E+6F/Ed6jyGY7c=;
        b=NORe5kboymQbuRxjx03ZsJ6KYm+M0Z1dsjHcA279+Xv7YKR234v4I3WX+CIloCutXx31Kp
        06oXLvFQYbn/a0NjpfkqZg1j2lLZuCSmxi+TT+myqnYP//NXnb4T5jLDe055HEWfZnO/8Z
        uacRg54VzrPTVKtb5CDSjQAZKlIMlFE=
Received: from suse.cz (unknown [10.100.224.162])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id 47538A3B94;
        Thu,  9 Dec 2021 09:24:36 +0000 (UTC)
Date:   Thu, 9 Dec 2021 10:24:36 +0100
From:   Petr Mladek <pmladek@suse.com>
To:     Jiasheng Jiang <jiasheng@iscas.ac.cn>
Cc:     akpm@linux-foundation.org, valentin.schneider@arm.com,
        peterz@infradead.org, keescook@chromium.org,
        robdclark@chromium.org, samitolvanen@google.com,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] kthread: potential dereference of null pointer
Message-ID: <YbHLVJ84QXxZdTqD@alley>
References: <20211209064314.2074885-1-jiasheng@iscas.ac.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211209064314.2074885-1-jiasheng@iscas.ac.cn>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu 2021-12-09 14:43:14, Jiasheng Jiang wrote:
> The return value of kzalloc() needs to be checked.
> To avoid use of null pointer in case of the failure of alloc.
> 
> Fixes: dc6a87f5450d ("sched: Make the idle task quack like a per-CPU
> kthread")

The hash id looks wrong:

$> git log -p -1 dc6a87f5450d
fatal: ambiguous argument 'dc6a87f5450d': unknown revision or path not in the working tree.


> Signed-off-by: Jiasheng Jiang <jiasheng@iscas.ac.cn>
> ---
>  kernel/kthread.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/kernel/kthread.c b/kernel/kthread.c
> index 08931e525dd9..3feefeff4922 100644
> --- a/kernel/kthread.c
> +++ b/kernel/kthread.c
> @@ -101,6 +101,8 @@ void set_kthread_struct(struct task_struct *p)
>  		return;
>  
>  	kthread = kzalloc(sizeof(*kthread), GFP_KERNEL);
> +	if (!kthread)
> +		return;

This does not have any effect. It will only skip the assignment:

	p->set_child_tid = (__force void __user *)kthread;

But we are here only when p->set_child_tid is already NULL
because of the above check:

	if (__to_kthread(p))
		return;


>  	/*
>  	 * We abuse ->set_child_tid to avoid the new member and because it
>  	 * can't be wrongly copied by copy_process(). We also rely on fact

By other words. The change does not harm but it is not needed either.
Anyway, the commit message is misleading. It suggests that it fixes
something but it is not true.

I would personally keep the code as is. The original code makes it
more clear that the allocation failure is not handled.

Best Regards,
Petr
