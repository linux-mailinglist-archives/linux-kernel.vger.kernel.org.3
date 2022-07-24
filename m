Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0D59457F274
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Jul 2022 03:22:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237049AbiGXBWP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 23 Jul 2022 21:22:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54042 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230417AbiGXBWN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 23 Jul 2022 21:22:13 -0400
Received: from out28-147.mail.aliyun.com (out28-147.mail.aliyun.com [115.124.28.147])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D95A217E25;
        Sat, 23 Jul 2022 18:22:10 -0700 (PDT)
X-Alimail-AntiSpam: AC=CONTINUE;BC=0.08158591|-1;CH=green;DM=|CONTINUE|false|;DS=CONTINUE|ham_alarm|0.0251032-0.00206122-0.972836;FP=0|0|0|0|0|-1|-1|-1;HT=ay29a033018047198;MF=zhouyanjie@wanyeetech.com;NM=1;PH=DS;RN=24;RT=24;SR=0;TI=SMTPD_---.Oc.Ojt._1658625725;
Received: from 192.168.10.152(mailfrom:zhouyanjie@wanyeetech.com fp:SMTPD_---.Oc.Ojt._1658625725)
          by smtp.aliyun-inc.com;
          Sun, 24 Jul 2022 09:22:07 +0800
Subject: Re: [PATCH 3/3] SPI: Ingenic: Add SFC support for Ingenic SoCs.
To:     Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        tudor.ambarus@microchip.com, p.yadav@ti.com, michael@walle.cc,
        miquel.raynal@bootlin.com, richard@nod.at, vigneshr@ti.com,
        broonie@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org
Cc:     linux-mtd@lists.infradead.org, linux-spi@vger.kernel.org,
        linux-mips@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, aidanmacdonald.0x0@gmail.com,
        tmn505@gmail.com, paul@crapouillou.net, dongsheng.qiu@ingenic.com,
        aric.pzqi@ingenic.com, rick.tyliu@ingenic.com,
        jinghui.liu@ingenic.com, sernia.zhou@foxmail.com,
        reimu@sudomaker.com
References: <1658508510-15400-1-git-send-email-zhouyanjie@wanyeetech.com>
 <1658508510-15400-4-git-send-email-zhouyanjie@wanyeetech.com>
 <c522ee04-4183-c2ff-8c35-ce2bbbc1bc95@wanadoo.fr>
From:   Zhou Yanjie <zhouyanjie@wanyeetech.com>
Message-ID: <9ca88fec-12c5-4fc8-80b7-9a94af3af89f@wanyeetech.com>
Date:   Sun, 24 Jul 2022 09:22:05 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <c522ee04-4183-c2ff-8c35-ce2bbbc1bc95@wanadoo.fr>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Christophe,

On 2022/7/23 下午11:15, Christophe JAILLET wrote:
> Le 22/07/2022 à 18:48, 周琰杰 (Zhou Yanjie) a écrit :
>> Add SFC support for the X1000 SoC, the X1600 SoC, and the X2000 SoC
>> from Ingenic.
>>
>> Signed-off-by: 周琰杰 (Zhou Yanjie) <zhouyanjie@wanyeetech.com>
>> ---
>>   drivers/spi/Kconfig           |   9 +
>>   drivers/spi/Makefile          |   1 +
>>   drivers/spi/spi-ingenic-sfc.c | 662 
>> ++++++++++++++++++++++++++++++++++++++++++
>>   3 files changed, 672 insertions(+)
>>   create mode 100644 drivers/spi/spi-ingenic-sfc.c
>>
>
> [...]
>
>> +static int ingenic_sfc_probe(struct platform_device *pdev)
>> +{
>> +    struct ingenic_sfc *sfc;
>> +    struct spi_controller *ctlr;
>> +    int ret;
>> +
>> +    ctlr = spi_alloc_master(&pdev->dev, sizeof(*sfc));
>> +    if (!ctlr)
>> +        return -ENOMEM;
>
> devm_spi_alloc_master()? (+ error handling simplification)
> Or there should be a .remove() function.
>

Sure, will do in the next version.


Thanks and best regards!


> CJ
>
>> +
>> +    sfc = spi_controller_get_devdata(ctlr);
>> +
>> +    sfc->soc_info = of_device_get_match_data(&pdev->dev);
>> +    if (!sfc->soc_info) {
>> +        dev_err(&pdev->dev, "No of match data provided\n");
>> +        ret = -ENODEV;
>> +        goto err_put_master;
>> +    }
>> +
>
> [...]
