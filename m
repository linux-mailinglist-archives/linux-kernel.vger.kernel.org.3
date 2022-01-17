Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CB8FA4900AE
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jan 2022 05:06:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237026AbiAQEFr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 16 Jan 2022 23:05:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37080 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237016AbiAQEFp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 16 Jan 2022 23:05:45 -0500
Received: from mail-ot1-x336.google.com (mail-ot1-x336.google.com [IPv6:2607:f8b0:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 42B20C06161C
        for <linux-kernel@vger.kernel.org>; Sun, 16 Jan 2022 20:05:45 -0800 (PST)
Received: by mail-ot1-x336.google.com with SMTP id 60-20020a9d0142000000b0059103eb18d4so18289531otu.2
        for <linux-kernel@vger.kernel.org>; Sun, 16 Jan 2022 20:05:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=JQ/xnrG6NbfCVGOwmMj9V0QI7i/pVfiEwLLPSTxg0zs=;
        b=cKNSqKTOXUjXKTVmzorDoAslxEI0ag6jySXgQ6pwaavx+7MRoWU9vv0Yosecyn/fxn
         lrcAzqeD+vfAF8aB1DbM34zv7qRFulEKz4ZarVzD8aNVS61dw4I6Wv7LRaDidLV7ljSa
         BC/kdY5FGk9SbOIX6MRpryZebZUFHyMDUeq7oA5LvwWVEDZsQgSM/WOGeSCuhZlCctr1
         HZubwuW+HWaUSsXMEs02iLTv55Oelqdk/B5y0x1p4LmyRat5XjYxc7gaPpUjlAGiBJgE
         2BaxzwVcIjXc7U43REdPEP6tPMTzybg0IQRIHzXOFlRCTBHjZHkcVhS7TbSURW4gvwq3
         BB0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=JQ/xnrG6NbfCVGOwmMj9V0QI7i/pVfiEwLLPSTxg0zs=;
        b=Fq57Smla7z9zdBjv4f+X0RX7GYXZltQRNNjozsHULKyIM3ftCNn0PcMwIxZNjF6AT5
         EdkvPkhBc9+AM/FA5S/UmmRnL6pmup5aRp/fD/diX2onTBfqdFGNm81itu2WlGXrqizV
         hUL2FqDa+K3YsahDL2FtgVxna6aYPow9CRfr2Y05WXTYJZGpaka5uBuQL56Ys0zC2RjM
         HhpWhV4QPD6vCYrYY4LBbAS5QvHzBif6PxXXD6d0B+i3vMJ6/Xo/LvHukRFapI5bDr8c
         YjvN3sIbSrW8DF0PWdmYCt/k+zejkIHLdQ3elJJ+qsuy1dDdKNxiIDjEtR4MZrCLU0nh
         Rivw==
X-Gm-Message-State: AOAM530R5OCpF65fv+mjzlKz7hqM6dBQoB6m6eLsC1H/MxGu/WB+hF6P
        UOD9Pk6q5d3r1UuqsNso2QK3TJDsM4grlkGwY178uyyjaSK01wAD
X-Google-Smtp-Source: ABdhPJwHwKiQi+xajrgHE0d7lTJBBiqRVbtO7UZyHZ3gW1fGktNrqQMMtQFAhprTRe7hIPWV7zUHIcG+Nv1E8E5f5y8=
X-Received: by 2002:a05:6830:2788:: with SMTP id x8mr14742865otu.349.1642392344331;
 Sun, 16 Jan 2022 20:05:44 -0800 (PST)
MIME-Version: 1.0
References: <20220116192611.19224-1-makvihas@gmail.com> <c908c21f-1de3-cb70-7694-54b3db669da6@gmail.com>
In-Reply-To: <c908c21f-1de3-cb70-7694-54b3db669da6@gmail.com>
From:   Vihas Mak <makvihas@gmail.com>
Date:   Mon, 17 Jan 2022 09:35:33 +0530
Message-ID: <CAH1kMwTO1AZKU45rBSm1hZgPtYsV83Cr9GZMOodYGAFZbTmZEA@mail.gmail.com>
Subject: Re: [PATCH] staging: r8188eu: handle rtw_init_netdev_name() failure appropriately
To:     Pavel Skripkin <paskripkin@gmail.com>
Cc:     Larry.Finger@lwfinger.net, Phillip Potter <phil@philpotter.co.uk>,
        Greg KH <gregkh@linuxfoundation.org>, martin@kaiser.cx,
        straube.linux@gmail.com, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

>> rtw_init_netdev_name() has an error message in case of allocation
>> failure. It looks like it's better to handle the error normally and pass
>> it to caller
By that you mean:
    goto handle_dualmac;
and freeing the adapter.
right?
FYI, if the allocation fails then it assigns the name using default
format i.e. "eth%d".

On Mon, Jan 17, 2022 at 3:17 AM Pavel Skripkin <paskripkin@gmail.com> wrote:
>
> Hi Vihas,
>
> On 1/16/22 22:26, Vihas Mak wrote:
> > rtw_init_netdev_name() calls dev_alloc_name() which allocates the name
> > for the device as per the given name format.
> > It returns a negative err code if the format is invalid. Currently the
> > name format is specified by the module parameter "ifname".
> > Warn the user if "ifname" is invalid.
> >
> > Signed-off-by: Vihas Mak <makvihas@gmail.com>
> > ---
> >   drivers/staging/r8188eu/os_dep/usb_intf.c | 5 ++++-
> >   1 file changed, 4 insertions(+), 1 deletion(-)
> >
> > diff --git a/drivers/staging/r8188eu/os_dep/usb_intf.c b/drivers/staging/r8188eu/os_dep/usb_intf.c
> > index 91792dfd3..875815b5e 100644
> > --- a/drivers/staging/r8188eu/os_dep/usb_intf.c
> > +++ b/drivers/staging/r8188eu/os_dep/usb_intf.c
> > @@ -399,7 +399,10 @@ static struct adapter *rtw_usb_if1_init(struct dvobj_priv *dvobj,
> >                       DBG_88E("can't get autopm:\n");
> >
> >       /*  alloc dev name after read efuse. */
> > -     rtw_init_netdev_name(pnetdev, padapter->registrypriv.ifname);
> > +     if (rtw_init_netdev_name(pnetdev, padapter->registrypriv.ifname) < 0) {
> > +             DBG_88E("rtw_init_netdev_name failed, ifname:%s\n",
> > +                     padapter->registrypriv.ifname);
> > +     }
> >       rtw_macaddr_cfg(padapter->eeprompriv.mac_addr);
> >       rtw_init_wifidirect_addrs(padapter, padapter->eeprompriv.mac_addr,
> >                                 padapter->eeprompriv.mac_addr);
>
> rtw_init_netdev_name() has an error message in case of allocation
> failure. It looks like it's better to handle the error normally and pass
> it to caller
>
>
>
>
> With regards,
> Pavel Skripkin



-- 
Thanks,
Vihas
