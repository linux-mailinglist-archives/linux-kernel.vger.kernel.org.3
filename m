Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AD6814A5A78
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Feb 2022 11:48:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236515AbiBAKsF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Feb 2022 05:48:05 -0500
Received: from lelv0142.ext.ti.com ([198.47.23.249]:37598 "EHLO
        lelv0142.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229845AbiBAKsE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Feb 2022 05:48:04 -0500
Received: from fllv0035.itg.ti.com ([10.64.41.0])
        by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 211AlUrU118559;
        Tue, 1 Feb 2022 04:47:30 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1643712450;
        bh=pGKyHfWX15eh3qo2QXJ8np7UoCYvaSlxF+7QvjQhaQE=;
        h=Date:From:To:CC:Subject:References:In-Reply-To;
        b=hVVcvR9kgztinH1mrkm+VoL1HfIBLNNXiuv2qoH11LD5P+DklIIXVcJy4CWomO1Jq
         UPwNPvZkjXJeOPu/FVts8NC3csau92OcVl/i8P6Xe+aOiVSDgUi4VmJZoIZpfh0jbI
         qMeKUuYESTDIjkP6NQ2p3F30m0Tkgoyry9MHS8LA=
Received: from DLEE114.ent.ti.com (dlee114.ent.ti.com [157.170.170.25])
        by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 211AlUIk046516
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 1 Feb 2022 04:47:30 -0600
Received: from DLEE114.ent.ti.com (157.170.170.25) by DLEE114.ent.ti.com
 (157.170.170.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2308.14; Tue, 1
 Feb 2022 04:47:28 -0600
Received: from fllv0039.itg.ti.com (10.64.41.19) by DLEE114.ent.ti.com
 (157.170.170.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2308.14 via
 Frontend Transport; Tue, 1 Feb 2022 04:47:28 -0600
Received: from localhost (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0039.itg.ti.com (8.15.2/8.15.2) with ESMTP id 211AlRLd017809;
        Tue, 1 Feb 2022 04:47:28 -0600
Date:   Tue, 1 Feb 2022 16:17:27 +0530
From:   Pratyush Yadav <p.yadav@ti.com>
To:     Miquel Raynal <miquel.raynal@bootlin.com>
CC:     Christophe Kerello <christophe.kerello@foss.st.com>,
        <richard@nod.at>, <vigneshr@ti.com>, <robh+dt@kernel.org>,
        <srinivas.kandagatla@linaro.org>, <linux-mtd@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-stm32@st-md-mailman.stormreply.com>,
        <devicetree@vger.kernel.org>, <chenshumin86@sina.com>,
        Tudor Ambarus <Tudor.Ambarus@microchip.com>
Subject: Re: [PATCH v2 4/4] mtd: core: Fix a conflict between MTD and NVMEM
 on wp-gpios property
Message-ID: <20220201104727.7xvcyexf3yucegcb@ti.com>
References: <20220131095755.8981-1-christophe.kerello@foss.st.com>
 <20220131095755.8981-5-christophe.kerello@foss.st.com>
 <20220131144309.0ffe7cc8@xps13>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20220131144309.0ffe7cc8@xps13>
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 31/01/22 02:43PM, Miquel Raynal wrote:
> Hi Vignesh, Tudory, Pratyush,
> 
> + Tudor and Pratyush
> 
> christophe.kerello@foss.st.com wrote on Mon, 31 Jan 2022 10:57:55 +0100:
> 
> > Wp-gpios property can be used on NVMEM nodes and the same property can
> > be also used on MTD NAND nodes. In case of the wp-gpios property is
> > defined at NAND level node, the GPIO management is done at NAND driver
> > level. Write protect is disabled when the driver is probed or resumed
> > and is enabled when the driver is released or suspended.
> > 
> > When no partitions are defined in the NAND DT node, then the NAND DT node
> > will be passed to NVMEM framework. If wp-gpios property is defined in
> > this node, the GPIO resource is taken twice and the NAND controller
> > driver fails to probe.
> > 
> > A new Boolean flag named skip_wp_gpio has been added in nvmem_config.
> > In case skip_wp_gpio is set, it means that the GPIO is handled by the
> > provider. Lets set this flag in MTD layer to avoid the conflict on
> > wp_gpios property.
> > 
> > Signed-off-by: Christophe Kerello <christophe.kerello@foss.st.com>
> > ---
> >  drivers/mtd/mtdcore.c | 2 ++
> >  1 file changed, 2 insertions(+)
> > 
> > diff --git a/drivers/mtd/mtdcore.c b/drivers/mtd/mtdcore.c
> > index 70f492dce158..e6d251594def 100644
> > --- a/drivers/mtd/mtdcore.c
> > +++ b/drivers/mtd/mtdcore.c
> > @@ -546,6 +546,7 @@ static int mtd_nvmem_add(struct mtd_info *mtd)
> >  	config.stride = 1;
> >  	config.read_only = true;
> >  	config.root_only = true;
> > +	config.skip_wp_gpio = true;
> >  	config.no_of_node = !of_device_is_compatible(node, "nvmem-cells");
> >  	config.priv = mtd;
> >  
> > @@ -833,6 +834,7 @@ static struct nvmem_device *mtd_otp_nvmem_register(struct mtd_info *mtd,
> >  	config.owner = THIS_MODULE;
> >  	config.type = NVMEM_TYPE_OTP;
> >  	config.root_only = true;
> > +	config.skip_wp_gpio = true;
> >  	config.reg_read = reg_read;
> >  	config.size = size;
> >  	config.of_node = np;
> 
> TLDR: There is a conflict between MTD and NVMEM, who should handle the
> WP pin when there is one? At least for raw NAND devices, I don't want
> the NVMEM core to handle the wp pin. So we've introduced this
> skip_wp_gpio nvmem config option. But there are two places where this
> boolean can be set and one of these is for otp regions (see above). In
> this case, I don't know if it is safe or if CFI/SPI-NOR rely on the
> nvmem protection. Please tell us if you think this is fine for you.

Why does NVMEM touch hardware write protection in the first place? The 
purpose of the framework is to provide a way to retrieve config stored 
in memory. It has no business dealing with details of the chip like the 
WP line. That should be MTD's job (which it should delegate to SPI NOR, 
SPI NAND, etc.). If you want to write protect a cell then do it in 
software. I don't see why NVMEM should be dealing with hardware directly 
at all.

That is my mental model of how things _should_ work. I have not spent 
much time digging into how things actually work currently.

-- 
Regards,
Pratyush Yadav
Texas Instruments Inc.
