Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CDAD2483B26
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jan 2022 04:44:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231218AbiADDoZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Jan 2022 22:44:25 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:44616 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231165AbiADDoY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Jan 2022 22:44:24 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1641267864;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=U3bRp9PDw2PtdlQN7RsHKxoF/g+6HtYTrwOQVxpYpkg=;
        b=ewJoEVH/asVTt1uuHPZuNvkintjY7r3X64UHDyxis0Y4qICDXE/MaFi1oUS6iMNgf2yx9n
        2L0JGW/QlGFw0Dpy/2zUBwmH9Jw1u2Nxd1BhPONTIBTwR5bFcH7dbO0tvTv+gO4rTrtymp
        oZjojhIoy0X4fCVfa2padaL5W4ppxvg=
Received: from mail-lf1-f72.google.com (mail-lf1-f72.google.com
 [209.85.167.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-258-y33Vxt1-ODOz8MhgMLvHSQ-1; Mon, 03 Jan 2022 22:44:22 -0500
X-MC-Unique: y33Vxt1-ODOz8MhgMLvHSQ-1
Received: by mail-lf1-f72.google.com with SMTP id 28-20020ac24d5c000000b00425c507cfc0so7216750lfp.20
        for <linux-kernel@vger.kernel.org>; Mon, 03 Jan 2022 19:44:22 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=U3bRp9PDw2PtdlQN7RsHKxoF/g+6HtYTrwOQVxpYpkg=;
        b=GPMG8d0Z2WJfo5seGvhrGJq2vmCsdJlfCB7emblkh2sD8xDVlNz4OdGIxqQm4coqgr
         ZYHMdelL3sL6Z9PeznFoOSYUsDXAwI/8PxJ6C6UYPO2JZpgB2twXgGG7HSlrJ2D7i+cq
         Uwxk9sA74aL/V08jJxOXbYUVTU+tZ6W/vyoq7LzLSfjGPMcMJ3AHVLVPk8rTKDfrYCx6
         sJJwikSgqTHipP7FkkQzhuSbozuvYAGji3iLfEXO2V3w3gpVwWbk09ID5cFgDWN/zajJ
         jorqyWf7WRr92h8JnH3JybCC2qkdJsMfkI8sD/RyZa8VWr2BdUEBL4/Dlc+wvWU0Irgo
         oWmQ==
X-Gm-Message-State: AOAM531bo/sdwGH4pBgytuRgvJ2nD5DIPKZFDEX462usUyI59tRteLuI
        AxDUJtWW5G7F6HM2cKIajjkapdp3ulwAStM9nrCdWSgVprU3ly06gULF7R5yTNiEG0Xp+igWE5F
        2UQ/HdLioeaCPm1gLI1DSx1yYwbGB0tBWcRyPa48h
X-Received: by 2002:a05:6512:22d6:: with SMTP id g22mr42525577lfu.199.1641267861341;
        Mon, 03 Jan 2022 19:44:21 -0800 (PST)
X-Google-Smtp-Source: ABdhPJwPfKa8UYDWk8yXRh/Tynib8SG3CWPXUC55CynDHAaf3IrbQwAAOOMAqfKLA5ICJGqVqiZgR88MAce8maqcssc=
X-Received: by 2002:a05:6512:22d6:: with SMTP id g22mr42525557lfu.199.1641267861109;
 Mon, 03 Jan 2022 19:44:21 -0800 (PST)
MIME-Version: 1.0
References: <20211224070404.54840-1-wang.yi59@zte.com.cn>
In-Reply-To: <20211224070404.54840-1-wang.yi59@zte.com.cn>
From:   Jason Wang <jasowang@redhat.com>
Date:   Tue, 4 Jan 2022 11:44:10 +0800
Message-ID: <CACGkMEvdKATVvLVQtfPfSeev83Ajskg4gFoHDhWT7wrWEQ3FEA@mail.gmail.com>
Subject: Re: [PATCH v2] vdpa: regist vhost-vdpa dev class
To:     Yi Wang <wang.yi59@zte.com.cn>
Cc:     mst <mst@redhat.com>, Stefano Garzarella <sgarzare@redhat.com>,
        kvm <kvm@vger.kernel.org>,
        virtualization <virtualization@lists.linux-foundation.org>,
        netdev <netdev@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        xue.zhihong@zte.com.cn, wang.liang82@zte.com.cn,
        Zhang Min <zhang.min9@zte.com.cn>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 24, 2021 at 3:13 PM Yi Wang <wang.yi59@zte.com.cn> wrote:
>
> From: Zhang Min <zhang.min9@zte.com.cn>
>
> Some applications like kata-containers need to acquire MAJOR/MINOR/DEVNAME
> for devInfo [1], so regist vhost-vdpa dev class to expose uevent.

Hi:

I think we need to be more verbose here e.g:

1) why can't we get major/minor with the current interface
2) what kind of the uevent is required and not supported currently

