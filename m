Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 393DC50F09B
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Apr 2022 08:05:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244386AbiDZGIx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Apr 2022 02:08:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60050 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232676AbiDZGIo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Apr 2022 02:08:44 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 9597D3B3E2
        for <linux-kernel@vger.kernel.org>; Mon, 25 Apr 2022 23:05:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1650953136;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=2egRURZGc3X1zsm5gAB76hti2IuqB4ZG8M3lASWWXA4=;
        b=hm3vrFqaWA0JAxNzMccEPIzjHmzB5KeH1ZRwIJ3z8ChqhUkaSj+sGI/OGeyZVgRt1P16w8
        f91ajGObVFgye/qjh3SPttlivIM2hHgmVx+Du9egEnqG0xbV4rvtyH86Mnd5NsLgBpnfqF
        lcXYtiJJVEIKbvBZTp32q0/BGvKvt4Q=
Received: from mail-lj1-f198.google.com (mail-lj1-f198.google.com
 [209.85.208.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-257-MFTJKrmjOZeb-eX5jduekQ-1; Tue, 26 Apr 2022 02:05:35 -0400
X-MC-Unique: MFTJKrmjOZeb-eX5jduekQ-1
Received: by mail-lj1-f198.google.com with SMTP id 20-20020a05651c009400b002462f08f8d2so4219778ljq.2
        for <linux-kernel@vger.kernel.org>; Mon, 25 Apr 2022 23:05:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=2egRURZGc3X1zsm5gAB76hti2IuqB4ZG8M3lASWWXA4=;
        b=JZ6+f0obm+EeABl1mJyzY5NEzvEgQsOlcIaz+SL70GU38/IZ1JVVwla9XD6rEsmpx4
         ZTopCBmKXeH3Wl8hgQ3xT/U7mrpJ9xq3c8jnlW50la44JJnPuxjD3FDPNhQoW9Jz7h96
         CMjTHUp8SOR3+yxUDCq0ifJnbAo7ZBIn2QEqYHCfDE/VJugFYZQLZwcrGkVu2VElW5bR
         df3wlnbk5a03M6+lAsiq+Fe2wLT1AxBsPaTJSsnetV6Xw27QzG3csLKERq2PMf3/5c2F
         /vmTVAxCgaD5B/PTlmsKByJRdVbTBj4/TlDRaFQIJMS1nEbzenO7O4oE20LMy5U4PQJ/
         f97g==
X-Gm-Message-State: AOAM5323O4G8MYyJUHjRaqqH2GZi70nPShIKalEUF9FXGYfivIaPDHNL
        U5ut3v37mqfFUIlC+4FsCuenWd8d4D3TsReY2S/EO1q/QKS3nt0bl88JSRTbaF8vFdhlEhYOI9y
        6Wh+15rlTJrOVMSh9Fl0OPMjXtMKhXzARtwIp2DjT
X-Received: by 2002:a2e:534a:0:b0:24a:f64f:a1d6 with SMTP id t10-20020a2e534a000000b0024af64fa1d6mr13647211ljd.315.1650953133055;
        Mon, 25 Apr 2022 23:05:33 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwvqk67sw4EDGv0ATnZE0rdxm7etQKm8KtJCuN+NgM20B0XOe9lQOGILQ7TAJClGDrxsUb8Af50QocRPtJgc+k=
X-Received: by 2002:a2e:534a:0:b0:24a:f64f:a1d6 with SMTP id
 t10-20020a2e534a000000b0024af64fa1d6mr13647200ljd.315.1650953132889; Mon, 25
 Apr 2022 23:05:32 -0700 (PDT)
MIME-Version: 1.0
References: <20220425062735.172576-2-lulu@redhat.com>
In-Reply-To: <20220425062735.172576-2-lulu@redhat.com>
From:   Jason Wang <jasowang@redhat.com>
Date:   Tue, 26 Apr 2022 14:05:21 +0800
Message-ID: <CACGkMEtGZqoei6i=LmVrTgNfWM4SpxjQH-8j7BP=EoFO=iqeYw@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] vdpa/vp_vdpa : add vdpa tool support in vp_vdpa
To:     Cindy Lu <lulu@redhat.com>
Cc:     mst <mst@redhat.com>,
        virtualization <virtualization@lists.linux-foundation.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 25, 2022 at 2:27 PM Cindy Lu <lulu@redhat.com> wrote:
>
> this patch is to add the support for vdpa tool in vp_vdpa
> here is the example steps
>
> modprobe vp_vdpa
> modprobe vhost_vdpa
> echo 0000:00:06.0>/sys/bus/pci/drivers/virtio-pci/unbind
> echo 1af4 1041 > /sys/bus/pci/drivers/vp-vdpa/new_id
>
> vdpa dev add name vdpa1 mgmtdev pci/0000:00:06.0
>
> Signed-off-by: Cindy Lu <lulu@redhat.com>
> ---
>  drivers/vdpa/virtio_pci/vp_vdpa.c | 138 +++++++++++++++++++++++-------
>  1 file changed, 106 insertions(+), 32 deletions(-)
>
> diff --git a/drivers/vdpa/virtio_pci/vp_vdpa.c b/drivers/vdpa/virtio_pci/vp_vdpa.c
> index cce101e6a940..873402977543 100644
> --- a/drivers/vdpa/virtio_pci/vp_vdpa.c
> +++ b/drivers/vdpa/virtio_pci/vp_vdpa.c
> @@ -32,7 +32,8 @@ struct vp_vring {
>
>  struct vp_vdpa {
>         struct vdpa_device vdpa;
> -       struct virtio_pci_modern_device mdev;
> +       /* this is an pointer point to the mdev in vp_vdpa_mgmtdev*/
> +       struct virtio_pci_modern_device *mdev;

The code can explain itself, so the comment is redundant.

>         struct vp_vring *vring;
>         struct vdpa_callback config_cb;
>         char msix_name[VP_VDPA_NAME_SIZE];
> @@ -41,6 +42,12 @@ struct vp_vdpa {
>         int vectors;
>  };
>
> +struct vp_vdpa_mgmtdev {
> +       struct vdpa_mgmt_dev mgtdev;
> +       struct virtio_pci_modern_device mdev;

I think coupling it with mgmt device is probably not good, any reason
we can't allocate it independently?

Thanks

> +       struct vp_vdpa *vp_vdpa;
> +};

