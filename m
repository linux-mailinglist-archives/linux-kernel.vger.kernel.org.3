Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ADD7447AF5A
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Dec 2021 16:11:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236906AbhLTPLa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Dec 2021 10:11:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38108 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239722AbhLTPJZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Dec 2021 10:09:25 -0500
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com [IPv6:2a00:1450:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE0BFC079798
        for <linux-kernel@vger.kernel.org>; Mon, 20 Dec 2021 06:55:08 -0800 (PST)
Received: by mail-ed1-x52a.google.com with SMTP id z5so39444873edd.3
        for <linux-kernel@vger.kernel.org>; Mon, 20 Dec 2021 06:55:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=tdE+T3aPoNGPg8ELi+8IVN1k//5ir0X0ohyUgltkbRw=;
        b=Nb2TllzUXYVXEw9dqWf1y4jFHfwAIx8Byw/e52kLdrpLA6yqUiaeF2SehGvQZOCOzp
         JHsotCsFQGEah58nSPzrcFwNexy1c1zSnRf5w1+uiFHkTTZwRVX7/v5gSR08rNxrPLp3
         /IjuqCAbOWDqGJVuUt14YRi+DLw7MNt8t1tYc445UAQN5Gdo9xSPTuBGJrtdD9+11pW3
         fX/ijsxBWl4NcRLG9Dtl+b3fYv7UWbPBnniDn+P5kSu9l7LLrBVR0DsAe0g8AiDYWXIa
         Iqun1+ti0p5uR5Evw/NtBtQOjhwYpP9xsYLZx6dxnOc6diYqzym13S+t+mEydh1fkYGC
         zwJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=tdE+T3aPoNGPg8ELi+8IVN1k//5ir0X0ohyUgltkbRw=;
        b=PDarNKEL4eWdXVIhKDobYrSRUEbb8jPKvF88V7cvtW7pXKyn9DnYynr5QrUnw87iJl
         nEVq/EbO9PojMWh1N86Ni3zu11vXYUOXH2j75qgem7E84G7idKNNfroQy0iGl82f11sF
         7wqxwkgVnv0Ub1LfAjx/Fa04eElvbixVh+Ogv7/ODVhrJvZLM5TVWSPytOfbgmg7iaFC
         WbA0I7ntSMKDHtlF9Gj6Ttjv4VfcpV0C7p+mS6C8fkdiUoBOe+7sORVs0bRm5AtGq36K
         Td753Df2/NhJTs9WX61pT5lv6yMyB1F1AbM6QCnsOTpFp4gY5NrcVJzOQMvfsgxjnneq
         ddyg==
X-Gm-Message-State: AOAM531Eb5aSxE3caPf3FHbYXk6W+hcn1lb57cyt16rzSHnv0V7scxoY
        gAfqRSI/y2gGnJOglG1IcdWIlZnjjfqzXoLzTbGojAmYwFA=
X-Google-Smtp-Source: ABdhPJxoWrYUKazioQqsvjf7ytmFNN+yKdjGGZpYezKULEb8U/6B38TWYAZ17Xk5+OZe0lgIMwn4DkfSd9x9u723RtY=
X-Received: by 2002:a50:e611:: with SMTP id y17mr16436969edm.270.1640012107378;
 Mon, 20 Dec 2021 06:55:07 -0800 (PST)
MIME-Version: 1.0
References: <20211220130656.16900-1-vincent.whitchurch@axis.com>
In-Reply-To: <20211220130656.16900-1-vincent.whitchurch@axis.com>
From:   Bartosz Golaszewski <brgl@bgdev.pl>
Date:   Mon, 20 Dec 2021 15:54:56 +0100
Message-ID: <CAMRc=MeEnSvSxQe-DdLSujSLpzxa-bacJ590BW+tt8awAJq3_w@mail.gmail.com>
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

My knowledge of virtio is limited, I hope this is not a stupid question.

Does this mean the operation can get stuck indefinitely?

Bart
