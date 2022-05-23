Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 90941530878
	for <lists+linux-kernel@lfdr.de>; Mon, 23 May 2022 06:41:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229539AbiEWEl1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 May 2022 00:41:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42770 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229851AbiEWElX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 May 2022 00:41:23 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id B1EBE6345
        for <linux-kernel@vger.kernel.org>; Sun, 22 May 2022 21:41:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1653280879;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=08y9EJtcz+7a/JcW5CAQJh1vaSn+lYtCa1y1S5/rUOM=;
        b=dOTxSxS1WagJmeEityGz2xpT572VJvoCT4WbLvvORnu5BDY6jQISUTPYdIrYH4AYuXUUO8
        N1LIuyNtz8szUiV6eVVA9lrPQ7kOmH/mYLV9kIs+EiA07gjrG1Xx7WEuGY01ehA8GSKnK+
        8xTBU9F8TGmXOpQrYvaRAnOwh04x8+w=
Received: from mail-lf1-f71.google.com (mail-lf1-f71.google.com
 [209.85.167.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-354-BZV11lDBMbGupL4Hp6xfDA-1; Mon, 23 May 2022 00:41:18 -0400
X-MC-Unique: BZV11lDBMbGupL4Hp6xfDA-1
Received: by mail-lf1-f71.google.com with SMTP id bi27-20020a0565120e9b00b004786caccc7dso1019730lfb.11
        for <linux-kernel@vger.kernel.org>; Sun, 22 May 2022 21:41:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=08y9EJtcz+7a/JcW5CAQJh1vaSn+lYtCa1y1S5/rUOM=;
        b=jKpdboXlB6u/QnmcfTBeGZt0ULwS7eJsQEYM8ADZ2JDlciNzc4CQwwXTYZx86D0tcZ
         16GXFfyICQ88G0Px0IUDU6jhtrJQ3HokWsMV3jw7pg22qsSh++OGylDBNOAAfLXOU1GI
         nq6lB5z9f4NhMxuMYdoFF3dkDaXg3P40+/tByMJa3Pg4I1sgUA9tGLwu/j/Q4WiD16xo
         7YUjh+rDxqh/08+ueeAtIzMyihgxkA2GODvM1tKIM7HrHEXlY0LeeICGSwjjazwkFx0L
         /P2KsbIIC/WbNt0q1NzV/59qdnJVePubDdU2HX2R/EFe4QCyhDGttQJ89aIoJEclAb6U
         36Sw==
X-Gm-Message-State: AOAM530Eb22NeZzSCiC/t0cJ3oDjPkJM1FM94Yt8XNfj8E8mFfCG7fmU
        2B/46uHsRu7ZaiNMbS/Ziui5661XPZFNkRl3Rf5zfLLJhAwECIfvuYNf+QWMnvhLCa3COAswdr7
        +Pegpf+dlC7TuVjMvxi2QJl0luFzzxpIBvQMRBMFX
X-Received: by 2002:a05:6512:1588:b0:477:a556:4ab2 with SMTP id bp8-20020a056512158800b00477a5564ab2mr15008560lfb.376.1653280875765;
        Sun, 22 May 2022 21:41:15 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxqRetp33JcfidVaUk+iFKExKrB3v7QK7jBSPRLyLJwJHS8cGFd1P5dpWd3xCNGBT0hiuY9YQ5gpi2GOTwnZdI=
X-Received: by 2002:a05:6512:1588:b0:477:a556:4ab2 with SMTP id
 bp8-20020a056512158800b00477a5564ab2mr15008553lfb.376.1653280875600; Sun, 22
 May 2022 21:41:15 -0700 (PDT)
MIME-Version: 1.0
References: <89ef0ae4c26ac3cfa440c71e97e392dcb328ac1b.1653227924.git.christophe.jaillet@wanadoo.fr>
In-Reply-To: <89ef0ae4c26ac3cfa440c71e97e392dcb328ac1b.1653227924.git.christophe.jaillet@wanadoo.fr>
From:   Jason Wang <jasowang@redhat.com>
Date:   Mon, 23 May 2022 12:41:03 +0800
Message-ID: <CACGkMEtvgL+MxBmhWZ-Hn-QjfS-MBm7gvLoQHhazOiwrLxxUJA@mail.gmail.com>
Subject: Re: [PATCH] vhost-vdpa: Fix some error handling path in vhost_vdpa_process_iotlb_msg()
To:     Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Cc:     Dan Carpenter <dan.carpenter@oracle.com>,
        "Michael S. Tsirkin" <mst@redhat.com>,
        Gautam Dawar <gautam.dawar@xilinx.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        kernel-janitors@vger.kernel.org, kvm <kvm@vger.kernel.org>,
        virtualization <virtualization@lists.linux-foundation.org>,
        netdev <netdev@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, May 22, 2022 at 9:59 PM Christophe JAILLET
<christophe.jaillet@wanadoo.fr> wrote:
>
> In the error paths introduced by the commit in the Fixes tag, a mutex may
> be left locked.
> Add the correct goto instead of a direct return.
>
> Fixes: a1468175bb17 ("vhost-vdpa: support ASID based IOTLB API")
> Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
> ---
> WARNING: This patch only fixes the goto vs return mix-up in this function.
> However, the 2nd hunk looks really spurious to me. I think that the:
> -               return -EINVAL;
> +               r = -EINVAL;
> +               goto unlock;
> should be done only in the 'if (!iotlb)' block.

It should be fine, the error happen if

1) the batched ASID based request is not equal (the first if)
2) there's no IOTLB for this ASID (the second if)

But I agree the code could be tweaked to use two different if instead
of using a or condition here.

Acked-by: Jason Wang <jasowang@redhat.com>

>
> As I don't know this code, I just leave it as-is but draw your attention
> in case this is another bug lurking.
> ---
>  drivers/vhost/vdpa.c | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/vhost/vdpa.c b/drivers/vhost/vdpa.c
> index 1f1d1c425573..3e86080041fc 100644
> --- a/drivers/vhost/vdpa.c
> +++ b/drivers/vhost/vdpa.c
> @@ -1000,7 +1000,8 @@ static int vhost_vdpa_process_iotlb_msg(struct vhost_dev *dev, u32 asid,
>                 if (!as) {
>                         dev_err(&v->dev, "can't find and alloc asid %d\n",
>                                 asid);
> -                       return -EINVAL;
> +                       r = -EINVAL;
> +                       goto unlock;
>                 }
>                 iotlb = &as->iotlb;
>         } else
> @@ -1013,7 +1014,8 @@ static int vhost_vdpa_process_iotlb_msg(struct vhost_dev *dev, u32 asid,
>                 }
>                 if (!iotlb)
>                         dev_err(&v->dev, "no iotlb for asid %d\n", asid);
> -               return -EINVAL;
> +               r = -EINVAL;
> +               goto unlock;
>         }
>
>         switch (msg->type) {
> --
> 2.34.1
>

