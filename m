Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AEDD2502739
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Apr 2022 11:13:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351687AbiDOJPh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Apr 2022 05:15:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44654 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243247AbiDOJPc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Apr 2022 05:15:32 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0039820189;
        Fri, 15 Apr 2022 02:13:03 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 82F29621A7;
        Fri, 15 Apr 2022 09:13:03 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 59D05C385A5;
        Fri, 15 Apr 2022 09:13:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1650013982;
        bh=brLvitOvF78cc92gJ/QPY5YjPbA6LzzNbIYvBCmoVWw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=bDPrhihkKlBU4ObZRJRX8ikCjHY0/DcYBSYKu4SP1F3VV8c6fdZpcj7VkfxlTn+Ji
         YGpkoUEM0+RX0zO99FpIqkvew37MxX3vio9j/syRW1vjnBQV89LV5uc5SMPv1W3nrA
         MWBporXXFrcY17rnk9NBWjfttKqG8v5L1frWwvkA=
Date:   Fri, 15 Apr 2022 11:13:00 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     "Maciej W. Rozycki" <macro@orcam.me.uk>
Cc:     Jiri Slaby <jirislaby@kernel.org>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [RESEND][PATCH v3 1/2] serial: 8250: Fold EndRun device support
 into OxSemi Tornado code
Message-ID: <Ylk3HNZqnBLMMQCm@kroah.com>
References: <alpine.DEB.2.21.2203310114210.44113@angie.orcam.me.uk>
 <alpine.DEB.2.21.2203310121211.44113@angie.orcam.me.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.21.2203310121211.44113@angie.orcam.me.uk>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 31, 2022 at 08:11:42AM +0100, Maciej W. Rozycki wrote:
