Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2E7CD59E4F7
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Aug 2022 16:13:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242558AbiHWOMK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 Aug 2022 10:12:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53604 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242142AbiHWOLq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Aug 2022 10:11:46 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D75C71F7E29;
        Tue, 23 Aug 2022 04:22:57 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id CE381B81CE1;
        Tue, 23 Aug 2022 11:22:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 15E32C433D6;
        Tue, 23 Aug 2022 11:22:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1661253723;
        bh=TD1BCzsB+VDB3omjrJdoMxFsM4VrXBf8+0iIsQqcBfs=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=lb3HisP/BWNyqhKidKUq0XDDe494RGc/N6ezGxLmgguEJVPxTA3QNpCtyvY8Kt5WB
         Hml6CBqnTRAiPeMDzOPJIIE2sZElO237QfgeZ/hCIrkhW3nIq+tmxBFvJF+FucKz3+
         yY3t8UwwQkSezEmFoFVPXRjr8zruB1oo+wCZvHt4=
Date:   Tue, 23 Aug 2022 13:22:00 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Kumaravel Thiagarajan <kumaravel.thiagarajan@microchip.com>
Cc:     linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        UNGLinuxDriver@microchip.com, arnd@arndb.de,
        dragan.cvetic@xilinx.com, derek.kiernan@xilinx.com
Subject: Re: [PATCH RFC char-misc-next 0/5] misc: microchip: pci1xxxx: Add
 auxiliary bus driver and the GPIO driver for PIO function of pci1xxxx.
Message-ID: <YwS4WDekXM3UQ7Yo@kroah.com>
References: <20220804163219.921640-1-kumaravel.thiagarajan@microchip.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220804163219.921640-1-kumaravel.thiagarajan@microchip.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 04, 2022 at 10:02:14PM +0530, Kumaravel Thiagarajan wrote:
> pci1xxxx is a PCIe switch with a multi-function endpoint on one of its
> downstream ports. PIO function is one of the functions in the
> multi-function endpoint. PIO function combines a GPIO controller and also
> an interface to program pci1xxxx'x OTP & EEPROM. This patch adds an
> auxiliary bus driver that enumerates separate child devices for gpio and
> OTP/EEPROM interface and the gpio controller driver for the first child.
> 
> Kumaravel Thiagarajan (5):
>   misc: microchip: pci1xxxx: load auxiliary bus driver for the PIO
>     function in the multi-function endpoint of pci1xxxx device.
>   misc: microchip: pci1xxxx: load gpio driver for the gpio controller
>     auxiliary device enumerated by the auxiliary bus driver.
>   misc: microchip: pci1xxxx: Add functions to configure gpio pins as
>     input / output, get status, handle I/O for gpio pins.
>   misc: microchip: pci1xxxx: Add gpio irq handler and irq helper
>     functions irq_ack, irq_mask, irq_unmask and irq_set_type of
>     irq_chip.
>   misc: microchip: pci1xxxx: Add power management functions - suspend &
>     resume handlers.
> 
>  MAINTAINERS                                   |   9 +
>  drivers/misc/Kconfig                          |   1 +
>  drivers/misc/Makefile                         |   3 +-
>  drivers/misc/mchp_pci1xxxx/Kconfig            |  10 +
>  drivers/misc/mchp_pci1xxxx/Makefile           |   1 +
>  drivers/misc/mchp_pci1xxxx/mchp_pci1xxxx_gp.c | 167 +++++++
>  drivers/misc/mchp_pci1xxxx/mchp_pci1xxxx_gp.h |  28 ++
>  .../misc/mchp_pci1xxxx/mchp_pci1xxxx_gpio.c   | 438 ++++++++++++++++++
>  8 files changed, 656 insertions(+), 1 deletion(-)
>  create mode 100644 drivers/misc/mchp_pci1xxxx/Kconfig
>  create mode 100644 drivers/misc/mchp_pci1xxxx/Makefile
>  create mode 100644 drivers/misc/mchp_pci1xxxx/mchp_pci1xxxx_gp.c
>  create mode 100644 drivers/misc/mchp_pci1xxxx/mchp_pci1xxxx_gp.h
>  create mode 100644 drivers/misc/mchp_pci1xxxx/mchp_pci1xxxx_gpio.c
> 
> -- 
> 2.25.1
> 

This patch is marked as "RFC" but I don't see any questions that you
have here.  Please resolve anything you think needs to be handled and
submit a "this series is ok to be merged" version.

thanks,

greg k-h
