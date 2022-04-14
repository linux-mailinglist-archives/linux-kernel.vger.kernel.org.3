Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BEF18500A70
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Apr 2022 11:51:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241437AbiDNJyE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Apr 2022 05:54:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49200 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230483AbiDNJx6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Apr 2022 05:53:58 -0400
Received: from ssl.serverraum.org (ssl.serverraum.org [176.9.125.105])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 10B486543C
        for <linux-kernel@vger.kernel.org>; Thu, 14 Apr 2022 02:51:34 -0700 (PDT)
Received: from ssl.serverraum.org (web.serverraum.org [172.16.0.2])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ssl.serverraum.org (Postfix) with ESMTPSA id 523652223A;
        Thu, 14 Apr 2022 11:51:32 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=walle.cc; s=mail2016061301;
        t=1649929892;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=sQczWkxt6C6RQJavgWeWLcLLt74X0PEIwqF89ebEzJg=;
        b=FsxB4Zeo6D5nOScWxByQkHw02uWV8Xov6sq0MSrpfbqyePoLkibaq/yiNGHOOuZx1wegp9
        1S09GJR9ICXx5Ee0S0pBKm28uT3c7qC9YS72xhpJ9qWkOsdRVaYAY4GAuUijDdabfDMLzN
        4xpYMjaMjWDTeL5BOCBaPPRiKFPGzS0=
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
 format=flowed
Content-Transfer-Encoding: 8bit
Date:   Thu, 14 Apr 2022 11:51:32 +0200
From:   Michael Walle <michael@walle.cc>
To:     Tudor.Ambarus@microchip.com
Cc:     p.yadav@ti.com, miquel.raynal@bootlin.com, richard@nod.at,
        vigneshr@ti.com, linux-mtd@lists.infradead.org,
        linux-kernel@vger.kernel.org, Nicolas.Ferre@microchip.com
Subject: Re: [PATCH v3 1/3] mtd: spi-nor: Parse BFPT to determine the 4-Byte
 Address Mode methods
In-Reply-To: <78aa1754-2f04-9f0b-72ef-f06535a413b0@microchip.com>
References: <20220411125346.118274-1-tudor.ambarus@microchip.com>
 <20220411125346.118274-2-tudor.ambarus@microchip.com>
 <63b485a1e48d3116f8f49cc427049f81@walle.cc>
 <78aa1754-2f04-9f0b-72ef-f06535a413b0@microchip.com>
User-Agent: Roundcube Webmail/1.4.13
Message-ID: <9867708d5625e5bf8f5f50c72385efb6@walle.cc>
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

>>> diff --git a/drivers/mtd/spi-nor/sfdp.c b/drivers/mtd/spi-nor/sfdp.c
>>> index a5211543d30d..2e40eba3744d 100644
>>> --- a/drivers/mtd/spi-nor/sfdp.c
>>> +++ b/drivers/mtd/spi-nor/sfdp.c
>>> @@ -401,6 +401,93 @@ static void
>>> spi_nor_regions_sort_erase_types(struct spi_nor_erase_map *map)
>>>       }
>>>  }
>>> 
>>> +/**
>>> + * spansion_set_4byte_addr_mode() - Set 4-byte address mode for
>>> Spansion
>>> + * flashes.
>>> + * @nor:     pointer to 'struct spi_nor'.
>>> + * @enable:  true to enter the 4-byte address mode, false to exit 
>>> the
>>> 4-byte
>>> + *           address mode.
>>> + *
>>> + * Return: 0 on success, -errno otherwise.
>>> + */
>>> +int spansion_set_4byte_addr_mode(struct spi_nor *nor, bool enable)
>> 
>> Mh, so now some callback functions are in the core like the quad 
>> enable
>> methods and some are in sfdp.c. I think there should be only the 
>> parsing
>> in sfdp.c and all the callback methods should be in core.c; as they 
>> are
>> potentially used by the vendor modules.
> 
> All set_4byte_addr_mode methods are defined in sfdp.c and declared in 
> sfdp.h.
> I kept the methods defined in sfdp.c because SFDP defines their 
> behavior/how
> they work. Vendors already have access to all these methods when 
> including
> core.h (which includes sfdp.h). No need to move them to core, as they 
> are
> SFDP specific.

The same is true for the quad enable method and they reside in core.c.
Again, I think sfdp.c should be about the parsing, not the flash 
handling
itself. (And sfdp.h should be the equivalent to the spec in terms of
constants). I mean SFDP will eventually cover everything, so will you 
move
all methods over to sfdp.c? All these methods can be used with flashes
without SFDP.

SFDP just collects all the different methods used by flash manufacturers
and put them into a table. I don't see how SFDP is a spec where they 
specify
a paricular method and all the flash manufacturer pick that up. I think 
it
is the other way around, a flash manufacturer does something
proprietary and then it eventually ends up in the SFDP spec.

>>> @@ -606,6 +693,24 @@ static int spi_nor_parse_bfpt(struct spi_nor 
>>> *nor,
>>>               break;
>>>       }
>>> 
>>> +     switch (bfpt.dwords[BFPT_DWORD(16)] & 
>>> BFPT_DWORD16_4B_ADDR_MODE_MASK)
>>> {
>> 
>> I was wondering why this is encoded as single bits and not as an
>> enumeration. To me it looks like it is intended to support
> 
> because I parse 2 bits and check if both the enter and the exit methods 
> of
> the 4b addr mode are specified.

No, I'm only speaking of either the entry or the exit mask. See
below.

>> different methods at the same time. Thus I think there might be
>> multiple bits set in each entry and exit mask at once. The spec
>> lists all the entries as x_xxx1, x_xx1x, ..
>> 
>>> +     case BFPT_DWORD16_4B_ADDR_MODE_BRWR:
>> .. then this will only match if exactly these two bits are set.
>> 
> 
> these 2 bits are:
> drivers/mtd/spi-nor/sfdp.h:#define BFPT_DWORD16_4B_ADDR_MODE_BRWR
>                  \
> drivers/mtd/spi-nor/sfdp.h-     (BFPT_DWORD16_EN4B_BRWR |
> BFPT_DWORD16_EX4B_BRWR)

I know this are two bits, but IMHO there can be multiple bits
set in *each* of these masks. Eg. the enter mask could be
0b00011 which would indicate that both the first and the second
enter method is supported.
(I'd expect that the exit mask will then be 0b00011, too).

-michael
