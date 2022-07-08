Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 517BE56B854
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Jul 2022 13:22:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237932AbiGHLWd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Jul 2022 07:22:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49214 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237709AbiGHLWc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Jul 2022 07:22:32 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 4F3ED904C0
        for <linux-kernel@vger.kernel.org>; Fri,  8 Jul 2022 04:22:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1657279349;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=u3x0OQw/GTFUegDf3IMVNmmEenpWbPlA4h7loRLkF6U=;
        b=QiOxEGvUx/I6j8NjIYQt/sCiItIJVIfYliRQfuoUXMMIquFNYlxH+wQCLKLOeKmvVA/lJF
        e+sCnAAnBwUiLyNVAfdZJAc2xYATNdSoSMkRYFJS88aaZUMB4TQa4Hw6/aSur0+QounSzz
        OxHApfVNlcKumzmK70Czj0qMGPUmTCU=
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-435-TULjvZS3O9mikUuJBtIwxw-1; Fri, 08 Jul 2022 07:22:22 -0400
X-MC-Unique: TULjvZS3O9mikUuJBtIwxw-1
Received: by mail-qk1-f198.google.com with SMTP id bm2-20020a05620a198200b006a5dac37fa2so20703098qkb.16
        for <linux-kernel@vger.kernel.org>; Fri, 08 Jul 2022 04:22:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=u3x0OQw/GTFUegDf3IMVNmmEenpWbPlA4h7loRLkF6U=;
        b=3yZn15eGz2QvMTHIOT/f7uPsSsPccpv75ikGcHhEtN4+MrTGjYI6T8Vc6hR/aBBof4
         kMyJxOiqaGDswbGdIKnTZ3Le+cmMzY5Pr155oluSzHRYVjJovpvC16St7KxEx1KrOwpZ
         1POk09ZFyhhP6qtjIC+yoz5WtDaeLgLrEKQ2AlbRjwLV9uM44cnU48P8rg9wLfPCjwoL
         vnXWlqxt472saaYJXBnv7dvm0dsvbFq4MvwA3/n32YT8KO+68MoJNJijiu4NVsMFF0gO
         xuXsGr6qzqZ5fbj2sEFH/D37zAKGmCu8aLzqrszOFxZJz/v7oJmF4d3DMFDMZv/8vrIh
         GC7Q==
X-Gm-Message-State: AJIora+LDHfXoC+blgSMA0t6U/akf4v7DlZ9OaS+M7bkU7WVWj59a15G
        X86ZYpQqeV7pOwnGqJX38XZAJMT0jDNXJvno7a92lQn4HHL7gjCuhVARSwg5vztvkG+yn8no0F3
        fG4O2YaZtY23Lg5rqNKbqu/ySZqd+GhS1qqMbex8Q
X-Received: by 2002:a0c:fe48:0:b0:462:6a02:a17d with SMTP id u8-20020a0cfe48000000b004626a02a17dmr2163948qvs.108.1657279342437;
        Fri, 08 Jul 2022 04:22:22 -0700 (PDT)
X-Google-Smtp-Source: AGRyM1vrL85pmnm5ItEBbZwgGhAFmNL2/Db+B/g+JqFjLltq8vOJKoTmcfo5J6o5O3Eb9tnXEskHW/qe3NYZ9EiLlB0=
X-Received: by 2002:a0c:fe48:0:b0:462:6a02:a17d with SMTP id
 u8-20020a0cfe48000000b004626a02a17dmr2163935qvs.108.1657279342195; Fri, 08
 Jul 2022 04:22:22 -0700 (PDT)
MIME-Version: 1.0
References: <20220621151323.190431-1-sgarzare@redhat.com>
In-Reply-To: <20220621151323.190431-1-sgarzare@redhat.com>
From:   Eugenio Perez Martin <eperezma@redhat.com>
Date:   Fri, 8 Jul 2022 13:21:46 +0200
Message-ID: <CAJaqyWdOSGLpks8ohTXcmv9c2vrsUr01bbCtK9h9yQ0-63Dpvg@mail.gmail.com>
Subject: Re: [PATCH] vdpa_sim_blk: set number of address spaces and virtqueue groups
To:     Stefano Garzarella <sgarzare@redhat.com>
Cc:     virtualization <virtualization@lists.linux-foundation.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        "Michael S. Tsirkin" <mst@redhat.com>,
        Jason Wang <jasowang@redhat.com>,
        Gautam Dawar <gautam.dawar@xilinx.com>
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

