Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7C9244D6E65
	for <lists+linux-kernel@lfdr.de>; Sat, 12 Mar 2022 12:22:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231267AbiCLLXL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 12 Mar 2022 06:23:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44838 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229632AbiCLLXH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 12 Mar 2022 06:23:07 -0500
Received: from hosting.gsystem.sk (hosting.gsystem.sk [212.5.213.30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 85FB2214175;
        Sat, 12 Mar 2022 03:22:00 -0800 (PST)
Received: from [192.168.0.2] (chello089173232159.chello.sk [89.173.232.159])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by hosting.gsystem.sk (Postfix) with ESMTPSA id 582817A018C;
        Sat, 12 Mar 2022 12:21:58 +0100 (CET)
From:   Ondrej Zary <linux@zary.sk>
To:     Damien Le Moal <damien.lemoal@opensource.wdc.com>
Subject: Re: [PATCH v0] pata_parport: add driver (PARIDE replacement)
Date:   Sat, 12 Mar 2022 12:21:55 +0100
User-Agent: KMail/1.9.10
Cc:     Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>,
        Tim Waugh <tim@cyberelk.net>, linux-block@vger.kernel.org,
        linux-parport@lists.infradead.org, linux-ide@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20220310212812.13944-1-linux@zary.sk> <202203111955.15743.linux@zary.sk> <c0a6065c-3e89-a4be-e257-ce25711e4368@opensource.wdc.com>
In-Reply-To: <c0a6065c-3e89-a4be-e257-ce25711e4368@opensource.wdc.com>
X-KMail-QuotePrefix: > 
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <202203121221.56068.linux@zary.sk>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Saturday 12 March 2022 09:09:54 Damien Le Moal wrote:
> On 3/12/22 03:55, Ondrej Zary wrote:
> > On Friday 11 March 2022 00:59:20 Damien Le Moal wrote:
> >> On 3/11/22 06:28, Ondrej Zary wrote:
> >>> Add pata_parport (PARIDE replacement) core libata driver.
> >>>
> >>> The original paride protocol modules are used for now so allow them to
> >>> be compiled without old PARIDE core.
> >>>
> >>> Signed-off-by: Ondrej Zary <linux@zary.sk>
> >>> ---
> >>>  drivers/Makefile                   |   2 +-
> >>>  drivers/ata/Kconfig                |  22 +
> >>>  drivers/ata/Makefile               |   2 +
> >>>  drivers/ata/parport/Makefile       |   3 +
> >>>  drivers/ata/parport/pata_parport.c | 805 +++++++++++++++++++++++++++++
> >>>  drivers/ata/parport/pata_parport.h | 108 ++++
> >>>  drivers/block/paride/Kconfig       |  32 +-
> >>>  drivers/block/paride/paride.h      |   5 +
> >>>  8 files changed, 962 insertions(+), 17 deletions(-)
> >>>  create mode 100644 drivers/ata/parport/Makefile
> >>>  create mode 100644 drivers/ata/parport/pata_parport.c
> >>>  create mode 100644 drivers/ata/parport/pata_parport.h
> >>>
> >>> diff --git a/drivers/Makefile b/drivers/Makefile
> >>> index a110338c860c..8ec515f3614e 100644
> >>> --- a/drivers/Makefile
> >>> +++ b/drivers/Makefile
> >>> @@ -98,7 +98,7 @@ obj-$(CONFIG_DIO)		+= dio/
> >>>  obj-$(CONFIG_SBUS)		+= sbus/
> >>>  obj-$(CONFIG_ZORRO)		+= zorro/
> >>>  obj-$(CONFIG_ATA_OVER_ETH)	+= block/aoe/
> >>> -obj-$(CONFIG_PARIDE) 		+= block/paride/
> >>> +obj-y		 		+= block/paride/
> >>>  obj-$(CONFIG_TC)		+= tc/
> >>>  obj-$(CONFIG_USB_PHY)		+= usb/
> >>>  obj-$(CONFIG_USB)		+= usb/
> >>> diff --git a/drivers/ata/Kconfig b/drivers/ata/Kconfig
> >>> index e5641e6c52ee..671c27b77a48 100644
> >>> --- a/drivers/ata/Kconfig
> >>> +++ b/drivers/ata/Kconfig
> >>> @@ -1161,6 +1161,28 @@ config PATA_WINBOND_VLB
> >>>  	  Support for the Winbond W83759A controller on Vesa Local Bus
> >>>  	  systems.
> >>>  
> >>> +config PATA_PARPORT
> >>> +	tristate "Parallel port IDE device support"
> >>> +	depends on PARPORT_PC && PARIDE=n
> >>
> >> This is very confusing. The change above this one switch paride
> >> compilation to be unconditional, regardless of CONFIG_PARIDE value, but
> >> here, you have the dependency to PARIDE=n. I do not understand... Please
> >> clarify.
> > 
> > pata_parport will use existing paride protocol modules. So the paride/ directory must be processed to compile the protocol modules (if they're enabled) even if paride is not enabled.
> > 
> > pata_parport and paride are mutually exclusive because the binary protocol modules are incompatible (the struct pi_adapter is different).
> 
> So if both CONFIG_PARIDE and CONFIG_PATA_PARPORT are disabled, there
> should be no need to compile the core PARIDE code under block/. You
> should have something like:
> 
> In drivers/Makefile:
> 
> -obj-$(CONFIG_PARIDE) 		+= block/paride/
> +obj-$(CONFIG_PARIDE_CORE) 	+= block/paride/
> 
> And then have CONFIG_PARIDE and CONFIG_PATA_PARPORT select PARIDE_CORE,
> with CONFIG_PARIDE and CONFIG_PATA_PARPORT being mutually exclusive
> (using "depends on" as you did).
> 
> Here, I am assuming that block/paride is the core code used by both
> PARIDE and PATA_PARPORT. Not sure what PARPORT_PC does nor what its
> dependency on block/paride code is.

There's no common core in block/paride. The block/paride/Makefile says:
obj-$(CONFIG_PARIDE)            += paride.o
obj-$(CONFIG_PARIDE_ATEN)       += aten.o
obj-$(CONFIG_PARIDE_...other protocol drivers

So if PARIDE and all protocol drivers are disabled, nothing is compiled there.

-- 
Ondrej Zary
