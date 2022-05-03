Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 74E65518886
	for <lists+linux-kernel@lfdr.de>; Tue,  3 May 2022 17:27:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238484AbiECPbD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 May 2022 11:31:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41512 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238451AbiECPaz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 May 2022 11:30:55 -0400
Received: from mail-qt1-f182.google.com (mail-qt1-f182.google.com [209.85.160.182])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3540825E94;
        Tue,  3 May 2022 08:27:22 -0700 (PDT)
Received: by mail-qt1-f182.google.com with SMTP id fu47so13671858qtb.5;
        Tue, 03 May 2022 08:27:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=KTaY5qW8ijHItpwiQrjyZtLK9UVGGZLKbTPeV/f2e4M=;
        b=F4d8PlZ9kUChsFbwuWexjT/w/DdnxBgrR2gWlzi3utzaOtq6VTOmoQzZFVmEqUA4ZG
         cxmDt9p5pNl/aQ0J6hxPMJneuOkW2iFrDRsyPAOhEVMcoAvaP5dB4pMUk4BTU8i88W04
         v/Ipn5A147XE1vMj9ccc0u5y7kWDQ4W8OcECeht47PtBrqwQOlfhfTZBC802NYcAOGe7
         eEja4/9jEFmaZBJ88/1eTaqR3SOrmb3eM2kfptUpfSivmcOvQHsPnA8W4lEGxj7sF3Ax
         0QxEnmdm2peGONQgsAzwVX5nVjSO7SnPswb043feJ44RlFo/elYnS+MZrclSiZNWciIv
         XiGA==
X-Gm-Message-State: AOAM531KevaRegLSwwig3TM5+WkMLIbiIlHU2vh8omTfbcRUomlOVQcj
        rr1kgUq60BZne6ZNpsmsf2Rjig8N3yFrDw==
X-Google-Smtp-Source: ABdhPJywZDspUpMkDpLIbuzbvXowmG5FZup/eYZbKcDpA8hFFb+YUkPADY0H8vLVccId5DDtAgRflw==
X-Received: by 2002:a05:622a:1c9:b0:2f3:a2cc:b7d6 with SMTP id t9-20020a05622a01c900b002f3a2ccb7d6mr10263209qtw.101.1651591641129;
        Tue, 03 May 2022 08:27:21 -0700 (PDT)
Received: from mail-yw1-f170.google.com (mail-yw1-f170.google.com. [209.85.128.170])
        by smtp.gmail.com with ESMTPSA id h81-20020a379e54000000b0069fe1fc72e7sm3673370qke.90.2022.05.03.08.27.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 03 May 2022 08:27:20 -0700 (PDT)
Received: by mail-yw1-f170.google.com with SMTP id 00721157ae682-2f83983782fso183713207b3.6;
        Tue, 03 May 2022 08:27:20 -0700 (PDT)
X-Received: by 2002:a81:6588:0:b0:2f8:b75e:1e1a with SMTP id
 z130-20020a816588000000b002f8b75e1e1amr16065257ywb.358.1651591640492; Tue, 03
 May 2022 08:27:20 -0700 (PDT)
MIME-Version: 1.0
References: <YjeEbHL8ITkW692W@rowland.harvard.edu> <YmKt3kH+85kjzdbL@kroah.com>
 <YmSc29YZvxgT5fEJ@rowland.harvard.edu> <YmSo6fU1FlNq8cOZ@rowland.harvard.edu>
 <YmSpKpnWR8WWEk/p@rowland.harvard.edu> <YmSpdxaDNeC2BBOf@rowland.harvard.edu>
 <alpine.DEB.2.22.394.2205031209030.681336@ramsan.of.borg> <YnFCEn45XwDWM/9Y@rowland.harvard.edu>
