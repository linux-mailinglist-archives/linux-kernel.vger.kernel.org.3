Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0A8314D819D
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Mar 2022 12:48:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239519AbiCNLtm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Mar 2022 07:49:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46294 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238089AbiCNLtl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Mar 2022 07:49:41 -0400
Received: from fllv0015.ext.ti.com (fllv0015.ext.ti.com [198.47.19.141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 631523ED2B;
        Mon, 14 Mar 2022 04:48:31 -0700 (PDT)
Received: from fllv0035.itg.ti.com ([10.64.41.0])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 22EBlGTZ124224;
        Mon, 14 Mar 2022 06:47:16 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1647258436;
        bh=A+p09ykpYT6VHc3fsURK5eWzEGL+2zDBzN5kHFSBz8c=;
        h=Date:Subject:To:CC:References:From:In-Reply-To;
        b=E1jemJllSfQqx5Izpc3mGcNV1DwGMELTSSOwpBuYCP43xPhZii6hINMNW1Hj81dOO
         rmJylF2qoYC4E2OkfUcK/wRQJReI4n4IyL8ReF+qVz+I0/0JGaOuFj/TkrC8x1dgCf
         ZB5zSHcvK4jMP0XJpmz/LBSoJYPpnByi1Yjz+3ks=
Received: from DLEE113.ent.ti.com (dlee113.ent.ti.com [157.170.170.24])
        by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 22EBlGeJ040925
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 14 Mar 2022 06:47:16 -0500
Received: from DLEE108.ent.ti.com (157.170.170.38) by DLEE113.ent.ti.com
 (157.170.170.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2308.14; Mon, 14
 Mar 2022 06:47:16 -0500
Received: from fllv0040.itg.ti.com (10.64.41.20) by DLEE108.ent.ti.com
 (157.170.170.38) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2308.14 via
 Frontend Transport; Mon, 14 Mar 2022 06:47:16 -0500
Received: from [10.250.235.173] (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0040.itg.ti.com (8.15.2/8.15.2) with ESMTP id 22EBlBgu022886;
        Mon, 14 Mar 2022 06:47:12 -0500
Message-ID: <1dfd6a3d-452a-1e71-ca26-1fffe6db1636@ti.com>
Date:   Mon, 14 Mar 2022 17:17:10 +0530
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
 <12c7a6a6-8b49-1c3e-087f-79c77388b091@ti.com>
 <20220310094053.1d86d13a@collabora.com>
From:   Apurva Nandan <a-nandan@ti.com>
In-Reply-To: <20220310094053.1d86d13a@collabora.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
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


On 10/03/22 14:10, Boris Brezillon wrote:
> On Thu, 10 Mar 2022 13:27:06 +0530
> Apurva Nandan <a-nandan@ti.com> wrote:
>
>>>>> This way, you can easily pick the right set of operations based
>>>>> on the protocol/mode you're in:
>>>>>
>>>>> #define spinand_get_op_template(spinand, opname) \
>>>>> 	((spinand)->op_templates[(spinand)->protocol]->opname)
>>>>>
>>>>> static int spinand_read_reg_op(struct spinand_device *spinand, u8 reg, u8 *val)
>>>>> {
>>>>> 	struct spi_mem_op op = *spinand_get_op_template(spinand, get_feature);
>>>>> 	int ret;
>>>>>
>>>>> 	...
>>>>> }
>>>> I find a couple of issues with this  method,
>>>>
>>>> 1. read_cache, write_cache, update_cache op templates don't fit well
>>>> with the other non-data ops, as
>>>> these data ops are used to create a dirmap, and that can be done only
>>>> once at probe time. Hence, there
>>>> is a different mechanism of selecting of data ops and non-data ops.
>>> Not sure I see why this is a problem. You can populate data-ops for all
>>> modes, and pick the one that provides the best perfs when you create
>>> the dirmap (which should really be at the end of the probe, if it's not
>>> already).
>>>   
>>>> Hence, this division in the op templates
>>>> struct as data_ops and ctrl_ops is required. Currently, the core only
>>>> supports using a single protocol for
>>>> data ops, chosen at the time of probing.
>>> Again, I don't see why you need to differentiate the control and data
>>> ops when populating this table. Those are just operations the NAND
>>> supports, and the data operations is just a subset.
>>>   
>>>> 2. If we use this single op_templates struct, I can't think of any good
>>>> way to initialize these in the
>>>> manufacturers driver (winbond.c), refer to 17th patch in this series.
>>>> Could you please suggest a macro
>>>> implementation also for winbond.c with the suggested op_templates struct.
>>> First replace the op_variants field by something more generic:
>>>
>>> struct spinand_info {
>>> ...
>>> 	const struct spinand_op_variants **ops_variants;
>>> ...
>>> };
>>>
>>> #define SPINAND_OP_VARIANTS(_id, ...) \
>>> 	[SPI_NAND_OP_ ## _id] = { __VA_ARGS__ }
>>>
>>> #define SPINAND_OPS_VARIANTS(name, ...)
>>> 	const struct spinand_op_variants name[]{
>>> 		__VA_ARGS__,
>>> 	};
>>>
>>> #define SPINAND_INFO_OPS_VARIANTS(defs)
>>> 	.ops_variants = defs
>> If we modify these macros, it would require other spinand vendor drivers
>> to change (toshiba, micron, etc).
>> The older macros suit them well, should we go about changing them to
>> this new macro (will require re-testing all of them),
>> or can we keep them unchanged and have new set of macros with different
>> name (please give suggestion for it) for op variants.
> I'd rather have everything converted to the new approach (we don't want
> 2 ways of describing the same thing), and I'm not sure you can make the
> old macros map to the new solution, so I fear you'll have to patch all
> vendors. This being said, I'm fine providing simple wrappers if that
> helps, but I don't see how they'd make the description simpler/more
> compact to be honest.
Okay, I will convert all of the vendor drivers, but please note I don't 
have any way to test the changes on all the flashes.
