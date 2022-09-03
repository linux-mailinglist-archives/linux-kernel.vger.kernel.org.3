Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ADDD15ABEB9
	for <lists+linux-kernel@lfdr.de>; Sat,  3 Sep 2022 13:19:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230229AbiICLTC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 3 Sep 2022 07:19:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42686 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229586AbiICLS7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 3 Sep 2022 07:18:59 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 19A5F7CAAD
        for <linux-kernel@vger.kernel.org>; Sat,  3 Sep 2022 04:18:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1662203937;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=WVDVVWLcyoS66ybhgFS8BXSJnOHhZUbQUeCNcx7RrB4=;
        b=ezUX+wiKWgf+tZlhXuEc7jzGPeuDIj78wl+Z76hmV/ARQTMMg0ejfCrBeT0z5uztlvr+qX
        RTOUQ5UopbQufS19eZnFJ/FHh/u3juKjna3zCB8ktYYrEMa045kGXTW01V/b8LRfuhUjBN
        bDlpKNzIXGF2PKEefVm1t1/ZgnOPZjI=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-587-puFBncOuNquK3TCf8cwGpQ-1; Sat, 03 Sep 2022 07:18:54 -0400
X-MC-Unique: puFBncOuNquK3TCf8cwGpQ-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.rdu2.redhat.com [10.11.54.7])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 8010580418F;
        Sat,  3 Sep 2022 11:18:53 +0000 (UTC)
Received: from T590 (ovpn-8-16.pek2.redhat.com [10.72.8.16])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 7D04F14152E0;
        Sat,  3 Sep 2022 11:18:48 +0000 (UTC)
Date:   Sat, 3 Sep 2022 19:18:49 +0800
From:   Ming Lei <ming.lei@redhat.com>
To:     ZiyangZhang <ZiyangZhang@linux.alibaba.com>
Cc:     axboe@kernel.dk, xiaoguang.wang@linux.alibaba.com,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        joseph.qi@linux.alibaba.com
Subject: Re: [RFC PATCH V2 3/6] ublk_drv: define macros for recovery feature
 and check them
Message-ID: <YxM4GWrl0Rlrswz3@T590>
References: <20220831155136.23434-1-ZiyangZhang@linux.alibaba.com>
 <20220831155136.23434-4-ZiyangZhang@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220831155136.23434-4-ZiyangZhang@linux.alibaba.com>
X-Scanned-By: MIMEDefang 2.85 on 10.11.54.7
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 31, 2022 at 11:51:33PM +0800, ZiyangZhang wrote:
> Define some macros for recovery feature. Especially define a new state:
> UBLK_S_DEV_RECOVERING which implies the ublk_device is recovering.
> 
> UBLK_F_USER_RECOVERY implies that:
> (1) ublk_drv enables recovery feature. It won't let monitor_work to
>     automatically abort rqs and release the device. Instead, it waits
> 	for user's START_USER_RECOVERY ctrl-cmd.
> 
> (2) In monitor_work after a crash, ublk_drv ends(aborts) rqs issued to
>     userspace(ublksrv) before crash.
> 
> (3) In task work and ublk_queue_rq() after a crash, ublk_drv requeues
>     rqs dispatched after crash.
> 
> UBLK_F_USER_RECOVERY_REISSUE implies that:
> (1) everything UBLK_F_USER_RECOVERY implies except
> (2) ublk_drv requeues rqs issued to userspace(ublksrv) before crash.
> 
> UBLK_F_USER_RECOVERY_REISSUE is designed for backends which:
> (1) tolerate double-writes because we may issue the same rq twice.
> (2) cannot let frontend users get I/O error, such as a RDONLY system.
> 
> Signed-off-by: ZiyangZhang <ZiyangZhang@linux.alibaba.com>
> ---
>  drivers/block/ublk_drv.c      | 31 ++++++++++++++++++++++++++++++-
>  include/uapi/linux/ublk_cmd.h |  7 +++++++
>  2 files changed, 37 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/block/ublk_drv.c b/drivers/block/ublk_drv.c
> index 0c6db0978ed0..0c3d32e8d686 100644
> --- a/drivers/block/ublk_drv.c
> +++ b/drivers/block/ublk_drv.c
> @@ -49,7 +49,9 @@
>  /* All UBLK_F_* have to be included into UBLK_F_ALL */
>  #define UBLK_F_ALL (UBLK_F_SUPPORT_ZERO_COPY \
>  		| UBLK_F_URING_CMD_COMP_IN_TASK \
> -		| UBLK_F_NEED_GET_DATA)
> +		| UBLK_F_NEED_GET_DATA \
> +		| UBLK_F_USER_RECOVERY \
> +		| UBLK_F_USER_RECOVERY_REISSUE)
>  
>  /* All UBLK_PARAM_TYPE_* should be included here */
>  #define UBLK_PARAM_TYPE_ALL (UBLK_PARAM_TYPE_BASIC | UBLK_PARAM_TYPE_DISCARD)
> @@ -323,6 +325,33 @@ static inline int ublk_queue_cmd_buf_size(struct ublk_device *ub, int q_id)
>  			PAGE_SIZE);
>  }
>  
> +/*
> + * TODO: UBLK_F_USER_RECOVERY should be a flag for device, not for queue,
> + * since "some queues are aborted while others are recoverd" is really weird.
> + */
> +static inline bool ublk_can_use_recovery(struct ublk_device *ub)
> +{
> +	struct ublk_queue *ubq = ublk_get_queue(ub, 0);

This way is too tricky, just wondering why you don't passe ubq to
ublk_can_use_recovery()?

Thanks,
Ming

