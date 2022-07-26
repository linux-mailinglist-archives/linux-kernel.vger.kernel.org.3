Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 862C9580A52
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Jul 2022 06:21:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231236AbiGZEVh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Jul 2022 00:21:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35846 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229852AbiGZEVf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Jul 2022 00:21:35 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 8FAF924BCF
        for <linux-kernel@vger.kernel.org>; Mon, 25 Jul 2022 21:21:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1658809292;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Vozal9Eu1i70NCpSRKE6fRuasNJPAr2zUeKK0YEFUFU=;
        b=V2hbBJwp38TR/S6VA9sh9d9Zvuf5eaBy7jA5BENNaIiZvoEHsdKXhB7kRfa8l03Aqf2PAh
        OGU6ECHruwa/RsPHeVk3v00F9mk+rtOgKPS4YY/UlRlQufC8Z2k15EO1K3NvZzmPYKPuAW
        MI9lx6/pAGTk4L0GNvt+h7l35FNwMQ8=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-443-EdLU_uJYOAuBIAwHEL3kVQ-1; Tue, 26 Jul 2022 00:21:28 -0400
X-MC-Unique: EdLU_uJYOAuBIAwHEL3kVQ-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com [10.11.54.5])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 3CA2E38025E1;
        Tue, 26 Jul 2022 04:21:27 +0000 (UTC)
Received: from T590 (ovpn-8-27.pek2.redhat.com [10.72.8.27])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 9168794561;
        Tue, 26 Jul 2022 04:21:09 +0000 (UTC)
Date:   Tue, 26 Jul 2022 12:21:00 +0800
From:   Ming Lei <ming.lei@redhat.com>
To:     Yu Kuai <yukuai1@huaweicloud.com>
Cc:     axboe@kernel.dk, osandov@fb.com, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, yukuai3@huawei.com,
        yi.zhang@huawei.com
Subject: Re: [PATCH v2] blk-mq: fix io hung due to missing commit_rqs
Message-ID: <Yt9rrL62zW2orGys@T590>
References: <20220726033519.4002586-1-yukuai1@huaweicloud.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220726033519.4002586-1-yukuai1@huaweicloud.com>
X-Scanned-By: MIMEDefang 2.79 on 10.11.54.5
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 26, 2022 at 11:35:19AM +0800, Yu Kuai wrote:
> From: Yu Kuai <yukuai3@huawei.com>
> 
> Currently, in virtio_scsi, if 'bd->last' is not set to true while
> dispatching request, such io will stay in driver's queue, and driver
> will wait for block layer to dispatch more rqs. However, if block
> layer failed to dispatch more rq, it should trigger commit_rqs to
> inform driver.
> 
> There is a problem in blk_mq_try_issue_list_directly() that commit_rqs
> won't be called:
> 
> // assume that queue_depth is set to 1, list contains two rq
> blk_mq_try_issue_list_directly
>  blk_mq_request_issue_directly
>  // dispatch first rq
>  // last is false
>   __blk_mq_try_issue_directly
>    blk_mq_get_dispatch_budget
>    // succeed to get first budget
>    __blk_mq_issue_directly
>     scsi_queue_rq
>      cmd->flags |= SCMD_LAST
>       virtscsi_queuecommand
>        kick = (sc->flags & SCMD_LAST) != 0
>        // kick is false, first rq won't issue to disk
>  queued++
> 
>  blk_mq_request_issue_directly
>  // dispatch second rq
>   __blk_mq_try_issue_directly
>    blk_mq_get_dispatch_budget
>    // failed to get second budget
>  ret == BLK_STS_RESOURCE
>   blk_mq_request_bypass_insert
>  // errors is still 0
> 
>  if (!list_empty(list) || errors && ...)
>   // won't pass, commit_rqs won't be called
> 
> In this situation, first rq relied on second rq to dispatch, while
> second rq relied on first rq to complete, thus they will both hung.
> And same problem exists in blk_mq_dispatch_rq_list()
> 
> Fix the problem by also treat 'BLK_STS_*RESOURCE' as 'errors' since
> it means that request is not queued successfully.
> 
> Fixes: d666ba98f849 ("blk-mq: add mq_ops->commit_rqs()")
> Signed-off-by: Yu Kuai <yukuai3@huawei.com>
> ---
> Changes in v2:
>  - suggested by Ming, handle blk_mq_dispatch_rq_list() as well.
>  - change title and modify commit message.
> 
>  block/blk-mq.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/block/blk-mq.c b/block/blk-mq.c
> index 70177ee74295..ee1e065fe63f 100644
> --- a/block/blk-mq.c
> +++ b/block/blk-mq.c
> @@ -1909,6 +1909,7 @@ bool blk_mq_dispatch_rq_list(struct blk_mq_hw_ctx *hctx, struct list_head *list,
>  			fallthrough;
>  		case BLK_STS_DEV_RESOURCE:
>  			blk_mq_handle_dev_resource(rq, list);
> +			errors++;
>  			goto out;
>  		case BLK_STS_ZONE_RESOURCE:
>  			/*
> @@ -1918,6 +1919,7 @@ bool blk_mq_dispatch_rq_list(struct blk_mq_hw_ctx *hctx, struct list_head *list,
>  			 */
>  			blk_mq_handle_zone_resource(rq, &zone_list);
>  			needs_resource = true;
> +			errors++;

But accounting error here may break return value of
blk_mq_dispatch_rq_list(), see:

/* Returns true if we did some work AND can potentially do more. */


thanks,
Ming

