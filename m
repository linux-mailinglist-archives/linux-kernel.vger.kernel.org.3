Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A070952D95E
	for <lists+linux-kernel@lfdr.de>; Thu, 19 May 2022 17:52:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236795AbiESPwD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 May 2022 11:52:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39974 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241615AbiESPuz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 May 2022 11:50:55 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E19B175AA
        for <linux-kernel@vger.kernel.org>; Thu, 19 May 2022 08:50:50 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id D116B61BFB
        for <linux-kernel@vger.kernel.org>; Thu, 19 May 2022 15:50:49 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AA248C34100;
        Thu, 19 May 2022 15:50:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1652975449;
        bh=k0ngAhg/Z3ZQxhg7rV0/oPwjM35gchHoHZEW1gRBeBA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=cy3munNdMyBLZ1tkla/JwMThbfl4pDGriqW7Dzzq89o31hihdxJgRH08avEQ8BZST
         LWrIWddTKSpAAWB/xiufwEXbJ7yeyc0bc8L+w8xUJCn9DvsDB8rqouODgXckPrVWDP
         w22PmmzG3CAKYnc5Y7+KtAG7Rfl/JHcPXYQFsbLA=
Date:   Thu, 19 May 2022 17:50:46 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Li Li <dualli@chromium.org>
Cc:     dualli@google.com, tkjos@google.com, christian@brauner.io,
        arve@android.com, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org, maco@google.com, hridya@google.com,
        surenb@google.com, joel@joelfernandes.org, kernel-team@android.com
Subject: Re: [PATCH v1] Binder: add TF_UPDATE_TXN
Message-ID: <YoZnVrU8Dih+urv6@kroah.com>
References: <20220519000623.1715899-1-dualli@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220519000623.1715899-1-dualli@chromium.org>
X-Spam-Status: No, score=-7.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 18, 2022 at 05:06:23PM -0700, Li Li wrote:
> From: Li Li <dualli@google.com>

Note, your subject does not say what TF_UPDATE_TXN is, so it's a bit
hard to determine what is happening here.  Can you clean that up a bit
and sumarize what this new addition does?

> 
> When the target process is busy, incoming oneway transactions are
> queued in the async_todo list. If the clients continue sending extra
> oneway transactions while the target process is frozen, this queue can
> become too large to accommodate new transactions. That's why binder
> driver introduced ONEWAY_SPAM_DETECTION to detect this situation. It's
> helpful to debug the async binder buffer exhausting issue, but the
> issue itself isn't solved directly.
> 
> In real cases applications are designed to send oneway transactions
> repeatedly, delivering updated inforamtion to the target process.
> Typical examples are Wi-Fi signal strength and some real time sensor
> data. Even if the apps might only care about the lastet information,
> all outdated oneway transactions are still accumulated there until the
> frozen process is thawed later. For this kind of situations, there's
> no existing method to skip those outdated transactions and deliver the
> latest one only.
> 
> This patch introduces a new transaction flag TF_UPDATE_TXN. To use it,
> use apps can set this new flag along with TF_ONE_WAY. When such an
> oneway transaction is to be queued into the async_todo list of a frozen
> process, binder driver will check if any previous pending transactions
> can be superseded by comparing their code, flags and target node. If
> such an outdated pending transaction is found, the latest transaction
> will supersede that outdated one. This effectively prevents the async
> binder buffer running out and saves unnecessary binder read workloads.
> 
> Signed-off-by: Li Li <dualli@google.com>
> ---
>  drivers/android/binder.c            | 90 ++++++++++++++++++++++++++++-
>  drivers/android/binder_trace.h      |  4 ++
>  include/uapi/linux/android/binder.h |  1 +

How was this tested? 

>  3 files changed, 92 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/android/binder.c b/drivers/android/binder.c
> index f3b639e89dd8..153486a32d69 100644
> --- a/drivers/android/binder.c
> +++ b/drivers/android/binder.c
> @@ -2594,6 +2594,60 @@ static int binder_fixup_parent(struct list_head *pf_head,
>  	return binder_add_fixup(pf_head, buffer_offset, bp->buffer, 0);
>  }
>  
> +/**
> + * binder_can_update_transaction() - Can a txn be superseded by an updated one?
> + * @t1: the pending async txn in the frozen process
> + * @t2: the new async txn to supersede the outdated pending one
> + *
> + * Return:  true if t2 can supersede t1
> + *          false if t2 can not supersede t1
> + */
> +static bool binder_can_update_transaction(struct binder_transaction *t1,
> +					  struct binder_transaction *t2)
> +{
> +	if ((t1->flags & t2->flags & (TF_ONE_WAY | TF_UPDATE_TXN))
> +			!= (TF_ONE_WAY | TF_UPDATE_TXN)
> +			|| t1->to_proc == NULL || t2->to_proc == NULL)
> +		return false;
> +	if (t1->to_proc->tsk == t2->to_proc->tsk && t1->code == t2->code
> +			&& t1->flags == t2->flags
> +			&& t1->buffer->pid == t2->buffer->pid
> +			&& t1->buffer->target_node->ptr
> +			== t2->buffer->target_node->ptr
> +			&& t1->buffer->target_node->cookie
> +			== t2->buffer->target_node->cookie)

Did checkpatch pass this?  Please always use --strict and fix up all the
issues that it reports as this is not a normal kernel coding style,
sorry.

thanks,

greg k-h