In-Reply-To: <YnFCEn45XwDWM/9Y@rowland.harvard.edu>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Tue, 3 May 2022 17:27:08 +0200
X-Gmail-Original-Message-ID: <CAMuHMdVDK0W0T3=+2c1E6wtwy5JTUemTGYyj3PFuVUhK++AzrA@mail.gmail.com>
Message-ID: <CAMuHMdVDK0W0T3=+2c1E6wtwy5JTUemTGYyj3PFuVUhK++AzrA@mail.gmail.com>
Subject: Re: [PATCH 4/4] USB: gadget: Add a new bus for gadgets
To:     Alan Stern <stern@rowland.harvard.edu>
Cc:     Felipe Balbi <balbi@kernel.org>,
        Greg KH <gregkh@linuxfoundation.org>,
        USB mailing list <linux-usb@vger.kernel.org>,
        Linux-Renesas <linux-renesas-soc@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Alan,

On Tue, May 3, 2022 at 5:14 PM Alan Stern <stern@rowland.harvard.edu> wrote:
> On Tue, May 03, 2022 at 12:14:30PM +0200, Geert Uytterhoeven wrote:
> > On Sat, 23 Apr 2022, Alan Stern wrote:
> > > This patch adds a "gadget" bus and uses it for registering gadgets and
> > > their drivers.  From now on, bindings will be managed by the driver
> > > core rather than through ad-hoc manipulations in the UDC core.
> > >
> > > As part of this change, the driver_pending_list is removed.  The UDC
> > > core won't need to keep track of unbound drivers for later binding,
> > > because the driver core handles all of that for us.
> > >
> > > However, we do need one new feature: a way to prevent gadget drivers
> > > from being bound to more than one gadget at a time.  The existing code
> > > does this automatically, but the driver core doesn't -- it's perfectly
> > > happy to bind a single driver to all the matching devices on the bus.
> > > The patch adds a new bitflag to the usb_gadget_driver structure for
> > > this purpose.
> > >
> > > A nice side effect of this change is a reduction in the total lines of
> > > code, since now the driver core will do part of the work that the UDC
> > > used to do.
> > >
> > > A possible future patch could add udc devices to the gadget bus, say
> > > as a separate device type.
> > >
> > > Signed-off-by: Alan Stern <stern@rowland.harvard.edu>
> >
> > Thanks for your patch, which is now commit fc274c1e997314bf ("USB:
> > gadget: Add a new bus for gadgets") in usb-next.
> >
> > This patch cause a regression on the Renesas Salvator-XS development
> > board, as R-Car H3 has multiple USB gadget devices:
>
> Then these gadgets ought to have distinct names in order to avoid the
> conflict below:
>
> >     sysfs: cannot create duplicate filename '/bus/gadget/devices/gadget'
> >     CPU: 2 PID: 1 Comm: swapper/0 Not tainted 5.18.0-rc1-arm64-renesas-00074-gfc274c1e9973 #1587
> >     Hardware name: Renesas Salvator-X 2nd version board based on r8a77951 (DT)
> >     Call trace:
> >      dump_backtrace+0xcc/0xd8
> >      show_stack+0x14/0x30
> >      dump_stack_lvl+0x88/0xb0
> >      dump_stack+0x14/0x2c
> >      sysfs_warn_dup+0x60/0x78
> >      sysfs_do_create_link_sd.isra.0+0xe4/0xf0
> >      sysfs_create_link+0x20/0x40
> >      bus_add_device+0x64/0x110
> >      device_add+0x31c/0x850
> >      usb_add_gadget+0x124/0x1a0
> >      usb_add_gadget_udc_release+0x1c/0x50
> >      usb_add_gadget_udc+0x10/0x18
> >      renesas_usb3_probe+0x450/0x728
> ...
>
> Having three gadget devices, all named "gadget", doesn't seem like a
> good idea.

I'm not so sure where these names are coming from.
`git grep '"gadget"'` points to the following likely targets:

drivers/usb/gadget/udc/core.c:  dev_set_name(&gadget->dev, "gadget");
drivers/usb/renesas_usbhs/mod_gadget.c: gpriv->mod.name         = "gadget";

Changing both names reveals the problem is actually caused by
the former ;-)

> This doesn't seem like it should be too hard to fix, although I'm not
> at all familiar with the renesas-usb3 driver.  Do you know who maintains
> that driver?  Is it you?

Adding Shimoda-san to CC (but he's enjoying Golden Week).

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
