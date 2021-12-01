Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C7A1D464613
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Dec 2021 05:49:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346642AbhLAEwl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Nov 2021 23:52:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54940 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230301AbhLAEwj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Nov 2021 23:52:39 -0500
Received: from mail-lj1-x230.google.com (mail-lj1-x230.google.com [IPv6:2a00:1450:4864:20::230])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 224AEC061574
        for <linux-kernel@vger.kernel.org>; Tue, 30 Nov 2021 20:49:19 -0800 (PST)
Received: by mail-lj1-x230.google.com with SMTP id e11so45448487ljo.13
        for <linux-kernel@vger.kernel.org>; Tue, 30 Nov 2021 20:49:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=pSuFVsq72hPtsLKMPEQ8DAcqHMPcbxuH5KA1VU6GhFs=;
        b=WygDa/xjukSsfZ3t/wUdmzO12DGsKJzy7Z52zlGIGju7QuGsOoySE2lsHy4njUCoj4
         JQ5Mew/AzuBan0+5nwppPJPvzOn02B0Pw9o7p36wdus2VssT0BVE5ijjuTVgziWx0xtf
         ubDuYqWlEuQyVtGAYfaQuntUwqAKQT0qkN0dxvtUofbT25sFEo6AWvINVvib6W+U26fj
         9yrHjXhLd1IT4k3s7H2zmDqvNbOToyutXVGHrG/sBHBbxn2F8PnFvEob49OFBxIEtqmT
         u6C8c3WqkoRuOXTgrqznEIzjrQY1QoY3i+wVoBKcpWMdpugUHVxRKYV2nTX/F5iIlGgz
         Y39w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=pSuFVsq72hPtsLKMPEQ8DAcqHMPcbxuH5KA1VU6GhFs=;
        b=ZOpb1Rt6LefdIA2jQjbbGvjD26KIGTPLlGKerWEM/udq6If8YJ+p3rnqqEm2xzMdZR
         BHcJuHo1kDUTsGySzPN2Qz+adGHPbX+xV0B/2zoO3r7AjiJ4mVNTKRpeBIQCM6IYgyB3
         wJd+c0IKHlz6Y4ZFwZKI6EjHshiYxxnNbegWpTwkTU2bS5ArGQfOVeQ560m3PFk0WO5k
         9axka0RrBNF+vTLpV7YMuelIxaWuxOAT2oBwt01l2BiByfa+/JjsF7sknBmB9kPYMTx+
         SBZLisMM6CofZQRYgQOj1YqqJzdpgQEqsboCsFoCIhGx8BJX+VMcy49EGOO1vBbtQn7d
         kNXQ==
X-Gm-Message-State: AOAM532QbKtCV7BWCXEZVTizfC4QcJxhSlNEoBvacGrVfdCKy53p/bL5
        VgdS/t7vpvyUNeBuh771f9Uki6ho3Cc8vtvkTIHGyA==
X-Google-Smtp-Source: ABdhPJyYGpWJxGsf/XYVUyOuiOOdY4Uh8JZPBGRQpLk6LZ3/Q5QFwe8+nOPGsLiudEOkhvZOG7NtSRYKY8E27+Jnyn0=
X-Received: by 2002:a2e:984f:: with SMTP id e15mr3265777ljj.427.1638334157424;
 Tue, 30 Nov 2021 20:49:17 -0800 (PST)
MIME-Version: 1.0
References: <20211029214833.2615274-1-tadeusz.struk@linaro.org> <YZ2x+xuvnHC48MHg@ripper>
In-Reply-To: <YZ2x+xuvnHC48MHg@ripper>
From:   John Stultz <john.stultz@linaro.org>
Date:   Tue, 30 Nov 2021 20:49:06 -0800
Message-ID: <CALAqxLV7YzuHLzNFSWawjpoJGb3WwO4bgnMN_5mWoHmB582kZw@mail.gmail.com>
Subject: Re: [PATCH v2] media: venus: Synchronize probe() between venus_core
 and enc/dec
To:     Bjorn Andersson <bjorn.andersson@linaro.org>
Cc:     Tadeusz Struk <tadeusz.struk@linaro.org>,
        Stanimir Varbanov <stanimir.varbanov@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Lee Jones <lee.jones@linaro.org>,
        Amit Pundir <amit.pundir@linaro.org>,
        linux-media@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 23, 2021 at 7:29 PM Bjorn Andersson
