Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CB32E4A6F2A
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Feb 2022 11:48:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238361AbiBBKrH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Feb 2022 05:47:07 -0500
Received: from mx07-00178001.pphosted.com ([185.132.182.106]:33836 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S238047AbiBBKrG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Feb 2022 05:47:06 -0500
Received: from pps.filterd (m0241204.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.16.1.2/8.16.1.2) with ESMTP id 2123Qan3020572;
        Wed, 2 Feb 2022 11:44:34 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=selector1;
 bh=Pr+oyaHcfqpMwRbyH1wMPUUz5wBqaWEV5O1Y7oxTiwo=;
 b=mOafBqFdJrltQ6Nxc3xfmzXumBTL/XpBQ82HXlDFJNy5AtlxijQny4nbmwxYR93QykGZ
 DPMU2xRL/jQLoW9j6Z2Wt8AJukLwYnoa5yMreoqyawtBcD4ne6fPX8stoZfUi8jaZtLA
 C5DVK6k77x3/jbuL7xTtGs162ODwa1p9H8ZJFdk3vSAuM0bjudkF4ROOdfgpVt8FtfrO
 zm3LH6UbHWcpbWx8MuEhaY3HT6fsN7U373VVAoMUhd28mNvgjrm1rRxRG/dSBDitx0wQ
 FDufzqditkdHot90rrKEPsAnec32bCTrdwsI4y7hUBJW0DPOlFccodhP/g+BTfh+t93t lw== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com (PPS) with ESMTPS id 3dy1xm5h7m-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 02 Feb 2022 11:44:34 +0100
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 4C90310002A;
        Wed,  2 Feb 2022 11:44:32 +0100 (CET)
Received: from Webmail-eu.st.com (sfhdag2node2.st.com [10.75.127.5])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 340AC2171D1;
        Wed,  2 Feb 2022 11:44:32 +0100 (CET)
Received: from [10.48.0.175] (10.75.127.47) by SFHDAG2NODE2.st.com
 (10.75.127.5) with Microsoft SMTP Server (TLS) id 15.0.1497.26; Wed, 2 Feb
 2022 11:44:31 +0100
Message-ID: <eebfa629-ead2-d63f-9cfb-4cafc1534678@foss.st.com>
Date:   Wed, 2 Feb 2022 11:44:31 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH v2 4/4] mtd: core: Fix a conflict between MTD and NVMEM on
 wp-gpios property
Content-Language: en-US
To:     Pratyush Yadav <p.yadav@ti.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>
CC:     <richard@nod.at>, <vigneshr@ti.com>, <robh+dt@kernel.org>,
        <srinivas.kandagatla@linaro.org>, <linux-mtd@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-stm32@st-md-mailman.stormreply.com>,
        <devicetree@vger.kernel.org>, <chenshumin86@sina.com>,
        Tudor Ambarus <Tudor.Ambarus@microchip.com>
References: <20220131095755.8981-1-christophe.kerello@foss.st.com>
 <20220131095755.8981-5-christophe.kerello@foss.st.com>
 <20220131144309.0ffe7cc8@xps13> <20220201104727.7xvcyexf3yucegcb@ti.com>
