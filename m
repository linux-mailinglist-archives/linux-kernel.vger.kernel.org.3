Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ABE90468341
	for <lists+linux-kernel@lfdr.de>; Sat,  4 Dec 2021 08:57:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354872AbhLDIAu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 4 Dec 2021 03:00:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60806 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240517AbhLDIAt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 4 Dec 2021 03:00:49 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E265C061751
        for <linux-kernel@vger.kernel.org>; Fri,  3 Dec 2021 23:57:23 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B52BB60AE2
        for <linux-kernel@vger.kernel.org>; Sat,  4 Dec 2021 07:57:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 30B0FC341C0;
        Sat,  4 Dec 2021 07:57:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1638604642;
        bh=k4Q5QHsiZ2WjT9C3kK7f5oFDgfGl+psRpVZ2CMBRmoY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=KuWZAEgds8XnwjdmOQFugIORMplgZM0DHiZrEdWLeiGXbYq6OvG9mpOYAW/GuZEvl
         RR6gtdRroPXfNwZDUULUViHdsQORarVlWeNzGRWK1LCro8G2bOVc/Trp0fOohe4MD6
         iADbVofNSnoT88m0KAcddBp8BHI5t10S1fuwaliI=
Date:   Sat, 4 Dec 2021 08:57:17 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Ameer Hamza <amhamza.mgc@gmail.com>
Cc:     arve@android.com, tkjos@android.com, maco@android.com,
        joel@joelfernandes.org, christian@brauner.io, hridya@google.com,
        surenb@google.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] binder: fixed coverity warning by moving pr_warn outside
 lock
Message-ID: <YasfXUW1rNrj3Mgo@kroah.com>
References: <20211203205041.115331-1-amhamza.mgc@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211203205041.115331-1-amhamza.mgc@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Dec 04, 2021 at 01:50:41AM +0500, Ameer Hamza wrote:
> Coverity warns about using print operations within a lock due to
> unlikely possible deadlock scenario, however, this warning can be
> easily avoided here without having any effect on the program flow.
> 
> Addresses-Coverity: 1494148 ("Thread deadlock")

Sounds like coverity is wrong, you can print any time, locks do not
matter here.

Do you have a link to the exact coverity report for this?

> Signed-off-by: Ameer Hamza <amhamza.mgc@gmail.com>
> ---
>  drivers/android/binder.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/android/binder.c b/drivers/android/binder.c
> index cffbe57a8e08..8ee942eef51d 100644
> --- a/drivers/android/binder.c
> +++ b/drivers/android/binder.c
> @@ -1507,14 +1507,14 @@ static void binder_free_transaction(struct binder_transaction *t)
>  	if (target_proc) {
>  		binder_inner_proc_lock(target_proc);
>  		target_proc->outstanding_txns--;
> -		if (target_proc->outstanding_txns < 0)
> -			pr_warn("%s: Unexpected outstanding_txns %d\n",
> -				__func__, target_proc->outstanding_txns);
>  		if (!target_proc->outstanding_txns && target_proc->is_frozen)
>  			wake_up_interruptible_all(&target_proc->freeze_wait);
>  		if (t->buffer)
>  			t->buffer->transaction = NULL;
>  		binder_inner_proc_unlock(target_proc);
> +		if (target_proc->outstanding_txns < 0)
> +			pr_warn("%s: Unexpected outstanding_txns %d\n",
> +				__func__, target_proc->outstanding_txns);

Have you seen problems with the location of the existing message?  If
not, this should be fine.

thanks,

greg k-h
