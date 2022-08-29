Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A6A495A4133
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Aug 2022 05:01:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229538AbiH2DBb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 28 Aug 2022 23:01:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34552 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229668AbiH2DBY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 28 Aug 2022 23:01:24 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E78CA3D58D
        for <linux-kernel@vger.kernel.org>; Sun, 28 Aug 2022 20:01:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1661742083;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=J3eYJm2AtdKAUutUhamGeD2WJMAiL0MgHbUn5Jwkdx4=;
        b=JIOTRJry34y/PCAYw/ZyvgdsC2siIM0nIxumieq1Di3CdvjfNzbuWHJsKyepLFfFPN2sFA
        6UYSh58LK+zxOAUCZXhta1o3+VMl6nlCLX1Zign1IIQPkuBdvaSC0UV8swjlSR2CTW5TEK
        VdHw4swCPDfxBJhsJhv/bTyhSx20t2o=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-307-Ob_JffuqOqiPVcKJZWhIjw-1; Sun, 28 Aug 2022 23:01:19 -0400
X-MC-Unique: Ob_JffuqOqiPVcKJZWhIjw-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com [10.11.54.6])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 24EDD3C11059;
        Mon, 29 Aug 2022 03:01:19 +0000 (UTC)
Received: from T590 (ovpn-8-18.pek2.redhat.com [10.72.8.18])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 195F62166B26;
        Mon, 29 Aug 2022 03:01:14 +0000 (UTC)
Date:   Mon, 29 Aug 2022 11:01:11 +0800
From:   Ming Lei <ming.lei@redhat.com>
To:     ZiyangZhang <ZiyangZhang@linux.alibaba.com>
Cc:     axboe@kernel.dk, xiaoguang.wang@linux.alibaba.com,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        joseph.qi@linux.alibaba.com
Subject: Re: [RFC PATCH 2/9] ublk_drv: refactor ublk_cancel_queue()
Message-ID: <Ywwr9wWI4Hf06fMD@T590>
References: <20220824054744.77812-1-ZiyangZhang@linux.alibaba.com>
 <20220824054744.77812-3-ZiyangZhang@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220824054744.77812-3-ZiyangZhang@linux.alibaba.com>
X-Scanned-By: MIMEDefang 2.78 on 10.11.54.6
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 24, 2022 at 01:47:37PM +0800, ZiyangZhang wrote:
> Assume only a few FETCH_REQ ioucmds are sent to ublk_drv, then the
> ubq_daemon exits, We have to call io_uring_cmd_done() for all ioucmds
> received so that io_uring ctx will not leak.
> 
> ublk_cancel_queue() may be called before START_DEV or after STOP_DEV,
> we decrease ubq->nr_io_ready and clear UBLK_IO_FLAG_ACTIVE so that we
> won't call io_uring_cmd_done() twice for one ioucmd to avoid UAF. Also
> clearing UBLK_IO_FLAG_ACTIVE makes the code more reasonable.
> 
> Signed-off-by: ZiyangZhang <ZiyangZhang@linux.alibaba.com>
> ---
>  drivers/block/ublk_drv.c | 11 ++++++++---
>  1 file changed, 8 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/block/ublk_drv.c b/drivers/block/ublk_drv.c
> index c39b67d7133d..e08f636b0b9d 100644
> --- a/drivers/block/ublk_drv.c
> +++ b/drivers/block/ublk_drv.c
> @@ -967,18 +967,23 @@ static void ublk_cancel_queue(struct ublk_queue *ubq)
>  {
>  	int i;
>  
> -	if (!ublk_queue_ready(ubq))
> +	if (!ubq->nr_io_ready)
>  		return;
>  
>  	for (i = 0; i < ubq->q_depth; i++) {
>  		struct ublk_io *io = &ubq->ios[i];
>  
> -		if (io->flags & UBLK_IO_FLAG_ACTIVE)
> +		if (io->flags & UBLK_IO_FLAG_ACTIVE) {
> +			pr_devel("%s: done old cmd: qid %d tag %d\n",
> +					__func__, ubq->q_id, i);
>  			io_uring_cmd_done(io->cmd, UBLK_IO_RES_ABORT, 0);
> +			io->flags &= ~UBLK_IO_FLAG_ACTIVE;
> +			ubq->nr_io_ready--;
> +		}
>  	}
>  
>  	/* all io commands are canceled */
> -	ubq->nr_io_ready = 0;
> +	WARN_ON_ONCE(ubq->nr_io_ready);

The change looks fine, but suggest to add comment like the
following given the above WARN_ON_ONCE() change isn't obvious.

```
1) ublk_cancel_dev() is called before sending START_DEV(), ->mutex
provides protection on above update.

2) ublk_cancel_dev() is called after sending START_DEV(), disk is
deleted first, UBLK_IO_RES_ABORT is returned so that any new io
command can't be issued to driver, so updating on io flags and
nr_io_ready is safe here

Also ->nr_io_ready is guaranteed to become zero after ublk_cance_queue
returns since request queue is either frozen or not present in both two cases.

```


Thanks,
Ming

