Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 79FD050D92B
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Apr 2022 08:04:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241435AbiDYGHi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Apr 2022 02:07:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56554 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237416AbiDYGGX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Apr 2022 02:06:23 -0400
Received: from mail-pg1-x52c.google.com (mail-pg1-x52c.google.com [IPv6:2607:f8b0:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F3F6BE0D
        for <linux-kernel@vger.kernel.org>; Sun, 24 Apr 2022 23:03:19 -0700 (PDT)
Received: by mail-pg1-x52c.google.com with SMTP id 15so4183476pgf.4
        for <linux-kernel@vger.kernel.org>; Sun, 24 Apr 2022 23:03:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=D2HVRNqoDXt0lpouIfLLUgo8GsxY/g45FAFyGsMdldY=;
        b=Q71PDeNOH4ByjI6Lp5ko2G4gHswGpBhszZOL9nkU6nM7bkFd5VfeSQJ/k9oSnj7xZy
         16kprRFDcDn2ySgpCeNvrcw9+vizOzWiweOc/Cv0hh1GPcpXuSTxgO8vOiYbpY55yctT
         xKCT1/+rv6CAchuvY9SIWYzrFzMBUcOT7hm/G9VV6v3haNamIvdV7UFz+Ud9EBCOKopk
         k2CXdrPdtM6AJiCItbyfWlrwSNbZ4Djb/mk1Lvw6LYSJ1vQRpaHCgJBrpG4Wosh07jMD
         Olfz+RCz5WJFHLwq5VjlToqz/8fqyS0q50YQ2gMMpMeC3p1aBg5xfhoYW83MvCxiKb+d
         auow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=D2HVRNqoDXt0lpouIfLLUgo8GsxY/g45FAFyGsMdldY=;
        b=6I7NrVOJ6PVCALEXRv18RjE3BJwPzqDXzcX/wg4c0kPtp3ZRJt8Wd2hmgGicDfC/qC
         U4/g93yd8MJQcfR7XNUc8LXLXWdrJi1hkfq2L3fX7yYxAiKFMrsWkOqgwvAXGMfNhEQJ
         yqSWvGfuoorB7D2AMz5ceiV+NyT3iZrpPZvSDvaMfDd956VI7r3lAnXmlwsRFCYlo2CS
         rT9bh8tj4J9sDDUdvpw+lp7YCb9kr0slUD8HN541KnsZnZ/u4nscJ5xd0r1RTDgoOaeF
         xE0HKjWSIloVRR+eX0YEJiB7pX1t/ZE6/viB8fxa9v6VElE1VXJBJ5/M7Cws3fqMpF/q
         rf7g==
X-Gm-Message-State: AOAM530wDu24HCO/AFPdWmF2ckVY3Hiu6URDpoWxzRe3UeIz3r01DNma
        TB+/k4PTNiJLLOwz3EcNkMo2bBy10slBBKQpfsIgPw==
X-Google-Smtp-Source: ABdhPJzEYe//c1hGtN88eIrgiMKl21K8X03vn7sgMOVmVzwZwdHxnO0NQaL2Zs2A7dUmz6T/O+eH9/dHh/qWud8H69I=
X-Received: by 2002:a63:ad4d:0:b0:378:4b82:b881 with SMTP id
 y13-20020a63ad4d000000b003784b82b881mr14261924pgo.282.1650866598777; Sun, 24
 Apr 2022 23:03:18 -0700 (PDT)
MIME-Version: 1.0
References: <20220422180139.13447-1-afd@ti.com>
In-Reply-To: <20220422180139.13447-1-afd@ti.com>
From:   Sumit Garg <sumit.garg@linaro.org>
Date:   Mon, 25 Apr 2022 11:33:04 +0530
Message-ID: <CAFA6WYOb9xBvTBSQoge7AhBXEfTmOJ3W7qMiY-EAy2AMHjERVA@mail.gmail.com>
Subject: Re: [PATCH 1/2] tee: remove tee_shm_va2pa() and tee_shm_pa2va()
To:     Andrew Davis <afd@ti.com>
Cc:     Jens Wiklander <jens.wiklander@linaro.org>,
        op-tee@lists.trustedfirmware.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 22 Apr 2022 at 23:31, Andrew Davis <afd@ti.com> wrote:
>
> We should not need to index into SHMs based on absolute VA/PA.
> These functions are not used and this kind of usage should not be
> encouraged anyway. Remove these functions.
>
> Signed-off-by: Andrew Davis <afd@ti.com>
> ---
>  drivers/tee/tee_shm.c   | 50 -----------------------------------------
>  include/linux/tee_drv.h | 18 ---------------
>  2 files changed, 68 deletions(-)
>

Sounds good to me as there are tee_shm_get_{va/pa}() which are well
suited/used for index based VA/PA. FWIW:

Reviewed-by: Sumit Garg <sumit.garg@linaro.org>

-Sumit

> diff --git a/drivers/tee/tee_shm.c b/drivers/tee/tee_shm.c
> index f31e29e8f1cac..b0c6d553d3a70 100644
> --- a/drivers/tee/tee_shm.c
> +++ b/drivers/tee/tee_shm.c
> @@ -414,56 +414,6 @@ void tee_shm_free(struct tee_shm *shm)
>  }
>  EXPORT_SYMBOL_GPL(tee_shm_free);
>
> -/**
> - * tee_shm_va2pa() - Get physical address of a virtual address
> - * @shm:       Shared memory handle
> - * @va:                Virtual address to tranlsate
> - * @pa:                Returned physical address
> - * @returns 0 on success and < 0 on failure
> - */
> -int tee_shm_va2pa(struct tee_shm *shm, void *va, phys_addr_t *pa)
> -{
> -       if (!shm->kaddr)
> -               return -EINVAL;
> -       /* Check that we're in the range of the shm */
> -       if ((char *)va < (char *)shm->kaddr)
> -               return -EINVAL;
> -       if ((char *)va >= ((char *)shm->kaddr + shm->size))
> -               return -EINVAL;
> -
> -       return tee_shm_get_pa(
> -                       shm, (unsigned long)va - (unsigned long)shm->kaddr, pa);
> -}
> -EXPORT_SYMBOL_GPL(tee_shm_va2pa);
> -
> -/**
> - * tee_shm_pa2va() - Get virtual address of a physical address
> - * @shm:       Shared memory handle
> - * @pa:                Physical address to tranlsate
> - * @va:                Returned virtual address
> - * @returns 0 on success and < 0 on failure
> - */
> -int tee_shm_pa2va(struct tee_shm *shm, phys_addr_t pa, void **va)
> -{
> -       if (!shm->kaddr)
> -               return -EINVAL;
> -       /* Check that we're in the range of the shm */
> -       if (pa < shm->paddr)
> -               return -EINVAL;
> -       if (pa >= (shm->paddr + shm->size))
> -               return -EINVAL;
> -
> -       if (va) {
> -               void *v = tee_shm_get_va(shm, pa - shm->paddr);
> -
> -               if (IS_ERR(v))
> -                       return PTR_ERR(v);
> -               *va = v;
> -       }
> -       return 0;
> -}
> -EXPORT_SYMBOL_GPL(tee_shm_pa2va);
> -
>  /**
>   * tee_shm_get_va() - Get virtual address of a shared memory plus an offset
>   * @shm:       Shared memory handle
> diff --git a/include/linux/tee_drv.h b/include/linux/tee_drv.h
> index 911cad324acc7..17eb1c5205d34 100644
> --- a/include/linux/tee_drv.h
> +++ b/include/linux/tee_drv.h
> @@ -298,24 +298,6 @@ void tee_shm_free(struct tee_shm *shm);
>   */
>  void tee_shm_put(struct tee_shm *shm);
>
> -/**
> - * tee_shm_va2pa() - Get physical address of a virtual address
> - * @shm:       Shared memory handle
> - * @va:                Virtual address to tranlsate
> - * @pa:                Returned physical address
> - * @returns 0 on success and < 0 on failure
> - */
> -int tee_shm_va2pa(struct tee_shm *shm, void *va, phys_addr_t *pa);
> -
> -/**
> - * tee_shm_pa2va() - Get virtual address of a physical address
> - * @shm:       Shared memory handle
> - * @pa:                Physical address to tranlsate
> - * @va:                Returned virtual address
> - * @returns 0 on success and < 0 on failure
> - */
> -int tee_shm_pa2va(struct tee_shm *shm, phys_addr_t pa, void **va);
> -
>  /**
>   * tee_shm_get_va() - Get virtual address of a shared memory plus an offset
>   * @shm:       Shared memory handle
> --
> 2.17.1
>
