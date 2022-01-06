Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9B2FF486D1C
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jan 2022 23:17:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245028AbiAFWRv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Jan 2022 17:17:51 -0500
Received: from dfw.source.kernel.org ([139.178.84.217]:49744 "EHLO
        dfw.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244435AbiAFWRs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Jan 2022 17:17:48 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 3A7BB61E4C;
        Thu,  6 Jan 2022 22:17:48 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 18A9FC36AE5;
        Thu,  6 Jan 2022 22:17:46 +0000 (UTC)
Date:   Thu, 6 Jan 2022 17:17:45 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Beau Belgrave <beaub@linux.microsoft.com>
Cc:     mhiramat@kernel.org, linux-trace-devel@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v8 08/12] user_events: Optimize writing events by only
 copying data once
Message-ID: <20220106171745.1496c723@gandalf.local.home>
In-Reply-To: <20211216173511.10390-9-beaub@linux.microsoft.com>
References: <20211216173511.10390-1-beaub@linux.microsoft.com>
        <20211216173511.10390-9-beaub@linux.microsoft.com>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 16 Dec 2021 09:35:07 -0800
Beau Belgrave <beaub@linux.microsoft.com> wrote:

> @@ -1018,16 +1081,11 @@ static ssize_t user_events_write_core(struct file *file, struct iov_iter *i)
>  	if (likely(atomic_read(&tp->key.enabled) > 0)) {
>  		struct tracepoint_func *probe_func_ptr;
>  		user_event_func_t probe_func;
> +		struct iov_iter copy;
>  		void *tpdata;
> -		void *kdata;
> -		u32 datalen;
> -
> -		kdata = kmalloc(i->count, GFP_KERNEL);
>  
> -		if (unlikely(!kdata))
> -			return -ENOMEM;
> -
> -		datalen = copy_from_iter(kdata, i->count, i);
> +		if (unlikely(iov_iter_fault_in_readable(i, i->count)))

Can you rebase on my tree: ftrace/core ?

That's because upstream now has:

a6294593e8a12 ("iov_iter: Turn iov_iter_fault_in_readable into fault_in_iov_iter_readable")

And it looks like you need to call fault_in_iov_iter_readable().

-- Steve


> +			return -EFAULT;
>  
>  		rcu_read_lock_sched();
>  
