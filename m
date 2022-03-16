Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 506DE4DAB8D
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Mar 2022 08:08:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238838AbiCPHKD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Mar 2022 03:10:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35564 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232916AbiCPHJ5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Mar 2022 03:09:57 -0400
Received: from fllv0016.ext.ti.com (fllv0016.ext.ti.com [198.47.19.142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 113AB27CD4;
        Wed, 16 Mar 2022 00:08:41 -0700 (PDT)
Received: from fllv0035.itg.ti.com ([10.64.41.0])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 22G78DA9021129;
        Wed, 16 Mar 2022 02:08:13 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1647414493;
        bh=GXRBNb0KChHbT2vJ7oonxrINUF2VVKqcqQru4kA3DNM=;
        h=Date:Subject:To:CC:References:From:In-Reply-To;
        b=elAV7nA/smOxkfx9V+ZHh4w3uK0VKBzMIFmS5dtXRWrbKbBDtVyxbIIf1f1KKqf0O
         PVHc1tyBQVoFZQz4y4Bd3GZa9oWvKYtv1FdV1JGIr22pWfhalOlu1/NvYbzOw3zyhX
         xogwzZkmBbAt89hQPYISYgv3uxmvMRF5Gh7Lav70=
Received: from DLEE105.ent.ti.com (dlee105.ent.ti.com [157.170.170.35])
        by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 22G78DRB033457
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 16 Mar 2022 02:08:13 -0500
Received: from DLEE115.ent.ti.com (157.170.170.26) by DLEE105.ent.ti.com
 (157.170.170.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2308.14; Wed, 16
 Mar 2022 02:08:13 -0500
Received: from fllv0040.itg.ti.com (10.64.41.20) by DLEE115.ent.ti.com
 (157.170.170.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2308.14 via
 Frontend Transport; Wed, 16 Mar 2022 02:08:13 -0500
Received: from [10.250.234.22] (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0040.itg.ti.com (8.15.2/8.15.2) with ESMTP id 22G787lY032732;
        Wed, 16 Mar 2022 02:08:09 -0500
Message-ID: <8e6e3dcb-0771-560f-4eb8-d49e7cf1f1df@ti.com>
Date:   Wed, 16 Mar 2022 12:38:07 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH v2 0/6] spi-mem: Allow specifying the byte order in DTR
 mode
Content-Language: en-US
To:     <Tudor.Ambarus@microchip.com>, <p.yadav@ti.com>,
        <michael@walle.cc>, <broonie@kernel.org>
CC:     <miquel.raynal@bootlin.com>, <richard@nod.at>,
        <linux-mtd@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        <linux-spi@vger.kernel.org>, <Nicolas.Ferre@microchip.com>,
        <zhengxunli@mxic.com.tw>, <jaimeliao@mxic.com.tw>,
        <andreasilvagni@macronix.com>
References: <20220311080147.453483-1-tudor.ambarus@microchip.com>
 <76eb13b6-9263-975f-3196-312259634301@ti.com>
 <9e0b6bde-838d-b8a4-9fe7-75c4f916fb27@microchip.com>
From:   Vignesh Raghavendra <vigneshr@ti.com>
In-Reply-To: <9e0b6bde-838d-b8a4-9fe7-75c4f916fb27@microchip.com>
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



On 15/03/22 12:28 pm, Tudor.Ambarus@microchip.com wrote:
> On 3/15/22 08:08, Vignesh Raghavendra wrote:
>> EXTERNAL EMAIL: Do not click links or open attachments unless you know the content is safe
>>
>> Hi,
> 
> Hi,
> 
>>
>> On 11/03/22 1:31 pm, Tudor Ambarus wrote:
>>> There are NOR flashes (Macronix) that swap the bytes on a 16-bit boundary
>>> when configured in Octal DTR mode. The byte order of 16-bit words is
>>> swapped when read or written in Octal Double Transfer Rate (DTR) mode
>>> compared to Single Transfer Rate (STR) modes. If one writes D0 D1 D2 D3
>>> bytes using 1-1-1 mode, and uses 8D-8D-8D SPI mode for reading, it will
>>> read back D1 D0 D3 D2. Swapping the bytes is a bad design decision because
>>> it may introduce some endianness problems. It can affect the boot sequence
>>> if the entire boot sequence is not handled in either 8D-8D-8D mode or 1-1-1
>>> mode. So we must swap the bytes back to have the same byte order as in STR
>>> modes. Fortunately there are controllers that can swap the bytes back at
>>> runtime, addressing the flash's endiannesses requirements.
>>> If the controllers are not capable of swapping the bytes, the protocol is
>>> downgraded via spi_nor_spimem_adjust_hwcaps(). When available, the swapping
>>> of the bytes is always done regardless if it's a data or register access,
>>> so that we comply with the JESD216 requirements: "Byte order of 16-bit
>>> words is swapped when read in 8D-8D-8D mode compared to 1-1-1".
>>>
>>
>> Sorry, bit late to the thread. But, dropping 8D-8D-8D mode support is
> 
> no worries
> 
>> quite restrictive IMO.
>>
>> AFAIK, SFDP standard does not dictate how data should be stored in flash
>> or how SW should interpret after reading data from flash. It merely
>> indicates endian-ness compared to 1-1-1 mode.
>>
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
>>
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
> we can't use DT for configuration, maybe a Kconfig instead. Are there any
> other options?
> 

Problem with Kconfig is that it cannot be used when there are multiple
flash instances on the board and both behave differently.

This is similar to big-endian vs little-endian property used by CFI
physmap driver and other places in kernel[1]

>>
>> 2.  SPI controllers don't support endian-ness SWAP on the fly:
>> It is still possible to reliably read and write data as long as its
>> written and read back in same mode.
>>
>> De-rating speeds because of absence of this support would mean reduction
>> of speed by **16 times** (maybe even higher as 8D mode tends to support
>> higher bus freqs). Swapping bytes in Linux before writing or after
>> reading is not an option either as it negatively impacts performance.
>>
>> Asking ROM/bootloaders to swap bytes based on SFDP indication is
>> restrictive too as it involves boot time penalty and most systems with
>> OSPI flashes are using them to achieve super fast boot times.
>>
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
> 
> This is a bit in contradiction, because if the ROMs follow xSPI, thus little
> endian byte order, they should swap the bytes.
> 

As I indicated below xSPI (JESD251) spec seems to align on little endian
order. So, don't really need to swap the bytes on read. Anyways impact
on performance prohibits such support and thus most ROM designs will
expect flashing program to take care of it (especially in case where
controller does not support on the fly swapping).

>>
>> IMO, kernel device drivers should just provide access to underlying HW
>> and not have too much intelligence to interpret data/take decisions
>>
>> So, simpler constraint to put is:
>> Flasher programs should program data in the same mode in which
>> ROM/bootloder/Linux is expected to read the data on that system.
> 
> No, this constraint doesn't cover all possible cases: take a 1-1-1 ROMcode,
> 8D-8D-8D for other bootloaders and kernel. You need to dynamically change modes
> in the flasher program in order to address this use case, which is a no go.
> 

Flash programmer need not change the mode, but needs to generate a byte
swapped image and write it knowing that image is being flashed in
8D-8D-8D mode and read in 1-1-1 mode or vice versa.

>>
>> For Macronix like flashes, if one has a ROM/bootloader that only
>> supports 1-1-1 mode and flashing data in 8D-8D-8D mode with Linux, then
>> please generate a byte-swapped image offline and flash it. Don't impose
> 
> we can't do that, see the example from above.
> 

See above, no need to change mode dynamically.

>> penalty on systems that do best to handle this messy situation.
>> I see this as the only option with least performance penalty.
>>
> 
> I take from this that we should let the byte swap be user-configurable,
> thus a Kconfig. Which I'm not against it, but it will give users
> headaches to sync all the software components. Making such a decision
> implies that users know SPI NOR internal details, which also is a bit
> stretched. Let's sync so that we move forward with this. Opinions? 
> 

I am fine with things being configurable

Only issues with Kconfig: it does not help systems with multiple OSPIs
with different endian-ness.


[1] Documentation/devicetree/bindings/mtd/mtd-physmap.yaml


Regards
Vignesh
