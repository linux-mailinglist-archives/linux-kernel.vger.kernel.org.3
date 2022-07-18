Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7FBD6577CB5
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Jul 2022 09:41:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233897AbiGRHlU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Jul 2022 03:41:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34166 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233938AbiGRHlL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jul 2022 03:41:11 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 747A71839A
        for <linux-kernel@vger.kernel.org>; Mon, 18 Jul 2022 00:41:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1658130067;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=oKdMPXrj8I9jUtvQS8iR9eYzvkc+NAeBqfLrBKF5aXg=;
        b=ZWEORI9PAaf9Pg83MFsr9TRzOVq4zk8Y+cq3dLWo89PCTlhpPmVWGYS+gaQqzRJ2CjTtlT
        NJ4gc3JMAXWQQbkzb5xG/p+C9PuBkDCqb5bymUz+/t7s26oqtg5AW3M7EbO7psyOWEeswr
        sy3AXR9ScVCrsVtejGaQigqo5EeZqyM=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-638-5x8pIg-ENS2FB1j_UiaxOw-1; Mon, 18 Jul 2022 03:41:02 -0400
X-MC-Unique: 5x8pIg-ENS2FB1j_UiaxOw-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com [10.11.54.4])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 1414E85A585;
        Mon, 18 Jul 2022 07:41:02 +0000 (UTC)
Received: from T590 (ovpn-8-29.pek2.redhat.com [10.72.8.29])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 1C0FE2026D64;
        Mon, 18 Jul 2022 07:40:58 +0000 (UTC)
Date:   Mon, 18 Jul 2022 15:40:53 +0800
From:   Ming Lei <ming.lei@redhat.com>
To:     Yang Yingliang <yangyingliang@huawei.com>
Cc:     linux-kernel@vger.kernel.org, linux-block@vger.kernel.org,
        axboe@kernel.dk
Subject: Re: [PATCH -next] ublk_drv: fix missing error return code in
 ublk_add_dev()
Message-ID: <YtUOhUXBKG28bew4@T590>
References: <20220718042408.3132835-1-yangyingliang@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220718042408.3132835-1-yangyingliang@huawei.com>
X-Scanned-By: MIMEDefang 2.78 on 10.11.54.4
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 18, 2022 at 12:24:08PM +0800, Yang Yingliang wrote:
> If blk_mq_init_queue() fails, it should return error code in ublk_add_dev()
> 
> Fixes: cebbe577cb17 ("ublk_drv: fix request queue leak")
> Signed-off-by: Yang Yingliang <yangyingliang@huawei.com>
> ---
>  drivers/block/ublk_drv.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/block/ublk_drv.c b/drivers/block/ublk_drv.c
> index 52fd0af8a4f2..bea441782cb0 100644
> --- a/drivers/block/ublk_drv.c
> +++ b/drivers/block/ublk_drv.c
> @@ -1169,8 +1169,10 @@ static int ublk_add_dev(struct ublk_device *ub)
>  		goto out_deinit_queues;
>  
>  	ub->ub_queue = blk_mq_init_queue(&ub->tag_set);
> -	if (IS_ERR(ub->ub_queue))
> +	if (IS_ERR(ub->ub_queue)) {
> +		err = PTR_ERR(ub->ub_queue);
>  		goto out_cleanup_tags;
> +	}
>  	ub->ub_queue->queuedata = ub;
>  
>  	disk = ub->ub_disk = blk_mq_alloc_disk_for_queue(ub->ub_queue,

Reviewed-by: Ming Lei <ming.lei@redhat.com>


Thanks,
Ming

