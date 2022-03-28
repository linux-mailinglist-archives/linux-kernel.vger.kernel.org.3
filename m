Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9015E4EA23F
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Mar 2022 23:08:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229891AbiC1VKX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Mar 2022 17:10:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54916 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229662AbiC1VKQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Mar 2022 17:10:16 -0400
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com [IPv6:2a00:1450:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C1AEF20F7C
        for <linux-kernel@vger.kernel.org>; Mon, 28 Mar 2022 14:08:33 -0700 (PDT)
Received: by mail-ej1-x62a.google.com with SMTP id r13so31221369ejd.5
        for <linux-kernel@vger.kernel.org>; Mon, 28 Mar 2022 14:08:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Gy52q0hk0EOe2yARL7BLFUrhC07yc/LGzLY5hvJWd9Q=;
        b=PspVM/NGsYmmepvwb7RIAfO4OVL1acnHrWJHnRYbUv5gXs6ulNmvXMW2TyCbx5Q7Yk
         RcTiAFURzmyQiGtT6oGZjLVWGifIlTDuAhMA1jenOe/Ptz3rorytIwMJ6Y9H0kribuVR
         NjaBTSekKRGEvfLcvBKtlgYJu4sjoYMv/TRgRND2J+PaeJymdZeJEpUm2ndWoLA12z6a
         0+BxKzfI8SwJ521yviTn1P6Xfn9uwZ9Dc2knM62zK++NGw1xu9YpOev6kwIoarH0ywVl
         C5/NNpMFgBtOIpU4gEwMOduyuUFvYSMvVNeWJBoPg0SXvoZ4uLz5BOXexjGT8HlcE05X
         kcZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Gy52q0hk0EOe2yARL7BLFUrhC07yc/LGzLY5hvJWd9Q=;
        b=cs86zCo9syL4aO5m2lBRunTSG9mxqUZdihqM0u45GBFyqzQfiEt6uwyETfnjHJg8TJ
         IfAm8YBNn+8E/UOYtfjXjzuim0MHaZooV1yqPNZH1puqCX98fjLX50Zc6C0442Nayfwn
         UOUh8Oe+DAUgpDdtGOicKell1QOvNqRcdFXR9uYA6IHazYQOqrC54rgcHWutD5hgPHMq
         x9E6dVl6UwfkajWAjZvsiVGKkaWc7P3DaMUzztlSjHDS9m9vxHGHzCOtDi3wIepr6Z1z
         /pdofLKbo4rRXss6U9DWxnPefQE1p5Q9njbWEugz0OSq8ubjMMdC+s9sv3zKa9Dg15YQ
         g56Q==
X-Gm-Message-State: AOAM531KmeApUq1AA38NFNQL0mD5IioQ1ofWtkHvPLb4YSxGZZo4CVVE
        B+XBmzMqgvjMMbU3p+baa57DrBsgUwPjXDii2Do=
X-Google-Smtp-Source: ABdhPJzF/ITADHePLd7Kqd1BNDEpYjsT1pDu1lP5yP42YMsGsMH5XWm/84sNviYmE9deBAzqOUwNaIpmQ1r5e4feVGc=
X-Received: by 2002:a17:907:3e92:b0:6df:cb08:14f5 with SMTP id
 hs18-20020a1709073e9200b006dfcb0814f5mr31124556ejc.308.1648501711578; Mon, 28
 Mar 2022 14:08:31 -0700 (PDT)
MIME-Version: 1.0
References: <20220327050945.1614-1-xiam0nd.tong@gmail.com>
In-Reply-To: <20220327050945.1614-1-xiam0nd.tong@gmail.com>
From:   Chia-I Wu <olvaffe@gmail.com>
Date:   Mon, 28 Mar 2022 14:08:20 -0700
Message-ID: <CAPaKu7Q54aumxEjih3v=xiW3NG7ct1O5UBzyqMQ0bug4svy-5g@mail.gmail.com>
Subject: Re: [PATCH] virtio-gpu: fix a missing check to avoid NULL dereference
To:     Xiaomeng Tong <xiam0nd.tong@gmail.com>
Cc:     David Airlie <airlied@linux.ie>, Gerd Hoffmann <kraxel@redhat.com>,
        Gurchetan Singh <gurchetansingh@chromium.org>,
        Daniel Vetter <daniel@ffwll.ch>,
        Dave Airlie <airlied@redhat.com>,
        ML dri-devel <dri-devel@lists.freedesktop.org>,
        "open list:VIRTIO CORE, NET AND BLOCK DRIVERS" 
        <virtualization@lists.linux-foundation.org>,
        open list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Mar 26, 2022 at 10:09 PM Xiaomeng Tong <xiam0nd.tong@gmail.com> wrote:
>
> 'cache_ent' could be set NULL inside virtio_gpu_cmd_get_capset()
> and it will lead to a NULL dereference by a lately use of it
> (i.e., ptr = cache_ent->caps_cache). Fix it with a NULL check.
>
> Fixes: 62fb7a5e10962 ("virtio-gpu: add 3d/virgl support")
> Signed-off-by: Xiaomeng Tong <xiam0nd.tong@gmail.com>
Reviewed-by: Chia-I Wu <olvaffe@gmail.com>
> ---
>  drivers/gpu/drm/virtio/virtgpu_ioctl.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/virtio/virtgpu_ioctl.c b/drivers/gpu/drm/virtio/virtgpu_ioctl.c
> index c708bab555c6..b0f1c4d8fd23 100644
> --- a/drivers/gpu/drm/virtio/virtgpu_ioctl.c
> +++ b/drivers/gpu/drm/virtio/virtgpu_ioctl.c
> @@ -579,8 +579,10 @@ static int virtio_gpu_get_caps_ioctl(struct drm_device *dev,
>         spin_unlock(&vgdev->display_info_lock);
>
>         /* not in cache - need to talk to hw */
> -       virtio_gpu_cmd_get_capset(vgdev, found_valid, args->cap_set_ver,
> +       ret = virtio_gpu_cmd_get_capset(vgdev, found_valid, args->cap_set_ver,
>                                   &cache_ent);
> +       if (ret)
> +               return ret;
>         virtio_gpu_notify(vgdev);
>
>  copy_exit:
>
> base-commit: f443e374ae131c168a065ea1748feac6b2e76613
> --
> 2.17.1
>