<bjorn.andersson@linaro.org> wrote:
>
> On Fri 29 Oct 14:48 PDT 2021, Tadeusz Struk wrote:
>
> > Venus video encode/decode hardware driver consists of three modules.
> > The parent module venus-core, and two sub modules venus-enc and venus-dec.
> > The venus-core module allocates a common structure that is used by the
> > enc/dec modules, loads the firmware, and performs some common hardware
> > initialization. Since the three modules are loaded one after the other,
> > and their probe functions can run in parallel it is possible that
> > the venc_probe and vdec_probe functions can finish before the core
> > venus_probe function, which then can fail when, for example it
> > fails to load the firmware. In this case the subsequent call to venc_open
> > causes an Oops as it tries to dereference already uninitialized structures
> > through dev->parent and the system crashes in __pm_runtime_resume() as in
> > the trace below:
> >
> > [   26.064835][  T485] Internal error: Oops: 96000006 [#1] PREEMPT SMP
> > [   26.270914][  T485] Hardware name: Thundercomm Dragonboard 845c (DT)
> > [   26.285019][  T485] pc : __pm_runtime_resume+0x34/0x178
> > [   26.286374][  T213] lt9611 10-003b: hdmi cable connected
> > [   26.290285][  T485] lr : venc_open+0xc0/0x278 [venus_enc]
> > [   26.290326][  T485] Call trace:
> > [   26.290328][  T485]  __pm_runtime_resume+0x34/0x178
> > [   26.290330][  T485]  venc_open+0xc0/0x278 [venus_enc]
> > [   26.290335][  T485]  v4l2_open+0x184/0x294
> > [   26.290340][  T485]  chrdev_open+0x468/0x5c8
> > [   26.290344][  T485]  do_dentry_open+0x260/0x54c
> > [   26.290349][  T485]  path_openat+0xbe8/0xd5c
> > [   26.290352][  T485]  do_filp_open+0xb8/0x168
> > [   26.290354][  T485]  do_sys_openat2+0xa4/0x1e8
> > [   26.290357][  T485]  __arm64_compat_sys_openat+0x70/0x9c
> > [   26.290359][  T485]  invoke_syscall+0x60/0x170
> > [   26.290363][  T485]  el0_svc_common+0xb8/0xf8
> > [   26.290365][  T485]  do_el0_svc_compat+0x20/0x30
> > [   26.290367][  T485]  el0_svc_compat+0x24/0x84
> > [   26.290372][  T485]  el0t_32_sync_handler+0x7c/0xbc
> > [   26.290374][  T485]  el0t_32_sync+0x1b8/0x1bc
> > [   26.290381][  T485] ---[ end trace 04ca7c088b4c1a9c ]---
> > [   26.290383][  T485] Kernel panic - not syncing: Oops: Fatal exception
> >
> > This can be fixed by synchronizing the three probe functions and
> > only allowing the venc_probe() and vdec_probe() to pass when venus_probe()
> > returns success.
> >
> > Changes in v2:
> > - Change locking from mutex_lock to mutex_trylock
> >   in venc_probe and vdec_probe to avoid potential deadlock.
> >
>
> Rather than trying to synchronize away the side effects of
> of_platform_populate() I think we should stop using it.
>
> I had the very same problem in the qcom_wcnss remoteproc driver and
> in below change I got rid of that by manually initializing a struct
> device for the child node. In the event that the child probe defer I
> would just probe defer the parent as well.
>
> 1fcef985c8bd ("remoteproc: qcom: wcnss: Fix race with iris probe")
>
> The change might look a little bit messy, but the end result it much
> cleaner than relying on various locks etc.
>
>
> But in the qcom_wcnss case I have a child _device_ because I need
> something to do e.g. regulator_get() on. I fail to see why venc and vdec
> are devices in the first place.

I definitely agree with Bjorn that all this asynchronous component
probing feels overly complicated, and a rework is probably the better
solution.

Though my only question is:  is someone planning to do this rework?

In the meantime, Tadeusz' patch does resolve a *very* frequent boot
crash seen when the venus driver is enabled.
So Stanimir, should we consider merging this as a stop gap until the
larger probe rework is done?

thanks
-john