On Tue, Jun 21, 2022 at 5:17 PM Stefano Garzarella <sgarzare@redhat.com> wr=
ote:
>
> Commit bda324fd037a ("vdpasim: control virtqueue support") added two
> new fields (nas, ngroups) to vdpasim_dev_attr, but we forgot to
> initialize them for vdpa_sim_blk.
>
> When creating a new vdpa_sim_blk device this causes the kernel
> to panic in this way:
>     $ vdpa dev add mgmtdev vdpasim_blk name blk0
>     BUG: kernel NULL pointer dereference, address: 0000000000000030
>     ...
>     RIP: 0010:vhost_iotlb_add_range_ctx+0x41/0x220 [vhost_iotlb]
>     ...
>     Call Trace:
>      <TASK>
>      vhost_iotlb_add_range+0x11/0x800 [vhost_iotlb]
>      vdpasim_map_range+0x91/0xd0 [vdpa_sim]
>      vdpasim_alloc_coherent+0x56/0x90 [vdpa_sim]
>      ...
>
> This happens because vdpasim->iommu[0] is not initialized when
> dev_attr.nas is 0.
>
> Let's fix this issue by initializing both (nas, ngroups) to 1 for
> vdpa_sim_blk.
>
> Fixes: bda324fd037a ("vdpasim: control virtqueue support")
> Cc: gautam.dawar@xilinx.com
> Signed-off-by: Stefano Garzarella <sgarzare@redhat.com>

Acked-by: Eugenio P=C3=A9rez <eperezma@redhat.com>

> ---
>  drivers/vdpa/vdpa_sim/vdpa_sim_blk.c | 6 ++++++
>  1 file changed, 6 insertions(+)
>
> diff --git a/drivers/vdpa/vdpa_sim/vdpa_sim_blk.c b/drivers/vdpa/vdpa_sim=
/vdpa_sim_blk.c
> index 42d401d43911..03a28def8eee 100644
> --- a/drivers/vdpa/vdpa_sim/vdpa_sim_blk.c
> +++ b/drivers/vdpa/vdpa_sim/vdpa_sim_blk.c
> @@ -34,7 +34,11 @@
>  #define VDPASIM_BLK_CAPACITY   0x40000
>  #define VDPASIM_BLK_SIZE_MAX   0x1000
>  #define VDPASIM_BLK_SEG_MAX    32
> +
> +/* 1 virtqueue, 1 address space, 1 virtqueue group */
>  #define VDPASIM_BLK_VQ_NUM     1
> +#define VDPASIM_BLK_AS_NUM     1
> +#define VDPASIM_BLK_GROUP_NUM  1
>
>  static char vdpasim_blk_id[VIRTIO_BLK_ID_BYTES] =3D "vdpa_blk_sim";
>
> @@ -260,6 +264,8 @@ static int vdpasim_blk_dev_add(struct vdpa_mgmt_dev *=
mdev, const char *name,
>         dev_attr.id =3D VIRTIO_ID_BLOCK;
>         dev_attr.supported_features =3D VDPASIM_BLK_FEATURES;
>         dev_attr.nvqs =3D VDPASIM_BLK_VQ_NUM;
> +       dev_attr.ngroups =3D VDPASIM_BLK_GROUP_NUM;
> +       dev_attr.nas =3D VDPASIM_BLK_AS_NUM;
>         dev_attr.config_size =3D sizeof(struct virtio_blk_config);
>         dev_attr.get_config =3D vdpasim_blk_get_config;
>         dev_attr.work_fn =3D vdpasim_blk_work;
> --
> 2.36.1
>

