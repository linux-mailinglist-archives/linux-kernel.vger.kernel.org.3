Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3B46746FEDB
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Dec 2021 11:42:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237285AbhLJKpd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Dec 2021 05:45:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59534 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236065AbhLJKpc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Dec 2021 05:45:32 -0500
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com [IPv6:2a00:1450:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DCF45C061746
        for <linux-kernel@vger.kernel.org>; Fri, 10 Dec 2021 02:41:57 -0800 (PST)
Received: by mail-wr1-x436.google.com with SMTP id v11so14143870wrw.10
        for <linux-kernel@vger.kernel.org>; Fri, 10 Dec 2021 02:41:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=l3zA3YFISqepqMfWlVnAWGhtccmB8/uPPfTRJv6kyDc=;
        b=cJ1x9lDdhbyZgv/Y5xKIZ9XKEqDJZ8OOybUGEimzRsp5zlxvPZNggWcsLDFboocuOZ
         W/DVPcp5wfxMRLr1ALq5rkYJSseXrJ7N8xhN9zX4yNFhGqvIImPwmqzPcy+F+WbhCqYj
         jgainY3M0AvzZtiv6TMnZS8Dowzwtp8Rea12l3M1o5UMgY11z5pipRxNEcpdLYP7oN9B
         tdGNU8+0xFwQxUq3N3sI1ufcwIqWiU+wib8Wj7+D5vQvVXIN9VhAhmWKiwyYAZmaZG2L
         AHUed6Np20/ORyXgaMJHLmgGWfo1imj9mlqMCdbVR3orcGp0wiY6w+n8qKDPl/U5c/u5
         tmGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=l3zA3YFISqepqMfWlVnAWGhtccmB8/uPPfTRJv6kyDc=;
        b=l4Hl3pejx/kMkm2qKE/UtRsRsEbshaEqE0ZTBfNIafKx9wkjk0egtndAgP997P2XI+
         KgsRFwGhCXNfTIBFjfx6GsUtjBbIWhb1DZlhNiZWJXHPEGGX3JPPDNbb1RoKm6dKGu1G
         yro9Zt8eVoCBA3yKcE4HhWnkRhjwkcmpzHnux0xCijSaDBzTB4JrK6gkkZK4fytJjNGm
         GvKBPyXLOswNpYcbbNtJbCQvjXPGZ8epwZ6Zxj6Co8SJvn7lo+vlHDeP3JVPhR2Pk1n5
         t7lawDAVE9ALCOZPl12wmLBRCVP+hWlANmNboYw8oJng7aXm5/mWbc3PF/zCoHKCaY2o
         ClLg==
X-Gm-Message-State: AOAM533EvLhTbyHUsVhxoGCdBxsjn1ZT34zB3DjIzeTo9EnSEZHFwSEM
        p0lweN1jBl6ZQMfesp17f7U3D9rmMwYoBbsvkpsYFw==
X-Google-Smtp-Source: ABdhPJxKBUchchwIx+nwGrSpftgVsOy0by1VD7d2p47g5mOTvAEFBeG05JyOjE2NXApfx5MiTTxrsTjkrbS4Yqdg9Ck=
X-Received: by 2002:adf:c146:: with SMTP id w6mr13509001wre.541.1639132916474;
 Fri, 10 Dec 2021 02:41:56 -0800 (PST)
MIME-Version: 1.0
References: <20211206120533.602062-1-xiaolei.wang@windriver.com>
 <CAFA6WYN+0751=feb-O9Drmm5V_Gz-1qsgiHmLsA88=49MoK_dg@mail.gmail.com>
 <PH0PR11MB507734019F54C2BB24D1456F95719@PH0PR11MB5077.namprd11.prod.outlook.com>
 <CAFA6WYMOHUEve8cbZdwzsijer3fRsy=50q67ndsC6U2JD6gK5Q@mail.gmail.com>
 <ede44051-41db-60b4-d5a3-97a789dd52bc@forissier.org> <CAN5uoS9xv-kKpC4E6-muYdh59g8XPSDfbquk5=DbQ4GmiVk-PA@mail.gmail.com>
 <CAFA6WYNZAbDpFJVnmNGm7aqCc82ZQEeUXvVW4r1+svm8rfRn7w@mail.gmail.com>
In-Reply-To: <CAFA6WYNZAbDpFJVnmNGm7aqCc82ZQEeUXvVW4r1+svm8rfRn7w@mail.gmail.com>
From:   Jens Wiklander <jens.wiklander@linaro.org>
Date:   Fri, 10 Dec 2021 11:41:45 +0100
Message-ID: <CAHUa44HqxTMcBu8ouUiSCC06gvvBUxZLZ0XWV+6Ha4kNfzRZJQ@mail.gmail.com>
Subject: Re: [PATCH] optee: Suppress false positive kmemleak report in optee_handle_rpc()
To:     Sumit Garg <sumit.garg@linaro.org>
Cc:     Etienne Carriere <etienne.carriere@linaro.org>,
        Jerome Forissier <jerome@forissier.org>,
        "Wang, Xiaolei" <Xiaolei.Wang@windriver.com>,
        "op-tee@lists.trustedfirmware.org" <op-tee@lists.trustedfirmware.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Fri, Dec 10, 2021 at 11:29 AM Sumit Garg <sumit.garg@linaro.org> wrote:
>
> On Fri, 10 Dec 2021 at 15:08, Etienne Carriere
> <etienne.carriere@linaro.org> wrote:
> >
> > Hello all,
> >
> > On Fri, 10 Dec 2021 at 09:10, Jerome Forissier <jerome@forissier.org> wrote:
> > >
> > > +CC Jens, Etienne
> > >
> > > On 12/10/21 06:00, Sumit Garg wrote:
> > > > On Fri, 10 Dec 2021 at 09:42, Wang, Xiaolei <Xiaolei.Wang@windriver.com> wrote:
> > > >>
> > > >> -----Original Message-----
> > > >> From: Sumit Garg <sumit.garg@linaro.org>
> > > >> Sent: Thursday, December 9, 2021 7:41 PM
> > > >> To: Wang, Xiaolei <Xiaolei.Wang@windriver.com>
> > > >> Cc: jens.wiklander@linaro.org; op-tee@lists.trustedfirmware.org; linux-kernel@vger.kernel.org
> > > >> Subject: Re: [PATCH] optee: Suppress false positive kmemleak report in optee_handle_rpc()
> > > >>
> > > >> [Please note: This e-mail is from an EXTERNAL e-mail address]
> > > >>
> > > >> On Mon, 6 Dec 2021 at 17:35, Xiaolei Wang <xiaolei.wang@windriver.com> wrote:
> > > >>>
> > > >>> We observed the following kmemleak report:
> > > >>> unreferenced object 0xffff000007904500 (size 128):
> > > >>>   comm "swapper/0", pid 1, jiffies 4294892671 (age 44.036s)
> > > >>>   hex dump (first 32 bytes):
> > > >>>     00 47 90 07 00 00 ff ff 60 00 c0 ff 00 00 00 00  .G......`.......
> > > >>>     60 00 80 13 00 80 ff ff a0 00 00 00 00 00 00 00  `...............
> > > >>>   backtrace:
> > > >>>     [<000000004c12b1c7>] kmem_cache_alloc+0x1ac/0x2f4
> > > >>>     [<000000005d23eb4f>] tee_shm_alloc+0x78/0x230
> > > >>>     [<00000000794dd22c>] optee_handle_rpc+0x60/0x6f0
> > > >>>     [<00000000d9f7c52d>] optee_do_call_with_arg+0x17c/0x1dc
> > > >>>     [<00000000c35884da>] optee_open_session+0x128/0x1ec
> > > >>>     [<000000001748f2ff>] tee_client_open_session+0x28/0x40
> > > >>>     [<00000000aecb5389>] optee_enumerate_devices+0x84/0x2a0
> > > >>>     [<000000003df18bf1>] optee_probe+0x674/0x6cc
> > > >>>     [<000000003a4a534a>] platform_drv_probe+0x54/0xb0
> > > >>>     [<000000000c51ce7d>] really_probe+0xe4/0x4d0
> > > >>>     [<000000002f04c865>] driver_probe_device+0x58/0xc0
> > > >>>     [<00000000b485397d>] device_driver_attach+0xc0/0xd0
> > > >>>     [<00000000c835f0df>] __driver_attach+0x84/0x124
> > > >>>     [<000000008e5a429c>] bus_for_each_dev+0x70/0xc0
> > > >>>     [<000000001735e8a8>] driver_attach+0x24/0x30
> > > >>>     [<000000006d94b04f>] bus_add_driver+0x104/0x1ec
> > > >>>
> > > >>> This is not a memory leak because we pass the share memory pointer to
> > > >>> secure world and would get it from secure world before releasing it.
> > > >>
> > > >>> How about if it's actually a memory leak caused by the secure world?
> > > >>> An example being secure world just allocates kernel memory via OPTEE_SMC_RPC_FUNC_ALLOC and doesn't free it via OPTEE_SMC_RPC_FUNC_FREE.
> > > >>
> > > >>> IMO, we need to cross-check optee-os if it's responsible for leaking kernel memory.
> > > >>
> > > >> Hi sumit,
> > > >>
> > > >> You mean we need to check whether there is a real memleak,
> > > >> If being secure world just allocate kernel memory via OPTEE_SMC_PRC_FUNC_ALLOC and until the end, there is no free
> > > >> It via OPTEE_SMC_PRC_FUNC_FREE, then we should judge it as a memory leak, wo need to judge whether it is caused by secure os?
> > > >
> > > > Yes. AFAICT, optee-os should allocate shared memory to communicate
> > > > with tee-supplicant. So once the communication is done, the underlying
> > > > shared memory should be freed. I can't think of any scenario where
> > > > optee-os should keep hold-off shared memory indefinitely.
> > >
> > > I believe it can happen when OP-TEE's CFG_PREALLOC_RPC_CACHE is y. See
> > > the config file [1] and the commit which introduced this config [2].
> > >
> > > [1] https://github.com/OP-TEE/optee_os/blob/3.15.0/mk/config.mk#L709
> > > [2] https://github.com/OP-TEE/optee_os/commit/8887663248ad
> > >
> >
> > It's been a while since OP-TEE caches some shm buffers to prevent
> > re-allocting them on and on.
> > OP-TEE does so for 1 shm buffer per "tee threads" OP-TEE has provisioned.
> > Each thread can cache a shm reference.
> > Note that used RPCs from optee to linux/u-boot/ree do not require such
> > message buffer (IMO).
> >
> > The main issue is the shm buffer are allocated per optee thread
> > (thread context assigned to client invocation request when entreing
> > optee).
> > Therefore, if an optee thread caches a shm buffer, it makes the caller
> > tee session to have a shm reference with a refcount held, until Optee
> > thread releases its cached shm reference.
> >
> > There are ugly side effects. Linux must disable the cache to release
> > all resources.
> > We recently saw some tee sessions may be left open because of such shm
> > refcount held.
> > It can lead to few misbehaviour of the TA service (restarting a
> > service, releasing a resource)
> >
> > Config switch CFG_PREALLOC_RPC_CACHE was introduced [pr4896] to
> > disable the feature at boot time.
> > There are means to not use it, or to explicitly enable/disable it at
> > run time (already used optee smc services for that). Would maybe be a
> > better default config.
> > Note this discussion thread ending at his comment [issue1918]:
> >
>
> Thanks etienne for the detailed description and references. Although,
> we can set CFG_PREALLOC_RPC_CACHE=n by default but it feels like we
> would miss a valuable optimization.
>
> How about we just allocate a shared memory page during the OP-TEE
> driver probe and share it with optee-os to use for RPC arguments? And
> later it can be freed during OP-TEE driver removal. This would avoid
> any refconting of this special memory to be associated with TA
> sessions.

The FF-A ABI part of the driver avoids this problem. I've started on a
similar solution for the SMC based ABI, but it's not ready to post
yet.

Cheers,
Jens

>
> -Sumit
>
> > Comments are welcome. I may have missed something in the description
> > (or understanding :).
> >
> > [pr4896] https://github.com/OP-TEE/optee_os/pull/4896
> > [issue1918] https://github.com/OP-TEE/optee_os/issues/1918#issuecomment-968747738
> >
> > Best regards,
> > etienne
> >
> >
> >
> > > --
> > > Jerome
