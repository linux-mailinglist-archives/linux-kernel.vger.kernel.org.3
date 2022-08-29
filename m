Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4EA675A40FE
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Aug 2022 04:14:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229504AbiH2COO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 28 Aug 2022 22:14:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53548 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229446AbiH2CON (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 28 Aug 2022 22:14:13 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 61F2E2F019
        for <linux-kernel@vger.kernel.org>; Sun, 28 Aug 2022 19:14:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1661739251;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=rM5zbaZYRZ9vm1GKLWu/oktNFyVDEDu0Q1Ep8JEXMfs=;
        b=O03xUDI/mRMpssjHMaqHcWbNObX3Qfcj98vPxYmiPIVKxeGYiurT1vQDrg8Oc4QC6JGYmM
        9vD9JXVUWZYUvoaT0pBEt+UlcDI2ITtNNWAvkXBt/4NeqxXFCyEfBlGHkaG3aJbBSNab2n
        TkeYVFxGST1aS/RZmsOrmzehlxfbhsQ=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-227-qsRXAeZfPRmYk2LBYW96eQ-1; Sun, 28 Aug 2022 22:14:06 -0400
X-MC-Unique: qsRXAeZfPRmYk2LBYW96eQ-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com [10.11.54.5])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id E33D13C02B77;
        Mon, 29 Aug 2022 02:14:05 +0000 (UTC)
Received: from T590 (ovpn-8-18.pek2.redhat.com [10.72.8.18])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 422829459C;
        Mon, 29 Aug 2022 02:14:01 +0000 (UTC)
Date:   Mon, 29 Aug 2022 10:13:58 +0800
From:   Ming Lei <ming.lei@redhat.com>
To:     ZiyangZhang <ZiyangZhang@linux.alibaba.com>
Cc:     axboe@kernel.dk, xiaoguang.wang@linux.alibaba.com,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        joseph.qi@linux.alibaba.com
Subject: Re: [RFC PATCH 1/9] ublk_drv: check 'current' instead of 'ubq_daemon'
Message-ID: <Ywwg5hCZSh0QQfYF@T590>
References: <20220824054744.77812-1-ZiyangZhang@linux.alibaba.com>
 <20220824054744.77812-2-ZiyangZhang@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220824054744.77812-2-ZiyangZhang@linux.alibaba.com>
X-Scanned-By: MIMEDefang 2.79 on 10.11.54.5
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 24, 2022 at 01:47:36PM +0800, ZiyangZhang wrote:
> This check is not atomic. So with recovery feature, ubq_daemon may be
> updated simultaneously by recovery task. Instead, check 'current' is
> safe here because 'current' never changes.
> 
> Also add comment explaining this check, which is really important for
> understanding recovery feature.
> 
> Signed-off-by: ZiyangZhang <ZiyangZhang@linux.alibaba.com>
> ---
>  drivers/block/ublk_drv.c | 12 ++++++++++--
>  1 file changed, 10 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/block/ublk_drv.c b/drivers/block/ublk_drv.c
> index 6a4a94b4cdf4..c39b67d7133d 100644
> --- a/drivers/block/ublk_drv.c
> +++ b/drivers/block/ublk_drv.c
> @@ -645,14 +645,22 @@ static inline void __ublk_rq_task_work(struct request *req)
>  	struct ublk_device *ub = ubq->dev;
>  	int tag = req->tag;
>  	struct ublk_io *io = &ubq->ios[tag];
> -	bool task_exiting = current != ubq->ubq_daemon || ubq_daemon_is_dying(ubq);
>  	unsigned int mapped_bytes;
>  
>  	pr_devel("%s: complete: op %d, qid %d tag %d io_flags %x addr %llx\n",
>  			__func__, io->cmd->cmd_op, ubq->q_id, req->tag, io->flags,
>  			ublk_get_iod(ubq, req->tag)->addr);
>  
> -	if (unlikely(task_exiting)) {
> +	/*
> +	 * Task is exiting if either:
> +	 *
> +	 * (1) current != ubq_daemon.
> +	 * io_uring_cmd_complete_in_task() tries to run task_work
> +	 * in a workqueue if ubq_daemon(cmd's task) is PF_EXITING.
> +	 *
> +	 * (2) current->flags & PF_EXITING.
> +	 */
> +	if (unlikely(current != ubq->ubq_daemon || current->flags & PF_EXITING)) {

Reviewed-by: Ming Lei <ming.lei@redhat.com>


Thanks,
Ming

