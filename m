Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9D8144B80CC
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Feb 2022 07:46:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229471AbiBPGp0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Feb 2022 01:45:26 -0500
Received: from gmail-smtp-in.l.google.com ([23.128.96.19]:47320 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229379AbiBPGpY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Feb 2022 01:45:24 -0500
Received: from mail-pl1-x630.google.com (mail-pl1-x630.google.com [IPv6:2607:f8b0:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ECD6425D265
        for <linux-kernel@vger.kernel.org>; Tue, 15 Feb 2022 22:45:03 -0800 (PST)
Received: by mail-pl1-x630.google.com with SMTP id y18so1250031plb.11
        for <linux-kernel@vger.kernel.org>; Tue, 15 Feb 2022 22:45:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=I31WZqXJ0s57cOlXZD8FT8G+iFz5eek0G4Woh5U+0sQ=;
        b=QJv4wGhz8pW7njZZS5dYoNkCgBZNfRVVUnN+Tv7Cii975mOEmj/5fFj2/zzERDaGW8
         S9lPYJAJdvStBpq3hrjdbTs9dmaT3hnlwMg3xH4W0BYbkoia0G5md0gn0txkh049kIlH
         AM8x/LqxJ9hrt+oG+DvsJ6ARxwIjSeyJYDcgGzSafviVV8ppADehzm+2INH8U4ZEmHuO
         dUM5XyEu+uzuC2dRkHC2QYNFpQ14mC3Tp6K9pXKIfm0wi8H6H13ne2rjaVKdPo4+i3YB
         E/fcLRegHHsZHDpzq3CZRlq5ic7Y2d8jrr4dLoGaNUZg/gmhh30ZFe9JK6gCa5nmWaY6
         FeRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=I31WZqXJ0s57cOlXZD8FT8G+iFz5eek0G4Woh5U+0sQ=;
        b=xhEJNFwUlteRSHU3NSZGT1RuR58rtCW214aqsQK341VjdC/ZoVQjHz9pIHV8/3r2EI
         4hhss8L9LmLd8pl49wI2S52JUItMTEtwm6OcaBdXkGIGOk3O+XVf0hcHKWUIzS4z4KsU
         bpqB/+9+s/C/AJ7EgrT/1UReQPc5wn65d2XRJiQX/4uAbU7nL2dDGrF4ma4cenFR2ELz
         WmbHw0HTOLTC6JUbPQkmhLop84Bf9/e0eWrvesqivZEKxMbn4WbFfy2ovLNTtSEcMIa0
         5xBBXaMgNWNUTjsuqBaVn+0HMrhZhnj/OM7BKPYiynz1TYu6iyxtjT+12RHoYkHA6F4G
         iorA==
X-Gm-Message-State: AOAM531DUPChVxB+wVznHSJ+ui3wJk/IlE1JkKAasxxTpdvyCYCXaD2h
        bFKGCSeNYoRl8urFELR3UuxlvP16WBuFdwTcC8NyrojQr4M=
X-Google-Smtp-Source: ABdhPJxdtLKjsFZlFSmqpL2ejNPDXl9omjbXxQeTNQwnZXEwhr8f66+fWiNwTpk3bxbzowNNdi32Q1fYQzbESdhZe0k=
X-Received: by 2002:a17:903:249:b0:14d:950c:7437 with SMTP id
 j9-20020a170903024900b0014d950c7437mr1481250plh.174.1644993637641; Tue, 15
 Feb 2022 22:40:37 -0800 (PST)
MIME-Version: 1.0
References: <20220204093359.359059-1-jens.wiklander@linaro.org>
In-Reply-To: <20220204093359.359059-1-jens.wiklander@linaro.org>
From:   Jens Wiklander <jens.wiklander@linaro.org>
Date:   Wed, 16 Feb 2022 07:40:26 +0100
Message-ID: <CAHUa44Gm6mTq2mp8JzxL7_MDfJa0ApVbkaV6ZOMOaKMWti2fDg@mail.gmail.com>
Subject: Re: [PATCH v4 00/10] tee: shared memory updates
To:     linux-kernel@vger.kernel.org, op-tee@lists.trustedfirmware.org
Cc:     Sumit Garg <sumit.garg@linaro.org>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        Devaraj Rangasamy <Devaraj.Rangasamy@amd.com>,
        Rijo Thomas <Rijo-john.Thomas@amd.com>,
        David Howells <dhowells@redhat.com>,
        Tyler Hicks <tyhicks@linux.microsoft.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,

On Fri, Feb 4, 2022 at 10:34 AM Jens Wiklander
<jens.wiklander@linaro.org> wrote:
>
> Hi all,
>
> This patchset is a general cleanup of shared memory handling in the TEE
> subsystem.
>
> Until now has the in-kernel tee clients used tee_shm_alloc() and
> tee_shm_register() to share memory with secure world. These two function
> exposes via a flags parameter a bit more of the internals of the TEE
> subsystem than one would like. So in order to make things easier are those
> two functions replaced by few functions which should provide better
> abstraction.
>
> Two in-kernel tee clients are updated to use these new functions.
>
> The shared memory pool handling is simplified, an internal matter for the
> two TEE drivers OP-TEE and AMDTEE.
>
> In the v3 review it was suggested [1] to break out "optee: add driver
> private tee_context" and "optee: use driver internal tee_contex for some
> rpc" into a separate patch to fix to allow those a faster path upstream as
> they fix reported problems. So this patchset is now rebased on top of those
> patches separated.
>
> This patchset is based on [2] and is also available at [3].

All patches are reviewed and there are no further comments so I'm
picking up this now.

Cheers,
Jens

>
> Thanks,
> Jens
>
> [1] https://lore.kernel.org/lkml/20220125162938.838382-1-jens.wiklander@linaro.org/T/#m9e38c5788b49ed3929276df69fe856b6cbe14dfb
> [2] https://git.linaro.org/people/jens.wiklander/linux-tee.git/log/?h=fixes
> [3] https://git.linaro.org/people/jens.wiklander/linux-tee.git/log/?h=tee_shm_v4
>
> v3->v4:
> * Broke out "optee: add driver private tee_context" and "optee: use driver
>   internal tee_contex for some rpc" into a separate patch as that fixes
>   earlier reported issues and deserves a to go into v5.17 and stable
>   trees.
> * Rebased on the recent fixes for the OP-TEE driver on top of v5.17-rc2
> * All patches are now reviewed by Sumit Garg + some small fixes from the
>   last review
>
> v2->v3:
> * Make tee_shm_alloc_user_buf() and tee_shm_register_user_buf() internal
>   and don't export them to the drivers.
> * Rename tee_shm_alloc_priv_kernel_buf() to tee_shm_alloc_priv_buf()
> * Adressing comments on variable names and choice of types in "tee: replace
>   tee_shm_register()"
> * Adding detailed explaination on alignment in "tee: simplify shm pool handling"
> * Added Sumits R-B on a few of the patches
>
> v1->v2:
> * The commits three "tee: add tee_shm_alloc_kernel_buf()",
>   "tpm_ftpm_tee: use tee_shm_alloc_kernel_buf()" and
>   "firmware: tee_bnxt: use tee_shm_alloc_kernel_buf()" has been merged some
>   time ago as part of another patchset.
> * Another in-kernel tee client is updated with the commit
>   "KEYS: trusted: tee: use tee_shm_register_kernel_buf()"
> * tee_shm_alloc_anon_kernel_buf() is replaced with an easier to use function
>   tee_shm_alloc_priv_kernel_buf() and tee_shm_free_anon_kernel_buf() has
>   been dropped.
> * A driver internal struct tee_context is used to when doing driver internal
>   calls to secure world.
> * Adds patches to replace tee_shm_register() in a similar way as how
>   tee_shm_alloc() is replaced.
> * A patch is added to clean up the TEE_SHM_* flags
> * Fixed a warning reported by kernel test robot <lkp@intel.com>
>
> Jens Wiklander (10):
>   hwrng: optee-rng: use tee_shm_alloc_kernel_buf()
>   tee: remove unused tee_shm_pool_alloc_res_mem()
>   tee: add tee_shm_alloc_user_buf()
>   tee: simplify shm pool handling
>   tee: replace tee_shm_alloc()
>   optee: add optee_pool_op_free_helper()
>   tee: add tee_shm_register_{user,kernel}_buf()
>   KEYS: trusted: tee: use tee_shm_register_kernel_buf()
>   tee: replace tee_shm_register()
>   tee: refactor TEE_SHM_* flags
>
>  drivers/char/hw_random/optee-rng.c       |   6 +-
>  drivers/tee/amdtee/shm_pool.c            |  55 ++--
>  drivers/tee/optee/Kconfig                |   8 -
>  drivers/tee/optee/call.c                 |   2 +-
>  drivers/tee/optee/core.c                 |  21 +-
>  drivers/tee/optee/device.c               |   5 +-
>  drivers/tee/optee/ffa_abi.c              |  63 ++---
>  drivers/tee/optee/optee_private.h        |   7 +-
>  drivers/tee/optee/smc_abi.c              | 125 +++------
>  drivers/tee/tee_core.c                   |   5 +-
>  drivers/tee/tee_private.h                |  15 +-
>  drivers/tee/tee_shm.c                    | 320 +++++++++++++++--------
>  drivers/tee/tee_shm_pool.c               | 162 +++---------
>  include/linux/tee_drv.h                  | 138 +++-------
>  security/keys/trusted-keys/trusted_tee.c |  23 +-
>  15 files changed, 388 insertions(+), 567 deletions(-)
>
> --
> 2.31.1
>
