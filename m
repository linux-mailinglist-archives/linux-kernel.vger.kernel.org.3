Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B29A54815DB
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Dec 2021 18:35:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241150AbhL2RfO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Dec 2021 12:35:14 -0500
Received: from fllv0016.ext.ti.com ([198.47.19.142]:35928 "EHLO
        fllv0016.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241148AbhL2RfJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Dec 2021 12:35:09 -0500
Received: from lelv0266.itg.ti.com ([10.180.67.225])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 1BTHYEKI102720;
        Wed, 29 Dec 2021 11:34:14 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1640799254;
        bh=geHRPj+zktb+R6F/05xIvOw3rx4VPqd5Q0cfOksBj3w=;
        h=Date:From:To:CC:Subject:References:In-Reply-To;
        b=YFOO0keGlSsFfQcVgkftiXsFveC8oP0NVpJHooV01SzJJ2IXR5En2DcT162gMHUSH
         ajQBdHlSIcDyb82udAqsp0Rhszi4z3sbXQMncFX5iYpNeSwLu3JUyl9ytuyTtg8wtp
         NU+7asdTzHtfI38xC+ABMKUwifKY8kR51PV4Yz+A=
Received: from DFLE111.ent.ti.com (dfle111.ent.ti.com [10.64.6.32])
        by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 1BTHYE48069336
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 29 Dec 2021 11:34:14 -0600
Received: from DFLE106.ent.ti.com (10.64.6.27) by DFLE111.ent.ti.com
 (10.64.6.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2308.14; Wed, 29
 Dec 2021 11:34:14 -0600
Received: from lelv0326.itg.ti.com (10.180.67.84) by DFLE106.ent.ti.com
 (10.64.6.27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2308.14 via
 Frontend Transport; Wed, 29 Dec 2021 11:34:14 -0600
Received: from localhost (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0326.itg.ti.com (8.15.2/8.15.2) with ESMTP id 1BTHYDdT008970;
        Wed, 29 Dec 2021 11:34:14 -0600
Date:   Wed, 29 Dec 2021 23:04:13 +0530
From:   Pratyush Yadav <p.yadav@ti.com>
To:     Patrick Williams <patrick@stwcx.xyz>
CC:     Tudor Ambarus <tudor.ambarus@microchip.com>,
        Michael Walle <michael@walle.cc>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Joel Stanley <joel@jms.id.au>,
        Andrew Jeffery <andrew@aj.id.au>,
        Potin Lai <potin.lai@quantatw.com>,
        <linux-mtd@lists.infradead.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-aspeed@lists.ozlabs.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] mtd: aspeed-smc: improve probe resilience
Message-ID: <20211229173411.l2bipmi4x3arqjoo@ti.com>
References: <20211229143334.297305-1-patrick@stwcx.xyz>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20211229143334.297305-1-patrick@stwcx.xyz>
User-Agent: NeoMutt/20171215
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 29/12/21 08:33AM, Patrick Williams wrote:
> The aspeed-smc can have multiple SPI devices attached to it in the
> device tree.  If one of the devices is missing or failing the entire
> probe will fail and all MTD devices under the controller will be
> removed.  On OpenBMC this results in a kernel panic due to missing
> rootfs:
> 
> [    0.538774] aspeed-smc 1e620000.spi: Using 50 MHz SPI frequency
> [    0.540471] aspeed-smc 1e620000.spi: w25q01jv-iq (131072 Kbytes)
> [    0.540750] aspeed-smc 1e620000.spi: CE0 window [ 0x20000000 - 0x28000000 ] 128MB
> [    0.540943] aspeed-smc 1e620000.spi: CE1 window [ 0x28000000 - 0x2c000000 ] 64MB
> [    0.541143] aspeed-smc 1e620000.spi: read control register: 203b0041
> [    0.581442] 5 fixed-partitions partitions found on MTD device bmc
> [    0.581625] Creating 5 MTD partitions on "bmc":
> [    0.581854] 0x000000000000-0x0000000e0000 : "u-boot"
> [    0.584472] 0x0000000e0000-0x000000100000 : "u-boot-env"
> [    0.586468] 0x000000100000-0x000000a00000 : "kernel"
> [    0.588465] 0x000000a00000-0x000006000000 : "rofs"
> [    0.590552] 0x000006000000-0x000008000000 : "rwfs"
> [    0.592605] aspeed-smc 1e620000.spi: Using 50 MHz SPI frequency
> [    0.592801] aspeed-smc 1e620000.spi: unrecognized JEDEC id bytes: 00 00 00 00 00 00
> [    0.593039] Deleting MTD partitions on "bmc":
> [    0.593175] Deleting u-boot MTD partition
> [    0.637929] Deleting u-boot-env MTD partition
> [    0.829527] Deleting kernel MTD partition
> [    0.856902] Freeing initrd memory: 1032K
> [    0.866428] Deleting rofs MTD partition
> [    0.906264] Deleting rwfs MTD partition
> [    0.986628] aspeed-smc 1e620000.spi: Aspeed SMC probe failed -2
> [    0.986929] aspeed-smc: probe of 1e620000.spi failed with error -2
> ...
> [    2.936719] /dev/mtdblock: Can't open blockdev
> mount: mounting /dev/mtdblock on run/initramfs/ro failed: No such file or directory
> [    2.963030] MTD: Couldn't look up '/dev/mtdblock': -2
> mount: mounting /dev/mtdblock on run/initramfs/rw failed: No such file or directory
> 
> Mounting read-write /dev/mtdblock filesystem failed.  Please fix and run
> 	mount /dev/mtdblock run/initramfs/rw -t jffs2 -o rw
> or perform a factory reset with the clean-rwfs-filesystem option.
> Fatal error, triggering kernel panic!
> [    3.013047] Kernel panic - not syncing: Attempted to kill init! exitcode=0x00000100
> 
> Many BMC designs have two flash chips so that they can handle a hardware
> failure of one of them.  If one chip failed, it doesn't do any good to
> have redundancy if they all get removed anyhow.
> 
> Improve the resilience of the probe function to handle one of the
> children being missing or failed.  Only in the case where all children
> fail to probe should the controller be failed out.

The patch itself looks fine to me but we no longer want to maintain 
drivers under drivers/mtd/spi-nor/controllers/. They should be moved to 
implement the SPI MEM API (under drivers/spi/). See [0][1] for a couple 
examples. Could you please volunteer to do the conversion for this 
driver?

[0] https://patchwork.ozlabs.org/project/linux-mtd/patch/20200601070444.16923-8-vigneshr@ti.com/
[1] https://patchwork.ozlabs.org/project/linux-mtd/patch/20211220164625.9400-3-mika.westerberg@linux.intel.com/

-- 
Regards,
Pratyush Yadav
Texas Instruments Inc.
