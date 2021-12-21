Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3967547C2C0
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Dec 2021 16:23:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239294AbhLUPXd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Dec 2021 10:23:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58802 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239283AbhLUPXc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Dec 2021 10:23:32 -0500
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com [IPv6:2a00:1450:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AB566C061574
        for <linux-kernel@vger.kernel.org>; Tue, 21 Dec 2021 07:23:31 -0800 (PST)
Received: by mail-ed1-x52a.google.com with SMTP id y13so53370657edd.13
        for <linux-kernel@vger.kernel.org>; Tue, 21 Dec 2021 07:23:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Rxf1NxPSo8s8xHVSSFeYT/Wi9LLJD3nqrr14uMo0HJM=;
        b=Zm4Kr75mSPUtQUO+AhWnCSQqVqlvVgM0PUHxF2hlOuTBkAdOOsA0VdiUotNjeQ9IrA
         7C6wz3tkc+pZbrUAXKhv91WelhZwKBZfG6bEEEbHALh5tZIBvxHc7ZnoFrk11sHyG9BJ
         cCeO8U/UVSoq4mbBVkHvdShdFeDoz4gMRk9btQJLcbKEzAhcIJUfE1R2X5BuHsNN9lqT
         O0U58vdRVkRF7HfiwjWlqZeEfN5FwtP9PuxGOd7OoU7aTNbTNmYG18bE/hIQoG39QQax
         JfiIA+3d0zLFOhS3WIAQV1hqmWgdy/HFU3qfeg8Ht2847Zfy8gx6Cxei5WJNTFQra9VL
         OTJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Rxf1NxPSo8s8xHVSSFeYT/Wi9LLJD3nqrr14uMo0HJM=;
        b=kNKoWL751L4+cm2moZ+hRWRRRUMPpmLUZQ3Bi/4pskA6qBHojTVJSBN7KUkGQC5Xm3
         WLGXxrF0SGcTspeitTxy1k9Q6ZMeyMRz9WDspMwsCexBKE3yiGpxTcGZmkXtqbp9PZIz
         7bAd3FqhGyFqIFLFarNE+hfL15wd4tYDjkzYtfkwDp8d/dxQ2Xa353+gK7qkaTvvlqAT
         zBLJz4doWQL5vCiRqkCzV8kzp5h8bbCUOKXhgzqLY4YF7I/SFYVNbSVylV798rwBeg/K
         tq/eSesIr2wTaJB8rNGHozHCqtr4862Iv1qfFFT7R9qrGTC+S0qiUL2aNgWPwsm8bMHO
         3dqg==
X-Gm-Message-State: AOAM533RrFQp07pxAFcfH+TE81IsiK7XYrXQwyOj6l2aETAHmNwu05mj
        fBmiFKsbQprFkS8skZefO12PQ+zOVy9zWa2YmpzQ/UEpJZQ=
X-Google-Smtp-Source: ABdhPJy+jIubI85s8a7viK5tSBmJqnt/uKumtZfv/Qds+UeGfXNu5/xBPFYJoQct46aedNtjT2044XfDnRYU039dp2o=
X-Received: by 2002:a50:e611:: with SMTP id y17mr3845710edm.270.1640100210304;
 Tue, 21 Dec 2021 07:23:30 -0800 (PST)
MIME-Version: 1.0
References: <20211220130656.16900-1-vincent.whitchurch@axis.com>
In-Reply-To: <20211220130656.16900-1-vincent.whitchurch@axis.com>
From:   Bartosz Golaszewski <brgl@bgdev.pl>
Date:   Tue, 21 Dec 2021 16:23:19 +0100
Message-ID: <CAMRc=Mcdo9WWX7U=AqwTite=JDEkoSCb-Lwwb+h_=vSFrKMmnQ@mail.gmail.com>
Subject: Re: [PATCH] gpio: virtio: remove timeout
To:     Vincent Whitchurch <vincent.whitchurch@axis.com>
Cc:     "Enrico Weigelt, metux IT consult" <info@metux.net>,
        Viresh Kumar <vireshk@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>, kernel@axis.com,
        "Michael S . Tsirkin" <mst@redhat.com>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        virtualization@lists.linux-foundation.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 20, 2021 at 2:07 PM Vincent Whitchurch
<vincent.whitchurch@axis.com> wrote:
>
> The driver imposes an arbitrary one second timeout on virtio requests,
> but the specification doesn't prevent the virtio device from taking
> longer to process requests, so remove this timeout to support all
> systems and device implementations.
>
> Fixes: 3a29355a22c0275fe86 ("gpio: Add virtio-gpio driver")
> Signed-off-by: Vincent Whitchurch <vincent.whitchurch@axis.com>
> ---
>  drivers/gpio/gpio-virtio.c | 6 +-----
>  1 file changed, 1 insertion(+), 5 deletions(-)
>
> diff --git a/drivers/gpio/gpio-virtio.c b/drivers/gpio/gpio-virtio.c
> index 84f96b78f32a..9f4941bc5760 100644
> --- a/drivers/gpio/gpio-virtio.c
> +++ b/drivers/gpio/gpio-virtio.c
> @@ -100,11 +100,7 @@ static int _virtio_gpio_req(struct virtio_gpio *vgpio, u16 type, u16 gpio,
>         virtqueue_kick(vgpio->request_vq);
>         mutex_unlock(&vgpio->lock);
>
> -       if (!wait_for_completion_timeout(&line->completion, HZ)) {
> -               dev_err(dev, "GPIO operation timed out\n");
> -               ret = -ETIMEDOUT;
> -               goto out;
> -       }
> +       wait_for_completion(&line->completion);
>
>         if (unlikely(res->status != VIRTIO_GPIO_STATUS_OK)) {
>                 dev_err(dev, "GPIO request failed: %d\n", gpio);
> --
> 2.33.1
>

Applied, thanks!

Bart