Thanks

>
> 1. https://github.com/kata-containers/kata-containers/blob/main/src/runtime/virtcontainers/device/config/config.go
>
> Signed-off-by: Zhang Min <zhang.min9@zte.com.cn>
> Signed-off-by: Yi Wang <wang.yi59@zte.com.cn>
> ---
> v2: remove redundant vhost_vdpa_class reset and pr_warn, adjust location
>     of *vhost_vdpa_class impl and class_destroy.
>
>  drivers/vhost/vdpa.c | 8 ++++++++
>  1 file changed, 8 insertions(+)
>
> diff --git a/drivers/vhost/vdpa.c b/drivers/vhost/vdpa.c
> index e3c4f059b21a..55e966c508c8 100644
> --- a/drivers/vhost/vdpa.c
> +++ b/drivers/vhost/vdpa.c
> @@ -53,6 +53,7 @@ struct vhost_vdpa {
>  static DEFINE_IDA(vhost_vdpa_ida);
>
>  static dev_t vhost_vdpa_major;
> +static struct class *vhost_vdpa_class;
>
>  static void handle_vq_kick(struct vhost_work *work)
>  {
> @@ -1140,6 +1141,7 @@ static int vhost_vdpa_probe(struct vdpa_device *vdpa)
>         v->dev.release = vhost_vdpa_release_dev;
>         v->dev.parent = &vdpa->dev;
>         v->dev.devt = MKDEV(MAJOR(vhost_vdpa_major), minor);
> +       v->dev.class = vhost_vdpa_class;
>         v->vqs = kmalloc_array(v->nvqs, sizeof(struct vhost_virtqueue),
>                                GFP_KERNEL);
>         if (!v->vqs) {
> @@ -1197,6 +1199,10 @@ static int __init vhost_vdpa_init(void)
>  {
>         int r;
>
> +       vhost_vdpa_class = class_create(THIS_MODULE, "vhost-vdpa");
> +       if (IS_ERR(vhost_vdpa_class))
> +               return PTR_ERR(vhost_vdpa_class);
> +
>         r = alloc_chrdev_region(&vhost_vdpa_major, 0, VHOST_VDPA_DEV_MAX,
>                                 "vhost-vdpa");
>         if (r)
> @@ -1211,6 +1217,7 @@ static int __init vhost_vdpa_init(void)
>  err_vdpa_register_driver:
>         unregister_chrdev_region(vhost_vdpa_major, VHOST_VDPA_DEV_MAX);
>  err_alloc_chrdev:
> +       class_destroy(vhost_vdpa_class);
>         return r;
>  }
>  module_init(vhost_vdpa_init);
> @@ -1219,6 +1226,7 @@ static void __exit vhost_vdpa_exit(void)
>  {
>         vdpa_unregister_driver(&vhost_vdpa_driver);
>         unregister_chrdev_region(vhost_vdpa_major, VHOST_VDPA_DEV_MAX);
> +       class_destroy(vhost_vdpa_class);
>  }
>  module_exit(vhost_vdpa_exit);
>
> --
> 2.27.0
>

