Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 907BA5AFEF8
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Sep 2022 10:28:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229862AbiIGI2h (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Sep 2022 04:28:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41138 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229766AbiIGI2N (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Sep 2022 04:28:13 -0400
Received: from mail-pg1-x52d.google.com (mail-pg1-x52d.google.com [IPv6:2607:f8b0:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 11A09A2A9A
        for <linux-kernel@vger.kernel.org>; Wed,  7 Sep 2022 01:28:09 -0700 (PDT)
Received: by mail-pg1-x52d.google.com with SMTP id q63so12896097pga.9
        for <linux-kernel@vger.kernel.org>; Wed, 07 Sep 2022 01:28:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date;
        bh=ZK2dN3LfGXshc0BSf1V+sKRVkilA0uQCpqG7quWKluc=;
        b=dO5kowaB5tVe7m0B1nuzMJ9vwwvV7RB9uFcxpmDp6TPBVoWDs2Uk7FpdvoLo0BMx4P
         c5KmdPSf7AAMWQIe55Udy2KD4sq9PuBkGNb2n9v+JObXBzUUTKfzEXQ8QvscsW+hYGKR
         niyfp6hdWHTn6nhoyfR3RmIXjmHZmKxy9Qqrq1fNiISWBRiWWFqu9nAInIU82qeIZCBE
         8b9ni9a2vIlp09E69bK7AjAvslTc7Rwfe3VcwpC2/qPVs6mhslxPhUPnYsfCYmjok8mB
         fQ4vxR5bwju2STu/CiVQ4fkeS9v2EIxRfg0W4cJDrO3/tPvMm5TZJiROqhekfvqHiI8p
         yweA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=ZK2dN3LfGXshc0BSf1V+sKRVkilA0uQCpqG7quWKluc=;
        b=cepfiSw2oS+e+hY51tSYX1bmzxyqncAxvhJH1Yr4CsD4ksOt/4kEO0PZfKBlQCi54b
         OxAq3xcn0MZ3yberxDGUobd8o2SSZNqYXwMsZ0QXWzY6Pe/MIbxMZMeDySorvmc5q5eT
         b6QfPdy0Rb9Up8DoLym7jQLp6sfcgr8ReosgQckCRU+Dp7K5OYT27C+/OkTHYyRI0Tf0
         jwYq97bwf5ndCiZ3h7IqRPAVfY5Agi5kyQxIGN1Q6Kr0R4T/nQJXvV/OXmt/mDL1+R/0
         +rejxR/3XQJhNndtnEbYm6qthAHyNxQpDHRvL3iWLv2p5lFZGyb/D1fKjCIlhB2Uh50U
         jB1Q==
X-Gm-Message-State: ACgBeo3VcPtxQKuo8/MWAYBDnbyu3x3Y60W8fpQBkJhjUmB8rENismBp
        Rd+ihMWFwPytAN5BwfGiZS+BgYrrJEAaQaepD1PMCg==
X-Google-Smtp-Source: AA6agR5F8M9xMjW6D4KPSktQY18htc1FBcG24l83DGqipr4u9uBgwtsjdLP1ERZ1m3nuSMwXWgvrApf8EP7t7Juaw10=
X-Received: by 2002:a63:1a23:0:b0:434:4395:8b5a with SMTP id
 a35-20020a631a23000000b0043443958b5amr2359400pga.428.1662539288843; Wed, 07
 Sep 2022 01:28:08 -0700 (PDT)
MIME-Version: 1.0
References: <20220902124032.788488-1-sudeep.holla@arm.com> <20220902124032.788488-7-sudeep.holla@arm.com>
In-Reply-To: <20220902124032.788488-7-sudeep.holla@arm.com>
From:   Jens Wiklander <jens.wiklander@linaro.org>
Date:   Wed, 7 Sep 2022 10:27:57 +0200
Message-ID: <CAHUa44FJtwidcxmPqZ3Fttq4J3QrFxvQh-o=0LnfGRBnFGfk4w@mail.gmail.com>
Subject: Re: [PATCH v2 06/10] firmware: arm_ffa: Make memory apis ffa_device independent
To:     Sudeep Holla <sudeep.holla@arm.com>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        op-tee@lists.trustedfirmware.org,
        Marc Bonnici <marc.bonnici@arm.com>,
        Achin Gupta <achin.gupta@arm.com>,
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

On Fri, Sep 2, 2022 at 2:40 PM Sudeep Holla <sudeep.holla@arm.com> wrote:
>
> There is a requirement to make memory APIs independent of the ffa_device.
> One of the use-case is to have a common memory driver that manages the
> memory for all the ffa_devices. That common memory driver won't be a
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

Acked-by: Jens Wiklander <jens.wiklander@linaro.org>

>
> diff --git a/drivers/firmware/arm_ffa/driver.c b/drivers/firmware/arm_ffa/driver.c
> index 37a8ee304508..e4fd35773071 100644
> --- a/drivers/firmware/arm_ffa/driver.c
> +++ b/drivers/firmware/arm_ffa/driver.c
> @@ -643,8 +643,7 @@ static int ffa_sync_send_receive(struct ffa_device *dev,
>                                        dev->mode_32bit, data);
>  }
>
> -static int
> -ffa_memory_share(struct ffa_device *dev, struct ffa_mem_ops_args *args)
> +static int ffa_memory_share(struct ffa_mem_ops_args *args)
>  {
>         if (drv_info->mem_ops_native)
>                 return ffa_memory_ops(FFA_FN_NATIVE(MEM_SHARE), args);
> @@ -652,8 +651,7 @@ ffa_memory_share(struct ffa_device *dev, struct ffa_mem_ops_args *args)
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
> index 3d4079575ccd..7257b42d0545 100644
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
>  #endif /* _LINUX_ARM_FFA_H */
> --
> 2.37.3
>
