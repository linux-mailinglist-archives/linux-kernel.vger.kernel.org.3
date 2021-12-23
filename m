Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E79DA47E1E2
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Dec 2021 12:00:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347831AbhLWLAB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Dec 2021 06:00:01 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:38163 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S243250AbhLWK77 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Dec 2021 05:59:59 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1640257199;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Gi7g+IDEb6WGbto01CYp8T3QI7qHrL20V9bktHYFsUE=;
        b=VvR2xm3DuLCiJiv8SDvzEYHZpwUyviPNYv9YdhbbMxm2rTM0KSsNs949S9iAZ/gsZ4dund
        pvcB3tRO5WPuOWpwAxPJcjdG18+CYOh3Y19oWGdoK7iXc7gv2dv519n1epsDHcjc3xNLGK
        GazHxnU/fek+ovw3+5UKZ9DkcRBhSsQ=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-648-F-AxjVrcPxqnUkF9Lo-5Tw-1; Thu, 23 Dec 2021 05:59:55 -0500
X-MC-Unique: F-AxjVrcPxqnUkF9Lo-5Tw-1
Received: by mail-wm1-f69.google.com with SMTP id v23-20020a05600c215700b0034566adb612so1892180wml.0
        for <linux-kernel@vger.kernel.org>; Thu, 23 Dec 2021 02:59:55 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=Gi7g+IDEb6WGbto01CYp8T3QI7qHrL20V9bktHYFsUE=;
        b=QgNjhloGgtbRILCYIDLm1wUzCAE/1BeQ3Qqe1qJlviN7svcT2Nw7r9puOsFQkL9Mva
         8DeYbZdTBRKcGOErAaBg2/PZD7hr3SsECDLdJPublieWm9hh1T8dxkyNwwzVkOMUNUte
         avAOW8iupDaa5NDfVx1x3HI5qs9MjEVO1/wsW3PcbTTS7iXwR06jmzSf47uA29yVS0rr
         l9ZOzXMEN/4p9dEupqlba2vMNooAWT133Sx7y18mY2fyJvzRtr8DcLpvQoDckLkpwOyE
         CHI6Lpb1IL96OoEFmfYuve4CMROr2ZguyEm9gqYcXse/ziC8w2Rr6kN+yjlQJkCheQqB
         Fehg==
X-Gm-Message-State: AOAM5309r5au5mdGWq8rz1wn/Fog1FWp3cm/ewep5spG5f1+Cwif3xbt
        JNcylwWKtRqMMTiCON3QPnyC6z1HTEGogx5nsn0Kskoxzu1LB++DWHoistohEL1qguxa4fAO7XM
        IVEdsoS5beGakMfM9MRLEcW2C
X-Received: by 2002:a5d:6944:: with SMTP id r4mr1338204wrw.515.1640257194567;
        Thu, 23 Dec 2021 02:59:54 -0800 (PST)
X-Google-Smtp-Source: ABdhPJyiSPvRCS4tIgVXtQ5WPcUTF+53o6QxFaMhWGw4m+5+v/5BVnqxslIxZT8JsIX8wZYXvoGfdw==
X-Received: by 2002:a5d:6944:: with SMTP id r4mr1338194wrw.515.1640257194380;
        Thu, 23 Dec 2021 02:59:54 -0800 (PST)
Received: from steredhat (host-79-51-11-180.retail.telecomitalia.it. [79.51.11.180])
        by smtp.gmail.com with ESMTPSA id p11sm4952547wru.99.2021.12.23.02.59.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Dec 2021 02:59:53 -0800 (PST)
Date:   Thu, 23 Dec 2021 11:59:50 +0100
From:   Stefano Garzarella <sgarzare@redhat.com>
To:     Yi Wang <wang.yi59@zte.com.cn>
Cc:     mst@redhat.com, Zhang Min <zhang.min9@zte.com.cn>,
        wang.liang82@zte.com.cn, kvm@vger.kernel.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        virtualization@lists.linux-foundation.org, xue.zhihong@zte.com.cn
