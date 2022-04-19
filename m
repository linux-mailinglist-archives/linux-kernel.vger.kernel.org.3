Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 30C97506C84
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Apr 2022 14:33:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243151AbiDSMf4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Apr 2022 08:35:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53604 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231693AbiDSMfx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Apr 2022 08:35:53 -0400
Received: from lelv0142.ext.ti.com (lelv0142.ext.ti.com [198.47.23.249])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE68422500
        for <linux-kernel@vger.kernel.org>; Tue, 19 Apr 2022 05:33:10 -0700 (PDT)
Received: from lelv0266.itg.ti.com ([10.180.67.225])
        by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 23JCWlVZ090706;
        Tue, 19 Apr 2022 07:32:47 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1650371567;
        bh=7pUxGX1NMNsUpg+kjZ7UPIQay8LquMeobEccHiyqJ3o=;
        h=Date:From:To:CC:Subject:References:In-Reply-To;
        b=Pu9Srcn5KCAPnw35f14Zdc8hpSi44oYqdO/0I6BZbbNUhSU4wZEg8gfxlTbGDaqaq
         YTaMUbMihF3MKH7iiEzdyIksndNvyYCuWXiiaoEjhLCxD24gMqN6efRpIFYM+qxB94
         XEBbOv+Ojw5QK6hbXiFn3DjMq2ZMRbXF6vwrLuDM=
