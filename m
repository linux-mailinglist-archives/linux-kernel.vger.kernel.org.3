Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5B7D14742DA
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Dec 2021 13:45:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234103AbhLNMpO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Dec 2021 07:45:14 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124]:48996 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230205AbhLNMpN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Dec 2021 07:45:13 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1639485910;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=OfSTdXewr1tEYxhAcGt8qlA6H3QKfJBMook+w/8QwBw=;
        b=f6ZMpgBM0PFCxTx/2ZtYIEC6BbFAXAWwX/PKPApd6RbLHvpI0XVdLCTThgLQgE3BHyHixE
        kwurYfDhYynRy5fuMPLzQcYuaitJyhOr/kUqkXLJE1nz8yDhUg2IfxwFxTjhu2bKfwLoFC
        Qp0lm/T+rAsuv5aqEMUwNFQMoznOFqU=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-155-dRvsGNXPO6mBbaefWZ0prw-1; Tue, 14 Dec 2021 07:45:07 -0500
X-MC-Unique: dRvsGNXPO6mBbaefWZ0prw-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 2B56581CCB4;
        Tue, 14 Dec 2021 12:45:06 +0000 (UTC)
Received: from T590 (ovpn-8-24.pek2.redhat.com [10.72.8.24])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 70B64418E;
        Tue, 14 Dec 2021 12:44:48 +0000 (UTC)
Date:   Tue, 14 Dec 2021 20:44:43 +0800
From:   Ming Lei <ming.lei@redhat.com>
To:     Laibin Qiu <qiulaibin@huawei.com>
Cc:     hch@infradead.org, axboe@kernel.dk, yi.zhang@huawei.com,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 -next] block/wbt: fix negative inflight counter when
 remove scsi device
Message-ID: <YbiRu3+FCiRvoIh8@T590>
References: <20211214044259.2656456-1-qiulaibin@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211214044259.2656456-1-qiulaibin@huawei.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 14, 2021 at 12:42:59PM +0800, Laibin Qiu wrote:
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
> elevator_switch_mq. Only re-enable wbt when scheduler switch.
> Fixes: 76a8040817b4b ("blk-wbt: make sure throttle is enabled properly")
> Signed-off-by: Laibin Qiu <qiulaibin@huawei.com>
> ---
>  block/elevator.c | 7 ++++---
>  1 file changed, 4 insertions(+), 3 deletions(-)
> 
> diff --git a/block/elevator.c b/block/elevator.c
> index ec98aed39c4f..de3cf1fa52fa 100644
> --- a/block/elevator.c
> +++ b/block/elevator.c
> @@ -525,8 +525,6 @@ void elv_unregister_queue(struct request_queue *q)
>  		kobject_del(&e->kobj);
>  
>  		e->registered = 0;
> -		/* Re-enable throttling in case elevator disabled it */
> -		wbt_enable_default(q);
>  	}
>  }
>  
> @@ -593,8 +591,11 @@ int elevator_switch_mq(struct request_queue *q,
>  	lockdep_assert_held(&q->sysfs_lock);
>  
>  	if (q->elevator) {
> -		if (q->elevator->registered)
> +		if (q->elevator->registered) {
>  			elv_unregister_queue(q);
> +			/* Re-enable throttling in case elevator disabled it */
> +			wbt_enable_default(q);
> +		}

Please move wbt_enable_default() into bfq_exit_queue(), which should
be easier to follow and fix the issue too given only bfq disables wbt.


Thanks,
Ming

