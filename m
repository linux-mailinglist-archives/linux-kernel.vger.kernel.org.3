Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2BA0849DC8B
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jan 2022 09:28:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237759AbiA0I1x (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Jan 2022 03:27:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48484 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229683AbiA0I1w (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jan 2022 03:27:52 -0500
Received: from mail-pj1-x102b.google.com (mail-pj1-x102b.google.com [IPv6:2607:f8b0:4864:20::102b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2EE37C061714
        for <linux-kernel@vger.kernel.org>; Thu, 27 Jan 2022 00:27:52 -0800 (PST)
Received: by mail-pj1-x102b.google.com with SMTP id d15-20020a17090a110f00b001b4e7d27474so2211680pja.2
        for <linux-kernel@vger.kernel.org>; Thu, 27 Jan 2022 00:27:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=KaHfDqMhPfMiHlzbieL5qN1ZX1OPUZf1ZWaIv7ob9qg=;
        b=wD1sclEJG4pYWP/avgPenRFeRr941+imJowEXMPzlzDVsTyf8pfJhiv4nRcK/QFAzH
         ppV4ai/kJtMDtsYysBBs3k3AYdZZtwGDIDMPOldt+QPEf5zPap7DyYmrYUwjMEhcO0ED
         LjNvl7F50fPmfkdmtW8eohT7vCUJ8K8tp8so5uz9sJeHD2yEX44Ke4C7uLCJoEuMgClx
         1zE97spZCwSRKY3E/+e/urJm0BFQZf3itHM1aVd8c5SHA3UIRnWOsfFOlvfgWvqFCvk0
         Ff0r8REizGGy381KHltYcUinGM84M3kftxLOrWndDmuYfHDikHDxIoVL6ffKPLo+T6/w
         3TJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=KaHfDqMhPfMiHlzbieL5qN1ZX1OPUZf1ZWaIv7ob9qg=;
        b=K8LFM+wgqmc8WrI/5cxdvKdjONshEUNceDH7AhAWPj+8smXqKY5vuRzyCHMArYSizC
         spuoWiIPLn5LmyBvXJMVKO3OoVCd+j4rfI1CubpQvuAOpaStT30fFyeZ//7sthee1f0U
         Y+MaJ4PFhUDzB44kbiZXXDbXeAwzc57WpBToljXbO8ukAlNAjtl3Fhde9R0zci62/Zqu
         SKuuOjVhr+ln3ubFBm29s+XrL1eog+P0OTHyczFe3goGd7OrbMAYfXTl2tX44FDYmiSG
         WZpjoZQilbYp53+wGdo8OiQLQ9THg3YX87uV8HVo22t69kGcH2IvQeSjfv747NWY4X1F
         i+xw==
X-Gm-Message-State: AOAM530GwUdOvExdVjqUDcuTs91Eigv3LZIdBMQOyyf1ecLthIHw4mEq
        YhDufBjfyuRRvXi+J9fit97iBPYlM9HjHFmq2xIV1g==
X-Google-Smtp-Source: ABdhPJzlKgWyVjZ2IkqjMWFKkttNmt7D4hx6cRnWktB7R1HzeN0tNDDjeTwwO3+te1TcCqU48jJZ4mWrGC2sjMBHvYI=
X-Received: by 2002:a17:902:f54b:: with SMTP id h11mr2959316plf.58.1643272071286;
 Thu, 27 Jan 2022 00:27:51 -0800 (PST)
MIME-Version: 1.0
References: <20220125162938.838382-1-jens.wiklander@linaro.org>
 <20220125162938.838382-5-jens.wiklander@linaro.org> <CAFA6WYPyMEYoL0h2bv3v5f6bdfsGtNmKk2fbns6vjZgKChUREg@mail.gmail.com>
In-Reply-To: <CAFA6WYPyMEYoL0h2bv3v5f6bdfsGtNmKk2fbns6vjZgKChUREg@mail.gmail.com>
From:   Jens Wiklander <jens.wiklander@linaro.org>
Date:   Thu, 27 Jan 2022 09:27:40 +0100
Message-ID: <CAHUa44HikYTKd2WJrKMbeXA7kJLPmzM4maxh2i83tz2ZtZcj2Q@mail.gmail.com>
Subject: Re: [PATCH v3 04/12] tee: simplify shm pool handling
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

On Thu, Jan 27, 2022 at 7:09 AM Sumit Garg <sumit.garg@linaro.org> wrote:
>
> On Tue, 25 Jan 2022 at 21:59, Jens Wiklander <jens.wiklander@linaro.org> wrote:
> >
> > Replaces the shared memory pool based on two pools with a single pool.
> > The alloc() function pointer in struct tee_shm_pool_ops gets another
> > parameter, align. This makes it possible to make less than page aligned
> > allocations from the optional reserved shared memory pool while still
> > making user space allocations page aligned. With in practice unchanged
> > behaviour using only a single pool for bookkeeping.
> >
> > The allocation algorithm in the static OP-TEE shared memory pool is
> > changed from best-fit to first-fit since only the latter supports an
> > alignment parameter. The best-fit algorithm was previously the default
> > choice and not a conscious one.
> >
> > The optee and amdtee drivers are updated as needed to work with this
> > changed pool handling.
> >
> > This also removes OPTEE_SHM_NUM_PRIV_PAGES which becomes obsolete with
> > this change as the private pages can be mixed with the payload pages.
> >
> > Signed-off-by: Jens Wiklander <jens.wiklander@linaro.org>
> > ---
> >  drivers/tee/amdtee/shm_pool.c     |  55 +++++-----------
> >  drivers/tee/optee/Kconfig         |   8 ---
> >  drivers/tee/optee/core.c          |  11 ++--
> >  drivers/tee/optee/ffa_abi.c       |  55 ++++------------
> >  drivers/tee/optee/optee_private.h |   4 +-
> >  drivers/tee/optee/smc_abi.c       | 100 ++++++----------------------
> >  drivers/tee/tee_private.h         |  11 ----
> >  drivers/tee/tee_shm.c             |  29 ++++-----
> >  drivers/tee/tee_shm_pool.c        | 104 ++++++++++--------------------
> >  include/linux/tee_drv.h           |  58 ++++++-----------
> >  10 files changed, 126 insertions(+), 309 deletions(-)
> >
> > diff --git a/drivers/tee/amdtee/shm_pool.c b/drivers/tee/amdtee/shm_pool.c
> > index 065854e2db18..f87f96a291c9 100644
> > --- a/drivers/tee/amdtee/shm_pool.c
> > +++ b/drivers/tee/amdtee/shm_pool.c
> > @@ -8,13 +8,17 @@
> >  #include <linux/psp-sev.h>
> >  #include "amdtee_private.h"
> >
> > -static int pool_op_alloc(struct tee_shm_pool_mgr *poolm, struct tee_shm *shm,
> > -                        size_t size)
> > +static int pool_op_alloc(struct tee_shm_pool *pool, struct tee_shm *shm,
> > +                        size_t size, size_t align)
> >  {
> >         unsigned int order = get_order(size);
> >         unsigned long va;
> >         int rc;
> >
> > +       /*
> > +        * Ignore alignment since this is already going to be page aligned
> > +        * and there's no need for any larger alignment.
> > +        */
> >         va = __get_free_pages(GFP_KERNEL | __GFP_ZERO, order);
> >         if (!va)
> >                 return -ENOMEM;
> > @@ -34,7 +38,7 @@ static int pool_op_alloc(struct tee_shm_pool_mgr *poolm, struct tee_shm *shm,
> >         return 0;
> >  }
> >
> > -static void pool_op_free(struct tee_shm_pool_mgr *poolm, struct tee_shm *shm)
> > +static void pool_op_free(struct tee_shm_pool *pool, struct tee_shm *shm)
> >  {
> >         /* Unmap the shared memory from TEE */
> >         amdtee_unmap_shmem(shm);
> > @@ -42,52 +46,25 @@ static void pool_op_free(struct tee_shm_pool_mgr *poolm, struct tee_shm *shm)
> >         shm->kaddr = NULL;
> >  }
> >
> > -static void pool_op_destroy_poolmgr(struct tee_shm_pool_mgr *poolm)
> > +static void pool_op_destroy_pool(struct tee_shm_pool *pool)
> >  {
> > -       kfree(poolm);
> > +       kfree(pool);
> >  }
> >
> > -static const struct tee_shm_pool_mgr_ops pool_ops = {
> > +static const struct tee_shm_pool_ops pool_ops = {
> >         .alloc = pool_op_alloc,
> >         .free = pool_op_free,
> > -       .destroy_poolmgr = pool_op_destroy_poolmgr,
> > +       .destroy_pool = pool_op_destroy_pool,
> >  };
> >
> > -static struct tee_shm_pool_mgr *pool_mem_mgr_alloc(void)
> > -{
> > -       struct tee_shm_pool_mgr *mgr = kzalloc(sizeof(*mgr), GFP_KERNEL);
> > -
> > -       if (!mgr)
> > -               return ERR_PTR(-ENOMEM);
> > -
> > -       mgr->ops = &pool_ops;
> > -
> > -       return mgr;
> > -}
> > -
> >  struct tee_shm_pool *amdtee_config_shm(void)
> >  {
> > -       struct tee_shm_pool_mgr *priv_mgr;
> > -       struct tee_shm_pool_mgr *dmabuf_mgr;
> > -       void *rc;
> > +       struct tee_shm_pool *pool = kzalloc(sizeof(*pool), GFP_KERNEL);
> >
> > -       rc = pool_mem_mgr_alloc();
> > -       if (IS_ERR(rc))
> > -               return rc;
> > -       priv_mgr = rc;
> > -
> > -       rc = pool_mem_mgr_alloc();
> > -       if (IS_ERR(rc)) {
> > -               tee_shm_pool_mgr_destroy(priv_mgr);
> > -               return rc;
> > -       }
> > -       dmabuf_mgr = rc;
> > +       if (!pool)
> > +               return ERR_PTR(-ENOMEM);
> >
> > -       rc = tee_shm_pool_alloc(priv_mgr, dmabuf_mgr);
> > -       if (IS_ERR(rc)) {
> > -               tee_shm_pool_mgr_destroy(priv_mgr);
> > -               tee_shm_pool_mgr_destroy(dmabuf_mgr);
> > -       }
> > +       pool->ops = &pool_ops;
> >
> > -       return rc;
> > +       return pool;
> >  }
> > diff --git a/drivers/tee/optee/Kconfig b/drivers/tee/optee/Kconfig
> > index 3ca71e3812ed..f121c224e682 100644
> > --- a/drivers/tee/optee/Kconfig
> > +++ b/drivers/tee/optee/Kconfig
> > @@ -7,11 +7,3 @@ config OPTEE
> >         help
> >           This implements the OP-TEE Trusted Execution Environment (TEE)
> >           driver.
> > -
> > -config OPTEE_SHM_NUM_PRIV_PAGES
> > -       int "Private Shared Memory Pages"
> > -       default 1
> > -       depends on OPTEE
> > -       help
> > -         This sets the number of private shared memory pages to be
> > -         used by OP-TEE TEE driver.
> > diff --git a/drivers/tee/optee/core.c b/drivers/tee/optee/core.c
> > index 1ca320885fad..2a369e346b85 100644
> > --- a/drivers/tee/optee/core.c
> > +++ b/drivers/tee/optee/core.c
> > @@ -18,8 +18,8 @@
> >  #include <linux/workqueue.h>
> >  #include "optee_private.h"
> >
> > -int optee_pool_op_alloc_helper(struct tee_shm_pool_mgr *poolm,
> > -                              struct tee_shm *shm, size_t size,
> > +int optee_pool_op_alloc_helper(struct tee_shm_pool *pool, struct tee_shm *shm,
> > +                              size_t size, size_t align,
> >                                int (*shm_register)(struct tee_context *ctx,
> >                                                    struct tee_shm *shm,
> >                                                    struct page **pages,
> > @@ -30,6 +30,10 @@ int optee_pool_op_alloc_helper(struct tee_shm_pool_mgr *poolm,
> >         struct page *page;
> >         int rc = 0;
> >
> > +       /*
> > +        * Ignore alignment since this is already going to be page aligned
> > +        * and there's no need for any larger alignment.
> > +        */
> >         page = alloc_pages(GFP_KERNEL | __GFP_ZERO, order);
> >         if (!page)
> >                 return -ENOMEM;
> > @@ -51,7 +55,6 @@ int optee_pool_op_alloc_helper(struct tee_shm_pool_mgr *poolm,
> >                 for (i = 0; i < nr_pages; i++)
> >                         pages[i] = page + i;
> >
> > -               shm->flags |= TEE_SHM_REGISTER;
> >                 rc = shm_register(shm->ctx, shm, pages, nr_pages,
> >                                   (unsigned long)shm->kaddr);
> >                 kfree(pages);
> > @@ -62,7 +65,7 @@ int optee_pool_op_alloc_helper(struct tee_shm_pool_mgr *poolm,
> >         return 0;
> >
> >  err:
> > -       __free_pages(page, order);
> > +       free_pages((unsigned long)shm->kaddr, order);
> >         return rc;
> >  }
> >
> > diff --git a/drivers/tee/optee/ffa_abi.c b/drivers/tee/optee/ffa_abi.c
> > index 20a1b1a3d965..e690d9420966 100644
> > --- a/drivers/tee/optee/ffa_abi.c
> > +++ b/drivers/tee/optee/ffa_abi.c
> > @@ -369,14 +369,14 @@ static int optee_ffa_shm_unregister_supp(struct tee_context *ctx,
> >   * The main function is optee_ffa_shm_pool_alloc_pages().
> >   */
> >
> > -static int pool_ffa_op_alloc(struct tee_shm_pool_mgr *poolm,
> > -                            struct tee_shm *shm, size_t size)
> > +static int pool_ffa_op_alloc(struct tee_shm_pool *pool,
> > +                            struct tee_shm *shm, size_t size, size_t align)
> >  {
> > -       return optee_pool_op_alloc_helper(poolm, shm, size,
> > +       return optee_pool_op_alloc_helper(pool, shm, size, align,
> >                                           optee_ffa_shm_register);
> >  }
> >
> > -static void pool_ffa_op_free(struct tee_shm_pool_mgr *poolm,
> > +static void pool_ffa_op_free(struct tee_shm_pool *pool,
> >                              struct tee_shm *shm)
> >  {
> >         optee_ffa_shm_unregister(shm->ctx, shm);
> > @@ -384,15 +384,15 @@ static void pool_ffa_op_free(struct tee_shm_pool_mgr *poolm,
> >         shm->kaddr = NULL;
> >  }
> >
> > -static void pool_ffa_op_destroy_poolmgr(struct tee_shm_pool_mgr *poolm)
> > +static void pool_ffa_op_destroy_pool(struct tee_shm_pool *pool)
> >  {
> > -       kfree(poolm);
> > +       kfree(pool);
> >  }
> >
> > -static const struct tee_shm_pool_mgr_ops pool_ffa_ops = {
> > +static const struct tee_shm_pool_ops pool_ffa_ops = {
> >         .alloc = pool_ffa_op_alloc,
> >         .free = pool_ffa_op_free,
> > -       .destroy_poolmgr = pool_ffa_op_destroy_poolmgr,
> > +       .destroy_pool = pool_ffa_op_destroy_pool,
> >  };
> >
> >  /**
> > @@ -401,16 +401,16 @@ static const struct tee_shm_pool_mgr_ops pool_ffa_ops = {
> >   * This pool is used with OP-TEE over FF-A. In this case command buffers
> >   * and such are allocated from kernel's own memory.
> >   */
> > -static struct tee_shm_pool_mgr *optee_ffa_shm_pool_alloc_pages(void)
> > +static struct tee_shm_pool *optee_ffa_shm_pool_alloc_pages(void)
> >  {
> > -       struct tee_shm_pool_mgr *mgr = kzalloc(sizeof(*mgr), GFP_KERNEL);
> > +       struct tee_shm_pool *pool = kzalloc(sizeof(*pool), GFP_KERNEL);
> >
> > -       if (!mgr)
> > +       if (!pool)
> >                 return ERR_PTR(-ENOMEM);
> >
> > -       mgr->ops = &pool_ffa_ops;
> > +       pool->ops = &pool_ffa_ops;
> >
> > -       return mgr;
> > +       return pool;
> >  }
> >
> >  /*
> > @@ -691,33 +691,6 @@ static bool optee_ffa_exchange_caps(struct ffa_device *ffa_dev,
> >         return true;
> >  }
> >
> > -static struct tee_shm_pool *optee_ffa_config_dyn_shm(void)
> > -{
> > -       struct tee_shm_pool_mgr *priv_mgr;
> > -       struct tee_shm_pool_mgr *dmabuf_mgr;
> > -       void *rc;
> > -
> > -       rc = optee_ffa_shm_pool_alloc_pages();
> > -       if (IS_ERR(rc))
> > -               return rc;
> > -       priv_mgr = rc;
> > -
> > -       rc = optee_ffa_shm_pool_alloc_pages();
> > -       if (IS_ERR(rc)) {
> > -               tee_shm_pool_mgr_destroy(priv_mgr);
> > -               return rc;
> > -       }
> > -       dmabuf_mgr = rc;
> > -
> > -       rc = tee_shm_pool_alloc(priv_mgr, dmabuf_mgr);
> > -       if (IS_ERR(rc)) {
> > -               tee_shm_pool_mgr_destroy(priv_mgr);
> > -               tee_shm_pool_mgr_destroy(dmabuf_mgr);
> > -       }
> > -
> > -       return rc;
> > -}
> > -
> >  static void optee_ffa_get_version(struct tee_device *teedev,
> >                                   struct tee_ioctl_version_data *vers)
> >  {
> > @@ -813,7 +786,7 @@ static int optee_ffa_probe(struct ffa_device *ffa_dev)
> >         if (!optee)
> >                 return -ENOMEM;
> >
> > -       optee->pool = optee_ffa_config_dyn_shm();
> > +       optee->pool = optee_ffa_shm_pool_alloc_pages();
> >         if (IS_ERR(optee->pool)) {
> >                 rc = PTR_ERR(optee->pool);
> >                 optee->pool = NULL;
> > diff --git a/drivers/tee/optee/optee_private.h b/drivers/tee/optee/optee_private.h
> > index 46f74ab07c7e..df2450921464 100644
> > --- a/drivers/tee/optee/optee_private.h
> > +++ b/drivers/tee/optee/optee_private.h
> > @@ -228,8 +228,8 @@ int optee_cancel_req(struct tee_context *ctx, u32 cancel_id, u32 session);
> >  int optee_enumerate_devices(u32 func);
> >  void optee_unregister_devices(void);
> >
> > -int optee_pool_op_alloc_helper(struct tee_shm_pool_mgr *poolm,
> > -                              struct tee_shm *shm, size_t size,
> > +int optee_pool_op_alloc_helper(struct tee_shm_pool *pool, struct tee_shm *shm,
> > +                              size_t size, size_t align,
> >                                int (*shm_register)(struct tee_context *ctx,
> >                                                    struct tee_shm *shm,
> >                                                    struct page **pages,
> > diff --git a/drivers/tee/optee/smc_abi.c b/drivers/tee/optee/smc_abi.c
> > index 449d6a72d289..b679037ea794 100644
> > --- a/drivers/tee/optee/smc_abi.c
> > +++ b/drivers/tee/optee/smc_abi.c
> > @@ -42,8 +42,6 @@
> >   * 6. Driver initialization.
> >   */
> >
> > -#define OPTEE_SHM_NUM_PRIV_PAGES       CONFIG_OPTEE_SHM_NUM_PRIV_PAGES
> > -
> >  /*
> >   * 1. Convert between struct tee_param and struct optee_msg_param
> >   *
> > @@ -532,20 +530,21 @@ static int optee_shm_unregister_supp(struct tee_context *ctx,
> >   * The main function is optee_shm_pool_alloc_pages().
> >   */
> >
> > -static int pool_op_alloc(struct tee_shm_pool_mgr *poolm,
> > -                        struct tee_shm *shm, size_t size)
> > +static int pool_op_alloc(struct tee_shm_pool *pool,
> > +                        struct tee_shm *shm, size_t size, size_t align)
> >  {
> >         /*
> >          * Shared memory private to the OP-TEE driver doesn't need
> >          * to be registered with OP-TEE.
> >          */
> >         if (shm->flags & TEE_SHM_PRIV)
> > -               return optee_pool_op_alloc_helper(poolm, shm, size, NULL);
> > +               return optee_pool_op_alloc_helper(pool, shm, size, align, NULL);
> >
> > -       return optee_pool_op_alloc_helper(poolm, shm, size, optee_shm_register);
> > +       return optee_pool_op_alloc_helper(pool, shm, size, align,
> > +                                         optee_shm_register);
> >  }
> >
> > -static void pool_op_free(struct tee_shm_pool_mgr *poolm,
> > +static void pool_op_free(struct tee_shm_pool *pool,
> >                          struct tee_shm *shm)
> >  {
> >         if (!(shm->flags & TEE_SHM_PRIV))
> > @@ -555,15 +554,15 @@ static void pool_op_free(struct tee_shm_pool_mgr *poolm,
> >         shm->kaddr = NULL;
> >  }
> >
> > -static void pool_op_destroy_poolmgr(struct tee_shm_pool_mgr *poolm)
> > +static void pool_op_destroy_pool(struct tee_shm_pool *pool)
> >  {
> > -       kfree(poolm);
> > +       kfree(pool);
> >  }
> >
> > -static const struct tee_shm_pool_mgr_ops pool_ops = {
> > +static const struct tee_shm_pool_ops pool_ops = {
> >         .alloc = pool_op_alloc,
> >         .free = pool_op_free,
> > -       .destroy_poolmgr = pool_op_destroy_poolmgr,
> > +       .destroy_pool = pool_op_destroy_pool,
> >  };
> >
> >  /**
> > @@ -572,16 +571,16 @@ static const struct tee_shm_pool_mgr_ops pool_ops = {
> >   * This pool is used when OP-TEE supports dymanic SHM. In this case
> >   * command buffers and such are allocated from kernel's own memory.
> >   */
> > -static struct tee_shm_pool_mgr *optee_shm_pool_alloc_pages(void)
> > +static struct tee_shm_pool *optee_shm_pool_alloc_pages(void)
> >  {
> > -       struct tee_shm_pool_mgr *mgr = kzalloc(sizeof(*mgr), GFP_KERNEL);
> > +       struct tee_shm_pool *pool = kzalloc(sizeof(*pool), GFP_KERNEL);
> >
> > -       if (!mgr)
> > +       if (!pool)
> >                 return ERR_PTR(-ENOMEM);
> >
> > -       mgr->ops = &pool_ops;
> > +       pool->ops = &pool_ops;
> >
> > -       return mgr;
> > +       return pool;
> >  }
> >
> >  /*
> > @@ -1174,33 +1173,6 @@ static bool optee_msg_exchange_capabilities(optee_invoke_fn *invoke_fn,
> >         return true;
> >  }
> >
> > -static struct tee_shm_pool *optee_config_dyn_shm(void)
> > -{
> > -       struct tee_shm_pool_mgr *priv_mgr;
> > -       struct tee_shm_pool_mgr *dmabuf_mgr;
> > -       void *rc;
> > -
> > -       rc = optee_shm_pool_alloc_pages();
> > -       if (IS_ERR(rc))
> > -               return rc;
> > -       priv_mgr = rc;
> > -
> > -       rc = optee_shm_pool_alloc_pages();
> > -       if (IS_ERR(rc)) {
> > -               tee_shm_pool_mgr_destroy(priv_mgr);
> > -               return rc;
> > -       }
> > -       dmabuf_mgr = rc;
> > -
> > -       rc = tee_shm_pool_alloc(priv_mgr, dmabuf_mgr);
> > -       if (IS_ERR(rc)) {
> > -               tee_shm_pool_mgr_destroy(priv_mgr);
> > -               tee_shm_pool_mgr_destroy(dmabuf_mgr);
> > -       }
> > -
> > -       return rc;
> > -}
> > -
> >  static struct tee_shm_pool *
> >  optee_config_shm_memremap(optee_invoke_fn *invoke_fn, void **memremaped_shm)
> >  {
> > @@ -1214,10 +1186,7 @@ optee_config_shm_memremap(optee_invoke_fn *invoke_fn, void **memremaped_shm)
> >         phys_addr_t begin;
> >         phys_addr_t end;
> >         void *va;
> > -       struct tee_shm_pool_mgr *priv_mgr;
> > -       struct tee_shm_pool_mgr *dmabuf_mgr;
> >         void *rc;
> > -       const int sz = OPTEE_SHM_NUM_PRIV_PAGES * PAGE_SIZE;
> >
> >         invoke_fn(OPTEE_SMC_GET_SHM_CONFIG, 0, 0, 0, 0, 0, 0, 0, &res.smccc);
> >         if (res.result.status != OPTEE_SMC_RETURN_OK) {
> > @@ -1235,11 +1204,6 @@ optee_config_shm_memremap(optee_invoke_fn *invoke_fn, void **memremaped_shm)
> >         paddr = begin;
> >         size = end - begin;
> >
> > -       if (size < 2 * OPTEE_SHM_NUM_PRIV_PAGES * PAGE_SIZE) {
> > -               pr_err("too small shared memory area\n");
> > -               return ERR_PTR(-EINVAL);
> > -       }
> > -
> >         va = memremap(paddr, size, MEMREMAP_WB);
> >         if (!va) {
> >                 pr_err("shared memory ioremap failed\n");
> > @@ -1247,35 +1211,13 @@ optee_config_shm_memremap(optee_invoke_fn *invoke_fn, void **memremaped_shm)
> >         }
> >         vaddr = (unsigned long)va;
> >
> > -       rc = tee_shm_pool_mgr_alloc_res_mem(vaddr, paddr, sz,
> > -                                           3 /* 8 bytes aligned */);
> > -       if (IS_ERR(rc))
> > -               goto err_memunmap;
> > -       priv_mgr = rc;
> > -
> > -       vaddr += sz;
> > -       paddr += sz;
> > -       size -= sz;
> > -
> > -       rc = tee_shm_pool_mgr_alloc_res_mem(vaddr, paddr, size, PAGE_SHIFT);
> > +       rc = tee_shm_pool_alloc_res_mem(vaddr, paddr, size,
> > +                                       9 /* 512 bytes aligned */);
>
> I don't see a corresponding macro with comments having details for 512
> bytes as default minimum alignment. Once you add that, feel free to
> add:
>
> Reviewed-by: Sumit Garg <sumit.garg@linaro.org>

Thanks for spotting this, somehow that updated patch was lost. I'll add that.

/Jens

>
> -Sumit
>
> >         if (IS_ERR(rc))
> > -               goto err_free_priv_mgr;
> > -       dmabuf_mgr = rc;
> > -
> > -       rc = tee_shm_pool_alloc(priv_mgr, dmabuf_mgr);
> > -       if (IS_ERR(rc))
> > -               goto err_free_dmabuf_mgr;
> > -
> > -       *memremaped_shm = va;
> > -
> > -       return rc;
> > +               memunmap(va);
> > +       else
> > +               *memremaped_shm = va;
> >
> > -err_free_dmabuf_mgr:
> > -       tee_shm_pool_mgr_destroy(dmabuf_mgr);
> > -err_free_priv_mgr:
> > -       tee_shm_pool_mgr_destroy(priv_mgr);
> > -err_memunmap:
> > -       memunmap(va);
> >         return rc;
> >  }
> >
> > @@ -1396,7 +1338,7 @@ static int optee_probe(struct platform_device *pdev)
> >          * Try to use dynamic shared memory if possible
> >          */
> >         if (sec_caps & OPTEE_SMC_SEC_CAP_DYNAMIC_SHM)
> > -               pool = optee_config_dyn_shm();
> > +               pool = optee_shm_pool_alloc_pages();
> >
> >         /*
> >          * If dynamic shared memory is not available or failed - try static one
> > diff --git a/drivers/tee/tee_private.h b/drivers/tee/tee_private.h
> > index e09c8aa5d967..7265f47c6d8e 100644
> > --- a/drivers/tee/tee_private.h
> > +++ b/drivers/tee/tee_private.h
> > @@ -12,17 +12,6 @@
> >  #include <linux/mutex.h>
> >  #include <linux/types.h>
> >
> > -/**
> > - * struct tee_shm_pool - shared memory pool
> > - * @private_mgr:       pool manager for shared memory only between kernel
> > - *                     and secure world
> > - * @dma_buf_mgr:       pool manager for shared memory exported to user space
> > - */
> > -struct tee_shm_pool {
> > -       struct tee_shm_pool_mgr *private_mgr;
> > -       struct tee_shm_pool_mgr *dma_buf_mgr;
> > -};
> > -
> >  #define TEE_DEVICE_FLAG_REGISTERED     0x1
> >  #define TEE_MAX_DEV_NAME_LEN           32
> >
> > diff --git a/drivers/tee/tee_shm.c b/drivers/tee/tee_shm.c
> > index 7e7e762fc1de..f0a9cccd2f2c 100644
> > --- a/drivers/tee/tee_shm.c
> > +++ b/drivers/tee/tee_shm.c
> > @@ -31,14 +31,7 @@ static void release_registered_pages(struct tee_shm *shm)
> >  static void tee_shm_release(struct tee_device *teedev, struct tee_shm *shm)
> >  {
> >         if (shm->flags & TEE_SHM_POOL) {
> > -               struct tee_shm_pool_mgr *poolm;
> > -
> > -               if (shm->flags & TEE_SHM_DMA_BUF)
> > -                       poolm = teedev->pool->dma_buf_mgr;
> > -               else
> > -                       poolm = teedev->pool->private_mgr;
> > -
> > -               poolm->ops->free(poolm, shm);
> > +               teedev->pool->ops->free(teedev->pool, shm);
> >         } else if (shm->flags & TEE_SHM_REGISTER) {
> >                 int rc = teedev->desc->ops->shm_unregister(shm->ctx, shm);
> >
> > @@ -59,8 +52,8 @@ static void tee_shm_release(struct tee_device *teedev, struct tee_shm *shm)
> >  struct tee_shm *tee_shm_alloc(struct tee_context *ctx, size_t size, u32 flags)
> >  {
> >         struct tee_device *teedev = ctx->teedev;
> > -       struct tee_shm_pool_mgr *poolm = NULL;
> >         struct tee_shm *shm;
> > +       size_t align;
> >         void *ret;
> >         int rc;
> >
> > @@ -93,12 +86,18 @@ struct tee_shm *tee_shm_alloc(struct tee_context *ctx, size_t size, u32 flags)
> >         refcount_set(&shm->refcount, 1);
> >         shm->flags = flags | TEE_SHM_POOL;
> >         shm->ctx = ctx;
> > -       if (flags & TEE_SHM_DMA_BUF)
> > -               poolm = teedev->pool->dma_buf_mgr;
> > -       else
> > -               poolm = teedev->pool->private_mgr;
> > +       if (flags & TEE_SHM_DMA_BUF) {
> > +               align = PAGE_SIZE;
> > +               /*
> > +                * Request to register the shm in the pool allocator below
> > +                * if supported.
> > +                */
> > +               shm->flags |= TEE_SHM_REGISTER;
> > +       } else {
> > +               align = 2 * sizeof(long);
> > +       }
> >
> > -       rc = poolm->ops->alloc(poolm, shm, size);
> > +       rc = teedev->pool->ops->alloc(teedev->pool, shm, size, align);
> >         if (rc) {
> >                 ret = ERR_PTR(rc);
> >                 goto err_kfree;
> > @@ -118,7 +117,7 @@ struct tee_shm *tee_shm_alloc(struct tee_context *ctx, size_t size, u32 flags)
> >
> >         return shm;
> >  err_pool_free:
> > -       poolm->ops->free(poolm, shm);
> > +       teedev->pool->ops->free(teedev->pool, shm);
> >  err_kfree:
> >         kfree(shm);
> >  err_dev_put:
> > diff --git a/drivers/tee/tee_shm_pool.c b/drivers/tee/tee_shm_pool.c
> > index 0e460347138a..71e0f8ae69aa 100644
> > --- a/drivers/tee/tee_shm_pool.c
> > +++ b/drivers/tee/tee_shm_pool.c
> > @@ -9,14 +9,16 @@
> >  #include <linux/tee_drv.h>
> >  #include "tee_private.h"
> >
> > -static int pool_op_gen_alloc(struct tee_shm_pool_mgr *poolm,
> > -                            struct tee_shm *shm, size_t size)
> > +static int pool_op_gen_alloc(struct tee_shm_pool *pool, struct tee_shm *shm,
> > +                            size_t size, size_t align)
> >  {
> >         unsigned long va;
> > -       struct gen_pool *genpool = poolm->private_data;
> > -       size_t s = roundup(size, 1 << genpool->min_alloc_order);
> > +       struct gen_pool *genpool = pool->private_data;
> > +       size_t a = max_t(size_t, align, BIT(genpool->min_alloc_order));
> > +       struct genpool_data_align data = { .align = a };
> > +       size_t s = roundup(size, a);
> >
> > -       va = gen_pool_alloc(genpool, s);
> > +       va = gen_pool_alloc_algo(genpool, s, gen_pool_first_fit_align, &data);
> >         if (!va)
> >                 return -ENOMEM;
> >
> > @@ -24,107 +26,67 @@ static int pool_op_gen_alloc(struct tee_shm_pool_mgr *poolm,
> >         shm->kaddr = (void *)va;
> >         shm->paddr = gen_pool_virt_to_phys(genpool, va);
> >         shm->size = s;
> > +       /*
> > +        * This is from a static shared memory pool so no need to register
> > +        * each chunk, and no need to unregister later either.
> > +        */
> > +       shm->flags &= ~TEE_SHM_REGISTER;
> >         return 0;
> >  }
> >
> > -static void pool_op_gen_free(struct tee_shm_pool_mgr *poolm,
> > -                            struct tee_shm *shm)
> > +static void pool_op_gen_free(struct tee_shm_pool *pool, struct tee_shm *shm)
> >  {
> > -       gen_pool_free(poolm->private_data, (unsigned long)shm->kaddr,
> > +       gen_pool_free(pool->private_data, (unsigned long)shm->kaddr,
> >                       shm->size);
> >         shm->kaddr = NULL;
> >  }
> >
> > -static void pool_op_gen_destroy_poolmgr(struct tee_shm_pool_mgr *poolm)
> > +static void pool_op_gen_destroy_pool(struct tee_shm_pool *pool)
> >  {
> > -       gen_pool_destroy(poolm->private_data);
> > -       kfree(poolm);
> > +       gen_pool_destroy(pool->private_data);
> > +       kfree(pool);
> >  }
> >
> > -static const struct tee_shm_pool_mgr_ops pool_ops_generic = {
> > +static const struct tee_shm_pool_ops pool_ops_generic = {
> >         .alloc = pool_op_gen_alloc,
> >         .free = pool_op_gen_free,
> > -       .destroy_poolmgr = pool_op_gen_destroy_poolmgr,
> > +       .destroy_pool = pool_op_gen_destroy_pool,
> >  };
> >
> > -struct tee_shm_pool_mgr *tee_shm_pool_mgr_alloc_res_mem(unsigned long vaddr,
> > -                                                       phys_addr_t paddr,
> > -                                                       size_t size,
> > -                                                       int min_alloc_order)
> > +struct tee_shm_pool *tee_shm_pool_alloc_res_mem(unsigned long vaddr,
> > +                                               phys_addr_t paddr, size_t size,
> > +                                               int min_alloc_order)
> >  {
> >         const size_t page_mask = PAGE_SIZE - 1;
> > -       struct tee_shm_pool_mgr *mgr;
> > +       struct tee_shm_pool *pool;
> >         int rc;
> >
> >         /* Start and end must be page aligned */
> >         if (vaddr & page_mask || paddr & page_mask || size & page_mask)
> >                 return ERR_PTR(-EINVAL);
> >
> > -       mgr = kzalloc(sizeof(*mgr), GFP_KERNEL);
> > -       if (!mgr)
> > +       pool = kzalloc(sizeof(*pool), GFP_KERNEL);
> > +       if (!pool)
> >                 return ERR_PTR(-ENOMEM);
> >
> > -       mgr->private_data = gen_pool_create(min_alloc_order, -1);
> > -       if (!mgr->private_data) {
> > +       pool->private_data = gen_pool_create(min_alloc_order, -1);
> > +       if (!pool->private_data) {
> >                 rc = -ENOMEM;
> >                 goto err;
> >         }
> >
> > -       gen_pool_set_algo(mgr->private_data, gen_pool_best_fit, NULL);
> > -       rc = gen_pool_add_virt(mgr->private_data, vaddr, paddr, size, -1);
> > +       rc = gen_pool_add_virt(pool->private_data, vaddr, paddr, size, -1);
> >         if (rc) {
> > -               gen_pool_destroy(mgr->private_data);
> > +               gen_pool_destroy(pool->private_data);
> >                 goto err;
> >         }
> >
> > -       mgr->ops = &pool_ops_generic;
> > +       pool->ops = &pool_ops_generic;
> >
> > -       return mgr;
> > +       return pool;
> >  err:
> > -       kfree(mgr);
> > +       kfree(pool);
> >
> >         return ERR_PTR(rc);
> >  }
> > -EXPORT_SYMBOL_GPL(tee_shm_pool_mgr_alloc_res_mem);
> > -
> > -static bool check_mgr_ops(struct tee_shm_pool_mgr *mgr)
> > -{
> > -       return mgr && mgr->ops && mgr->ops->alloc && mgr->ops->free &&
> > -               mgr->ops->destroy_poolmgr;
> > -}
> > -
> > -struct tee_shm_pool *tee_shm_pool_alloc(struct tee_shm_pool_mgr *priv_mgr,
> > -                                       struct tee_shm_pool_mgr *dmabuf_mgr)
> > -{
> > -       struct tee_shm_pool *pool;
> > -
> > -       if (!check_mgr_ops(priv_mgr) || !check_mgr_ops(dmabuf_mgr))
> > -               return ERR_PTR(-EINVAL);
> > -
> > -       pool = kzalloc(sizeof(*pool), GFP_KERNEL);
> > -       if (!pool)
> > -               return ERR_PTR(-ENOMEM);
> > -
> > -       pool->private_mgr = priv_mgr;
> > -       pool->dma_buf_mgr = dmabuf_mgr;
> > -
> > -       return pool;
> > -}
> > -EXPORT_SYMBOL_GPL(tee_shm_pool_alloc);
> > -
> > -/**
> > - * tee_shm_pool_free() - Free a shared memory pool
> > - * @pool:      The shared memory pool to free
> > - *
> > - * There must be no remaining shared memory allocated from this pool when
> > - * this function is called.
> > - */
> > -void tee_shm_pool_free(struct tee_shm_pool *pool)
> > -{
> > -       if (pool->private_mgr)
> > -               tee_shm_pool_mgr_destroy(pool->private_mgr);
> > -       if (pool->dma_buf_mgr)
> > -               tee_shm_pool_mgr_destroy(pool->dma_buf_mgr);
> > -       kfree(pool);
> > -}
> > -EXPORT_SYMBOL_GPL(tee_shm_pool_free);
> > +EXPORT_SYMBOL_GPL(tee_shm_pool_alloc_res_mem);
> > diff --git a/include/linux/tee_drv.h b/include/linux/tee_drv.h
> > index 975500b2553e..ed641dc314bd 100644
> > --- a/include/linux/tee_drv.h
> > +++ b/include/linux/tee_drv.h
> > @@ -221,62 +221,39 @@ struct tee_shm {
> >  };
> >
> >  /**
> > - * struct tee_shm_pool_mgr - shared memory manager
> > + * struct tee_shm_pool - shared memory pool
> >   * @ops:               operations
> >   * @private_data:      private data for the shared memory manager
> >   */
> > -struct tee_shm_pool_mgr {
> > -       const struct tee_shm_pool_mgr_ops *ops;
> > +struct tee_shm_pool {
> > +       const struct tee_shm_pool_ops *ops;
> >         void *private_data;
> >  };
> >
> >  /**
> > - * struct tee_shm_pool_mgr_ops - shared memory pool manager operations
> > + * struct tee_shm_pool_ops - shared memory pool operations
> >   * @alloc:             called when allocating shared memory
> >   * @free:              called when freeing shared memory
> > - * @destroy_poolmgr:   called when destroying the pool manager
> > + * @destroy_pool:      called when destroying the pool
> >   */
> > -struct tee_shm_pool_mgr_ops {
> > -       int (*alloc)(struct tee_shm_pool_mgr *poolmgr, struct tee_shm *shm,
> > -                    size_t size);
> > -       void (*free)(struct tee_shm_pool_mgr *poolmgr, struct tee_shm *shm);
> > -       void (*destroy_poolmgr)(struct tee_shm_pool_mgr *poolmgr);
> > +struct tee_shm_pool_ops {
> > +       int (*alloc)(struct tee_shm_pool *pool, struct tee_shm *shm,
> > +                    size_t size, size_t align);
> > +       void (*free)(struct tee_shm_pool *pool, struct tee_shm *shm);
> > +       void (*destroy_pool)(struct tee_shm_pool *pool);
> >  };
> >
> > -/**
> > - * tee_shm_pool_alloc() - Create a shared memory pool from shm managers
> > - * @priv_mgr:  manager for driver private shared memory allocations
> > - * @dmabuf_mgr:        manager for dma-buf shared memory allocations
> > - *
> > - * Allocation with the flag TEE_SHM_DMA_BUF set will use the range supplied
> > - * in @dmabuf, others will use the range provided by @priv.
> > - *
> > - * @returns pointer to a 'struct tee_shm_pool' or an ERR_PTR on failure.
> > - */
> > -struct tee_shm_pool *tee_shm_pool_alloc(struct tee_shm_pool_mgr *priv_mgr,
> > -                                       struct tee_shm_pool_mgr *dmabuf_mgr);
> > -
> >  /*
> > - * tee_shm_pool_mgr_alloc_res_mem() - Create a shm manager for reserved
> > - * memory
> > + * tee_shm_pool_alloc_res_mem() - Create a shm manager for reserved memory
> >   * @vaddr:     Virtual address of start of pool
> >   * @paddr:     Physical address of start of pool
> >   * @size:      Size in bytes of the pool
> >   *
> > - * @returns pointer to a 'struct tee_shm_pool_mgr' or an ERR_PTR on failure.
> > - */
> > -struct tee_shm_pool_mgr *tee_shm_pool_mgr_alloc_res_mem(unsigned long vaddr,
> > -                                                       phys_addr_t paddr,
> > -                                                       size_t size,
> > -                                                       int min_alloc_order);
> > -
> > -/**
> > - * tee_shm_pool_mgr_destroy() - Free a shared memory manager
> > + * @returns pointer to a 'struct tee_shm_pool' or an ERR_PTR on failure.
> >   */
> > -static inline void tee_shm_pool_mgr_destroy(struct tee_shm_pool_mgr *poolm)
> > -{
> > -       poolm->ops->destroy_poolmgr(poolm);
> > -}
> > +struct tee_shm_pool *tee_shm_pool_alloc_res_mem(unsigned long vaddr,
> > +                                               phys_addr_t paddr, size_t size,
> > +                                               int min_alloc_order);
> >
> >  /**
> >   * tee_shm_pool_free() - Free a shared memory pool
> > @@ -285,7 +262,10 @@ static inline void tee_shm_pool_mgr_destroy(struct tee_shm_pool_mgr *poolm)
> >   * The must be no remaining shared memory allocated from this pool when
> >   * this function is called.
> >   */
> > -void tee_shm_pool_free(struct tee_shm_pool *pool);
> > +static inline void tee_shm_pool_free(struct tee_shm_pool *pool)
> > +{
> > +       pool->ops->destroy_pool(pool);
> > +}
> >
> >  /**
> >   * tee_get_drvdata() - Return driver_data pointer
> > --
> > 2.31.1
> >
