Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B4D3E4C85E8
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Mar 2022 09:05:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232732AbiCAIG2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Mar 2022 03:06:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41372 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230043AbiCAIG1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Mar 2022 03:06:27 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id BAC8E25C7E
        for <linux-kernel@vger.kernel.org>; Tue,  1 Mar 2022 00:05:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1646121945;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=w77Ebi4LifMh+ZrcFTZqWSEQCBXXdZGjexRcCg9Znzs=;
        b=GBbGQW540CoyevOTZYogp5iFMrci4G/KArqofZicSYVPJ8OLmJx8fes5CFTbGLvCROfKVr
        ZT61cTLoa9JRYVEtxxja2aIM1xASZd4cXbQy9WlVADhaoXuzTxRfm4aXaZgqt+hhRT1aZx
        QL60fOx9qBfnLb1o6BPuUu9Nkovowis=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-126--1E1k2T4M2-4BiXAGXsyvA-1; Tue, 01 Mar 2022 03:05:44 -0500
X-MC-Unique: -1E1k2T4M2-4BiXAGXsyvA-1
Received: by mail-ej1-f69.google.com with SMTP id 13-20020a170906328d00b006982d0888a4so6380387ejw.9
        for <linux-kernel@vger.kernel.org>; Tue, 01 Mar 2022 00:05:44 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=w77Ebi4LifMh+ZrcFTZqWSEQCBXXdZGjexRcCg9Znzs=;
        b=eDBglhmV+qDZFLlYRW0GMva90sfhUFYZeEW5ust1mNZB88h2pWHNGcz5qerZLwmFhu
         qXRamjWuyVqJbCjyj5xFYvJCiCgC3mmjb4N95GV8Vh3VIeMZI0OAsaTo2PhThZlYUQM7
         IOYp08u64cVMDJPU9EFsh2m2MHkNsOB7ZM8FiG5xIC5IzAkCdmWolz1XbEG/XVJIxlRf
         f58PDlp4fUItdN1ZK7zvhvkgnMxBkFihnep8wI2/+y6Vmz26UVpEyQhJel8YDo5ulFXi
         qfONpe8emO9utsnVMGFOhJ85TbH/LpSZfhaRZoIAUX8I1fU1eYHYnYi6Qx1ZhBYJY1us
         IXYQ==
X-Gm-Message-State: AOAM533sxWplpaOEIGraWKmn+UzJ6eJMS1u910E5K8tqVfiXbc9iCGxw
        cREIFQHIVgu161tA9vH+LPXMAFYHOH+eCVnUxl50uRFd3faDQqwq/NVJnaS8RVEiqOB4VsMq5ws
        Re/NjysAX0MLYoxE5cvXNlvOX
X-Received: by 2002:a05:6402:168a:b0:3fb:600e:4cc3 with SMTP id a10-20020a056402168a00b003fb600e4cc3mr23152115edv.32.1646121943305;
        Tue, 01 Mar 2022 00:05:43 -0800 (PST)
X-Google-Smtp-Source: ABdhPJw2pXZS36u3F2oeMJehcUk31fIeBl/2gQcaSHUT4ZU+CTnm865d3/D4s5dPIC9Q5J5DliIC2w==
X-Received: by 2002:a05:6402:168a:b0:3fb:600e:4cc3 with SMTP id a10-20020a056402168a00b003fb600e4cc3mr23152105edv.32.1646121943127;
        Tue, 01 Mar 2022 00:05:43 -0800 (PST)
Received: from sgarzare-redhat (host-95-248-229-156.retail.telecomitalia.it. [95.248.229.156])
        by smtp.gmail.com with ESMTPSA id n6-20020aa7c786000000b00410d2403ccfsm6861832eds.21.2022.03.01.00.05.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Mar 2022 00:05:42 -0800 (PST)
Date:   Tue, 1 Mar 2022 09:05:38 +0100
From:   Stefano Garzarella <sgarzare@redhat.com>
To:     Yi Wang <wang.yi59@zte.com.cn>
Cc:     Michael Tsirkin <mst@redhat.com>, Jason Wang <jasowang@redhat.com>,
        Eli Cohen <elic@nvidia.com>,
        Xie Yongji <xieyongji@bytedance.com>,
        Wu Zongyong <wuzongyong@linux.alibaba.com>,
        Linux Virtualization <virtualization@lists.linux-foundation.org>,
        kernel list <linux-kernel@vger.kernel.org>,
        xue.zhihong@zte.com.cn, Yi Wang <wang.yi59@zte.com.cn>,
        wang.liang82@zte.com.cn, Zhang Min <zhang.min9@zte.com.cn>
Subject: Re: [PATCH] vdpa: fix use-after-free on vp_vdpa_remove
Message-ID: <CAGxU2F5-PUzDNQrMiOn4Naj7Mga3NZ4kb6AHi7AfPSVauhGFTw@mail.gmail.com>
References: <20220301091059.46869-1-wang.yi59@zte.com.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220301091059.46869-1-wang.yi59@zte.com.cn>
X-Spam-Status: No, score=-3.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 1, 2022 at 2:26 AM Yi Wang <wang.yi59@zte.com.cn> wrote:
>
> From: Zhang Min <zhang.min9@zte.com.cn>
>
> When vp_vdpa driver is unbind, vp_vdpa is freed in vdpa_unregister_device
> and then vp_vdpa->mdev.pci_dev is dereferenced in vp_modern_remove,
> triggering use-after-free.
>
> Call Trace of unbinding driver free vp_vdpa :
> do_syscall_64
>   vfs_write
>     kernfs_fop_write_iter
>       device_release_driver_internal
>         pci_device_remove
>           vp_vdpa_remove
>             vdpa_unregister_device
>               kobject_release
>                 device_release
>                   kfree
>
> Call Trace of dereference vp_vdpa->mdev.pci_dev:
> vp_modern_remove
>   pci_release_selected_regions
>     pci_release_region
>       pci_resource_len
>         pci_resource_end
>           (dev)->resource[(bar)].end

We can add the fixes tag:

Fixes: 64b9f64f80a6 ("vdpa: introduce virtio pci driver")

>
> Signed-off-by: Zhang Min <zhang.min9@zte.com.cn>
> Signed-off-by: Yi Wang <wang.yi59@zte.com.cn>
> ---
>  drivers/vdpa/virtio_pci/vp_vdpa.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/vdpa/virtio_pci/vp_vdpa.c b/drivers/vdpa/virtio_pci/vp_vdpa.c
> index a57e381e830b..cce101e6a940 100644
> --- a/drivers/vdpa/virtio_pci/vp_vdpa.c
> +++ b/drivers/vdpa/virtio_pci/vp_vdpa.c
> @@ -533,8 +533,8 @@ static void vp_vdpa_remove(struct pci_dev *pdev)
>  {
>         struct vp_vdpa *vp_vdpa = pci_get_drvdata(pdev);
>
> -       vdpa_unregister_device(&vp_vdpa->vdpa);
>         vp_modern_remove(&vp_vdpa->mdev);
> +       vdpa_unregister_device(&vp_vdpa->vdpa);
>  }
>
>  static struct pci_driver vp_vdpa_driver = {
> --
> 2.27.0
>

The patch LGTM:

Reviewed-by: Stefano Garzarella <sgarzare@redhat.com>

