Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 59F485981AB
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Aug 2022 12:53:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244176AbiHRKxY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 Aug 2022 06:53:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47126 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243923AbiHRKxU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Aug 2022 06:53:20 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DDBDE3AB03
        for <linux-kernel@vger.kernel.org>; Thu, 18 Aug 2022 03:53:18 -0700 (PDT)
Received: from [192.168.1.90] (unknown [82.79.170.245])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: cristicc)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 2FF936601C5E;
        Thu, 18 Aug 2022 11:53:17 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1660819997;
        bh=L8FuEj+uN11BKfoU7eBja+x1iwupqHjXP0z3vvUg4ck=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=Xu7I3+7ZQE0+EwjviYfmFE3ZO2nQQ5IliM8KVW7zaBvF9u1NKD/eUi5AK+TGyTZIx
         Q0xtZhFRzZzyaPedXt61ZrHHg42gVI1nIzTo9WkFpYP/erWV6j8osJiW4kPN0zwZzH
         TAZQ5hIyhwBXLDZwAG+epM3OVe/gRWXc/zNdaGoknc4T0W/Dce/N70wKbKxmqOmh/b
         s+vvmoyPeU7Kz+z5gOfx02m4BtKJQ8MhuI5UPArn27Hs/O96Z+s9lxBbML39keFh7U
         ttxPbMUkZDVyaNcRsyuJQ/srRYAvvcJBcUEPjreRWP9X7ryDBJYrLQONrunYMlcfPm
         7pAdO1RqenqqQ==
Message-ID: <c8c14e88-3aa3-f5bc-6083-70aaeedd9a1c@collabora.com>
Date:   Thu, 18 Aug 2022 13:53:14 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.12.0
Subject: Re: [PATCH] regmap: spi: Reserve space for register address/padding
Content-Language: en-US
To:     Lucas tanure <tanureal@opensource.cirrus.com>,
        Mark Brown <broonie@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        =?UTF-8?Q?Andr=c3=a9_Almeida?= <andrealmeid@igalia.com>,
        Charles Keepax <ckeepax@opensource.cirrus.com>
Cc:     linux-kernel@vger.kernel.org, kernel@collabora.com
References: <20220817213835.359037-1-cristian.ciocaltea@collabora.com>
 <d21568e5-854b-0a3e-f71d-947198aa61a5@opensource.cirrus.com>
From:   Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
In-Reply-To: <d21568e5-854b-0a3e-f71d-947198aa61a5@opensource.cirrus.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 8/18/22 12:22, Lucas tanure wrote:
> On 8/17/22 22:38, Cristian Ciocaltea wrote:
>> Currently the max_raw_read and max_raw_write limits in regmap_spi struct
>> do not take into account the additional size of the transmitted register
>> address and padding.  This may result in exceeding the maximum permitted
>> SPI transfer size, which could cause undefined behaviour, e.g. data
>> corruption.
>>
>> Fix regmap_get_spi_bus() to properly adjust the above mentioned limits
>> by reserving space for the register address/padding as set in the regmap
>> configuration.
>>
>> Fixes: f231ff38b7b2 ("regmap: spi: Set regmap max raw r/w from 
>> max_transfer_size")
>>
>> Signed-off-by: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
>> ---
>>   drivers/base/regmap/regmap-spi.c | 7 +++++++
>>   1 file changed, 7 insertions(+)
>>
>> diff --git a/drivers/base/regmap/regmap-spi.c 
>> b/drivers/base/regmap/regmap-spi.c
>> index 719323bc6c7f..6fb94c06a447 100644
>> --- a/drivers/base/regmap/regmap-spi.c
>> +++ b/drivers/base/regmap/regmap-spi.c
>> @@ -113,6 +113,7 @@ static const struct regmap_bus 
>> *regmap_get_spi_bus(struct spi_device *spi,
>>                              const struct regmap_config *config)
>>   {
>>       size_t max_size = spi_max_transfer_size(spi);
>> +    size_t max_msg_size, reg_reserve_size;
>>       struct regmap_bus *bus;
>>
>>       if (max_size != SIZE_MAX) {
>> @@ -120,9 +121,15 @@ static const struct regmap_bus 
>> *regmap_get_spi_bus(struct spi_device *spi,
>>           if (!bus)
>>               return ERR_PTR(-ENOMEM);
>>
>> +        max_msg_size = spi_max_message_size(spi);
>> +        reg_reserve_size = config->reg_bits / 8 + config->pad_bits / 8;
> I think you can use BITS_PER_BYTE here instead of 8.

Right, thanks for hint. Applied to v2:

https://lore.kernel.org/all/20220818104851.429479-1-cristian.ciocaltea@collabora.com/

>> +        if (max_size + reg_reserve_size > max_msg_size)
>> +            max_size -= reg_reserve_size;
>> +
>>           bus->free_on_exit = true;
>>           bus->max_raw_read = max_size;
>>           bus->max_raw_write = max_size;
>> +
>>           return bus;
>>       }
>>
>> base-commit: 568035b01cfb107af8d2e4bd2fb9aea22cf5b868
>> -- 
>> 2.37.2
> 
