Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9130749DC3C
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jan 2022 09:09:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237658AbiA0IJh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Jan 2022 03:09:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44408 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230127AbiA0IJg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jan 2022 03:09:36 -0500
Received: from mail-pl1-x635.google.com (mail-pl1-x635.google.com [IPv6:2607:f8b0:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F18FC061714
        for <linux-kernel@vger.kernel.org>; Thu, 27 Jan 2022 00:09:36 -0800 (PST)
Received: by mail-pl1-x635.google.com with SMTP id h14so1861335plf.1
        for <linux-kernel@vger.kernel.org>; Thu, 27 Jan 2022 00:09:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Jj3qMvBjTT6j/SOlKMxE/OiM+a/oHNHlcXnrCMXcDmk=;
        b=bSUKyFoupKbe49Ggrxey89hibKPASxMbA8SqWgfUtjl9y27Hdy6Ri+9U1Gi49Hgvo+
         vvzknfSpgbAyJ20xn6rB7HXEPq4YoYmGxgWhNt9E9BvbSzWOVvsZu99V/JB793FDS3vK
         AY4yXWOFSOzO7CSp5xoW1HrlW8bqkdcRCo3LpylT9+MLifAFhcwSm5AZaCzRF/z3pBG1
         Igj3ePjUwl1GWNeKPkEKIOw5NcgcmIaOOr+YBBi9GRgymExCx25kcvdaZN7lZP59661k
         p0oidc/D3nqjRuvT4+tNaCGXU3VgBQoTWNAQYulzIY8FLYFxQfx4XKR7FNrCfcWmT5eg
         KYiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Jj3qMvBjTT6j/SOlKMxE/OiM+a/oHNHlcXnrCMXcDmk=;
        b=eL6McRAN0tdMlLdn7ESWXRxQQhuH7xdTOywacyfPqqJoNAsOZN0IysbjxSfB40+ehA
         jsnILW9u3I6UAUKyzZ/agFrui21aZfjeyvX7PNZN86hYQ6FXTk9ifjw5p2rACIJOR2b6
         Q6G6umJuuvUch32QyhhRmDxRakZKuWyCAYgLaFIRoKSLVeVW84B1n9feTAzAGU2xojtH
         NoaQzAh44Gjmor2PLyt7x8Pm7gmD4gMjSZPo/CHQOYKaIYNU7dLGu8SAOLGU1l5IhSs7
         JY7EYrQ82UNGWGAGawSsZ7f1ORkgNtLy+PdKcVIw1WzO6ugsAqDbcBkYzdDuD5vlZ7v4
         vxuQ==
X-Gm-Message-State: AOAM530KoazlJXzGAK2UVYsEVGrXqbRfL3Wgq9/0SgUOcGs+AXb1ixE3
        0+BEVcGMqX4+hKWMPyzoaI2beCUZ1ATkmo5HUuNbvQ==
X-Google-Smtp-Source: ABdhPJxZS5vsEhTE3sodpt30zTPMiVoW+wEFG/jG/MGBVTCtKkVuatLV8KwwjL8hQW+AvPpI+HrBm45VEN/mksF6D9c=
X-Received: by 2002:a17:90b:3882:: with SMTP id mu2mr579746pjb.150.1643270976034;
 Thu, 27 Jan 2022 00:09:36 -0800 (PST)
MIME-Version: 1.0
References: <20220125162938.838382-1-jens.wiklander@linaro.org>
 <20220125162938.838382-4-jens.wiklander@linaro.org> <CAFA6WYOT7capu1RrK57HAu_qKvG65X_C1-esw3DyD4_9LeKZSg@mail.gmail.com>
In-Reply-To: <CAFA6WYOT7capu1RrK57HAu_qKvG65X_C1-esw3DyD4_9LeKZSg@mail.gmail.com>
From:   Jens Wiklander <jens.wiklander@linaro.org>
Date:   Thu, 27 Jan 2022 09:09:25 +0100
Message-ID: <CAHUa44Ec0Mcr_4PW0pi2mkFBHW8wLQBK9F9WNkaid_MrhaeBTg@mail.gmail.com>
Subject: Re: [PATCH v3 03/12] tee: add tee_shm_alloc_user_buf()
To:     Sumit Garg <sumit.garg@linaro.org>
Cc:     linux-kernel@vger.kernel.org, op-tee@lists.trustedfirmware.org,
        Herbert Xu <herbert@gondor.apana.org.au>,
        Devaraj Rangasamy <Devaraj.Rangasamy@amd.com>,
        Rijo Thomas <Rijo-john.Thomas@amd.com>,
        David Howells <dhowells@redhat.com>,
        Tyler Hicks <tyhicks@linux.microsoft.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 27, 2022 at 6:56 AM Sumit Garg <sumit.garg@linaro.org> wrote:
>
> On Tue, 25 Jan 2022 at 21:59, Jens Wiklander <jens.wiklander@linaro.org> wrote:
> >
> > Adds a new function tee_shm_alloc_user_buf() or user mode allocations,
>
> typo: s/or/for/
>
> > replacing passing the flags TEE_SHM_MAPPED | TEE_SHM_DMA_BUF to
> > tee_shm_alloc().
> >
> > Signed-off-by: Jens Wiklander <jens.wiklander@linaro.org>
> > ---
> >  drivers/tee/tee_core.c     |  2 +-
> >  drivers/tee/tee_private.h  |  2 ++
> >  drivers/tee/tee_shm.c      | 17 +++++++++++++++++
> >  drivers/tee/tee_shm_pool.c |  2 +-
> >  include/linux/tee_drv.h    |  2 +-
> >  5 files changed, 22 insertions(+), 3 deletions(-)
> >
>
> Apart from minor comments below:
>
> Reviewed-by: Sumit Garg <sumit.garg@linaro.org>

Thanks, I'll fix those.

/Jens

>
> > diff --git a/drivers/tee/tee_core.c b/drivers/tee/tee_core.c
> > index 3fc426dad2df..a15812baaeb1 100644
> > --- a/drivers/tee/tee_core.c
> > +++ b/drivers/tee/tee_core.c
> > @@ -297,7 +297,7 @@ static int tee_ioctl_shm_alloc(struct tee_context *ctx,
> >         if (data.flags)
> >                 return -EINVAL;
> >
> > -       shm = tee_shm_alloc(ctx, data.size, TEE_SHM_MAPPED | TEE_SHM_DMA_BUF);
> > +       shm = tee_shm_alloc_user_buf(ctx, data.size);
> >         if (IS_ERR(shm))
> >                 return PTR_ERR(shm);
> >
> > diff --git a/drivers/tee/tee_private.h b/drivers/tee/tee_private.h
> > index e55204df31ce..e09c8aa5d967 100644
> > --- a/drivers/tee/tee_private.h
> > +++ b/drivers/tee/tee_private.h
> > @@ -68,4 +68,6 @@ void tee_device_put(struct tee_device *teedev);
> >  void teedev_ctx_get(struct tee_context *ctx);
> >  void teedev_ctx_put(struct tee_context *ctx);
> >
> > +struct tee_shm *tee_shm_alloc_user_buf(struct tee_context *ctx, size_t size);
> > +
> >  #endif /*TEE_PRIVATE_H*/
> > diff --git a/drivers/tee/tee_shm.c b/drivers/tee/tee_shm.c
> > index 499fccba3d74..7e7e762fc1de 100644
> > --- a/drivers/tee/tee_shm.c
> > +++ b/drivers/tee/tee_shm.c
> > @@ -127,6 +127,23 @@ struct tee_shm *tee_shm_alloc(struct tee_context *ctx, size_t size, u32 flags)
> >  }
> >  EXPORT_SYMBOL_GPL(tee_shm_alloc);
> >
> > +/**
> > + * tee_shm_alloc_user_buf() - Allocate shared memory for user space
> > + * @ctx:       Context that allocates the shared memory
> > + * @size:      Requested size of shared memory
> > + *
> > + * Memory allocated as user space shared memory is automatically freed when
> > + * the TEE file pointer is closed. The primary usage of this function is
> > + * when the TEE driver doesn't support registering ordinary user space
> > + * memory.
> > + *
> > + * @returns a pointer to 'struct tee_shm'
> > + */
> > +struct tee_shm *tee_shm_alloc_user_buf(struct tee_context *ctx, size_t size)
> > +{
> > +       return tee_shm_alloc(ctx, size, TEE_SHM_MAPPED | TEE_SHM_DMA_BUF);
> > +}
> > +
> >  /**
> >   * tee_shm_alloc_kernel_buf() - Allocate shared memory for kernel buffer
> >   * @ctx:       Context that allocates the shared memory
> > diff --git a/drivers/tee/tee_shm_pool.c b/drivers/tee/tee_shm_pool.c
> > index a9f9d50fd181..0e460347138a 100644
> > --- a/drivers/tee/tee_shm_pool.c
> > +++ b/drivers/tee/tee_shm_pool.c
> > @@ -1,6 +1,6 @@
> >  // SPDX-License-Identifier: GPL-2.0-only
> >  /*
> > - * Copyright (c) 2015, Linaro Limited
> > + * Copyright (c) 2015, 2017, 2022 Linaro Limited
>
> Redundant change?
>
> >   */
> >  #include <linux/device.h>
> >  #include <linux/dma-buf.h>
> > diff --git a/include/linux/tee_drv.h b/include/linux/tee_drv.h
> > index 6b0f0d01ebdf..975500b2553e 100644
> > --- a/include/linux/tee_drv.h
> > +++ b/include/linux/tee_drv.h
> > @@ -1,6 +1,6 @@
> >  /* SPDX-License-Identifier: GPL-2.0-only */
> >  /*
> > - * Copyright (c) 2015-2016, Linaro Limited
> > + * Copyright (c) 2015-2022 Linaro Limited
>
> Ditto?
>
> -Sumit
>
> >   */
> >
> >  #ifndef __TEE_DRV_H
> > --
> > 2.31.1
> >
