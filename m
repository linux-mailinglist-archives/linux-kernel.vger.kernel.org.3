Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 53E0C4D68D0
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Mar 2022 19:55:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351004AbiCKS4a (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Mar 2022 13:56:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60836 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345153AbiCKS41 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Mar 2022 13:56:27 -0500
Received: from hosting.gsystem.sk (hosting.gsystem.sk [212.5.213.30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 4086B25E8A;
        Fri, 11 Mar 2022 10:55:20 -0800 (PST)
Received: from [192.168.0.2] (chello089173232159.chello.sk [89.173.232.159])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by hosting.gsystem.sk (Postfix) with ESMTPSA id 49C957A025E;
        Fri, 11 Mar 2022 19:55:19 +0100 (CET)
From:   Ondrej Zary <linux@zary.sk>
To:     Damien Le Moal <damien.lemoal@opensource.wdc.com>
Subject: Re: [PATCH v0] pata_parport: add driver (PARIDE replacement)
Date:   Fri, 11 Mar 2022 19:55:15 +0100
User-Agent: KMail/1.9.10
Cc:     Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>,
        Tim Waugh <tim@cyberelk.net>, linux-block@vger.kernel.org,
        linux-parport@lists.infradead.org, linux-ide@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20220310212812.13944-1-linux@zary.sk> <e41b526d-18d4-ae05-976d-3021e739cd8e@opensource.wdc.com>
In-Reply-To: <e41b526d-18d4-ae05-976d-3021e739cd8e@opensource.wdc.com>
X-KMail-QuotePrefix: > 
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <202203111955.15743.linux@zary.sk>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday 11 March 2022 00:59:20 Damien Le Moal wrote:
> On 3/11/22 06:28, Ondrej Zary wrote:
> > Add pata_parport (PARIDE replacement) core libata driver.
> > 
> > The original paride protocol modules are used for now so allow them to
> > be compiled without old PARIDE core.
> > 
> > Signed-off-by: Ondrej Zary <linux@zary.sk>
> > ---
> >  drivers/Makefile                   |   2 +-
> >  drivers/ata/Kconfig                |  22 +
> >  drivers/ata/Makefile               |   2 +
> >  drivers/ata/parport/Makefile       |   3 +
> >  drivers/ata/parport/pata_parport.c | 805 +++++++++++++++++++++++++++++
> >  drivers/ata/parport/pata_parport.h | 108 ++++
> >  drivers/block/paride/Kconfig       |  32 +-
> >  drivers/block/paride/paride.h      |   5 +
> >  8 files changed, 962 insertions(+), 17 deletions(-)
> >  create mode 100644 drivers/ata/parport/Makefile
> >  create mode 100644 drivers/ata/parport/pata_parport.c
> >  create mode 100644 drivers/ata/parport/pata_parport.h
> > 
> > diff --git a/drivers/Makefile b/drivers/Makefile
> > index a110338c860c..8ec515f3614e 100644
> > --- a/drivers/Makefile
> > +++ b/drivers/Makefile
> > @@ -98,7 +98,7 @@ obj-$(CONFIG_DIO)		+= dio/
> >  obj-$(CONFIG_SBUS)		+= sbus/
> >  obj-$(CONFIG_ZORRO)		+= zorro/
> >  obj-$(CONFIG_ATA_OVER_ETH)	+= block/aoe/
> > -obj-$(CONFIG_PARIDE) 		+= block/paride/
> > +obj-y		 		+= block/paride/
> >  obj-$(CONFIG_TC)		+= tc/
> >  obj-$(CONFIG_USB_PHY)		+= usb/
> >  obj-$(CONFIG_USB)		+= usb/
> > diff --git a/drivers/ata/Kconfig b/drivers/ata/Kconfig
> > index e5641e6c52ee..671c27b77a48 100644
> > --- a/drivers/ata/Kconfig
> > +++ b/drivers/ata/Kconfig
> > @@ -1161,6 +1161,28 @@ config PATA_WINBOND_VLB
> >  	  Support for the Winbond W83759A controller on Vesa Local Bus
> >  	  systems.
> >  
> > +config PATA_PARPORT
> > +	tristate "Parallel port IDE device support"
> > +	depends on PARPORT_PC && PARIDE=n
> 
> This is very confusing. The change above this one switch paride
> compilation to be unconditional, regardless of CONFIG_PARIDE value, but
> here, you have the dependency to PARIDE=n. I do not understand... Please
> clarify.

pata_parport will use existing paride protocol modules. So the paride/ directory must be processed to compile the protocol modules (if they're enabled) even if paride is not enabled.

pata_parport and paride are mutually exclusive because the binary protocol modules are incompatible (the struct pi_adapter is different).

-- 
Ondrej Zary
