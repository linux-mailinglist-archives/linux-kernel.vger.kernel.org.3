Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E6FB6565DCD
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Jul 2022 21:08:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234546AbiGDTHp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Jul 2022 15:07:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57408 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234604AbiGDTHY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Jul 2022 15:07:24 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 3CDAF214
        for <linux-kernel@vger.kernel.org>; Mon,  4 Jul 2022 12:07:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1656961642;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=D2gi9XsvbFmRpvchivL/m3Dq1jd/AeOLkln+AN3rc6I=;
        b=ikVjspmvTskz89MzMaAdUFkFtVX5pshvog1uWbAYyxZ2sdQA0lbTDLt1jPD8xah1GUPzs5
        x5V10kiDHvrCi1Q6vWi2b6Bbr5J5g8bP0YEqdcSdYx+js7eSfX6oMedAVXm79rdy9qly1X
        AwJj0x7xHWzN6TCNm5pEZZgzGOFNr54=
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com
 [209.85.208.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-41-z3fceakQPvWl4qv2mB0pxA-1; Mon, 04 Jul 2022 15:07:21 -0400
X-MC-Unique: z3fceakQPvWl4qv2mB0pxA-1
Received: by mail-ed1-f72.google.com with SMTP id g7-20020a056402424700b00435ac9c7a8bso7709319edb.14
        for <linux-kernel@vger.kernel.org>; Mon, 04 Jul 2022 12:07:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=D2gi9XsvbFmRpvchivL/m3Dq1jd/AeOLkln+AN3rc6I=;
        b=fhj+a+EporDXuCe39fUt7OW7EL73OIdx0bKuA91Q8jm4A12chtkeE+u8bRlKcEMRF4
         qaAjqpRPs38t6DAtEPPGjvBisTQhvu9082yf4L9N69ECf2DaqwX7H9EoDU/27NNmGdSt
         8U36b0BM79HJb+ujTuse6Z/OseyoRN84SxNZliM9J45WKOevuDzCj4os227RYrp1dQ34
         xVWasA/xiM+ejO7wL+E9F8oN4Hg8LBuXKVipFcTQ3LRRjxKlf5Q+8cFAEC8MZreLqIjQ
         uMdngj8R/qimX1GCV7SuR8yQgVv8P2JPe2+Eul9LF+91FhZpMnJh4eRZPliMtgwSeyOq
         wtuA==
X-Gm-Message-State: AJIora/NQO53FevYYsZd6omAq4gdwXCQtPXRcuqnD4CE2Wq7b9ithlHi
        8BAp7QYSP9anXDLDtsZDkMZMRbrXaS8TCcrkqaiz8WPHjhWtdNX3y9nimomVdn2lY6VQAm18HK0
        4cPV+u6gunxVZLiZ2dJbavDes
X-Received: by 2002:a05:6402:5001:b0:437:8918:8dbe with SMTP id p1-20020a056402500100b0043789188dbemr40093050eda.70.1656961640147;
        Mon, 04 Jul 2022 12:07:20 -0700 (PDT)
X-Google-Smtp-Source: AGRyM1sRTKxevSLGEYgqLonHWHFDIlgEK+Dm3Q1A/IkjYBGtZpCegln635n3jvgVCXe9lX7kz0vbTg==
X-Received: by 2002:a05:6402:5001:b0:437:8918:8dbe with SMTP id p1-20020a056402500100b0043789188dbemr40093023eda.70.1656961639948;
        Mon, 04 Jul 2022 12:07:19 -0700 (PDT)
Received: from redhat.com ([2.55.3.188])
        by smtp.gmail.com with ESMTPSA id p19-20020aa7cc93000000b0042bdb6a3602sm20930975edt.69.2022.07.04.12.07.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Jul 2022 12:07:19 -0700 (PDT)
Date:   Mon, 4 Jul 2022 15:07:15 -0400
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     Stefano Garzarella <sgarzare@redhat.com>
Cc:     virtualization@lists.linux-foundation.org,
        Jason Wang <jasowang@redhat.com>, linux-kernel@vger.kernel.org,
        Eugenio =?iso-8859-1?Q?P=E9rez?= <eperezma@redhat.com>
Subject: Re: [RFC PATCH 1/6] tools/virtio: fix build
Message-ID: <20220704150706-mutt-send-email-mst@kernel.org>
References: <20220704171701.127665-1-sgarzare@redhat.com>
 <20220704171701.127665-2-sgarzare@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220704171701.127665-2-sgarzare@redhat.com>
X-Spam-Status: No, score=-3.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 04, 2022 at 07:16:56PM +0200, Stefano Garzarella wrote:
> Fix the build caused by the following changes:
> - phys_addr_t is now defined in tools/include/linux/types.h
> - dev_warn_once() is used in drivers/virtio/virtio_ring.c
> - linux/uio.h included by vringh.h use INT_MAX defined in limits.h
> 
> Signed-off-by: Stefano Garzarella <sgarzare@redhat.com>

Post this separately?

> ---
>  tools/virtio/linux/kernel.h | 2 +-
>  tools/virtio/linux/vringh.h | 1 +
>  2 files changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/tools/virtio/linux/kernel.h b/tools/virtio/linux/kernel.h
> index 0b493542e61a..21593bf97755 100644
> --- a/tools/virtio/linux/kernel.h
> +++ b/tools/virtio/linux/kernel.h
> @@ -29,7 +29,6 @@
>  #define READ                    0
>  #define WRITE                   1
>  
> -typedef unsigned long long phys_addr_t;
>  typedef unsigned long long dma_addr_t;
>  typedef size_t __kernel_size_t;
>  typedef unsigned int __wsum;
> @@ -136,6 +135,7 @@ static inline void *krealloc_array(void *p, size_t new_n, size_t new_size, gfp_t
>  #endif
>  #define dev_err(dev, format, ...) fprintf (stderr, format, ## __VA_ARGS__)
>  #define dev_warn(dev, format, ...) fprintf (stderr, format, ## __VA_ARGS__)
> +#define dev_warn_once(dev, format, ...) fprintf (stderr, format, ## __VA_ARGS__)
>  
>  #define min(x, y) ({				\
>  	typeof(x) _min1 = (x);			\
> diff --git a/tools/virtio/linux/vringh.h b/tools/virtio/linux/vringh.h
> index 9348957be56e..e11c6aece734 100644
> --- a/tools/virtio/linux/vringh.h
> +++ b/tools/virtio/linux/vringh.h
> @@ -1 +1,2 @@
> +#include <limits.h>
>  #include "../../../include/linux/vringh.h"
> -- 
> 2.36.1

