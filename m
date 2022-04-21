Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AF181509F84
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Apr 2022 14:20:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1383829AbiDUMXD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Apr 2022 08:23:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60860 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1383805AbiDUMW4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Apr 2022 08:22:56 -0400
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com [IPv6:2a00:1450:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0911CBCB8;
        Thu, 21 Apr 2022 05:20:07 -0700 (PDT)
Received: by mail-ej1-x630.google.com with SMTP id r13so9663493ejd.5;
        Thu, 21 Apr 2022 05:20:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=CxlyVsgZL3AxNiJHWyBQrkItp0FP2CX+DnsKzRAeJgI=;
        b=EI0pFGruT33m/Kewoj/hIJzLzvi651eJq5WZH7Ezl2qCdSjKVdL7Thl33BNdeIS3bI
         iLqEMxl5J0iJKJoTPhlbAgIrQBQ0plBsrauQF/fkIa1akHf7Jk/fvp7YXc38vfRGlvSl
         +T3oew5yzBr4MQYK0qjkXmM0Bstn5qnUys18eYR6iJMJ7JxsXe2RfaksJTnl9F5Ui8Zn
         FpYb5sr5QoSywS+xBSR6uvyhF0ooQ5DphZeRMtv0HEWgRI0KxvC6iPOYBfFQ9snqpau1
         0Ir2+IknNSFoo1uVHaR3LlH8MhD4uRnWUy2P7saUbOeKVsJ7MorWuIAwt5A6tTfJzYRN
         m8aA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=CxlyVsgZL3AxNiJHWyBQrkItp0FP2CX+DnsKzRAeJgI=;
        b=l8aWqjDjhm5H7XCp0Pdq2mULyQr09JlMCpho+mors8CdcjEm+GbQVntvThmMvSZDFT
         JMY4oqGsAHLgGC+Z07gYvz4atQqPUQ7ZGy9OibDyW1G9hdE2FGjqYuIup8ZwVpdjGIoa
         ByqjBQ6GYKxElmeX7rHOZaw9ci6E7ynNge4fhOUdrBckHn3eEbaFMtGJR/5Y7of0oCEo
         n3PpOC8EogcNC3EBWaCgIWB+YfQTnWAXJo+14Tp4noJl4hq7l4VB730zMZYrARQwzeaH
         jXZRDj/o0IQuMpqioRqvJ5lhebSfDStfJUYtX32tt0Y4rK4EiZJAjXwA7wsDL0L+ughl
         cz5Q==
X-Gm-Message-State: AOAM5333CDYoE9GlspV7Ii5N+YVuZ4c6/YwhSWjU3EgihzF+AzWxwqW6
        TDw0rFQhEXCwdGTCDOIjXUU5IPdOF2ib7lsbziY=
X-Google-Smtp-Source: ABdhPJw9cMc7AJXhQVeYqONilvzQqwKKDcikI610x1DPMaVZnjhGl01pbo2p49fLYoLuCLjzhqzs4gZxYaM+VNP5O+E=
X-Received: by 2002:a17:906:9c84:b0:6e0:7c75:6f01 with SMTP id
 fj4-20020a1709069c8400b006e07c756f01mr22623677ejc.103.1650543605370; Thu, 21
 Apr 2022 05:20:05 -0700 (PDT)
MIME-Version: 1.0
References: <20220421094236.1052170-1-r33s3n6@gmail.com> <YmEs6BqcyM7fgLXg@kroah.com>
 <CAMvdLANp4jHnySOmpjXZdFwruLdvN9qR-B_Ew9_zeCiKYiLZSA@mail.gmail.com> <YmFIqPeGQYKl33vh@kroah.com>
In-Reply-To: <YmFIqPeGQYKl33vh@kroah.com>
From:   Fu Zixuan <r33s3n6@gmail.com>
Date:   Thu, 21 Apr 2022 20:21:07 +0800
Message-ID: <CAMvdLANGW35m0-mg_00wM2FPivmk-wVfqE379iNjE=gFL3u-5A@mail.gmail.com>
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

On Thu, 21 Apr 2022 at 20:06, Greg KH <gregkh@linuxfoundation.org> wrote:
>
> On Thu, Apr 21, 2022 at 07:55:28PM +0800, Fu Zixuan wrote:
> > On Thu, 21 Apr 2022 at 18:07, Greg KH <gregkh@linuxfoundation.org> wrote:
> > >
> > > On Thu, Apr 21, 2022 at 05:42:36PM +0800, Zixuan Fu wrote:
> > > > In xhci_create_rhub_port_array(), when rhub->num_ports is zero,
> > > > rhub->ports would not be set; when kcalloc_node() fails, rhub->ports
> > > > would be set to NULL. In these two cases, xhci_create_rhub_port_array()
> > > > just returns void, and thus its callers are unaware of the error.
> > > >
> > > > Then rhub->ports is dereferenced in xhci_usb3_hub_descriptor() or
> > > > xhci_usb2_hub_descriptor().
> > > >
> > > > To fix the bug, xhci_setup_port_arrays() should return an integer to
> > > > indicate a possible error, and its callers should handle the error.
> > > >
> > > > Here is the log when this bug occurred in our fault-injection testing:
> > > >
> > > > [   24.001309] BUG: kernel NULL pointer dereference, address: 0000000000000000
> > > > ...
> > > > [   24.003992] RIP: 0010:xhci_hub_control+0x3f5/0x60d0 [xhci_hcd]
> > > > ...
> > > > [   24.009803] Call Trace:
> > > > [   24.010014]  <TASK>
> > > > [   24.011310]  usb_hcd_submit_urb+0x1233/0x1fd0
> > > > [   24.017071]  usb_start_wait_urb+0x115/0x310
> > > > [   24.017641]  usb_control_msg+0x28a/0x450
> > > > [   24.019046]  hub_probe+0xb16/0x2320
> > > > [   24.019757]  usb_probe_interface+0x4f1/0x930
> > > > [   24.019765]  really_probe+0x33d/0x970
> > > > [   24.019768]  __driver_probe_device+0x157/0x210
> > > > [   24.019772]  driver_probe_device+0x4f/0x340
> > > > [   24.019775]  __device_attach_driver+0x2ee/0x3a0
> > > > ...
> > > >
> > > > Reported-by: TOTE Robot <oslab@tsinghua.edu.cn>
> > > > Signed-off-by: Zixuan Fu <r33s3n6@gmail.com>
> > > > ---
> > > >  drivers/usb/host/xhci-mem.c | 17 ++++++++++++-----
> > > >  1 file changed, 12 insertions(+), 5 deletions(-)
> > > >
> > > > diff --git a/drivers/usb/host/xhci-mem.c b/drivers/usb/host/xhci-mem.c
> > > > index bbb27ee2c6a3..024515346c39 100644
> > > > --- a/drivers/usb/host/xhci-mem.c
> > > > +++ b/drivers/usb/host/xhci-mem.c
> > > > @@ -2235,7 +2235,7 @@ static void xhci_add_in_port(struct xhci_hcd *xhci, unsigned int num_ports,
> > > >       /* FIXME: Should we disable ports not in the Extended Capabilities? */
> > > >  }
> > > >
> > > > -static void xhci_create_rhub_port_array(struct xhci_hcd *xhci,
> > > > +static int xhci_create_rhub_port_array(struct xhci_hcd *xhci,
> > > >                                       struct xhci_hub *rhub, gfp_t flags)
> > > >  {
> > > >       int port_index = 0;
> > > > @@ -2243,11 +2243,11 @@ static void xhci_create_rhub_port_array(struct xhci_hcd *xhci,
> > > >       struct device *dev = xhci_to_hcd(xhci)->self.sysdev;
> > > >
> > > >       if (!rhub->num_ports)
> > > > -             return;
> > > > +             return -EINVAL;
> > > >       rhub->ports = kcalloc_node(rhub->num_ports, sizeof(*rhub->ports),
> > > >                       flags, dev_to_node(dev));
> > > >       if (!rhub->ports)
> > > > -             return;
> > > > +             return -ENOMEM;
> > > >
> > > >       for (i = 0; i < HCS_MAX_PORTS(xhci->hcs_params1); i++) {
> > > >               if (xhci->hw_ports[i].rhub != rhub ||
> > > > @@ -2259,6 +2259,7 @@ static void xhci_create_rhub_port_array(struct xhci_hcd *xhci,
> > > >               if (port_index == rhub->num_ports)
> > > >                       break;
> > > >       }
> > > > +     return 0;
> > > >  }
> > > >
> > > >  /*
> > > > @@ -2277,6 +2278,7 @@ static int xhci_setup_port_arrays(struct xhci_hcd *xhci, gfp_t flags)
> > > >       int cap_count = 0;
> > > >       u32 cap_start;
> > > >       struct device *dev = xhci_to_hcd(xhci)->self.sysdev;
> > > > +     int ret;
> > > >
> > > >       num_ports = HCS_MAX_PORTS(xhci->hcs_params1);
> > > >       xhci->hw_ports = kcalloc_node(num_ports, sizeof(*xhci->hw_ports),
> > > > @@ -2367,8 +2369,13 @@ static int xhci_setup_port_arrays(struct xhci_hcd *xhci, gfp_t flags)
> > > >        * Not sure how the USB core will handle a hub with no ports...
> > > >        */
> > > >
> > > > -     xhci_create_rhub_port_array(xhci, &xhci->usb2_rhub, flags);
> > > > -     xhci_create_rhub_port_array(xhci, &xhci->usb3_rhub, flags);
> > > > +     ret = xhci_create_rhub_port_array(xhci, &xhci->usb2_rhub, flags);
> > > > +     if (ret)
> > > > +             return ret;
> > > > +
> > > > +     ret = xhci_create_rhub_port_array(xhci, &xhci->usb3_rhub, flags);
> > > > +     if (ret)
> > > > +             return ret;
> > >
> > > What about the memory allocated by the first call to
> > > xhci_create_rhub_port_array()?  Is that now lost?  Same for everything
> > > else allocated before these calls, how is that cleaned up properly?
> > >
> > > thanks,
> > >
> > > greg k-h
> >
> > Thanks for your swift reply. We understand your concern. In fact, we have
> > checked the related code carefully and found that xhci_create_rhub_port_array()
> > is only used in xhci_setup_port_arrays(). Moreover, only xhci_mem_init() calls
> > xhci_setup_port_arrays() and does all cleanup work when it fails. Specifically,
> > xhci_mem_init() calls xhci_mem_cleanup(), which eventually called
> > kfree(xhci->usb2_rhub.ports) and kfree(xhci->usb3_rhub.ports).
>
> Great, can you mention this in the changelog text to show that you have
> thought this through and it can be documented as such?
>
> thanks,
>
> greg k-h

Thanks for your reply! We will do that and submit the patch v2 soon.

Thanks,

Zixuan Fu
