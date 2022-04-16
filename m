Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E9A3F503741
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Apr 2022 17:03:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232381AbiDPPGL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 16 Apr 2022 11:06:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48786 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231328AbiDPPGJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 16 Apr 2022 11:06:09 -0400
Received: from ssl.serverraum.org (ssl.serverraum.org [176.9.125.105])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CF3ACB47
        for <linux-kernel@vger.kernel.org>; Sat, 16 Apr 2022 08:03:36 -0700 (PDT)
Received: from ssl.serverraum.org (web.serverraum.org [172.16.0.2])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ssl.serverraum.org (Postfix) with ESMTPSA id 7D7FE22247;
        Sat, 16 Apr 2022 17:03:34 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=walle.cc; s=mail2016061301;
        t=1650121414;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=3R88hZdaZDhNwsTg+vXMMs2+aEstni2HQyKdsyD+vWk=;
        b=W09hpofDzOSDDKkKdVkVEA/Nu9WyBtvObgd4JnxHHgNzb/KhsR2/lOa0HArgOd4y9CuJPV
        cbmj1QSQERuR4WaQs8OuGvv1fX8fge8LeH+m+QMWVRjpvBGMG0aOwKquupRQ14G7js1Bgv
        yihUacbF5m3YrT5Fjhu11vlspUpo4Uc=
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
 format=flowed
Content-Transfer-Encoding: 8bit
Date:   Sat, 16 Apr 2022 17:03:34 +0200
From:   Michael Walle <michael@walle.cc>
To:     Tudor.Ambarus@microchip.com
Cc:     p.yadav@ti.com, miquel.raynal@bootlin.com, richard@nod.at,
        vigneshr@ti.com, linux-mtd@lists.infradead.org,
        linux-kernel@vger.kernel.org, Nicolas.Ferre@microchip.com
Subject: Re: [PATCH v3 1/3] mtd: spi-nor: Parse BFPT to determine the 4-Byte
 Address Mode methods
In-Reply-To: <97558244-9757-82fd-209e-99f7ad8587f3@microchip.com>
References: <20220411125346.118274-1-tudor.ambarus@microchip.com>
 <20220411125346.118274-2-tudor.ambarus@microchip.com>
 <63b485a1e48d3116f8f49cc427049f81@walle.cc>
 <78aa1754-2f04-9f0b-72ef-f06535a413b0@microchip.com>
 <9867708d5625e5bf8f5f50c72385efb6@walle.cc>
 <97558244-9757-82fd-209e-99f7ad8587f3@microchip.com>
User-Agent: Roundcube Webmail/1.4.13
Message-ID: <996bee9d1bef12623f774c57c5908405@walle.cc>
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

Am 2022-04-14 13:05, schrieb Tudor.Ambarus@microchip.com:
> On 4/14/22 12:51, Michael Walle wrote:
>> EXTERNAL EMAIL: Do not click links or open attachments unless you know 
>> the content is safe
>> 
>>>>> diff --git a/drivers/mtd/spi-nor/sfdp.c 
>>>>> b/drivers/mtd/spi-nor/sfdp.c
>>>>> index a5211543d30d..2e40eba3744d 100644
>>>>> --- a/drivers/mtd/spi-nor/sfdp.c
>>>>> +++ b/drivers/mtd/spi-nor/sfdp.c
>>>>> @@ -401,6 +401,93 @@ static void
>>>>> spi_nor_regions_sort_erase_types(struct spi_nor_erase_map *map)
>>>>>       }
>>>>>  }
>>>>> 
>>>>> +/**
>>>>> + * spansion_set_4byte_addr_mode() - Set 4-byte address mode for
>>>>> Spansion
>>>>> + * flashes.
>>>>> + * @nor:     pointer to 'struct spi_nor'.
>>>>> + * @enable:  true to enter the 4-byte address mode, false to exit
>>>>> the
>>>>> 4-byte
>>>>> + *           address mode.
>>>>> + *
>>>>> + * Return: 0 on success, -errno otherwise.
>>>>> + */
>>>>> +int spansion_set_4byte_addr_mode(struct spi_nor *nor, bool enable)
>>>> 
>>>> Mh, so now some callback functions are in the core like the quad
>>>> enable
>>>> methods and some are in sfdp.c. I think there should be only the
>>>> parsing
>>>> in sfdp.c and all the callback methods should be in core.c; as they
>>>> are
>>>> potentially used by the vendor modules.
>>> 
>>> All set_4byte_addr_mode methods are defined in sfdp.c and declared in
>>> sfdp.h.
>>> I kept the methods defined in sfdp.c because SFDP defines their
>>> behavior/how
>>> they work. Vendors already have access to all these methods when
>>> including
>>> core.h (which includes sfdp.h). No need to move them to core, as they
>>> are
>>> SFDP specific.
>> 
>> The same is true for the quad enable method and they reside in core.c.
>> Again, I think sfdp.c should be about the parsing, not the flash
>> handling
>> itself. (And sfdp.h should be the equivalent to the spec in terms of
>> constants). I mean SFDP will eventually cover everything, so will you
>> move
>> all methods over to sfdp.c? All these methods can be used with flashes
>> without SFDP.
>> 
>> SFDP just collects all the different methods used by flash 
>> manufacturers
>> and put them into a table. I don't see how SFDP is a spec where they
>> specify
>> a paricular method and all the flash manufacturer pick that up. I 
>> think
>> it
>> is the other way around, a flash manufacturer does something
>> proprietary and then it eventually ends up in the SFDP spec.
> 
> It doesn't matter who was first to define the method. What matters is 
> that
> the method is backed-up by a standard. The JEDEC standard "[..] 
> provides a
> consistent method of describing the functional and feature capabilities 
> of
> serial flash devices [...]".
> 
> So if the functional method is described by the standard, let's use the
> "standard" methods, and keep them in the standard's code.

