Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C548D506B50
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Apr 2022 13:47:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351867AbiDSLt1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Apr 2022 07:49:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40144 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349708AbiDSLt0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Apr 2022 07:49:26 -0400
Received: from ssl.serverraum.org (ssl.serverraum.org [IPv6:2a01:4f8:151:8464::1:2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D37EB2AE1F
        for <linux-kernel@vger.kernel.org>; Tue, 19 Apr 2022 04:46:43 -0700 (PDT)
Received: from ssl.serverraum.org (web.serverraum.org [172.16.0.2])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ssl.serverraum.org (Postfix) with ESMTPSA id 199A12223A;
        Tue, 19 Apr 2022 13:46:42 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=walle.cc; s=mail2016061301;
        t=1650368802;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=hy9+f75H5O31PVsVZ9lqk9GbDwMyawdojGN879oqnow=;
        b=C8gzNaZZKpq/oD1ZbB0WXz+EJf4ObMxe22BZcTCY+2emXyQokICab8hVjiNIa/kKNAxOgD
        Ntoy4Ao17Ka8l1v7azvwmTknaTx1unzYi/a+K8Qosv/FIMyQdDKTOSsj6tyCjvE5OQWB5M
        ivTUQ5edn+2kN0UZYHm8caj/TF/TvI8=
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Tue, 19 Apr 2022 13:46:42 +0200
From:   Michael Walle <michael@walle.cc>
To:     Tudor Ambarus <tudor.ambarus@microchip.com>
Cc:     p.yadav@ti.com, miquel.raynal@bootlin.com, richard@nod.at,
        vigneshr@ti.com, linux-mtd@lists.infradead.org,
        linux-kernel@vger.kernel.org, nicolas.ferre@microchip.com,
        Takahiro Kuwano <Takahiro.Kuwano@infineon.com>
Subject: Re: [PATCH v3 6/9] mtd: spi-nor: core: Add helpers to read/write any
 register
In-Reply-To: <0e4ec58c21490dcd9cf82ab89bd8c34c@walle.cc>
References: <20220411091033.98754-1-tudor.ambarus@microchip.com>
 <20220411091033.98754-7-tudor.ambarus@microchip.com>
 <0e4ec58c21490dcd9cf82ab89bd8c34c@walle.cc>
User-Agent: Roundcube Webmail/1.4.13
Message-ID: <e21b0d76bf778f78f432ba27a673222d@walle.cc>
X-Sender: michael@walle.cc
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am 2022-04-19 13:19, schrieb Michael Walle:
> Am 2022-04-11 11:10, schrieb Tudor Ambarus:
>> There are manufacturers that use registers indexed by address. Some of
>> them support "read/write any register" opcodes. Provide core methods 
>> that
>> can be used by all manufacturers. SPI NOR controller ops are 
>> intentionally
>> not supported as we intend to move all the SPI NOR controller drivers
>> under the SPI subsystem.
>> 
>> Signed-off-by: Tudor Ambarus <tudor.ambarus@microchip.com>
>> Tested-by: Takahiro Kuwano <Takahiro.Kuwano@infineon.com>
>> Reviewed-by: Pratyush Yadav <p.yadav@ti.com>
> 
> I still don't like it because the function doesn't do
> anything what the function name might suggest. The read
> just executes an op, the write executes an op with a
> write enable before. All the behavior is determined by the
> 'op' argument.
> 
> Anyway,
> Reviewed-by: Michael Walle <michael@walle.cc>
> 
>> ---
>> v3: no changes
>> 
>>  drivers/mtd/spi-nor/core.c | 41 
>> ++++++++++++++++++++++++++++++++++++++
>>  drivers/mtd/spi-nor/core.h |  4 ++++
>>  2 files changed, 45 insertions(+)
>> 
>> diff --git a/drivers/mtd/spi-nor/core.c b/drivers/mtd/spi-nor/core.c
>> index 6165dc7bfd17..42794328d3b6 100644
>> --- a/drivers/mtd/spi-nor/core.c
>> +++ b/drivers/mtd/spi-nor/core.c
>> @@ -307,6 +307,47 @@ ssize_t spi_nor_write_data(struct spi_nor *nor,
>> loff_t to, size_t len,
>>  	return nor->controller_ops->write(nor, to, len, buf);
>>  }
>> 
>> +/**
>> + * spi_nor_read_reg() - read register to flash memory
>> + * @nor:        pointer to 'struct spi_nor'.
>> + * @op:		SPI memory operation. op->data.buf must be DMA-able.
>> + * @proto:	SPI protocol to use for the register operation.
>> + *
>> + * Return: zero on success, -errno otherwise
>> + */
>> +int spi_nor_read_reg(struct spi_nor *nor, struct spi_mem_op *op,
>> +		     enum spi_nor_protocol proto)
>> +{
>> +	if (!nor->spimem)
>> +		return -EOPNOTSUPP;
>> +
>> +	spi_nor_spimem_setup_op(nor, op, proto);
>> +	return spi_nor_spimem_exec_op(nor, op);
>> +}
>> +
>> +/**
>> + * spi_nor_write_reg() - write register to flash memory
>> + * @nor:        pointer to 'struct spi_nor'
>> + * @op:		SPI memory operation. op->data.buf must be DMA-able.
>> + * @proto:	SPI protocol to use for the register operation.
>> + *
>> + * Return: zero on success, -errno otherwise
>> + */
>> +int spi_nor_write_reg(struct spi_nor *nor, struct spi_mem_op *op,
>> +		      enum spi_nor_protocol proto)
>> +{
>> +	int ret;
>> +
>> +	if (!nor->spimem)
>> +		return -EOPNOTSUPP;
>> +
>> +	ret = spi_nor_write_enable(nor);
>> +	if (ret)
>> +		return ret;
>> +	spi_nor_spimem_setup_op(nor, op, proto);
>> +	return spi_nor_spimem_exec_op(nor, op);

After seeing your next two patches. Shouldn't the
spi_nor_wait_until_ready() call be here too?

-michael
