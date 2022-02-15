Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 04E7D4B71F4
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Feb 2022 17:41:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240766AbiBOPnH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Feb 2022 10:43:07 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:39604 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241165AbiBOPlB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Feb 2022 10:41:01 -0500
Received: from lelv0143.ext.ti.com (lelv0143.ext.ti.com [198.47.23.248])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 85A3A13DE15;
        Tue, 15 Feb 2022 07:34:31 -0800 (PST)
Received: from lelv0265.itg.ti.com ([10.180.67.224])
        by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 21FFXwV8039094;
        Tue, 15 Feb 2022 09:33:58 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1644939238;
        bh=h/zYlGUEcc55g9uDoWcPM6icynXj9sCfC3wz2wPbMlI=;
        h=Date:Subject:To:CC:References:From:In-Reply-To;
        b=HkQhHlHz4evf9qkhvc1KP9o7Ynwyec/ugo97uiN1mhCCOCqfCJVQammQpVOjTS+Pf
         Be7nyf9Kk3bhynTxrb+JuvjvhIfXw54EG6SmrUFJn6aiJ+dprtX1veGYvMc5Kj4q9o
         pV6eT63AzQbHDrzhP+yLG/FtdjSOfeXWLkcruMpU=
Received: from DLEE100.ent.ti.com (dlee100.ent.ti.com [157.170.170.30])
        by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 21FFXw47061286
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 15 Feb 2022 09:33:58 -0600
Received: from DLEE109.ent.ti.com (157.170.170.41) by DLEE100.ent.ti.com
 (157.170.170.30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2308.14; Tue, 15
 Feb 2022 09:33:58 -0600
Received: from fllv0040.itg.ti.com (10.64.41.20) by DLEE109.ent.ti.com
 (157.170.170.41) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2308.14 via
 Frontend Transport; Tue, 15 Feb 2022 09:33:58 -0600
Received: from [10.250.233.196] (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0040.itg.ti.com (8.15.2/8.15.2) with ESMTP id 21FFXqVL025861;
        Tue, 15 Feb 2022 09:33:53 -0600
Message-ID: <bf3ea909-e0a5-eeac-12e9-c8a809685f48@ti.com>
Date:   Tue, 15 Feb 2022 21:03:52 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH v3 05/17] mtd: spinand: Define ctrl_ops for non-page
 read/write op templates
Content-Language: en-US
To:     Boris Brezillon <boris.brezillon@collabora.com>
CC:     Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Mark Brown <broonie@kernel.org>,
        Patrice Chotard <patrice.chotard@foss.st.com>,
        Christophe Kerello <christophe.kerello@foss.st.com>,
        Daniel Palmer <daniel@0x0f.com>,
        Alexander Lobakin <alobakin@pm.me>,
        <linux-mtd@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        <linux-spi@vger.kernel.org>, <p.yadav@ti.com>
References: <20220101074250.14443-1-a-nandan@ti.com>
 <20220101074250.14443-6-a-nandan@ti.com>
 <20220103110107.45594e78@collabora.com>
From:   Apurva Nandan <a-nandan@ti.com>
In-Reply-To: <20220103110107.45594e78@collabora.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Boris,

On 03/01/22 15:31, Boris Brezillon wrote:
> On Sat, 1 Jan 2022 13:12:38 +0530
> Apurva Nandan <a-nandan@ti.com> wrote:
>
>> 'ctrl_ops' are op templates for non-page read/write operations,
>> which are: reset, get_feature, set_feature, write_enable, block_erase,
>> page_read and program_execute ops. The 'ctrl_ops' struct contains in it
>> op templates for each of this op, as well as enum spinand_protocol
>> denoting protocol of all these ops.
>>
>> We require these new op templates because of deviation in standard
>> SPINAND ops by manufacturers and also due to changes when there is a
>> change in SPI protocol/mode. This prevents the core from live-patching
>> and vendor-specific adjustments in ops.
>>
>> Define 'ctrl_ops', add macros to initialize it and add it in
>> spinand_device.
>>
>> Signed-off-by: Apurva Nandan <a-nandan@ti.com>
>> ---
>>   include/linux/mtd/spinand.h | 33 +++++++++++++++++++++++++++++++++
>>   1 file changed, 33 insertions(+)
>>
>> diff --git a/include/linux/mtd/spinand.h b/include/linux/mtd/spinand.h
>> index 439d8ce40e1d..e5df6220ec1e 100644
>> --- a/include/linux/mtd/spinand.h
>> +++ b/include/linux/mtd/spinand.h
>> @@ -356,6 +356,35 @@ struct spinand_op_variants {
>>   			sizeof(struct spi_mem_op),			\
>>   	}
>>   
>> +struct spinand_ctrl_ops {
>> +	const struct {
>> +		struct spi_mem_op reset;
>> +		struct spi_mem_op get_feature;
>> +		struct spi_mem_op set_feature;
>> +		struct spi_mem_op write_enable;
>> +		struct spi_mem_op block_erase;
>> +		struct spi_mem_op page_read;
>> +		struct spi_mem_op program_execute;
>> +	} ops;
>> +	const enum spinand_protocol protocol;
> Do you really need that protocol field?
>
>> +};
>> +
>> +#define SPINAND_CTRL_OPS(__protocol, __reset, __get_feature, __set_feature,	\
>> +			 __write_enable, __block_erase, __page_read,		\
>> +			 __program_execute)					\
>> +	{									\
>> +		.ops = {							\
>> +			.reset = __reset,					\
>> +			.get_feature = __get_feature,				\
>> +			.set_feature = __set_feature,				\
>> +			.write_enable = __write_enable,				\
>> +			.block_erase = __block_erase,				\
>> +			.page_read = __page_read,				\
>> +			.program_execute = __program_execute,			\
>> +		},								\
>> +		.protocol = __protocol,						\
>> +	}
>> +
>>   /**
>>    * spinand_ecc_info - description of the on-die ECC implemented by a SPI NAND
>>    *		      chip
>> @@ -468,6 +497,8 @@ struct spinand_dirmap {
>>    * @data_ops.read_cache: read cache op template
>>    * @data_ops.write_cache: write cache op template
>>    * @data_ops.update_cache: update cache op template
>> + * @ctrl_ops: various SPI mem op templates for handling the flash device, i.e.
>> + *	      non page-read/write ops.
>>    * @select_target: select a specific target/die. Usually called before sending
>>    *		   a command addressing a page or an eraseblock embedded in
>>    *		   this die. Only required if your chip exposes several dies
>> @@ -498,6 +529,8 @@ struct spinand_device {
>>   		const struct spi_mem_op *update_cache;
>>   	} data_ops;
>>   
>> +	const struct spinand_ctrl_ops *ctrl_ops;
>> +
> Okay, I had something slightly different in mind. First, I'd put all
> templates in a struct:
>
> struct spinand_op_templates {
> 	const struct spi_mem_op *read_cache;
> 	const struct spi_mem_op *write_cache;
> 	const struct spi_mem_op *update_cache;
> 	const struct spi_mem_op *reset;
> 	const struct spi_mem_op *get_feature;
> 	const struct spi_mem_op *set_feature;
> 	const struct spi_mem_op *write_enable;
> 	const struct spi_mem_op *block_erase;
> 	const struct spi_mem_op *page_load;
> 	const struct spi_mem_op *program_execute;
> };
>
> Then, at the spinand level, I'd define an array of templates:
>
> enum spinand_protocol {
> 	SPINAND_1S_1S_1S,
> 	SPINAND_2S_2S_2S,
> 	SPINAND_4S_4S_4S,
> 	SPINAND_8S_8S_8S,
> 	SPINAND_8D_8D_8D,
> 	SPINAND_NUM_PROTOCOLS,
> };
>
> struct spinand_device {
> 	...
> 	enum spinand_protocol protocol;
> 	const struct spinand_op_templates *op_templates[SPINAND_NUM_PROTOCOLS];
> 	...
> };
>
> This way, you can easily pick the right set of operations based
> on the protocol/mode you're in:
>
> #define spinand_get_op_template(spinand, opname) \
> 	((spinand)->op_templates[(spinand)->protocol]->opname)
>
> static int spinand_read_reg_op(struct spinand_device *spinand, u8 reg, u8 *val)
> {
> 	struct spi_mem_op op = *spinand_get_op_template(spinand, get_feature);
> 	int ret;
>
> 	...
> }

I find a couple of issues with this  method,

1. read_cache, write_cache, update_cache op templates don't fit well 
with the other non-data ops, as
these data ops are used to create a dirmap, and that can be done only 
once at probe time. Hence, there
is a different mechanism of selecting of data ops and non-data ops. 
Hence, this division in the op templates
struct as data_ops and ctrl_ops is required. Currently, the core only 
supports using a single protocol for
data ops, chosen at the time of probing.

2. If we use this single op_templates struct, I can't think of any good 
way to initialize these in the
manufacturers driver (winbond.c), refer to 17th patch in this series. 
Could you please suggest a macro
implementation also for winbond.c with the suggested op_templates struct.

Thanks,
Apurva Nandan

