Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5271156B277
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Jul 2022 08:00:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237177AbiGHGA1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Jul 2022 02:00:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38080 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237133AbiGHGA0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Jul 2022 02:00:26 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 7FBEF796B0
        for <linux-kernel@vger.kernel.org>; Thu,  7 Jul 2022 23:00:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1657260024;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=VdKKna492ZuNX3D+72shOPOSeJ4spzTkUN1n9gAILF4=;
        b=Q9j2U3MkyGW/sm032uaKhtBM5Hk930wXpnvDoMgHKcRnhXtY1zqaFY4G2d3/BggxSSTvK7
        feM+rOy5lO/3UTDbVfahJRfURQwCdlBzGM31+g/Nt29DLYVWYuy7lkjdn/7dpgHdsuqU89
        3Rq9hIM/oCPo3U74uIA4QtUVGgUYNCw=
Received: from mail-lf1-f70.google.com (mail-lf1-f70.google.com
 [209.85.167.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-482-1MD-8b5IPoeeqizQzFCpHg-1; Fri, 08 Jul 2022 02:00:23 -0400
X-MC-Unique: 1MD-8b5IPoeeqizQzFCpHg-1
Received: by mail-lf1-f70.google.com with SMTP id e10-20020a19674a000000b0047f8d95f43cso7347587lfj.0
        for <linux-kernel@vger.kernel.org>; Thu, 07 Jul 2022 23:00:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=VdKKna492ZuNX3D+72shOPOSeJ4spzTkUN1n9gAILF4=;
        b=OPCeq/EZWyKjhE7ADrJDQt+46crjx8ckXzHdwH5M+61+8kokH2yOcldJ94UNe2aBRl
         zWPH8xz+csdgGWsUJE0foAm7MsuAsMjqdmr37eippHj2u5ii0J184/lfCcpEnj4e7Bx+
         lm0/Nr6I3/wYRZiDrU8rm4SXkTtUhNkxsOe7QcJZSjw6V7+ocesxdcrKjqHQVd8IvyS+
         XHU3XAoKBvA15nYyCoHxE7u9jD0gbopfQtEh7BbsLk9aqYNAgCpIbssT1w8B7RBElMcv
         pEFyPrUluJXqjV3Iklzee3OYsOWHcEk2jn0SY4JCAwa+oLyXSZxJ+ZqL/Dr3x1QaJeph
         fmpg==
X-Gm-Message-State: AJIora/9+zfLpIcutE1Y5ZD+iELccGk2/Ohuy21sId+Npe+KkBQ6em6S
        aRM1H3tz9r9dg6LQEGetHfCn6w2YScQx+KKeh+BfwSa+K5Rn6W426FxWoQAUX6V/3MDBs/gm34S
        kPep20hAXKjEMBRJdJMFWVkLTXMiZR+n4Mj5VwwFz
X-Received: by 2002:a05:6512:ba1:b0:47f:c0bd:7105 with SMTP id b33-20020a0565120ba100b0047fc0bd7105mr1326051lfv.641.1657260021395;
        Thu, 07 Jul 2022 23:00:21 -0700 (PDT)
X-Google-Smtp-Source: AGRyM1tOMJxokEf+TWe5wm0bW58Mnjk/5eCF7RONI4FfMSWrXOFRWLD7jzXM+KMEOGYRQ6ibDZ1CxMIyr37UhTtOQBA=
X-Received: by 2002:a05:6512:ba1:b0:47f:c0bd:7105 with SMTP id
 b33-20020a0565120ba100b0047fc0bd7105mr1326040lfv.641.1657260021184; Thu, 07
 Jul 2022 23:00:21 -0700 (PDT)
MIME-Version: 1.0
References: <20220707031751.4802-1-liubo03@inspur.com>
In-Reply-To: <20220707031751.4802-1-liubo03@inspur.com>
From:   Jason Wang <jasowang@redhat.com>
Date:   Fri, 8 Jul 2022 14:00:09 +0800
Message-ID: <CACGkMEujMgP=QbQte6Hjv2DXp7TYJXQvu8uK3=h130pcr6eYsg@mail.gmail.com>
Subject: Re: [PATCH] virtio: Check dev_set_name() return value
To:     Bo Liu <liubo03@inspur.com>
Cc:     mst <mst@redhat.com>,
        virtualization <virtualization@lists.linux-foundation.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 7, 2022 at 11:18 AM Bo Liu <liubo03@inspur.com> wrote:
>
> It's possible that dev_set_name() returns -ENOMEM, catch and handle this.
>
> Signed-off-by: Bo Liu <liubo03@inspur.com>

Acked-by: Jason Wang <jasowang@redhat.com>

> ---
>  drivers/virtio/virtio.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/virtio/virtio.c b/drivers/virtio/virtio.c
> index 7deeed30d1f3..ddd4466da83b 100644
> --- a/drivers/virtio/virtio.c
> +++ b/drivers/virtio/virtio.c
> @@ -428,7 +428,9 @@ int register_virtio_device(struct virtio_device *dev)
>                 goto out;
>
>         dev->index = err;
> -       dev_set_name(&dev->dev, "virtio%u", dev->index);
> +       err = dev_set_name(&dev->dev, "virtio%u", dev->index);
> +       if (err)
> +               goto out_ida_remove;
>
>         err = virtio_device_of_init(dev);
>         if (err)
> --
> 2.27.0
>

