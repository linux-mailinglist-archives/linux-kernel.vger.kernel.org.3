Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B7C09535804
	for <lists+linux-kernel@lfdr.de>; Fri, 27 May 2022 05:18:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238155AbiE0DSL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 May 2022 23:18:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40666 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232437AbiE0DSJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 May 2022 23:18:09 -0400
Received: from mail-sz.amlogic.com (mail-sz.amlogic.com [211.162.65.117])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C8A1899693
        for <linux-kernel@vger.kernel.org>; Thu, 26 May 2022 20:18:07 -0700 (PDT)
Received: from [10.28.39.121] (10.28.39.121) by mail-sz.amlogic.com
 (10.28.11.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2176.2; Fri, 27 May
 2022 11:18:05 +0800
Message-ID: <0fc9fc39-a4e2-85fc-ba46-5ab825e6fcbf@amlogic.com>
Date:   Fri, 27 May 2022 11:18:04 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 6.1; rv:91.0) Gecko/20100101
 Thunderbird/91.9.0
Subject: Re: [PATCH v5 3/4] mtd: rawnand: meson: refine resource getting in
 probe
Content-Language: en-US
To:     Kevin Hilman <khilman@baylibre.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        <linux-mtd@lists.infradead.org>
CC:     Rob Herring <robh+dt@kernel.org>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        Jianxin Pan <jianxin.pan@amlogic.com>,
        Victor Wan <victor.wan@amlogic.com>,
        XianWei Zhao <xianwei.zhao@amlogic.com>,
        Kelvin Zhang <kelvin.zhang@amlogic.com>,
        BiChao Zheng <bichao.zheng@amlogic.com>,
        YongHui Yu <yonghui.yu@amlogic.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-amlogic@lists.infradead.org>, <linux-kernel@vger.kernel.org>
References: <20220513123404.48513-1-liang.yang@amlogic.com>
 <20220513123404.48513-4-liang.yang@amlogic.com> <7hzgj48dj4.fsf@baylibre.com>
From:   Liang Yang <liang.yang@amlogic.com>
In-Reply-To: <7hzgj48dj4.fsf@baylibre.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.28.39.121]
X-ClientProxiedBy: mail-sz.amlogic.com (10.28.11.5) To mail-sz.amlogic.com
 (10.28.11.5)
X-Spam-Status: No, score=-3.9 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Kevin,

On 2022/5/27 0:27, Kevin Hilman wrote:
> [ EXTERNAL EMAIL ]
> 
> Liang Yang <liang.yang@amlogic.com> writes:
> 
>> Signed-off-by: Liang Yang <liang.yang@amlogic.com>
> 
> Patch should have a changelog.ok, i will add it.
> 
> Reviewed-by: Kevin Hilman <khilman@baylibre.com>
> 
>> ---
>>   drivers/mtd/nand/raw/meson_nand.c | 4 +---
>>   1 file changed, 1 insertion(+), 3 deletions(-)
>>
>> diff --git a/drivers/mtd/nand/raw/meson_nand.c b/drivers/mtd/nand/raw/meson_nand.c
>> index cc93667a1e7f..6e50387475bb 100644
>> --- a/drivers/mtd/nand/raw/meson_nand.c
>> +++ b/drivers/mtd/nand/raw/meson_nand.c
>> @@ -1378,7 +1378,6 @@ static int meson_nfc_probe(struct platform_device *pdev)
>>   {
>>   	struct device *dev = &pdev->dev;
>>   	struct meson_nfc *nfc;
>> -	struct resource *res;
>>   	int ret, irq;
>>   
>>   	nfc = devm_kzalloc(dev, sizeof(*nfc), GFP_KERNEL);
>> @@ -1395,8 +1394,7 @@ static int meson_nfc_probe(struct platform_device *pdev)
>>   
>>   	nfc->dev = dev;
>>   
>> -	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
>> -	nfc->reg_base = devm_ioremap_resource(dev, res);
>> +	nfc->reg_base = devm_platform_ioremap_resource_byname(pdev, "nfc");
>>   	if (IS_ERR(nfc->reg_base))
>>   		return PTR_ERR(nfc->reg_base);
>>   
>> -- 
>> 2.34.1
>>
>>
>> _______________________________________________
>> linux-amlogic mailing list
>> linux-amlogic@lists.infradead.org
>> http://lists.infradead.org/mailman/listinfo/linux-amlogic
> 
> .
