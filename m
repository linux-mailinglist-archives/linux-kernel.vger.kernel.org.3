Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 23BCA5A7B9D
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Aug 2022 12:46:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229976AbiHaKqZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 Aug 2022 06:46:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41468 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229607AbiHaKqY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Aug 2022 06:46:24 -0400
Received: from mail-lf1-x132.google.com (mail-lf1-x132.google.com [IPv6:2a00:1450:4864:20::132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA1F0C7F84
        for <linux-kernel@vger.kernel.org>; Wed, 31 Aug 2022 03:46:22 -0700 (PDT)
Received: by mail-lf1-x132.google.com with SMTP id z29so10779807lfb.13
        for <linux-kernel@vger.kernel.org>; Wed, 31 Aug 2022 03:46:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc;
        bh=w7LRoVcd9BLwWbUBCGZiiEDMoNflqnBENh2m6L91/iw=;
        b=dVGV7u7T5VilLehTAFMbXWUy00y2JBJH0myB0WeUV66VShZMq4LTXsQAilglVayiRQ
         7/WrsaGsovbhL+Yus5kvm4JuMhmlf4pN6WV7VyJtGZw/rUrQN+TyTvdMVoZ+NOsNBX5g
         tRzreOGLBWrPTPI8+YcbMNFx1IlqP7kfT2fzExSWoRdg/0Z1N8T1zutf6Vk5ETkmQdqP
         Y9Mg+DmQG/vmntyH5DC68torDWKHUhomGmT/iEEnNjBzzdfk5iK7Y16rOHD11WJThML5
         cmdsmronTZ2m6ncHin+xgy1PGD/Ey0HmkKHu7wTorjJm4madmVwaUPa7QIk5EHnx9Afv
         HrvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=w7LRoVcd9BLwWbUBCGZiiEDMoNflqnBENh2m6L91/iw=;
        b=nYh/RncEkub6o+g+jxPVS63h4pt3zijzr4ZCsQLT2mRBSettayRpiVVyJ7hZ23YD5A
         8hlxiMAww5XCL2QaPKtx6I9jdeyaJI1DryQxN2ApK8++oMJqm+g3fp/QAkCbIqFa9Qf6
         By6STJcpVNbGAcoC+gFakexXRSqVlvSZjSK8XQQpjqef4g3PTXXGGij07BWG37JrtSvr
         NzRrD4PoZdJNLtSbcyh7eNJcS7DviY5l8uRlaXemmpI8Mp/Vm59ehNPaO8DYXFyNRFR9
         27T4rMvPD31x4qGpXudRgXycu6p8hEN9TAmJLbMqI/g0xlK8Egn3Fx4enmgGHpzCtXtm
         x5pA==
X-Gm-Message-State: ACgBeo3HdWM5qTBcveRwaGcGFdRvrPXfasqJXXzzEt7/vR6lzZc6L02h
        tFVvcbMnSUP82tS58ykN4zwoCxNeMFL33enXAiNGzg==
X-Google-Smtp-Source: AA6agR5yO7HRkS85a5YlDDM4S3UTg0C3dtBDpp6XCxnXZrKR5zqZ387xWMwl9MFmbAXvpE5aRu5Q9lPhsda/KMMbJto=
X-Received: by 2002:ac2:4901:0:b0:494:88dc:7efc with SMTP id
 n1-20020ac24901000000b0049488dc7efcmr986101lfi.408.1661942780284; Wed, 31 Aug
 2022 03:46:20 -0700 (PDT)
MIME-Version: 1.0
References: <20220830100700.344594-1-sudeep.holla@arm.com> <20220830100700.344594-7-sudeep.holla@arm.com>
In-Reply-To: <20220830100700.344594-7-sudeep.holla@arm.com>
From:   Sumit Garg <sumit.garg@linaro.org>
Date:   Wed, 31 Aug 2022 16:16:09 +0530
Message-ID: <CAFA6WYOcHGRwkt6PKFEm9did=hO-e1eukK_1M-NWT=79jMS9WQ@mail.gmail.com>
Subject: Re: [PATCH 6/9] firmware: arm_ffa: Make memory apis ffa_device independent
To:     Sudeep Holla <sudeep.holla@arm.com>
Cc:     linux-kernel@vger.kernel.org, op-tee@lists.trustedfirmware.org,
        Marc Bonnici <marc.bonnici@arm.com>,
        Valentin Laurent <valentin.laurent@trustonic.com>,
        Lukas Hanel <lukas.hanel@trustonic.com>,
        Coboy Chen <coboy.chen@mediatek.com>
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

Hi Sudeep,

On Tue, 30 Aug 2022 at 15:39, Sudeep Holla <sudeep.holla@arm.com> wrote:
>
> There is a requirement to make memory APIs independent of the ffa_device.
> One of the use-case is to have a common memory driver that manages the
> memory for all the ffa_devices. That commom memory driver won't be a

s/commom/common/

> ffa_driver or won't have any ffa_device associated with it. So having
> these memory APIs accessible without a ffa_device is needed and should
> be possible as most of these are handled by the partition manager(SPM
> or hypervisor).
>
> Drop the ffa_device argument to the memory APIs and make them ffa_device
> independent.
>
> Signed-off-by: Sudeep Holla <sudeep.holla@arm.com>
> ---
>  drivers/firmware/arm_ffa/driver.c | 6 ++----
>  drivers/tee/optee/ffa_abi.c       | 2 +-
>  include/linux/arm_ffa.h           | 6 ++----
>  3 files changed, 5 insertions(+), 9 deletions(-)
>
> diff --git a/drivers/firmware/arm_ffa/driver.c b/drivers/firmware/arm_ffa/driver.c
> index 5f02b670e964..5c8484b05c50 100644
> --- a/drivers/firmware/arm_ffa/driver.c
> +++ b/drivers/firmware/arm_ffa/driver.c
> @@ -640,8 +640,7 @@ static int ffa_sync_send_receive(struct ffa_device *dev,
>                                        dev->mode_32bit, data);
>  }
>
> -static int
> -ffa_memory_share(struct ffa_device *dev, struct ffa_mem_ops_args *args)
> +static int ffa_memory_share(struct ffa_mem_ops_args *args)
>  {
>         if (drv_info->mem_ops_native)
>                 return ffa_memory_ops(FFA_FN_NATIVE(MEM_SHARE), args);
> @@ -649,8 +648,7 @@ ffa_memory_share(struct ffa_device *dev, struct ffa_mem_ops_args *args)
>         return ffa_memory_ops(FFA_MEM_SHARE, args);
>  }
>
> -static int
> -ffa_memory_lend(struct ffa_device *dev, struct ffa_mem_ops_args *args)
> +static int ffa_memory_lend(struct ffa_mem_ops_args *args)
>  {
>         /* Note that upon a successful MEM_LEND request the caller
>          * must ensure that the memory region specified is not accessed
> diff --git a/drivers/tee/optee/ffa_abi.c b/drivers/tee/optee/ffa_abi.c
> index 4c3b5d0008dd..7ec0a2f9a63b 100644
> --- a/drivers/tee/optee/ffa_abi.c
> +++ b/drivers/tee/optee/ffa_abi.c
> @@ -294,7 +294,7 @@ static int optee_ffa_shm_register(struct tee_context *ctx, struct tee_shm *shm,
>         if (rc)
>                 return rc;
>         args.sg = sgt.sgl;
> -       rc = ffa_ops->memory_share(ffa_dev, &args);
> +       rc = ffa_ops->memory_share(&args);
>         sg_free_table(&sgt);
>         if (rc)
>                 return rc;
> diff --git a/include/linux/arm_ffa.h b/include/linux/arm_ffa.h
> index 556f50f27fb1..eafab07c9f58 100644
> --- a/include/linux/arm_ffa.h
> +++ b/include/linux/arm_ffa.h
> @@ -262,10 +262,8 @@ struct ffa_dev_ops {
>         int (*sync_send_receive)(struct ffa_device *dev,
>                                  struct ffa_send_direct_data *data);
>         int (*memory_reclaim)(u64 g_handle, u32 flags);
> -       int (*memory_share)(struct ffa_device *dev,
> -                           struct ffa_mem_ops_args *args);
> -       int (*memory_lend)(struct ffa_device *dev,
> -                          struct ffa_mem_ops_args *args);
> +       int (*memory_share)(struct ffa_mem_ops_args *args);
> +       int (*memory_lend)(struct ffa_mem_ops_args *args);
>  };
>

Since these are included under "struct ffa_dev_ops", wouldn't it be
better to rename the struct (ffa_ops?) as well?

-Sumit

>  #endif /* _LINUX_ARM_FFA_H */
> --
> 2.37.2
>
