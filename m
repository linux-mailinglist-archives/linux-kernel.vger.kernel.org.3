Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5CE1A4A705B
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Feb 2022 12:54:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344013AbiBBLy2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Feb 2022 06:54:28 -0500
Received: from fllv0016.ext.ti.com ([198.47.19.142]:54578 "EHLO
        fllv0016.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231839AbiBBLyY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Feb 2022 06:54:24 -0500
Received: from fllv0035.itg.ti.com ([10.64.41.0])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 212BrUQD124243;
        Wed, 2 Feb 2022 05:53:30 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1643802810;
        bh=ZCiOlYN6uGVwo49DCOPGVRgsHZSeZjio+2Askyn+jEU=;
        h=Date:From:To:CC:Subject:References:In-Reply-To;
        b=Oe8FV/lTfcLmVGZDXiBYYSuW6er4n7IOenQBNpF3uJA3Dliw3ACK1iPNIxt0N2QyQ
         jh+YwlBhPdJpCiwuMEwjWK5yOKR3O7ipo1ZObkANAFh4AR+GmNoNVyOvaIqyGhE3Wx
         O4O1XKiw/cpSgYNtNsnRfLK1U8nX9HHvKLsVAhTI=
Received: from DLEE112.ent.ti.com (dlee112.ent.ti.com [157.170.170.23])
        by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 212BrU9N004577
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 2 Feb 2022 05:53:30 -0600
Received: from DLEE114.ent.ti.com (157.170.170.25) by DLEE112.ent.ti.com
 (157.170.170.23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2308.14; Wed, 2
 Feb 2022 05:53:28 -0600
Received: from lelv0326.itg.ti.com (10.180.67.84) by DLEE114.ent.ti.com
 (157.170.170.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2308.14 via
 Frontend Transport; Wed, 2 Feb 2022 05:53:28 -0600
Received: from localhost (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0326.itg.ti.com (8.15.2/8.15.2) with ESMTP id 212BrRl5023205;
        Wed, 2 Feb 2022 05:53:28 -0600
Date:   Wed, 2 Feb 2022 17:23:27 +0530
From:   Pratyush Yadav <p.yadav@ti.com>
To:     Christophe Kerello <christophe.kerello@foss.st.com>
CC:     Miquel Raynal <miquel.raynal@bootlin.com>, <richard@nod.at>,
        <vigneshr@ti.com>, <robh+dt@kernel.org>,
        <srinivas.kandagatla@linaro.org>, <linux-mtd@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-stm32@st-md-mailman.stormreply.com>,
        <devicetree@vger.kernel.org>, <chenshumin86@sina.com>,
        Tudor Ambarus <Tudor.Ambarus@microchip.com>,
        Khouloud Touil <ktouil@baylibre.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>
Subject: Re: [PATCH v2 4/4] mtd: core: Fix a conflict between MTD and NVMEM
 on wp-gpios property
Message-ID: <20220202115327.53oqg5n7tx6b6q7u@ti.com>
References: <20220131095755.8981-1-christophe.kerello@foss.st.com>
 <20220131095755.8981-5-christophe.kerello@foss.st.com>
 <20220131144309.0ffe7cc8@xps13>
 <20220201104727.7xvcyexf3yucegcb@ti.com>
 <eebfa629-ead2-d63f-9cfb-4cafc1534678@foss.st.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <eebfa629-ead2-d63f-9cfb-4cafc1534678@foss.st.com>
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

+ Khouloud, Linus, Bartosz

On 02/02/22 11:44AM, Christophe Kerello wrote:
> Hi,
> 
> On 2/1/22 11:47, Pratyush Yadav wrote:
> > On 31/01/22 02:43PM, Miquel Raynal wrote:
> > > Hi Vignesh, Tudory, Pratyush,
> > > 
> > > + Tudor and Pratyush
> > > 
> > > christophe.kerello@foss.st.com wrote on Mon, 31 Jan 2022 10:57:55 +0100:
> > > 
> > > > Wp-gpios property can be used on NVMEM nodes and the same property can
> > > > be also used on MTD NAND nodes. In case of the wp-gpios property is
> > > > defined at NAND level node, the GPIO management is done at NAND driver
> > > > level. Write protect is disabled when the driver is probed or resumed
> > > > and is enabled when the driver is released or suspended.
> > > > 
> > > > When no partitions are defined in the NAND DT node, then the NAND DT node
> > > > will be passed to NVMEM framework. If wp-gpios property is defined in
> > > > this node, the GPIO resource is taken twice and the NAND controller
> > > > driver fails to probe.
> > > > 
> > > > A new Boolean flag named skip_wp_gpio has been added in nvmem_config.
> > > > In case skip_wp_gpio is set, it means that the GPIO is handled by the
> > > > provider. Lets set this flag in MTD layer to avoid the conflict on
> > > > wp_gpios property.
> > > > 
> > > > Signed-off-by: Christophe Kerello <christophe.kerello@foss.st.com>
> > > > ---
> > > >   drivers/mtd/mtdcore.c | 2 ++
> > > >   1 file changed, 2 insertions(+)
> > > > 
> > > > diff --git a/drivers/mtd/mtdcore.c b/drivers/mtd/mtdcore.c
> > > > index 70f492dce158..e6d251594def 100644
> > > > --- a/drivers/mtd/mtdcore.c
> > > > +++ b/drivers/mtd/mtdcore.c
> > > > @@ -546,6 +546,7 @@ static int mtd_nvmem_add(struct mtd_info *mtd)
> > > >   	config.stride = 1;
> > > >   	config.read_only = true;
> > > >   	config.root_only = true;
> > > > +	config.skip_wp_gpio = true;
> > > >   	config.no_of_node = !of_device_is_compatible(node, "nvmem-cells");
> > > >   	config.priv = mtd;
> > > > @@ -833,6 +834,7 @@ static struct nvmem_device *mtd_otp_nvmem_register(struct mtd_info *mtd,
> > > >   	config.owner = THIS_MODULE;
> > > >   	config.type = NVMEM_TYPE_OTP;
> > > >   	config.root_only = true;
> > > > +	config.skip_wp_gpio = true;
> > > >   	config.reg_read = reg_read;
> > > >   	config.size = size;
> > > >   	config.of_node = np;
> > > 
> > > TLDR: There is a conflict between MTD and NVMEM, who should handle the
> > > WP pin when there is one? At least for raw NAND devices, I don't want
> > > the NVMEM core to handle the wp pin. So we've introduced this
> > > skip_wp_gpio nvmem config option. But there are two places where this
> > > boolean can be set and one of these is for otp regions (see above). In
> > > this case, I don't know if it is safe or if CFI/SPI-NOR rely on the
> > > nvmem protection. Please tell us if you think this is fine for you.
> > 
> > Why does NVMEM touch hardware write protection in the first place? The
> > purpose of the framework is to provide a way to retrieve config stored
> > in memory. It has no business dealing with details of the chip like the
> > WP line. That should be MTD's job (which it should delegate to SPI NOR,
> > SPI NAND, etc.). If you want to write protect a cell then do it in
> > software. I don't see why NVMEM should be dealing with hardware directly
> > at all.
> > 
> > That is my mental model of how things _should_ work. I have not spent
> > much time digging into how things actually work currently.
> > 
> 
> Wp-gpios property management was added in MVMEM framework in January 2020 =>
> sha1: 2a127da461a9d8d97782d6e82b227041393eb4d2
> "
>     nvmem: add support for the write-protect pin
> 
>     The write-protect pin handling looks like a standard property that
>     could benefit other users if available in the core nvmem framework.
> 
>     Instead of modifying all the memory drivers to check this pin, make
>     the NVMEM subsystem check if the write-protect GPIO being passed
>     through the nvmem_config or defined in the device tree and pull it
>     low whenever writing to the memory.
> "
> 
> And this modification was done for EEPROMs flashes => sha1:
> 1c89074bf85068d1b86f2e0f0c2110fdd9b83c9f
> "
>     eeprom: at24: remove the write-protect pin support
> 
>     NVMEM framework is an interface for the at24 EEPROMs as well as for
>     other drivers, instead of passing the wp-gpios over the different
>     drivers each time, it would be better to pass it over the NVMEM
>     subsystem once and for all.
> 
>     Removing the support for the write-protect pin after adding it to
>     the NVMEM subsystem.
> "
> 
> Current NVMEM framework implementation toggles the WP GPIO when reg_write
> nvmem_config API is defined. In case of MTD framework, reg_write is not
> defined in nvmem_config.

Thanks for digging these up. I think this was the wrong decision to 
make. NVMEM should just provide the APIs for handling read/write, and 
leave the rest to the drivers.

It might be convenient for some drivers to put the WP GPIO handling to 
NVMEM core but I just don't think it is the job of the framework to deal 
with this, and it just does not know enough about the device to deal 
with correctly and completely anyway. For example, wp-gpio is only one 
of the ways to write protect a chip. SPI NOR flashes have a WP# pin that 
is often toggled via the SPI controller. There could also be registers 
that do the write protection.

One would have to make strong justifications for making nvmem directly 
deal with hardware level details to convince me it is a good idea. IMHO 
if AT24 EEPROM is the only driver relying on this as of now then we 
should just revert the patches and not have to deal with the 
skip_wp_gpio hackery.

> 
> Based on the comments made, it seems that we also agree that this write
> protection should be handled by MTD subsystems or associated drivers and not
> by MVMEN framework for MTD use cases.
> 
> The proposal implementation should solve this conflict for MTD framework
> without breaking anything for others NVMEM users (EEPROMs flashes for
> example).

-- 
Regards,
Pratyush Yadav
Texas Instruments Inc.