Fair enough, but what is then the difference between core.c and sfdp.c?

The core already holds all the "standard methods" because everything
else will be moved or was already moved into the vendor modules. Take
write_enable() for example, that is also covered by the SFDP standard,
should it be moved to sfdp.c too? And probably 90% of the code in
core.c is covered by the standard. I really don't see any advantages
for just moving the code around. Sorry if I repeat myself, but I already
find it really hard to actually use git blame inside mtd/spi-nor/ due to
the all the refactoring.

>>>>> @@ -606,6 +693,24 @@ static int spi_nor_parse_bfpt(struct spi_nor
>>>>> *nor,
>>>>>               break;
>>>>>       }
>>>>> 
>>>>> +     switch (bfpt.dwords[BFPT_DWORD(16)] &
>>>>> BFPT_DWORD16_4B_ADDR_MODE_MASK)
>>>>> {
>>>> 
>>>> I was wondering why this is encoded as single bits and not as an
>>>> enumeration. To me it looks like it is intended to support
>>> 
>>> because I parse 2 bits and check if both the enter and the exit 
>>> methods
>>> of
>>> the 4b addr mode are specified.
>> 
>> No, I'm only speaking of either the entry or the exit mask. See
>> below.
>> 
>>>> different methods at the same time. Thus I think there might be
>>>> multiple bits set in each entry and exit mask at once. The spec
>>>> lists all the entries as x_xxx1, x_xx1x, ..
>>>> 
>>>>> +     case BFPT_DWORD16_4B_ADDR_MODE_BRWR:
>>>> .. then this will only match if exactly these two bits are set.
>>>> 
>>> 
>>> these 2 bits are:
>>> drivers/mtd/spi-nor/sfdp.h:#define BFPT_DWORD16_4B_ADDR_MODE_BRWR
>>>                  \
>>> drivers/mtd/spi-nor/sfdp.h-     (BFPT_DWORD16_EN4B_BRWR |
>>> BFPT_DWORD16_EX4B_BRWR)
>> 
>> I know this are two bits, but IMHO there can be multiple bits
>> set in *each* of these masks. Eg. the enter mask could be
>> 0b00011 which would indicate that both the first and the second
>> enter method is supported.
>> (I'd expect that the exit mask will then be 0b00011, too).
> 
> I see. I can't contradict you here. How about:
> 
> u32 dword;
> 
> dword = bfpt.dwords[BFPT_DWORD(16)] & BFPT_DWORD16_4B_ADDR_MODE_MASK;
> if ((dword & BFPT_DWORD16_4B_ADDR_MODE_BRWR) == 
> BFPT_DWORD16_4B_ADDR_MODE_BRWR)
> 	params->set_4byte_addr_mode = spansion_set_4byte_addr_mode;
> else if ((dword & BFPT_DWORD16_4B_ADDR_MODE_WREN_EN4B_EX4B) ==
> BFPT_DWORD16_4B_ADDR_MODE_WREN_EN4B_EX4B)
> 	params->set_4byte_addr_mode = micron_st_nor_set_4byte_addr_mode;
> ...

Maybe with a bit more syntactic sugar :) Too bad this is already a
special case because it combines two different fields. The SFDP
standard seems to use the xxxx_xxx1, xxxx_xx1x, .. pattern quite
often. So for all the other fields you could have:

#define sfdp_bitfield(x) ((x) ? BIT(ffs(x)) : 0)

And an example for the SR status polling:

switch (sfdp_bitfield(bfpt.dwords[BFPT_DWORD(14)] & 
BFPT_DWORD14_SR_POLLING_MASK)) {
case BFPT_DWORD14_SR_POLLING_LEGACY:
  ...
case BFPT_DWORD14_SR_POLLING_SR_BIT7:
  ...
}

> else
> 	dev_dbg(nor->dev, "BFPT: 4-Byte Address Mode method is not recognized
> or not implemented\n");
> 
> The first method hit will be used, regardless of how many methods
> are supported.

sure.

-michael
