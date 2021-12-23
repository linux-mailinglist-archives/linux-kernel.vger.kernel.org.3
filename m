Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5A4A347E444
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Dec 2021 14:58:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348716AbhLWN6g (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Dec 2021 08:58:36 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124]:47446 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S236801AbhLWN6e (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Dec 2021 08:58:34 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1640267913;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=CpQJOwyNtlX1Mdolftn4RcdaD2Hy2yaictkseWrq6SQ=;
        b=DwayA+U41dHyPsANWB3jp7pFg/1cxaSXyXdcf4hGCuRPVp8wPgANWcobSN9rvMlxP79Cei
        93mEIV4eyUpw1+1ET3NeIjTOUTfKEfNXRX6Cte+XJMP5Q6oz6Rv01qC7LLxHP0oZkbzV2h
        3jZkALMQ6cOh3NMDKY0Uxd5M99DjPpA=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-441-yXG8qpqoPXyJmhVX-JRx5Q-1; Thu, 23 Dec 2021 08:58:32 -0500
X-MC-Unique: yXG8qpqoPXyJmhVX-JRx5Q-1
Received: by mail-wm1-f70.google.com with SMTP id u10-20020a05600c19ca00b00345b2959e5aso1995520wmq.9
        for <linux-kernel@vger.kernel.org>; Thu, 23 Dec 2021 05:58:32 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=CpQJOwyNtlX1Mdolftn4RcdaD2Hy2yaictkseWrq6SQ=;
        b=Q+8FfKzvKtpCv3Cyzlj8vL6tlTw/C++D1V92StPqvqBgVJBFsgHwJYewt+KStcVtRV
         hjEYbq5UpSIB3NGPlp+bPnmRrKcGkBt5vvi8YNvSsHL/yoipHu132Ul7ArJGmdgPi/bT
         QdX73ItI4wzwieicqGXoWBp3hSinvffQ7O8h/GW25565touzqrRg7eqQSlqr75T5igPI
         sniwhmtaRsvZHH5kBXny2LtXDzjiblG81vgeDikVkw5S5Ytug1xYJHTA9peyvm44hpPm
         393HHMuK4TgUdFVXRwOCDfmySDUXkpFGnHB6+hAz9dUqxUZqH1CUNkpEr6sJF6NSBgxn
         9plA==
X-Gm-Message-State: AOAM53334C6M4t2Z89Xqxyy0Q5pgOPZH4PLmu9tk/KosM59bFZrK/1X8
        Fnad7+nUPVXqSVPRnnoTeAFVyUjgMJNMe2oPUnQpsSfKzFQvlnTePS1/nmC+d1ZjiNX6R2VKxJ9
        yr9y9iVbClf1Yxxd8SEL0fFb1
X-Received: by 2002:a05:600c:1f0f:: with SMTP id bd15mr1897618wmb.2.1640267911071;
        Thu, 23 Dec 2021 05:58:31 -0800 (PST)
X-Google-Smtp-Source: ABdhPJxdZ+swrtLCADcHVBsqJwj8tIlyAIce/Bk5kJZdXg7yhPIcNXyeP1RJ9MxfrD4FnxzIoU/LvQ==
X-Received: by 2002:a05:600c:1f0f:: with SMTP id bd15mr1897604wmb.2.1640267910875;
        Thu, 23 Dec 2021 05:58:30 -0800 (PST)
Received: from redhat.com ([2.55.1.37])
        by smtp.gmail.com with ESMTPSA id r8sm5096452wru.107.2021.12.23.05.58.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Dec 2021 05:58:30 -0800 (PST)
Date:   Thu, 23 Dec 2021 08:58:26 -0500
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     Yi Wang <wang.yi59@zte.com.cn>
Cc:     jasowang@redhat.com, kvm@vger.kernel.org,
        virtualization@lists.linux-foundation.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, xue.zhihong@zte.com.cn,
        wang.liang82@zte.com.cn, Zhang Min <zhang.min9@zte.com.cn>
Subject: Re: [PATCH] vdpa: regist vhost-vdpa dev class
Message-ID: <20211223085634-mutt-send-email-mst@kernel.org>
References: <20211223073145.35363-1-wang.yi59@zte.com.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211223073145.35363-1-wang.yi59@zte.com.cn>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

typo in subject

On Thu, Dec 23, 2021 at 03:31:45PM +0800, Yi Wang wrote:
> From: Zhang Min <zhang.min9@zte.com.cn>
> 
> Some applications like kata-containers need to acquire MAJOR/MINOR/DEVNAME
> for devInfo [1], so regist vhost-vdpa dev class to expose uevent.
> 
> 1. https://github.com/kata-containers/kata-containers/blob/main/src/runtime/virtcontainers/device/config/config.go
> 
> Signed-off-by: Zhang Min <zhang.min9@zte.com.cn>
> Signed-off-by: Yi Wang <wang.yi59@zte.com.cn>
> ---
>  drivers/vhost/vdpa.c | 12 ++++++++++++
>  1 file changed, 12 insertions(+)
> 
> diff --git a/drivers/vhost/vdpa.c b/drivers/vhost/vdpa.c
> index fb41db3da611..90fbad93e7a2 100644
> --- a/drivers/vhost/vdpa.c
> +++ b/drivers/vhost/vdpa.c
> @@ -1012,6 +1012,7 @@ static void vhost_vdpa_release_dev(struct device *device)
>  	kfree(v);
>  }
>  
> +static struct class *vhost_vdpa_class;
>  static int vhost_vdpa_probe(struct vdpa_device *vdpa)
>  {
>  	const struct vdpa_config_ops *ops = vdpa->config;
> @@ -1040,6 +1041,7 @@ static int vhost_vdpa_probe(struct vdpa_device *vdpa)
>  	v->dev.release = vhost_vdpa_release_dev;
>  	v->dev.parent = &vdpa->dev;
>  	v->dev.devt = MKDEV(MAJOR(vhost_vdpa_major), minor);
> +	v->dev.class = vhost_vdpa_class;
>  	v->vqs = kmalloc_array(v->nvqs, sizeof(struct vhost_virtqueue),
>  			       GFP_KERNEL);
>  	if (!v->vqs) {
> @@ -1097,6 +1099,14 @@ static int __init vhost_vdpa_init(void)
>  {
>  	int r;
>  
> +	vhost_vdpa_class = class_create(THIS_MODULE, "vhost-vdpa");
> +	if (IS_ERR(vhost_vdpa_class)) {
> +		r = PTR_ERR(vhost_vdpa_class);
> +		pr_warn("vhost vdpa class create error %d,  maybe mod reinserted\n", r);

what's mod reinserted? why warn not error?

> +		vhost_vdpa_class = NULL;
> +		return r;
> +	}
> +
>  	r = alloc_chrdev_region(&vhost_vdpa_major, 0, VHOST_VDPA_DEV_MAX,
>  				"vhost-vdpa");
>  	if (r)
> @@ -1111,6 +1121,7 @@ static int __init vhost_vdpa_init(void)
>  err_vdpa_register_driver:
>  	unregister_chrdev_region(vhost_vdpa_major, VHOST_VDPA_DEV_MAX);
>  err_alloc_chrdev:
> +	class_destroy(vhost_vdpa_class);
>  	return r;
>  }
>  module_init(vhost_vdpa_init);
> @@ -1118,6 +1129,7 @@ module_init(vhost_vdpa_init);
>  static void __exit vhost_vdpa_exit(void)
>  {
>  	vdpa_unregister_driver(&vhost_vdpa_driver);
> +	class_destroy(vhost_vdpa_class);
>  	unregister_chrdev_region(vhost_vdpa_major, VHOST_VDPA_DEV_MAX);
>  }
>  module_exit(vhost_vdpa_exit);
> -- 
> 2.27.0

