Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F060A473A15
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Dec 2021 02:13:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242982AbhLNBNa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Dec 2021 20:13:30 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:20559 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S242920AbhLNBN3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Dec 2021 20:13:29 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1639444408;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=3gTydd0924G7zLLa9vjnpFZ/IS4FVbudD6kWOndvAx0=;
        b=TJQS5BKikq5gA6CJmDPEMH/GsYo/zpKLbiERc6qHygB4m6RVO8qixYvGKJ1hy+2yXRKC4c
        qY6RunSXy7x+j7+G0j3IHGG06rXEgl3GPcm/m0rx0k/dN2yNbyMSDk+3gvPdqqYL+qIPCx
        Qzm/xHUBiFzinFXp8+JQPUceoCavdCY=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-594-J6NPJEsFN1m1ojS5zJyYrQ-1; Mon, 13 Dec 2021 20:13:25 -0500
X-MC-Unique: J6NPJEsFN1m1ojS5zJyYrQ-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 2DE441006AA0;
        Tue, 14 Dec 2021 01:13:24 +0000 (UTC)
Received: from T590 (ovpn-8-18.pek2.redhat.com [10.72.8.18])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id DA4795F70B;
        Tue, 14 Dec 2021 01:13:14 +0000 (UTC)
Date:   Tue, 14 Dec 2021 09:13:10 +0800
From:   Ming Lei <ming.lei@redhat.com>
To:     Christoph Hellwig <hch@infradead.org>
Cc:     Laibin Qiu <qiulaibin@huawei.com>, axboe@kernel.dk,
        yi.zhang@huawei.com, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH -next] block/wbt: fix negative inflight counter when
 remove scsi device
Message-ID: <YbfvplNrBkuZUIyf@T590>
References: <20211213040907.2669480-1-qiulaibin@huawei.com>
 <YbeAAyWbkh5frMGc@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YbeAAyWbkh5frMGc@infradead.org>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 13, 2021 at 09:16:51AM -0800, Christoph Hellwig wrote:
> On Mon, Dec 13, 2021 at 12:09:07PM +0800, Laibin Qiu wrote:
> > Submit_bio
> >                                                          scsi_remove_device
> >                                                          sd_remove
> >                                                          del_gendisk
> >                                                          blk_unregister_queue
> >                                                          elv_unregister_queue
> >                                                          wbt_enable_default
> >                                                          <= Set rwb->enable_state (ON)
> > q_qos_track
> > <= rwb->enable_state (ON)
> > ^^^^^^ this request will mark WBT_TRACKED without inflight add and will
> > lead to drop rqw->inflight to -1 in wbt_done() which will trigger IO hung.
> > 
> > Fix this by judge whether QUEUE_FLAG_REGISTERED is marked to distinguish
> > scsi remove scene.
> > Fixes: 76a8040817b4b ("blk-wbt: make sure throttle is enabled properly")
> > Signed-off-by: Laibin Qiu <qiulaibin@huawei.com>
> > ---
> >  block/blk-wbt.c | 8 ++++----
> >  1 file changed, 4 insertions(+), 4 deletions(-)
> > 
> > diff --git a/block/blk-wbt.c b/block/blk-wbt.c
> > index 3ed71b8da887..537f77bb1365 100644
> > --- a/block/blk-wbt.c
> > +++ b/block/blk-wbt.c
> > @@ -637,6 +637,10 @@ void wbt_enable_default(struct request_queue *q)
> >  {
> >  	struct rq_qos *rqos = wbt_rq_qos(q);
> >  
> > +	/* Queue not registered? Maybe shutting down... */
> > +	if (!blk_queue_registered(q))
> > +		return;
> 
> Wouldn't it make more sense to simply not call wbt_enable_default from
> elv_unregister_queue?

wbt_disable_default() is called in bfq_init_root_group(), so wbt_enable_default
should be moved to bfq_exit_queue()?


Thanks,
Ming

