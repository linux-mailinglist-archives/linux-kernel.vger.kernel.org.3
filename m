Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5A7C84F0FE7
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Apr 2022 09:18:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377633AbiDDHTl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Apr 2022 03:19:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36970 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234334AbiDDHTk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Apr 2022 03:19:40 -0400
Received: from smtpout2.mo529.mail-out.ovh.net (smtpout2.mo529.mail-out.ovh.net [79.137.123.220])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4BC2033EA8
        for <linux-kernel@vger.kernel.org>; Mon,  4 Apr 2022 00:17:44 -0700 (PDT)
Received: from mxplan5.mail.ovh.net (unknown [10.108.16.128])
        by mo529.mail-out.ovh.net (Postfix) with ESMTPS id 00501F2F594E;
        Mon,  4 Apr 2022 09:11:36 +0200 (CEST)
Received: from kaod.org (37.59.142.95) by DAG4EX1.mxp5.local (172.16.2.31)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Mon, 4 Apr
 2022 09:11:34 +0200
Authentication-Results: garm.ovh; auth=pass (GARM-95G0016a9dc02d-dd94-4cad-8a52-00a717b27f96,
                    193BEDB8EED17CFBFC1316EE01F9191BF107EB6B) smtp.auth=clg@kaod.org
X-OVh-ClientIp: 82.64.250.170
Message-ID: <3e5ea70d-805a-ff30-663b-e802d9116a49@kaod.org>
Date:   Mon, 4 Apr 2022 09:11:33 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH v4 04/11] spi: aspeed: Add support for direct mapping
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
 <20220325100849.2019209-5-clg@kaod.org>
 <20220330194548.zldbkaoctlhgwcl2@ti.com>
From:   =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>
In-Reply-To: <20220330194548.zldbkaoctlhgwcl2@ti.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [37.59.142.95]
X-ClientProxiedBy: DAG5EX1.mxp5.local (172.16.2.41) To DAG4EX1.mxp5.local
 (172.16.2.31)
