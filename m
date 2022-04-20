Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2EFA850802A
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Apr 2022 06:35:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1359301AbiDTEht (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Apr 2022 00:37:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46390 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1359299AbiDTEha (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Apr 2022 00:37:30 -0400
Received: from lelv0142.ext.ti.com (lelv0142.ext.ti.com [198.47.23.249])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4656D10CD
        for <linux-kernel@vger.kernel.org>; Tue, 19 Apr 2022 21:34:45 -0700 (PDT)
Received: from fllv0034.itg.ti.com ([10.64.40.246])
        by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 23K4YRx9068607;
        Tue, 19 Apr 2022 23:34:27 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1650429267;
        bh=Zz+ZwW1u2a70e9a3ZpME/yjw+6sAVF1thEFIAtUbgN4=;
        h=Date:From:To:CC:Subject:References:In-Reply-To;
        b=RBgGVJDyBjWYmbVrTOOmdX637J1Ci7SlUxmmUma/MBes9P5OgDTpR3NVPI3unbmT8
         jCoPQgIhpbXgoQX/2u7jukbcIOcRQZTG5ludikDJwuLCnlPZZuDz4l6ZXUWlZcz1u5
         yzaMTDEnV4fJq82K5cR4jrS52juqlWRk6hjVQzJI=
Received: from DLEE109.ent.ti.com (dlee109.ent.ti.com [157.170.170.41])
        by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 23K4YRox026463
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 19 Apr 2022 23:34:27 -0500
Received: from DLEE102.ent.ti.com (157.170.170.32) by DLEE109.ent.ti.com
 (157.170.170.41) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2308.14; Tue, 19
 Apr 2022 23:34:26 -0500
Received: from lelv0326.itg.ti.com (10.180.67.84) by DLEE102.ent.ti.com
 (157.170.170.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2308.14 via
 Frontend Transport; Tue, 19 Apr 2022 23:34:26 -0500
Received: from localhost (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0326.itg.ti.com (8.15.2/8.15.2) with ESMTP id 23K4YQLe006258;
        Tue, 19 Apr 2022 23:34:26 -0500
Date:   Wed, 20 Apr 2022 10:04:25 +0530
From:   Pratyush Yadav <p.yadav@ti.com>
To:     <Tudor.Ambarus@microchip.com>
CC:     <michael@walle.cc>, <miquel.raynal@bootlin.com>, <richard@nod.at>,
        <vigneshr@ti.com>, <linux-mtd@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <Nicolas.Ferre@microchip.com>,
        <Takahiro.Kuwano@infineon.com>
Subject: Re: [PATCH v3 6/9] mtd: spi-nor: core: Add helpers to read/write any
 register
Message-ID: <20220420043425.l77hmc4zm7cwfwdn@ti.com>
References: <20220411091033.98754-1-tudor.ambarus@microchip.com>
 <20220411091033.98754-7-tudor.ambarus@microchip.com>
 <0e4ec58c21490dcd9cf82ab89bd8c34c@walle.cc>
 <e21b0d76bf778f78f432ba27a673222d@walle.cc>
 <f318dbd9-d4bf-301a-b5c9-556d04d5bfe6@microchip.com>
 <20220419123245.zu4hypebz77ckygn@ti.com>
 <996f36b1303d191e472f56393aa6398e@walle.cc>
 <89083a31-b862-de50-fdca-d427fb908a08@microchip.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <89083a31-b862-de50-fdca-d427fb908a08@microchip.com>
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

On 19/04/22 12:56PM, Tudor.Ambarus@microchip.com wrote:
> On 4/19/22 15:46, Michael Walle wrote:
> > EXTERNAL EMAIL: Do not click links or open attachments unless you know the content is safe
> > 
> > Am 2022-04-19 14:32, schrieb Pratyush Yadav:
> >> On 19/04/22 12:08PM, Tudor.Ambarus@microchip.com wrote:
> >>> On 4/19/22 14:46, Michael Walle wrote:
> >>> > EXTERNAL EMAIL: Do not click links or open attachments unless you know the content is safe
> >>> >
> >>> > Am 2022-04-19 13:19, schrieb Michael Walle:
> >>> >> Am 2022-04-11 11:10, schrieb Tudor Ambarus:
> >>> >>> There are manufacturers that use registers indexed by address. Some of
> >>> >>> them support "read/write any register" opcodes. Provide core methods
> >>> >>> that
> >>> >>> can be used by all manufacturers. SPI NOR controller ops are
> >>> >>> intentionally
> >>> >>> not supported as we intend to move all the SPI NOR controller drivers
> >>> >>> under the SPI subsystem.
> >>> >>>
> >>> >>> Signed-off-by: Tudor Ambarus <tudor.ambarus@microchip.com>
> >>> >>> Tested-by: Takahiro Kuwano <Takahiro.Kuwano@infineon.com>
> >>> >>> Reviewed-by: Pratyush Yadav <p.yadav@ti.com>
> >>> >>
> >>> >> I still don't like it because the function doesn't do
> >>> >> anything what the function name might suggest. The read
> >>> >> just executes an op, the write executes an op with a
> >>> >> write enable before. All the behavior is determined by the
> >>> >> 'op' argument.
> >>> >>
> >>> >> Anyway,
> >>> >> Reviewed-by: Michael Walle <michael@walle.cc>
> >>> >>
> >>> >>> ---
> >>> >>> v3: no changes
> >>> >>>
> >>> >>>  drivers/mtd/spi-nor/core.c | 41
> >>> >>> ++++++++++++++++++++++++++++++++++++++
> >>> >>>  drivers/mtd/spi-nor/core.h |  4 ++++
> >>> >>>  2 files changed, 45 insertions(+)
> >>> >>>
> >>> >>> diff --git a/drivers/mtd/spi-nor/core.c b/drivers/mtd/spi-nor/core.c
> >>> >>> index 6165dc7bfd17..42794328d3b6 100644
> >>> >>> --- a/drivers/mtd/spi-nor/core.c
> >>> >>> +++ b/drivers/mtd/spi-nor/core.c
> >>> >>> @@ -307,6 +307,47 @@ ssize_t spi_nor_write_data(struct spi_nor *nor,
> >>> >>> loff_t to, size_t len,
> >>> >>>      return nor->controller_ops->write(nor, to, len, buf);
> >>> >>>  }
> >>> >>>
> >>> >>> +/**
> >>> >>> + * spi_nor_read_reg() - read register to flash memory
> >>> >>> + * @nor:        pointer to 'struct spi_nor'.
> >>> >>> + * @op:             SPI memory operation. op->data.buf must be DMA-able.
> >>> >>> + * @proto:  SPI protocol to use for the register operation.
> >>> >>> + *
> >>> >>> + * Return: zero on success, -errno otherwise
> >>> >>> + */
> >>> >>> +int spi_nor_read_reg(struct spi_nor *nor, struct spi_mem_op *op,
> >>> >>> +                 enum spi_nor_protocol proto)
> >>> >>> +{
> >>> >>> +    if (!nor->spimem)
> >>> >>> +            return -EOPNOTSUPP;
> >>> >>> +
> >>> >>> +    spi_nor_spimem_setup_op(nor, op, proto);
> >>> >>> +    return spi_nor_spimem_exec_op(nor, op);
> >>> >>> +}
> >>> >>> +
> >>> >>> +/**
> >>> >>> + * spi_nor_write_reg() - write register to flash memory
> >>> >>> + * @nor:        pointer to 'struct spi_nor'
> >>> >>> + * @op:             SPI memory operation. op->data.buf must be DMA-able.
> >>> >>> + * @proto:  SPI protocol to use for the register operation.
> >>> >>> + *
> >>> >>> + * Return: zero on success, -errno otherwise
> >>> >>> + */
> >>> >>> +int spi_nor_write_reg(struct spi_nor *nor, struct spi_mem_op *op,
> >>> >>> +                  enum spi_nor_protocol proto)
> >>> >>> +{
> >>> >>> +    int ret;
> >>> >>> +
> >>> >>> +    if (!nor->spimem)
> >>> >>> +            return -EOPNOTSUPP;
> >>> >>> +
> >>> >>> +    ret = spi_nor_write_enable(nor);
> >>> >>> +    if (ret)
> >>> >>> +            return ret;
> >>> >>> +    spi_nor_spimem_setup_op(nor, op, proto);
> >>> >>> +    return spi_nor_spimem_exec_op(nor, op);
> >>> >
> >>> > After seeing your next two patches. Shouldn't the
> >>> > spi_nor_wait_until_ready() call be here too?
> >>> >
> >>>
> >>> I thought of this too, but seems that for a reason that I don't
> >>> remember, we don't call for spi_nor_wait_until_ready after we
> >>> write the octal DTR bit. Pratyush, do you remember why?
> >>
> >> We are not sure the protocol changed correctly so we can't rely on
> >> spi_nor_wait_until_ready(). We read the ID instead to be sure.
> > 
> > So besides the fact that the write_reg only works with the 'correct'
> > op parameter, it is also tailored to the special use case. For real
> > write_reg(), the user would actually has to poll the status bit
> > afterwards? :(
> > 
> Don't be sad :D. Are the octal DTR methods an exception?
> If yes, let's add the call to spi_nor_wait_until_ready() in the
> read/write_any_reg() methods, and let the octal methods handle
> the specific write themselves, without calling for ready()

It has been a while, but IIRC I asked Cypress about this, because I was 
worried about reading ID while the switch to 8D mode was still in 
progress. They said that volatile register writes are instant and do not 
need any status polling. So the switch to 8D-8D-8D mode would be instant 
and there is no need to wait for anything.

The Cypress S28 flash datasheet does not say this explicitly. It does 
say that writing to non-volatile registers takes time and you need to 
wait for ready for those, but makes no mention of volatile registers. We 
don't ever want to write non-volatile registers so we can ignore that 
problem.

I see the Micron MT35 datasheet say this explicitly, that changes to 
volatile registers are instant.

So I would say that based on my limited sample size, volatile register 
writes for Cypress and Micron flashes do _not_ need 
spi_nor_wait_until_ready().

-- 
Regards,
Pratyush Yadav
Texas Instruments Inc.
