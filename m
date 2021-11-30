Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C929E462D53
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Nov 2021 08:10:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238981AbhK3HNP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Nov 2021 02:13:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37520 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234559AbhK3HNO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Nov 2021 02:13:14 -0500
Received: from sin.source.kernel.org (sin.source.kernel.org [IPv6:2604:1380:40e1:4800::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E97CC061574;
        Mon, 29 Nov 2021 23:09:55 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id BF03ACE1814;
        Tue, 30 Nov 2021 07:09:52 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2DACBC53FC1;
        Tue, 30 Nov 2021 07:09:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1638256190;
        bh=kLuGWOj0/CeNyazjZ0443VRhbHXKaiSe5ZXsMM3dZ+Q=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=KTkyqgZnTc7ZIL5IAI7yvIO9d3CjLkYX8CTok2BgGUg/ZKUO0qud2UQfhdqJ1l2Gn
         zuoylXn5MHW31XyIkUSx6K8+MBEyvEAn/3qHEWtz8JvSAS8FpFsffMNF6+YI6kgOdw
         t1ka0Df/7ZmeS6YJCG7JsbvI8nNMzdWi1xgx7+xE=
Date:   Tue, 30 Nov 2021 08:09:45 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Eric Biggers <ebiggers@kernel.org>
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-api@vger.kernel.org, linux-scsi@vger.kernel.org,
        linux-mmc@vger.kernel.org, Bart Van Assche <bvanassche@acm.org>
Subject: Re: [PATCH v2 2/3] block: don't delete queue kobject before its
 children
Message-ID: <YaXOOcoMZb0fymVX@kroah.com>
References: <20211130040306.148925-1-ebiggers@kernel.org>
 <20211130040306.148925-3-ebiggers@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211130040306.148925-3-ebiggers@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 29, 2021 at 08:03:05PM -0800, Eric Biggers wrote:
> From: Eric Biggers <ebiggers@google.com>
> 
> kobjects aren't supposed to be deleted before their child kobjects are
> deleted.  Apparently this is usually benign; however, a WARN will be
> triggered if one of the child kobjects has a named attribute group:
> 
>     sysfs group 'modes' not found for kobject 'crypto'
>     WARNING: CPU: 0 PID: 1 at fs/sysfs/group.c:278 sysfs_remove_group+0x72/0x80
>     ...
>     Call Trace:
>       sysfs_remove_groups+0x29/0x40 fs/sysfs/group.c:312
>       __kobject_del+0x20/0x80 lib/kobject.c:611
>       kobject_cleanup+0xa4/0x140 lib/kobject.c:696
>       kobject_release lib/kobject.c:736 [inline]
>       kref_put include/linux/kref.h:65 [inline]
>       kobject_put+0x53/0x70 lib/kobject.c:753
>       blk_crypto_sysfs_unregister+0x10/0x20 block/blk-crypto-sysfs.c:159
>       blk_unregister_queue+0xb0/0x110 block/blk-sysfs.c:962
>       del_gendisk+0x117/0x250 block/genhd.c:610
> 
> Fix this by moving the kobject_del() and the corresponding
> kobject_uevent() to the correct place.
> 
> Fixes: 2c2086afc2b8 ("block: Protect less code with sysfs_lock in blk_{un,}register_queue()")
> Signed-off-by: Eric Biggers <ebiggers@google.com>
> ---
>  block/blk-sysfs.c | 8 +++++---
>  1 file changed, 5 insertions(+), 3 deletions(-)
> 
> diff --git a/block/blk-sysfs.c b/block/blk-sysfs.c
> index 91d3805a6ec6b..1368dfe3ee500 100644
> --- a/block/blk-sysfs.c
> +++ b/block/blk-sysfs.c
> @@ -951,15 +951,17 @@ void blk_unregister_queue(struct gendisk *disk)
>  	 */
>  	if (queue_is_mq(q))
>  		blk_mq_unregister_dev(disk_to_dev(disk), q);
> -
> -	kobject_uevent(&q->kobj, KOBJ_REMOVE);
> -	kobject_del(&q->kobj);
>  	blk_trace_remove_sysfs(disk_to_dev(disk));
>  
>  	mutex_lock(&q->sysfs_lock);
>  	elv_unregister_queue(q);
>  	disk_unregister_independent_access_ranges(disk);
>  	mutex_unlock(&q->sysfs_lock);
> +
> +	/* Now that all child objects were deleted, the queue can be deleted. */
> +	kobject_uevent(&q->kobj, KOBJ_REMOVE);
> +	kobject_del(&q->kobj);
> +
>  	mutex_unlock(&q->sysfs_dir_lock);
>  
>  	kobject_put(&disk_to_dev(disk)->kobj);
> -- 
> 2.34.1
> 

Reviewed-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
