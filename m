Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8BB074B8337
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Feb 2022 09:47:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231637AbiBPIrJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Feb 2022 03:47:09 -0500
Received: from gmail-smtp-in.l.google.com ([23.128.96.19]:50860 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229455AbiBPIrI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Feb 2022 03:47:08 -0500
Received: from mx07-00178001.pphosted.com (mx07-00178001.pphosted.com [185.132.182.106])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5005F18CC60;
        Wed, 16 Feb 2022 00:46:56 -0800 (PST)
Received: from pps.filterd (m0241204.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.16.1.2/8.16.1.2) with ESMTP id 21G8Sqeo005841;
        Wed, 16 Feb 2022 09:46:20 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=selector1;
 bh=/7nixD/n01nc+BoZwZ9R1YyOe5pCnVpSW4p/rLQTcvM=;
 b=GMjvUOyE3cbd/56o+dFiFWF7O5Dm4Rd9Pir1K8KbyGzxeOhZS+kKeAp2+CVxHrOPXhow
 s1L0wvso3CwX7ORZHpr5SoFOOCnkXCDs7f3u6ycQJ8wPfxeDoxGYfSRS3wdTTSIp9Awl
 etgH2OJcCoc5/2rG9AadjREsVrSnbNhaxPL4hKZ5A6k21hEs2EtaLWeCouCx5h+iWiV/
 CntlODSuAyrHnEWJivUGlX1NwVWKjsPuxVnu9agPoFWTd5Rda9JFftkyv3u6grT4SD8K
 xFzcR0j56TDlOof8MdfxnVv5mazGJ6x72UtoXBw03aDYWC/zLlvX7gTbb2cCnZeTrZdE gA== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com (PPS) with ESMTPS id 3e8n20tega-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 16 Feb 2022 09:46:20 +0100
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 82FD110002A;
        Wed, 16 Feb 2022 09:46:18 +0100 (CET)
Received: from Webmail-eu.st.com (sfhdag2node2.st.com [10.75.127.5])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 6C9E8214D3B;
        Wed, 16 Feb 2022 09:46:18 +0100 (CET)
Received: from [10.48.0.175] (10.75.127.46) by SFHDAG2NODE2.st.com
 (10.75.127.5) with Microsoft SMTP Server (TLS) id 15.0.1497.26; Wed, 16 Feb
 2022 09:46:17 +0100
Message-ID: <f6687807-607c-f672-2394-ad463735d597@foss.st.com>
Date:   Wed, 16 Feb 2022 09:46:17 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH v2 4/4] mtd: core: Fix a conflict between MTD and NVMEM on
 wp-gpios property
Content-Language: en-US
To:     Pratyush Yadav <p.yadav@ti.com>
CC:     Miquel Raynal <miquel.raynal@bootlin.com>, <richard@nod.at>,
        <vigneshr@ti.com>, <robh+dt@kernel.org>,
        <srinivas.kandagatla@linaro.org>, <linux-mtd@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-stm32@st-md-mailman.stormreply.com>,
        <devicetree@vger.kernel.org>, <chenshumin86@sina.com>,
        Tudor Ambarus <Tudor.Ambarus@microchip.com>,
        Khouloud Touil <ktouil@baylibre.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>
References: <20220131095755.8981-1-christophe.kerello@foss.st.com>
 <20220131095755.8981-5-christophe.kerello@foss.st.com>
 <20220131144309.0ffe7cc8@xps13> <20220201104727.7xvcyexf3yucegcb@ti.com>
 <eebfa629-ead2-d63f-9cfb-4cafc1534678@foss.st.com>
 <20220202115327.53oqg5n7tx6b6q7u@ti.com>
From:   Christophe Kerello <christophe.kerello@foss.st.com>
In-Reply-To: <20220202115327.53oqg5n7tx6b6q7u@ti.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.75.127.46]
X-ClientProxiedBy: SFHDAG2NODE2.st.com (10.75.127.5) To SFHDAG2NODE2.st.com
 (10.75.127.5)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.816,Hydra:6.0.425,FMLib:17.11.62.513
 definitions=2022-02-16_04,2022-02-14_04,2021-12-02_01
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Miquel, Pratyush, Srinivas,

