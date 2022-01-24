Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 62C774983CC
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jan 2022 16:49:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238584AbiAXPt1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Jan 2022 10:49:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55696 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238677AbiAXPtY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Jan 2022 10:49:24 -0500
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com [IPv6:2a00:1450:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 77EC2C06173B;
        Mon, 24 Jan 2022 07:49:23 -0800 (PST)
Received: by mail-ed1-x533.google.com with SMTP id m11so57261541edi.13;
        Mon, 24 Jan 2022 07:49:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ck0w51IvRliIB6pv/Ws3xhjRD4pvF1jTBIYtkJQiBu8=;
        b=LL5yNLCd5JsqLpRQ5nzdeJeWV2vu2EoWJzHzeHCBYA/NWGdo4VeSsgsIEwI8Tn7nz6
         W1e6v9wnY9BH8N79mkx56m4EfJoiT+3EjBvVBnG0jW3Rq/DaPVLKLlY5qNrdb+9ossC/
         QpgfjRYxfcynBXH1Afp+KEhzd/ZaHQHo60DU3Dl+eUkkdUpxCKZKgtxBJO0/NcPgB/aE
         D2Pch7iyAi2fFukvCrrQPnp8EF1ezevx+whtC1hW/HgDtPx97R/j+4MTZpXEmpvW36/a
         zozwZnshO2LfsPDO9HAef0dqpjqaAt3Go04GBE2HWPqgJg40rg2NLOnF0U516sbb3V4u
         rF2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ck0w51IvRliIB6pv/Ws3xhjRD4pvF1jTBIYtkJQiBu8=;
        b=GkzgqP/RN2qE3nEsHv7QTB6iiZKByQJnV6J5hJaXshLi/z+iSwLbJMCknrQnqn0NKl
         sD8zLKU5MuX94kpwrgxpmLrSpKQHilI4V1RCIJHZK/gT/wszteVswSwGsQyQjZO9Er3H
         J5yXX4gNeN87oNXm1Llk+jpf6edyNEg3GOpFdK/bjiB331RkuZGmRHs8yV75fhlHfD89
         83TKPjCBXW3m4ETIeW5PxBZoywdOjHQA4+A6TDAxUxl85GY0Vq2Rh585HXunlwXzGNjp
         eZ786+9yliyrbIO41aKlwX4GhWqv/yq0+6g0LzwHJUDXGIsfzU6bMmdbUo7ERLTbpZJO
         H+aQ==
X-Gm-Message-State: AOAM531ADtf2TlOIXNXCVPF+KYhIxPDx/TYpzcvasmmXCOhG22w6TLgm
        DwXARgJdxoZzooi6EBcgB1Fjpww2x6V6RTfeQ6g=
X-Google-Smtp-Source: ABdhPJyccFD32PE0fHnTFMAkO1S4G2O0a7lkHbN88E2PpAwxoCEouvAtoC8wB/8SvFmF2nBGTwCFw1jhAqGsFD7ZDr8=
X-Received: by 2002:a50:9504:: with SMTP id u4mr16091507eda.107.1643039361772;
 Mon, 24 Jan 2022 07:49:21 -0800 (PST)
MIME-Version: 1.0
References: <20220110172738.31686-1-Frank.Li@nxp.com> <Yd/7NQLgoEU17TzI@abelvesa>
In-Reply-To: <Yd/7NQLgoEU17TzI@abelvesa>
From:   Zhi Li <lznuaa@gmail.com>
Date:   Mon, 24 Jan 2022 09:49:10 -0600
Message-ID: <CAHrpEqQGDaUzhSpOmxj_J6a8X3ohMCW32jY+PApvmajPe7ckSQ@mail.gmail.com>
Subject: Re: [PATCH 1/1] usb: xhci-plat: fix crash when suspend if remote wake enable
To:     Abel Vesa <abelvesa@kernel.org>
Cc:     Frank Li <Frank.Li@nxp.com>, mathias.nyman@intel.com,
        gregkh@linuxfoundation.org, Peter Chen <peter.chen@kernel.org>,
        linux-usb@vger.kernel.org,
        kernel list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 13, 2022 at 4:13 AM Abel Vesa <abelvesa@kernel.org> wrote:
>
> On 22-01-10 11:27:38, Frank Li wrote:
> > Crashed at i.mx8qm platform when suspend if enable remote wakeup
> >
> > Internal error: synchronous external abort: 96000210 [#1] PREEMPT SMP
> > Modules linked in:
> > CPU: 2 PID: 244 Comm: kworker/u12:6 Not tainted 5.15.5-dirty #12
> > Hardware name: Freescale i.MX8QM MEK (DT)
> > Workqueue: events_unbound async_run_entry_fn
> > pstate: 600000c5 (nZCv daIF -PAN -UAO -TCO -DIT -SSBS BTYPE=--)
> > pc : xhci_disable_hub_port_wake.isra.62+0x60/0xf8
> > lr : xhci_disable_hub_port_wake.isra.62+0x34/0xf8
> > sp : ffff80001394bbf0
> > x29: ffff80001394bbf0 x28: 0000000000000000 x27: ffff00081193b578
> > x26: ffff00081193b570 x25: 0000000000000000 x24: 0000000000000000
> > x23: ffff00081193a29c x22: 0000000000020001 x21: 0000000000000001
> > x20: 0000000000000000 x19: ffff800014e90490 x18: 0000000000000000
> > x17: 0000000000000000 x16: 0000000000000000 x15: 0000000000000000
> > x14: 0000000000000000 x13: 0000000000000002 x12: 0000000000000000
> > x11: 0000000000000000 x10: 0000000000000960 x9 : ffff80001394baa0
> > x8 : ffff0008145d1780 x7 : ffff0008f95b8e80 x6 : 000000001853b453
> > x5 : 0000000000000496 x4 : 0000000000000000 x3 : ffff00081193a29c
> > x2 : 0000000000000001 x1 : 0000000000000000 x0 : ffff000814591620
> > Call trace:
> >  xhci_disable_hub_port_wake.isra.62+0x60/0xf8
> >  xhci_suspend+0x58/0x510
> >  xhci_plat_suspend+0x50/0x78
> >  platform_pm_suspend+0x2c/0x78
> >  dpm_run_callback.isra.25+0x50/0xe8
> >  __device_suspend+0x108/0x3c0
> >
> > The basic flow:
> >       1. run time suspend call xhci_suspend, xhci parent devices gate the clock.
> >         2. echo mem >/sys/power/state, system _device_suspend call xhci_suspend
> >         3. xhci_suspend call xhci_disable_hub_port_wake, which access register,
> >          but clock already gated by run time suspend.
> >
> > This problem was hidden by power domain driver, which call run time resume before it.
> >
> > But the below commit remove it and make this issue happen.
> >       commit c1df456d0f06e ("PM: domains: Don't runtime resume devices at genpd_prepare()")
> >
> > This patch call run time resume before suspend to make sure clock is on
> > before access register.
> >
> > Signed-off-by: Frank Li <Frank.Li@nxp.com>
>
> Tested on i.MX8QM.
>
> Testeb-by: Abel Vesa <abel.vesa@nxp.com>

Friendly ping

>
> > ---
> >  drivers/usb/host/xhci-plat.c | 3 +++
> >  1 file changed, 3 insertions(+)
> >
> > diff --git a/drivers/usb/host/xhci-plat.c b/drivers/usb/host/xhci-plat.c
> > index c6b791a83ad18..7d2f665271310 100644
> > --- a/drivers/usb/host/xhci-plat.c
> > +++ b/drivers/usb/host/xhci-plat.c
> > @@ -442,6 +442,9 @@ static int __maybe_unused xhci_plat_suspend(struct device *dev)
> >       struct xhci_hcd *xhci = hcd_to_xhci(hcd);
> >       int ret;
> >
> > +     if (pm_runtime_suspended(dev))
> > +             pm_runtime_resume(dev);
> > +
> >       ret = xhci_priv_suspend_quirk(hcd);
> >       if (ret)
> >               return ret;
> > --
> > 2.24.0.rc1
> >