X-Ovh-Tracer-GUID: 392fb3cf-682b-418f-9b6e-8d88ba5d0c6b
X-Ovh-Tracer-Id: 11108128482050476871
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgedvvddrudejuddguddukecutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfqggfjpdevjffgvefmvefgnecuuegrihhlohhuthemucehtddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefkffggfgfuvfhfhfgjtgfgihesthekredttdefjeenucfhrhhomhepveorughrihgtpgfnvggpifhorghtvghruceotghlgheskhgrohgurdhorhhgqeenucggtffrrghtthgvrhhnpeekleejfeevjeehiefhgeelgeeludduleeuvdffteduieegvdfgteevfeetkeetfeenucffohhmrghinhepsghufhdrihhnnecukfhppedtrddtrddtrddtpdefjedrheelrddugedvrdelheenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhhouggvpehsmhhtphhouhhtpdhhvghlohepmhigphhlrghnhedrmhgrihhlrdhovhhhrdhnvghtpdhinhgvtheptddrtddrtddrtddpmhgrihhlfhhrohhmpegtlhhgsehkrghougdrohhrghdpnhgspghrtghpthhtohepuddprhgtphhtthhopehrvghnthgrohdrsghuphhtsehgmhgrihhlrdgtohhm
X-Spam-Status: No, score=-2.5 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/30/22 21:45, Pratyush Yadav wrote:
> On 25/03/22 11:08AM, Cédric Le Goater wrote:
>> Use direct mapping to read the flash device contents. This operation
>> mode is called "Command mode" on Aspeed SoC SMC controllers. It uses a
>> Control Register for the settings to apply when a memory operation is
>> performed on the flash device mapping window.
>>
>> If the window is not big enough, fall back to the "User mode" to
>> perform the read.
>>
>> Since direct mapping now handles all reads of the flash device
>> contents, also use memcpy_fromio for other address spaces, such as
>> SFDP.
>>
>> Direct mapping for writes will come later when validated.
>>
>> Reviewed-by: Joel Stanley <joel@jms.id.au>
>> Tested-by: Joel Stanley <joel@jms.id.au>
>> Tested-by: Tao Ren <rentao.bupt@gmail.com>
>> Signed-off-by: Cédric Le Goater <clg@kaod.org>
>> ---
>>   drivers/spi/spi-aspeed-smc.c | 67 ++++++++++++++++++++++++++++++++++--
>>   1 file changed, 65 insertions(+), 2 deletions(-)
>>
>> diff --git a/drivers/spi/spi-aspeed-smc.c b/drivers/spi/spi-aspeed-smc.c
>> index 997ec2e45118..0951766baef4 100644
>> --- a/drivers/spi/spi-aspeed-smc.c
>> +++ b/drivers/spi/spi-aspeed-smc.c
>> @@ -322,8 +322,8 @@ static int do_aspeed_spi_exec_op(struct spi_mem *mem, const struct spi_mem_op *o
>>   		if (!op->addr.nbytes)
>>   			ret = aspeed_spi_read_reg(chip, op);
>>   		else
>> -			ret = aspeed_spi_read_user(chip, op, op->addr.val,
>> -						   op->data.nbytes, op->data.buf.in);
>> +			memcpy_fromio(op->data.buf.in, chip->ahb_base + op->addr.val,
>> +				      op->data.nbytes);
> 
> I think I commented on this earlier too, though I failed to respond to
> your reply. Let me bring the topic back up. I think this can cause an
> invalid memory address to be accessed. Not all SPI MEM consumers will
> use dirmap APIs, and they won't use them all the time. For example, SPI
> NOR can perform some operations to reset the flash before shutting down.
> For example, SPI NOR turns off 4byte address mode during shutdown. This
> will be a register read/write operation, which usually has a different
> opcode.

It's only a small optimization for startup when the SFDP probing is done.
There are quite a few reads which are large :

   spi-aspeed-smc 1e630000.spi: CE0 read OP 0x5a mode:1.1.1.1 naddr:0x3 ndummies:0x1 len:0x10
   spi-aspeed-smc 1e630000.spi: CE0 read OP 0x5a mode:1.1.1.1 naddr:0x3 ndummies:0x1 len:0x10
   spi-aspeed-smc 1e630000.spi: CE0 read OP 0x5a mode:1.1.1.1 naddr:0x3 ndummies:0x1 len:0x120
   spi-aspeed-smc 1e630000.spi: CE0 read OP 0x5a mode:1.1.1.1 naddr:0x3 ndummies:0x1 len:0x40
   spi-aspeed-smc 1e630000.spi: CE0 read OP 0x5a mode:1.1.1.1 naddr:0x3 ndummies:0x1 len:0x8

> 
> So I think you should keep dirmap and exec_op() independent of each
> other.

OK. I understand. It's not a problem as it works either way.

Thanks,

C.


>>   	} else {
>>   		if (!op->addr.nbytes)
>>   			ret = aspeed_spi_write_reg(chip, op);
>> @@ -403,10 +403,73 @@ static int aspeed_spi_chip_set_default_window(struct aspeed_spi_chip *chip)
>>   	return chip->ahb_window_size ? 0 : -1;
>>   }
>>   
>> +static int aspeed_spi_dirmap_create(struct spi_mem_dirmap_desc *desc)
>> +{
>> +	struct aspeed_spi *aspi = spi_controller_get_devdata(desc->mem->spi->master);
>> +	struct aspeed_spi_chip *chip = &aspi->chips[desc->mem->spi->chip_select];
>> +	struct spi_mem_op *op = &desc->info.op_tmpl;
>> +	u32 ctl_val;
>> +	int ret = 0;
>> +
>> +	chip->clk_freq = desc->mem->spi->max_speed_hz;
>> +
>> +	/* Only for reads */
>> +	if (op->data.dir != SPI_MEM_DATA_IN)
>> +		return -EOPNOTSUPP;
>> +
>> +	if (desc->info.length > chip->ahb_window_size)
>> +		dev_warn(aspi->dev, "CE%d window (%dMB) too small for mapping",
>> +			 chip->cs, chip->ahb_window_size >> 20);
>> +
>> +	/* Define the default IO read settings */
>> +	ctl_val = readl(chip->ctl) & ~CTRL_IO_CMD_MASK;
>> +	ctl_val |= aspeed_spi_get_io_mode(op) |
>> +		op->cmd.opcode << CTRL_COMMAND_SHIFT |
>> +		CTRL_IO_DUMMY_SET(op->dummy.nbytes / op->dummy.buswidth) |
>> +		CTRL_IO_MODE_READ;
>> +
>> +	/* Tune 4BYTE address mode */
>> +	if (op->addr.nbytes) {
>> +		u32 addr_mode = readl(aspi->regs + CE_CTRL_REG);
>> +
>> +		if (op->addr.nbytes == 4)
>> +			addr_mode |= (0x11 << chip->cs);
>> +		else
>> +			addr_mode &= ~(0x11 << chip->cs);
>> +		writel(addr_mode, aspi->regs + CE_CTRL_REG);
>> +	}
>> +
>> +	/* READ mode is the controller default setting */
>> +	chip->ctl_val[ASPEED_SPI_READ] = ctl_val;
>> +	writel(chip->ctl_val[ASPEED_SPI_READ], chip->ctl);
>> +
>> +	dev_info(aspi->dev, "CE%d read buswidth:%d [0x%08x]\n",
>> +		 chip->cs, op->data.buswidth, chip->ctl_val[ASPEED_SPI_READ]);
>> +
>> +	return ret;
>> +}
>> +
>> +static ssize_t aspeed_spi_dirmap_read(struct spi_mem_dirmap_desc *desc,
>> +				      u64 offset, size_t len, void *buf)
>> +{
>> +	struct aspeed_spi *aspi = spi_controller_get_devdata(desc->mem->spi->master);
>> +	struct aspeed_spi_chip *chip = &aspi->chips[desc->mem->spi->chip_select];
>> +
>> +	/* Switch to USER command mode if mapping window is too small */
>> +	if (chip->ahb_window_size < offset + len)
>> +		aspeed_spi_read_user(chip, &desc->info.op_tmpl, offset, len, buf);
>> +	else
>> +		memcpy_fromio(buf, chip->ahb_base + offset, len);
>> +
>> +	return len;
>> +}
>> +
>>   static const struct spi_controller_mem_ops aspeed_spi_mem_ops = {
>>   	.supports_op = aspeed_spi_supports_op,
>>   	.exec_op = aspeed_spi_exec_op,
>>   	.get_name = aspeed_spi_get_name,
>> +	.dirmap_create = aspeed_spi_dirmap_create,
>> +	.dirmap_read = aspeed_spi_dirmap_read,
>>   };
>>   
>>   static void aspeed_spi_chip_set_type(struct aspeed_spi *aspi, unsigned int cs, int type)
>> -- 
>> 2.34.1
>>
> 

