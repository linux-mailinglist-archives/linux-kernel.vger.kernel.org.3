Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AC5395794AE
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Jul 2022 09:57:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234905AbiGSH5h (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Jul 2022 03:57:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46424 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235610AbiGSH5f (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jul 2022 03:57:35 -0400
Received: from ssl.serverraum.org (ssl.serverraum.org [176.9.125.105])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E8B027CF5
        for <linux-kernel@vger.kernel.org>; Tue, 19 Jul 2022 00:57:33 -0700 (PDT)
Received: from ssl.serverraum.org (web.serverraum.org [172.16.0.2])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ssl.serverraum.org (Postfix) with ESMTPSA id 36B0B221D4;
        Tue, 19 Jul 2022 09:57:31 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=walle.cc; s=mail2016061301;
        t=1658217451;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=QN1+cOUealxzJ82/ApZPg7+rBCRm/zOrfFuK3gYV4x0=;
        b=B78JOIFk4aAxZ3zSgwdndiA9ITHhOTLkmsZi0MRvXTIu4e2f3U+K4LDD0x9iJbCeY6hhza
        cGPGZmuVC3pvtHkJp8HmPamrLfthwioZ/sshUpfGP2wg13Akl8h3mIYhs86RXUnWKHYkrY
        CmjRuMMw2wkEp5pjXziqXbXjDSz9xpE=
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Tue, 19 Jul 2022 09:57:31 +0200
From:   Michael Walle <michael@walle.cc>
To:     Tudor.Ambarus@microchip.com
Cc:     p.yadav@ti.com, miquel.raynal@bootlin.com, richard@nod.at,
        vigneshr@ti.com, linux-mtd@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] mtd: spi-nor: introduce SNOR_ID3()
In-Reply-To: <7365146d-b001-2a14-014d-62a6b19f4381@microchip.com>
References: <20220510140232.3519184-1-michael@walle.cc>
 <20220510140232.3519184-2-michael@walle.cc>
 <160ddac1-6d0a-c922-1380-09e7823a285e@microchip.com>
 <02125e047cfbf347d81811224be3141e@walle.cc>
 <7365146d-b001-2a14-014d-62a6b19f4381@microchip.com>
User-Agent: Roundcube Webmail/1.4.13
Message-ID: <1a1b1bf3f8ea7a27afb6e85e0ecabbbc@walle.cc>
X-Sender: michael@walle.cc
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am 2022-07-19 09:33, schrieb Tudor.Ambarus@microchip.com:
> On 7/19/22 10:07, Michael Walle wrote:
>> EXTERNAL EMAIL: Do not click links or open attachments unless you know 
>> the content is safe
>> 
>> Am 2022-07-19 07:57, schrieb Tudor.Ambarus@microchip.com:
>>> On 5/10/22 17:02, Michael Walle wrote:
>>>> EXTERNAL EMAIL: Do not click links or open attachments unless you 
>>>> know
>>>> the content is safe
>>>> 
>>>> Up until now, flashes were defined by specifying the JEDEC ID, the
>>>> sector size and the number of sectors. This can be read by parsing 
>>>> the
>>>> SFDP, we don't have to specify it. Thus provide a new macro 
>>>> SNOR_ID3()
>>>> which just takes the JEDEC ID and implicitly set .parse_sfdp = true.
>>>> All
>>>> new flashes which have SFDP should use this macro.
>>> 
>>> I like the idea, but you need to refine it a bit.
>>> Your assumptions are true only for flashes that are compliant with 
>>> SFDP
>>> revB or
>>> later because params->page_size is initialized by querying BFPT DWORD
>>> 11. I think it would be good to specify this in the comment section.
>> 
>> Sure.
>> 
>>> Also, I think you introduce
>>> a bug in spi_nor_select_erase() when 
>>> CONFIG_MTD_SPI_NOR_USE_4K_SECTORS
>>> is not
>>> selected. wanted_size will be zero, will you select an invalid erase
>>> type?
>> 
>> You mean to squeeze [1] into this one? If so, sure.
>> 
>> -michael
>> 
>> [1]
>> https://lore.kernel.org/linux-mtd/20220716000643.3541839-1-quic_jaehyoo@quicinc.com/
> 
> No, these are orthogonal. If you keep wanted_size to zero, then
> spi_nor_select_uniform_erase() will return NULL, doesn't it?

No, have a look at the second condition

if (!erase && tested_erase->size)
   erase = ..

So it will return the first non-empty slot. Thus it will
only return NULL if all the slots are empty (given the
fix is included).

Actually, I'd have expected that to mask out an erase
type, you clear the corresponding bit in uniform_erase_type,
in which case the for loop in spi_nor_select_uniform_erase()
would have just worked. But apparently there are two differnt
mechanism here to mark an entry as unused, either the size
is zero or the bit is not set. But that is a topic for another
patch.

-michael

> Maybe to adapt the code to something like
> diff --git a/drivers/mtd/spi-nor/core.c b/drivers/mtd/spi-nor/core.c
> index 21cefe2864ba..dd6cd852d1ef 100644
> --- a/drivers/mtd/spi-nor/core.c
> +++ b/drivers/mtd/spi-nor/core.c
> @@ -2148,7 +2148,7 @@ static int spi_nor_select_erase(struct spi_nor 
> *nor)
>         struct spi_nor_erase_map *map = &nor->params->erase_map;
>         const struct spi_nor_erase_type *erase = NULL;
>         struct mtd_info *mtd = &nor->mtd;
> -       u32 wanted_size = nor->info->sector_size;
> +       u32 wanted_size = nor->params->sector_size;
> 
> and fill nor->params->sector_size even when no SFDP
> 
> Also, params->size = (u64)info->sector_size * info->n_sectors; from
> spi_nor_init_default_params() becomes superfluous. I would check
> the fields that I don't initialize in flash_info with SNOR_ID3
> and check how I can mitigate their absence throughout the code.
