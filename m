Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BE52F5AE62A
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Sep 2022 13:05:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239839AbiIFLFc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Sep 2022 07:05:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47472 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233422AbiIFLFa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Sep 2022 07:05:30 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1FCC21E3C9
        for <linux-kernel@vger.kernel.org>; Tue,  6 Sep 2022 04:05:29 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 838FCB81630
        for <linux-kernel@vger.kernel.org>; Tue,  6 Sep 2022 11:05:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D540AC433D6;
        Tue,  6 Sep 2022 11:05:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1662462326;
        bh=4s4ztIiR0oqhWOWxN1Ey5feV+6vRX4cqf/Q74bBX8Bs=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=HBWz5DWC6c+Ra89H/PrSYFYj9QztCYJOTmZeKV3wIJBdvu/48Su2i9/BDa6gITePd
         ByzK3OJah0LosygEYeBEBMPgitV147TDEZKJ8Sk+ShZ0p5ezaZu5X+8k0KwwPpEAVd
         dLgL1y6PUrqGsgj/nkwQgS4B8FPlXWdEhJRbQ+KI=
Date:   Tue, 6 Sep 2022 13:05:23 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Kumaravel Thiagarajan <kumaravel.thiagarajan@microchip.com>
Cc:     linux-kernel@vger.kernel.org, kbuild-all@lists.01.org,
        lkp@intel.com
Subject: Re: [PATCH v2 char-misc-next] misc: microchip: pci1xxxx: fix
 dependency issues in building the pci1xxxx's aux bus driver.
Message-ID: <Yxcpc7ao10kytxbV@kroah.com>
References: <20220906103658.681751-1-kumaravel.thiagarajan@microchip.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220906103658.681751-1-kumaravel.thiagarajan@microchip.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 06, 2022 at 04:06:58PM +0530, Kumaravel Thiagarajan wrote:
> build errors and warnings listed below and reported by kernel
> test robot <lkp@intel.com> on the char-misc-next branch are
> fixed in this add-on patch.
> 
> errors:
> ERROR: modpost: "auxiliary_device_init"
>  [drivers/misc/mchp_pci1xxxx/mchp_pci1xxxx_gp.ko] undefined!

These lines should now be wrapped, it's ok to have long lines that show
the error messages.

> ERROR: modpost: "__auxiliary_device_add"
>  [drivers/misc/mchp_pci1xxxx/mchp_pci1xxxx_gp.ko] undefined!
> ERROR: modpost: "auxiliary_driver_unregister"
>  [drivers/misc/mchp_pci1xxxx/mchp_pci1xxxx_gpio.ko] undefined!
> ERROR: modpost: "__auxiliary_driver_register"
>  [drivers/misc/mchp_pci1xxxx/mchp_pci1xxxx_gpio.ko] undefined!
> ia64-linux-ld: drivers/misc/mchp_pci1xxxx/mchp_pci1xxxx_gp.o:
>  in function `gp_aux_bus_probe.part.0':
> mchp_pci1xxxx_gp.c:(.text+0x342): undefined reference to
>  `auxiliary_device_init'
> ia64-linux-ld: mchp_pci1xxxx_gp.c:(.text+0x392):
>  undefined reference to `__auxiliary_device_add'
> ia64-linux-ld: mchp_pci1xxxx_gp.c:(.text+0x5c2):
>  undefined reference to `auxiliary_device_init'
> ia64-linux-ld: mchp_pci1xxxx_gp.c:(.text+0x612):
>  undefined reference to `__auxiliary_device_add'
> ia64-linux-ld: drivers/misc/mchp_pci1xxxx/mchp_pci1xxxx_gpio.o:
>  in function `pci1xxxx_gpio_driver_init':
>  mchp_pci1xxxx_gpio.c:(.init.text+0x42): undefined reference to
>  `__auxiliary_driver_register'
> 
> warnings:
> unmet direct dependencies detected for GPIOLIB_IRQCHIP when selected by
>  GP_PCI1XXXX

Same here.

> 
> Fixes: 393fc2f5948f ("misc: microchip: pci1xxxx: load auxiliary bus driver
>  for the PIO function in the multi-function endpoint of pci1xxxx device.")

That all needs to be on one line.

> Reported-by: kernel test robot <lkp@intel.com>
> Signed-off-by: Kumaravel Thiagarajan <kumaravel.thiagarajan@microchip.com>
> ---
>  drivers/misc/mchp_pci1xxxx/Kconfig | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)

And as you said, no v2 information :(

v3 please?

thanks,

greg k-h
