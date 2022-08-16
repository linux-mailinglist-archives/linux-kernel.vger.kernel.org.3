Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 07EE15955DD
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Aug 2022 11:05:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233451AbiHPJEt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 Aug 2022 05:04:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43654 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232801AbiHPJD7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Aug 2022 05:03:59 -0400
Received: from mx1.tq-group.com (mx1.tq-group.com [93.104.207.81])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 040156747E;
        Tue, 16 Aug 2022 00:17:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=tq-group.com; i=@tq-group.com; q=dns/txt; s=key1;
  t=1660634266; x=1692170266;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=dkehMmxOl1c1Zf5GC4wXoMM0vyQ0XwwrYepcrwTs+5Y=;
  b=Zk4Do33sAFQbB5oajX5te5BTq/mHS8n3UnYF6Nbs2CUgMXA1cBVdPMZm
   DLAlg0oJ3NT0UyHzlej9PKpQY1BAUcd+9w1e0+c785yqww/jZp5l67Tqi
   VU7wb8rqCtbXzUIdmq49ZiAZl4Hyv4lC2RFM4RgOCrbSBvqlkVq5eqpZK
   0mN1Pv2JgXxzNT1xOJ5Xey0K8AMIGIArIQo1cPLwP7sBT0gT7oXqIJBpd
   5eYxj4B4Ri/cz4RW/yJMna4+NDo0+GQjPrpkolEiwAK056eKAJrhPcZh2
   byjKF5h01eVsOcdVckeQdJABfH2rrdgqS/aqbnDUlmms/6VwMDQ+QaPDW
   Q==;
X-IronPort-AV: E=Sophos;i="5.93,240,1654552800"; 
   d="scan'208";a="25618691"
Received: from unknown (HELO tq-pgp-pr1.tq-net.de) ([192.168.6.15])
  by mx1-pgp.tq-group.com with ESMTP; 16 Aug 2022 09:17:41 +0200
Received: from mx1.tq-group.com ([192.168.6.7])
  by tq-pgp-pr1.tq-net.de (PGP Universal service);
  Tue, 16 Aug 2022 09:17:42 +0200
X-PGP-Universal: processed;
        by tq-pgp-pr1.tq-net.de on Tue, 16 Aug 2022 09:17:42 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=tq-group.com; i=@tq-group.com; q=dns/txt; s=key1;
  t=1660634261; x=1692170261;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=dkehMmxOl1c1Zf5GC4wXoMM0vyQ0XwwrYepcrwTs+5Y=;
  b=FCrbwVk5lgSncxDTBANc0cchHXvN3F+CKbipHx60d4RfkW9l1J49Nn2L
   BK0pUkBuSMbjE8frUo0Bj0xfPLdD62JkcsemvsgQl9lXf4YXbFxzGl2tT
   47WqZYoqxeths67hQ/E3pPnpgmRVisp/f7eVQvAFf+nXI3EzlFZS3lqIo
   pA7wZyPgq3fQdq3H3mWP+l8MdnPQd0Q2mRuwAFvHnr7Ey48/ccdWpSakF
   iAicp4/8yDonkUuQ5bPJgWY5uoF+Jz9rzqRHF1S5WhXWH8tRM7M4PyajQ
   SzDJPsMuj0sh5wS+ZSaiVJHdI5YBuy/uJjN/qW702KPmUFMOM4RsA/YR+
   Q==;
X-IronPort-AV: E=Sophos;i="5.93,240,1654552800"; 
   d="scan'208";a="25618664"
Received: from vtuxmail01.tq-net.de ([10.115.0.20])
  by mx1.tq-group.com with ESMTP; 16 Aug 2022 09:17:37 +0200
Received: from steina-w.localnet (unknown [10.123.49.11])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        by vtuxmail01.tq-net.de (Postfix) with ESMTPSA id 3EE2E280056;
        Tue, 16 Aug 2022 09:17:37 +0200 (CEST)
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
Date:   Tue, 16 Aug 2022 09:17:34 +0200
Message-ID: <1888231.VLH7GnMWUR@steina-w>
Organization: TQ-Systems GmbH
In-Reply-To: <CAGETcx_tSndU0xerz=DF9JQxYFRC2aaxyOE-bR2JpM0L0ht=sw@mail.gmail.com>
References: <20220810060040.321697-1-saravanak@google.com> <3601760.iIbC2pHGDl@steina-w> <CAGETcx_tSndU0xerz=DF9JQxYFRC2aaxyOE-bR2JpM0L0ht=sw@mail.gmail.com>
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

