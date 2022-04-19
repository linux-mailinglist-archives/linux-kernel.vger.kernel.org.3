Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 556B9507680
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Apr 2022 19:30:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355714AbiDSRct (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Apr 2022 13:32:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34862 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344485AbiDSRcp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Apr 2022 13:32:45 -0400
Received: from out28-193.mail.aliyun.com (out28-193.mail.aliyun.com [115.124.28.193])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 26C60633E;
        Tue, 19 Apr 2022 10:29:59 -0700 (PDT)
X-Alimail-AntiSpam: AC=CONTINUE;BC=0.07437557|-1;CH=green;DM=|CONTINUE|false|;DS=CONTINUE|ham_regular_dialog|0.0103164-0.000447057-0.989237;FP=0|0|0|0|0|-1|-1|-1;HT=ay29a033018047212;MF=zhouyanjie@wanyeetech.com;NM=1;PH=DS;RN=15;RT=15;SR=0;TI=SMTPD_---.NTtx3yP_1650389394;
Received: from 192.168.30.128(mailfrom:zhouyanjie@wanyeetech.com fp:SMTPD_---.NTtx3yP_1650389394)
          by smtp.aliyun-inc.com(33.32.41.12);
          Wed, 20 Apr 2022 01:29:56 +0800
Subject: Re: [PATCH 1/3] SPI: Ingenic: Add support for use GPIO as chip select
 line.
To:     Paul Cercueil <paul@crapouillou.net>
Cc:     broonie@kernel.org, robh+dt@kernel.org, krzk+dt@kernel.org,
        linux-spi@vger.kernel.org, linux-mips@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        contact@artur-rojek.eu, dongsheng.qiu@ingenic.com,
        aric.pzqi@ingenic.com, rick.tyliu@ingenic.com,
        sernia.zhou@foxmail.com, zhenwenjin@gmail.com, reimu@sudomaker.com
References: <1650032528-118220-1-git-send-email-zhouyanjie@wanyeetech.com>
 <1650032528-118220-2-git-send-email-zhouyanjie@wanyeetech.com>
 <IUJLAR.XMD0PY9XJ5X41@crapouillou.net>
From:   Zhou Yanjie <zhouyanjie@wanyeetech.com>
Message-ID: <797abbbe-2bef-001f-9b4c-5d8e607b2f1c@wanyeetech.com>
Date:   Wed, 20 Apr 2022 01:29:54 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <IUJLAR.XMD0PY9XJ5X41@crapouillou.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-Spam-Status: No, score=-5.2 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Paul,

On 2022/4/20 上午1:13, Paul Cercueil wrote:
> Hi Zhou,
>
> Le ven., avril 15 2022 at 22:22:06 +0800, 周琰杰 (Zhou Yanjie) 
> <zhouyanjie@wanyeetech.com> a écrit :
>> Add support for using GPIOs as chip select lines on Ingenic SoCs.
>>
>> Signed-off-by: 周琰杰 (Zhou Yanjie) <zhouyanjie@wanyeetech.com>
>> ---
>>  drivers/spi/spi-ingenic.c | 11 +++++++++--
>>  1 file changed, 9 insertions(+), 2 deletions(-)
>>
>> diff --git a/drivers/spi/spi-ingenic.c b/drivers/spi/spi-ingenic.c
>> index 03077a7..672e4ed 100644
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
>> +    if (of_property_read_u32(dev->of_node, "num-cs", &num_cs)) {
>
> One small comment here - I think it would be better to use 
> device_property_read_u32().
>
> The driver should also use device_get_match_data() instead of 
> of_device_get_match_data(), but that's a cleanup that can be done later.
>

Sure, I will send v2.


Thanks and best regards!


> Cheers,
> -Paul
>
>> +        dev_warn(dev, "Number of chip select lines not specified.\n");
>> +        num_cs = 2;
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