Subject: Re: [PATCH] vdpa: regist vhost-vdpa dev class
Message-ID: <20211223105950.ovywoj6v3aooh2v5@steredhat>
References: <20211223073145.35363-1-wang.yi59@zte.com.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20211223073145.35363-1-wang.yi59@zte.com.cn>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 23, 2021 at 03:31:45PM +0800, Yi Wang wrote:
>From: Zhang Min <zhang.min9@zte.com.cn>
>
>Some applications like kata-containers need to acquire MAJOR/MINOR/DEVNAME
>for devInfo [1], so regist vhost-vdpa dev class to expose uevent.
>
>1. https://github.com/kata-containers/kata-containers/blob/main/src/runtime/virtcontainers/device/config/config.go
>
>Signed-off-by: Zhang Min <zhang.min9@zte.com.cn>
>Signed-off-by: Yi Wang <wang.yi59@zte.com.cn>
>---
> drivers/vhost/vdpa.c | 12 ++++++++++++
> 1 file changed, 12 insertions(+)
>
>diff --git a/drivers/vhost/vdpa.c b/drivers/vhost/vdpa.c
>index fb41db3da611..90fbad93e7a2 100644
>--- a/drivers/vhost/vdpa.c
>+++ b/drivers/vhost/vdpa.c
>@@ -1012,6 +1012,7 @@ static void vhost_vdpa_release_dev(struct device *device)
> 	kfree(v);
> }
>
>+static struct class *vhost_vdpa_class;
   ^
Maybe is better to move this declaration on top, near `static dev_t 
vhost_vdpa_major;`

> static int vhost_vdpa_probe(struct vdpa_device *vdpa)
> {
> 	const struct vdpa_config_ops *ops = vdpa->config;
>@@ -1040,6 +1041,7 @@ static int vhost_vdpa_probe(struct vdpa_device *vdpa)
> 	v->dev.release = vhost_vdpa_release_dev;
> 	v->dev.parent = &vdpa->dev;
> 	v->dev.devt = MKDEV(MAJOR(vhost_vdpa_major), minor);
>+	v->dev.class = vhost_vdpa_class;
> 	v->vqs = kmalloc_array(v->nvqs, sizeof(struct vhost_virtqueue),
> 			       GFP_KERNEL);
> 	if (!v->vqs) {
>@@ -1097,6 +1099,14 @@ static int __init vhost_vdpa_init(void)
> {
> 	int r;
>
>+	vhost_vdpa_class = class_create(THIS_MODULE, "vhost-vdpa");
>+	if (IS_ERR(vhost_vdpa_class)) {
>+		r = PTR_ERR(vhost_vdpa_class);
>+		pr_warn("vhost vdpa class create error %d,  maybe mod reinserted\n", r);
                                                           ^
double space.

I'm not a native speaker, but I would rephrase the second part to "maybe 
the module is already loaded"

>+		vhost_vdpa_class = NULL;
>+		return r;
>+	}
>+
> 	r = alloc_chrdev_region(&vhost_vdpa_major, 0, VHOST_VDPA_DEV_MAX,
> 				"vhost-vdpa");
> 	if (r)
>@@ -1111,6 +1121,7 @@ static int __init vhost_vdpa_init(void)
> err_vdpa_register_driver:
> 	unregister_chrdev_region(vhost_vdpa_major, VHOST_VDPA_DEV_MAX);
> err_alloc_chrdev:
>+	class_destroy(vhost_vdpa_class);

Should we set `vhost_vdpa_class` to NULL here?

If yes, maybe better to add a new label, and a goto in the 
`class_create` error handling.

> 	return r;
> }
> module_init(vhost_vdpa_init);
>@@ -1118,6 +1129,7 @@ module_init(vhost_vdpa_init);
> static void __exit vhost_vdpa_exit(void)
> {
> 	vdpa_unregister_driver(&vhost_vdpa_driver);
>+	class_destroy(vhost_vdpa_class);

I would move it after unregister_chrdev_region() to have the reverse 
order of initialization (as we already rightly do in the error path of 
vhost_vdpa_init()).

Thanks,
Stefano

> 	unregister_chrdev_region(vhost_vdpa_major, VHOST_VDPA_DEV_MAX);
> }
> module_exit(vhost_vdpa_exit);
>-- 
>2.27.0
>_______________________________________________
>Virtualization mailing list
>Virtualization@lists.linux-foundation.org
>https://lists.linuxfoundation.org/mailman/listinfo/virtualization
>

