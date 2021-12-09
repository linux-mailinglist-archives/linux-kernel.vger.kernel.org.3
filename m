Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5BF8346E7B2
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Dec 2021 12:41:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235378AbhLILop (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Dec 2021 06:44:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51112 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231529AbhLILoo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Dec 2021 06:44:44 -0500
Received: from mail-lf1-x130.google.com (mail-lf1-x130.google.com [IPv6:2a00:1450:4864:20::130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A281C061746
        for <linux-kernel@vger.kernel.org>; Thu,  9 Dec 2021 03:41:11 -0800 (PST)
Received: by mail-lf1-x130.google.com with SMTP id u3so11501607lfl.2
        for <linux-kernel@vger.kernel.org>; Thu, 09 Dec 2021 03:41:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=I+Lx19UfV1nQLmVXADoGTttDZv7k9w+pxr5e5LnM9aU=;
        b=hQj1xtovpoQkcwIdhjBZnbrWbOtHTNEvOa9gWSqz/DKGuAhdwaUaUMRYOBkF1mlXz7
         kE1CCAttv2EAir2n3Sewge0OjFDptRzYebfDQKAl731IogmuQtuYIxfJXQu/UX1hs84X
         9aN8H+6jKdJkjVRVNtlp3bFVkmimemKKRwdjKb1T+K35jvk4ezPEc1/bHcTsdecN/vvs
         rpcO9S/fD3oJshvg3+vU3lWt5bVMktzQfIzOnEFDXDfbeRs+c+WGI6tkVNP6187b6cJb
         73N8Z9In35tjQPy5VLY7SL0dP3bZwFwipKi0tDtC9pmjXprDELDz/iIoDlbIM+r21kUg
         KKZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=I+Lx19UfV1nQLmVXADoGTttDZv7k9w+pxr5e5LnM9aU=;
        b=huXWH9npjF/q6sdTepaHgMDe0R0SSEI5UDb0ucJWBqIQBHHYM4CcKO1upyOKmjX6fb
         s5cu9bjLVK66dibnBZ430UA5HKhpFQqi0ioU5tLR3Uo8GuTtD+vXzbgoiHaG1SlpLofy
         BDjFrmFqUQMiio2zB/ZmbTl6YabDZjA/VSk91xJ8epRpog7X9GC12PQctTEq0Bhm1QrC
         oSmTYWUqzZV9WP36vIm6ooNIsqtbsHCLFjVhauduWC8SwAEmlyIPOS8R/tCAzD8NexZF
         YGjmHgQ2BF2MmBM+ilLPID2ZOOnnZTGraaC+yISGzYSkh/uNRFGuPgBPr3i0OqPUiu33
         5+PA==
X-Gm-Message-State: AOAM5310zpPiEXjQyv1Cy6sCtvXR508ZWYUY0m4JYj76K0yuy3GR/hz8
        jcyD6K3lH94woJQe6PUNdPHNspyAbFVGd1i/V11wkw==
X-Google-Smtp-Source: ABdhPJyi/fR8HjV9YPpeVuabrYRg21P89FvZ5ci6qPxkUAHY4uGWCH/bgAtfRS29LF4qTrDoHAYyvHdMrn+bdzQH1iY=
X-Received: by 2002:a05:6512:3d94:: with SMTP id k20mr5551976lfv.116.1639050069449;
 Thu, 09 Dec 2021 03:41:09 -0800 (PST)
MIME-Version: 1.0
References: <20211206120533.602062-1-xiaolei.wang@windriver.com>
In-Reply-To: <20211206120533.602062-1-xiaolei.wang@windriver.com>
From:   Sumit Garg <sumit.garg@linaro.org>
Date:   Thu, 9 Dec 2021 17:10:58 +0530
Message-ID: <CAFA6WYN+0751=feb-O9Drmm5V_Gz-1qsgiHmLsA88=49MoK_dg@mail.gmail.com>
Subject: Re: [PATCH] optee: Suppress false positive kmemleak report in optee_handle_rpc()
To:     Xiaolei Wang <xiaolei.wang@windriver.com>
Cc:     jens.wiklander@linaro.org, op-tee@lists.trustedfirmware.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 6 Dec 2021 at 17:35, Xiaolei Wang <xiaolei.wang@windriver.com> wrote:
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

How about if it's actually a memory leak caused by the secure world?
An example being secure world just allocates kernel memory via
OPTEE_SMC_RPC_FUNC_ALLOC and doesn't free it via
OPTEE_SMC_RPC_FUNC_FREE.

IMO, we need to cross-check optee-os if it's responsible for leaking
kernel memory.

-Sumit

>
> Signed-off-by: Xiaolei Wang <xiaolei.wang@windriver.com>
> ---
>  drivers/tee/optee/smc_abi.c | 2 ++
>  1 file changed, 2 insertions(+)
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
