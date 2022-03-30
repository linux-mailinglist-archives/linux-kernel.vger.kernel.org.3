Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C29EF4ECCAD
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Mar 2022 20:49:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243680AbiC3SvN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Mar 2022 14:51:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41858 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350032AbiC3SvJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Mar 2022 14:51:09 -0400
Received: from fllv0016.ext.ti.com (fllv0016.ext.ti.com [198.47.19.142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 170CFDD5
        for <linux-kernel@vger.kernel.org>; Wed, 30 Mar 2022 11:49:23 -0700 (PDT)
Received: from fllv0035.itg.ti.com ([10.64.41.0])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 22UIn5xj022928;
        Wed, 30 Mar 2022 13:49:05 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1648666145;
        bh=wBCBCyFOJB1jndgfQo2090jJ3/rIyQsHevorUy94W+g=;
        h=Date:From:To:CC:Subject:References:In-Reply-To;
        b=Oc/xAX85u4EwCqPcwER6BCvfIxSNNwW82U4qvbil/9nL2PhhWCXC9FpA0GytgNnr+
         r1QJkR0sU9K5lRxPt6HXLTMXBGniYiAlNdpXsaED1Md2gn9x6QY60zFX2O9jVYgYgL
         TcED9o9H3xAuos6YmLzbGuyLY9enQzE6fil7jP/Q=
Received: from DLEE111.ent.ti.com (dlee111.ent.ti.com [157.170.170.22])
        by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 22UIn5bv116645
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 30 Mar 2022 13:49:05 -0500
Received: from DLEE105.ent.ti.com (157.170.170.35) by DLEE111.ent.ti.com
 (157.170.170.22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2308.14; Wed, 30
 Mar 2022 13:49:05 -0500
Received: from lelv0326.itg.ti.com (10.180.67.84) by DLEE105.ent.ti.com
 (157.170.170.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2308.14 via
 Frontend Transport; Wed, 30 Mar 2022 13:49:05 -0500
Received: from localhost (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0326.itg.ti.com (8.15.2/8.15.2) with ESMTP id 22UIn4P8020399;
        Wed, 30 Mar 2022 13:49:05 -0500
Date:   Thu, 31 Mar 2022 00:19:04 +0530
From:   Pratyush Yadav <p.yadav@ti.com>
To:     <Tudor.Ambarus@microchip.com>
CC:     <michael@walle.cc>, <miquel.raynal@bootlin.com>, <richard@nod.at>,
        <vigneshr@ti.com>, <linux-mtd@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <Nicolas.Ferre@microchip.com>
Subject: Re: [PATCH v2 4/8] mtd: spi-nor: core: Introduce method for RDID op
Message-ID: <20220330184904.mjpt2qui4lxyjw37@ti.com>
References: <20220228111712.111737-1-tudor.ambarus@microchip.com>
 <20220228111712.111737-5-tudor.ambarus@microchip.com>
 <20220321122149.dvqyml4riqkr3gqi@ti.com>
 <32b3449a-66db-3ed1-da96-47e124800500@microchip.com>
 <20220321173908.tcqx3ygo6qd62ukg@ti.com>
 <b739a03f-fe3f-7a2d-95fc-00122ca34c39@microchip.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <b739a03f-fe3f-7a2d-95fc-00122ca34c39@microchip.com>
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 30/03/22 06:53AM, Tudor.Ambarus@microchip.com wrote:
> On 3/21/22 19:39, Pratyush Yadav wrote:
> > EXTERNAL EMAIL: Do not click links or open attachments unless you know the content is safe
> > 
> > On 21/03/22 01:18PM, Tudor.Ambarus@microchip.com wrote:
> >> On 3/21/22 14:21, Pratyush Yadav wrote:
> >>> EXTERNAL EMAIL: Do not click links or open attachments unless you know the content is safe
> >>>
> >>> On 28/02/22 01:17PM, Tudor Ambarus wrote:
> >>>> RDID is used in the core to auto detect the flash, but also by some
> >>>> manufacturer drivers that contain flashes that support Octal DTR mode,
> >>>> so that they can read the flash ID after the switch to Octal DTR was made
> >>>> to test if the switch was successful. Introduce a core method for RDID op
> >>>> to avoid code duplication.
> >>>>
> >>>> Signed-off-by: Tudor Ambarus <tudor.ambarus@microchip.com>
> >>>> ---
> >>>>  drivers/mtd/spi-nor/core.c | 58 ++++++++++++++++++++++++++------------
> >>>>  drivers/mtd/spi-nor/core.h |  9 ++++++
> >>>>  2 files changed, 49 insertions(+), 18 deletions(-)
> >>>>
> >>>> diff --git a/drivers/mtd/spi-nor/core.c b/drivers/mtd/spi-nor/core.c
> >>>> index b1d6fa65417d..281e3d25f74c 100644
> >>>> --- a/drivers/mtd/spi-nor/core.c
> >>>> +++ b/drivers/mtd/spi-nor/core.c
> >>>> @@ -369,6 +369,41 @@ int spi_nor_write_disable(struct spi_nor *nor)
> >>>>       return ret;
> >>>>  }
> >>>>
> >>>> +/**
> >>>> + * spi_nor_read_id() - Read the JEDEC ID.
> >>>> + * @nor:     pointer to 'struct spi_nor'.
> >>>> + * @naddr:   number of address bytes to send. Can be zero if the operation
> >>>> + *           does not need to send an address.
> >>>> + * @ndummy:  number of dummy bytes to send after an opcode or address. Can
> >>>> + *           be zero if the operation does not require dummy bytes.
> >>>> + * @id:              pointer to a DMA-able buffer where the value of the JEDEC ID
> >>>> + *           will be written.
> >>>> + * @reg_proto:       the SPI protocol for register operation.
> >>>> + *
> >>>> + * Return: 0 on success, -errno otherwise.
> >>>> + */
> >>>> +int spi_nor_read_id(struct spi_nor *nor, u8 naddr, u8 ndummy, u8 *id,
> >>>> +                 enum spi_nor_protocol reg_proto)
> >>>
> >>> Nitpick: Could just call it 'proto'.
> >>
> >> sure, will update
> >>
> >>>
> >>>> +{
> >>>> +     int ret;
> >>>> +
> >>>> +     if (nor->spimem) {
> >>>> +             struct spi_mem_op op =
> >>>> +                     SPI_NOR_READID_OP(naddr, ndummy, id, SPI_NOR_MAX_ID_LEN);
> >>>> +
> >>>> +             spi_nor_spimem_setup_op(nor, &op, reg_proto);
> >>>> +             ret = spi_mem_exec_op(nor->spimem, &op);
> >>>> +     } else {
> >>>> +             ret = nor->controller_ops->read_reg(nor, SPINOR_OP_RDID, id,
> >>>> +                                                 SPI_NOR_MAX_ID_LEN);
> >>>> +     }
> >>>> +
> >>>> +     if (ret)
> >>>> +             dev_dbg(nor->dev, "error %d reading JEDEC ID\n", ret);
> >>>
> >>> I think this message should be in spi_nor_detect(). Let octal DTR enable
> >>
> >> As of now every SPI NOR operation that return an error also prints a dbg
> >> message. I like this because it offers a smaller granularity on the error
> >> cause.
> > 
> > Yes, but I think this message would be misleading. If someone sees
> > "error reading JEDEC ID", they would think flash detection itself has
> > failed, not that we failed to switch to Octal DTR mode.
> > 
> >>
> >>> methods print their own, more specific error messages.
> >>
> >> How about duplicating the error in the octal dtr enable methods if you
> >> feel it is worth it?
> > 
> > They should at the very least explain that reading ID failed _after_
> > attempting to switch to Octal DTR. But I think it would just be simpler
> > if this is not printed here and the caller has the flexibility to
> > explain the error.
> 
> If the first readID fails, the one that identifies the flash, then the
> octal dtr will not be run, thus a single error message. When octal dtr
> fails, 2 errors can be printed, one specifying what failed (the read ID
> command) and the second where it failed (at the octal dtr enable method).
> But I don't care too much, I'll follow your suggestion.
> 
> > 
> >>
> >>>
> >>>> +
> >>>> +     return ret;
> >>>> +}
> >>>> +
> >>>>  /**
> >>>>   * spi_nor_read_sr() - Read the Status Register.
> >>>>   * @nor:     pointer to 'struct spi_nor'.
> >>>> @@ -1649,28 +1684,15 @@ static const struct flash_info *spi_nor_match_id(struct spi_nor *nor,
> >>>>       return NULL;
> >>>>  }
> >>>>
> >>>> -static const struct flash_info *spi_nor_read_id(struct spi_nor *nor)
> >>>> +static const struct flash_info *spi_nor_detect(struct spi_nor *nor)
> >>>>  {
> >>>>       const struct flash_info *info;
> >>>>       u8 *id = nor->bouncebuf;
> >>>>       int ret;
> >>>>
> >>>> -     if (nor->spimem) {
> >>>> -             struct spi_mem_op op =
> >>>> -                     SPI_MEM_OP(SPI_MEM_OP_CMD(SPINOR_OP_RDID, 1),
> >>>> -                                SPI_MEM_OP_NO_ADDR,
> >>>> -                                SPI_MEM_OP_NO_DUMMY,
> >>>> -                                SPI_MEM_OP_DATA_IN(SPI_NOR_MAX_ID_LEN, id, 1));
> >>>> -
> >>>> -             ret = spi_mem_exec_op(nor->spimem, &op);
> >>>> -     } else {
> >>>> -             ret = nor->controller_ops->read_reg(nor, SPINOR_OP_RDID, id,
> >>>> -                                                 SPI_NOR_MAX_ID_LEN);
> >>>> -     }
> >>>> -     if (ret) {
> >>>> -             dev_dbg(nor->dev, "error %d reading JEDEC ID\n", ret);
> >>>> +     ret = spi_nor_read_id(nor, 0, 0, id, nor->reg_proto);
> >>>
> >>> Hmm, I wonder if it is better to explicitly use SNOR_PROTO_1_1_1 so
> >>> clearly signify that this is intended to use 1S-1S-1S only. What do you
> >>> think?
> >>
> >> I would keep it as it is for now, because it offers flexibility.
> >> If we ever gonna determine the protocol at runtime this will come in handy
> >> because it will work without touching the code. JESD216 suggests an algorithm
> >> that tries to determine the mode depending on the SFDP signature.
> > 
> > I was thinking exactly this but came to the opposite conclusion ;-). I
> > think this would imply that other protocols can be used to detect the
> > flash which is not true.
> 
> It can become true. As you already specified 8d-8d-8d is supported by some flashes
> and we can implement hooks for their specific 8d-8d-8d readID command. The logic
> will complicate a bit as one has to adjust the hwcaps before issuing the 8d-8d-8d
> readID, but it's doable. Otherwise, if the bootloaders pass you the flash in octal
> dtr mode, you'll have to disable it, issue readID is 1-1-1 and then re-enable it.

Right.

> 
> > 
> > But I have no strong preferences here. Either is fine by me.
> 
> I don't have strong preferences either, but it seems that there's room for discussion
> on this, so I would keep it for later. Is that fine?

Fine by me. It should be fine without the comment. It is not too hard to 
see what nor->reg_proto is initialized to.

> I can add a comment if you prefer, specifying that at this point nor->reg_proto is in
> 1-1-1 mode.

-- 
Regards,
Pratyush Yadav
Texas Instruments Inc.
