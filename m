Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A8C544704ED
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Dec 2021 16:50:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235194AbhLJPx5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Dec 2021 10:53:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46202 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239791AbhLJPxf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Dec 2021 10:53:35 -0500
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com [IPv6:2a00:1450:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7FB3CC0698C8
        for <linux-kernel@vger.kernel.org>; Fri, 10 Dec 2021 07:49:19 -0800 (PST)
Received: by mail-wm1-x32a.google.com with SMTP id 137so7152049wma.1
        for <linux-kernel@vger.kernel.org>; Fri, 10 Dec 2021 07:49:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=m2XTc9iMBeQXABoVYg3OLHH7J0d8VZo7TwL0+hrpD3U=;
        b=RyKt8lg+/Hqq2hSK6Fl/AmA7Vch8WEeipWAYG84InWJGjcfe8zQH8hFZKwb63iFl9U
         4id7khNCuBkhOaw1wQLGilKpnDFCDyixLGOMzctduki3sYyMymdk2/lSp24T/7WS+gkk
         TwEl3SDhN6ECnQJUSXPdWEwiK2XzWwFcRhdTaU0hWAxCOw2YYZ9mnPnFa8ItNUSzxwvJ
         gSoxBx5/52vIxyMcVArRnG2v46bVDkxfnp1FaZs6xdLppFHaApFEA6+qV8R/nHHKn4+g
         gmQW+6764CE/uktQS0EX7KVvVmPN5//JoQKqMN8YpycjWC0kXTbDMpcxUdSn+f50GiyW
         ULaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=m2XTc9iMBeQXABoVYg3OLHH7J0d8VZo7TwL0+hrpD3U=;
        b=FUGXdL6WMTULwK/aTB4VUHHQ7tOzV8FeLo3N+rHo/TBZK/LWM68erwuXUt90d7UGEb
         EiMaLR6zlViOx2339nVo9j4Plqe2tPAQ6pLBLsyEXwRKyprcOXNrhhM3+qIk4eGFl/u+
         8HybJjOWX91eyL9hktO43WFF4WG9JxtJiKAUpSXXtThjzcOXDVIkQKt4oPmQAtLaaYNw
         lh+jubdGPOz67RYEAuPMZB4a2/rjOeQ6w5QlJCM4RFNO00f3Y4TxbhcOfnCDuKxE16Q8
         7PMqTM/6d7IBmTIaj3JY5QglIlS4meLgexvm3OUel3bLCGyo8qH0fBqH1P8WKuLxy3U2
         QUIg==
X-Gm-Message-State: AOAM533zv3bW/2msNXdgGi8RyuiTQkuzr0BA8uOf1hRIrB+15ThAJoLn
        47aTmQM03Fza8BI7HdUhPb9D1A==
X-Google-Smtp-Source: ABdhPJwygBkPQIVcmcc5vlSoy3fKPJHrWQJqWcwr45GwsC213r7T580wmwYyt5jdB128ItrmE67bCg==
X-Received: by 2002:a05:600c:3506:: with SMTP id h6mr17461416wmq.122.1639151357985;
        Fri, 10 Dec 2021 07:49:17 -0800 (PST)
Received: from maple.lan (cpc141216-aztw34-2-0-cust174.18-1.cable.virginm.net. [80.7.220.175])
        by smtp.gmail.com with ESMTPSA id p12sm2876675wro.33.2021.12.10.07.49.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Dec 2021 07:49:17 -0800 (PST)
Date:   Fri, 10 Dec 2021 15:49:15 +0000
From:   Daniel Thompson <daniel.thompson@linaro.org>
To:     Sumit Garg <sumit.garg@linaro.org>
Cc:     Jerome Forissier <jerome@forissier.org>,
        "Wang, Xiaolei" <xiaolei.wang@windriver.com>,
        "op-tee@lists.trustedfirmware.org" <op-tee@lists.trustedfirmware.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Jens Wiklander <jens.wiklander@linaro.org>,
        Etienne Carriere <etienne.carriere@linaro.org>
Subject: Re: [PATCH] optee: Suppress false positive kmemleak report in
 optee_handle_rpc()
Message-ID: <20211210154915.hjbgrnvtitmwluhz@maple.lan>
References: <20211206120533.602062-1-xiaolei.wang@windriver.com>
 <CAFA6WYN+0751=feb-O9Drmm5V_Gz-1qsgiHmLsA88=49MoK_dg@mail.gmail.com>
 <PH0PR11MB507734019F54C2BB24D1456F95719@PH0PR11MB5077.namprd11.prod.outlook.com>
 <CAFA6WYMOHUEve8cbZdwzsijer3fRsy=50q67ndsC6U2JD6gK5Q@mail.gmail.com>
 <ede44051-41db-60b4-d5a3-97a789dd52bc@forissier.org>
 <CAFA6WYM1oCs9gE4b5DaRez+jhCXPb_c25ausj0yWdS5tawX0MA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAFA6WYM1oCs9gE4b5DaRez+jhCXPb_c25ausj0yWdS5tawX0MA@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 10, 2021 at 03:08:21PM +0530, Sumit Garg wrote:
> On Fri, 10 Dec 2021 at 13:40, Jerome Forissier <jerome@forissier.org> wrote:
> >
> > +CC Jens, Etienne
> >
> > On 12/10/21 06:00, Sumit Garg wrote:
> > > On Fri, 10 Dec 2021 at 09:42, Wang, Xiaolei <Xiaolei.Wang@windriver.com> wrote:
> > >>
> > >> -----Original Message-----
> > >> From: Sumit Garg <sumit.garg@linaro.org>
> > >> Sent: Thursday, December 9, 2021 7:41 PM
> > >> To: Wang, Xiaolei <Xiaolei.Wang@windriver.com>
> > >> Cc: jens.wiklander@linaro.org; op-tee@lists.trustedfirmware.org; linux-kernel@vger.kernel.org
> > >> Subject: Re: [PATCH] optee: Suppress false positive kmemleak report in optee_handle_rpc()
> > >>
> > >> [Please note: This e-mail is from an EXTERNAL e-mail address]
> > >>
> > >> On Mon, 6 Dec 2021 at 17:35, Xiaolei Wang <xiaolei.wang@windriver.com> wrote:
> > >>>
> > >>> We observed the following kmemleak report:
> > >>> unreferenced object 0xffff000007904500 (size 128):
> > >>>   comm "swapper/0", pid 1, jiffies 4294892671 (age 44.036s)
> > >>>   hex dump (first 32 bytes):
> > >>>     00 47 90 07 00 00 ff ff 60 00 c0 ff 00 00 00 00  .G......`.......
> > >>>     60 00 80 13 00 80 ff ff a0 00 00 00 00 00 00 00  `...............
> > >>>   backtrace:
> > >>>     [<000000004c12b1c7>] kmem_cache_alloc+0x1ac/0x2f4
> > >>>     [<000000005d23eb4f>] tee_shm_alloc+0x78/0x230
> > >>>     [<00000000794dd22c>] optee_handle_rpc+0x60/0x6f0
> > >>>     [<00000000d9f7c52d>] optee_do_call_with_arg+0x17c/0x1dc
> > >>>     [<00000000c35884da>] optee_open_session+0x128/0x1ec
> > >>>     [<000000001748f2ff>] tee_client_open_session+0x28/0x40
> > >>>     [<00000000aecb5389>] optee_enumerate_devices+0x84/0x2a0
> > >>>     [<000000003df18bf1>] optee_probe+0x674/0x6cc
> > >>>     [<000000003a4a534a>] platform_drv_probe+0x54/0xb0
> > >>>     [<000000000c51ce7d>] really_probe+0xe4/0x4d0
> > >>>     [<000000002f04c865>] driver_probe_device+0x58/0xc0
> > >>>     [<00000000b485397d>] device_driver_attach+0xc0/0xd0
> > >>>     [<00000000c835f0df>] __driver_attach+0x84/0x124
> > >>>     [<000000008e5a429c>] bus_for_each_dev+0x70/0xc0
> > >>>     [<000000001735e8a8>] driver_attach+0x24/0x30
> > >>>     [<000000006d94b04f>] bus_add_driver+0x104/0x1ec
> > >>>
> > >>> This is not a memory leak because we pass the share memory pointer to
> > >>> secure world and would get it from secure world before releasing it.
> > >>
> > >>> How about if it's actually a memory leak caused by the secure world?
> > >>> An example being secure world just allocates kernel memory via OPTEE_SMC_RPC_FUNC_ALLOC and doesn't free it via OPTEE_SMC_RPC_FUNC_FREE.
> > >>
> > >>> IMO, we need to cross-check optee-os if it's responsible for leaking kernel memory.
> > >>
> > >> Hi sumit,
> > >>
> > >> You mean we need to check whether there is a real memleak,
> > >> If being secure world just allocate kernel memory via OPTEE_SMC_PRC_FUNC_ALLOC and until the end, there is no free
> > >> It via OPTEE_SMC_PRC_FUNC_FREE, then we should judge it as a memory leak, wo need to judge whether it is caused by secure os?
> > >
> > > Yes. AFAICT, optee-os should allocate shared memory to communicate
> > > with tee-supplicant. So once the communication is done, the underlying
> > > shared memory should be freed. I can't think of any scenario where
> > > optee-os should keep hold-off shared memory indefinitely.
> >
> > I believe it can happen when OP-TEE's CFG_PREALLOC_RPC_CACHE is y. See
> > the config file [1] and the commit which introduced this config [2].
> 
> Okay, I see the reasoning. So during the OP-TEE driver's lifetime, the
> RPC shared memory remains allocated. I guess that is done primarily
> for performance reasons.
> 
> But still it doesn't feel appropriate that we term all RPC shm
> allocations as not leaking memory as we might miss obvious ones.

IIUC this patch adds kmemleak_not_leak() at (pretty much) the last
possible point before *ownership* of the SHM block is passed from kernel
to OP-TEE.

Sure, after we change ownership it could still be leaked... but it can
no longer be leaked by the kernel because the kernel no longer owns it!
More importantly, it makes no sense to run the kernel memory detector on the
buffer because it simply can't work.

After the RPC completes, doesn't it become impossible for kmemleak to
scan to see if the pointer is lost[1]? kmemleak is essentially a tracing
garbage collector and needs to be able to scan all memory that could
hold a pointer to leakable memory. After the RPC completes the
only copy of the pointer will be stored in a memory region that the
kernel is prohibited from reading. How could kmemleak possibly give you
a useful answer in this circumstance?

In other words if there's nothing kmemleak could do to fix this
situation then marking the memory as kmemleak_not_leak() seems entirely
appropriate (although it should be prefaced with a big comment
explaining the change of ownerhship and why kmemleak cannot work).


Daniel.


[1] Everything I've said here hinges on this being true... so if I've
    made a mistake about where OP-TEE stores this pointer then most of
    the rest of this post is junk ;-)
