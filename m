Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A6680494C6B
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jan 2022 12:01:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230141AbiATLAp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Jan 2022 06:00:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40358 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230071AbiATLAm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Jan 2022 06:00:42 -0500
Received: from mail-lf1-x131.google.com (mail-lf1-x131.google.com [IPv6:2a00:1450:4864:20::131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7CDAEC061574
        for <linux-kernel@vger.kernel.org>; Thu, 20 Jan 2022 03:00:41 -0800 (PST)
Received: by mail-lf1-x131.google.com with SMTP id x22so20043909lfd.10
        for <linux-kernel@vger.kernel.org>; Thu, 20 Jan 2022 03:00:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=UPbDMiKKkCnJ7JFAF+4/3sq+Zk2yl1W5R6/aNYWR0zw=;
        b=oMYL5gHJxT4GG+l/3JjfM/S7RG6byyXjxy0CcvfRV2mmD42OeYwpbga0iHstV3rQk3
         zSm85WAiCIzasDplZ/prhy871B8MtzN8IzsnSYx5p5vqvr6vRjXsZYxgZGDNtntbKznm
         4vnCgCU2o5GlbuWs4pE126le/bqdXgmgUoXmt8i4hxOgunEyqO1Fbttm1Vm8p6oSjKd+
         ZFpgAz+gyXnv1GP2b62TmKBvINh5q8C+7jTSeC8nxq84a55EYpenhl4mNa4Kn0GeBtnz
         z9Q7XPcfkfcjBO03yG+GkDC5gEfb6V1NttBLTZIdN2tLCRm+V6ruS0d9cWEQsfu9tZLk
         pkaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=UPbDMiKKkCnJ7JFAF+4/3sq+Zk2yl1W5R6/aNYWR0zw=;
        b=NTWtFNjPd4nTKk0O/q1C6d8Ig34nDbdcSv2mZmMCulIk+i6o57nlkW2UuP1l+MPxZh
         gzEwrgB2kZE3sKQVwAW/oXlO+KbRRFPFYwKeQEyCJhdOuG0qTAh6VFXLy+9UOMpkTUcV
         OSF7UrLdehLyBQokZSeUHsIQHP65ou/KcWNTOPOrvCtnI/HrcEL0H70z/PnunDEiu7W/
         gkc3ZDlufq40bdTyQqQ0CLniq7Y2TAkcvNpyX+1wJUWoDty95kJkJuQmXGp0sJpcBFes
         WXzClASuNNMYwZSFP7H0QTfkhF1EMhw6Vr42XTn0Mbsub1BiGwgZtdn2iQl6Ud1iUJC+
         EeKg==
X-Gm-Message-State: AOAM532IWvPMuEUIVuZ5PqnTiiAyNe5KYQZSbBdHD6xg50U9yompecTO
        SzK0+Tt2eAtnVFxBbM5Tr71zF4NsJqoOMqCOsV8NWw==
X-Google-Smtp-Source: ABdhPJxaBeypZlrKXUlyJh6fatR1/1ha21PWv5uN37sKk7M1pAW+9sqQ1//5GhfYc+4dyPj3Yi4ZoQw41pF7x4mESIU=
X-Received: by 2002:a2e:9b47:: with SMTP id o7mr21706611ljj.242.1642676439825;
 Thu, 20 Jan 2022 03:00:39 -0800 (PST)
MIME-Version: 1.0
References: <20220114150824.3578829-1-jens.wiklander@linaro.org> <20220114150824.3578829-10-jens.wiklander@linaro.org>
In-Reply-To: <20220114150824.3578829-10-jens.wiklander@linaro.org>
From:   Sumit Garg <sumit.garg@linaro.org>
Date:   Thu, 20 Jan 2022 16:30:28 +0530
Message-ID: <CAFA6WYOOLAxwK6P8=kcG29FGv3YG=jrOt_uAqEnrLmRwbQGU6w@mail.gmail.com>
Subject: Re: [PATCH v2 09/12] tee: add tee_shm_register_{user,kernel}_buf()
To:     Jens Wiklander <jens.wiklander@linaro.org>
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

On Fri, 14 Jan 2022 at 20:38, Jens Wiklander <jens.wiklander@linaro.org> wrote:
>
> Adds the two new functions tee_shm_register_user_buf() and
> tee_shm_register_kernel_buf() which should be used instead of the old
> tee_shm_register().
>
> This avoids having the caller supplying the flags parameter which
> exposes a bit more than desired of the internals of the TEE subsystem.
>
> Signed-off-by: Jens Wiklander <jens.wiklander@linaro.org>
> ---
>  drivers/tee/tee_core.c  |  3 +--
>  drivers/tee/tee_shm.c   | 34 ++++++++++++++++++++++++++++++++++
>  include/linux/tee_drv.h |  4 ++++
>  3 files changed, 39 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/tee/tee_core.c b/drivers/tee/tee_core.c
> index a15812baaeb1..8aa1a4836b92 100644
> --- a/drivers/tee/tee_core.c
> +++ b/drivers/tee/tee_core.c
> @@ -334,8 +334,7 @@ tee_ioctl_shm_register(struct tee_context *ctx,
>         if (data.flags)
>                 return -EINVAL;
>
> -       shm = tee_shm_register(ctx, data.addr, data.length,
> -                              TEE_SHM_DMA_BUF | TEE_SHM_USER_MAPPED);
> +       shm = tee_shm_register_user_buf(ctx, data.addr, data.length);
>         if (IS_ERR(shm))
>                 return PTR_ERR(shm);
>
> diff --git a/drivers/tee/tee_shm.c b/drivers/tee/tee_shm.c
> index d51bf97ce7e5..6a1dbce75616 100644
> --- a/drivers/tee/tee_shm.c
> +++ b/drivers/tee/tee_shm.c
> @@ -301,6 +301,40 @@ struct tee_shm *tee_shm_register(struct tee_context *ctx, unsigned long addr,
>  }
>  EXPORT_SYMBOL_GPL(tee_shm_register);
>
> +/**
> + * tee_shm_register_user_buf() - Register a userspace shared memory buffer
> + * @ctx:       Context that registers the shared memory
> + * @addr:      The userspace address of the shared buffer
> + * @length:    Length of the shared buffer
> + *
> + * @returns a pointer to 'struct tee_shm'
> + */
> +struct tee_shm *tee_shm_register_user_buf(struct tee_context *ctx,
> +                                         unsigned long addr, size_t length)
> +{
> +       return tee_shm_register(ctx, addr, length,
> +                               TEE_SHM_DMA_BUF | TEE_SHM_USER_MAPPED);
> +}
> +EXPORT_SYMBOL_GPL(tee_shm_register_user_buf);
> +

Similar comment as for tee_shm_alloc_user_buf() in patch #3. This
isn't required to be exported but rather a private function to TEE
core.

-Sumit

> +/**
> + * tee_shm_register_kernel_buf() - Register kernel memory to be shared with
> + *                                secure world
> + * @ctx:       Context that registers the shared memory
> + * @addr:      The buffer
> + * @length:    Length of the buffer
> + *
> + * @returns a pointer to 'struct tee_shm'
> + */
> +
> +struct tee_shm *tee_shm_register_kernel_buf(struct tee_context *ctx,
> +                                           void *addr, size_t length)
> +{
> +       return tee_shm_register(ctx, (unsigned long)addr, length,
> +                               TEE_SHM_DMA_BUF | TEE_SHM_KERNEL_MAPPED);
> +}
> +EXPORT_SYMBOL_GPL(tee_shm_register_kernel_buf);
> +
>  static int tee_shm_fop_release(struct inode *inode, struct file *filp)
>  {
>         tee_shm_put(filp->private_data);
> diff --git a/include/linux/tee_drv.h b/include/linux/tee_drv.h
> index e71cb0411e9c..029c9a0590cc 100644
> --- a/include/linux/tee_drv.h
> +++ b/include/linux/tee_drv.h
> @@ -289,6 +289,10 @@ struct tee_shm *tee_shm_alloc_kernel_buf(struct tee_context *ctx, size_t size);
>   */
>  struct tee_shm *tee_shm_register(struct tee_context *ctx, unsigned long addr,
>                                  size_t length, u32 flags);
> +struct tee_shm *tee_shm_register_user_buf(struct tee_context *ctx,
> +                                         unsigned long addr, size_t length);
> +struct tee_shm *tee_shm_register_kernel_buf(struct tee_context *ctx,
> +                                           void *addr, size_t length);
>
>  /**
>   * tee_shm_is_registered() - Check if shared memory object in registered in TEE
> --
> 2.31.1
>
