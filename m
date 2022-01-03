Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 162C94834A5
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Jan 2022 17:17:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234210AbiACQR3 convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Mon, 3 Jan 2022 11:17:29 -0500
Received: from relay12.mail.gandi.net ([217.70.178.232]:43305 "EHLO
        relay12.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232511AbiACQR2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Jan 2022 11:17:28 -0500
Received: (Authenticated sender: miquel.raynal@bootlin.com)
        by relay12.mail.gandi.net (Postfix) with ESMTPSA id 49201200006;
        Mon,  3 Jan 2022 16:17:23 +0000 (UTC)
Date:   Mon, 3 Jan 2022 17:17:21 +0100
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     Pratyush Yadav <p.yadav@ti.com>
Cc:     Patrick Williams <patrick@stwcx.xyz>,
        Joel Stanley <joel@jms.id.au>,
        Tudor Ambarus <tudor.ambarus@microchip.com>,
        Michael Walle <michael@walle.cc>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Andrew Jeffery <andrew@aj.id.au>,
        Potin Lai <potin.lai@quantatw.com>,
        <linux-mtd@lists.infradead.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-aspeed@lists.ozlabs.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] mtd: aspeed-smc: improve probe resilience
Message-ID: <20220103171721.46c8e697@xps13>
In-Reply-To: <20211231102623.izaqlzjvracbbgmp@ti.com>
References: <20211229143334.297305-1-patrick@stwcx.xyz>
        <20211229173411.l2bipmi4x3arqjoo@ti.com>
        <Yc3Qav+ULNdF5zRT@heinlein>
        <20211231102623.izaqlzjvracbbgmp@ti.com>
Organization: Bootlin
X-Mailer: Claws Mail 3.17.7 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

p.yadav@ti.com wrote on Fri, 31 Dec 2021 15:56:25 +0530:

> Hi Patrick,
> 
> On 30/12/21 09:29AM, Patrick Williams wrote:
> > On Wed, Dec 29, 2021 at 11:04:13PM +0530, Pratyush Yadav wrote:  
> > > Hi,
> > > 
> > > On 29/12/21 08:33AM, Patrick Williams wrote:  
> >    
> > > The patch itself looks fine to me but we no longer want to maintain 
> > > drivers under drivers/mtd/spi-nor/controllers/. They should be moved to 
> > > implement the SPI MEM API (under drivers/spi/).  
> > 
> > Is the linux-aspeed community aware of this?  Are you saying you don't want to
> > take fixes for their driver into the MTD tree?  Can it be pulled into the Aspeed
> > tree?  
> 
> I am fine with taking in bug fixes but no longer want to take in any new 
> features. My main intention was to nudge you to convert it to SPI MEM 
> regardless of whether this is a bug fix or a new feature, because 
> eventually we want to get rid of drivers/mtd/spi-nor/controllers/ and 
> the API that comes along with it.

I totally agree with Pratyush here, we no longer want to support the
spi-nor controller API so if, as you say, there are boards failing
in the field, it means there are still users and these users must be
warned that at some point we might discontinue the support of these
drivers if it becomes too painful.

> As for your patch, I certainly don't want it to go via the aspeed tree.

Definitely, no.

> It should go via the MTD tree or not at all. I am not quite sure if this 
> counts as a bug fix or a new feature though.
> 
> >   
> > > Could you please volunteer to do the conversion for this driver?  
> > 
> > I'm not personally going to be able to get to it for at least the next 3 months.
> > 
> > It looks like we don't have a dedicated maintainer for this driver other than
> > Joel by nature of him being listed as the maintainer of "ARM/ASPEED MACHINE
> > SUPPORT".  I'm not sure if Aspeed themselves are planning on doing the necessary
> > refactoring here.
> > 
> > 
> > Joel, are you aware of this driver using a deprecated implementation?  Were
> > there anyone planning to do the reworks that you are aware of?  I'd like to get
> > this fix at least into the OpenBMC kernel tree because I'm seeing this fail in
> > the real world.  
> 

Thanks,
Miquèl
