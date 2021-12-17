Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 543D44795CD
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Dec 2021 21:53:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237268AbhLQUxH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Dec 2021 15:53:07 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:35494 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234597AbhLQUxG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Dec 2021 15:53:06 -0500
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1639774385;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=egAtBIp+8eOxFk5qDbLy/fb5/DD1UbIaiHz3nHCp6wE=;
        b=Im6nyUFYbdMfWAm7k1s3MigVptJNb8dvv7g1TO7dzTcjROobLkCUuQeaNLy6Jk33yFQHxb
        nENx9WXvtXo6ufquTrTwW/sEFk5S35ov61toTiuYxtnIXvtVWS/KjcZVVGI0jGmWGNmSkO
        rwzmzSy3hLLlnLmbxnX/zwP94M2nzC744fRcWrlAUFvTLznZGTXV5E+EKBkQrNyMsMdn7f
        1nU9/wTKEe+pQmPvQ37MN2/DcQFdIxSQwPa1qEXow/xNrTEAXjL5sUgd/mZXW/FgQZjZUF
        l0H7WXUtQlfyBVp4Q4R9HW6w1g6dGniawxvSr4jXsv4YJPCrnffzd+T39pEBHw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1639774385;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=egAtBIp+8eOxFk5qDbLy/fb5/DD1UbIaiHz3nHCp6wE=;
        b=Sa+9TLs8OLFxpdinJptLuzazPPO0FDIlX9S/41wnb5R7SrF7DXoQPMinSwTKfSghfu3wyu
        C52eLhNu162VwaAQ==
To:     Zqiang <qiang1.zhang@intel.com>, peterz@infradead.org,
        mingo@redhat.com, will@kernel.org, longman@redhat.com
Cc:     linux-kernel@vger.kernel.org, qiang1.zhang@intel.com
Subject: Re: [PATCH v2] locking/rtmutex: Fix incorrect spinning condition
In-Reply-To: <20211217074207.77425-1-qiang1.zhang@intel.com>
References: <20211217074207.77425-1-qiang1.zhang@intel.com>
Date:   Fri, 17 Dec 2021 21:53:04 +0100
Message-ID: <87k0g3ar7z.ffs@tglx>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Zqiang,

On Fri, Dec 17 2021 at 15:42, Zqiang wrote:
> When the lock owner is on CPU and not need resched, the current waiter
> need to be checked, if it not longer top the waiter, stop spinning.
>
> Fixes: c3123c431447 ("locking/rtmutex: Dont dereference waiter lockless")
> Signed-off-by: Zqiang <qiang1.zhang@intel.com>
> ---
>  v1->v2:
>  Modify description information.
>
>  kernel/locking/rtmutex.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/kernel/locking/rtmutex.c b/kernel/locking/rtmutex.c
> index 0c1f2e3f019a..8555c4efe97c 100644
> --- a/kernel/locking/rtmutex.c
> +++ b/kernel/locking/rtmutex.c
> @@ -1383,7 +1383,7 @@ static bool rtmutex_spin_on_owner(struct rt_mutex_base *lock,
>  		 *  - the VCPU on which owner runs is preempted
>  		 */
>  		if (!owner_on_cpu(owner) || need_resched() ||
> -		    rt_mutex_waiter_is_top_waiter(lock, waiter)) {
> +		    !rt_mutex_waiter_is_top_waiter(lock, waiter)) {
>  			res = false;
>  			break;

good catch!

Though this does not apply because the condition is incomplete. You
somehow dropped this from the condition:

                   vcpu_is_preempted(task_cpu(owner))) 

Please make always sure that your patches apply against Linus tree
before sending them out.

Thanks,

        tglx
