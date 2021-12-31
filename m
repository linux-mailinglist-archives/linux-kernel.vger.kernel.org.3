Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 972DE482352
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Dec 2021 11:27:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230071AbhLaK1F (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 31 Dec 2021 05:27:05 -0500
Received: from lelv0142.ext.ti.com ([198.47.23.249]:51688 "EHLO
        lelv0142.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229565AbhLaK1E (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Dec 2021 05:27:04 -0500
Received: from fllv0034.itg.ti.com ([10.64.40.246])
        by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 1BVAQRXS032981;
        Fri, 31 Dec 2021 04:26:27 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1640946387;
        bh=bpUJPGgi/5Jx8j2h6g3oXESZgoh1z7lVwijB7GXIvPY=;
        h=Date:From:To:CC:Subject:References:In-Reply-To;
        b=I9dhu3YnYCdPQV5wZhyOYljCW4hQ7M3JSxn0R/O6sq2J2xXbx2ZcHqiNzlLS9Ij7z
         flBelTZNcsrNHIBW/GTR9RiIIcbJpXDj0KeAUDldhNPbd7Vq52rYRgMLdvzap4QbUx
         JxYHXmup4QljSyZRiZHqqrq0kq57+0xMFGxWlizY=
Received: from DLEE115.ent.ti.com (dlee115.ent.ti.com [157.170.170.26])
        by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 1BVAQR5s023694
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Fri, 31 Dec 2021 04:26:27 -0600
Received: from DLEE110.ent.ti.com (157.170.170.21) by DLEE115.ent.ti.com
 (157.170.170.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2308.14; Fri, 31
 Dec 2021 04:26:27 -0600
Received: from fllv0040.itg.ti.com (10.64.41.20) by DLEE110.ent.ti.com
 (157.170.170.21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2308.14 via
 Frontend Transport; Fri, 31 Dec 2021 04:26:27 -0600
Received: from localhost (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0040.itg.ti.com (8.15.2/8.15.2) with ESMTP id 1BVAQQ7k052825;
        Fri, 31 Dec 2021 04:26:26 -0600
Date:   Fri, 31 Dec 2021 15:56:25 +0530
From:   Pratyush Yadav <p.yadav@ti.com>
To:     Patrick Williams <patrick@stwcx.xyz>
CC:     Joel Stanley <joel@jms.id.au>,
        Tudor Ambarus <tudor.ambarus@microchip.com>,
        Michael Walle <michael@walle.cc>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Andrew Jeffery <andrew@aj.id.au>,
        Potin Lai <potin.lai@quantatw.com>,
        <linux-mtd@lists.infradead.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-aspeed@lists.ozlabs.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] mtd: aspeed-smc: improve probe resilience
Message-ID: <20211231102623.izaqlzjvracbbgmp@ti.com>
References: <20211229143334.297305-1-patrick@stwcx.xyz>
 <20211229173411.l2bipmi4x3arqjoo@ti.com>
 <Yc3Qav+ULNdF5zRT@heinlein>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <Yc3Qav+ULNdF5zRT@heinlein>
User-Agent: NeoMutt/20171215
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Patrick,

On 30/12/21 09:29AM, Patrick Williams wrote:
> On Wed, Dec 29, 2021 at 11:04:13PM +0530, Pratyush Yadav wrote:
> > Hi,
> > 
> > On 29/12/21 08:33AM, Patrick Williams wrote:
>  
> > The patch itself looks fine to me but we no longer want to maintain 
> > drivers under drivers/mtd/spi-nor/controllers/. They should be moved to 
> > implement the SPI MEM API (under drivers/spi/).
> 
> Is the linux-aspeed community aware of this?  Are you saying you don't want to
> take fixes for their driver into the MTD tree?  Can it be pulled into the Aspeed
> tree?

I am fine with taking in bug fixes but no longer want to take in any new 
features. My main intention was to nudge you to convert it to SPI MEM 
regardless of whether this is a bug fix or a new feature, because 
eventually we want to get rid of drivers/mtd/spi-nor/controllers/ and 
the API that comes along with it.

As for your patch, I certainly don't want it to go via the aspeed tree. 
It should go via the MTD tree or not at all. I am not quite sure if this 
counts as a bug fix or a new feature though.

> 
> > Could you please volunteer to do the conversion for this driver?
> 
> I'm not personally going to be able to get to it for at least the next 3 months.
> 
> It looks like we don't have a dedicated maintainer for this driver other than
> Joel by nature of him being listed as the maintainer of "ARM/ASPEED MACHINE
> SUPPORT".  I'm not sure if Aspeed themselves are planning on doing the necessary
> refactoring here.
> 
> 
> Joel, are you aware of this driver using a deprecated implementation?  Were
> there anyone planning to do the reworks that you are aware of?  I'd like to get
> this fix at least into the OpenBMC kernel tree because I'm seeing this fail in
> the real world.

-- 
Regards,
Pratyush Yadav
Texas Instruments Inc.
