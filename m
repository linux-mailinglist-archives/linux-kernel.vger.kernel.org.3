Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A248159AD5B
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Aug 2022 12:57:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345494AbiHTK4I (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 20 Aug 2022 06:56:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35890 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242181AbiHTK4G (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 20 Aug 2022 06:56:06 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 15BE4A5738;
        Sat, 20 Aug 2022 03:56:05 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A328F61174;
        Sat, 20 Aug 2022 10:56:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7716EC433C1;
        Sat, 20 Aug 2022 10:56:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1660992964;
        bh=b2iO0hLmokZ8rJ3GCQaQjV/dfXMQhljRGwpKAg/ck4c=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=mGJNidZ779yhD4gUGSxdEOEF/tZFd3Zu0M3RL3GmbgsOj0727VfA3GqxrI0zVlhGf
         ON9lMSFYpER3wOy2ZdFI76pCOcEvjXxzjcTjAGHH6OSTC5vunkiei6xI59ruWe16Wj
         oEgxvjfRIwnktPSI513Q5Sg5Zr5OrqdVng9llWY9DQJGQzdYBF2QysQNyKCagdlRYv
         oiusK8GK1ycunyrpWhKE1m4tFfC20SnqCui0w6o/vY88Hd5B0E1MpjZ+ekCIAx61iG
         P7puuPhcG9m444vUPXqydGKhJ2FgIQISGQ1Tav6EvR/7nZM9WmfmfBfgQJhtDa9Wrc
         QOsAjN9HK2/yw==
Date:   Sat, 20 Aug 2022 12:06:40 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Vincent Whitchurch <vincent.whitchurch@axis.com>
Cc:     <kernel@axis.com>, Lars-Peter Clausen <lars@metafoo.de>,
        <linux-iio@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Peter Rosin <peda@axentia.se>
Subject: Re: [PATCH] iio: buffer: Silence lock nesting splat
Message-ID: <20220820120640.6d1b928d@jic23-huawei>
In-Reply-To: <20220816080828.1218667-1-vincent.whitchurch@axis.com>
References: <20220816080828.1218667-1-vincent.whitchurch@axis.com>
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.34; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 16 Aug 2022 10:08:28 +0200
Vincent Whitchurch <vincent.whitchurch@axis.com> wrote:

> If an IIO driver uses callbacks from another IIO driver and calls
> iio_channel_start_all_cb() from one of its buffer setup ops, then
> lockdep complains due to the lock nesting, as in the below example with
> lmp91000.  Since the locks are being taken on different IIO devices,
> there is no actual deadlock, so add lock nesting annotation to silence
> the spurious warning.
> 
>  ============================================
>  WARNING: possible recursive locking detected
>  6.0.0-rc1+ #10 Not tainted
>  --------------------------------------------
>  python3/23 is trying to acquire lock:
>  0000000064c944c0 (&indio_dev->mlock){+.+.}-{3:3}, at: iio_update_buffers+0x62/0x180
> 
>  but task is already holding lock:
>  00000000636b64c0 (&indio_dev->mlock){+.+.}-{3:3}, at: enable_store+0x4d/0x100
> 
>  other info that might help us debug this:
>   Possible unsafe locking scenario:
> 
>         CPU0
>         ----
>    lock(&indio_dev->mlock);
>    lock(&indio_dev->mlock);
> 
>   *** DEADLOCK ***
> 
>   May be due to missing lock nesting notation
> 
>  5 locks held by python3/23:
>   #0: 00000000636b5420 (sb_writers#5){.+.+}-{0:0}, at: ksys_write+0x67/0x100
>   #1: 0000000064c19280 (&of->mutex){+.+.}-{3:3}, at: kernfs_fop_write_iter+0x13a/0x270
>   #2: 0000000064c3d9e0 (kn->active#14){.+.+}-{0:0}, at: kernfs_fop_write_iter+0x149/0x270
>   #3: 00000000636b64c0 (&indio_dev->mlock){+.+.}-{3:3}, at: enable_store+0x4d/0x100
>   #4: 0000000064c945c8 (&iio_dev_opaque->info_exist_lock){+.+.}-{3:3}, at: iio_update_buffers+0x4f/0x180
> 
>  stack backtrace:
>  CPU: 0 PID: 23 Comm: python3 Not tainted 6.0.0-rc1+ #10
>  Call Trace:
>   dump_stack+0x1a/0x1c
>   __lock_acquire.cold+0x407/0x42d
>   lock_acquire+0x1ed/0x310
>   __mutex_lock+0x72/0xde0
>   mutex_lock_nested+0x1d/0x20
>   iio_update_buffers+0x62/0x180
>   iio_channel_start_all_cb+0x1c/0x20 [industrialio_buffer_cb]
>   lmp91000_buffer_postenable+0x1b/0x20 [lmp91000]
>   __iio_update_buffers+0x50b/0xd80
>   enable_store+0x81/0x100
>   dev_attr_store+0xf/0x20
>   sysfs_kf_write+0x4c/0x70
>   kernfs_fop_write_iter+0x179/0x270
>   new_sync_write+0x99/0x120
>   vfs_write+0x2c1/0x470
>   ksys_write+0x67/0x100
>   sys_write+0x10/0x20
> 
> Signed-off-by: Vincent Whitchurch <vincent.whitchurch@axis.com>

I'm wondering if this is sufficient.
At first glance there are a whole bunch of other possible cases of this.
Any consumer driver that calls iio_device_claim_direct_mode() would be a
problem - though I'm not sure any do?

I'm not sure I properly understand lockdep notations, but I thought the
point was we needed to define a hierarchy?  To do that here we need
an IIO driver that is a consumer to somehow let the IIO core know that
and mark all calls to the locks appropriately.  This gets trickier
as we allow 3+ levels of IIO drivers calling into each other.

We should also think about how to prevent recursion if there are 3
IIO drivers involved.

+CC Peter as most of the fun cases of IIO consumers were from him.

Perhaps this notation is a step in the right direction and we can
look for other problem cases later.  

One side note is that it's not immediately obvious that iio_update_buffers()
is called only from consumers (the other paths use __iio_update_buffers() directly
so if we make this change we should consider renaming that function or
at very least adding some documentation.

Jonathan

> ---
>  drivers/iio/industrialio-buffer.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/iio/industrialio-buffer.c b/drivers/iio/industrialio-buffer.c
> index acc2b6c05d57..27868ed092d0 100644
> --- a/drivers/iio/industrialio-buffer.c
> +++ b/drivers/iio/industrialio-buffer.c
> @@ -1255,7 +1255,7 @@ int iio_update_buffers(struct iio_dev *indio_dev,
>  		return -EINVAL;
>  
>  	mutex_lock(&iio_dev_opaque->info_exist_lock);
> -	mutex_lock(&indio_dev->mlock);
> +	mutex_lock_nested(&indio_dev->mlock, SINGLE_DEPTH_NESTING);
>  
>  	if (insert_buffer && iio_buffer_is_active(insert_buffer))
>  		insert_buffer = NULL;

