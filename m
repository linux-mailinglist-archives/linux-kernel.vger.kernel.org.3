Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D23FA509F11
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Apr 2022 13:55:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354520AbiDUL5V (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Apr 2022 07:57:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41938 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230044AbiDUL5R (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Apr 2022 07:57:17 -0400
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com [IPv6:2a00:1450:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0ECD22E690;
        Thu, 21 Apr 2022 04:54:28 -0700 (PDT)
Received: by mail-ej1-x62f.google.com with SMTP id lc2so9458209ejb.12;
        Thu, 21 Apr 2022 04:54:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=0DDzJn9dwy6iRA1ptiaHLy+Z13fMErKSI6cEup7orYQ=;
        b=nTCs8/lVqO9JNaUDe6n1TeJ3r1YGN+/THNsa2TxgsPLGiObxiuBKXTjbyBJsVwORKv
         wR+tefxOeWwvW8DzToxht90zkSC76/GFlQD4/KBJ0vh1fORneaO21UwCqGaDClSsWuVe
         Y6/UGj7eyLg6kWoeX0WnebZ5+wPTivRoi+BpRAuYAB6SbanKxoKD9Y1pkJ45gXYNLjLm
         OpJutZRnB7bJhoZ7/sWi0YCYg0z1u143hqxAKlM//z6rHADb+McGv9ZubXNyQtbrEGc8
         9vmX+5+POEC9t3Rnc/gs4J8ydzYLHiPnTJXdQF+mCmm898hKfaOA34zuklWA92mmhYJT
         IBsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=0DDzJn9dwy6iRA1ptiaHLy+Z13fMErKSI6cEup7orYQ=;
        b=aCjJ95cyFcQ8auoAN4Am2DnL/+j4BhcqiyiIodURtc4xAIAEeMhQ6fBlulN+pKWnIQ
         K6Y1GWxABkbfUx9y0JMynHg1MUP69J9lKcFjoeS/oBdjO+txZaAqddk8nYsGEBO7WRwm
         Sxj2rryU590ql7dPZvTi+3vNLA9u7X9TOR5lqN1JeAzFwhKJkj4JgwxNik+8oZJmp3ZT
         1tPayHnm7dBj4EEi+ymnFLUMfqNK3Cv70Y4Cdis+mPatQ2A6MtsM1UAP6M6uNQcVFsJC
         vEomyT1R5Gf/4qIXVziNxPLRdq69Gh+b/Fq5TAdUMtCVJv+5UH/pCeTe9vY8dOMRClle
         8q5w==
X-Gm-Message-State: AOAM53205OArwqoK0sgUAiG8mUa35tMiO5JwuOQgmIsDGZ3vguPITUkg
        A5oDugFdPf0w65Ertg+sTjChQrcjEFj70DT3Ra0=
X-Google-Smtp-Source: ABdhPJyNmkwYSj+FO8ES8Jpx7ks0wQQHThabVQT7Jsm09lmVrOrNojpEErJNnkDp4wkhyYEm9gTUwmOjyRJvwVEM0T0=
X-Received: by 2002:a17:907:3d91:b0:6df:a01c:f7cd with SMTP id
 he17-20020a1709073d9100b006dfa01cf7cdmr22511350ejc.255.1650542066467; Thu, 21
 Apr 2022 04:54:26 -0700 (PDT)
MIME-Version: 1.0
References: <20220421094236.1052170-1-r33s3n6@gmail.com> <YmEs6BqcyM7fgLXg@kroah.com>
In-Reply-To: <YmEs6BqcyM7fgLXg@kroah.com>
From:   Fu Zixuan <r33s3n6@gmail.com>
Date:   Thu, 21 Apr 2022 19:55:28 +0800
Message-ID: <CAMvdLANp4jHnySOmpjXZdFwruLdvN9qR-B_Ew9_zeCiKYiLZSA@mail.gmail.com>
Subject: Re: [PATCH] drivers: usb: host: fix NULL pointer dereferences
 triggered by unhandled errors in xhci_create_rhub_port_array()
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     mathias.nyman@intel.com, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org, baijiaju1990@gmail.com,
        TOTE Robot <oslab@tsinghua.edu.cn>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 21 Apr 2022 at 18:07, Greg KH <gregkh@linuxfoundation.org> wrote:
>
> On Thu, Apr 21, 2022 at 05:42:36PM +0800, Zixuan Fu wrote:
> > In xhci_create_rhub_port_array(), when rhub->num_ports is zero,
> > rhub->ports would not be set; when kcalloc_node() fails, rhub->ports
> > would be set to NULL. In these two cases, xhci_create_rhub_port_array()
> > just returns void, and thus its callers are unaware of the error.
> >
> > Then rhub->ports is dereferenced in xhci_usb3_hub_descriptor() or
> > xhci_usb2_hub_descriptor().
> >
> > To fix the bug, xhci_setup_port_arrays() should return an integer to
> > indicate a possible error, and its callers should handle the error.
> >
> > Here is the log when this bug occurred in our fault-injection testing:
> >
> > [   24.001309] BUG: kernel NULL pointer dereference, address: 0000000000000000
> > ...
> > [   24.003992] RIP: 0010:xhci_hub_control+0x3f5/0x60d0 [xhci_hcd]
> > ...
> > [   24.009803] Call Trace:
> > [   24.010014]  <TASK>
> > [   24.011310]  usb_hcd_submit_urb+0x1233/0x1fd0
> > [   24.017071]  usb_start_wait_urb+0x115/0x310
> > [   24.017641]  usb_control_msg+0x28a/0x450
> > [   24.019046]  hub_probe+0xb16/0x2320
> > [   24.019757]  usb_probe_interface+0x4f1/0x930
> > [   24.019765]  really_probe+0x33d/0x970
> > [   24.019768]  __driver_probe_device+0x157/0x210
> > [   24.019772]  driver_probe_device+0x4f/0x340
> > [   24.019775]  __device_attach_driver+0x2ee/0x3a0
> > ...
> >
> > Reported-by: TOTE Robot <oslab@tsinghua.edu.cn>
> > Signed-off-by: Zixuan Fu <r33s3n6@gmail.com>
> > ---
> >  drivers/usb/host/xhci-mem.c | 17 ++++++++++++-----
> >  1 file changed, 12 insertions(+), 5 deletions(-)
> >
> > diff --git a/drivers/usb/host/xhci-mem.c b/drivers/usb/host/xhci-mem.c
> > index bbb27ee2c6a3..024515346c39 100644
> > --- a/drivers/usb/host/xhci-mem.c
> > +++ b/drivers/usb/host/xhci-mem.c
> > @@ -2235,7 +2235,7 @@ static void xhci_add_in_port(struct xhci_hcd *xhci, unsigned int num_ports,
> >       /* FIXME: Should we disable ports not in the Extended Capabilities? */
> >  }
> >
> > -static void xhci_create_rhub_port_array(struct xhci_hcd *xhci,
> > +static int xhci_create_rhub_port_array(struct xhci_hcd *xhci,
> >                                       struct xhci_hub *rhub, gfp_t flags)
> >  {
> >       int port_index = 0;
> > @@ -2243,11 +2243,11 @@ static void xhci_create_rhub_port_array(struct xhci_hcd *xhci,
> >       struct device *dev = xhci_to_hcd(xhci)->self.sysdev;
> >
> >       if (!rhub->num_ports)
> > -             return;
> > +             return -EINVAL;
> >       rhub->ports = kcalloc_node(rhub->num_ports, sizeof(*rhub->ports),
> >                       flags, dev_to_node(dev));
> >       if (!rhub->ports)
> > -             return;
> > +             return -ENOMEM;
> >
> >       for (i = 0; i < HCS_MAX_PORTS(xhci->hcs_params1); i++) {
> >               if (xhci->hw_ports[i].rhub != rhub ||
> > @@ -2259,6 +2259,7 @@ static void xhci_create_rhub_port_array(struct xhci_hcd *xhci,
> >               if (port_index == rhub->num_ports)
> >                       break;
> >       }
> > +     return 0;
> >  }
> >
> >  /*
> > @@ -2277,6 +2278,7 @@ static int xhci_setup_port_arrays(struct xhci_hcd *xhci, gfp_t flags)
> >       int cap_count = 0;
> >       u32 cap_start;
> >       struct device *dev = xhci_to_hcd(xhci)->self.sysdev;
> > +     int ret;
> >
> >       num_ports = HCS_MAX_PORTS(xhci->hcs_params1);
> >       xhci->hw_ports = kcalloc_node(num_ports, sizeof(*xhci->hw_ports),
> > @@ -2367,8 +2369,13 @@ static int xhci_setup_port_arrays(struct xhci_hcd *xhci, gfp_t flags)
> >        * Not sure how the USB core will handle a hub with no ports...
> >        */
> >
> > -     xhci_create_rhub_port_array(xhci, &xhci->usb2_rhub, flags);
> > -     xhci_create_rhub_port_array(xhci, &xhci->usb3_rhub, flags);
> > +     ret = xhci_create_rhub_port_array(xhci, &xhci->usb2_rhub, flags);
> > +     if (ret)
> > +             return ret;
> > +
> > +     ret = xhci_create_rhub_port_array(xhci, &xhci->usb3_rhub, flags);
> > +     if (ret)
> > +             return ret;
>
> What about the memory allocated by the first call to
> xhci_create_rhub_port_array()?  Is that now lost?  Same for everything
> else allocated before these calls, how is that cleaned up properly?
>
> thanks,
>
> greg k-h

Thanks for your swift reply. We understand your concern. In fact, we have
checked the related code carefully and found that xhci_create_rhub_port_array()
is only used in xhci_setup_port_arrays(). Moreover, only xhci_mem_init() calls
xhci_setup_port_arrays() and does all cleanup work when it fails. Specifically,
xhci_mem_init() calls xhci_mem_cleanup(), which eventually called
kfree(xhci->usb2_rhub.ports) and kfree(xhci->usb3_rhub.ports).

Thanks,

Zixuan Fu
