Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8C85A48EA0A
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jan 2022 13:45:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241099AbiANMpo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Jan 2022 07:45:44 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124]:36043 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S235721AbiANMpm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Jan 2022 07:45:42 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1642164341;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=er6MELR4/wo1rA6heNzWM5PKfCy/ueOscQvUYlmKOB0=;
        b=SRRI7AAKBrkfFswTc8O0WlgLlOAEa4hpUvypsMXz+vS8/x9xl2nZYKJaqwBw9Yt/cUfQW0
        mg91owSHNWQRDj2R0H6QDc4BzkDeAeQkAZzTsC6Gpx1orqIpQZZFsJxtSPYmQUBrGgzC9U
        H5Ys2D9aHduOAB+nCF56jsoIMTr6ohg=
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com
 [209.85.208.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-381-vFEFzDb6ODKpGJ18YCInjA-1; Fri, 14 Jan 2022 07:45:40 -0500
X-MC-Unique: vFEFzDb6ODKpGJ18YCInjA-1
Received: by mail-ed1-f71.google.com with SMTP id g2-20020a056402424200b003f8ee03207eso8283437edb.7
        for <linux-kernel@vger.kernel.org>; Fri, 14 Jan 2022 04:45:40 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=er6MELR4/wo1rA6heNzWM5PKfCy/ueOscQvUYlmKOB0=;
        b=7tfsHu10mBEZgVpeWuOu7/sjcvueEuB0Ji75k1bD8Pqi6BtjndTF6UDLnLdRLbu+dz
         vYG3VdK4nTjOkPh9u+1/KJhDe8sNyx8pvt2kqGBvrYB2lX4whbLKZUsUO3SYQvpC43WA
         G3e+hEQ7RWpxfELu5Svj+Y55hlWnEa8wLHiFTJF0kXRtBtKtbA9e/UZ22BdecKjIAFSz
         QZOEt3Z2yarrzqVRyTBxBDqSdrYXaMpk8L9CE89HsF0bS0EPV9ClQQhAfVOdQ/tsQzG5
         6H+ksPhGM5bh4zmRUbHWzZwiuNFHvpAmwImq+L8vnyiATy4y3bk50LOG4g8yrGjG9a9S
         M6wQ==
X-Gm-Message-State: AOAM530BG5wxS4IiBgrheixnEHkvRGxneOKgugE0atwkXdJ+Kq5sSBOU
        HM3TTbEyMt0z0cW1P9UhitgpELaGYJO7vm/udtzqcjWUeM6Tdgf59k04Q2H50vdrZvgqV9d8fVn
        uQT5zdFx7kMT5sx4aMlKDADIK
X-Received: by 2002:a05:6402:40d0:: with SMTP id z16mr8908893edb.68.1642164339317;
        Fri, 14 Jan 2022 04:45:39 -0800 (PST)
X-Google-Smtp-Source: ABdhPJxSRH3o6ei5Mw5iW6zgvruyjrCJ+sESmB6gyoqBksqi4jGepcg7bQdBJV7nxJYFL4y7oZRihw==
X-Received: by 2002:a05:6402:40d0:: with SMTP id z16mr8908884edb.68.1642164339134;
        Fri, 14 Jan 2022 04:45:39 -0800 (PST)
Received: from redhat.com ([2.55.154.210])
        by smtp.gmail.com with ESMTPSA id j5sm1815651ejo.171.2022.01.14.04.45.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Jan 2022 04:45:38 -0800 (PST)
Date:   Fri, 14 Jan 2022 07:45:35 -0500
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     Stefano Garzarella <sgarzare@redhat.com>
Cc:     virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org, stefanha@redhat.com,
        kvm@vger.kernel.org, netdev@vger.kernel.org,
        Jason Wang <jasowang@redhat.com>
Subject: Re: [PATCH v1] vhost: cache avail index in vhost_enable_notify()
Message-ID: <20220114074454-mutt-send-email-mst@kernel.org>
References: <20220114090508.36416-1-sgarzare@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220114090508.36416-1-sgarzare@redhat.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 14, 2022 at 10:05:08AM +0100, Stefano Garzarella wrote:
> In vhost_enable_notify() we enable the notifications and we read
> the avail index to check if new buffers have become available in
> the meantime.
> 
> We are not caching the avail index, so when the device will call
> vhost_get_vq_desc(), it will find the old value in the cache and
> it will read the avail index again.
> 
> It would be better to refresh the cache every time we read avail
> index, so let's change vhost_enable_notify() caching the value in
> `avail_idx` and compare it with `last_avail_idx` to check if there
> are new buffers available.
> 
> Anyway, we don't expect a significant performance boost because
> the above path is not very common, indeed vhost_enable_notify()
> is often called with unlikely(), expecting that avail index has
> not been updated.
> 
> Signed-off-by: Stefano Garzarella <sgarzare@redhat.com>

... and can in theory even hurt due to an extra memory write.
So ... performance test restults pls?

> ---
> v1:
> - improved the commit description [MST, Jason]
> ---
>  drivers/vhost/vhost.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/vhost/vhost.c b/drivers/vhost/vhost.c
> index 59edb5a1ffe2..07363dff559e 100644
> --- a/drivers/vhost/vhost.c
> +++ b/drivers/vhost/vhost.c
> @@ -2543,8 +2543,9 @@ bool vhost_enable_notify(struct vhost_dev *dev, struct vhost_virtqueue *vq)
>  		       &vq->avail->idx, r);
>  		return false;
>  	}
> +	vq->avail_idx = vhost16_to_cpu(vq, avail_idx);
>  
> -	return vhost16_to_cpu(vq, avail_idx) != vq->avail_idx;
> +	return vq->avail_idx != vq->last_avail_idx;
>  }
>  EXPORT_SYMBOL_GPL(vhost_enable_notify);
>  
> -- 
> 2.31.1

