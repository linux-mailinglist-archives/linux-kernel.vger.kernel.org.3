Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 73C3D499757
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jan 2022 22:27:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353106AbiAXVMn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Jan 2022 16:12:43 -0500
Received: from lelv0143.ext.ti.com ([198.47.23.248]:53518 "EHLO
        lelv0143.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347091AbiAXUhs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Jan 2022 15:37:48 -0500
Received: from lelv0265.itg.ti.com ([10.180.67.224])
        by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 20OKbA1c060580;
        Mon, 24 Jan 2022 14:37:10 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1643056630;
        bh=qUb5l1wvstsaPaKzYhWNVfh1pZulWuLaYHyPrA3IFH4=;
        h=Date:From:To:CC:Subject:References:In-Reply-To;
        b=IAnVdVYHgM5sljUjoshj/J0HdPU633rqTFUiqrDA8m7vxFeLaXBPq2MMBBKdQ6I7R
         ZcIFj/lKutP8PmV5TPekteMR0vnp9qlzS93saVQz1QCZJMwl6ckmoSXru06LbK+/rt
         J5U9Lrob6JONeeLJw65qOzcccXg8pdhrQ5CMCxxw=
Received: from DLEE112.ent.ti.com (dlee112.ent.ti.com [157.170.170.23])
        by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 20OKbAJi026882
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 24 Jan 2022 14:37:10 -0600
Received: from DLEE101.ent.ti.com (157.170.170.31) by DLEE112.ent.ti.com
 (157.170.170.23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2308.14; Mon, 24
 Jan 2022 14:37:09 -0600
Received: from lelv0327.itg.ti.com (10.180.67.183) by DLEE101.ent.ti.com
 (157.170.170.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2308.14 via
 Frontend Transport; Mon, 24 Jan 2022 14:37:10 -0600
Received: from localhost (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0327.itg.ti.com (8.15.2/8.15.2) with ESMTP id 20OKb9WV043785;
        Mon, 24 Jan 2022 14:37:09 -0600
Date:   Tue, 25 Jan 2022 02:07:08 +0530
From:   Pratyush Yadav <p.yadav@ti.com>
To:     =?utf-8?Q?C=C3=A9dric?= Le Goater <clg@kaod.org>
CC:     Patrick Williams <patrick@stwcx.xyz>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        <linux-aspeed@lists.ozlabs.org>,
        Tudor Ambarus <tudor.ambarus@microchip.com>,
        Richard Weinberger <richard@nod.at>,
        Potin Lai <potin.lai@quantatw.com>,
        <linux-kernel@vger.kernel.org>, Michael Walle <michael@walle.cc>,
        <linux-mtd@lists.infradead.org>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        <linux-arm-kernel@lists.infradead.org>
Subject: Re: [PATCH] mtd: aspeed-smc: improve probe resilience
Message-ID: <20220124203708.lm23sgsub234wlhq@ti.com>
References: <20211229143334.297305-1-patrick@stwcx.xyz>
 <20211229173411.l2bipmi4x3arqjoo@ti.com>
 <Yc3Qav+ULNdF5zRT@heinlein>
 <20211231102623.izaqlzjvracbbgmp@ti.com>
 <20220103171721.46c8e697@xps13>
 <YdSP6tKyQ2ZRUC+2@heinlein>
 <20220105063244.lno3xur64uepa7i5@ti.com>
 <d4ba6413-57ce-14c1-ed48-d00db2f74bd3@kaod.org>
 <20220124153644.m3iwlvq5ld5cpbyz@ti.com>
 <b222361a-288a-55b2-fc02-04c0b93b4220@kaod.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <b222361a-288a-55b2-fc02-04c0b93b4220@kaod.org>
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 24/01/22 07:34PM, Cédric Le Goater wrote:
> > > spimem needs an extension I think. Sorry I have not been able to
> > > push that forward. Lack of time and other tasks to address on the
> > > host side of the machine. This is really a software problem, we
> > > have the HW procedures ready. If a spimem expert could get involved
> > > to make a few proposals, I would be happy to help and do some testing.
> > > QEMU models are good enough for the software part. We can do the
> > > training validation on real HW when ready.
> > 
> > What information about the flash do you need for this training?
> 
> Last time I looked, we lacked some post_init handler to setup a slave:
> configure the registers defining the AHB windows for each flash
> slave and perform the read timing calibration. calibration should
> only be done once.
> 
> See how the aspeed_spi_flash_init() routine doing the calibration
> is hooked up under aspeed_spi_claim_bus() in the u-boot driver :

My patch series should provide a hook for doing the calibration _after_ 
the flash is initialized.

> 
>   https://github.com/openbmc/u-boot/blob/v2019.04-aspeed-openbmc/drivers/spi/aspeed_spi.c
> 
> Not good enough for upstream, Linux would be the same :/
> 
> > I proposed a patch series [0] some time ago trying to implement training
> > for TI SoCs. It did not get merged but I do intend to respin it and get
> > it through. Would this API work for your tuning as well?
> 
> I will take a look.
> > Also, I am curious how your training works. What data do you read for
> > training delays? Where is it stored?
> 
> The driver reads the first 16K at slow speed (that's why we need a
> basic minimal setup of the slave) and checks if the buffer is valid
> enough for the calibration :
> 
>   https://github.com/openbmc/linux/blob/dev-5.15/drivers/mtd/spi-nor/controllers/aspeed-smc.c#L998
> 
> it then performs reads by changing the frequency and delays and
> compares results with the initial default buffer.

This seems similar to the tuning I implemented, except mine uses a 
pre-defined pattern at a pre-defined location.

> 
> if not, then the driver stays in a safe mode (slow).

Same for my patches.

> 
> > In our case we need to flash a
> > known pattern at some location (which is passed in via DT). Do you need
> > to run it for every read transaction or just once after the flash is
> > initialized?
> 
> Just once because it is a heavy process. See the debug outputs below.
> Once we have good read timings and frequency, there is no need to do
> it each time.

It looks very similar to the tuning I implemented in my patch series. 
You should be able to use those APIs for your tuning as well. But it 
should not block the SPI MEM port. The current upstream driver does not 
seem to implement this tuning anyway.

> 
> > [0] https://patchwork.ozlabs.org/project/linux-mtd/list/?series=233504&state=%2A&archive=both
> Thanks,
> 
> C.

-- 
Regards,
Pratyush Yadav
Texas Instruments Inc.
