Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AF3F650F398
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Apr 2022 10:22:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344704AbiDZIYh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Apr 2022 04:24:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52560 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344662AbiDZIYO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Apr 2022 04:24:14 -0400
Received: from mail-pj1-x102f.google.com (mail-pj1-x102f.google.com [IPv6:2607:f8b0:4864:20::102f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C64539838
        for <linux-kernel@vger.kernel.org>; Tue, 26 Apr 2022 01:21:08 -0700 (PDT)
Received: by mail-pj1-x102f.google.com with SMTP id t11-20020a17090ad50b00b001d95bf21996so1606550pju.2
        for <linux-kernel@vger.kernel.org>; Tue, 26 Apr 2022 01:21:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=+PWofH/RE6RL2blsl7TB3HGBX5BGWv6xmkidIQQtCCg=;
        b=uMn/M2EEbAJ4RLO38L9gqrx0NAjQOFbvqlXeh61iCQm5F/UGxznnQ2s12owTocPXSy
         1Wbgf887qz7kVR8N5/alZpo3qo672B2ZisDSdYdFLjqRaWaFfZvmk63zEs5jOlnFwSuy
         7f61WmoH5Eanndg+TV8o/LAKg5mbEQeJDfRs5qu+/ovsWS0v35H5N2Uli3demS1DCI88
         pwDXvdpwy+XH9kr4SyRkqmnpNyyw/ABULtY+pcpj2Vv73XsyozOazq024Ej30d6Q1k4o
         n2VsZe6TMdTRoyCFmvTF74UfSaMrdngPe5m9K8zAFiMl1ipelgVOK0Vaj4YUaCDOSu87
         hRPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=+PWofH/RE6RL2blsl7TB3HGBX5BGWv6xmkidIQQtCCg=;
        b=G4Dp0wEsVSNX2hpt725JgZxZ485fizmvVBowbqNK8kXa9H+dCmV7cXshlc9SnnZNEd
         wgyIQOh9fl6QZHvMzXsCBwO0sI7rgtTEi5i3uVoaQMAszJLOLEsQVo6WJByR43Frw9EM
         qdsaYRwLcFIkdebd2TLjuNcXEpDsS8evp3YfMow8cY4ZW4mko1RqbGNKKQYhdS7DcMX4
         MC1DAqFcxnIXyzPFNzPFSjtBuZcK18hqHId70ChMLjGyPfHIP9u/hKwYiAkEhb8kcQGl
         6Qva3tGKYSzu57DGyGkM1IKPnHjXXhhiYNtW5ZrBg4p7zYGu1/cMpAy+6K8gha3dAjFz
         E7ng==
X-Gm-Message-State: AOAM533Gbb0YKimdy+4HB2u8OhgegWUDit/SwxqJcPrqAuogW1wj35EH
        P3Nzc9prXIkNVJjzbtOrROlva00JhS3M5iLoYNglqQ==
X-Google-Smtp-Source: ABdhPJzoyy2WHq7rGmwl0o9drw9QZZ2ZXi71UfPy5x1f4hlZEF0nmAt4JkjzQV+e0wK283j060u3fBJCgNvORB6naps=
X-Received: by 2002:a17:903:1212:b0:156:3ddc:84bd with SMTP id
 l18-20020a170903121200b001563ddc84bdmr21769690plh.70.1650961267556; Tue, 26
 Apr 2022 01:21:07 -0700 (PDT)
MIME-Version: 1.0
References: <20220425141617.23925-1-afd@ti.com>
In-Reply-To: <20220425141617.23925-1-afd@ti.com>
From:   Jens Wiklander <jens.wiklander@linaro.org>
Date:   Tue, 26 Apr 2022 10:20:56 +0200
Message-ID: <CAHUa44HMbsthyH1FN-Ug3ArGCApWtWT=H4D1qKk-PTKRsyJPBw@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] tee: remove tee_shm_va2pa() and tee_shm_pa2va()
To:     Andrew Davis <afd@ti.com>
Cc:     Sumit Garg <sumit.garg@linaro.org>,
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

On Mon, Apr 25, 2022 at 4:16 PM Andrew Davis <afd@ti.com> wrote:
>
> We should not need to index into SHMs based on absolute VA/PA.
> These functions are not used and this kind of usage should not be
> encouraged anyway. Remove these functions.
>
> Signed-off-by: Andrew Davis <afd@ti.com>
> Reviewed-by: Sumit Garg <sumit.garg@linaro.org>
> ---
>  drivers/tee/tee_shm.c   | 50 -----------------------------------------
>  include/linux/tee_drv.h | 18 ---------------
>  2 files changed, 68 deletions(-)

Looks good to me, I'm picking up this.

Thanks,
Jens

>
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
