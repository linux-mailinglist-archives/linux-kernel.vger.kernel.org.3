Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B41185955DC
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Aug 2022 11:05:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233469AbiHPJE4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 Aug 2022 05:04:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53176 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229845AbiHPJD7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Aug 2022 05:03:59 -0400
Received: from mx1.tq-group.com (mx1.tq-group.com [93.104.207.81])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6FBA674DFB;
        Tue, 16 Aug 2022 00:17:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=tq-group.com; i=@tq-group.com; q=dns/txt; s=key1;
  t=1660634269; x=1692170269;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=7PvK1XUJcZYZO1YG4EHtQpi5gl6ePBLQ14O333RXE6M=;
  b=eNAwxEVq2uFWcdSCkeNnNotBKdtGifEd2lWg2Oq9Dbgsn+KD1GjTeXor
   Xi0RFRgrS9JeapcpZ5BTabDMHdESmxQRxW1XJoRtrQI/5lvyyiloMlNS9
   AOdRzkisgqb23Cice9kFP4voDYn3F28RqTwbJUBUPsK+MYeVAPTcyKhND
   YovOfuS5SvjTYBenlNd0+vRD9cJYhUp6r2uQmQCUY+mXulIguKzNDUleC
   IKAGNlx6LQRR7rASXSZ5MaozEfaT4uWCx6QiI8A0h/b0SPncLN6/9+yLy
   gJZdXX4+xXOdPBZYtUUD10ctpHn0x8E5Li31jGGlJWmcRSmDSWRnk0mCP
   Q==;
X-IronPort-AV: E=Sophos;i="5.93,240,1654552800"; 
   d="scan'208";a="25618706"
Received: from unknown (HELO tq-pgp-pr1.tq-net.de) ([192.168.6.15])
  by mx1-pgp.tq-group.com with ESMTP; 16 Aug 2022 09:17:46 +0200
Received: from mx1.tq-group.com ([192.168.6.7])
  by tq-pgp-pr1.tq-net.de (PGP Universal service);
  Tue, 16 Aug 2022 09:17:46 +0200
X-PGP-Universal: processed;
        by tq-pgp-pr1.tq-net.de on Tue, 16 Aug 2022 09:17:46 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=tq-group.com; i=@tq-group.com; q=dns/txt; s=key1;
  t=1660634266; x=1692170266;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=7PvK1XUJcZYZO1YG4EHtQpi5gl6ePBLQ14O333RXE6M=;
  b=ZSOs1+u9ikj1Y+pMFDACnwA7kcyEJ68efn6NgfXMLX9Es1jvmknCvqZB
   CrN7h/6BgPQGf3aYcWswqSNUShkzMT4ZXfCKkP1Y+k7T5l1HD7k3j8uaw
   ANC2DhSdDZ/VL2Kdriyh5GRUtcHlc6bhIJabdC7zB6wtwG9jQis8YaBLa
   ZNcpHEe/CSo4gcbXNnYA9kF8PgfVRfmb+MwqmT5uocDKBp04w4tJGxsoy
   IYJW06z2gjgadMYvEM4U7Urk0NhRvqcf/FJA5c23DKFfDYtU/f48BYTAW
   8WPWR6SKQCHXaPUJVmOcjqAoaWtZkjqeGDhDrEQEhtSiEUho7Hc0nwvwt
   A==;
X-IronPort-AV: E=Sophos;i="5.93,240,1654552800"; 
   d="scan'208";a="25618703"
Received: from vtuxmail01.tq-net.de ([10.115.0.20])
  by mx1.tq-group.com with ESMTP; 16 Aug 2022 09:17:45 +0200
Received: from steina-w.localnet (unknown [10.123.49.11])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        by vtuxmail01.tq-net.de (Postfix) with ESMTPSA id 90E6F280056;
        Tue, 16 Aug 2022 09:17:45 +0200 (CEST)
From:   Alexander Stein <alexander.stein@ew.tq-group.com>
To:     Saravana Kannan <saravanak@google.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        Rob Herring <robh+dt@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Magnus Damm <magnus.damm@gmail.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Daniel Scally <djrscally@gmail.com>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        Len Brown <lenb@kernel.org>, Abel Vesa <abel.vesa@linaro.org>,
        Tony Lindgren <tony@atomide.com>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        John Stultz <jstultz@google.com>,
        Doug Anderson <dianders@chromium.org>,
        Guenter Roeck <linux@roeck-us.net>, kernel-team@android.com,
        linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org,
        devicetree@vger.kernel.org, linux-renesas-soc@vger.kernel.org,
        linux-acpi@vger.kernel.org
