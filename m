Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 599224DAB68
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Mar 2022 08:08:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348699AbiCPHJF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Mar 2022 03:09:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55530 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354301AbiCPHHs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Mar 2022 03:07:48 -0400
Received: from lelv0143.ext.ti.com (lelv0143.ext.ti.com [198.47.23.248])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C99D163BDD;
        Wed, 16 Mar 2022 00:05:57 -0700 (PDT)
Received: from fllv0035.itg.ti.com ([10.64.41.0])
        by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 22G75TLi125261;
        Wed, 16 Mar 2022 02:05:29 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1647414329;
        bh=Qsx7Hio13DYDyYCWiH8XOZgZKlpiGA2a4pfQVkpRRRo=;
        h=Date:Subject:To:CC:References:From:In-Reply-To;
        b=MMjDkcuCgTwqYIEECIckafpuwNjcq08CqUIs1HJ8mMSC4rQsGpCUrE/UqN3xFN6zY
         ekmUvjGVf18qubs59JiyEsGQcOgL0q9S9GXsZ9DWYMbPutSpds8juuoJCQigsNQmCc
         UbYv1Pyzd0Ymots2Y/Tvg2IuK+bx0M5ItWhXFxR0=
Received: from DLEE106.ent.ti.com (dlee106.ent.ti.com [157.170.170.36])
        by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 22G75TBQ029522
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 16 Mar 2022 02:05:29 -0500
Received: from DLEE110.ent.ti.com (157.170.170.21) by DLEE106.ent.ti.com
 (157.170.170.36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2308.14; Wed, 16
 Mar 2022 02:05:29 -0500
Received: from fllv0040.itg.ti.com (10.64.41.20) by DLEE110.ent.ti.com
 (157.170.170.21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2308.14 via
 Frontend Transport; Wed, 16 Mar 2022 02:05:29 -0500
Received: from [10.250.234.22] (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0040.itg.ti.com (8.15.2/8.15.2) with ESMTP id 22G75PAP028036;
        Wed, 16 Mar 2022 02:05:26 -0500
Message-ID: <0f271365-354b-82e2-02a2-9d69a6ac85b1@ti.com>
Date:   Wed, 16 Mar 2022 12:35:25 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH v2 0/6] spi-mem: Allow specifying the byte order in DTR
 mode
Content-Language: en-US
To:     Michael Walle <michael@walle.cc>
CC:     Tudor Ambarus <tudor.ambarus@microchip.com>, <p.yadav@ti.com>,
        <broonie@kernel.org>, <miquel.raynal@bootlin.com>,
        <richard@nod.at>, <linux-mtd@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <linux-spi@vger.kernel.org>,
        <nicolas.ferre@microchip.com>
References: <20220311080147.453483-1-tudor.ambarus@microchip.com>
 <76eb13b6-9263-975f-3196-312259634301@ti.com>
 <b60064231d33581c20279172cf8f765e@walle.cc>
From:   Vignesh Raghavendra <vigneshr@ti.com>
In-Reply-To: <b60064231d33581c20279172cf8f765e@walle.cc>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
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

Hi Michael,

On 15/03/22 12:49 pm, Michael Walle wrote:
> Hi,
> 
> Am 2022-03-15 07:08, schrieb Vignesh Raghavendra:
>> On 11/03/22 1:31 pm, Tudor Ambarus wrote:
>>> There are NOR flashes (Macronix) that swap the bytes on a 16-bit
>>> boundary
>>> when configured in Octal DTR mode. The byte order of 16-bit words is
>>> swapped when read or written in Octal Double Transfer Rate (DTR) mode
>>> compared to Single Transfer Rate (STR) modes. If one writes D0 D1 D2 D3
>>> bytes using 1-1-1 mode, and uses 8D-8D-8D SPI mode for reading, it will
>>> read back D1 D0 D3 D2. Swapping the bytes is a bad design decision
>>> because
>>> it may introduce some endianness problems. It can affect the boot
>>> sequence
>>> if the entire boot sequence is not handled in either 8D-8D-8D mode or
>>> 1-1-1
>>> mode. So we must swap the bytes back to have the same byte order as
>>> in STR
>>> modes. Fortunately there are controllers that can swap the bytes back at
>>> runtime, addressing the flash's endiannesses requirements.
>>> If the controllers are not capable of swapping the bytes, the
>>> protocol is
>>> downgraded via spi_nor_spimem_adjust_hwcaps(). When available, the
>>> swapping
>>> of the bytes is always done regardless if it's a data or register
>>> access,
>>> so that we comply with the JESD216 requirements: "Byte order of 16-bit
>>> words is swapped when read in 8D-8D-8D mode compared to 1-1-1".
>>>
>>
>> Sorry, bit late to the thread. But, dropping 8D-8D-8D mode support is
>> quite restrictive IMO.
>>
>> AFAIK, SFDP standard does not dictate how data should be stored in flash
>> or how SW should interpret after reading data from flash. It merely
>> indicates endian-ness compared to 1-1-1 mode.
> 
> Mh, but below you are saying that Micronix is violating the standard
> and is swapping the bytes. So, the standard is actually specifying the
> byte order.
> 

As I understand, SFDP spec(JESD216) is way of describing flash details,
it does not enforce any rules on how flash should "behave". It just
provides info for drivers to discover flash parameters at runtime.
OTOH, xSPI spec (JESD251) lays down guidelines for SW interface,
electrical, and mechanical interfaces. Macronix flash deviates from xSPI
spec but no SFDP per say (unless it claims xSPI compliance elsewhere in
SFDP tables).

>> So, its up to various system SWs like bootloader/Linux to work according
>> to pre-aligned layout as there is no rule that data needs to be stored
>> in byte order.
>>
>> We have two types of controllers:
>>
>> 1. SPI controllers supporting swapping endian-ness on the fly:
>> -> For such flashes, better choice is to have SWAP option always
>> enabled. So that data written in 8D-8D-8D mode can be read correctly in
>> 1-1-1 mode and vice-versa.
>> ( I am assuming SWAP option of controller is only effective in 8D-8D-8D
>> mode and is NOP in 1-1-1 or other modes)
> 
> Why should it be always enabled? You can also say it should always
> be disabled. It doesn't matter if the byte order isn't important.
> 
> But I say the byte order *is* important. We need one reference.
> 
>> But, its possible that "ROM" or other non-upgradable SWs may choose not
>> make to use of this SWAP option of HW to keep things simple in which
>> case, they cannot boot from 8D-8D-8D mode with above setting. Such SW
>> don't always have knowledge of flash and cannot be forced to have a
>> constraint to enable byte swap on read.
>>
>> So, IMO, its best left to system integrators to specify whether or not
>> SWAP option needs to be enabled (perhaps via DT as its per flash
>> specific property?)
> 
> Agreed, but I don't think we have to do it now. If someone cares,

I am fine with that, but I want to make sure we are not saying
controllers w/o ability to swap byte order can never support Macronix
like flash in 8D-8D-8D mode.

> he can make a patch. Also we have to consider non-DT platforms.
> 

non DT platforms also have a way to pass HW related data

>> 2.  SPI controllers don't support endian-ness SWAP on the fly:
>> It is still possible to reliably read and write data as long as its
>> written and read back in same mode.
>>
>> De-rating speeds because of absence of this support would mean reduction
>> of speed by **16 times** (maybe even higher as 8D mode tends to support
>> higher bus freqs).
> 
> You can also fall back to a quad mode. Again, can be implemented if
> someone cares.

Actually I have not come across OSPI flash that also supports quad mode.
So, fallback is 1-1-1 for majority of these flashes

> 
>> Swapping bytes in Linux before writing or after
>> reading is not an option either as it negatively impacts performance.
>>
>> Asking ROM/bootloaders to swap bytes based on SFDP indication is
>> restrictive too as it involves boot time penalty and most systems with
>> OSPI flashes are using them to achieve super fast boot times.
> 
> No we are talking about what? ms? to read the sfdp? If that is really
> a use case, the the bootloader can hardcode it there.
> 

Reading SFDP is not the issue but swapping entire image is the problem.
Takes several tens of ms depending on boot image size which is not
acceptable to systems looking at < 100 - 200msms start up times for
quick bootup usecases involving early Display / CAN output etc

>> One more case to consider is flashes that dont have SFDP table to
>> indicate byte order but follow Macronix's convention. In such cases, its
>> better for SPI NOR layer to be as dumb as possible and not really do any
>> byte swapping, leaving it up to user space to handle/interpret data
>> appropriately.
>>
>> Also, Macronix is probably in violation of xSPI spec (JESD251A 6.9.5.2
>> 8D-8D-8D Profile 1.0) where diagrams clearly show data output should be
>> D0 D1 D2 D3... So ROMs following xSPI spec (which is the only spec
>> providing flash agnostic way of switching to 8D mode and reading data in
>> 8D mode) would not care about SFDP bit indicating byteorder and its up
>> to flasher programs to take care of the same
>>
>> IMO, kernel device drivers should just provide access to underlying HW
>> and not have too much intelligence to interpret data/take decisions
> 
> I strongly disagree here. The kernel should provide a consistent
> view of the flash content, regardless if its read in 1-1-1 or 8d-8d-8d.
> Imagine you are forced to switch away from 8d-8d-8d mode (for whatever
> reason) after some time. How would you know how to read the contents?
> 

Agree with need for consistent view, although if we need to fall back to
1-1-1 mode for a while and switch back to 8D-8D-8D mode then there is
something fundamentally broken.

> JESD216 is a standard, too. There is a reason this bit ended up in
> there. If I had to guess, someone messed up the byte order in 8d-8d-8d
> but it was too late. And now the standard is giving you a hint that
> you are using a flash with that messed up byte ordering.
> 

Yes, but note JESD216 is all about giving hint to softwares  on how
flash behaves, it does not dictate what softwares need to do with it.
So another OS is free to leave these Macronix flashes using native byte
ordering and not swapping on read / write

> I want to avoid having flash contents where the byte are swapped.
> The sooner we care about that, the better. You cannot undo that
> later on.
> 
>> So, simpler constraint to put is:
>> Flasher programs should program data in the same mode in which
>> ROM/bootloder/Linux is expected to read the data on that system.
> 
> So what if your flasher only has 1 pin? With this you are just
> shifting the problem elsewhere.
> 

flasher program would have to use byte swapped image if read is expected
to be in 8D-8D mode

>> For Macronix like flashes, if one has a ROM/bootloader that only
>> supports 1-1-1 mode and flashing data in 8D-8D-8D mode with Linux, then
>> please generate a byte-swapped image offline and flash it. Don't impose
>> penalty on systems that do best to handle this messy situation.
>> I see this as the only option with least performance penalty.
> 
> I certainly have nothing against an option to turn this all off
> to improve speed. But the swapping (if asked to do so) and the
> degradation should be an *opt-out*. Not an opt-in. Nobody will
> do the opt-in and we end up with 'corrupted' flash contents.
> 

Sounds good to me. We should note this in commit message disabling
8D-8D-8D mode for these flashes.

Regards
Vignesh
