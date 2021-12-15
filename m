Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 46B0F47510A
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Dec 2021 03:43:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239263AbhLOCnF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Dec 2021 21:43:05 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:24338 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229492AbhLOCnF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Dec 2021 21:43:05 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1639536184;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=8DLlsO41QigibH8PvgeywfW84g0cBYW6u/y7bzR2aBw=;
        b=CVjbRpWUN0IN+FrMsHmYXpn2qUKN9LmR0XimBzmk42jt0cH0b/+9Mj5h8tfampQcDa/mVr
        GhAw7zZAvuwrMNBUCmlubh7lz6+nlfOtFxci3hg6GMwEmqlCVQeEanQh43DH4L8NMiY5Tu
        aUYbuIsnUVMUskpJU2o4PdsGt3hBvtw=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-368-CfEYZmnFMTmwPcZeZP2xcg-1; Tue, 14 Dec 2021 21:43:03 -0500
X-MC-Unique: CfEYZmnFMTmwPcZeZP2xcg-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id E0656801AAB;
        Wed, 15 Dec 2021 02:43:01 +0000 (UTC)
Received: from T590 (ovpn-8-24.pek2.redhat.com [10.72.8.24])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id A57BE752C9;
        Wed, 15 Dec 2021 02:42:41 +0000 (UTC)
Date:   Wed, 15 Dec 2021 10:42:37 +0800
From:   Ming Lei <ming.lei@redhat.com>
To:     Laibin Qiu <qiulaibin@huawei.com>
Cc:     hch@infradead.org, axboe@kernel.dk, yi.zhang@huawei.com,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 -next] block/wbt: fix negative inflight counter when
 remove scsi device
Message-ID: <YblWHXkMU56gG8fT@T590>
References: <20211214133103.551813-1-qiulaibin@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211214133103.551813-1-qiulaibin@huawei.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 14, 2021 at 09:31:03PM +0800, Laibin Qiu wrote:
> Now that we disable wbt by set WBT_STATE_OFF_DEFAULT in
> wbt_disable_default() when switch elevator to bfq. And when
> we remove scsi device, wbt will be enabled by wbt_enable_default.
> If it become false positive between wbt_wait() and wbt_track()
> when submit write request.
> 
> The following is the scenario that triggered the problem.
> 
> T1                          T2                           T3
>                             elevator_switch_mq
>                             bfq_init_queue
>                             wbt_disable_default <= Set
>                             rwb->enable_state (OFF)
> Submit_bio
> blk_mq_make_request
> rq_qos_throttle
> <= rwb->enable_state (OFF)
>                                                          scsi_remove_device
>                                                          sd_remove
>                                                          del_gendisk
>                                                          blk_unregister_queue
>                                                          elv_unregister_queue
>                                                          wbt_enable_default
>                                                          <= Set rwb->enable_state (ON)
> q_qos_track
> <= rwb->enable_state (ON)
> ^^^^^^ this request will mark WBT_TRACKED without inflight add and will
> lead to drop rqw->inflight to -1 in wbt_done() which will trigger IO hung.
> 
> Fix this by move wbt_enable_default() from elv_unregister to
> bfq_exit_queue(). Only re-enable wbt when bfq exit.
> Fixes: 76a8040817b4b ("blk-wbt: make sure throttle is enabled properly")
> Signed-off-by: Laibin Qiu <qiulaibin@huawei.com>
> ---
>  block/bfq-iosched.c | 4 ++++
>  block/elevator.c    | 2 --
>  2 files changed, 4 insertions(+), 2 deletions(-)
> 
> diff --git a/block/bfq-iosched.c b/block/bfq-iosched.c
> index 0c612a911696..8b7524450835 100644
> --- a/block/bfq-iosched.c
> +++ b/block/bfq-iosched.c
> @@ -6996,6 +6996,7 @@ static void bfq_exit_queue(struct elevator_queue *e)
>  {
>  	struct bfq_data *bfqd = e->elevator_data;
>  	struct bfq_queue *bfqq, *n;
> +	struct request_queue *q = bfqd->queue;
>  
>  	hrtimer_cancel(&bfqd->idle_slice_timer);
>  
> @@ -7019,6 +7020,9 @@ static void bfq_exit_queue(struct elevator_queue *e)
>  #endif
>  
>  	kfree(bfqd);
> +
> +	/* Re-enable throttling in case elevator disabled it */

Of course, bfq has disabled it, so the above comment is useless,
otherwise looks fine:

Reviewed-by: Ming Lei <ming.lei@rehdat.com>


Thanks,
Ming

