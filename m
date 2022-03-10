Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 73AB74D4216
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Mar 2022 08:58:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240150AbiCJH6z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Mar 2022 02:58:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37690 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231814AbiCJH6x (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Mar 2022 02:58:53 -0500
Received: from lelv0142.ext.ti.com (lelv0142.ext.ti.com [198.47.23.249])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E99B060078;
        Wed,  9 Mar 2022 23:57:50 -0800 (PST)
Received: from lelv0266.itg.ti.com ([10.180.67.225])
        by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 22A7vEBQ005739;
        Thu, 10 Mar 2022 01:57:14 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1646899034;
        bh=BrTgXQ4YJOICIAG05mVu7WDFSnxZku3w7EKnMSxmmeM=;
        h=Date:Subject:To:CC:References:From:In-Reply-To;
        b=Zbc9j+aHUzXqQHtZuRG2qxTs7iaTSv4g387t5ScUFEprJNEvX0aty1aZWmkPARpGE
         1O1y/j3188L/k97rYbSgFXtTSRowcdkj4L+0uS5T1sz0jWoPu521m+vI6zeNTXCpDS
         HVpm3qSkorbhW7qYue+A8/aghzo/eRsDVRciXzA8=
Received: from DLEE107.ent.ti.com (dlee107.ent.ti.com [157.170.170.37])
        by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 22A7vEa5034992
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 10 Mar 2022 01:57:14 -0600
Received: from DLEE111.ent.ti.com (157.170.170.22) by DLEE107.ent.ti.com
 (157.170.170.37) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2308.14; Thu, 10
 Mar 2022 01:57:13 -0600
Received: from lelv0326.itg.ti.com (10.180.67.84) by DLEE111.ent.ti.com
 (157.170.170.22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2308.14 via
 Frontend Transport; Thu, 10 Mar 2022 01:57:13 -0600
Received: from [10.250.235.173] (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0326.itg.ti.com (8.15.2/8.15.2) with ESMTP id 22A7v7L1020714;
        Thu, 10 Mar 2022 01:57:08 -0600
Message-ID: <12c7a6a6-8b49-1c3e-087f-79c77388b091@ti.com>
Date:   Thu, 10 Mar 2022 13:27:06 +0530
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
 <bf3ea909-e0a5-eeac-12e9-c8a809685f48@ti.com>
 <20220215183705.574df0c1@collabora.com>
From:   Apurva Nandan <a-nandan@ti.com>
In-Reply-To: <20220215183705.574df0c1@collabora.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Spam-Status: No, score=-3.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Boris,

On 15/02/22 23:07, Boris Brezillon wrote:
> Hi Apurva,
>
> On Tue, 15 Feb 2022 21:03:52 +0530
> Apurva Nandan <a-nandan@ti.com> wrote:
>
>> Hi Boris,
>>
>> On 03/01/22 15:31, Boris Brezillon wrote:
>>> On Sat, 1 Jan 2022 13:12:38 +0530
>>> Apurva Nandan <a-nandan@ti.com> wrote:
>>>   
>>>> 'ctrl_ops' are op templates for non-page read/write operations,
>>>> which are: reset, get_feature, set_feature, write_enable, block_erase,
>>>> page_read and program_execute ops. The 'ctrl_ops' struct contains in it
>>>> op templates for each of this op, as well as enum spinand_protocol
>>>> denoting protocol of all these ops.
>>>>
>>>> We require these new op templates because of deviation in standard
>>>> SPINAND ops by manufacturers and also due to changes when there is a
>>>> change in SPI protocol/mode. This prevents the core from live-patching
>>>> and vendor-specific adjustments in ops.
>>>>
>>>> Define 'ctrl_ops', add macros to initialize it and add it in
>>>> spinand_device.
>>>>
>>>> Signed-off-by: Apurva Nandan <a-nandan@ti.com>
>>>> ---
>>>>    include/linux/mtd/spinand.h | 33 +++++++++++++++++++++++++++++++++
>>>>    1 file changed, 33 insertions(+)
>>>>
>>>> diff --git a/include/linux/mtd/spinand.h b/include/linux/mtd/spinand.h
>>>> index 439d8ce40e1d..e5df6220ec1e 100644
>>>> --- a/include/linux/mtd/spinand.h
>>>> +++ b/include/linux/mtd/spinand.h
>>>> @@ -356,6 +356,35 @@ struct spinand_op_variants {
>>>>    			sizeof(struct spi_mem_op),			\
>>>>    	}
>>>>    
>>>> +struct spinand_ctrl_ops {
>>>> +	const struct {
>>>> +		struct spi_mem_op reset;
>>>> +		struct spi_mem_op get_feature;
>>>> +		struct spi_mem_op set_feature;
>>>> +		struct spi_mem_op write_enable;
>>>> +		struct spi_mem_op block_erase;
>>>> +		struct spi_mem_op page_read;
>>>> +		struct spi_mem_op program_execute;
>>>> +	} ops;
>>>> +	const enum spinand_protocol protocol;
>>> Do you really need that protocol field?
>>>   
>>>> +};
>>>> +
>>>> +#define SPINAND_CTRL_OPS(__protocol, __reset, __get_feature, __set_feature,	\
>>>> +			 __write_enable, __block_erase, __page_read,		\
>>>> +			 __program_execute)					\
>>>> +	{									\
>>>> +		.ops = {							\
>>>> +			.reset = __reset,					\
>>>> +			.get_feature = __get_feature,				\
>>>> +			.set_feature = __set_feature,				\
>>>> +			.write_enable = __write_enable,				\
>>>> +			.block_erase = __block_erase,				\
>>>> +			.page_read = __page_read,				\
>>>> +			.program_execute = __program_execute,			\
>>>> +		},								\
>>>> +		.protocol = __protocol,						\
>>>> +	}
>>>> +
>>>>    /**
>>>>     * spinand_ecc_info - description of the on-die ECC implemented by a SPI NAND
>>>>     *		      chip
>>>> @@ -468,6 +497,8 @@ struct spinand_dirmap {
>>>>     * @data_ops.read_cache: read cache op template
>>>>     * @data_ops.write_cache: write cache op template
>>>>     * @data_ops.update_cache: update cache op template
>>>> + * @ctrl_ops: various SPI mem op templates for handling the flash device, i.e.
>>>> + *	      non page-read/write ops.
>>>>     * @select_target: select a specific target/die. Usually called before sending
>>>>     *		   a command addressing a page or an eraseblock embedded in
>>>>     *		   this die. Only required if your chip exposes several dies
>>>> @@ -498,6 +529,8 @@ struct spinand_device {
>>>>    		const struct spi_mem_op *update_cache;
>>>>    	} data_ops;
>>>>    
>>>> +	const struct spinand_ctrl_ops *ctrl_ops;
>>>> +
>>> Okay, I had something slightly different in mind. First, I'd put all
>>> templates in a struct:
>>>
>>> struct spinand_op_templates {
>>> 	const struct spi_mem_op *read_cache;
>>> 	const struct spi_mem_op *write_cache;
>>> 	const struct spi_mem_op *update_cache;
>>> 	const struct spi_mem_op *reset;
>>> 	const struct spi_mem_op *get_feature;
>>> 	const struct spi_mem_op *set_feature;
>>> 	const struct spi_mem_op *write_enable;
>>> 	const struct spi_mem_op *block_erase;
>>> 	const struct spi_mem_op *page_load;
>>> 	const struct spi_mem_op *program_execute;
>>> };
>>>
>>> Then, at the spinand level, I'd define an array of templates:
>>>
>>> enum spinand_protocol {
>>> 	SPINAND_1S_1S_1S,
>>> 	SPINAND_2S_2S_2S,
>>> 	SPINAND_4S_4S_4S,
>>> 	SPINAND_8S_8S_8S,
>>> 	SPINAND_8D_8D_8D,
>>> 	SPINAND_NUM_PROTOCOLS,
>>> };
>>>
>>> struct spinand_device {
>>> 	...
>>> 	enum spinand_protocol protocol;
>>> 	const struct spinand_op_templates *op_templates[SPINAND_NUM_PROTOCOLS];
> It should probably be
>
> 	struct spinand_op_templates op_templates[SPINAND_NUM_PROTOCOLS];
>
> with the spinand_op_templates struct defined as:
>
> struct spinand_op_templates {
>   	struct spi_mem_op read_cache;
>   	struct spi_mem_op write_cache;
>   	struct spi_mem_op update_cache;
>   	struct spi_mem_op reset;
>   	struct spi_mem_op get_feature;
>   	struct spi_mem_op set_feature;
>   	struct spi_mem_op write_enable;
>   	struct spi_mem_op block_erase;
>   	struct spi_mem_op page_load;
>   	struct spi_mem_op program_execute;
> };
>
> so the NAND framework can populate these ops.
>
> Or maybe even better, define an enum that contains all the ops:
>
> enum spinand_op_id {
> 	SPI_NAND_OP_READ_CACHE,
> 	SPI_NAND_OP_WRITE_CACHE,
> 	SPI_NAND_OP_UPDATE_CACHE,
> 	SPI_NAND_OP_RESET,
> ...
> 	SPI_NAND_NUM_OPS,
> };
>
> struct spinand_device {
> 	...
>   	enum spinand_protocol protocol;
>   	struct spi_mem_op op_templates[SPINAND_NUM_PROTOCOLS][SPI_NAND_NUM_OPS];
> 	...
> };
>
>>> This way, you can easily pick the right set of operations based
>>> on the protocol/mode you're in:
>>>
>>> #define spinand_get_op_template(spinand, opname) \
>>> 	((spinand)->op_templates[(spinand)->protocol]->opname)
>>>
>>> static int spinand_read_reg_op(struct spinand_device *spinand, u8 reg, u8 *val)
>>> {
>>> 	struct spi_mem_op op = *spinand_get_op_template(spinand, get_feature);
>>> 	int ret;
>>>
>>> 	...
>>> }
>> I find a couple of issues with this  method,
>>
>> 1. read_cache, write_cache, update_cache op templates don't fit well
>> with the other non-data ops, as
>> these data ops are used to create a dirmap, and that can be done only
>> once at probe time. Hence, there
>> is a different mechanism of selecting of data ops and non-data ops.
> Not sure I see why this is a problem. You can populate data-ops for all
> modes, and pick the one that provides the best perfs when you create
> the dirmap (which should really be at the end of the probe, if it's not
> already).
>
>> Hence, this division in the op templates
>> struct as data_ops and ctrl_ops is required. Currently, the core only
>> supports using a single protocol for
>> data ops, chosen at the time of probing.
> Again, I don't see why you need to differentiate the control and data
> ops when populating this table. Those are just operations the NAND
> supports, and the data operations is just a subset.
>
>> 2. If we use this single op_templates struct, I can't think of any good
>> way to initialize these in the
>> manufacturers driver (winbond.c), refer to 17th patch in this series.
>> Could you please suggest a macro
>> implementation also for winbond.c with the suggested op_templates struct.
> First replace the op_variants field by something more generic:
>
> struct spinand_info {
> ...
> 	const struct spinand_op_variants **ops_variants;
> ...
> };
>
> #define SPINAND_OP_VARIANTS(_id, ...) \
> 	[SPI_NAND_OP_ ## _id] = { __VA_ARGS__ }
>
> #define SPINAND_OPS_VARIANTS(name, ...)
> 	const struct spinand_op_variants name[]{
> 		__VA_ARGS__,
> 	};
>
> #define SPINAND_INFO_OPS_VARIANTS(defs)
> 	.ops_variants = defs

If we modify these macros, it would require other spinand vendor drivers 
to change (toshiba, micron, etc).
The older macros suit them well, should we go about changing them to 
this new macro (will require re-testing all of them),
or can we keep them unchanged and have new set of macros with different 
name (please give suggestion for it) for op variants.

>
> ...
>
> static SPINAND_OPS_VARIANTS(w35n01jw_ops_variants,
> 		SPINAND_OP_VARIANTS(READ_CACHE,
> 			SPINAND_PAGE_READ_FROM_CACHE_OCTALIO_DTR_OP(0, 24, NULL, 0),
> 			SPINAND_PAGE_READ_FROM_CACHE_OP(true, 0, 1, NULL, 0),
> 			...)),
> 		SPINAND_OP_VARIANTS(WRITE_CACHE,
> 			SPINAND_PROG_LOAD_OCTALIO_DTR(true, 0, NULL, 0),
> 			SPINAND_PROG_LOAD(true, 0, NULL, 0)),
> 		...
> 		SPINAND_OP_VARIANTS(RESET,
> 			SPINAND_RESET_OP_OCTAL_DTR,
> 			SPINAND_RESET_OP,
> 		...
> 		);
> ...
>
>
> 	SPINAND_INFO("W35N01JW",
> 		     SPINAND_ID(SPINAND_READID_METHOD_OPCODE_DUMMY, 0xdc),
> 		     NAND_MEMORG(1, 4096, 128, 64, 512, 20, 1, 1, 1),
> 		     NAND_ECCREQ(1, 512),
> 		     SPINAND_HAS_OCTAL_DTR_BIT | SPINAND_HAS_CR_FEAT_BIT,
> 		     SPINAND_ECCINFO(&w35n01jw_ooblayout, NULL),
> 		     SPINAND_INFO_OPS_VARIANTS(&w35n01jw_ops_variants)),
>
> You also need to adjust spinand_match_and_init() to account for this
> new layout and put each template op in the right subset based on
> op.cmd.width and op.cmd.dtr.
>
> Regards,
>
> Boris