Subject: Re: [PATCH v1 0/9] fw_devlink improvements
Date:   Tue, 16 Aug 2022 09:17:43 +0200
Message-ID: <8296964.NyiUUSuA9g@steina-w>
Organization: TQ-Systems GmbH
In-Reply-To: <CAGETcx-JUV1nj8wBJrTPfyvM7=Mre5j_vkVmZojeiumUGG6QZQ@mail.gmail.com>
References: <20220810060040.321697-1-saravanak@google.com> <CAGETcx_tSndU0xerz=DF9JQxYFRC2aaxyOE-bR2JpM0L0ht=sw@mail.gmail.com> <CAGETcx-JUV1nj8wBJrTPfyvM7=Mre5j_vkVmZojeiumUGG6QZQ@mail.gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Saravana,

Am Montag, 15. August 2022, 22:56:07 CEST schrieb Saravana Kannan:
> On Mon, Aug 15, 2022 at 12:17 PM Saravana Kannan <saravanak@google.com> 
wrote:
> > On Mon, Aug 15, 2022 at 5:39 AM Alexander Stein
> > 
> > <alexander.stein@ew.tq-group.com> wrote:
> > > Hello Saravana,
> > > 
> > > Am Mittwoch, 10. August 2022, 08:00:29 CEST schrieb Saravana Kannan:
> > > > Alexander,
> > > > 
> > > > This should fix your issue where the power domain device not having a
> > > > compatible property. Can you give it a shot please?
> > > 
> > > thanks for the update. Unfortunately this does not work:
> > > > [    0.774838] PM: Added domain provider from /soc@0/bus@30000000/
> > > 
> > > gpc@303a0000/pgc/power-domain@0
> > > 
> > > > [    0.775100] imx-pgc imx-pgc-domain.1: __genpd_dev_pm_attach()
> > > > failed to
> > > 
> > > find PM domain: -2
> > > 
> > > > [    0.775324] PM: Added domain provider from /soc@0/bus@30000000/
> > > 
> > > gpc@303a0000/pgc/power-domain@2
> > > 
> > > > [    0.775601] PM: Added domain provider from /soc@0/bus@30000000/
> > > 
> > > gpc@303a0000/pgc/power-domain@3
> > > 
> > > > [    0.775842] PM: Added domain provider from /soc@0/bus@30000000/
> > > 
> > > gpc@303a0000/pgc/power-domain@4
> > > 
> > > > [    0.776642] PM: Added domain provider from /soc@0/bus@30000000/
> > > 
> > > gpc@303a0000/pgc/power-domain@7
> > > 
> > > > [    0.776897] PM: Added domain provider from /soc@0/bus@30000000/
> > > 
> > > gpc@303a0000/pgc/power-domain@8
> > > 
> > > > [    0.777158] PM: Added domain provider from /soc@0/bus@30000000/
> > > 
> > > gpc@303a0000/pgc/power-domain@9
> > > 
> > > > [    0.777405] PM: Added domain provider from /soc@0/bus@30000000/
> > > 
> > > gpc@303a0000/pgc/power-domain@a
> > > 
> > > > [    0.779342] genpd genpd:0:38320000.blk-ctrl:
> > > > __genpd_dev_pm_attach()
> > > 
> > > failed to find PM domain: -2
> > > 
> > > > [    0.779422] imx8m-blk-ctrl 38320000.blk-ctrl: error -ENODEV: failed
> > > > to
> > > 
> > > attach power domain "bus"
> > > 
> > > > [    0.848785] etnaviv-gpu 38000000.gpu: __genpd_dev_pm_attach()
> > > > failed to
> > > 
> > > find PM domain: -2
> > > 
> > > > [    1.114220] pfuze100-regulator 0-0008: Full layer: 2, Metal layer:
> > > > 1
> > > > [    1.122267] pfuze100-regulator 0-0008: FAB: 0, FIN: 0
> > > > [    1.132970] pfuze100-regulator 0-0008: pfuze100 found.
> > > > [    1.157011] imx-gpcv2 303a0000.gpc: Failed to create device link
> > > > with
> > > 
> > > 0-0008
> > > 
> > > > [    1.164094] imx-gpcv2 303a0000.gpc: Failed to create device link
> > > > with
> > > 
> > > 0-0008
> > > 
> > > The required power-supply for the power domains is still not yet
> > > available.
> > > Does this series require some other patches as well?
> > 
> > Ah sorry, yeah, this needs additional patches. The one I gave in the
> > other thread when I debugged this and I also noticed another issue.
> > Here's the combined diff of what's needed. Can you add this on top of
> > the series and test it?
> > 
> > diff --git a/drivers/irqchip/irq-imx-gpcv2.c
> > b/drivers/irqchip/irq-imx-gpcv2.c index b9c22f764b4d..8a0e82067924 100644
> > --- a/drivers/irqchip/irq-imx-gpcv2.c
> > +++ b/drivers/irqchip/irq-imx-gpcv2.c
> > @@ -283,6 +283,7 @@ static int __init imx_gpcv2_irqchip_init(struct
> > device_node *node,
> > 
> >          * later the GPC power domain driver will not be skipped.
> >          */
> >         
> >         of_node_clear_flag(node, OF_POPULATED);
> > 
> > +       fwnode_dev_initialized(domain->fwnode, false);
> > 
> >         return 0;
> >  
> >  }
> > 
> > diff --git a/drivers/soc/imx/gpcv2.c b/drivers/soc/imx/gpcv2.c
> > index 6383a4edc360..181fbfe5bd4d 100644
> > --- a/drivers/soc/imx/gpcv2.c
> > +++ b/drivers/soc/imx/gpcv2.c
> > @@ -1513,6 +1513,7 @@ static int imx_gpcv2_probe(struct platform_device
> > *pdev)> 
> >                 pd_pdev->dev.parent = dev;
> >                 pd_pdev->dev.of_node = np;
> > 
> > +               pd_pdev->dev.fwnode = of_fwnode_handle(np);
> > 
> >                 ret = platform_device_add(pd_pdev);
> >                 if (ret) {
> > 
> > With this patch, I'd really expect the power domain dependency to be
> > handled correctly.
> > 
> > > Whats worse, starting with commit 9/9 [of: property: Simplify
> > > of_link_to_phandle()], other drivers fail to probe waiting for pinctrl
> > > to be available.
> > 
> > Heh, Patch 9/9 and all its other dependencies in this series was to
> > fix your use case. Ironic that it's causing you more issues.
> > 
> > > > $ cat /sys/kernel/debug/devices_deferred
> > > > gpio-leds       platform: wait for supplier gpioledgrp
> > > > extcon-usbotg0  platform: wait for supplier usb0congrp
> > > > gpio-keys       platform: wait for supplier gpiobuttongrp
> > > > regulator-otg-vbus      platform: wait for supplier reggotgvbusgrp
> > > > regulator-vdd-arm       platform: wait for supplier dvfsgrp
> > > 
> > > Apparently for some reason they are not probed again, once the pinctrl
> > > driver probed.
> > 
> > I'm hoping that this is just some issue due to the missing patch
> > above, but doesn't sound like it if you say that the pinctrl ended up
> > probing eventually.
> > 
> > So when device_links_driver_bound() calls
> > __fw_devlink_pickup_dangling_consumers(), it should have picked up the
> > consumers of node like gpiobuttongrp and moved it to the pinctrl
> > device. And right after that we call __fw_devlink_link_to_consumers()
> > that would have created the device links. And then right after that,
> > we go through all the consumers and add them to the deferred probe
> > list. After that deferred probe should have run... either because it's
> > enabled at late_initcall() or because a new device probed
> > successfully.
> > 
> > Can you check which one of my expectations isn't true in your case?
> 
> Actually I have a hypothesis on what might be happening. It could be a
> case of the consumer device getting added after the supplier has been
> initialized.
> 
> If the patch above doesn't fix everything, can you add this diff on
> top of the patch above and see if that fixes everything? If it fixes
> the pinctrl issue, can you check my hypothesis be checking in what
> order the devices get added and get probed?
> 
> diff --git a/drivers/base/core.c b/drivers/base/core.c
> index 2f012e826986..866755d8ad95 100644
> --- a/drivers/base/core.c
> +++ b/drivers/base/core.c
> @@ -2068,7 +2068,11 @@ static int fw_devlink_create_devlink(struct device
> *con, device_links_write_unlock();
>         }
> 
> -       sup_dev = get_dev_from_fwnode(sup_handle);
> +       if (sup_handle->flags & FWNODE_FLAG_NOT_DEVICE)
> +               sup_dev = fwnode_get_next_parent_dev(sup_handle);
> +       else
> +               sup_dev = get_dev_from_fwnode(sup_handle);
> +
>         if (sup_dev) {
>                 /*
>                  * If it's one of those drivers that don't actually bind to
> 

And with this change my pinctrl probing is fixed as well!

Thanks
Alexander




