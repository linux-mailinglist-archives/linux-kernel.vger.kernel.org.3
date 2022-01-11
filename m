Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 40C2048AAF3
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jan 2022 10:58:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237421AbiAKJ6P (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Jan 2022 04:58:15 -0500
Received: from ewsoutbound.kpnmail.nl ([195.121.94.167]:35447 "EHLO
        ewsoutbound.kpnmail.nl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237046AbiAKJ6M (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Jan 2022 04:58:12 -0500
X-KPN-MessageId: e6ac5070-72c4-11ec-9a2e-005056abbe64
Received: from smtp.kpnmail.nl (unknown [10.31.155.38])
        by ewsoutbound.so.kpn.org (Halon) with ESMTPS
        id e6ac5070-72c4-11ec-9a2e-005056abbe64;
        Tue, 11 Jan 2022 10:57:35 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=xs4all.nl; s=xs4all01;
        h=content-type:from:to:subject:mime-version:date:message-id;
        bh=jo6b7F0s56P5whxkE0nVB9Lu6HPIV5nff044lDrbMHw=;
        b=qShTBxdKKkYe8pW5zNwLfJNR91BviYblHUpIfsDn6AziZDvtuwMf+gV/FwE0zyW+LPbxq4abd7dg1
         EGrduDC/9pwsEUkV6tSR3/xFSGvmwVfZjenBKo9pdEVdfJPCnTh37LgeVWh43oFNlUoz9vHBH/OnfY
         bK028ITchkyEY5cjhgAhKcqGFcejFzJtbqFUzPLyVlZ3JHYppd8Q/tSQ9DbddO/WvWMk9WOl5c6yQl
         JnzVyOBZX+YocVb5mZ7i9Eo5TLsS4Iv5QkKC3r5gZdzbmlzlmeiQS3+3apSfztp6jJ2ujOJlv0lJjb
         Cc5kkV+/NTUdrrHwRDouBstkq6jFLzg==
X-KPN-VerifiedSender: Yes
X-CMASSUN: 33|PkIO3M7ubySwyEWU2rcIR5NS34PjDje/MsJXDmzBZ3SD39S/lWby54vF8bH7FHy
 Bmycr+zEGRvdOIUAwgKZZTA==
X-Originating-IP: 193.91.129.219
Received: from [192.168.2.10] (cdb815bc1.dhcp.as2116.net [193.91.129.219])
        by smtp.xs4all.nl (Halon) with ESMTPSA
        id fc28e89e-72c4-11ec-94d2-005056abf0db;
        Tue, 11 Jan 2022 10:58:11 +0100 (CET)
Message-ID: <ab107cb4-3ba5-9d22-2e40-fada05c3579f@xs4all.nl>
Date:   Tue, 11 Jan 2022 10:58:10 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Firefox/91.0 Thunderbird/91.4.1
Subject: Re: [PATCH] media: vidtv: Check for null return of vzalloc
Content-Language: en-US
To:     Jiasheng Jiang <jiasheng@iscas.ac.cn>, dwlsalmeida@gmail.com,
        mchehab@kernel.org
Cc:     linux-media@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20211231075019.1894177-1-jiasheng@iscas.ac.cn>
From:   Hans Verkuil <hverkuil@xs4all.nl>
In-Reply-To: <20211231075019.1894177-1-jiasheng@iscas.ac.cn>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 31/12/2021 08:50, Jiasheng Jiang wrote:
> As the possible failure of the vzalloc(), e->encoder_buf might be NULL.
> Therefore, it should be better to check it like the kzalloc() in order
> to guarantee the success of the initialization.
> 
> Fixes: f90cf6079bf6 ("media: vidtv: add a bridge driver")
> Signed-off-by: Jiasheng Jiang <jiasheng@iscas.ac.cn>
> ---
>  drivers/media/test-drivers/vidtv/vidtv_s302m.c | 5 +++++
>  1 file changed, 5 insertions(+)
> 
> diff --git a/drivers/media/test-drivers/vidtv/vidtv_s302m.c b/drivers/media/test-drivers/vidtv/vidtv_s302m.c
> index d79b65854627..d7907f1ae530 100644
> --- a/drivers/media/test-drivers/vidtv/vidtv_s302m.c
> +++ b/drivers/media/test-drivers/vidtv/vidtv_s302m.c
> @@ -455,6 +455,11 @@ struct vidtv_encoder
>  		e->name = kstrdup(args.name, GFP_KERNEL);
>  
>  	e->encoder_buf = vzalloc(VIDTV_S302M_BUF_SZ);
> +	if (!e->encoder_buf) {

This doesn't free e->name!

Actually, the same issue is also present later in this function:

        ctx = kzalloc(priv_sz, GFP_KERNEL);
        if (!ctx) {
                kfree(e);
                return NULL;
        }

Regards,

	Hans

> +		kfree(e);
> +		return NULL;
> +	}
> +
>  	e->encoder_buf_sz = VIDTV_S302M_BUF_SZ;
>  	e->encoder_buf_offset = 0;
>  

