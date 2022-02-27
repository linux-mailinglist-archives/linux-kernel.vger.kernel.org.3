Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2EB364C5F10
	for <lists+linux-kernel@lfdr.de>; Sun, 27 Feb 2022 22:28:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231697AbiB0V2g (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 27 Feb 2022 16:28:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59230 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229549AbiB0V2d (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 27 Feb 2022 16:28:33 -0500
X-Greylist: delayed 8971 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Sun, 27 Feb 2022 13:27:55 PST
Received: from 6.mo552.mail-out.ovh.net (6.mo552.mail-out.ovh.net [188.165.49.222])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 86CC313F79
        for <linux-kernel@vger.kernel.org>; Sun, 27 Feb 2022 13:27:55 -0800 (PST)
Received: from mxplan5.mail.ovh.net (unknown [10.109.143.118])
        by mo552.mail-out.ovh.net (Postfix) with ESMTPS id E30F222C9F;
        Sun, 27 Feb 2022 21:27:53 +0000 (UTC)
Received: from kaod.org (37.59.142.103) by DAG4EX1.mxp5.local (172.16.2.31)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.18; Sun, 27 Feb
 2022 22:27:52 +0100
Authentication-Results: garm.ovh; auth=pass (GARM-103G005bd4da659-6e74-42ae-98f4-7b2406606e6c,
                    949565DF20DEE76D4A77FF7731A75FE8B07B1F6B) smtp.auth=clg@kaod.org
X-OVh-ClientIp: 82.64.250.170
Message-ID: <890fce14-8001-74c9-21a9-0de117e743ef@kaod.org>
Date:   Sun, 27 Feb 2022 22:27:52 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH 08/10] spi: aspeed: Calibrate read timings
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
        <linux-kernel@vger.kernel.org>
References: <20220214094231.3753686-1-clg@kaod.org>
 <20220214094231.3753686-9-clg@kaod.org>
 <20220225091809.gvup3mcst45szi6x@ti.com>
From:   =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>
In-Reply-To: <20220225091809.gvup3mcst45szi6x@ti.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [37.59.142.103]
X-ClientProxiedBy: DAG6EX2.mxp5.local (172.16.2.52) To DAG4EX1.mxp5.local
 (172.16.2.31)
X-Ovh-Tracer-GUID: 9a51f072-26f3-48de-b05f-06cdd16eb070
X-Ovh-Tracer-Id: 17066672266216704900
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgedvvddrleekgddugeejucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuqfggjfdpvefjgfevmfevgfenuceurghilhhouhhtmecuhedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhepkfffgggfuffvfhfhjggtgfhisehtkeertddtfeejnecuhfhrohhmpeevrogurhhitggpnfgvpgfiohgrthgvrhcuoegtlhhgsehkrghougdrohhrgheqnecuggftrfgrthhtvghrnhepudetudefueeffedvjeeiieffleegtefgledthfelueevieetgeekuedvffdtteehnecuffhomhgrihhnpehoiihlrggsshdrohhrghenucfkpheptddrtddrtddrtddpfeejrdehledrudegvddruddtfeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhhouggvpehsmhhtphhouhhtpdhhvghlohepmhigphhlrghnhedrmhgrihhlrdhovhhhrdhnvghtpdhinhgvtheptddrtddrtddrtddpmhgrihhlfhhrohhmpegtlhhgsehkrghougdrohhrghdpnhgspghrtghpthhtohepuddprhgtphhtthhopehlihhnuhigqdhkvghrnhgvlhesvhhgvghrrdhkvghrnhgvlhdrohhrgh
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/25/22 10:18, Pratyush Yadav wrote:
> On 14/02/22 10:42AM, Cédric Le Goater wrote:
>> To accommodate the different response time of SPI transfers on different
>> boards and different SPI NOR devices, the Aspeed controllers provide a
>> set of Read Timing Compensation registers to tune the timing delays
>> depending on the frequency being used. The AST2600 SoC has one of
>> these registers per device. On the AST2500 and AST2400 SoCs, the
>> timing register is shared by all devices which is a bit problematic to
>> get good results other than for one device.
>>
>> The algorithm first reads a golden buffer at low speed and then performs
>> reads with different clocks and delay cycle settings to find a breaking
>> point. This selects a default good frequency for the CEx control register.
>> The current settings are bit optimistic as we pick the first delay giving
>> good results. A safer approach would be to determine an interval and
>> choose the middle value.
>>
>> Due to the lack of API, calibration is performed when the direct mapping
>> for reads is created.
> 
> The dirmap_create mapping says nothing about _when_ it should be called.
> So there is no guarantee that it will only be called after the flash is
> fully initialized. 

spi_nor_create_read_dirmap() is called after spi_nor_scan() in spi_nor_probe().
Since a spi_mem_dirmap_info descriptor is created using the nor fields :

	struct spi_mem_dirmap_info info = {
		.op_tmpl = SPI_MEM_OP(SPI_MEM_OP_CMD(nor->read_opcode, 0),
				      SPI_MEM_OP_ADDR(nor->addr_width, 0, 0),
				      SPI_MEM_OP_DUMMY(nor->read_dummy, 0),
				      SPI_MEM_OP_DATA_IN(0, NULL, 0)),
		.offset = 0,
		.length = nor->params->size,
	};
	struct spi_mem_op *op = &info.op_tmpl;

the spi-mem framework makes the assumption that the nor object is initialized.

> I suggest you either make this a requirement of the API,

how ?

Thanks,

C.


> or create a new API that guarantees it will only be called after
> the flash is initialized, like [0].
> 
> [0] https://patchwork.ozlabs.org/project/linux-mtd/patch/20210311191216.7363-2-p.yadav@ti.com/
> 
>>
>> Cc: Pratyush Yadav <p.yadav@ti.com>
>> Signed-off-by: Cédric Le Goater <clg@kaod.org>
>> ---
> 

