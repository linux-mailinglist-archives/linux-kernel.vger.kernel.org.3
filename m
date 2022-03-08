Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 597254D0FF4
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Mar 2022 07:17:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238133AbiCHGR2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Mar 2022 01:17:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44984 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344406AbiCHGRI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Mar 2022 01:17:08 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id ABF8A2E6BE
        for <linux-kernel@vger.kernel.org>; Mon,  7 Mar 2022 22:16:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1646720171;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=c5ugwLO4/RAIk+A33RH1Nda04XboyFL8Xk9nspKrv+Q=;
        b=KroPkbxi1L9hH/HmXZgxQhdBuekA4HxqXcDzsresT6Cwo1ZF2iPR2/08WoFCAlgUegXm4H
        tteJRZtglg8X/UYn6LVuSY0XdpzFn7lOtlTOiezUxssBHnJgsCusmhMTCkJBfuEoQDTgby
        9yPcyxLQDV/WOkXeKQYUcHYFAWasC08=
Received: from mail-lf1-f72.google.com (mail-lf1-f72.google.com
 [209.85.167.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-190-CjUjc8p6Ne2On3LACfWhzg-1; Tue, 08 Mar 2022 01:16:10 -0500
X-MC-Unique: CjUjc8p6Ne2On3LACfWhzg-1
Received: by mail-lf1-f72.google.com with SMTP id j22-20020a05651231d600b0044830cff16fso1264983lfe.12
        for <linux-kernel@vger.kernel.org>; Mon, 07 Mar 2022 22:16:10 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=c5ugwLO4/RAIk+A33RH1Nda04XboyFL8Xk9nspKrv+Q=;
        b=KjAbrA/1O7JprwWMGDo0guv8h82fAP8hUfkuSPjdhadsUGWh4kv4cY331PyObUIBGR
         gk1Z4WEbps7ZWP/QbASD1+nW8j3klnbNkFmn/JWUlTRUzmzLvQc2vxIqnjsF52+t1b7q
         d7OJFUpWnVVq8wOISehchCoitBqPED/6O5SrcFLEoVURsSnBUwRdlNQaIPYpc9lHe4UH
         9l/rRFSPXlTIORZd7TnfAHq3MxSjY9EkH0Z22+8JxQIHXQiEWJMr2PVyCiRkUpSfDO79
         yBtSj0FiZILbMZ9dAzOVfsX/j7yNu0yU0wRfg4EEj5zXT5QdMHYmfzI+428VHTTm2JQJ
         QOGg==
X-Gm-Message-State: AOAM532EAD7ZdhVdb2gMjs506Lx+aKORq+WoZk9ZBzy0M62xNZGEd0JK
        pAr8/fjqCQritA/L1ykfTrH09l8bzfl0bEQtUP6EOSjmRKDaNQWFBu5AWiysFi7SqYja00M8dXq
        fjvEOFLptrXValEvzi6bcLo9NNHZ/3I+rKVXeXXTd
X-Received: by 2002:a2e:9045:0:b0:247:da7d:a460 with SMTP id n5-20020a2e9045000000b00247da7da460mr9533965ljg.300.1646720168270;
        Mon, 07 Mar 2022 22:16:08 -0800 (PST)
X-Google-Smtp-Source: ABdhPJxait3lv+dLzC+BdDFV83vSleLNh5HIk4y197ubAHp3aPkfzkCIzF+1Ixw1dsakTX8Qi9vOeSnOuGXbcvWoGxY=
X-Received: by 2002:a2e:9045:0:b0:247:da7d:a460 with SMTP id
 n5-20020a2e9045000000b00247da7da460mr9533952ljg.300.1646720167963; Mon, 07
 Mar 2022 22:16:07 -0800 (PST)
MIME-Version: 1.0
References: <20220307191757.3177139-1-lee.jones@linaro.org>
In-Reply-To: <20220307191757.3177139-1-lee.jones@linaro.org>
From:   Jason Wang <jasowang@redhat.com>
Date:   Tue, 8 Mar 2022 14:15:56 +0800
Message-ID: <CACGkMEsjmCNQPjxPjXL0WUfbMg8ARnumEp4yjUxqznMKR1nKSQ@mail.gmail.com>
Subject: Re: [PATCH 1/1] vhost: Protect the virtqueue from being cleared
 whilst still in use
To:     Lee Jones <lee.jones@linaro.org>
Cc:     mst <mst@redhat.com>, linux-kernel <linux-kernel@vger.kernel.org>,
        kvm <kvm@vger.kernel.org>,
        virtualization <virtualization@lists.linux-foundation.org>,
        netdev <netdev@vger.kernel.org>, stable@vger.kernel.org,
        syzbot+adc3cb32385586bec859@syzkaller.appspotmail.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 8, 2022 at 3:18 AM Lee Jones <lee.jones@linaro.org> wrote:
>
> vhost_vsock_handle_tx_kick() already holds the mutex during its call
> to vhost_get_vq_desc().  All we have to do here is take the same lock
> during virtqueue clean-up and we mitigate the reported issues.
>
> Also WARN() as a precautionary measure.  The purpose of this is to
> capture possible future race conditions which may pop up over time.
>
> Link: https://syzkaller.appspot.com/bug?extid=279432d30d825e63ba00
>
> Cc: <stable@vger.kernel.org>
> Reported-by: syzbot+adc3cb32385586bec859@syzkaller.appspotmail.com
> Signed-off-by: Lee Jones <lee.jones@linaro.org>
> ---
>  drivers/vhost/vhost.c | 10 ++++++++++
>  1 file changed, 10 insertions(+)
>
> diff --git a/drivers/vhost/vhost.c b/drivers/vhost/vhost.c
> index 59edb5a1ffe28..ef7e371e3e649 100644
> --- a/drivers/vhost/vhost.c
> +++ b/drivers/vhost/vhost.c
> @@ -693,6 +693,15 @@ void vhost_dev_cleanup(struct vhost_dev *dev)
>         int i;
>
>         for (i = 0; i < dev->nvqs; ++i) {
> +               /* No workers should run here by design. However, races have
> +                * previously occurred where drivers have been unable to flush
> +                * all work properly prior to clean-up.  Without a successful
> +                * flush the guest will malfunction, but avoiding host memory
> +                * corruption in those cases does seem preferable.
> +                */
> +               WARN_ON(mutex_is_locked(&dev->vqs[i]->mutex));
> +

I don't get how this can help, the mutex could be grabbed in the
middle of the above and below line.

> +               mutex_lock(&dev->vqs[i]->mutex);
>                 if (dev->vqs[i]->error_ctx)
>                         eventfd_ctx_put(dev->vqs[i]->error_ctx);
>                 if (dev->vqs[i]->kick)
> @@ -700,6 +709,7 @@ void vhost_dev_cleanup(struct vhost_dev *dev)
>                 if (dev->vqs[i]->call_ctx.ctx)
>                         eventfd_ctx_put(dev->vqs[i]->call_ctx.ctx);
>                 vhost_vq_reset(dev, dev->vqs[i]);
> +               mutex_unlock(&dev->vqs[i]->mutex);
>         }

I'm not sure it's correct to assume some behaviour of a buggy device.
For the device mutex, we use that to protect more than just err/call
and vq.

Thanks

>         vhost_dev_free_iovecs(dev);
>         if (dev->log_ctx)
> --
> 2.35.1.616.g0bdcbb4464-goog
>

