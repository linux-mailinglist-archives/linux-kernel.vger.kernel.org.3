Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2C458473DA7
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Dec 2021 08:29:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229577AbhLNH3n (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Dec 2021 02:29:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48840 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229516AbhLNH3n (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Dec 2021 02:29:43 -0500
Received: from mail-lf1-x12c.google.com (mail-lf1-x12c.google.com [IPv6:2a00:1450:4864:20::12c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 96A42C06173F
        for <linux-kernel@vger.kernel.org>; Mon, 13 Dec 2021 23:29:42 -0800 (PST)
Received: by mail-lf1-x12c.google.com with SMTP id b40so35225508lfv.10
        for <linux-kernel@vger.kernel.org>; Mon, 13 Dec 2021 23:29:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=DRPba7eN+b3r8lKyEgGhsWcaZu66WORVhrUd8YpJn/M=;
        b=oPVAcez875ZKzrHsLWsQ3KUUzh+TM96h46a9Ov0uDD9zr1f6F0D+kCjaD59DsdZHGO
         uIKC1uVqD27Hojuu329gionX+JDofEVTTIpfaQWx0/hZUkp3B7f08xoVNasRvIifjODL
         bhgKLSkUO7kNQ+smM8I3QY614XYvfY5h8yXihwMQhfEpgb4wAPmv2YcOei5rKjmnbKmq
         GuOy9W8HZXU2t7LtrvQp3b5f247UI/qdPUCICHzqip5UayXj854K3xU7FJ9lTdGzeG4t
         x3j7L+w2+xTsGsvUZyMhKvBcQv2QKZXEp1kqooDI/Akcw1BJDKlNPlR8NjJ9dHT9JwHd
         lPRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=DRPba7eN+b3r8lKyEgGhsWcaZu66WORVhrUd8YpJn/M=;
        b=43ZupDf7UPUzl+ARWQZCzLZvgsUn+7Azni8mxRMPLNUBitLOyBzcC/KyawAtMe1AIe
         AWuNU0r5zLn6h0bp59PMWDkPKLxe1WVifciXurrkP3W0r7C8L1sVgNeXnR1QR/pEwP+h
         ZKYLAIg4qEyfGf+1m9dGkLJ6NMC4oLlHtjSFjKFvT+CAMzOLMu+EBBjTNgmcHNdyFfR0
         u+n4Z0tyDZB2PcyHrU2n1d5ZP+DwM+i4tyneX0YpEOiH0g4WCjNWr3v3/CNJ5lvL9TSA
         aJ9z3LyutlChhepNFnrY2hp2URxnUrug1odXiwTKlM/SrrB4R7FbVPXrDSnVmPhx79Uh
         bXRQ==
X-Gm-Message-State: AOAM533Fhb18+05zjgkctXj3iprRZm0TAolhkp22z8zyfxLxuNRs7tRo
        8DvKHRc562VfHjnx1Q6TmMPwiO5Ry5zUd6PoZAxXjg==
X-Google-Smtp-Source: ABdhPJxjUHcZg7bNSQe0y909TytFtH4GOql+JhnnV28FDEI8kb4gQQt5LlFWOOZP3Yhl4tYxx9kL9gsuH+r4LiEshfw=
X-Received: by 2002:a05:6512:1192:: with SMTP id g18mr3418627lfr.40.1639466980828;
 Mon, 13 Dec 2021 23:29:40 -0800 (PST)
MIME-Version: 1.0
References: <20211206120533.602062-1-xiaolei.wang@windriver.com>
 <CAFA6WYN+0751=feb-O9Drmm5V_Gz-1qsgiHmLsA88=49MoK_dg@mail.gmail.com>
 <PH0PR11MB507734019F54C2BB24D1456F95719@PH0PR11MB5077.namprd11.prod.outlook.com>
 <CAFA6WYMOHUEve8cbZdwzsijer3fRsy=50q67ndsC6U2JD6gK5Q@mail.gmail.com>
 <ede44051-41db-60b4-d5a3-97a789dd52bc@forissier.org> <CAFA6WYM1oCs9gE4b5DaRez+jhCXPb_c25ausj0yWdS5tawX0MA@mail.gmail.com>
 <2c9f2f34-9dab-4f1b-bc10-48212fb70335@windriver.com> <CAFA6WYPfjGqY6GJqLmrhU7CBjBTEYZzuCptHLJe2aEGUM_kOBA@mail.gmail.com>
 <3c130368-6933-55cf-eb05-431f326c5be8@windriver.com>
In-Reply-To: <3c130368-6933-55cf-eb05-431f326c5be8@windriver.com>
From:   Sumit Garg <sumit.garg@linaro.org>
Date:   Tue, 14 Dec 2021 12:59:29 +0530
Message-ID: <CAFA6WYNh6WmkeZFCOPJpu69ypyWc7itMBdhTg3yqnH0MbOhFcQ@mail.gmail.com>
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

On Tue, 14 Dec 2021 at 12:41, wangxiaolei <xiaolei.wang@windriver.com> wrote:
>
>
> On 12/13/21 5:04 PM, Sumit Garg wrote:
> > [Please note: This e-mail is from an EXTERNAL e-mail address]
> >
> > On Mon, 13 Dec 2021 at 14:25, wangxiaolei <xiaolei.wang@windriver.com> wrote:
> >>
> >> On 12/10/21 5:38 PM, Sumit Garg wrote:
> >>> [Please note: This e-mail is from an EXTERNAL e-mail address]
> >>>
> >>> On Fri, 10 Dec 2021 at 13:40, Jerome Forissier <jerome@forissier.org> wrote:
> >>>> +CC Jens, Etienne
> >>>>
> >>>> On 12/10/21 06:00, Sumit Garg wrote:
> >>>>> On Fri, 10 Dec 2021 at 09:42, Wang, Xiaolei <Xiaolei.Wang@windriver.com> wrote:
> >>>>>> -----Original Message-----
> >>>>>> From: Sumit Garg <sumit.garg@linaro.org>
> >>>>>> Sent: Thursday, December 9, 2021 7:41 PM
> >>>>>> To: Wang, Xiaolei <Xiaolei.Wang@windriver.com>
> >>>>>> Cc: jens.wiklander@linaro.org; op-tee@lists.trustedfirmware.org; linux-kernel@vger.kernel.org
> >>>>>> Subject: Re: [PATCH] optee: Suppress false positive kmemleak report in optee_handle_rpc()
> >>>>>>
> >>>>>> [Please note: This e-mail is from an EXTERNAL e-mail address]
> >>>>>>
> >>>>>> On Mon, 6 Dec 2021 at 17:35, Xiaolei Wang <xiaolei.wang@windriver.com> wrote:
> >>>>>>> We observed the following kmemleak report:
> >>>>>>> unreferenced object 0xffff000007904500 (size 128):
> >>>>>>>     comm "swapper/0", pid 1, jiffies 4294892671 (age 44.036s)
> >>>>>>>     hex dump (first 32 bytes):
> >>>>>>>       00 47 90 07 00 00 ff ff 60 00 c0 ff 00 00 00 00  .G......`.......
> >>>>>>>       60 00 80 13 00 80 ff ff a0 00 00 00 00 00 00 00  `...............
> >>>>>>>     backtrace:
> >>>>>>>       [<000000004c12b1c7>] kmem_cache_alloc+0x1ac/0x2f4
> >>>>>>>       [<000000005d23eb4f>] tee_shm_alloc+0x78/0x230
> >>>>>>>       [<00000000794dd22c>] optee_handle_rpc+0x60/0x6f0
> >>>>>>>       [<00000000d9f7c52d>] optee_do_call_with_arg+0x17c/0x1dc
> >>>>>>>       [<00000000c35884da>] optee_open_session+0x128/0x1ec
> >>>>>>>       [<000000001748f2ff>] tee_client_open_session+0x28/0x40
> >>>>>>>       [<00000000aecb5389>] optee_enumerate_devices+0x84/0x2a0
> >>>>>>>       [<000000003df18bf1>] optee_probe+0x674/0x6cc
> >>>>>>>       [<000000003a4a534a>] platform_drv_probe+0x54/0xb0
> >>>>>>>       [<000000000c51ce7d>] really_probe+0xe4/0x4d0
> >>>>>>>       [<000000002f04c865>] driver_probe_device+0x58/0xc0
> >>>>>>>       [<00000000b485397d>] device_driver_attach+0xc0/0xd0
> >>>>>>>       [<00000000c835f0df>] __driver_attach+0x84/0x124
> >>>>>>>       [<000000008e5a429c>] bus_for_each_dev+0x70/0xc0
> >>>>>>>       [<000000001735e8a8>] driver_attach+0x24/0x30
> >>>>>>>       [<000000006d94b04f>] bus_add_driver+0x104/0x1ec
> >>>>>>>
> >>>>>>> This is not a memory leak because we pass the share memory pointer to
> >>>>>>> secure world and would get it from secure world before releasing it.
> >>>>>>> How about if it's actually a memory leak caused by the secure world?
> >>>>>>> An example being secure world just allocates kernel memory via OPTEE_SMC_RPC_FUNC_ALLOC and doesn't free it via OPTEE_SMC_RPC_FUNC_FREE.
> >>>>>>> IMO, we need to cross-check optee-os if it's responsible for leaking kernel memory.
> >>>>>> Hi sumit,
> >>>>>>
> >>>>>> You mean we need to check whether there is a real memleak,
> >>>>>> If being secure world just allocate kernel memory via OPTEE_SMC_PRC_FUNC_ALLOC and until the end, there is no free
> >>>>>> It via OPTEE_SMC_PRC_FUNC_FREE, then we should judge it as a memory leak, wo need to judge whether it is caused by secure os?
> >>>>> Yes. AFAICT, optee-os should allocate shared memory to communicate
> >>>>> with tee-supplicant. So once the communication is done, the underlying
> >>>>> shared memory should be freed. I can't think of any scenario where
> >>>>> optee-os should keep hold-off shared memory indefinitely.
> >>>> I believe it can happen when OP-TEE's CFG_PREALLOC_RPC_CACHE is y. See
> >>>> the config file [1] and the commit which introduced this config [2].
> >>> Okay, I see the reasoning. So during the OP-TEE driver's lifetime, the
> >>> RPC shared memory remains allocated. I guess that is done primarily
> >>> for performance reasons.
> >>>
> >>> But still it doesn't feel appropriate that we term all RPC shm
> >>> allocations as not leaking memory as we might miss obvious ones.
> >>>
> >>> Xiaolei,
> >>>
> >>> Can you once test with CFG_PREALLOC_RPC_CACHE=n while compiling
> >>> optee-os and see if the observed memory leak disappears or not?
> >>>
> >>> -Sumit
> >> Hi sumit
> >>
> >>
> >> The version I am using has not increased the CFG_PREALLOC_RPC_CACHE
> >>
> >> switch, I checked out to the latest version, but because of the need for
> >>
> >> additional patches for the imx8 platform, I still have no way to test the
> >>
> >> CFG_PREALLOC_RPC_CACHE=n situation
> >>
> > Can you just try to backport this [1] patch to your imx8 optee-os tree and test?
> >
> > [1] https://github.com/OP-TEE/optee_os/commit/8887663248ad
>
> Hi sumit
>
> I upgraded optee-os from version 3.2.0 to 3.13.0, and the kernel did not
> detect this problem.

Can you check if CFG_TEE_CORE_EMBED_INTERNAL_TESTS is enabled in
optee-os version 3.13.0? As we would require atleast one RPC prealloc
SHM invocation from OP-TEE for kmemleak to detect the problem.

-Sumit

>
> I have not set CFG_PREALLOC_RPC_CACHE to n. This should be a problem
> that occurs when compatible
>
> with lower versions.
>
>
> thanks
>
> xiaolei
>
> >
> > -Sumit
> >
> >> thanks
> >>
> >> xiaolei
> >>
> >>>> [1] https://github.com/OP-TEE/optee_os/blob/3.15.0/mk/config.mk#L709
> >>>> [2] https://github.com/OP-TEE/optee_os/commit/8887663248ad
> >>>>
> >>>> --
> >>>> Jerome