Received: from DFLE112.ent.ti.com (dfle112.ent.ti.com [10.64.6.33])
        by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 23JCWlGT037011
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 19 Apr 2022 07:32:47 -0500
Received: from DFLE105.ent.ti.com (10.64.6.26) by DFLE112.ent.ti.com
 (10.64.6.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2308.14; Tue, 19
 Apr 2022 07:32:46 -0500
Received: from fllv0039.itg.ti.com (10.64.41.19) by DFLE105.ent.ti.com
 (10.64.6.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2308.14 via
 Frontend Transport; Tue, 19 Apr 2022 07:32:46 -0500
Received: from localhost (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0039.itg.ti.com (8.15.2/8.15.2) with ESMTP id 23JCWkpC008529;
        Tue, 19 Apr 2022 07:32:46 -0500
Date:   Tue, 19 Apr 2022 18:02:45 +0530
From:   Pratyush Yadav <p.yadav@ti.com>
To:     <Tudor.Ambarus@microchip.com>
CC:     <michael@walle.cc>, <miquel.raynal@bootlin.com>, <richard@nod.at>,
        <vigneshr@ti.com>, <linux-mtd@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <Nicolas.Ferre@microchip.com>,
        <Takahiro.Kuwano@infineon.com>
Subject: Re: [PATCH v3 6/9] mtd: spi-nor: core: Add helpers to read/write any
 register
Message-ID: <20220419123245.zu4hypebz77ckygn@ti.com>
References: <20220411091033.98754-1-tudor.ambarus@microchip.com>
 <20220411091033.98754-7-tudor.ambarus@microchip.com>
 <0e4ec58c21490dcd9cf82ab89bd8c34c@walle.cc>
 <e21b0d76bf778f78f432ba27a673222d@walle.cc>
 <f318dbd9-d4bf-301a-b5c9-556d04d5bfe6@microchip.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <f318dbd9-d4bf-301a-b5c9-556d04d5bfe6@microchip.com>
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 19/04/22 12:08PM, Tudor.Ambarus@microchip.com wrote:
> On 4/19/22 14:46, Michael Walle wrote:
> > EXTERNAL EMAIL: Do not click links or open attachments unless you know the content is safe
> > 
> > Am 2022-04-19 13:19, schrieb Michael Walle:
> >> Am 2022-04-11 11:10, schrieb Tudor Ambarus:
> >>> There are manufacturers that use registers indexed by address. Some of
> >>> them support "read/write any register" opcodes. Provide core methods
> >>> that
> >>> can be used by all manufacturers. SPI NOR controller ops are
> >>> intentionally
> >>> not supported as we intend to move all the SPI NOR controller drivers
> >>> under the SPI subsystem.
> >>>
> >>> Signed-off-by: Tudor Ambarus <tudor.ambarus@microchip.com>
> >>> Tested-by: Takahiro Kuwano <Takahiro.Kuwano@infineon.com>
> >>> Reviewed-by: Pratyush Yadav <p.yadav@ti.com>
> >>
> >> I still don't like it because the function doesn't do
> >> anything what the function name might suggest. The read
> >> just executes an op, the write executes an op with a
> >> write enable before. All the behavior is determined by the
> >> 'op' argument.
> >>
> >> Anyway,
> >> Reviewed-by: Michael Walle <michael@walle.cc>
> >>
> >>> ---
> >>> v3: no changes
> >>>
> >>>  drivers/mtd/spi-nor/core.c | 41
> >>> ++++++++++++++++++++++++++++++++++++++
> >>>  drivers/mtd/spi-nor/core.h |  4 ++++
> >>>  2 files changed, 45 insertions(+)
> >>>
> >>> diff --git a/drivers/mtd/spi-nor/core.c b/drivers/mtd/spi-nor/core.c
> >>> index 6165dc7bfd17..42794328d3b6 100644
> >>> --- a/drivers/mtd/spi-nor/core.c
> >>> +++ b/drivers/mtd/spi-nor/core.c
> >>> @@ -307,6 +307,47 @@ ssize_t spi_nor_write_data(struct spi_nor *nor,
> >>> loff_t to, size_t len,
> >>>      return nor->controller_ops->write(nor, to, len, buf);
> >>>  }
> >>>
> >>> +/**
> >>> + * spi_nor_read_reg() - read register to flash memory
> >>> + * @nor:        pointer to 'struct spi_nor'.
> >>> + * @op:             SPI memory operation. op->data.buf must be DMA-able.
> >>> + * @proto:  SPI protocol to use for the register operation.
> >>> + *
> >>> + * Return: zero on success, -errno otherwise
> >>> + */
> >>> +int spi_nor_read_reg(struct spi_nor *nor, struct spi_mem_op *op,
> >>> +                 enum spi_nor_protocol proto)
> >>> +{
> >>> +    if (!nor->spimem)
> >>> +            return -EOPNOTSUPP;
> >>> +
> >>> +    spi_nor_spimem_setup_op(nor, op, proto);
> >>> +    return spi_nor_spimem_exec_op(nor, op);
> >>> +}
> >>> +
> >>> +/**
> >>> + * spi_nor_write_reg() - write register to flash memory
> >>> + * @nor:        pointer to 'struct spi_nor'
> >>> + * @op:             SPI memory operation. op->data.buf must be DMA-able.
> >>> + * @proto:  SPI protocol to use for the register operation.
> >>> + *
> >>> + * Return: zero on success, -errno otherwise
> >>> + */
> >>> +int spi_nor_write_reg(struct spi_nor *nor, struct spi_mem_op *op,
> >>> +                  enum spi_nor_protocol proto)
> >>> +{
> >>> +    int ret;
> >>> +
> >>> +    if (!nor->spimem)
> >>> +            return -EOPNOTSUPP;
> >>> +
> >>> +    ret = spi_nor_write_enable(nor);
> >>> +    if (ret)
> >>> +            return ret;
> >>> +    spi_nor_spimem_setup_op(nor, op, proto);
> >>> +    return spi_nor_spimem_exec_op(nor, op);
> > 
> > After seeing your next two patches. Shouldn't the
> > spi_nor_wait_until_ready() call be here too?
> > 
> 
> I thought of this too, but seems that for a reason that I don't
> remember, we don't call for spi_nor_wait_until_ready after we
> write the octal DTR bit. Pratyush, do you remember why?

We are not sure the protocol changed correctly so we can't rely on 
spi_nor_wait_until_ready(). We read the ID instead to be sure.

-- 
Regards,
Pratyush Yadav
Texas Instruments Inc.
