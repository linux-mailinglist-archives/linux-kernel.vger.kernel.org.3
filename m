Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F2F105A530F
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Aug 2022 19:23:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231357AbiH2RXP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 Aug 2022 13:23:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44874 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229980AbiH2RXL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Aug 2022 13:23:11 -0400
Received: from smtp.smtpout.orange.fr (smtp04.smtpout.orange.fr [80.12.242.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A24E37EFFF
        for <linux-kernel@vger.kernel.org>; Mon, 29 Aug 2022 10:23:10 -0700 (PDT)
Received: from [192.168.1.18] ([90.11.190.129])
        by smtp.orange.fr with ESMTPA
        id SiTaoh2z4tk1aSiTaoL9lM; Mon, 29 Aug 2022 19:23:08 +0200
X-ME-Helo: [192.168.1.18]
X-ME-Auth: Y2hyaXN0b3BoZS5qYWlsbGV0QHdhbmFkb28uZnI=
X-ME-Date: Mon, 29 Aug 2022 19:23:08 +0200
X-ME-IP: 90.11.190.129
Message-ID: <444669a0-6328-0bc4-8073-9ec4baaf893e@wanadoo.fr>
Date:   Mon, 29 Aug 2022 19:23:06 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH 4/4] spi: mt7621: Remove 'clk' from 'struct mt7621_spi'
Content-Language: fr
To:     Matthias Brugger <matthias.bgg@gmail.com>, broonie@kernel.org,
        gregkh@linuxfoundation.org, neil@brown.name, blogic@openwrt.org
Cc:     linux-spi@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
        kernel-janitors@vger.kernel.org
References: <cover.1661599671.git.christophe.jaillet@wanadoo.fr>
 <76ed0ef91479498b9a2d5ef539f80851cffdb4ea.1661599671.git.christophe.jaillet@wanadoo.fr>
 <a8c87417-f37e-7c7a-a4a4-c5a01118e7a8@gmail.com>
From:   Christophe JAILLET <christophe.jaillet@wanadoo.fr>
In-Reply-To: <a8c87417-f37e-7c7a-a4a4-c5a01118e7a8@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Le 29/08/2022 à 13:18, Matthias Brugger a écrit :
> 
> 
> On 27/08/2022 13:42, Christophe JAILLET wrote:
>> The 'clk' field in 'struct mt7621_spi' is useless, remove it.
>>
>> Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
> 
> IMHO should be part of patch 2/4.

Ok, I'll send a v2 of the serie to merge patch 2 & 4.

CJ

> 
> Regards,
> Matthias
> 
>> ---
>>   drivers/spi/spi-mt7621.c | 4 +---
>>   1 file changed, 1 insertion(+), 3 deletions(-)
>>
>> diff --git a/drivers/spi/spi-mt7621.c b/drivers/spi/spi-mt7621.c
>> index 114f98dcae5e..c4cc8e2f85e2 100644
>> --- a/drivers/spi/spi-mt7621.c
>> +++ b/drivers/spi/spi-mt7621.c
>> @@ -55,7 +55,6 @@ struct mt7621_spi {
>>       void __iomem        *base;
>>       unsigned int        sys_freq;
>>       unsigned int        speed;
>> -    struct clk        *clk;
>>       int            pending_write;
>>   };
>> @@ -361,9 +360,8 @@ static int mt7621_spi_probe(struct platform_device 
>> *pdev)
>>       rs = spi_controller_get_devdata(master);
>>       rs->base = base;
>> -    rs->clk = clk;
>>       rs->master = master;
>> -    rs->sys_freq = clk_get_rate(rs->clk);
>> +    rs->sys_freq = clk_get_rate(clk);
>>       rs->pending_write = 0;
>>       dev_info(&pdev->dev, "sys_freq: %u\n", rs->sys_freq);

