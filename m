Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2AFF3470C5E
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Dec 2021 22:17:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243612AbhLJVUg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Dec 2021 16:20:36 -0500
Received: from ams.source.kernel.org ([145.40.68.75]:32992 "EHLO
        ams.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237869AbhLJVUf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Dec 2021 16:20:35 -0500
Received: from mail.kernel.org (unknown [198.145.29.99])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 506BAB829E6
        for <linux-kernel@vger.kernel.org>; Fri, 10 Dec 2021 21:16:59 +0000 (UTC)
Received: by mail.kernel.org (Postfix) with ESMTPSA id 6DF23603E2;
        Fri, 10 Dec 2021 21:16:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
        s=korg; t=1639171017;
        bh=d1V6wRVScf+jsw78DRcRPbbdKMPCEh+HKtjrtN35Qvw=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=PhINp8swlK1qZGyc/ijbWUgmg7fn8c4nBHzg/7Ut/yiS/ucbdnR2HnbKne+Lxrgvr
         KZNbXd81eOi9+VcS75Z7dSerrObfdtEved9N/9ceLksmpta6SMA28XS2MMcJhruiw/
         aVVUW9YuAUh3AfiSTGwzLN6f/+k4s+beZPJ9qlQ8=
Date:   Fri, 10 Dec 2021 13:16:55 -0800
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Jiasheng Jiang <jiasheng@iscas.ac.cn>
Cc:     pmladek@suse.com, valentin.schneider@arm.com, peterz@infradead.org,
        keescook@chromium.org, robdclark@chromium.org,
        samitolvanen@google.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] kthread: potential dereference of null pointer
Message-Id: <20211210131655.2eeb8f866382c324b605a6ce@linux-foundation.org>
In-Reply-To: <20211209064314.2074885-1-jiasheng@iscas.ac.cn>
References: <20211209064314.2074885-1-jiasheng@iscas.ac.cn>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu,  9 Dec 2021 14:43:14 +0800 Jiasheng Jiang <jiasheng@iscas.ac.cn> wrote:

> The return value of kzalloc() needs to be checked.
> To avoid use of null pointer in case of the failure of alloc.
> 
> ...
>
> --- a/kernel/kthread.c
> +++ b/kernel/kthread.c
> @@ -101,6 +101,8 @@ void set_kthread_struct(struct task_struct *p)
>  		return;
>  
>  	kthread = kzalloc(sizeof(*kthread), GFP_KERNEL);
> +	if (!kthread)
> +		return;
>  	/*
>  	 * We abuse ->set_child_tid to avoid the new member and because it
>  	 * can't be wrongly copied by copy_process(). We also rely on fact

No, we shouldn't simply leave ->set_child_tid uninitialized if kmalloc
failed.

set_ktread_struct() appears to be designed so that callers must check
that to_kthread() returns non-zero after having called
set_kthread_struct().

Which is a quite weird interface, but I'm not seeing any bugs here.  If
kthread() sees to_kthread()==NULL then this kthread won't be created
and all the other unchecked calls to to_kthread() will never execute,
because this kthread doesn't exist.

The exception is in init_idle(), but that's __init code, executed at
boot time when we assume that allocations will always succeed.
