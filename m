Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 76E7B49358D
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jan 2022 08:36:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351425AbiASHgV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Jan 2022 02:36:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34644 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245393AbiASHgU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Jan 2022 02:36:20 -0500
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com [IPv6:2a00:1450:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 626DEC061574
        for <linux-kernel@vger.kernel.org>; Tue, 18 Jan 2022 23:36:20 -0800 (PST)
Received: by mail-wm1-x32f.google.com with SMTP id q9-20020a7bce89000000b00349e697f2fbso12268048wmj.0
        for <linux-kernel@vger.kernel.org>; Tue, 18 Jan 2022 23:36:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=nmhhg9i2bfaFOwCknAYA4Kfe2fR5pcSkqhxdrBlpK2I=;
        b=px6inIADgoydqk3L7hXNA3BrJWgSLJNgfAcZGj07teKRKLETe8jAOusS4w2txHdobP
         wvMafzitIbriMz1MZYM8bHS2DBgTSp4IpDnrOMxC7x/qxiFlKgno9ht2sIpkooE27qjs
         KnkHlI/KIai2bPxJQoCM+XzGEImaiTK6JP0FBVDpO/iLA+w9YikG7+mgfm6sBxBta7s0
         rMW8pZ1b95bYzu52aSn4n1stJqAB67Zu2i+dCkQ/ZBJjpE28+7HUEHpquMfqffy75jF0
         PuUlVz4Xbw5dVnacO4OdFBxYBDKUh9DUE2GruIdTb9tpP/lqjb3Je2RNEOk05N7BO/gX
         asHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=nmhhg9i2bfaFOwCknAYA4Kfe2fR5pcSkqhxdrBlpK2I=;
        b=H6kwvkc8gVCU0NXU9XaUQ2M4Lfzdnp9+hTK1Nyzrrjjls5IP099umfa9LI6Jst8d3/
         LgehUYYdNECMOODiVCaE9jm9iqoE4slz5TOzt+841AyLTa1WiQ6rYZoDRyzASmai96to
         /+DS9rLZtvaTSEwcViVNNXSSEfvKBKfWP8jjk8QDxaXAfqNBgWLXQisocQamCUydDy5l
         O9qY+JKSjIIawkXTW8LiWlOX/mrEVAG5wYRjlFRuRDWSQKkQRKh5xxzQvycikliDk2W3
         MbCdUfKMoqr0TSjyJkWMdOCS/7ZTjlcKI+RWPYOZ0MP+1gcEBQj7ECx02jAX+97DsHl6
         Jh7w==
X-Gm-Message-State: AOAM533snbsNjzKaiFFV+OvPMbxfOfs2+zJhEmidnCMnpCNuoBXAmApz
        Sp8SaPParLE11iId+lNlKJuXe7PzG8VhrY2e0AD1kPsMfvk=
X-Google-Smtp-Source: ABdhPJy4QimdWZGr6a+Ae3yGwZFLijg9i7QAl5oIahOV+GDckvPQAfJNujL5I/YFDGuf9sRN+KW/mKz06oOb2xw4CKE=
X-Received: by 2002:adf:e312:: with SMTP id b18mr22010681wrj.321.1642577778957;
 Tue, 18 Jan 2022 23:36:18 -0800 (PST)
MIME-Version: 1.0
References: <20220114150824.3578829-1-jens.wiklander@linaro.org>
 <20220114150824.3578829-4-jens.wiklander@linaro.org> <CAFA6WYOG263--zk9djUT1ueeXBCbg62fo95ZRJ1c733KULpUhw@mail.gmail.com>
In-Reply-To: <CAFA6WYOG263--zk9djUT1ueeXBCbg62fo95ZRJ1c733KULpUhw@mail.gmail.com>
From:   Jens Wiklander <jens.wiklander@linaro.org>
Date:   Wed, 19 Jan 2022 08:36:08 +0100
Message-ID: <CAHUa44HUdNGporP4-2QeL+oPgqD3faLv6WW0Mo0fkn0AT=qeNw@mail.gmail.com>
Subject: Re: [PATCH v2 03/12] tee: add tee_shm_alloc_user_buf()
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

On Tue, Jan 18, 2022 at 2:11 PM Sumit Garg <sumit.garg@linaro.org> wrote:
>
> On Fri, 14 Jan 2022 at 20:38, Jens Wiklander <jens.wiklander@linaro.org> wrote:
> >
> > Adds a new function tee_shm_alloc_user_buf() or user mode allocations,
> > replacing passing the flags TEE_SHM_MAPPED | TEE_SHM_DMA_BUF to
> > tee_shm_alloc().
> >
> > Signed-off-by: Jens Wiklander <jens.wiklander@linaro.org>
> > ---
> >  drivers/tee/tee_core.c     |  2 +-
> >  drivers/tee/tee_shm.c      | 18 ++++++++++++++++++
> >  drivers/tee/tee_shm_pool.c |  2 +-
> >  include/linux/tee_drv.h    |  3 ++-
> >  4 files changed, 22 insertions(+), 3 deletions(-)
> >
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
>
> Since it's the only place this API would be used within the driver
> itself and I can't see any future usage from other kernel drivers..
>
> >         if (IS_ERR(shm))
> >                 return PTR_ERR(shm);
> >
> > diff --git a/drivers/tee/tee_shm.c b/drivers/tee/tee_shm.c
> > index 499fccba3d74..b43178986985 100644
> > --- a/drivers/tee/tee_shm.c
> > +++ b/drivers/tee/tee_shm.c
> > @@ -127,6 +127,24 @@ struct tee_shm *tee_shm_alloc(struct tee_context *ctx, size_t size, u32 flags)
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
> > +EXPORT_SYMBOL_GPL(tee_shm_alloc_user_buf);
> > +
>
> ..so I don't see any value-add for this export..
>
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
> >   */
> >  #include <linux/device.h>
> >  #include <linux/dma-buf.h>
> > diff --git a/include/linux/tee_drv.h b/include/linux/tee_drv.h
> > index 6b0f0d01ebdf..26b450484ac1 100644
> > --- a/include/linux/tee_drv.h
> > +++ b/include/linux/tee_drv.h
> > @@ -1,6 +1,6 @@
> >  /* SPDX-License-Identifier: GPL-2.0-only */
> >  /*
> > - * Copyright (c) 2015-2016, Linaro Limited
> > + * Copyright (c) 2015-2022 Linaro Limited
> >   */
> >
> >  #ifndef __TEE_DRV_H
> > @@ -308,6 +308,7 @@ void *tee_get_drvdata(struct tee_device *teedev);
> >   * @returns a pointer to 'struct tee_shm'
> >   */
> >  struct tee_shm *tee_shm_alloc(struct tee_context *ctx, size_t size, u32 flags);
> > +struct tee_shm *tee_shm_alloc_user_buf(struct tee_context *ctx, size_t size);
>
> ..and it should rather belong to drivers/tee/tee_private.h.

Makes sense, I'll fix this in the next version.

Thanks,
Jens

>
> -Sumit
>
> >  struct tee_shm *tee_shm_alloc_kernel_buf(struct tee_context *ctx, size_t size);
> >
> >  /**
> > --
> > 2.31.1
> >
