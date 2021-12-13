Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ED5B04732C5
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Dec 2021 18:16:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241225AbhLMRQz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Dec 2021 12:16:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52404 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230392AbhLMRQy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Dec 2021 12:16:54 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C0DB1C06173F;
        Mon, 13 Dec 2021 09:16:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=tZCyYMCcvzwoBl6WCM6iizVFHmU1v3d/0fVDo5xA0Gw=; b=TuXzluuLb2pl8H0gZoc4uujyGL
        ey8uI9SEpDIThteOOBatmxMy6DBhSqZx5jgcmVRitntzibzRD2RaxS6JXUkNfToy/rRqxBKYFcA3E
        viazj54ue8qNIr3xBMflMe7da8AMb4UjauokybfB32yC6XO7AX8ek8O1bQMDj8xfXOOkF8PiN8TP/
        LHA8kcGhRyqs0Gx+D/n/CInFnvoua2SD8GkG3ijvUJGTTJ3Y/EHV62Uxmex/1LwnczXtTyOz+paWF
        WIU9JgvvnraW/H2sg5fOHdK2Fy7MiboJawm3ybrwgk1iTJMXnXVZcITy65QKLdfUaIHQaauebaOmm
        m0eLZacQ==;
Received: from hch by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mwowV-00Aofm-NF; Mon, 13 Dec 2021 17:16:51 +0000
Date:   Mon, 13 Dec 2021 09:16:51 -0800
From:   Christoph Hellwig <hch@infradead.org>
To:     Laibin Qiu <qiulaibin@huawei.com>
Cc:     axboe@kernel.dk, yi.zhang@huawei.com, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH -next] block/wbt: fix negative inflight counter when
 remove scsi device
Message-ID: <YbeAAyWbkh5frMGc@infradead.org>
References: <20211213040907.2669480-1-qiulaibin@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211213040907.2669480-1-qiulaibin@huawei.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 13, 2021 at 12:09:07PM +0800, Laibin Qiu wrote:
> Submit_bio
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
> Fix this by judge whether QUEUE_FLAG_REGISTERED is marked to distinguish
> scsi remove scene.
> Fixes: 76a8040817b4b ("blk-wbt: make sure throttle is enabled properly")
> Signed-off-by: Laibin Qiu <qiulaibin@huawei.com>
> ---
>  block/blk-wbt.c | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/block/blk-wbt.c b/block/blk-wbt.c
> index 3ed71b8da887..537f77bb1365 100644
> --- a/block/blk-wbt.c
> +++ b/block/blk-wbt.c
> @@ -637,6 +637,10 @@ void wbt_enable_default(struct request_queue *q)
>  {
>  	struct rq_qos *rqos = wbt_rq_qos(q);
>  
> +	/* Queue not registered? Maybe shutting down... */
> +	if (!blk_queue_registered(q))
> +		return;

Wouldn't it make more sense to simply not call wbt_enable_default from
elv_unregister_queue?
