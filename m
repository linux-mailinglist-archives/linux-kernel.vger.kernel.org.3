Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 651E047236F
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Dec 2021 10:04:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233534AbhLMJE2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Dec 2021 04:04:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47310 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229725AbhLMJE1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Dec 2021 04:04:27 -0500
Received: from mail-lj1-x22e.google.com (mail-lj1-x22e.google.com [IPv6:2a00:1450:4864:20::22e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8315BC06173F
        for <linux-kernel@vger.kernel.org>; Mon, 13 Dec 2021 01:04:26 -0800 (PST)
Received: by mail-lj1-x22e.google.com with SMTP id k2so22679080lji.4
        for <linux-kernel@vger.kernel.org>; Mon, 13 Dec 2021 01:04:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=896cuHELLHcKosn+kwKi7ZRAJPiWeNfrXN6jd7Y4Mns=;
        b=N6hVwEFFUPxqJ4nHR8daLo+4DwO91y/DDSHoe535lmyEx60PRwGXObH1Lsy4O5YNGg
         5iXrgskWIJ6/a0PEfyMVm/w8UtyIZ/99YOnvgLdQyif2K2/y38QkLfJ+6F6UsZ8tl99w
         WSn1zIiF2Vf0eQxrc16w2MgOveVPcyhS3hJKy4xXgTM308N42kY8G5YxEiNdJFJew0wf
         wijhOYzturiZeyDBQQtGrvIQF3HTW1JbzHBm+ltTe7D8+b4gAut9OsXdIvgPeCp3aS6Y
         NGe5kSRIcD2O5hO3di9g5a1XtLrEyqp9j/ZIf2zBCMbkvfAmE/hxDd0bx6cDCWmzuAij
         Lsvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=896cuHELLHcKosn+kwKi7ZRAJPiWeNfrXN6jd7Y4Mns=;
        b=HPt09sr8E81st98OD1vK22bC5CkDr+1nSxT2C2E7kdqmaMVsSPWeoPzUutS7UC7Jm+
         tNS1lbEyFcSeLbnLgSuuR31ZMOY5CdNedfb1A/wfxzXce59kmqRbdGrfmFTH7eacgrSk
         PKWQkv8DIQ33Pejswn8Lb46KO0h/K9sfj41V6idcIz5J3pU+egzYSjDWMQHzdTqWFChm
         D6qkitBCG1/Oh6BPhzF2/Wj1sudGjnf9j6nt5i4UrlYThJaWkTmmtVYFh8JvJcxA5pwC
         WoDgAu+CVvyiQPuuiowczekYn1HqyQKz+WpiodraApdLFxdyUiQN6RWu+zdFRy2xhEhU
         0MnA==
X-Gm-Message-State: AOAM532Ssf+aR3DKcoF+eUDxhkzHzMZQiJFAG0WQxOPuuOfc87SWFO/l
        /KL9prpLmEqOIRb424uz29lYNjBUdMbO8u4nPEEzCQ==
X-Google-Smtp-Source: ABdhPJwRzk+9q6ZOI5BsPwSGxtZq3zAN+P4XTHhIgV09JC0m2V5arYDhdQYjFgrIeYTqd/7uSSMz5t6r4sDdnYYX//0=
X-Received: by 2002:a2e:a54e:: with SMTP id e14mr29247881ljn.136.1639386264639;
 Mon, 13 Dec 2021 01:04:24 -0800 (PST)
MIME-Version: 1.0
References: <20211206120533.602062-1-xiaolei.wang@windriver.com>
 <CAFA6WYN+0751=feb-O9Drmm5V_Gz-1qsgiHmLsA88=49MoK_dg@mail.gmail.com>
 <PH0PR11MB507734019F54C2BB24D1456F95719@PH0PR11MB5077.namprd11.prod.outlook.com>
 <CAFA6WYMOHUEve8cbZdwzsijer3fRsy=50q67ndsC6U2JD6gK5Q@mail.gmail.com>
 <ede44051-41db-60b4-d5a3-97a789dd52bc@forissier.org> <CAFA6WYM1oCs9gE4b5DaRez+jhCXPb_c25ausj0yWdS5tawX0MA@mail.gmail.com>
 <2c9f2f34-9dab-4f1b-bc10-48212fb70335@windriver.com>
In-Reply-To: <2c9f2f34-9dab-4f1b-bc10-48212fb70335@windriver.com>
From:   Sumit Garg <sumit.garg@linaro.org>
Date:   Mon, 13 Dec 2021 14:34:13 +0530
Message-ID: <CAFA6WYPfjGqY6GJqLmrhU7CBjBTEYZzuCptHLJe2aEGUM_kOBA@mail.gmail.com>
Subject: Re: [PATCH] optee: Suppress false positive kmemleak report in optee_handle_rpc()
To:     wangxiaolei <xiaolei.wang@windriver.com>
Cc:     Jerome Forissier <jerome@forissier.org>,
        "op-tee@lists.trustedfirmware.org" <op-tee@lists.trustedfirmware.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Jens Wiklander <jens.wiklander@linaro.org>,
        Etienne Carriere <etienne.carriere@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 13 Dec 2021 at 14:25, wangxiaolei <xiaolei.wang@windriver.com> wrote:
>
>
> On 12/10/21 5:38 PM, Sumit Garg wrote:
> > [Please note: This e-mail is from an EXTERNAL e-mail address]
> >
> > On Fri, 10 Dec 2021 at 13:40, Jerome Forissier <jerome@forissier.org> wrote:
> >> +CC Jens, Etienne
> >>
> >> On 12/10/21 06:00, Sumit Garg wrote:
> >>> On Fri, 10 Dec 2021 at 09:42, Wang, Xiaolei <Xiaolei.Wang@windriver.com> wrote:
> >>>> -----Original Message-----
> >>>> From: Sumit Garg <sumit.garg@linaro.org>
> >>>> Sent: Thursday, December 9, 2021 7:41 PM
> >>>> To: Wang, Xiaolei <Xiaolei.Wang@windriver.com>
> >>>> Cc: jens.wiklander@linaro.org; op-tee@lists.trustedfirmware.org; linux-kernel@vger.kernel.org
> >>>> Subject: Re: [PATCH] optee: Suppress false positive kmemleak report in optee_handle_rpc()
> >>>>
> >>>> [Please note: This e-mail is from an EXTERNAL e-mail address]
> >>>>
> >>>> On Mon, 6 Dec 2021 at 17:35, Xiaolei Wang <xiaolei.wang@windriver.com> wrote:
> >>>>> We observed the following kmemleak report:
> >>>>> unreferenced object 0xffff000007904500 (size 128):
> >>>>>    comm "swapper/0", pid 1, jiffies 4294892671 (age 44.036s)
> >>>>>    hex dump (first 32 bytes):
> >>>>>      00 47 90 07 00 00 ff ff 60 00 c0 ff 00 00 00 00  .G......`.......
> >>>>>      60 00 80 13 00 80 ff ff a0 00 00 00 00 00 00 00  `...............
> >>>>>    backtrace:
> >>>>>      [<000000004c12b1c7>] kmem_cache_alloc+0x1ac/0x2f4
> >>>>>      [<000000005d23eb4f>] tee_shm_alloc+0x78/0x230
> >>>>>      [<00000000794dd22c>] optee_handle_rpc+0x60/0x6f0
> >>>>>      [<00000000d9f7c52d>] optee_do_call_with_arg+0x17c/0x1dc
> >>>>>      [<00000000c35884da>] optee_open_session+0x128/0x1ec
> >>>>>      [<000000001748f2ff>] tee_client_open_session+0x28/0x40
> >>>>>      [<00000000aecb5389>] optee_enumerate_devices+0x84/0x2a0
> >>>>>      [<000000003df18bf1>] optee_probe+0x674/0x6cc
> >>>>>      [<000000003a4a534a>] platform_drv_probe+0x54/0xb0
> >>>>>      [<000000000c51ce7d>] really_probe+0xe4/0x4d0
> >>>>>      [<000000002f04c865>] driver_probe_device+0x58/0xc0
> >>>>>      [<00000000b485397d>] device_driver_attach+0xc0/0xd0
> >>>>>      [<00000000c835f0df>] __driver_attach+0x84/0x124
> >>>>>      [<000000008e5a429c>] bus_for_each_dev+0x70/0xc0
> >>>>>      [<000000001735e8a8>] driver_attach+0x24/0x30
> >>>>>      [<000000006d94b04f>] bus_add_driver+0x104/0x1ec
> >>>>>
> >>>>> This is not a memory leak because we pass the share memory pointer to
> >>>>> secure world and would get it from secure world before releasing it.
> >>>>> How about if it's actually a memory leak caused by the secure world?
> >>>>> An example being secure world just allocates kernel memory via OPTEE_SMC_RPC_FUNC_ALLOC and doesn't free it via OPTEE_SMC_RPC_FUNC_FREE.
> >>>>> IMO, we need to cross-check optee-os if it's responsible for leaking kernel memory.
> >>>> Hi sumit,
> >>>>
> >>>> You mean we need to check whether there is a real memleak,
> >>>> If being secure world just allocate kernel memory via OPTEE_SMC_PRC_FUNC_ALLOC and until the end, there is no free
> >>>> It via OPTEE_SMC_PRC_FUNC_FREE, then we should judge it as a memory leak, wo need to judge whether it is caused by secure os?
> >>> Yes. AFAICT, optee-os should allocate shared memory to communicate
> >>> with tee-supplicant. So once the communication is done, the underlying
> >>> shared memory should be freed. I can't think of any scenario where
> >>> optee-os should keep hold-off shared memory indefinitely.
> >> I believe it can happen when OP-TEE's CFG_PREALLOC_RPC_CACHE is y. See
> >> the config file [1] and the commit which introduced this config [2].
> > Okay, I see the reasoning. So during the OP-TEE driver's lifetime, the
> > RPC shared memory remains allocated. I guess that is done primarily
> > for performance reasons.
> >
> > But still it doesn't feel appropriate that we term all RPC shm
> > allocations as not leaking memory as we might miss obvious ones.
> >
> > Xiaolei,
> >
> > Can you once test with CFG_PREALLOC_RPC_CACHE=n while compiling
> > optee-os and see if the observed memory leak disappears or not?
> >
> > -Sumit
>
> Hi sumit
>
>
> The version I am using has not increased the CFG_PREALLOC_RPC_CACHE
>
> switch, I checked out to the latest version, but because of the need for
>
> additional patches for the imx8 platform, I still have no way to test the
>
> CFG_PREALLOC_RPC_CACHE=n situation
>

Can you just try to backport this [1] patch to your imx8 optee-os tree and test?

[1] https://github.com/OP-TEE/optee_os/commit/8887663248ad

-Sumit

>
> thanks
>
> xiaolei
>
> >
> >> [1] https://github.com/OP-TEE/optee_os/blob/3.15.0/mk/config.mk#L709
> >> [2] https://github.com/OP-TEE/optee_os/commit/8887663248ad
> >>
> >> --
> >> Jerome
