Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8230E46494B
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Dec 2021 09:09:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347456AbhLAINI convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Wed, 1 Dec 2021 03:13:08 -0500
Received: from relay4-d.mail.gandi.net ([217.70.183.196]:56733 "EHLO
        relay4-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345308AbhLAINH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Dec 2021 03:13:07 -0500
Received: (Authenticated sender: miquel.raynal@bootlin.com)
        by relay4-d.mail.gandi.net (Postfix) with ESMTPSA id 0AD3BE0012;
        Wed,  1 Dec 2021 08:09:42 +0000 (UTC)
Date:   Wed, 1 Dec 2021 09:09:41 +0100
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     Olga Kitaina <okitain@gmail.com>
Cc:     linux-mtd@lists.infradead.org, nagasure@xilinx.com, richard@nod.at,
        vigneshr@ti.com, linux-kernel@vger.kernel.org,
        Michal Simek <monstr@monstr.eu>
Subject: Re: [PATCH] mtd: rawnand: arasan: Fix clock rate in NV-DDR
Message-ID: <20211201090941.73e67f65@xps13>
In-Reply-To: <fb6a4b49-7c10-4ed1-7054-5dd8ce2d8073@gmail.com>
References: <20211127180758.30884-1-okitain@gmail.com>
        <20211129095559.01aa63a6@xps13>
        <3da5dff5-53d4-15db-075d-9b195f2f75dd@gmail.com>
        <20211130082017.1400f24b@xps13>
        <fb6a4b49-7c10-4ed1-7054-5dd8ce2d8073@gmail.com>
Organization: Bootlin
X-Mailer: Claws Mail 3.17.7 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Olga,

+ Michal (please add him in Cc of your next iteration)

okitain@gmail.com wrote on Tue, 30 Nov 2021 23:08:20 +0300:

> Hi Miquel,
> 
> On 30.11.2021 10:20, Miquel Raynal wrote:
> > Hi Olga,
> > 
> > okitain@gmail.com wrote on Mon, 29 Nov 2021 21:06:05 +0300:
> >   
> >> Hi Miquel,
> >>
> >> On 29.11.2021 11:55, Miquel Raynal wrote:  
> >>> Hi Olga,
> >>>
> >>> Please add all the MTD maintainers in copy, as requested by
> >>> get_maintainers.pl.
> >>>
> >>> okitain@gmail.com wrote on Sat, 27 Nov 2021 21:07:58
> >>> +0300:
> >>>     
> >>>> According to the Arasan NAND controller spec,
> >>>> the flash clock rate for SDR must be <= 100 MHz,
> >>>> while for NV-DDR it must be the same as the rate
> >>>> of the CLK line for the mode.    
> >>>
> >>> I completely missed that, where did you get the information?    
> >>
> >> The "Data Interface Transitions" chapter of the spec contains timings for flash clock setup in NV-DDR
> >> and NV-DDR2 modes. The "time period" of those clocks is equal to tCK in NV-DDR and tRC in NV-DDR2.
> >>
> >> The same chapter should have information about necessary steps to switch from NV-DDR to SDR,
> >> which includes setting the flash clock to 100 MHz.
> >>
> >>
> >> Just to make sure i'm not shooting myself in the foot: am I changing the right clock?
> >> The documentation points out that we have to change flash_clk, which i thought was
> >> nfc->controller_clk and set up by anand->clk, but it seems like it might actually be nfc->bus_clk.  
> > 
> > I believe I made a serious mistake, re-reading the code it feels like
> > I'm changing the system's clock (which basically changes nothing in our
> > case) instead of changing the NAND bus clock.
> >   
> >> In that case, does setting nfc->controller_clk to 100 MHz by default make sense?
> >> There isn't a hard limit on what the system clock might be (beyond a specific SoC),
> >> but there are timing requirements for the flash clock, and so setting a specific 
> >> system clock frequency seems unnecessary for most devices.
> >>  
> > 
> > Please create a two-patch series:
> > 1- Setting the right clock in the current code base (inverting bus_clk
> > and controller_clk where relevant, setting one to 100MHz and letting
> > the other as it is)
> > 2- Changing the default NV-DDR rate based on tCK (below patch).
> > 
> > Do you have the necessary hardware for testing?  
> 
> I'm sorry to say - I do not. The SoC this problem was initially noticed on can't run latest Linux,
> and even if it did I have no way of acquiring an NV-DDR-capable flash.
> 
> Since Bootlin merged in NV-DDR support into the kernel, is it possible for you to test 
> the next iteration of this patch series on NV-DDR hardware as well?
> Say, by purposefully preventing NV-DDR mode 5 from being chosen in anfc_setup_interface()?

I don't have the hardware anymore.

Please send a v2 with the necessary changes, then we will ask Naga (or
somebody else from the same team) with access to the board to test it.

> >>>> The driver previously always set 100 MHz for NV-DDR, which
> >>>> would result in incorrect behavior for NV-DDR modes 0-4.
> >>>>
> >>>> The appropriate clock rate can be calculated
> >>>> from the NV-DDR timing parameters as 1/tCK, or for rates
> >>>> measured in picoseconds, 10^12 / nand_nvddr_timings->tCK_min.
> >>>>    
> >>>
> >>> You need a couple of Fixes + Cc: stable tags here, otherwise the
> >>> patch looks good to me.
> >>>     
> >>
> >> Will include in the next iteration of the patch, thank you.
> >>  
> >>>> Signed-off-by: Olga Kitaina <okitain@gmail.com>
> >>>> ---
> >>>>  drivers/mtd/nand/raw/arasan-nand-controller.c | 8 +++++++-
> >>>>  1 file changed, 7 insertions(+), 1 deletion(-)
> >>>>
> >>>> diff --git a/drivers/mtd/nand/raw/arasan-nand-controller.c b/drivers/mtd/nand/raw/arasan-nand-controller.c
> >>>> index 53bd10738418..ed4ee9942441 100644
> >>>> --- a/drivers/mtd/nand/raw/arasan-nand-controller.c
> >>>> +++ b/drivers/mtd/nand/raw/arasan-nand-controller.c
> >>>> @@ -18,6 +18,7 @@
> >>>>  #include <linux/gpio/consumer.h>
> >>>>  #include <linux/interrupt.h>
> >>>>  #include <linux/iopoll.h>
> >>>> +#include <linux/math64.h>
> >>>>  #include <linux/module.h>
> >>>>  #include <linux/mtd/mtd.h>
> >>>>  #include <linux/mtd/partitions.h>
> >>>> @@ -1043,7 +1044,12 @@ static int anfc_setup_interface(struct nand_chip *chip, int target,
> >>>>  				 DQS_BUFF_SEL_OUT(dqs_mode);
> >>>>  	}
> >>>>  
> >>>> -	anand->clk = ANFC_XLNX_SDR_DFLT_CORE_CLK;
> >>>> +	if (nand_interface_is_sdr)
> >>>> +		anand->clk = ANFC_XLNX_SDR_DFLT_CORE_CLK;
> >>>> +	else
> >>>> +		/* ONFI timings are defined in picoseconds */
> >>>> +		anand->clk = div_u64((u64)NSEC_PER_SEC * 1000,
> >>>> +				     conf->timings.nvddr.tCK_min);
> >>>>  
> >>>>  	/*
> >>>>  	 * Due to a hardware bug in the ZynqMP SoC, SDR timing modes 0-1 work
> >>>>
> >>>> base-commit: f53d4c109a666bf1a4883b45d546fba079258717    
> >>>
> >>>
> >>> Thanks,
> >>> Miquèl
> >>>     
> > 
> > 
> > Thanks,
> > Miquèl
> >   
> 
> Thanks,
> Olga.


Thanks,
Miquèl
