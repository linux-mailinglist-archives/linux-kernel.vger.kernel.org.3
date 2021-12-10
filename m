Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 87BE346FA0D
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Dec 2021 06:10:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229619AbhLJFEW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Dec 2021 00:04:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38476 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229484AbhLJFEV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Dec 2021 00:04:21 -0500
Received: from mail-lf1-x130.google.com (mail-lf1-x130.google.com [IPv6:2a00:1450:4864:20::130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E0B33C061746
        for <linux-kernel@vger.kernel.org>; Thu,  9 Dec 2021 21:00:46 -0800 (PST)
Received: by mail-lf1-x130.google.com with SMTP id bu18so16105714lfb.0
        for <linux-kernel@vger.kernel.org>; Thu, 09 Dec 2021 21:00:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=IXcnqvUPmhjyxQPjlS/e44G9xrXjxY9m4geaMKqAj4E=;
        b=YfrluK/RDoNT8nxrnKCFTZmt5aNZ38B8Sak6WJ2C1wUPv0d5cmR9te+rYRQ3GzNr3R
         ycWOjjsTP7nRxrgaJ5XDQmvV0n8AeTd10EFNu2h22i0mnh7i0kST/WGwtumQAJ5W5N18
         Ao8d+LIyXGqSQsBtgZtXukRqEaz0cJ29WljPz/1TP+Q21BJ9W8+Ygdm919uPLKliH88G
         gbk2EW3Pb3oFkdVgWw44A9YWJZpOwuYPgZ0rbwJxJ9i/Tj1ArgiRFTW8UBQdxAl9sQX1
         2Ajph24K+yHx2MreXyGnUfCAMIw05RuCHtakweWplXcnxOBApMm3m5+F4kYiwZvUKFbv
         MT5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=IXcnqvUPmhjyxQPjlS/e44G9xrXjxY9m4geaMKqAj4E=;
        b=QkKgW8JeV3txzuLS2I4TrIaeG5W0em4si45AlpUhmAIr+0KszfBt7ejjQLxczWcvt/
         OV0BtsqECQ285Av0wGQuyb3SrCOv/8OuAY3sfGehw1TyL8TwRlQv4G9ahCAUZIVQQWTf
         9TIDs4nhxtuw4wGPlku8P78Xz/7DZPiZx6l0CSJs3dIeozmas2PVZArilt1sA382ebSN
         A5ZzwEb4TLyOqLgGc8+wjnjnigu/mFDmagmZF8CyBJt1K0wlR/IXq5miaVbyrcquHpUY
         GCdx2Qm+ar9WfXdldk3W2g6QBnhLuuRoL7X2eAPva+X3pgKdaPKG+kNCTLW62q8z8ZjN
         et8A==
X-Gm-Message-State: AOAM533/kPAgbvCdskm4p/FDeI8Sb8hl1xiqnuEj3yKvpXfy86qzL8gY
        saKFMLFO7YgW7JjHG2IhWzz95CHbO1QyAjKev5h5OA==
X-Google-Smtp-Source: ABdhPJybAaPRn+oPwV/J5R6C1hTqljCV4hLdhzIyVHuPIadMp7iGDIf844Hktmwbw1/82thuiOjXQuxQVW4heTjIfqw=
X-Received: by 2002:a05:6512:1192:: with SMTP id g18mr10298936lfr.40.1639112444956;
 Thu, 09 Dec 2021 21:00:44 -0800 (PST)
MIME-Version: 1.0
References: <20211206120533.602062-1-xiaolei.wang@windriver.com>
 <CAFA6WYN+0751=feb-O9Drmm5V_Gz-1qsgiHmLsA88=49MoK_dg@mail.gmail.com> <PH0PR11MB507734019F54C2BB24D1456F95719@PH0PR11MB5077.namprd11.prod.outlook.com>
In-Reply-To: <PH0PR11MB507734019F54C2BB24D1456F95719@PH0PR11MB5077.namprd11.prod.outlook.com>
From:   Sumit Garg <sumit.garg@linaro.org>
Date:   Fri, 10 Dec 2021 10:30:33 +0530
Message-ID: <CAFA6WYMOHUEve8cbZdwzsijer3fRsy=50q67ndsC6U2JD6gK5Q@mail.gmail.com>
Subject: Re: [PATCH] optee: Suppress false positive kmemleak report in optee_handle_rpc()
To:     "Wang, Xiaolei" <xiaolei.wang@windriver.com>
Cc:     "jens.wiklander@linaro.org" <jens.wiklander@linaro.org>,
        "op-tee@lists.trustedfirmware.org" <op-tee@lists.trustedfirmware.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 10 Dec 2021 at 09:42, Wang, Xiaolei <Xiaolei.Wang@windriver.com> wrote:
>
>
>
> -----Original Message-----
> From: Sumit Garg <sumit.garg@linaro.org>
> Sent: Thursday, December 9, 2021 7:41 PM
> To: Wang, Xiaolei <Xiaolei.Wang@windriver.com>
> Cc: jens.wiklander@linaro.org; op-tee@lists.trustedfirmware.org; linux-kernel@vger.kernel.org
> Subject: Re: [PATCH] optee: Suppress false positive kmemleak report in optee_handle_rpc()
>
> [Please note: This e-mail is from an EXTERNAL e-mail address]
>
> On Mon, 6 Dec 2021 at 17:35, Xiaolei Wang <xiaolei.wang@windriver.com> wrote:
> >
> > We observed the following kmemleak report:
> > unreferenced object 0xffff000007904500 (size 128):
> >   comm "swapper/0", pid 1, jiffies 4294892671 (age 44.036s)
> >   hex dump (first 32 bytes):
> >     00 47 90 07 00 00 ff ff 60 00 c0 ff 00 00 00 00  .G......`.......
> >     60 00 80 13 00 80 ff ff a0 00 00 00 00 00 00 00  `...............
> >   backtrace:
> >     [<000000004c12b1c7>] kmem_cache_alloc+0x1ac/0x2f4
> >     [<000000005d23eb4f>] tee_shm_alloc+0x78/0x230
> >     [<00000000794dd22c>] optee_handle_rpc+0x60/0x6f0
> >     [<00000000d9f7c52d>] optee_do_call_with_arg+0x17c/0x1dc
> >     [<00000000c35884da>] optee_open_session+0x128/0x1ec
> >     [<000000001748f2ff>] tee_client_open_session+0x28/0x40
> >     [<00000000aecb5389>] optee_enumerate_devices+0x84/0x2a0
> >     [<000000003df18bf1>] optee_probe+0x674/0x6cc
> >     [<000000003a4a534a>] platform_drv_probe+0x54/0xb0
> >     [<000000000c51ce7d>] really_probe+0xe4/0x4d0
> >     [<000000002f04c865>] driver_probe_device+0x58/0xc0
> >     [<00000000b485397d>] device_driver_attach+0xc0/0xd0
> >     [<00000000c835f0df>] __driver_attach+0x84/0x124
> >     [<000000008e5a429c>] bus_for_each_dev+0x70/0xc0
> >     [<000000001735e8a8>] driver_attach+0x24/0x30
> >     [<000000006d94b04f>] bus_add_driver+0x104/0x1ec
> >
> > This is not a memory leak because we pass the share memory pointer to
> > secure world and would get it from secure world before releasing it.
>
> > How about if it's actually a memory leak caused by the secure world?
> > An example being secure world just allocates kernel memory via OPTEE_SMC_RPC_FUNC_ALLOC and doesn't free it via OPTEE_SMC_RPC_FUNC_FREE.
>
> > IMO, we need to cross-check optee-os if it's responsible for leaking kernel memory.
>
> Hi sumit,
>
> You mean we need to check whether there is a real memleak,
> If being secure world just allocate kernel memory via OPTEE_SMC_PRC_FUNC_ALLOC and until the end, there is no free
> It via OPTEE_SMC_PRC_FUNC_FREE, then we should judge it as a memory leak, wo need to judge whether it is caused by secure os?

Yes. AFAICT, optee-os should allocate shared memory to communicate
with tee-supplicant. So once the communication is done, the underlying
shared memory should be freed. I can't think of any scenario where
optee-os should keep hold-off shared memory indefinitely.

-Sumit

>
> Thanks
> Xiaolei
>
>
> > -Sumit
>
> >
> > Signed-off-by: Xiaolei Wang <xiaolei.wang@windriver.com>
> > ---
> >  drivers/tee/optee/smc_abi.c | 2 ++
> >  1 file changed, 2 insertions(+)
> >
> > diff --git a/drivers/tee/optee/smc_abi.c b/drivers/tee/optee/smc_abi.c
> > index 6196d7c3888f..cf2e3293567d 100644
> > --- a/drivers/tee/optee/smc_abi.c
> > +++ b/drivers/tee/optee/smc_abi.c
> > @@ -23,6 +23,7 @@
> >  #include "optee_private.h"
> >  #include "optee_smc.h"
> >  #include "optee_rpc_cmd.h"
> > +#include <linux/kmemleak.h>
> >  #define CREATE_TRACE_POINTS
> >  #include "optee_trace.h"
> >
> > @@ -783,6 +784,7 @@ static void optee_handle_rpc(struct tee_context *ctx,
> >                         param->a4 = 0;
> >                         param->a5 = 0;
> >                 }
> > +               kmemleak_not_leak(shm);
> >                 break;
> >         case OPTEE_SMC_RPC_FUNC_FREE:
> >                 shm = reg_pair_to_ptr(param->a1, param->a2);
> > --
> > 2.25.1
> >
