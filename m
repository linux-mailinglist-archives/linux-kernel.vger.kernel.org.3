Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5CA0F50CA3E
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Apr 2022 14:55:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235586AbiDWM5c (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 23 Apr 2022 08:57:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39804 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234914AbiDWM51 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 23 Apr 2022 08:57:27 -0400
Received: from out28-196.mail.aliyun.com (out28-196.mail.aliyun.com [115.124.28.196])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 70860BD6;
        Sat, 23 Apr 2022 05:54:28 -0700 (PDT)
X-Alimail-AntiSpam: AC=CONTINUE;BC=0.0743748|-1;CH=green;DM=|CONTINUE|false|;DS=CONTINUE|ham_regular_dialog|0.0141704-0.000306015-0.985524;FP=0|0|0|0|0|-1|-1|-1;HT=ay29a033018047205;MF=zhouyanjie@wanyeetech.com;NM=1;PH=DS;RN=14;RT=14;SR=0;TI=SMTPD_---.NWKZXFE_1650718463;
Received: from 192.168.30.128(mailfrom:zhouyanjie@wanyeetech.com fp:SMTPD_---.NWKZXFE_1650718463)
          by smtp.aliyun-inc.com(33.32.24.3);
          Sat, 23 Apr 2022 20:54:24 +0800
Subject: Re: [PATCH v2 1/3] SPI: Ingenic: Add support for use GPIO as chip
 select line.
To:     Paul Cercueil <paul@crapouillou.net>
Cc:     broonie@kernel.org, robh+dt@kernel.org, krzk+dt@kernel.org,
        linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, contact@artur-rojek.eu,
        dongsheng.qiu@ingenic.com, aric.pzqi@ingenic.com,
        rick.tyliu@ingenic.com, sernia.zhou@foxmail.com,
        zhenwenjin@gmail.com, reimu@sudomaker.com
References: <1650654583-89933-1-git-send-email-zhouyanjie@wanyeetech.com>
 <1650654583-89933-2-git-send-email-zhouyanjie@wanyeetech.com>
 <PQ9RAR.93DKCD4H5Q7G1@crapouillou.net>
From:   Zhou Yanjie <zhouyanjie@wanyeetech.com>
Message-ID: <4645dd7a-08b4-e80e-2033-a55212c6f051@wanyeetech.com>
Date:   Sat, 23 Apr 2022 20:54:23 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <PQ9RAR.93DKCD4H5Q7G1@crapouillou.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-Spam-Status: No, score=-3.8 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Paul,

On 2022/4/23 上午3:20, Paul Cercueil wrote:
> Hi Zhou,
>
> Le sam., avril 23 2022 at 03:09:41 +0800, 周琰杰 (Zhou Yanjie) 
> <zhouyanjie@wanyeetech.com> a écrit :
>> Add support for using GPIOs as chip select lines on Ingenic SoCs.
>>
>> Signed-off-by: 周琰杰 (Zhou Yanjie) <zhouyanjie@wanyeetech.com>
>> ---
>>
>> Notes:
>>     v1->v2:
>>     Use "device_property_read_u32()" instead
>>     "of_property_read_u32()" as Paul Cercueil's suggestion.
>>
>>  drivers/spi/spi-ingenic.c | 11 +++++++++--
>>  1 file changed, 9 insertions(+), 2 deletions(-)
>>
>> diff --git a/drivers/spi/spi-ingenic.c b/drivers/spi/spi-ingenic.c
>> index 03077a7..bb512ca 100644
>> --- a/drivers/spi/spi-ingenic.c
>> +++ b/drivers/spi/spi-ingenic.c
>> @@ -380,7 +380,7 @@ static int spi_ingenic_probe(struct 
>> platform_device *pdev)
>>      struct spi_controller *ctlr;
>>      struct ingenic_spi *priv;
>>      void __iomem *base;
>> -    int ret;
>> +    int num_cs, ret;
>>
>>      pdata = of_device_get_match_data(dev);
>>      if (!pdata) {
>> @@ -416,6 +416,11 @@ static int spi_ingenic_probe(struct 
>> platform_device *pdev)
>>      if (IS_ERR(priv->flen_field))
>>          return PTR_ERR(priv->flen_field);
>>
>> +    if (device_property_read_u32(dev, "num-cs", &num_cs)) {
>> +        dev_warn(dev, "Number of chip select lines not specified.\n");
>> +        num_cs = 2;
>
> The "num-cs" property is not required in the binding, so I don't think 
> the dev_warn() is warranted. Just silently set num_cs = 2.
>

Sure.


> With this addressed:
> Reviewed-by: Paul Cercueil <paul@crapouillou.net>
>
> Cheers,
> -Paul
>
>> +    }
>> +
>>      platform_set_drvdata(pdev, ctlr);
>>
>>      ctlr->prepare_transfer_hardware = spi_ingenic_prepare_hardware;
>> @@ -429,7 +434,9 @@ static int spi_ingenic_probe(struct 
>> platform_device *pdev)
>>      ctlr->bits_per_word_mask = pdata->bits_per_word_mask;
>>      ctlr->min_speed_hz = 7200;
>>      ctlr->max_speed_hz = 54000000;
>> -    ctlr->num_chipselect = 2;
>> +    ctlr->use_gpio_descriptors = true;
>> +    ctlr->max_native_cs = 2;
>> +    ctlr->num_chipselect = num_cs;
>>      ctlr->dev.of_node = pdev->dev.of_node;
>>
>>      if (spi_ingenic_request_dma(ctlr, dev))
>> -- 
>> 2.7.4
>>
>