On 2/2/22 12:53, Pratyush Yadav wrote:
> + Khouloud, Linus, Bartosz
> 
> On 02/02/22 11:44AM, Christophe Kerello wrote:
>> Hi,
>>
>> On 2/1/22 11:47, Pratyush Yadav wrote:
>>> On 31/01/22 02:43PM, Miquel Raynal wrote:
>>>> Hi Vignesh, Tudory, Pratyush,
>>>>
>>>> + Tudor and Pratyush
>>>>
>>>> christophe.kerello@foss.st.com wrote on Mon, 31 Jan 2022 10:57:55 +0100:
>>>>
>>>>> Wp-gpios property can be used on NVMEM nodes and the same property can
>>>>> be also used on MTD NAND nodes. In case of the wp-gpios property is
>>>>> defined at NAND level node, the GPIO management is done at NAND driver
>>>>> level. Write protect is disabled when the driver is probed or resumed
>>>>> and is enabled when the driver is released or suspended.
>>>>>
>>>>> When no partitions are defined in the NAND DT node, then the NAND DT node
>>>>> will be passed to NVMEM framework. If wp-gpios property is defined in
>>>>> this node, the GPIO resource is taken twice and the NAND controller
>>>>> driver fails to probe.
>>>>>
>>>>> A new Boolean flag named skip_wp_gpio has been added in nvmem_config.
>>>>> In case skip_wp_gpio is set, it means that the GPIO is handled by the
>>>>> provider. Lets set this flag in MTD layer to avoid the conflict on
>>>>> wp_gpios property.
>>>>>
>>>>> Signed-off-by: Christophe Kerello <christophe.kerello@foss.st.com>
>>>>> ---
>>>>>    drivers/mtd/mtdcore.c | 2 ++
>>>>>    1 file changed, 2 insertions(+)
>>>>>
>>>>> diff --git a/drivers/mtd/mtdcore.c b/drivers/mtd/mtdcore.c
>>>>> index 70f492dce158..e6d251594def 100644
>>>>> --- a/drivers/mtd/mtdcore.c
>>>>> +++ b/drivers/mtd/mtdcore.c
>>>>> @@ -546,6 +546,7 @@ static int mtd_nvmem_add(struct mtd_info *mtd)
>>>>>    	config.stride = 1;
>>>>>    	config.read_only = true;
>>>>>    	config.root_only = true;
>>>>> +	config.skip_wp_gpio = true;
>>>>>    	config.no_of_node = !of_device_is_compatible(node, "nvmem-cells");
>>>>>    	config.priv = mtd;
>>>>> @@ -833,6 +834,7 @@ static struct nvmem_device *mtd_otp_nvmem_register(struct mtd_info *mtd,
>>>>>    	config.owner = THIS_MODULE;
>>>>>    	config.type = NVMEM_TYPE_OTP;
>>>>>    	config.root_only = true;
>>>>> +	config.skip_wp_gpio = true;
>>>>>    	config.reg_read = reg_read;
>>>>>    	config.size = size;
>>>>>    	config.of_node = np;
>>>>
>>>> TLDR: There is a conflict between MTD and NVMEM, who should handle the
>>>> WP pin when there is one? At least for raw NAND devices, I don't want
>>>> the NVMEM core to handle the wp pin. So we've introduced this
>>>> skip_wp_gpio nvmem config option. But there are two places where this
>>>> boolean can be set and one of these is for otp regions (see above). In
>>>> this case, I don't know if it is safe or if CFI/SPI-NOR rely on the
>>>> nvmem protection. Please tell us if you think this is fine for you.
>>>
>>> Why does NVMEM touch hardware write protection in the first place? The
>>> purpose of the framework is to provide a way to retrieve config stored
>>> in memory. It has no business dealing with details of the chip like the
>>> WP line. That should be MTD's job (which it should delegate to SPI NOR,
>>> SPI NAND, etc.). If you want to write protect a cell then do it in
>>> software. I don't see why NVMEM should be dealing with hardware directly
>>> at all.
>>>
>>> That is my mental model of how things _should_ work. I have not spent
>>> much time digging into how things actually work currently.
>>>
>>
>> Wp-gpios property management was added in MVMEM framework in January 2020 =>
>> sha1: 2a127da461a9d8d97782d6e82b227041393eb4d2
>> "
>>      nvmem: add support for the write-protect pin
>>
>>      The write-protect pin handling looks like a standard property that
>>      could benefit other users if available in the core nvmem framework.
>>
>>      Instead of modifying all the memory drivers to check this pin, make
>>      the NVMEM subsystem check if the write-protect GPIO being passed
>>      through the nvmem_config or defined in the device tree and pull it
>>      low whenever writing to the memory.
>> "
>>
>> And this modification was done for EEPROMs flashes => sha1:
>> 1c89074bf85068d1b86f2e0f0c2110fdd9b83c9f
>> "
>>      eeprom: at24: remove the write-protect pin support
>>
>>      NVMEM framework is an interface for the at24 EEPROMs as well as for
>>      other drivers, instead of passing the wp-gpios over the different
>>      drivers each time, it would be better to pass it over the NVMEM
>>      subsystem once and for all.
>>
>>      Removing the support for the write-protect pin after adding it to
>>      the NVMEM subsystem.
>> "
>>
>> Current NVMEM framework implementation toggles the WP GPIO when reg_write
>> nvmem_config API is defined. In case of MTD framework, reg_write is not
>> defined in nvmem_config.
> 
> Thanks for digging these up. I think this was the wrong decision to
> make. NVMEM should just provide the APIs for handling read/write, and
> leave the rest to the drivers.
> 
> It might be convenient for some drivers to put the WP GPIO handling to
> NVMEM core but I just don't think it is the job of the framework to deal
> with this, and it just does not know enough about the device to deal
> with correctly and completely anyway. For example, wp-gpio is only one
> of the ways to write protect a chip. SPI NOR flashes have a WP# pin that
> is often toggled via the SPI controller. There could also be registers
> that do the write protection.
> 
> One would have to make strong justifications for making nvmem directly
> deal with hardware level details to convince me it is a good idea. IMHO
> if AT24 EEPROM is the only driver relying on this as of now then we
> should just revert the patches and not have to deal with the
> skip_wp_gpio hackery.
> 

Based on the  bindings documentation, AT24 EEPROM driver is not the only
driver relying on this implementation. At least, AT25 EEPROM driver will
have to be modified to handle the Write Protect management, and there is
probably others drivers relying on this implementation.

So, should we keep the legacy and apply the proposal patch to fix this
conflict (I can send a V3 with a fixes tag on patch 3 and 4 as
recommended by Miquel)?
Or should we revert the Write Protect management in NVMEM framework
but in this case I will not be able to handle such modifications (I am
not able to test those drivers).

Regards,
Christophe Kerello.

>>
>> Based on the comments made, it seems that we also agree that this write
>> protection should be handled by MTD subsystems or associated drivers and not
>> by MVMEN framework for MTD use cases.
>>
>> The proposal implementation should solve this conflict for MTD framework
>> without breaking anything for others NVMEM users (EEPROMs flashes for
>> example).
> 
