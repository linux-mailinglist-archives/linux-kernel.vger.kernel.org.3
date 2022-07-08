Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 35AF756B85B
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Jul 2022 13:24:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237962AbiGHLXu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Jul 2022 07:23:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50122 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237747AbiGHLXr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Jul 2022 07:23:47 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 663A51582D
        for <linux-kernel@vger.kernel.org>; Fri,  8 Jul 2022 04:23:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1657279425;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=jZKl82+1QA3/A/0McRa1/kVvWc5U9T3I3cW1exdXvaU=;
        b=Dbx91Ay0fXb14ILZOHqHYiv+bclNBTMNhFUCin9iqfcnRD5h1DGPMzygqJsQVzQA7RnP10
        FlSxlB6QYLDtAeI1qqVa+FfoZwn9dkgM5AfMLssXs5/6KVnjgHlLree1OZ5B/6tH32Eaxv
        /HUotnRS9/9rs19OUfQXLxBBVW9qceQ=
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com
 [209.85.160.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-191-u8WNQsfHPkaFMWU6de7ekQ-1; Fri, 08 Jul 2022 07:23:44 -0400
X-MC-Unique: u8WNQsfHPkaFMWU6de7ekQ-1
Received: by mail-qt1-f197.google.com with SMTP id m4-20020aed27c4000000b0031b0ef018aaso18423053qtg.20
        for <linux-kernel@vger.kernel.org>; Fri, 08 Jul 2022 04:23:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=jZKl82+1QA3/A/0McRa1/kVvWc5U9T3I3cW1exdXvaU=;
        b=mmluK0U/dk5v5hBAt7W8LaWfmTggOXR2DAj7DPKJeBKYCZbxbYTYODIIrOejjt9ZuQ
         A/6ga8q/NefOH7/NVpnw1QQT3wYE9DXAIij+L/0A39c7t8ZRUE8m1UOQFEbP3+PXr6L/
         aTAkLYr0aQJ9hUnl55VqWLLpGv11h3wlGPEGJ0Oaujm6eZMsMNTS6WG7G1VmgZcY3RZj
         ntF1TtF/ofNBCCs4ZIohTfpeLeKfACI0tsiRWfhKlALmSTpwqy6+ENppUaw2mLkJQmqB
         pCukjsLh6xb/6hAQWbeuSekXsUucjSNDYXG+OBGFWqHaUkGFl0ZAC7014GlABLKXkVmD
         quag==
X-Gm-Message-State: AJIora9sAKS4b+050XXf8qPqAN3AMdCnS6xLS0JvkXNx1/6Sal1Gdl5X
        0ShsaIoH4ZVjGWJIIXpVchXgvgowrhgpJCFuTjLemmuh3Z/Q2uZSQpObplv3JKsgNpshQlFVQTs
        9aNaBvUEJHrPZZoLPjzKUWohpTM2+B6rvXtk5CVkb
X-Received: by 2002:a05:620a:2005:b0:6b5:6531:ec5e with SMTP id c5-20020a05620a200500b006b56531ec5emr1142823qka.255.1657279423729;
        Fri, 08 Jul 2022 04:23:43 -0700 (PDT)
X-Google-Smtp-Source: AGRyM1u5/pYTjprKCfRi9E/poyeEAeX7KFxDOeaICvdQ3L0cIFLOh++3CfRuHfl/ovzPgNNZxbaURBshZ61LdBYXgnk=
X-Received: by 2002:a05:620a:2005:b0:6b5:6531:ec5e with SMTP id
 c5-20020a05620a200500b006b56531ec5emr1142815qka.255.1657279423491; Fri, 08
 Jul 2022 04:23:43 -0700 (PDT)
MIME-Version: 1.0
References: <20220621151208.189959-1-sgarzare@redhat.com>
In-Reply-To: <20220621151208.189959-1-sgarzare@redhat.com>
From:   Eugenio Perez Martin <eperezma@redhat.com>
Date:   Fri, 8 Jul 2022 13:23:07 +0200
Message-ID: <CAJaqyWfULsXQ4hOovc6CQC5wogkKYxzGwhqFtD-6Te6s+kFy_w@mail.gmail.com>
Subject: Re: [PATCH] vdpa_sim: use max_iotlb_entries as a limit in vhost_iotlb_init
To:     Stefano Garzarella <sgarzare@redhat.com>
Cc:     virtualization <virtualization@lists.linux-foundation.org>,
        "Michael S. Tsirkin" <mst@redhat.com>,
        Gautam Dawar <gautam.dawar@xilinx.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Jason Wang <jasowang@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-3.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 21, 2022 at 5:16 PM Stefano Garzarella <sgarzare@redhat.com> wr=
ote:
>
> Commit bda324fd037a ("vdpasim: control virtqueue support") changed
> the allocation of iotlbs calling vhost_iotlb_init() for each address
> space, instead of vhost_iotlb_alloc().
>
> With this change we forgot to use the limit we had introduced with
> the `max_iotlb_entries` module parameter.
>
> Fixes: bda324fd037a ("vdpasim: control virtqueue support")
> Cc: gautam.dawar@xilinx.com
> Signed-off-by: Stefano Garzarella <sgarzare@redhat.com>

Acked-by: Eugenio P=C3=A9rez <eperezma@redhat.com>

> ---
>  drivers/vdpa/vdpa_sim/vdpa_sim.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/vdpa/vdpa_sim/vdpa_sim.c b/drivers/vdpa/vdpa_sim/vdp=
a_sim.c
> index 0f2865899647..3e81532c01cb 100644
> --- a/drivers/vdpa/vdpa_sim/vdpa_sim.c
> +++ b/drivers/vdpa/vdpa_sim/vdpa_sim.c
> @@ -33,7 +33,7 @@ MODULE_PARM_DESC(batch_mapping, "Batched mapping 1 -Ena=
ble; 0 - Disable");
>  static int max_iotlb_entries =3D 2048;
>  module_param(max_iotlb_entries, int, 0444);
>  MODULE_PARM_DESC(max_iotlb_entries,
> -                "Maximum number of iotlb entries. 0 means unlimited. (de=
fault: 2048)");
> +                "Maximum number of iotlb entries for each address space.=
 0 means unlimited. (default: 2048)");
>
>  #define VDPASIM_QUEUE_ALIGN PAGE_SIZE
>  #define VDPASIM_QUEUE_MAX 256
> @@ -291,7 +291,7 @@ struct vdpasim *vdpasim_create(struct vdpasim_dev_att=
r *dev_attr)
>                 goto err_iommu;
>
>         for (i =3D 0; i < vdpasim->dev_attr.nas; i++)
> -               vhost_iotlb_init(&vdpasim->iommu[i], 0, 0);
> +               vhost_iotlb_init(&vdpasim->iommu[i], max_iotlb_entries, 0=
);
>
>         vdpasim->buffer =3D kvmalloc(dev_attr->buffer_size, GFP_KERNEL);
>         if (!vdpasim->buffer)
> --
> 2.36.1
>

