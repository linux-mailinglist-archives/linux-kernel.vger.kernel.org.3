Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 09F6A581DEE
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Jul 2022 05:09:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240090AbiG0DJE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Jul 2022 23:09:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40618 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239918AbiG0DIz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Jul 2022 23:08:55 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id E0F7C3C8DF
        for <linux-kernel@vger.kernel.org>; Tue, 26 Jul 2022 20:08:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1658891333;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=32axq/VfQhSlDfqHI2UD/a9LuuHQ/A3908wmtNoQ7lo=;
        b=SlPFIdOefoa2ZV5E9vOI/11EMbtwoZWUwzKS0DwD4zx7zs2xNDG0ZoW/UAEmbC6oEgfydK
        Bc5r+qHcomtdnwCmQVDWXoihM9ebAkWZjB0V8ASPDaIHh0e++gIFJVJ/6AWcuLTCnf52op
        oxz4osYGHfKs8dW+QJ/WRErEvUqlYoQ=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-231-3z542prMMcGtTLhGBYgXgg-1; Tue, 26 Jul 2022 23:08:48 -0400
X-MC-Unique: 3z542prMMcGtTLhGBYgXgg-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.rdu2.redhat.com [10.11.54.8])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 2CDAF85A581;
        Wed, 27 Jul 2022 03:08:48 +0000 (UTC)
Received: from T590 (ovpn-8-20.pek2.redhat.com [10.72.8.20])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id E9F87C15D4F;
        Wed, 27 Jul 2022 03:08:43 +0000 (UTC)
Date:   Wed, 27 Jul 2022 11:08:38 +0800
From:   Ming Lei <ming.lei@redhat.com>
To:     Yu Kuai <yukuai1@huaweicloud.com>
Cc:     axboe@kernel.dk, osandov@fb.com, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, yukuai3@huawei.com,
        yi.zhang@huawei.com
Subject: Re: [PATCH v3] blk-mq: fix io hung due to missing commit_rqs
Message-ID: <YuCsNuVuVppgn9FL@T590>
References: <20220726122224.1790882-1-yukuai1@huaweicloud.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220726122224.1790882-1-yukuai1@huaweicloud.com>
X-Scanned-By: MIMEDefang 2.85 on 10.11.54.8
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 26, 2022 at 08:22:24PM +0800, Yu Kuai wrote:
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
> 
> Fix the problem by also treat 'BLK_STS_*RESOURCE' as 'errors' since
> it means that request is not queued successfully.
> 
> Same problem exists in blk_mq_dispatch_rq_list(), 'BLK_STS_*RESOURCE'
> can't be treated as 'errors' here, fix the problem by calling
> commit_rqs if queue_rq return 'BLK_STS_*RESOURCE'.
> 
> Fixes: d666ba98f849 ("blk-mq: add mq_ops->commit_rqs()")
> Signed-off-by: Yu Kuai <yukuai3@huawei.com>

Reviewed-by: Ming Lei <ming.lei@redhat.com>

Thanks,
Ming