From:   Christophe Kerello <christophe.kerello@foss.st.com>
In-Reply-To: <20220201104727.7xvcyexf3yucegcb@ti.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.75.127.47]
X-ClientProxiedBy: SFHDAG2NODE2.st.com (10.75.127.5) To SFHDAG2NODE2.st.com
 (10.75.127.5)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.816,Hydra:6.0.425,FMLib:17.11.62.513
 definitions=2022-02-02_04,2022-02-01_01,2021-12-02_01
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 2/1/22 11:47, Pratyush Yadav wrote:
> On 31/01/22 02:43PM, Miquel Raynal wrote:
>> Hi Vignesh, Tudory, Pratyush,
>>
>> + Tudor and Pratyush
>>
>> christophe.kerello@foss.st.com wrote on Mon, 31 Jan 2022 10:57:55 +0100:
>>
>>> Wp-gpios property can be used on NVMEM nodes and the same property can
>>> be also used on MTD NAND nodes. In case of the wp-gpios property is
>>> defined at NAND level node, the GPIO management is done at NAND driver
>>> level. Write protect is disabled when the driver is probed or resumed
>>> and is enabled when the driver is released or suspended.
>>>
>>> When no partitions are defined in the NAND DT node, then the NAND DT node
>>> will be passed to NVMEM framework. If wp-gpios property is defined in
>>> this node, the GPIO resource is taken twice and the NAND controller
>>> driver fails to probe.
>>>
>>> A new Boolean flag named skip_wp_gpio has been added in nvmem_config.
>>> In case skip_wp_gpio is set, it means that the GPIO is handled by the
>>> provider. Lets set this flag in MTD layer to avoid the conflict on
>>> wp_gpios property.
>>>
>>> Signed-off-by: Christophe Kerello <christophe.kerello@foss.st.com>
>>> ---
>>>   drivers/mtd/mtdcore.c | 2 ++
>>>   1 file changed, 2 insertions(+)
>>>
>>> diff --git a/drivers/mtd/mtdcore.c b/drivers/mtd/mtdcore.c
>>> index 70f492dce158..e6d251594def 100644
>>> --- a/drivers/mtd/mtdcore.c
>>> +++ b/drivers/mtd/mtdcore.c
>>> @@ -546,6 +546,7 @@ static int mtd_nvmem_add(struct mtd_info *mtd)
>>>   	config.stride = 1;
>>>   	config.read_only = true;
>>>   	config.root_only = true;
>>> +	config.skip_wp_gpio = true;
>>>   	config.no_of_node = !of_device_is_compatible(node, "nvmem-cells");
>>>   	config.priv = mtd;
>>>   
>>> @@ -833,6 +834,7 @@ static struct nvmem_device *mtd_otp_nvmem_register(struct mtd_info *mtd,
>>>   	config.owner = THIS_MODULE;
>>>   	config.type = NVMEM_TYPE_OTP;
>>>   	config.root_only = true;
>>> +	config.skip_wp_gpio = true;
>>>   	config.reg_read = reg_read;
>>>   	config.size = size;
>>>   	config.of_node = np;
>>
>> TLDR: There is a conflict between MTD and NVMEM, who should handle the
>> WP pin when there is one? At least for raw NAND devices, I don't want
>> the NVMEM core to handle the wp pin. So we've introduced this
>> skip_wp_gpio nvmem config option. But there are two places where this
>> boolean can be set and one of these is for otp regions (see above). In
>> this case, I don't know if it is safe or if CFI/SPI-NOR rely on the
>> nvmem protection. Please tell us if you think this is fine for you.
> 
> Why does NVMEM touch hardware write protection in the first place? The
> purpose of the framework is to provide a way to retrieve config stored
> in memory. It has no business dealing with details of the chip like the
> WP line. That should be MTD's job (which it should delegate to SPI NOR,
> SPI NAND, etc.). If you want to write protect a cell then do it in
> software. I don't see why NVMEM should be dealing with hardware directly
> at all.
> 
> That is my mental model of how things _should_ work. I have not spent
> much time digging into how things actually work currently.
> 

Wp-gpios property management was added in MVMEM framework in January 
2020 => sha1: 2a127da461a9d8d97782d6e82b227041393eb4d2
"
     nvmem: add support for the write-protect pin

     The write-protect pin handling looks like a standard property that
     could benefit other users if available in the core nvmem framework.

     Instead of modifying all the memory drivers to check this pin, make
     the NVMEM subsystem check if the write-protect GPIO being passed
     through the nvmem_config or defined in the device tree and pull it
     low whenever writing to the memory.
"

And this modification was done for EEPROMs flashes => sha1: 
1c89074bf85068d1b86f2e0f0c2110fdd9b83c9f
"
     eeprom: at24: remove the write-protect pin support

     NVMEM framework is an interface for the at24 EEPROMs as well as for
     other drivers, instead of passing the wp-gpios over the different
     drivers each time, it would be better to pass it over the NVMEM
     subsystem once and for all.

     Removing the support for the write-protect pin after adding it to
     the NVMEM subsystem.
"

Current NVMEM framework implementation toggles the WP GPIO when 
reg_write nvmem_config API is defined. In case of MTD framework, 
reg_write is not defined in nvmem_config.

Based on the comments made, it seems that we also agree that this write 
protection should be handled by MTD subsystems or associated drivers and 
not by MVMEN framework for MTD use cases.

The proposal implementation should solve this conflict for MTD framework 
without breaking anything for others NVMEM users (EEPROMs flashes for 
example).

Regards,
Christophe Kerello.