> The EndRun PTP/1588 dual serial port device is based on the Oxford
> Semiconductor OXPCIe952 UART device with the PCI vendor:device ID set
> for EndRun Technologies and uses the same sequence to determine the
> number of ports available.  Despite that we have duplicate code
> specific to the EndRun device.
> 
> Remove redundant code then and factor out OxSemi Tornado device
> detection.  Also correct the baud base like with commit 6cbe45d8ac93
> ("serial: 8250: Correct the clock for OxSemi PCIe devices") for the
> value of 3906250 rather than 4000000, obtained by dividing the 62.5MHz
> clock input by the default oversampling rate of 16.  Finally move the
> EndRun vendor:device ID to <linux/pci_ids.h>.
> 
> Signed-off-by: Maciej W. Rozycki <macro@orcam.me.uk>
> Fixes: 1bc8cde46a159 ("8250_pci: Added driver for Endrun Technologies PTP PCIe card.")
> ---
> New change in v3.
> ---
>  drivers/tty/serial/8250/8250_pci.c |   79 +++++++++++--------------------------
>  include/linux/pci_ids.h            |    3 +
>  2 files changed, 28 insertions(+), 54 deletions(-)
> 
> linux-serial-8250-oxsemi-endrun.diff
> Index: linux-macro/drivers/tty/serial/8250/8250_pci.c
> ===================================================================
> --- linux-macro.orig/drivers/tty/serial/8250/8250_pci.c
> +++ linux-macro/drivers/tty/serial/8250/8250_pci.c
> @@ -994,41 +994,26 @@ static void pci_ite887x_exit(struct pci_
>  }
>  
>  /*
> - * EndRun Technologies.
> - * Determine the number of ports available on the device.
> + * Oxford Semiconductor Inc.
> + * Check if an OxSemi device is part of the Tornado range of devices.
>   */
> -#define PCI_VENDOR_ID_ENDRUN			0x7401
> -#define PCI_DEVICE_ID_ENDRUN_1588	0xe100
> -
> -static int pci_endrun_init(struct pci_dev *dev)
> +static bool pci_oxsemi_tornado_p(struct pci_dev *dev)
>  {
> -	u8 __iomem *p;
> -	unsigned long deviceID;
> -	unsigned int  number_uarts = 0;
> +	/* OxSemi Tornado devices are all 0xCxxx */
> +	if (dev->vendor == PCI_VENDOR_ID_OXSEMI &&
> +	    (dev->device & 0xf000) != 0xc000)
> +		return false;
>  
> -	/* EndRun device is all 0xexxx */
> +	/* EndRun devices are all 0xExxx */
>  	if (dev->vendor == PCI_VENDOR_ID_ENDRUN &&
> -		(dev->device & 0xf000) != 0xe000)
> -		return 0;
> -
> -	p = pci_iomap(dev, 0, 5);
> -	if (p == NULL)
> -		return -ENOMEM;
> +	    (dev->device & 0xf000) != 0xe000)
> +		return false;
>  
> -	deviceID = ioread32(p);
> -	/* EndRun device */
> -	if (deviceID == 0x07000200) {
> -		number_uarts = ioread8(p + 4);
> -		pci_dbg(dev, "%d ports detected on EndRun PCI Express device\n", number_uarts);
> -	}
> -	pci_iounmap(dev, p);
> -	return number_uarts;
> +	return true;
>  }
>  
>  /*
> - * Oxford Semiconductor Inc.
> - * Check that device is part of the Tornado range of devices, then determine
> - * the number of ports available on the device.
> + * Determine the number of ports available on a Tornado device.
>   */
>  static int pci_oxsemi_tornado_init(struct pci_dev *dev)
>  {
> @@ -1036,9 +1021,7 @@ static int pci_oxsemi_tornado_init(struc
>  	unsigned long deviceID;
>  	unsigned int  number_uarts = 0;
>  
> -	/* OxSemi Tornado devices are all 0xCxxx */
> -	if (dev->vendor == PCI_VENDOR_ID_OXSEMI &&
> -	    (dev->device & 0xF000) != 0xC000)
> +	if (!pci_oxsemi_tornado_p(dev))
>  		return 0;
>  
>  	p = pci_iomap(dev, 0, 5);
> @@ -1049,7 +1032,10 @@ static int pci_oxsemi_tornado_init(struc
>  	/* Tornado device */
>  	if (deviceID == 0x07000200) {
>  		number_uarts = ioread8(p + 4);
> -		pci_dbg(dev, "%d ports detected on Oxford PCI Express device\n", number_uarts);
> +		pci_dbg(dev, "%d ports detected on %s PCI Express device\n",
> +			number_uarts,
> +			dev->vendor == PCI_VENDOR_ID_ENDRUN ?
> +			"EndRun" : "Oxford");
>  	}
>  	pci_iounmap(dev, p);
>  	return number_uarts;
> @@ -2244,7 +2230,7 @@ static struct pci_serial_quirk pci_seria
>  		.device		= PCI_ANY_ID,
>  		.subvendor	= PCI_ANY_ID,
>  		.subdevice	= PCI_ANY_ID,
> -		.init		= pci_endrun_init,
> +		.init		= pci_oxsemi_tornado_init,
>  		.setup		= pci_default_setup,
>  	},
>  	/*
> @@ -2667,7 +2653,6 @@ enum pci_board_num_t {
>  	pbn_panacom2,
>  	pbn_panacom4,
>  	pbn_plx_romulus,
> -	pbn_endrun_2_4000000,
>  	pbn_oxsemi,
>  	pbn_oxsemi_1_3906250,
>  	pbn_oxsemi_2_3906250,
> @@ -3190,20 +3175,6 @@ static struct pciserial_board pci_boards
>  	},
>  
>  	/*
> -	 * EndRun Technologies
> -	* Uses the size of PCI Base region 0 to
> -	* signal now many ports are available
> -	* 2 port 952 Uart support
> -	*/
> -	[pbn_endrun_2_4000000] = {
> -		.flags		= FL_BASE0,
> -		.num_ports	= 2,
> -		.base_baud	= 4000000,
> -		.uart_offset	= 0x200,
> -		.first_offset	= 0x1000,
> -	},
> -
> -	/*
>  	 * This board uses the size of PCI Base region 0 to
>  	 * signal now many ports are available
>  	 */
> @@ -4123,13 +4094,6 @@ static const struct pci_device_id serial
>  		0x10b5, 0x106a, 0, 0,
>  		pbn_plx_romulus },
>  	/*
> -	* EndRun Technologies. PCI express device range.
> -	*    EndRun PTP/1588 has 2 Native UARTs.
> -	*/
> -	{	PCI_VENDOR_ID_ENDRUN, PCI_DEVICE_ID_ENDRUN_1588,
> -		PCI_ANY_ID, PCI_ANY_ID, 0, 0,
> -		pbn_endrun_2_4000000 },
> -	/*
>  	 * Quatech cards. These actually have configurable clocks but for
>  	 * now we just use the default.
>  	 *
> @@ -4390,6 +4354,13 @@ static const struct pci_device_id serial
>  	{	PCI_VENDOR_ID_DIGI, PCIE_DEVICE_ID_NEO_2_OX_IBM,
>  		PCI_SUBVENDOR_ID_IBM, PCI_ANY_ID, 0, 0,
>  		pbn_oxsemi_2_3906250 },
> +	/*
> +	 * EndRun Technologies. PCI express device range.
> +	 * EndRun PTP/1588 has 2 Native UARTs utilizing OxSemi 952.
> +	 */
> +	{	PCI_VENDOR_ID_ENDRUN, PCI_DEVICE_ID_ENDRUN_1588,
> +		PCI_ANY_ID, PCI_ANY_ID, 0, 0,
> +		pbn_oxsemi_2_3906250 },
>  
>  	/*
>  	 * SBS Technologies, Inc. P-Octal and PMC-OCTPRO cards,
> Index: linux-macro/include/linux/pci_ids.h
> ===================================================================
> --- linux-macro.orig/include/linux/pci_ids.h
> +++ linux-macro/include/linux/pci_ids.h
> @@ -2622,6 +2622,9 @@
>  #define PCI_DEVICE_ID_DCI_PCCOM8	0x0002
>  #define PCI_DEVICE_ID_DCI_PCCOM2	0x0004
>  
> +#define PCI_VENDOR_ID_ENDRUN		0x7401
> +#define PCI_DEVICE_ID_ENDRUN_1588	0xe100

As per the top of this file, this should not be needed here as you are
only using it in one file.  Please leave it as-is.

thanks,

greg k-h
