Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E860347B05E
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Dec 2021 16:35:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235199AbhLTPfS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Dec 2021 10:35:18 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124]:53577 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231589AbhLTPfQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Dec 2021 10:35:16 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1640014515;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=gdAKE7AYio9k8Fn74B3MejAzlS0bLe3U5EfQ2P/VNeg=;
        b=KS0SEEAUouCZ20HBqVxAy+zLnrIUlDfw3i14KiL7eFInt7MEVues08XgFWI3uGDwJSE+WZ
        Q6CJVJC//qzwScCjuLJl1uP3RdGHtRB9/h5OMwXOV6Qjy3eOnf3ZhbG7PiuKvzPN0zHoTW
        Ai9sBwR7g0BRp3iAXXwCvNEwxZ5/PwI=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-461-HrOF1xyVN3i6S1Jzm68guA-1; Mon, 20 Dec 2021 10:35:14 -0500
X-MC-Unique: HrOF1xyVN3i6S1Jzm68guA-1
Received: by mail-wm1-f72.google.com with SMTP id l6-20020a05600c4f0600b0033321934a39so73001wmq.9
        for <linux-kernel@vger.kernel.org>; Mon, 20 Dec 2021 07:35:14 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=gdAKE7AYio9k8Fn74B3MejAzlS0bLe3U5EfQ2P/VNeg=;
        b=qwjGw+QDi/iqZBhadYyBd8oadrybT8cFwAeJeJLEqbVqjpHzek4mQO/ZVROzSkJeEt
         Jyd8vGhcl32V2sp78VgasoKR03AsELLdhE/u2Cd4px8FNH7rWXmL2L7CHBlUj+bIDRDP
         HoRlGB8EuZJJgWDMHc1yhQXL8cFrWZhflQYUBek1c6cNgY3VoHx6lRB09zCSbqJFC5Ef
         NxDy1Z+hgBDkk2X1HcFZvK0gDB4E5xR3etNxgZ8RPhju8Bcwq5t3bGTmK58Laoj/mMyC
         1Dqw5yZra5Mww/ogduEPAH2aWEsceie7OqtYUHoA9MnWKMoS+rMDoIK4HRmSyokD4b2B
         hySg==
X-Gm-Message-State: AOAM530dakjgF79Z3u5Nouji5ZJwrd1cFJzbn4PUVwHc3FCX+sUkkJRS
        ztT6qTBcp3pcfTTK+hmm3FmMrSO9bnnlbp3ntcQKhzOimoKa/9KoEQ/92ecnW9CRIFh0j/PO+ux
        6IHwTiJnkohrjjihz8HSIOzsn
X-Received: by 2002:adf:e0c7:: with SMTP id m7mr13526819wri.530.1640014513236;
        Mon, 20 Dec 2021 07:35:13 -0800 (PST)
X-Google-Smtp-Source: ABdhPJwY85XN14lZIx//9XWyWKXq9VFYx9aU4mVKF0Hv69ur1LO8PZVlFRSmrdNUnFmEaoz9rSr1vg==
X-Received: by 2002:adf:e0c7:: with SMTP id m7mr13526807wri.530.1640014513055;
        Mon, 20 Dec 2021 07:35:13 -0800 (PST)
Received: from redhat.com ([2.55.19.224])
        by smtp.gmail.com with ESMTPSA id o7sm1473124wrc.89.2021.12.20.07.35.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Dec 2021 07:35:12 -0800 (PST)
Date:   Mon, 20 Dec 2021 10:35:08 -0500
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     Bartosz Golaszewski <brgl@bgdev.pl>
Cc:     Vincent Whitchurch <vincent.whitchurch@axis.com>,
        "Enrico Weigelt, metux IT consult" <info@metux.net>,
        Viresh Kumar <vireshk@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>, kernel@axis.com,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        virtualization@lists.linux-foundation.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] gpio: virtio: remove timeout
Message-ID: <20211220103435-mutt-send-email-mst@kernel.org>
References: <20211220130656.16900-1-vincent.whitchurch@axis.com>
 <CAMRc=MeEnSvSxQe-DdLSujSLpzxa-bacJ590BW+tt8awAJq3_w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAMRc=MeEnSvSxQe-DdLSujSLpzxa-bacJ590BW+tt8awAJq3_w@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 20, 2021 at 03:54:56PM +0100, Bartosz Golaszewski wrote:
> On Mon, Dec 20, 2021 at 2:07 PM Vincent Whitchurch
> <vincent.whitchurch@axis.com> wrote:
> >
> > The driver imposes an arbitrary one second timeout on virtio requests,
> > but the specification doesn't prevent the virtio device from taking
> > longer to process requests, so remove this timeout to support all
> > systems and device implementations.
> >
> > Fixes: 3a29355a22c0275fe86 ("gpio: Add virtio-gpio driver")
> > Signed-off-by: Vincent Whitchurch <vincent.whitchurch@axis.com>
> > ---
> >  drivers/gpio/gpio-virtio.c | 6 +-----
> >  1 file changed, 1 insertion(+), 5 deletions(-)
> >
> > diff --git a/drivers/gpio/gpio-virtio.c b/drivers/gpio/gpio-virtio.c
> > index 84f96b78f32a..9f4941bc5760 100644
> > --- a/drivers/gpio/gpio-virtio.c
> > +++ b/drivers/gpio/gpio-virtio.c
> > @@ -100,11 +100,7 @@ static int _virtio_gpio_req(struct virtio_gpio *vgpio, u16 type, u16 gpio,
> >         virtqueue_kick(vgpio->request_vq);
> >         mutex_unlock(&vgpio->lock);
> >
> > -       if (!wait_for_completion_timeout(&line->completion, HZ)) {
> > -               dev_err(dev, "GPIO operation timed out\n");
> > -               ret = -ETIMEDOUT;
> > -               goto out;
> > -       }
> > +       wait_for_completion(&line->completion);
> >
> >         if (unlikely(res->status != VIRTIO_GPIO_STATUS_OK)) {
> >                 dev_err(dev, "GPIO request failed: %d\n", gpio);
> > --
> > 2.33.1
> >
> 
> My knowledge of virtio is limited, I hope this is not a stupid question.
> 
> Does this mean the operation can get stuck indefinitely?
> 
> Bart

Only if the device is broken. which given it's part of the
hypervisor, is par for the course.

-- 
MST

