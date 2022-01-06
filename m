Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 21AAC4864B2
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jan 2022 13:59:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239156AbiAFM7e (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Jan 2022 07:59:34 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124]:22722 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S238827AbiAFM7b (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Jan 2022 07:59:31 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1641473971;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=5WAXUnIE5VkO2N/WW0e+ntcocAshJvWgVTBusRNRoBM=;
        b=Z07kWzKqvVWOFLqA/fDNW7zz+X+r68ILcJvw4w69ZmYTo9Ur2VG/SYmtyIoc+9gSJlcsYw
        8um3vgLqGeUv2JC9zg1IIq9gaAY4ktPRtliEJPSkOqwjKhyTquEnMcVjgyjnfOfi/tHuhh
        accsAnI6Rtj+Fq7mJ1+m/yKDdb+vFmI=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-15-KlBJdBprOZ-RbVeGLr0XFw-1; Thu, 06 Jan 2022 07:59:29 -0500
X-MC-Unique: KlBJdBprOZ-RbVeGLr0XFw-1
Received: by mail-wm1-f70.google.com with SMTP id k40-20020a05600c1ca800b00345bf554707so1905304wms.4
        for <linux-kernel@vger.kernel.org>; Thu, 06 Jan 2022 04:59:29 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=5WAXUnIE5VkO2N/WW0e+ntcocAshJvWgVTBusRNRoBM=;
        b=YclcfUsZUdkhyL+uwvVRuv+oIop6u0JFR4Rv6Vuw67h3THiBkYUa8GLPI5pcJbKxZ5
         icl/LlKv6tnlMj79Jin1w9e9Hg5QIYXfNDbxB6IEnsPYEiYJckkfkJc9cWJ1Ut9sbkfK
         gwpj6MDnrvElVN5BZ/GevDl2b+W4MhwPae+nvpC5SLhSF6QTOQdwWdOFPVCRdO3ol+jg
         4VIUoCT5DKbLtXOZqgOaDo3LatEpE7RO9/e7ZUCksvYhF/X5mLIotIzxcmowxl7Qck5Q
         cUD+J0VzDW5Lvf+so69Lx0L2G8u6nUeGa6fjWSQ6VC/vjvHVnTlzb4kbVhHG3emV2NLv
         5D2g==
X-Gm-Message-State: AOAM532aCeJGfVp6H3LvJx+fiym9Fpu+VvB5pIrFgbX4ktycDPXVfuon
        BpuCs98f+dlX+hbOThBPq7wkX3hBk3sXDow1kogNDk2Rx5P0ULm6bTXCABvjdJpvk+al1TGez3q
        gg4ohTwh5aCMeE2DTO29Ha4ga
X-Received: by 2002:a5d:47cd:: with SMTP id o13mr50910677wrc.669.1641473968662;
        Thu, 06 Jan 2022 04:59:28 -0800 (PST)
X-Google-Smtp-Source: ABdhPJzk/EB7gBSw+8TNfGdRn9vLKyEkOGA9jgxYXDa9oIkZ9y8w7ZQqRax7nQjOp89r1Ux1UWKooQ==
X-Received: by 2002:a5d:47cd:: with SMTP id o13mr50910672wrc.669.1641473968510;
        Thu, 06 Jan 2022 04:59:28 -0800 (PST)
Received: from redhat.com ([2a03:c5c0:207e:991b:6857:5652:b903:a63b])
        by smtp.gmail.com with ESMTPSA id l2sm2111421wrs.43.2022.01.06.04.59.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Jan 2022 04:59:27 -0800 (PST)
Date:   Thu, 6 Jan 2022 07:59:24 -0500
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     Jiasheng Jiang <jiasheng@iscas.ac.cn>
Cc:     jasowang@redhat.com, virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] virtio_ring: Check null pointer
Message-ID: <20220106075459-mutt-send-email-mst@kernel.org>
References: <20220104151251.1988036-1-jiasheng@iscas.ac.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220104151251.1988036-1-jiasheng@iscas.ac.cn>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 04, 2022 at 11:12:51PM +0800, Jiasheng Jiang wrote:
> As the alloc_indirect_packed() returns kmalloc_array() that could
> allocation fail and return null pointer, it should be check in order to
> prevent the dereference of null pointer.
> 
> Fixes: 1ce9e6055fa0 ("virtio_ring: introduce packed ring support")
> Signed-off-by: Jiasheng Jiang <jiasheng@iscas.ac.cn>


Well upstream has:

    virtio_ring: check desc == NULL when using indirect with packed

so this no longer applies.
I think we do need to fix it: the END_USE is missing there.
Sending a patch.


> ---
> v2: Remove the redundant empty line.
> ---
>  drivers/virtio/virtio_ring.c | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/drivers/virtio/virtio_ring.c b/drivers/virtio/virtio_ring.c
> index 71e16b53e9c1..2923d8a68dc3 100644
> --- a/drivers/virtio/virtio_ring.c
> +++ b/drivers/virtio/virtio_ring.c
> @@ -992,6 +992,10 @@ static int virtqueue_add_indirect_packed(struct vring_virtqueue *vq,
>  
>  	head = vq->packed.next_avail_idx;
>  	desc = alloc_indirect_packed(total_sg, gfp);
> +	if (!desc) {
> +		END_USE(vq);
> +		return -ENOMEM;
> +	}
>  
>  	if (unlikely(vq->vq.num_free < 1)) {
>  		pr_debug("Can't add buf len 1 - avail = 0\n");
> -- 
> 2.25.1

