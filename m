Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 11F4A494E99
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jan 2022 14:08:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245046AbiATNHM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Jan 2022 08:07:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41404 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244622AbiATNHJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Jan 2022 08:07:09 -0500
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com [IPv6:2a00:1450:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CCB65C061574
        for <linux-kernel@vger.kernel.org>; Thu, 20 Jan 2022 05:07:08 -0800 (PST)
Received: by mail-wm1-x32a.google.com with SMTP id o1-20020a1c4d01000000b0034d95625e1fso7280926wmh.4
        for <linux-kernel@vger.kernel.org>; Thu, 20 Jan 2022 05:07:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Pf4BYXVkEBiAHxvfjg/LOTJIqSqaQLQh4tvfHTTB40k=;
        b=w9Qy6G03ThdCH7oCJFZ1yv/joiohw6cBHxsD4nQF5QSUU7k8QyVWRwA9pnL3IhaAgj
         zmFZcqLzoA+JenBw6K0Db06rx9TbYNbhs/uJi3nIzp2c/L+b0VzZFtZeElTlDwOFKJRq
         egfnvSgubGXORX0PQxktigyZcUZ7endRTEcVxNxhOGy0V4gzzNLnOEiLBnWQnCzlgTKy
         NpzzEmuD3wLP24QvgUXyQzmW3uBF1li5AsDK2P9g9RECXV+S3IjuHYwWS4QVXEOm4ry6
         R0xHUA7Ke+KuGxU/iZby+1HSbVxQTBF6th0OcW6FK5gXq7V0yeQY95wu7KKAem3eAveQ
         Xacg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Pf4BYXVkEBiAHxvfjg/LOTJIqSqaQLQh4tvfHTTB40k=;
        b=OlX71BdqtUJKgSmxSPnzjVLhlRiQzDF0kRNtQxtWKcSW4JKl3tWKXt3inTZVmDln7Y
         Xel1anSjsHVBVnpzXuEjKQsvSpG81paTk78ekv9N4dOAbJrISzl2w/CvTPfQdygWT8wi
         spsRpNp6IcnvxdZU60KtU0s2glanDcQz2REZhpFnHqQJfix2a4BTxyRyA0uSnHFS6ev7
         IN1eQKyUBTMLcQbNqFZwCwna5IvkLz0ygfPhRgZSccSczdYO002K4/DPduTDDb05a1jb
         CMQaQlt7Hzf7yjpkfkrqzhOBZBVW50qpPgg8nP/MbgHHxs8es0t+rGNPXtqkqBETJ8Ww
         msaQ==
X-Gm-Message-State: AOAM530VSJuAYRgBfAfHCOVr1xsUV/+WF3CZTrSoZMT1t1Pgd7+QiNGv
        Epj7E9qxGg7c71CXxJtGohb+knNt+e7b2i+c59+u6A==
X-Google-Smtp-Source: ABdhPJzX+KqHzjtxOkv77MHHzbYfly4M1iEzLRQJEKYDS8mwQ891Is6L6HbxPg8YkZVjZJdMyUOLiUxCDTatsoiaiE8=
X-Received: by 2002:a5d:6c6e:: with SMTP id r14mr13074020wrz.651.1642684027298;
 Thu, 20 Jan 2022 05:07:07 -0800 (PST)
MIME-Version: 1.0
References: <20220114150824.3578829-1-jens.wiklander@linaro.org>
 <20220114150824.3578829-10-jens.wiklander@linaro.org> <CAFA6WYOOLAxwK6P8=kcG29FGv3YG=jrOt_uAqEnrLmRwbQGU6w@mail.gmail.com>
In-Reply-To: <CAFA6WYOOLAxwK6P8=kcG29FGv3YG=jrOt_uAqEnrLmRwbQGU6w@mail.gmail.com>
From:   Jens Wiklander <jens.wiklander@linaro.org>
Date:   Thu, 20 Jan 2022 14:06:56 +0100
Message-ID: <CAHUa44H0ryokLDJn3DLFEQUw+0jd0a_Jh9hPOCLjL-pZxKk-ZA@mail.gmail.com>
Subject: Re: [PATCH v2 09/12] tee: add tee_shm_register_{user,kernel}_buf()
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

On Thu, Jan 20, 2022 at 12:00 PM Sumit Garg <sumit.garg@linaro.org> wrote:
>
> On Fri, 14 Jan 2022 at 20:38, Jens Wiklander <jens.wiklander@linaro.org> wrote:
> >
> > Adds the two new functions tee_shm_register_user_buf() and
> > tee_shm_register_kernel_buf() which should be used instead of the old
> > tee_shm_register().
> >
> > This avoids having the caller supplying the flags parameter which
> > exposes a bit more than desired of the internals of the TEE subsystem.
> >
> > Signed-off-by: Jens Wiklander <jens.wiklander@linaro.org>
> > ---
> >  drivers/tee/tee_core.c  |  3 +--
> >  drivers/tee/tee_shm.c   | 34 ++++++++++++++++++++++++++++++++++
> >  include/linux/tee_drv.h |  4 ++++
> >  3 files changed, 39 insertions(+), 2 deletions(-)
> >
> > diff --git a/drivers/tee/tee_core.c b/drivers/tee/tee_core.c
> > index a15812baaeb1..8aa1a4836b92 100644
> > --- a/drivers/tee/tee_core.c
> > +++ b/drivers/tee/tee_core.c
> > @@ -334,8 +334,7 @@ tee_ioctl_shm_register(struct tee_context *ctx,
> >         if (data.flags)
> >                 return -EINVAL;
> >
> > -       shm = tee_shm_register(ctx, data.addr, data.length,
> > -                              TEE_SHM_DMA_BUF | TEE_SHM_USER_MAPPED);
> > +       shm = tee_shm_register_user_buf(ctx, data.addr, data.length);
> >         if (IS_ERR(shm))
> >                 return PTR_ERR(shm);
> >
> > diff --git a/drivers/tee/tee_shm.c b/drivers/tee/tee_shm.c
> > index d51bf97ce7e5..6a1dbce75616 100644
> > --- a/drivers/tee/tee_shm.c
> > +++ b/drivers/tee/tee_shm.c
> > @@ -301,6 +301,40 @@ struct tee_shm *tee_shm_register(struct tee_context *ctx, unsigned long addr,
> >  }
> >  EXPORT_SYMBOL_GPL(tee_shm_register);
> >
> > +/**
> > + * tee_shm_register_user_buf() - Register a userspace shared memory buffer
> > + * @ctx:       Context that registers the shared memory
> > + * @addr:      The userspace address of the shared buffer
> > + * @length:    Length of the shared buffer
> > + *
> > + * @returns a pointer to 'struct tee_shm'
> > + */
> > +struct tee_shm *tee_shm_register_user_buf(struct tee_context *ctx,
> > +                                         unsigned long addr, size_t length)
> > +{
> > +       return tee_shm_register(ctx, addr, length,
> > +                               TEE_SHM_DMA_BUF | TEE_SHM_USER_MAPPED);
> > +}
> > +EXPORT_SYMBOL_GPL(tee_shm_register_user_buf);
> > +
>
> Similar comment as for tee_shm_alloc_user_buf() in patch #3. This
> isn't required to be exported but rather a private function to TEE
> core.

OK, I'll fix it in v3.

Thanks,
Jens

>
> -Sumit
>
> > +/**
> > + * tee_shm_register_kernel_buf() - Register kernel memory to be shared with
> > + *                                secure world
> > + * @ctx:       Context that registers the shared memory
> > + * @addr:      The buffer
> > + * @length:    Length of the buffer
> > + *
> > + * @returns a pointer to 'struct tee_shm'
> > + */
> > +
> > +struct tee_shm *tee_shm_register_kernel_buf(struct tee_context *ctx,
> > +                                           void *addr, size_t length)
> > +{
> > +       return tee_shm_register(ctx, (unsigned long)addr, length,
> > +                               TEE_SHM_DMA_BUF | TEE_SHM_KERNEL_MAPPED);
> > +}
> > +EXPORT_SYMBOL_GPL(tee_shm_register_kernel_buf);
> > +
> >  static int tee_shm_fop_release(struct inode *inode, struct file *filp)
> >  {
> >         tee_shm_put(filp->private_data);
> > diff --git a/include/linux/tee_drv.h b/include/linux/tee_drv.h
> > index e71cb0411e9c..029c9a0590cc 100644
> > --- a/include/linux/tee_drv.h
> > +++ b/include/linux/tee_drv.h
> > @@ -289,6 +289,10 @@ struct tee_shm *tee_shm_alloc_kernel_buf(struct tee_context *ctx, size_t size);
> >   */
> >  struct tee_shm *tee_shm_register(struct tee_context *ctx, unsigned long addr,
> >                                  size_t length, u32 flags);
> > +struct tee_shm *tee_shm_register_user_buf(struct tee_context *ctx,
> > +                                         unsigned long addr, size_t length);
> > +struct tee_shm *tee_shm_register_kernel_buf(struct tee_context *ctx,
> > +                                           void *addr, size_t length);
> >
> >  /**
> >   * tee_shm_is_registered() - Check if shared memory object in registered in TEE
> > --
> > 2.31.1
> >
