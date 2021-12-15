Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D8D9A4758D8
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Dec 2021 13:29:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242495AbhLOM3T (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Dec 2021 07:29:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50854 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242428AbhLOM3Q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Dec 2021 07:29:16 -0500
Received: from mail-lj1-x232.google.com (mail-lj1-x232.google.com [IPv6:2a00:1450:4864:20::232])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD512C061574
        for <linux-kernel@vger.kernel.org>; Wed, 15 Dec 2021 04:29:15 -0800 (PST)
Received: by mail-lj1-x232.google.com with SMTP id i63so33070686lji.3
        for <linux-kernel@vger.kernel.org>; Wed, 15 Dec 2021 04:29:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=KOFNxj4d6DPgHzGuI/lzQfNt0ljyQXZwY55SvrPrCIc=;
        b=FB6HonqLA5Jrkpo+Rlcgo0d8HkaZYDHwDx2uezf+kRgLI/KtMmfS9jGreasi6dceYF
         KMfKG8Dap6HvowaUH5jZJxbNpTuhEb/36FL7+iYcop0KTkgTdVXNDu0DEBvnnjMLFB+6
         HqldeCGhbmmukma2v8ek81xgeskovrLxyaMko+w9Dy816lJoZgpKuYCwAmKrMRtL6Zmo
         sZ0nCs0Yzqz9w3hvCYItQI0kxVyEI3ITuJE63aaTqFV+HPYi8TkMCpXqcbKoM++Ut9X9
         rEIjD++qFcx+C6kKzSFhO2qLYxafKUchabyKsYo+R0SlEO0qR1HXNXL3j8K0bYJt2T2A
         soEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=KOFNxj4d6DPgHzGuI/lzQfNt0ljyQXZwY55SvrPrCIc=;
        b=1fK+3VAgq3dS9NJ3ACwlnmTXgkO+qAvrh8J5UUGeT/Hk64Y0e8TIo0z7KfyCsLackd
         zrnrIbZlpYgbZrxYdVJOpcRycv9boi8e+Uo+dN+fOd3NLkTTmum7Fo+S2uw/4OW3C+vO
         sKySC4EwaS54gcaAN25ihasrQXVVtUVyA7gRXrX25kx7U+YAopeVXLNfBO+ai/ZwmlVI
         YkN+QoCIfZuT5Noh2/qxd+bL64JYNJI94ECcBs7eKad5hvGSP3O21FVWYZD0v9x6fJFm
         PHAyVFoaURFwfTdVDcNdzUaxQQDcCKrmF6xYPLv+5Ttkk4MJmin0rrtGqgs/SmE/OfmI
         vmOQ==
X-Gm-Message-State: AOAM5301/EL0tdDe8JU0vKmRRdCL3KJOyLPe6wiaDwG5UN+tfQf0As4j
        il/HjwxesheFwQESH8RzahvSnEhWtFSfRNoO
X-Google-Smtp-Source: ABdhPJwO0jDxGTid1g6p/Ut+pwnbAR7etDQj354AYa5RLduVthCQSkZ7UQU3E1EQq9ucsxaDrwZfZg==
X-Received: by 2002:a2e:6e15:: with SMTP id j21mr10100738ljc.195.1639571354146;
        Wed, 15 Dec 2021 04:29:14 -0800 (PST)
Received: from jade (h-94-254-48-165.A175.priv.bahnhof.se. [94.254.48.165])
        by smtp.gmail.com with ESMTPSA id g14sm299228lfv.138.2021.12.15.04.29.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Dec 2021 04:29:13 -0800 (PST)
Date:   Wed, 15 Dec 2021 13:29:12 +0100
From:   Jens Wiklander <jens.wiklander@linaro.org>
To:     Xiaolei Wang <xiaolei.wang@windriver.com>
Cc:     sumit.garg@linaro.org, op-tee@lists.trustedfirmware.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] optee: Suppress false positive kmemleak report in
 optee_handle_rpc()
Message-ID: <20211215122912.GA1874103@jade>
References: <20211206120533.602062-1-xiaolei.wang@windriver.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20211206120533.602062-1-xiaolei.wang@windriver.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 06, 2021 at 08:05:33PM +0800, Xiaolei Wang wrote:
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
>  			param->a4 = 0;
>  			param->a5 = 0;
>  		}
> +		kmemleak_not_leak(shm);

Eventually this pointer will be freed below with the call to tee_shm_free().
I assume than once the memory is freed it's not execused from being a leak
any longer. Is that correct?

Thanks,
Jens

>  		break;
>  	case OPTEE_SMC_RPC_FUNC_FREE:
>  		shm = reg_pair_to_ptr(param->a1, param->a2);
> -- 
> 2.25.1
> 
