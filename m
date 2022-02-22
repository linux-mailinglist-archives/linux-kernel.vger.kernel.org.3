Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2110B4BFADA
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Feb 2022 15:23:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232842AbiBVOX5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Feb 2022 09:23:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33130 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232837AbiBVOXx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Feb 2022 09:23:53 -0500
Received: from ssl.serverraum.org (ssl.serverraum.org [IPv6:2a01:4f8:151:8464::1:2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E9FA5C683D;
        Tue, 22 Feb 2022 06:23:27 -0800 (PST)
Received: from ssl.serverraum.org (web.serverraum.org [172.16.0.2])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ssl.serverraum.org (Postfix) with ESMTPSA id 2E28822205;
        Tue, 22 Feb 2022 15:23:25 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=walle.cc; s=mail2016061301;
        t=1645539805;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=p7nCyihZrTAEDIAYltsM5PtP+i9ASLLiz/HV93vby0U=;
        b=Iw0TSoTKVXkz8ttb/Kl4zBRK0FmLo3UzAVkQfMP9GJnn1rWmM8Iu0ToYmRXqiHymX9JncM
        J9E8FbJfvFIDCRH/aRjAFVOBpW3TWsisV5J8IWtwFf15GfD44ZCgAMROT+bugNfr4/qB2U
        PW4UtjEKdPJZuopkHBnoJYY71ujL3Vs=
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
 format=flowed
Content-Transfer-Encoding: 8bit
Date:   Tue, 22 Feb 2022 15:23:25 +0100
From:   Michael Walle <michael@walle.cc>
To:     Tudor.Ambarus@microchip.com
Cc:     p.yadav@ti.com, broonie@kernel.org, miquel.raynal@bootlin.com,
        richard@nod.at, vigneshr@ti.com, linux-mtd@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-spi@vger.kernel.org,
        Nicolas.Ferre@microchip.com, zhengxunli@mxic.com.tw,
        jaimeliao@mxic.com.tw
Subject: Re: [PATCH 2/4] mtd: spi-nor: core: Allow specifying the byte order
 in DTR mode
In-Reply-To: <73ff1e23-75a9-c2ed-e4a5-3dc62a957a17@microchip.com>
References: <20220218145900.1440045-1-tudor.ambarus@microchip.com>
 <20220218145900.1440045-3-tudor.ambarus@microchip.com>
 <e5d42f6e3cf9084b26e72263a8a0ddc9@walle.cc>
 <73ff1e23-75a9-c2ed-e4a5-3dc62a957a17@microchip.com>
User-Agent: Roundcube Webmail/1.4.12
Message-ID: <0d4dc33bb2720e8800199ec60aa52b26@walle.cc>
X-Sender: michael@walle.cc
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am 2022-02-22 15:02, schrieb Tudor.Ambarus@microchip.com:
> On 2/21/22 09:36, Michael Walle wrote:
>> EXTERNAL EMAIL: Do not click links or open attachments unless you know 
>> the content is safe
>> 
>> Am 2022-02-18 15:58, schrieb Tudor Ambarus:
>>> Macronix swaps bytes on a 16-bit boundary when configured in Octal 
>>> DTR.
>>> The byte order of 16-bit words is swapped when read or write written 
>>> in
>>> 8D-8D-8D mode compared to STR modes. Swapping the bytes is a bad 
>>> design
>>> decision because this may affect the boot sequence if the entire boot
>>> sequence is not handled in either 8D-8D-8D mode or 1-1-1 mode. Allow
>>> operations to specify the byte order in DTR mode, so that controllers
>>> can
>>> swap the bytes back at run-time to fix the endianness, if they are
>>> capable.
>>> 
>>> The byte order in 8D-8D-8D mode can be retrieved at run-time by
>>> checking
>>> BFPT[DWORD(18)] BIT(31). When set to one, the "Byte order of 16-bit
>>> words
>>> is swapped when read in 8D-8D-8D mode compared to 1-1-1 mode.". It
>>> doesn't
>>> specify if this applies to both register and data operations. 
>>> Macronix
>>> is
>>> the single user of this byte swap and it doesn't have clear rules, as
>>> it
>>> contains register operations that require data swap (RDPASS, WRPASS,
>>> PASSULK, RDSFDP) and register operations that don't require data swap
>>> (WRFBR). All these are not common and can be handled in 1-1-1 mode, 
>>> so
>>> we
>>> can ignore them for now. All the other register operations are done 
>>> on
>>> one
>>> byte length. The read register operations are actually in 8D-8D-8S
>>> mode,
>>> as they send the data value twice, on each half of the clock cycle. 
>>> In
>>> case
>>> of a register write of one byte, the memory supports receiving the
>>> register
>>> value only on the first byte, thus it discards the value of the byte 
>>> on
>>> the
>>> second half of the clock cycle. Swapping the bytes for one byte
>>> register
>>> writes is not required, and for one byte register reads it doesn't
>>> matter.
>>> Thus swap the bytes only for read or page program operations.
>>> 
>>> Signed-off-by: Tudor Ambarus <tudor.ambarus@microchip.com>
>>> ---
>>>  drivers/mtd/spi-nor/core.c  | 31 +++++++++++++++++++++++++------
>>>  drivers/mtd/spi-nor/core.h  |  1 +
>>>  include/linux/mtd/spi-nor.h | 17 +++++++++++++++++
>>>  3 files changed, 43 insertions(+), 6 deletions(-)
>>> 
>>> diff --git a/drivers/mtd/spi-nor/core.c b/drivers/mtd/spi-nor/core.c
>>> index 04ea180118e3..453d8c54d062 100644
>>> --- a/drivers/mtd/spi-nor/core.c
>>> +++ b/drivers/mtd/spi-nor/core.c
>>> @@ -106,6 +106,9 @@ void spi_nor_spimem_setup_op(const struct spi_nor
>>> *nor,
>>>               op->dummy.dtr = true;
>>>               op->data.dtr = true;
>>> 
>>> +             if (spi_nor_protocol_is_dtr_bswap16(proto))
>>> +                     op->data.dtr_bswap16 = true;
>>> +
>>>               /* 2 bytes per clock cycle in DTR mode. */
>>>               op->dummy.nbytes *= 2;
>>> 
>>> @@ -388,7 +391,7 @@ int spi_nor_read_sr(struct spi_nor *nor, u8 *sr)
>>>                                  SPI_MEM_OP_NO_DUMMY,
>>>                                  SPI_MEM_OP_DATA_IN(1, sr, 0));
>>> 
>>> -             if (nor->reg_proto == SNOR_PROTO_8_8_8_DTR) {
>>> +             if (spi_nor_protocol_is_octal_dtr(nor->reg_proto)) {
>>>                       op.addr.nbytes = nor->params->rdsr_addr_nbytes;
>>>                       op.dummy.nbytes = nor->params->rdsr_dummy;
>>>                       /*
>>> @@ -432,7 +435,7 @@ static int spi_nor_read_fsr(struct spi_nor *nor, 
>>> u8
>>> *fsr)
>>>                                  SPI_MEM_OP_NO_DUMMY,
>>>                                  SPI_MEM_OP_DATA_IN(1, fsr, 0));
>>> 
>>> -             if (nor->reg_proto == SNOR_PROTO_8_8_8_DTR) {
>>> +             if (spi_nor_protocol_is_octal_dtr(nor->reg_proto)) {
>>>                       op.addr.nbytes = nor->params->rdsr_addr_nbytes;
>>>                       op.dummy.nbytes = nor->params->rdsr_dummy;
>>>                       /*
>>> @@ -2488,7 +2491,7 @@ static int spi_nor_set_addr_width(struct 
>>> spi_nor
>>> *nor)
>>>  {
>>>       if (nor->addr_width) {
>>>               /* already configured from SFDP */
>>> -     } else if (nor->read_proto == SNOR_PROTO_8_8_8_DTR) {
>>> +     } else if (spi_nor_protocol_is_octal_dtr(nor->read_proto)) {
>>>               /*
>>>                * In 8D-8D-8D mode, one byte takes half a cycle to 
>>> transfer. So
>>>                * in this protocol an odd address width cannot be used 
>>> because
>>> @@ -2701,6 +2704,19 @@ static void spi_nor_init_fixup_flags(struct
>>> spi_nor *nor)
>>>               nor->flags |= SNOR_F_IO_MODE_EN_VOLATILE;
>>>  }
>>> 
>>> +static void spi_nor_set_dtr_bswap16_ops(struct spi_nor *nor)
>>> +{
>>> +     struct spi_nor_flash_parameter *params = nor->params;
>>> +     u32 mask = SNOR_HWCAPS_READ_8_8_8_DTR | 
>>> SNOR_HWCAPS_PP_8_8_8_DTR;
>>> +
>>> +     if ((params->hwcaps.mask & mask) == mask) {
>>> +             params->reads[SNOR_CMD_READ_8_8_8_DTR].proto |=
>>> +                     SNOR_PROTO_IS_DTR_BSWAP16;
>>> +             params->page_programs[SNOR_CMD_PP_8_8_8_DTR].proto |=
>>> +                     SNOR_PROTO_IS_DTR_BSWAP16;
>>> +     }
>>> +}
>>> +
>>>  /**
>>>   * spi_nor_late_init_params() - Late initialization of default flash
>>> parameters.
>>>   * @nor:     pointer to a 'struct spi_nor'
>>> @@ -2721,6 +2737,9 @@ static void spi_nor_late_init_params(struct
>>> spi_nor *nor)
>>>       spi_nor_init_flags(nor);
>>>       spi_nor_init_fixup_flags(nor);
>>> 
>>> +     if (nor->flags & SNOR_F_DTR_BSWAP16)
>>> +             spi_nor_set_dtr_bswap16_ops(nor);
>>> +
>>>       /*
>>>        * NOR protection support. When locking_ops are not provided, 
>>> we pick
>>>        * the default ones.
>>> @@ -2899,8 +2918,8 @@ static int spi_nor_octal_dtr_enable(struct
>>> spi_nor *nor, bool enable)
>>>       if (!nor->params->octal_dtr_enable)
>>>               return 0;
>>> 
>>> -     if (!(nor->read_proto == SNOR_PROTO_8_8_8_DTR &&
>>> -           nor->write_proto == SNOR_PROTO_8_8_8_DTR))
>>> +     if (!(spi_nor_protocol_is_octal_dtr(nor->read_proto) &&
>>> +           spi_nor_protocol_is_octal_dtr(nor->write_proto)))
>>>               return 0;
>>> 
>>>       if (!(nor->flags & SNOR_F_IO_MODE_EN_VOLATILE))
>>> @@ -2968,7 +2987,7 @@ static int spi_nor_init(struct spi_nor *nor)
>>>               spi_nor_try_unlock_all(nor);
>>> 
>>>       if (nor->addr_width == 4 &&
>>> -         nor->read_proto != SNOR_PROTO_8_8_8_DTR &&
>>> +         !spi_nor_protocol_is_octal_dtr(nor->read_proto) &&
>>>           !(nor->flags & SNOR_F_4B_OPCODES)) {
>>>               /*
>>>                * If the RESET# pin isn't hooked up properly, or the 
>>> system
>>> diff --git a/drivers/mtd/spi-nor/core.h b/drivers/mtd/spi-nor/core.h
>>> index 2afb610853a9..7c077d41c335 100644
>>> --- a/drivers/mtd/spi-nor/core.h
>>> +++ b/drivers/mtd/spi-nor/core.h
>>> @@ -29,6 +29,7 @@ enum spi_nor_option_flags {
>>>       SNOR_F_IO_MODE_EN_VOLATILE = BIT(14),
>>>       SNOR_F_SOFT_RESET       = BIT(15),
>>>       SNOR_F_SWP_IS_VOLATILE  = BIT(16),
>>> +     SNOR_F_DTR_BSWAP16      = BIT(17),
>>>  };
>>> 
>>>  struct spi_nor_read_command {
>>> diff --git a/include/linux/mtd/spi-nor.h 
>>> b/include/linux/mtd/spi-nor.h
>>> index fc90fce26e33..6e9660475c5b 100644
>>> --- a/include/linux/mtd/spi-nor.h
>>> +++ b/include/linux/mtd/spi-nor.h
>>> @@ -168,6 +168,11 @@
>>>        SNOR_PROTO_DATA_MASK)
>>> 
>>>  #define SNOR_PROTO_IS_DTR    BIT(24) /* Double Transfer Rate */
>>> +/*
>>> + * Byte order of 16-bit words is swapped when read or written in DTR
>>> mode
>>> + * compared to STR mode.
>>> + */
>>> +#define SNOR_PROTO_IS_DTR_BSWAP16    BIT(25)
>>> 
>>>  #define SNOR_PROTO_STR(_inst_nbits, _addr_nbits, _data_nbits)        
>>> \
>>>       (SNOR_PROTO_INST(_inst_nbits) |                         \
>>> @@ -201,6 +206,18 @@ static inline bool spi_nor_protocol_is_dtr(enum
>>> spi_nor_protocol proto)
>>>       return !!(proto & SNOR_PROTO_IS_DTR);
>>>  }
>>> 
>>> +static inline bool spi_nor_protocol_is_octal_dtr(enum 
>>> spi_nor_protocol
>>> proto)
>>> +{
>>> +     return ((proto & SNOR_PROTO_8_8_8_DTR) == 
>>> SNOR_PROTO_8_8_8_DTR);
>> 
>> This looks wrong what if there are 0's in SNOR_PROTO_8_8_8_DTR? If 
>> this
>> happens to be the same as SNOR_PROTO_MASK (which doesn't exist) this
>> deserves a comment.
> 
> I'm not sure I understand the comment. SNOR_PROTO_8_8_8_DTR has value 
> 0x80808.
> This method is added to cover the classical 8D-8D-8D mode and the 
> 8D-8D-8D mode
> with bytes swapped. This method will return true for both cases.

I know it should cover both cases, or that is what I dedcuded because
you moved the simple compare into a helper. It works in this case,
because all values just have mutually exclusive bits, thus I think this
deserves a comment.

Usually, you'd mask a field and then compare it with a value. So I'd
have expected sth like:

#define MASK (SNOR_PROTO_INST_MASK | SNOR_PROTO_ADDR_MASK | 
SNOR_PROTO_DATA_MASK)
return proto & (MASK | SNOR_PROTO_IS_DTR) == SNOR_PROTO_8_8_8_DTR;


>>> +}
>>> +
>>> +static inline bool spi_nor_protocol_is_dtr_bswap16(enum
>>> spi_nor_protocol proto)
>>> +{
>>> +     u32 mask = SNOR_PROTO_IS_DTR | SNOR_PROTO_IS_DTR_BSWAP16;
>>> +
>>> +     return ((proto & mask) == mask);
>> 
>> isn't "return proto & SNOR_PROTO_IS_DTR_BSWAP16;" enough here?
> 
> Byte swap can be done only on DTR modes. SNOR_PROTO_IS_DTR_BSWAP16
> without SNOR_PROTO_IS_DTR doesn't make sense. This method includes
> this sanity check.

I don't think this is the best place for sanity checks TBH.

-michael
