Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B21F047750F
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Dec 2021 15:55:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237994AbhLPOzQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Dec 2021 09:55:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49540 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235033AbhLPOzP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Dec 2021 09:55:15 -0500
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com [IPv6:2a00:1450:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CDCDFC061574
        for <linux-kernel@vger.kernel.org>; Thu, 16 Dec 2021 06:55:14 -0800 (PST)
Received: by mail-wm1-x330.google.com with SMTP id bg2-20020a05600c3c8200b0034565c2be15so1970808wmb.0
        for <linux-kernel@vger.kernel.org>; Thu, 16 Dec 2021 06:55:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=2sqpRMFqKvfIhqnVgfXPVnQPlhbx9/r4YTWeT9Fu6UE=;
        b=eHmf1oetGBA7piabJSrzj0oVZe9IR7wazTk3/adp3o2oY14QMmIiZH9neCH7mHmXz8
         v/fO8z/qLzZIntxVrOF6Qz3NJfEQ2a2pf7gTzkY1vhdt23FjcAK+y7E6pmrlp/ZkXIJS
         ISmzJPlbd1g5Pzg6ajpQX6FacwDBbcfU1iMj78sZpsv29rMHPSM8F/vyZ/AxQTI5p1BN
         1rcHAKpA7KyBv7uIkKO82I6Xb3kpoXj907NRd2XtD3rH5KKIypRsUH2ysB+TNHGO6dbW
         hkxDn6xePq0/cv6hEVECBpYu30jKXA5i13/V+E409csH3KvG10HFBDxkhuttkU23RXv0
         uigQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=2sqpRMFqKvfIhqnVgfXPVnQPlhbx9/r4YTWeT9Fu6UE=;
        b=nTfRgFHgXe03Y6CJBrL1TggWchs0GsRwtCe+zzf3KvfPu32HjWCpKwEF/Bqg8tHPeC
         vu6AIrZQ2irWpQw8LCzBHvJrGmrh5QZRTShJsvutqCVBgXAwtA7rI6qxo5+/1I/H2ksp
         BaSgu1CsIuH3fjESTXWQc1qMvDOIa0D6vpE+SnZKlnsC3m0pI5xFxQCMbrAnmThSzHSn
         /n5j8Pg6LHQ0NzoegyiCgHVcAp56tCZo4Ja3UiS20wM1F1K6SCiPPVzP1IaZQfu/dseM
         Mtn4X9kVO0IwK1U7ZR5qriLyu8Zk4yU6P7cUNhP6G0blGA8gDFapCtxR+Y1F9g62poBN
         R/Cw==
X-Gm-Message-State: AOAM531+ZvJ67p49jyz56op96kT801waw6E/A3vqb+QzFcwPcxkk1iV5
        c+G5kA63jdNbGP6/5LAlhtqHeSUEKDI+bsBnWfvY3A==
X-Google-Smtp-Source: ABdhPJwDfhZ4s85oymq7QDebqBOYyfLnIFcXM3hBq098nDb2K26Nn/cOlOnwBvOKsmRoxWW3gVteND3dvBahR6BIaoY=
X-Received: by 2002:a7b:c845:: with SMTP id c5mr5215055wml.177.1639666513389;
 Thu, 16 Dec 2021 06:55:13 -0800 (PST)
MIME-Version: 1.0
References: <20211206120533.602062-1-xiaolei.wang@windriver.com>
In-Reply-To: <20211206120533.602062-1-xiaolei.wang@windriver.com>
From:   Jens Wiklander <jens.wiklander@linaro.org>
Date:   Thu, 16 Dec 2021 15:55:02 +0100
Message-ID: <CAHUa44F7-cf74otao04vfZHZdN0kgaUqzFVd4iTJgZN9xfJC-g@mail.gmail.com>
Subject: Re: [PATCH] optee: Suppress false positive kmemleak report in optee_handle_rpc()
To:     Xiaolei Wang <Xiaolei.Wang@windriver.com>
Cc:     sumit.garg@linaro.org, op-tee@lists.trustedfirmware.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 6, 2021 at 1:05 PM Xiaolei Wang <xiaolei.wang@windriver.com> wrote:
>
> We observed the following kmemleak report:
> unreferenced object 0xffff000007904500 (size 128):
>   comm "swapper/0", pid 1, jiffies 4294892671 (age 44.036s)
>   hex dump (first 32 bytes):
>     00 47 90 07 00 00 ff ff 60 00 c0 ff 00 00 00 00  .G......`.......
>     60 00 80 13 00 80 ff ff a0 00 00 00 00 00 00 00  `...............
>   backtrace:
>     [<000000004c12b1c7>] kmem_cache_alloc+0x1ac/0x2f4
>     [<000000005d23eb4f>] tee_shm_alloc+0x78/0x230
>     [<00000000794dd22c>] optee_handle_rpc+0x60/0x6f0
>     [<00000000d9f7c52d>] optee_do_call_with_arg+0x17c/0x1dc
>     [<00000000c35884da>] optee_open_session+0x128/0x1ec
>     [<000000001748f2ff>] tee_client_open_session+0x28/0x40
>     [<00000000aecb5389>] optee_enumerate_devices+0x84/0x2a0
>     [<000000003df18bf1>] optee_probe+0x674/0x6cc
>     [<000000003a4a534a>] platform_drv_probe+0x54/0xb0
>     [<000000000c51ce7d>] really_probe+0xe4/0x4d0
>     [<000000002f04c865>] driver_probe_device+0x58/0xc0
>     [<00000000b485397d>] device_driver_attach+0xc0/0xd0
>     [<00000000c835f0df>] __driver_attach+0x84/0x124
>     [<000000008e5a429c>] bus_for_each_dev+0x70/0xc0
>     [<000000001735e8a8>] driver_attach+0x24/0x30
>     [<000000006d94b04f>] bus_add_driver+0x104/0x1ec
>
> This is not a memory leak because we pass the share memory pointer
> to secure world and would get it from secure world before releasing it.
>
> Signed-off-by: Xiaolei Wang <xiaolei.wang@windriver.com>
> ---
>  drivers/tee/optee/smc_abi.c | 2 ++
>  1 file changed, 2 insertions(+)

I'm picking up this.

Thanks,
Jens

>
> diff --git a/drivers/tee/optee/smc_abi.c b/drivers/tee/optee/smc_abi.c
> index 6196d7c3888f..cf2e3293567d 100644
> --- a/drivers/tee/optee/smc_abi.c
> +++ b/drivers/tee/optee/smc_abi.c
> @@ -23,6 +23,7 @@
>  #include "optee_private.h"
>  #include "optee_smc.h"
>  #include "optee_rpc_cmd.h"
> +#include <linux/kmemleak.h>
>  #define CREATE_TRACE_POINTS
>  #include "optee_trace.h"
>
> @@ -783,6 +784,7 @@ static void optee_handle_rpc(struct tee_context *ctx,
>                         param->a4 = 0;
>                         param->a5 = 0;
>                 }
> +               kmemleak_not_leak(shm);
>                 break;
>         case OPTEE_SMC_RPC_FUNC_FREE:
>                 shm = reg_pair_to_ptr(param->a1, param->a2);
> --
> 2.25.1
>
