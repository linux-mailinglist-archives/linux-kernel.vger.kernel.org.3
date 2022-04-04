Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 792704F1004
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Apr 2022 09:30:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377683AbiDDHcc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Apr 2022 03:32:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38612 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347284AbiDDHc1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Apr 2022 03:32:27 -0400
Received: from 1.mo552.mail-out.ovh.net (1.mo552.mail-out.ovh.net [178.32.96.117])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C9A61377D9
        for <linux-kernel@vger.kernel.org>; Mon,  4 Apr 2022 00:30:30 -0700 (PDT)
Received: from mxplan5.mail.ovh.net (unknown [10.109.146.192])
        by mo552.mail-out.ovh.net (Postfix) with ESMTPS id 13CB5224F4;
        Mon,  4 Apr 2022 07:30:27 +0000 (UTC)
Received: from kaod.org (37.59.142.101) by DAG4EX1.mxp5.local (172.16.2.31)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Mon, 4 Apr
 2022 09:30:26 +0200
Authentication-Results: garm.ovh; auth=pass (GARM-101G0041c6325e6-010e-462f-a9ff-e43c6fe6fcff,
                    193BEDB8EED17CFBFC1316EE01F9191BF107EB6B) smtp.auth=clg@kaod.org
X-OVh-ClientIp: 82.64.250.170
Message-ID: <8c88e726-0ddb-e2ba-35df-676cfc3d0475@kaod.org>
Date:   Mon, 4 Apr 2022 09:30:25 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH v4 08/11] spi: aspeed: Calibrate read timings
Content-Language: en-US
To:     Pratyush Yadav <p.yadav@ti.com>
CC:     <linux-spi@vger.kernel.org>, <linux-mtd@lists.infradead.org>,
        Mark Brown <broonie@kernel.org>,
        Tudor Ambarus <tudor.ambarus@microchip.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        <linux-aspeed@lists.ozlabs.org>, Joel Stanley <joel@jms.id.au>,
        Andrew Jeffery <andrew@aj.id.au>,
        Chin-Ting Kuo <chin-ting_kuo@aspeedtech.com>,
        <devicetree@vger.kernel.org>, Rob Herring <robh+dt@kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, Tao Ren <rentao.bupt@gmail.com>
References: <20220325100849.2019209-1-clg@kaod.org>
 <20220325100849.2019209-9-clg@kaod.org>
 <20220331164115.w5q3wxlmwcg3w4ns@ti.com>
From:   =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>
In-Reply-To: <20220331164115.w5q3wxlmwcg3w4ns@ti.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [37.59.142.101]
X-ClientProxiedBy: DAG4EX1.mxp5.local (172.16.2.31) To DAG4EX1.mxp5.local
 (172.16.2.31)
X-Ovh-Tracer-GUID: 06f63634-85ae-4b96-a96f-c3ad2ae45158
X-Ovh-Tracer-Id: 11426476679860161351
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgedvvddrudejuddguddvvdcutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfqggfjpdevjffgvefmvefgnecuuegrihhlohhuthemucehtddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefkffggfgfuvfhfhfgjtgfgihesthekredttdefjeenucfhrhhomhepveorughrihgtpgfnvggpifhorghtvghruceotghlgheskhgrohgurdhorhhgqeenucggtffrrghtthgvrhhnpeeigedvffekgeeftedutddttdevudeihfegudffkeeitdekkeetkefhffelveelleenucfkpheptddrtddrtddrtddpfeejrdehledrudegvddruddtudenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhhouggvpehsmhhtphhouhhtpdhhvghlohepmhigphhlrghnhedrmhgrihhlrdhovhhhrdhnvghtpdhinhgvtheptddrtddrtddrtddpmhgrihhlfhhrohhmpegtlhhgsehkrghougdrohhrghdpnhgspghrtghpthhtohepuddprhgtphhtthhopehrvghnthgrohdrsghuphhtsehgmhgrihhlrdgtohhm
X-Spam-Status: No, score=-2.5 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/31/22 18:41, Pratyush Yadav wrote:
> Hi,
> 
> On 25/03/22 11:08AM, Cédric Le Goater wrote:
>> To accommodate the different response time of SPI transfers on different
>> boards and different SPI NOR devices, the Aspeed controllers provide a
>> set of Read Timing Compensation registers to tune the timing delays
>> depending on the frequency being used. The AST2600 SoC has one of these
>> registers per device. On the AST2500 and AST2400 SoCs, the timing
>> register is shared by all devices which is problematic to get good
>> results other than for one device.
>>
>> The algorithm first reads a golden buffer at low speed and then performs
>> reads with different clocks and delay cycle settings to find a breaking
>> point. This selects a default good frequency for the CEx control register.
>> The current settings are a bit optimistic as we pick the first delay giving
>> good results. A safer approach would be to determine an interval and
>> choose the middle value.
>>
>> Calibration is performed when the direct mapping for reads is created.
>> Since the underlying spi-nor object needs to be initialized to create
>> the spi_mem operation for direct mapping, we should be fine. Having a
>> specific API would clarify the requirements though.
>>
>> Cc: Pratyush Yadav <p.yadav@ti.com>
>> Reviewed-by: Joel Stanley <joel@jms.id.au>
>> Tested-by: Joel Stanley <joel@jms.id.au>
>> Tested-by: Tao Ren <rentao.bupt@gmail.com>
>> Signed-off-by: Cédric Le Goater <clg@kaod.org>
>> ---
>>   drivers/spi/spi-aspeed-smc.c | 281 +++++++++++++++++++++++++++++++++++
>>   1 file changed, 281 insertions(+)
>>
> [...]
>> @@ -517,6 +527,8 @@ static int aspeed_spi_chip_adjust_window(struct aspeed_spi_chip *chip,
>>   	return 0;
>>   }
>>   
>> +static int aspeed_spi_do_calibration(struct aspeed_spi_chip *chip);
>> +
>>   static int aspeed_spi_dirmap_create(struct spi_mem_dirmap_desc *desc)
>>   {
>>   	struct aspeed_spi *aspi = spi_controller_get_devdata(desc->mem->spi->master);
>> @@ -565,6 +577,8 @@ static int aspeed_spi_dirmap_create(struct spi_mem_dirmap_desc *desc)
>>   	chip->ctl_val[ASPEED_SPI_READ] = ctl_val;
>>   	writel(chip->ctl_val[ASPEED_SPI_READ], chip->ctl);
>>   
>> +	ret = aspeed_spi_do_calibration(chip);
>> +
> 
> I am still not convinced this is a good idea. The API does not say
> anywhere what dirmap_create must be called after the flash is completely
> initialized, though that is what is done currently in practice. 

Yes because we wouldn't have a correct 'spi_mem_dirmap_info' if it wasn't
the case. May be change the documentation ?

> I think
> an explicit API to mark flash as "ready for calibration" would be a
> better idea.

OK. Since the above is a oneliner, it should not be a problem to move
it under a new handler if needed.

The dirmap_create() handler expects the spi-mem descriptor and the field
'desc->info.op_tmpl' to be correctly initialized in order to compute the
control register value, which is a requirement for dirmap_read(). The
calibration sequence simply comes after.

AFAICT, there is nothing incorrect today.

> Tudor/Mark/Miquel, what do you think?


Thanks,

C.
