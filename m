Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 991E455CE2F
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Jun 2022 15:04:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233546AbiF0KBz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Jun 2022 06:01:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47876 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233887AbiF0KBu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Jun 2022 06:01:50 -0400
X-Greylist: delayed 616 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Mon, 27 Jun 2022 03:01:42 PDT
Received: from 7.mo548.mail-out.ovh.net (7.mo548.mail-out.ovh.net [46.105.33.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B0456252
        for <linux-kernel@vger.kernel.org>; Mon, 27 Jun 2022 03:01:42 -0700 (PDT)
Received: from mxplan5.mail.ovh.net (unknown [10.108.16.62])
        by mo548.mail-out.ovh.net (Postfix) with ESMTPS id 7066B21B82;
        Mon, 27 Jun 2022 09:43:22 +0000 (UTC)
Received: from kaod.org (37.59.142.96) by DAG4EX1.mxp5.local (172.16.2.31)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.9; Mon, 27 Jun
 2022 11:43:20 +0200
Authentication-Results: garm.ovh; auth=pass (GARM-96R001214c8b85-88ae-43d7-9f45-820f0b88e976,
                    D5BAD815273CE4794DDBC5929823026F491AE39B) smtp.auth=clg@kaod.org
X-OVh-ClientIp: 82.64.250.170
Message-ID: <82015d89-cab5-3e9a-a40e-e5dafa17ec0c@kaod.org>
Date:   Mon, 27 Jun 2022 11:43:15 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.0
Subject: Re: [RFC PATCH 3/6] mtd: spi-nor: core: run calibration when
 initialization is done
Content-Language: en-US
To:     Pratyush Yadav <p.yadav@ti.com>
CC:     Miquel Raynal <miquel.raynal@bootlin.com>,
        Nishanth Menon <nm@ti.com>, Tero Kristo <kristo@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Tudor Ambarus <tudor.ambarus@microchip.com>,
        Michael Walle <michael@walle.cc>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Mark Brown <broonie@kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-mtd@lists.infradead.org>, <linux-spi@vger.kernel.org>,
        Joel Stanley <joel@jms.id.au>
References: <20210311191216.7363-1-p.yadav@ti.com>
 <20210311191216.7363-4-p.yadav@ti.com> <20220517160226.4107f282@xps-13>
 <20220518060640.os5fp5rez4ie7qc4@ti.com> <20220518091931.279c5398@xps-13>
 <20220518075651.mvdhfnfbgutecgyq@ti.com>
 <b3bfa5a6-caac-94ed-6741-04db9c2a9ee0@kaod.org>
 <20220627091404.54257obrdazcjhre@ti.com>
From:   =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>
In-Reply-To: <20220627091404.54257obrdazcjhre@ti.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [37.59.142.96]
X-ClientProxiedBy: DAG3EX2.mxp5.local (172.16.2.22) To DAG4EX1.mxp5.local
 (172.16.2.31)
X-Ovh-Tracer-GUID: d90d66d2-6dd4-4970-a538-40e48684ccd2
X-Ovh-Tracer-Id: 8915438414617938820
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgedvfedrudeghedgvddtucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuqfggjfdpvefjgfevmfevgfenuceurghilhhouhhtmecuhedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhepkfffgggfuffvvehfhfgjtgfgihesthekredttdefjeenucfhrhhomhepveorughrihgtpgfnvggpifhorghtvghruceotghlgheskhgrohgurdhorhhgqeenucggtffrrghtthgvrhhnpeekteejtdelkeejvdevffduhfetteelieefgeefffeugffhfeekheffueefledujeenucfkpheptddrtddrtddrtddpfeejrdehledrudegvddrleeinecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmohguvgepshhmthhpohhuthdphhgvlhhopehmgihplhgrnhehrdhmrghilhdrohhvhhdrnhgvthdpihhnvghtpedtrddtrddtrddtpdhmrghilhhfrhhomheptghlgheskhgrohgurdhorhhgpdhnsggprhgtphhtthhopedupdhrtghpthhtohepjhhovghlsehjmhhsrdhiugdrrghupdfovfetjfhoshhtpehmohehgeek
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 6/27/22 11:14, Pratyush Yadav wrote:
> On 18/05/22 10:51AM, Cédric Le Goater wrote:
>> Hello,
>>
>> On 5/18/22 09:56, Pratyush Yadav wrote:
>>> On 18/05/22 09:19AM, Miquel Raynal wrote:
>>>> Hi Pratyush,
>>>>
>>>> p.yadav@ti.com wrote on Wed, 18 May 2022 11:37:05 +0530:
>>>>
>>>>> +Cedric
>>>>>
>>>>> On 17/05/22 04:02PM, Miquel Raynal wrote:
>>>>>> Hi Pratyush,
>>>>>>
>>>>>> p.yadav@ti.com wrote on Fri, 12 Mar 2021 00:42:13 +0530:
>>>>>>> Once the flash is initialized tell the controller it can run
>>>>>>> calibration procedures if needed. This can be useful when calibration is
>>>>>>> needed to run at higher clock speeds.
>>>>>>>
>>>>>>> Signed-off-by: Pratyush Yadav <p.yadav@ti.com>
>>>>>>> ---
>>>>>>>    drivers/mtd/spi-nor/core.c | 12 ++++++++++--
>>>>>>>    1 file changed, 10 insertions(+), 2 deletions(-)
>>>>>>>
>>>>>>> diff --git a/drivers/mtd/spi-nor/core.c b/drivers/mtd/spi-nor/core.c
>>>>>>> index 88888df009f0..e0cbcaf1be89 100644
>>>>>>> --- a/drivers/mtd/spi-nor/core.c
>>>>>>> +++ b/drivers/mtd/spi-nor/core.c
>>>>>>> @@ -3650,6 +3650,7 @@ static int spi_nor_probe(struct spi_mem *spimem)
>>>>>>>    	 * checking what's really supported using spi_mem_supports_op().
>>>>>>>    	 */
>>>>>>>    	const struct spi_nor_hwcaps hwcaps = { .mask = SNOR_HWCAPS_ALL };
>>>>>>> +	struct spi_mem_op op;
>>>>>>>    	char *flash_name;
>>>>>>>    	int ret;
>>>>>>> @@ -3709,8 +3710,15 @@ static int spi_nor_probe(struct spi_mem *spimem)
>>>>>>>    	if (ret)
>>>>>>>    		return ret;
>>>>>>> -	return mtd_device_register(&nor->mtd, data ? data->parts : NULL,
>>>>>>> -				   data ? data->nr_parts : 0);
>>>>>>> +	ret = mtd_device_register(&nor->mtd, data ? data->parts : NULL,
>>>>>>> +				  data ? data->nr_parts : 0);
>>>>>>> +	if (ret)
>>>>>>> +		return ret;
>>>>>>> +
>>>>>>> +	op = spi_nor_spimem_get_read_op(nor);
>>>>>>
>>>>>> Isn't this too specific? I really don't know much about spi-nors, but I
>>>>>> find odd to have this op being created here, why not moving this into
>>>>>> the _do_calibration() helper?
>>>>>
>>>>> Maybe the naming confused you but this is a function in the SPI NOR
>>>>> core, not in SPI MEM. SPI NOR supports both SPI MEM based controllers
>>>>> and "legacy" controllers, so the convention is to add the "spimem"
>>>>> prefix before SPI MEM specific functions. So I don't get the comment
>>>>> about it being too specific. It is too specific to what?
>>>>
>>>> Mmh right, it's fine then.
>>>>
>>>>>
>>>>> And how can spi_mem_do_calibration() know what op the flash uses to read
>>>>> data? SPI NOR or SPI NAND would know it, but not SPI MEM. That is why we
>>>>> pass in that information to spi_mem_do_calibration().
>>>>
>>>> But here the op is "spi-nor wide", I would have expected a
>>>> per-device op. But that is not a big deal, that is something that can
>>>> also be updated later if needed I guess.
>>>
>>> It is per-device. The op is generated using nor->read_opcode,
>>> nor->addr_width, nor->read_dummy, etc. So if you have 2 NOR flashes on
>>> your system with different opcodes, it would work for both.
>>>
>>>>
>>>> One last question, is there something that mtd_device_register() does
>>>> that is really needed for the calibration to work? Otherwise I would
>>>> rather prefer to have that calibration happening before the user gets
>>>> access to the device.
>>
>> Which would mean calling it right after :
>>
>> 	ret = spi_nor_create_read_dirmap(nor);
>> 	if (ret)
>> 		return ret;
>>
>> 	ret = spi_nor_create_write_dirmap(nor);
>> 	if (ret)
>> 		return ret;
>>
>>> The calibration works by reading a known pattern that is already written
>>> to the flash again and again and seeing what delays work and what don't.
>>> For that to happen, the controller driver needs to know where the
>>> pattern is stored.
>>
>> Why don't you simply choose some random place, first 16KB for instance,
>> and check that the data is random enough ? If not, declare calibration
>> not possible and choose a default safe setting which is anyhow a
>> requirement for calibration. Retry at reboot as data might have changed.
> 
> I did not come up with the pattern myself. But from what I can
> understand, the pattern is not random at all, but is carefully chosen to
> target certain ways a read can fail on the controller. So a random piece
> of data won't work as well as this carefully designed pattern.

True. I don't exactly remember how your proposal worked from the
driver side but I imagine having a specific DT property to locate
that pattern in the setup handler and to use it later on is not
too complex.

>>> This series does that by looking at the MTD
>>> partitions. For that to happen, we need to create those partitions
>>> first, which happens after mtd_device_register().
>>
>> hmm, that might work for some boards. This is not at all the case for
>> the BMC boards. Vendors can put any kind of flash model and/or layout
>> and the driver needs to be more generic.
> 
> Yes, vendors can choose any layout, but one partition on that layout
> would be your calibration pattern. I think you can use a different
> compatible for that partition. 

OK. and that it would become more generic then.

> I have not thought this through yet though.

If a partition is required, that's a dependency on mtdpart.

It could be done from spi_nor_probe() after mtd_device_register() with
some spimem handler using the 'struct mtd_partition' for the {size,offset}
parameters.

>>
>>> But I am planning to use device tree to get that information now so this
>>> should no longer be needed and we can do calibration before registering
>>> the device with MTD.
>>
>> Perfect, we can move the calibration hook in spi_nor_create_read_dirmap()
>> then, or in devm_spi_mem_dirmap_create(), which would make more sense IMHO.
> 
> Sorry, I still don't get why you want to tie dirmap and calibration
> together. Just let them be independent and let flash drivers take care
> of when to call what. SPI MEM should not care.

I know you would prefer a specific handler and that can still be done.

Thanks,

C.
