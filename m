Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7608D4C8092
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Mar 2022 02:54:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231922AbiCABzV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Feb 2022 20:55:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35616 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230074AbiCABzU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Feb 2022 20:55:20 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 3F30C284
        for <linux-kernel@vger.kernel.org>; Mon, 28 Feb 2022 17:54:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1646099678;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=g40r52wHu65FpHGhPhkJNOWmkU7K31s8CzbExRsMUVU=;
        b=Bj8UmuYplVb0CueQRhtE7t8izpRe7K2uR+tCO5XpEmm45DrHVfbVZxoJ9Q+yilBHGhjE28
        dcM6vKc+CP7atCZ+DV8NkUCvpa0kpv2NHqi2x2SnriMkphC9SGKrQZaHpFdw1Sb540VG2l
        fsRPqOf3zWL3CCU6o9TqiR5R79VG3jc=
Received: from mail-lj1-f199.google.com (mail-lj1-f199.google.com
 [209.85.208.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-19-w1du3k5SOfOUPcBPclijlA-1; Mon, 28 Feb 2022 20:54:36 -0500
X-MC-Unique: w1du3k5SOfOUPcBPclijlA-1
Received: by mail-lj1-f199.google.com with SMTP id u19-20020a05651c131300b00246a8982589so1146022lja.1
        for <linux-kernel@vger.kernel.org>; Mon, 28 Feb 2022 17:54:36 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=g40r52wHu65FpHGhPhkJNOWmkU7K31s8CzbExRsMUVU=;
        b=hGw1Isz2KNmHbMi/3m5hg8e50wc7uXu9XhQ2TZ/tqRJoetYaXuKMUf10wSz9IPO1Tp
         KcfrlFC725GsyxhGaxnp5T9v35FhAB6yXNKU0OPrqkTdXxakuCGfkn7ZAaucidX70SCc
         VpbWsD6YcHgBE54dbOFwD2WflhOBt1y9aksnOTZyi2B9sndL2OQmCEkxpEF6IY30y2H5
         0JWZKWuHMxKArRXne7gk/ABgGgd5QNrhG4dQitYh1s0DotK5Rh2oYtZZqcfToLh/rYvR
         odGP3+xQSsvX/ROPU5gg9lRRyx5U3xmRwUedWLliuhV3jUZovSU7DjRs9om/r+YUXBBQ
         5JJA==
X-Gm-Message-State: AOAM532ye/UlQ1aW2+/SNp1ezIqJLOf4Oa/BCUt+BnRmvsO17v+DooIV
        Yy4jvYqWq76uNlzJuRZMNUwjZqLCQXaRwQ1PxcXfvxjaDftm6/BZVDbsVJjylCAx9pSyUSbDAjG
        MIOyoIAQerSx5tEWjMjxxH+cDpeUxDhE5mmb/dIt+
X-Received: by 2002:a2e:a885:0:b0:23a:30ac:5798 with SMTP id m5-20020a2ea885000000b0023a30ac5798mr16079120ljq.73.1646099675471;
        Mon, 28 Feb 2022 17:54:35 -0800 (PST)
X-Google-Smtp-Source: ABdhPJxw2rPJ4y3ziPQM8cVViNqHOz9fcmI1XLguFucvqdFCOhRObJ9+wV8U3FtF7b2/fBHQt3VcdKCGoxdc36ylRhU=
X-Received: by 2002:a2e:a885:0:b0:23a:30ac:5798 with SMTP id
 m5-20020a2ea885000000b0023a30ac5798mr16079111ljq.73.1646099675293; Mon, 28
 Feb 2022 17:54:35 -0800 (PST)
MIME-Version: 1.0
References: <20220301091059.46869-1-wang.yi59@zte.com.cn>
In-Reply-To: <20220301091059.46869-1-wang.yi59@zte.com.cn>
From:   Jason Wang <jasowang@redhat.com>
Date:   Tue, 1 Mar 2022 09:54:24 +0800
Message-ID: <CACGkMEvKcb1DrdSvCR8YvoDQu4TF1LMUDtngKFycNOzY11cYHg@mail.gmail.com>
Subject: Re: [PATCH] vdpa: fix use-after-free on vp_vdpa_remove
To:     Yi Wang <wang.yi59@zte.com.cn>
Cc:     mst <mst@redhat.com>, Eli Cohen <elic@nvidia.com>,
        Yongji Xie <xieyongji@bytedance.com>,
        Stefano Garzarella <sgarzare@redhat.com>,
        Wu Zongyong <wuzongyong@linux.alibaba.com>,
        virtualization <virtualization@lists.linux-foundation.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        xue.zhihong@zte.com.cn, wang.liang82@zte.com.cn,
        Zhang Min <zhang.min9@zte.com.cn>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-3.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 1, 2022 at 9:26 AM Yi Wang <wang.yi59@zte.com.cn> wrote:
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
>
> Signed-off-by: Zhang Min <zhang.min9@zte.com.cn>
> Signed-off-by: Yi Wang <wang.yi59@zte.com.cn>

Acked-by: Jason Wang <jasowang@redhat.com>

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