Am Montag, 15. August 2022, 21:17:36 CEST schrieb Saravana Kannan:
> On Mon, Aug 15, 2022 at 5:39 AM Alexander Stein
> 
> <alexander.stein@ew.tq-group.com> wrote:
> > Hello Saravana,
> > 
> > Am Mittwoch, 10. August 2022, 08:00:29 CEST schrieb Saravana Kannan:
> > > Alexander,
> > > 
> > > This should fix your issue where the power domain device not having a
> > > compatible property. Can you give it a shot please?
> > 
> > thanks for the update. Unfortunately this does not work:
> > > [    0.774838] PM: Added domain provider from /soc@0/bus@30000000/
> > 
> > gpc@303a0000/pgc/power-domain@0
> > 
> > > [    0.775100] imx-pgc imx-pgc-domain.1: __genpd_dev_pm_attach() failed
> > > to
> > 
> > find PM domain: -2
> > 
> > > [    0.775324] PM: Added domain provider from /soc@0/bus@30000000/
> > 
> > gpc@303a0000/pgc/power-domain@2
> > 
> > > [    0.775601] PM: Added domain provider from /soc@0/bus@30000000/
> > 
> > gpc@303a0000/pgc/power-domain@3
> > 
> > > [    0.775842] PM: Added domain provider from /soc@0/bus@30000000/
> > 
> > gpc@303a0000/pgc/power-domain@4
> > 
> > > [    0.776642] PM: Added domain provider from /soc@0/bus@30000000/
> > 
> > gpc@303a0000/pgc/power-domain@7
> > 
> > > [    0.776897] PM: Added domain provider from /soc@0/bus@30000000/
> > 
> > gpc@303a0000/pgc/power-domain@8
> > 
> > > [    0.777158] PM: Added domain provider from /soc@0/bus@30000000/
> > 
> > gpc@303a0000/pgc/power-domain@9
> > 
> > > [    0.777405] PM: Added domain provider from /soc@0/bus@30000000/
> > 
> > gpc@303a0000/pgc/power-domain@a
> > 
> > > [    0.779342] genpd genpd:0:38320000.blk-ctrl: __genpd_dev_pm_attach()
> > 
> > failed to find PM domain: -2
> > 
> > > [    0.779422] imx8m-blk-ctrl 38320000.blk-ctrl: error -ENODEV: failed
> > > to
> > 
> > attach power domain "bus"
> > 
> > > [    0.848785] etnaviv-gpu 38000000.gpu: __genpd_dev_pm_attach() failed
> > > to
> > 
> > find PM domain: -2
> > 
> > > [    1.114220] pfuze100-regulator 0-0008: Full layer: 2, Metal layer: 1
> > > [    1.122267] pfuze100-regulator 0-0008: FAB: 0, FIN: 0
> > > [    1.132970] pfuze100-regulator 0-0008: pfuze100 found.
> > > [    1.157011] imx-gpcv2 303a0000.gpc: Failed to create device link with
> > 
> > 0-0008
> > 
> > > [    1.164094] imx-gpcv2 303a0000.gpc: Failed to create device link with
> > 
> > 0-0008
> > 
> > The required power-supply for the power domains is still not yet
> > available.
> > Does this series require some other patches as well?
> 
> Ah sorry, yeah, this needs additional patches. The one I gave in the
> other thread when I debugged this and I also noticed another issue.
> Here's the combined diff of what's needed. Can you add this on top of
> the series and test it?
> 
> diff --git a/drivers/irqchip/irq-imx-gpcv2.c
> b/drivers/irqchip/irq-imx-gpcv2.c index b9c22f764b4d..8a0e82067924 100644
> --- a/drivers/irqchip/irq-imx-gpcv2.c
> +++ b/drivers/irqchip/irq-imx-gpcv2.c
> @@ -283,6 +283,7 @@ static int __init imx_gpcv2_irqchip_init(struct
> device_node *node,
>          * later the GPC power domain driver will not be skipped.
>          */
>         of_node_clear_flag(node, OF_POPULATED);
> +       fwnode_dev_initialized(domain->fwnode, false);
>         return 0;
>  }
> 
> diff --git a/drivers/soc/imx/gpcv2.c b/drivers/soc/imx/gpcv2.c
> index 6383a4edc360..181fbfe5bd4d 100644
> --- a/drivers/soc/imx/gpcv2.c
> +++ b/drivers/soc/imx/gpcv2.c
> @@ -1513,6 +1513,7 @@ static int imx_gpcv2_probe(struct platform_device
> *pdev)
> 
>                 pd_pdev->dev.parent = dev;
>                 pd_pdev->dev.of_node = np;
> +               pd_pdev->dev.fwnode = of_fwnode_handle(np);
> 
>                 ret = platform_device_add(pd_pdev);
>                 if (ret) {
> 
> With this patch, I'd really expect the power domain dependency to be
> handled correctly.

I was out of office so I didn't keep track of any dependencies, sorry.
With these 2 changes above my power domain problem is fixed!

Thanks
Alexander



