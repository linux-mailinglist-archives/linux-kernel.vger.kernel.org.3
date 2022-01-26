Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DD06249D51C
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jan 2022 23:12:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232997AbiAZWMy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Jan 2022 17:12:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53912 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229591AbiAZWMx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jan 2022 17:12:53 -0500
Received: from mail-io1-xd2d.google.com (mail-io1-xd2d.google.com [IPv6:2607:f8b0:4864:20::d2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D2639C06161C;
        Wed, 26 Jan 2022 14:12:52 -0800 (PST)
Received: by mail-io1-xd2d.google.com with SMTP id z199so1319568iof.10;
        Wed, 26 Jan 2022 14:12:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=rhXHrSPTLOS4pRVESabVF3pQQP/mJ2JTnR9miTNwFf4=;
        b=VzXocjntTph7UWrJ1xKum5qjVkrdp2soC0a+SXb5VKfiPnPi3lGU3f1Bu3rromCSW7
         OxnWAkPwNeEbw/Kb9TBF9mTImyJ6g+LrriUC4/HFH+jeYCwYpjJNjeqB8iFrQj9MxDey
         ZQVC11TqXw2fta1LTPfCFi+81IOvaLR52dO4lW+GlDOL7QupkTv5QKvREYUaf4r8TFLR
         gmiT2fiWI2+fYuSIr45Qo5mRTMbcbFiuhgh2vvTRRlGjT897LzkYDbSH0N6NVE/Eh0MV
         QqIESGjv+IzcUuUTj1c5e5tnP9ZR/P97/+T+gwvj7Xm3ldFVPms+nmapc+ZdnT5qETdR
         ty5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=rhXHrSPTLOS4pRVESabVF3pQQP/mJ2JTnR9miTNwFf4=;
        b=VNobSp5JVXSnC+4/K+31dgVgRRmo3b5LKMGEJZVD6YQ7H409sBLPPEjLxzP8sf/7qQ
         1SdZ1AQoeXVSdlUoOuGYS/GjrlceQYxk/UM27o6BnAR5glBgkJGXItsrVjCza6AGAY7T
         65EiIYe9z4wwiH2eTgqiIdxmjKvOepiOq8Vd33LL+IFGZdAVLv2lAKRPaO2WYuI29JDE
         P3Lr52bzYnyBt9NzCaDOJiGd8P0T+uFsopcH1OoOfnjeOR/NgI5KTqph0dtihvRBmifn
         ++yhQNl7f9ZJoO+6ijaK6Lnvfwm0FUA942933JK7zB/0MsiuJIBSu07hl5qRLpRDx4fx
         l9jQ==
X-Gm-Message-State: AOAM530Txdsi+KwByt020m1MIARiI6VQz4wR4EZuMHldfpa078I0xEcI
        4TWSWK5CHnX51apiK7UC1w3SMVnRiPek/xpGuzY=
X-Google-Smtp-Source: ABdhPJwrr3Hq8ZddbuK7p5tL6bFDcjE2tqdDKLW9pRG65b27MoTJTSf/Eyj+GHkDBsEjzAmfR74d9HdwxSw4F2Ddgak=
X-Received: by 2002:a05:6638:516:: with SMTP id i22mr417959jar.71.1643235172226;
 Wed, 26 Jan 2022 14:12:52 -0800 (PST)
MIME-Version: 1.0
References: <20220126205214.2149936-1-jannh@google.com>
In-Reply-To: <20220126205214.2149936-1-jannh@google.com>
From:   Andrey Konovalov <andreyknvl@gmail.com>
Date:   Wed, 26 Jan 2022 23:12:41 +0100
Message-ID: <CA+fCnZe_p+JwUWwumgGm185vWSdAK_z-UFDp7-HWKANB4YjA=g@mail.gmail.com>
Subject: Re: [PATCH] usb: raw-gadget: fix handling of dual-direction-capable endpoints
To:     Jann Horn <jannh@google.com>
Cc:     Felipe Balbi <balbi@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        USB list <linux-usb@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 26, 2022 at 9:52 PM Jann Horn <jannh@google.com> wrote:
>
> Under dummy_hcd, every available endpoint is *either* IN or OUT capable.
> But with some real hardware, there are endpoints that support both IN and
> OUT. In particular, the PLX 2380 has four available endpoints that each
> support both IN and OUT.
>
> raw-gadget currently gets confused and thinks that any endpoint that is
> usable as an IN endpoint can never be used as an OUT endpoint.
>
> Fix it by looking at the direction in the configured endpoint descriptor
> instead of looking at the hardware capabilities.
>
> With this change, I can use the PLX 2380 with raw-gadget.
>
> Fixes: f2c2e717642c ("usb: gadget: add raw-gadget interface")
> Signed-off-by: Jann Horn <jannh@google.com>
> ---
>  drivers/usb/gadget/legacy/raw_gadget.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/usb/gadget/legacy/raw_gadget.c b/drivers/usb/gadget/legacy/raw_gadget.c
> index c5a2c734234a..d86c3a36441e 100644
> --- a/drivers/usb/gadget/legacy/raw_gadget.c
> +++ b/drivers/usb/gadget/legacy/raw_gadget.c
> @@ -1004,7 +1004,7 @@ static int raw_process_ep_io(struct raw_dev *dev, struct usb_raw_ep_io *io,
>                 ret = -EBUSY;
>                 goto out_unlock;
>         }
> -       if ((in && !ep->ep->caps.dir_in) || (!in && ep->ep->caps.dir_in)) {
> +       if (in != usb_endpoint_dir_in(ep->ep->desc)) {
>                 dev_dbg(&dev->gadget->dev, "fail, wrong direction\n");
>                 ret = -EINVAL;
>                 goto out_unlock;
>
> base-commit: 0280e3c58f92b2fe0e8fbbdf8d386449168de4a8
> --
> 2.35.0.rc0.227.g00780c9af4-goog
>

Awesome! Thanks for finding this!

What do you think about using

if ((in && !ep->ep->caps.dir_in) || (!in && !ep->ep->caps.dir_out))

instead?

It looks less cryptic: if (in and no in caps) or (out and no out caps) => fail.

FTR, I tested both changes with the net2280 hardware that I have, and
they work. At least gadget.c from the test suite enumerates properly.
Most of the tests still fail. But with g_zero, even more of them fail.

P.S. I wonder why everyone suddenly got interested in Raw Gadget lately? :)
