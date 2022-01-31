Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9B3DC4A3C67
	for <lists+linux-kernel@lfdr.de>; Mon, 31 Jan 2022 02:01:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1357269AbiAaBBc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 30 Jan 2022 20:01:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52526 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230269AbiAaBB3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 30 Jan 2022 20:01:29 -0500
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com [IPv6:2a00:1450:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F7F7C061714;
        Sun, 30 Jan 2022 17:01:29 -0800 (PST)
Received: by mail-ej1-x62a.google.com with SMTP id s13so37591663ejy.3;
        Sun, 30 Jan 2022 17:01:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Ym89J5ppYsLafTCgQLu95aNd6tvgqMgguKVHierPn/o=;
        b=F1HXOcuPEx+vjvjYiS9jZnO+S87abpMto09OwPLdD61GB+TPrwM8pDPTRPvzQeQKIR
         JHo/u6YABWDwYBawEZNAhW8HDOrtyHPKPLciTJK0YPI6qws5wCTFUNTNL8zRn7Dziu6T
         dZl30ZGyOJMzdz/RQrAxFVs4wniY8ki9n6c1kkO6ZhLqf4dWEo+Wb0VM9ObMU/qk05f3
         WmVQQRQpnM0ChT3GiDDOAXQNG5tMKR0HrBdFXpIEJCjKNhfnJNcpl10eNNdj8KObXrTt
         RspTiy0BRKWZUnlF7zeESfIPz+08QnsyfWGWLftiiNM9QCn/jN7R1hZ1EnlLtmDkolav
         QWvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Ym89J5ppYsLafTCgQLu95aNd6tvgqMgguKVHierPn/o=;
        b=NXoPD0euXXqKcTDlu20+9rKe7lnCjxmITNPDw/sw40pTh4VtsALYgevhJV0R1+Q3Z7
         6uLdq8kyMosApb8i/K3elMZNNb8RdflK81Zf5V5fLnwvRXIcEAna+NuYqj+6Do7pxwMN
         OEgTHcqPIooezmI1MO0ZjKu/ncDTMbyt6fJTYY0vtTgI1VsZLsK4rSgpk6mW0u/68/9C
         G1c4ZlCxncgWkLnGlzQMB/XRDBRwlw7TTlQ0Ya3pTt6cgMh6LGRm70VgBHC/DWGYKbEg
         xCBR5nXeYf0TyJ6f4RNQsyFnhwD8HLMS2HCBeM5vqisn5d1uGYbaRIIMnUkAgfJkPMSa
         kD4g==
X-Gm-Message-State: AOAM532l0XupfYyOSYwmqomwgI3JFUMt4/LfN+wnP91atAwzsyWw/+cf
        SJcMYrk6S1uC4+I0twE6CaK3qzVboGa59Pgmz0A=
X-Google-Smtp-Source: ABdhPJzG76M5wdheyjOk+cbnhKZ/LTUItQR589njdDqxoD/D453M6HFUTfNY6sLWTIL5D9Bq0qda/XJf19hUOWcX8/0=
X-Received: by 2002:a17:907:8a05:: with SMTP id sc5mr14934095ejc.316.1643590887228;
 Sun, 30 Jan 2022 17:01:27 -0800 (PST)
MIME-Version: 1.0
References: <20220128223603.2362621-1-aford173@gmail.com> <TYBPR01MB53418BE9FC9E11B901DF561DD8259@TYBPR01MB5341.jpnprd01.prod.outlook.com>
In-Reply-To: <TYBPR01MB53418BE9FC9E11B901DF561DD8259@TYBPR01MB5341.jpnprd01.prod.outlook.com>
From:   Adam Ford <aford173@gmail.com>
Date:   Sun, 30 Jan 2022 19:01:16 -0600
Message-ID: <CAHCN7xJ491qfvkZCY6iSSXFNXbFdKnN6RUhb5df2x3P8oeQ0qQ@mail.gmail.com>
Subject: Re: [PATCH] usb: gadget: udc: renesas_usb3: Fix host to USB_ROLE_NONE transition
To:     Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
Cc:     "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "linux-renesas-soc@vger.kernel.org" 
        <linux-renesas-soc@vger.kernel.org>,
        "cstevens@beaconembedded.com" <cstevens@beaconembedded.com>,
        "aford@beaconembedded.com" <aford@beaconembedded.com>,
        Felipe Balbi <balbi@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Biju Das <biju.das@bp.renesas.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jan 30, 2022 at 6:23 PM Yoshihiro Shimoda
<yoshihiro.shimoda.uh@renesas.com> wrote:
>
> Hi Adam-san,
>
> Thank you for the patch!
>
> > From: Adam Ford, Sent: Saturday, January 29, 2022 7:36 AM
> >
> > The support the external role switch a variety of situations were
> > addressed, but the transition from USB_ROLE_HOST to USB_ROLE_NONE
> > leaves the host up which can cause some error messages when
> > switching from host to none, to gadget, to none, and then back
> > to host again.
>
> I think so. An external role switch in this driver is possible to
> enter the role to USB_ROLE_NONE. (Just a record for me: in other words,
> the "internal" role switch didn't enter the role to USB_ROLE_NONE.)
>
> >  xhci-hcd ee000000.usb: Abort failed to stop command ring: -110
> >  xhci-hcd ee000000.usb: xHCI host controller not responding, assume dead
> >  xhci-hcd ee000000.usb: HC died; cleaning up
> >  usb 4-1: device not accepting address 6, error -108
> >  usb usb4-port1: couldn't allocate usb_device
> >
> > After this happens it will not act as a host again.
> > Fix this by releasing the host mode when transitioning to USB_ROLE_NONE.
> >
> > Fixes: 0604160d8c0b ("usb: gadget: udc: renesas_usb3: Enhance role switch support")
> > Signed-off-by: Adam Ford <aford173@gmail.com>
> >
> > diff --git a/drivers/usb/gadget/udc/renesas_usb3.c b/drivers/usb/gadget/udc/renesas_usb3.c
> > index 57d417a7c3e0..601829a6b4ba 100644
> > --- a/drivers/usb/gadget/udc/renesas_usb3.c
> > +++ b/drivers/usb/gadget/udc/renesas_usb3.c
> > @@ -2378,6 +2378,8 @@ static void handle_ext_role_switch_states(struct device *dev,
> >       switch (role) {
> >       case USB_ROLE_NONE:
> >               usb3->connection_state = USB_ROLE_NONE;
> > +             if (cur_role == USB_ROLE_HOST)
> > +                     device_release_driver(host);
>
> The handle_ext_role_switch_states() with role = USB_ROLE_NONE seems
> to be called multiple times. So, we have to avoid multiple calling of
> device_release_driver() somehow.

From what I can tell, it appears that device_release_driver ultimately
calls __device_release_driver which checks for a NULL, and during the
release sets it to NULL, so subsequent releases should just get
ignored.  Maybe I am missing something.

adam
>
> Best regards,
> Yoshihiro Shimoda
>
> >               if (usb3->driver)
> >                       usb3_disconnect(usb3);
> >               usb3_vbus_out(usb3, false);
> > --
> > 2.32.0
>
