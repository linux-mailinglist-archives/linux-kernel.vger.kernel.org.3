Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ABD2351821E
	for <lists+linux-kernel@lfdr.de>; Tue,  3 May 2022 12:14:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233924AbiECKSJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 May 2022 06:18:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35406 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233116AbiECKSH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 May 2022 06:18:07 -0400
Received: from albert.telenet-ops.be (albert.telenet-ops.be [IPv6:2a02:1800:110:4::f00:1a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A3A001EC56
        for <linux-kernel@vger.kernel.org>; Tue,  3 May 2022 03:14:34 -0700 (PDT)
Received: from ramsan.of.borg ([IPv6:2a02:1810:ac12:ed40:cd2b:85eb:bdf:a9c3])
        by albert.telenet-ops.be with bizsmtp
        id SAEX270023SeZYW06AEXpV; Tue, 03 May 2022 12:14:31 +0200
Received: from geert (helo=localhost)
        by ramsan.of.borg with local-esmtp (Exim 4.93)
        (envelope-from <geert@linux-m68k.org>)
        id 1nlpY6-002rGb-P5; Tue, 03 May 2022 12:14:30 +0200
Date:   Tue, 3 May 2022 12:14:30 +0200 (CEST)
From:   Geert Uytterhoeven <geert@linux-m68k.org>
X-X-Sender: geert@ramsan.of.borg
To:     Alan Stern <stern@rowland.harvard.edu>
cc:     Felipe Balbi <balbi@kernel.org>,
        Greg KH <gregkh@linuxfoundation.org>,
        USB mailing list <linux-usb@vger.kernel.org>,
        linux-renesas-soc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 4/4] USB: gadget: Add a new bus for gadgets
In-Reply-To: <YmSpdxaDNeC2BBOf@rowland.harvard.edu>
Message-ID: <alpine.DEB.2.22.394.2205031209030.681336@ramsan.of.borg>
References: <YjeEbHL8ITkW692W@rowland.harvard.edu> <YmKt3kH+85kjzdbL@kroah.com> <YmSc29YZvxgT5fEJ@rowland.harvard.edu> <YmSo6fU1FlNq8cOZ@rowland.harvard.edu> <YmSpKpnWR8WWEk/p@rowland.harvard.edu> <YmSpdxaDNeC2BBOf@rowland.harvard.edu>
User-Agent: Alpine 2.22 (DEB 394 2020-01-19)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

 	Hi Alan,

On Sat, 23 Apr 2022, Alan Stern wrote:
> This patch adds a "gadget" bus and uses it for registering gadgets and
> their drivers.  From now on, bindings will be managed by the driver
> core rather than through ad-hoc manipulations in the UDC core.
>
> As part of this change, the driver_pending_list is removed.  The UDC
> core won't need to keep track of unbound drivers for later binding,
> because the driver core handles all of that for us.
>
> However, we do need one new feature: a way to prevent gadget drivers
> from being bound to more than one gadget at a time.  The existing code
> does this automatically, but the driver core doesn't -- it's perfectly
> happy to bind a single driver to all the matching devices on the bus.
> The patch adds a new bitflag to the usb_gadget_driver structure for
> this purpose.
>
> A nice side effect of this change is a reduction in the total lines of
> code, since now the driver core will do part of the work that the UDC
> used to do.
>
> A possible future patch could add udc devices to the gadget bus, say
> as a separate device type.
>
> Signed-off-by: Alan Stern <stern@rowland.harvard.edu>

Thanks for your patch, which is now commit fc274c1e997314bf ("USB:
gadget: Add a new bus for gadgets") in usb-next.

This patch cause a regression on the Renesas Salvator-XS development
board, as R-Car H3 has multiple USB gadget devices:

     sysfs: cannot create duplicate filename '/bus/gadget/devices/gadget'
     CPU: 2 PID: 1 Comm: swapper/0 Not tainted 5.18.0-rc1-arm64-renesas-00074-gfc274c1e9973 #1587
     Hardware name: Renesas Salvator-X 2nd version board based on r8a77951 (DT)
     Call trace:
      dump_backtrace+0xcc/0xd8
      show_stack+0x14/0x30
      dump_stack_lvl+0x88/0xb0
      dump_stack+0x14/0x2c
      sysfs_warn_dup+0x60/0x78
      sysfs_do_create_link_sd.isra.0+0xe4/0xf0
      sysfs_create_link+0x20/0x40
      bus_add_device+0x64/0x110
      device_add+0x31c/0x850
      usb_add_gadget+0x124/0x1a0
      usb_add_gadget_udc_release+0x1c/0x50
      usb_add_gadget_udc+0x10/0x18
      renesas_usb3_probe+0x450/0x728
      platform_probe+0x64/0xd0
      really_probe+0x100/0x2a0
      __driver_probe_device+0x74/0xd8
      driver_probe_device+0x3c/0xe0
      __driver_attach+0x80/0x110
      bus_for_each_dev+0x6c/0xc0
      driver_attach+0x20/0x28
      bus_add_driver+0x138/0x1e0
      driver_register+0x60/0x110
      __platform_driver_register+0x24/0x30
      renesas_usb3_driver_init+0x18/0x20
      do_one_initcall+0x15c/0x31c
      kernel_init_freeable+0x2f0/0x354
      kernel_init+0x20/0x120
      ret_from_fork+0x10/0x20
     renesas_usb3: probe of ee020000.usb failed with error -17
     ...
     renesas_usbhs: probe of e6590000.usb failed with error -17

After boot-up, only one gadget device is visible:

     root@h3-salvator-xs:~# ls -l /sys/bus/gadget/devices/
     total 0
     lrwxrwxrwx 1 root root 0 Feb 14  2019 gadget -> ../../../devices/platform/soc/e659c000.usb/gadget
     root@h3-salvator-xs:~#

Reverting this patch fixes the issue.

Gr{oetje,eeting}s,

 						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
 							    -- Linus Torvalds
