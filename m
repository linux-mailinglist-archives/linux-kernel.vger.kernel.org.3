Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0D66D4DC3E9
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Mar 2022 11:24:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232561AbiCQKZV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Mar 2022 06:25:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54288 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232528AbiCQKZT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Mar 2022 06:25:19 -0400
Received: from lelv0142.ext.ti.com (lelv0142.ext.ti.com [198.47.23.249])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C004FEEA5C;
        Thu, 17 Mar 2022 03:24:03 -0700 (PDT)
Received: from fllv0035.itg.ti.com ([10.64.41.0])
        by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 22HANbD2114716;
        Thu, 17 Mar 2022 05:23:37 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1647512617;
        bh=Z5rzlj1lD0CCm9QdaRl7k2JWFCxQ4rdNGEUNYarhhig=;
        h=Date:Subject:To:CC:References:From:In-Reply-To;
        b=mur5oLicA0PwxxO9xPiyTPOeYo8sJe76AQt1q8zvcHZPHj7uBlBBSwDAPhoFLd/T/
         fYrlNZm9LZkJN+NyW93Uswv6mm1PsnH1F9ngKive8d/Tkj39Zy1F3FulpNILw2/IWh
         j0iXvCxaHB3RUW/zeIJgzPPUdyjKbZ417yWsj3sg=
Received: from DFLE100.ent.ti.com (dfle100.ent.ti.com [10.64.6.21])
        by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 22HANb8f055721
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 17 Mar 2022 05:23:37 -0500
Received: from DFLE110.ent.ti.com (10.64.6.31) by DFLE100.ent.ti.com
 (10.64.6.21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2308.14; Thu, 17
 Mar 2022 05:23:37 -0500
Received: from fllv0040.itg.ti.com (10.64.41.20) by DFLE110.ent.ti.com
 (10.64.6.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2308.14 via
 Frontend Transport; Thu, 17 Mar 2022 05:23:37 -0500
Received: from [10.250.234.22] (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0040.itg.ti.com (8.15.2/8.15.2) with ESMTP id 22HANXpt073475;
        Thu, 17 Mar 2022 05:23:34 -0500
Message-ID: <c17fe9c6-0757-dbb6-6efb-69d05d7ff589@ti.com>
Date:   Thu, 17 Mar 2022 15:53:32 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH v2 0/6] spi-mem: Allow specifying the byte order in DTR
 mode
Content-Language: en-US
To:     David Laight <David.Laight@ACULAB.COM>,
        "'Michael Walle'" <michael@walle.cc>
CC:     Tudor Ambarus <tudor.ambarus@microchip.com>,
        "p.yadav@ti.com" <p.yadav@ti.com>,
        "broonie@kernel.org" <broonie@kernel.org>,
        "miquel.raynal@bootlin.com" <miquel.raynal@bootlin.com>,
        "richard@nod.at" <richard@nod.at>,
        "linux-mtd@lists.infradead.org" <linux-mtd@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-spi@vger.kernel.org" <linux-spi@vger.kernel.org>,
        "nicolas.ferre@microchip.com" <nicolas.ferre@microchip.com>
References: <20220311080147.453483-1-tudor.ambarus@microchip.com>
 <76eb13b6-9263-975f-3196-312259634301@ti.com>
 <b60064231d33581c20279172cf8f765e@walle.cc>
 <0f271365-354b-82e2-02a2-9d69a6ac85b1@ti.com>
 <9bc530d1fdaf4490a00fee150f963ac7@AcuMS.aculab.com>
 <bc2083a8903fdabc65083f7e5232ca2d@walle.cc>
 <8b765d24cb9a422bb383aad07251b65f@AcuMS.aculab.com>
From:   Vignesh Raghavendra <vigneshr@ti.com>
In-Reply-To: <8b765d24cb9a422bb383aad07251b65f@AcuMS.aculab.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 17/03/22 3:44 pm, David Laight wrote:
> From: Michael Walle
>> Sent: 17 March 2022 09:40
>>
>> Am 2022-03-16 14:55, schrieb David Laight:
>>> Thought...
>>
>> Thank you for your proposal.
>>
>>> Can you read the device in STR mode until you get a suitable
>>> non-palindromic value, then read it in DTR mode and dynamically
>>> determine the byte order?
>>>
>>> Clearly this won't work if the device is erased to all 0xff.
>>> But a check could be done on/after the first write.
>>>
>>> I suspect write times are actually dominated by the time spent
>>> waiting for the write to complete?
>>> (Never mind the earlier block erase time.)
>>> So always writing in STR mode probably makes little difference?
>>> Writes really ought to be uncommon as well.
>>>
>>> Speeding up reads is a different matter - and probably useful.
>>>
>>> Of course, if you've got hardware reading the spi memory in DTR
>>> mode for config data you might need to byteswap it (compared
>>> to the STR writes) - but that is probably a 2nd order problem.
>>>
>>> I've got some bespoke logic on an PCIe fpga for accessing spi memory.
>>> Uses address bits for the control signals and converts a 32bit
>>> read/write into 8 nibble transfers to the chip.
>>> (uses byte enables - don't an odd number of clocks.)
>>> mmapp()ed to userspace for updating the 6MB fpga image.
>>
>> Our problem is not how to detect that we have to swap it, but
>> rather what we do when we have to do it.
>>
>> If we have a controller which can swap the bytes for us on the
>> fly, we are lucky and can enable swapping if we need it. We are
>> also lucky when we don't have to swap the flash contents, obviously.
>>
>> But what do we do when we need to swap it and the controller
>> doesn't support it. We could do it in software which will slow
>> things down. So depending on the use case this might or might not
>> work. We can degrade it to a speed which doesn't have this issue;
>> which might be 1-1-1 in the worst case. We could also do just
>> nothing special; but this will lead to inconsistencies between
>> reading in 1-1-1 and 8d-8d-8d.
> 
> I really doubt you'll notice the effects of a software byteswap
> compared to the actual time taken to do an spi read.
> 
> What's the maximum clock rate for spi memory?
> Something like 50MHz ?

We have Octal SPI flashes running at upwards of 200MHz clock (400MB/s)
so SW byteswap will add significant overhead.


> If the spi controller isn't doing dma then the cpu pio reads
> to get the data are very likely to be even slower than that.
> (Especially if they are PCIe reads.)
> 

Modern OSPI/QSPI flash controllers provide MMIO interface to read from
flash where DMA can pull data as if though you are reading from On chip RAM

Regards
Vignesh
