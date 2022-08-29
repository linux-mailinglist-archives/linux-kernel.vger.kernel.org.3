Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6CC375A414A
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Aug 2022 05:07:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229727AbiH2DHm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 28 Aug 2022 23:07:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39960 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229743AbiH2DHK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 28 Aug 2022 23:07:10 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3DA8B3DF19
        for <linux-kernel@vger.kernel.org>; Sun, 28 Aug 2022 20:07:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1661742429;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Db/ObBgPT0I5ltsCA8YROcuIZJ9I4YfuTZDGnkPg1TU=;
        b=P6aLjZ0Bvd0cmn0r2HbCAiUEaDj0NJBr977teqcVAGhC3/SAsISMNL5Hs0Yo00D0jhzOeq
        iLTBYJkiOYNrt+z1/6w3LuuLL25HWaG+qUdc6+xarIyZhrBmnIcJiVEo6blaZeqtYBQxdi
        f/jfEqqLGzTsUl7bHRsPdSoBHIcC+ns=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-382-QjFASFHYPYyFh2F6WRHltg-1; Sun, 28 Aug 2022 23:07:05 -0400
X-MC-Unique: QjFASFHYPYyFh2F6WRHltg-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.rdu2.redhat.com [10.11.54.8])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id AD104801231;
        Mon, 29 Aug 2022 03:07:04 +0000 (UTC)
Received: from T590 (ovpn-8-18.pek2.redhat.com [10.72.8.18])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 9F303C15BB3;
        Mon, 29 Aug 2022 03:07:00 +0000 (UTC)
Date:   Mon, 29 Aug 2022 11:06:57 +0800
From:   Ming Lei <ming.lei@redhat.com>
To:     ZiyangZhang <ZiyangZhang@linux.alibaba.com>
Cc:     axboe@kernel.dk, xiaoguang.wang@linux.alibaba.com,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        joseph.qi@linux.alibaba.com, ming.lei@redhat.com
Subject: Re: [RFC PATCH 3/9] ublk_drv: add a helper to get ioucmd from pdu
Message-ID: <YwwtUVl51B0ve0So@T590>
References: <20220824054744.77812-1-ZiyangZhang@linux.alibaba.com>
 <20220824054744.77812-4-ZiyangZhang@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220824054744.77812-4-ZiyangZhang@linux.alibaba.com>
X-Scanned-By: MIMEDefang 2.85 on 10.11.54.8
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 24, 2022 at 01:47:38PM +0800, ZiyangZhang wrote:
> We store pointer of task_work in pdu. And we should get ioucmd from pdu
> since we prepare to only pass ioucmd to task_work function.
> 
> Signed-off-by: ZiyangZhang <ZiyangZhang@linux.alibaba.com>
> ---
>  drivers/block/ublk_drv.c | 6 ++++++
>  1 file changed, 6 insertions(+)
> 
> diff --git a/drivers/block/ublk_drv.c b/drivers/block/ublk_drv.c
> index e08f636b0b9d..8add6e3ae15f 100644
> --- a/drivers/block/ublk_drv.c
> +++ b/drivers/block/ublk_drv.c
> @@ -555,6 +555,12 @@ static inline struct ublk_uring_cmd_pdu *ublk_get_uring_cmd_pdu(
>  	return (struct ublk_uring_cmd_pdu *)&ioucmd->pdu;
>  }
>  
> +static inline struct io_uring_cmd *ublk_uring_cmd_from_pdu(
> +			struct ublk_uring_cmd_pdu *pdu)
> +{
> +	return container_of((u8 *)pdu, struct io_uring_cmd, pdu[0]);
> +}
> +

Patch isn't supposed to be written in this way, it is one helper, either
change its caller in this patch, or merge this one wth the patch which
applies it.

Also looks this change belong to include/linux/io_uring.h if you think
it is useful.

thanks,
Ming

