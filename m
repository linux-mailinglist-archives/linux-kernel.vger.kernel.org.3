Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E6BC6522BCA
	for <lists+linux-kernel@lfdr.de>; Wed, 11 May 2022 07:36:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241751AbiEKFgc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 May 2022 01:36:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33472 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241383AbiEKFf5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 May 2022 01:35:57 -0400
Received: from nksmu.kylinos.cn (mailgw.kylinos.cn [123.150.8.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 60CC6120B7;
        Tue, 10 May 2022 22:35:51 -0700 (PDT)
X-UUID: c15df73932a042b48c13c870fdd5a331-20220511
X-UUID: c15df73932a042b48c13c870fdd5a331-20220511
Received: from cs2c.com.cn [(172.17.111.24)] by nksmu.kylinos.cn
        (envelope-from <jianghaoran@kylinos.cn>)
        (Generic MTA)
        with ESMTP id 1227716475; Wed, 11 May 2022 13:38:53 +0800
X-ns-mid: postfix-627B4B26-356447265
Received: from [172.30.60.211] (unknown [172.30.60.211])
        by cs2c.com.cn (NSMail) with ESMTPSA id 4ED52384867C;
        Wed, 11 May 2022 05:35:34 +0000 (UTC)
Subject: Re: [PATCH] irqchip/loongson-liointc: 4 cores correspond to different
 interrupt status registers
To:     Jiaxun Yang <jiaxun.yang@flygoat.com>, chenhuacai@kernel.org
Cc:     tglx@linutronix.de, maz@kernel.org, linux-mips@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20220510055303.1907165-1-jianghaoran@kylinos.cn>
 <21bb46ea-6a36-b426-2ca9-4471af5879a1@flygoat.com>
From:   jianghaoran <jianghaoran@kylinos.cn>
Message-ID: <833ade5f-ab35-1d69-28b1-b50ae41df2f5@kylinos.cn>
Date:   Wed, 11 May 2022 13:33:12 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <21bb46ea-6a36-b426-2ca9-4471af5879a1@flygoat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,KHOP_HELO_FCRDNS,
        NICE_REPLY_A,SPF_HELO_NONE,T_SCC_BODY_TEXT_LINE,T_SPF_PERMERROR,
        UNPARSEABLE_RELAY autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



在 2022/5/10 下午8:15, Jiaxun Yang 写道:
> 
> 
> 在 2022/5/10 6:53, Haoran Jiang 写道:
>> According to the loongson cpu manual,different cpu cores
>> correspond to different interrupt status registers
> NAK!
> 
> It is intentional to do so.
> 
> The per-core ISR register is broken on 3B1500. So we use general ISR 
> register here.
> The per-core variable is left for LS2K.
> 
> Thanks
> - Jiaxun
>>
>> Signed-off-by: Haoran Jiang <jianghaoran@kylinos.cn>
>> ---
>>   drivers/irqchip/irq-loongson-liointc.c | 2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/drivers/irqchip/irq-loongson-liointc.c 
>> b/drivers/irqchip/irq-loongson-liointc.c
>> index 649c58391618..f4e015b50af0 100644
>> --- a/drivers/irqchip/irq-loongson-liointc.c
>> +++ b/drivers/irqchip/irq-loongson-liointc.c
>> @@ -195,7 +195,7 @@ static int __init liointc_of_init(struct 
>> device_node *node,
>>           }
>>           for (i = 0; i < LIOINTC_NUM_CORES; i++)
>> -            priv->core_isr[i] = base + LIOINTC_REG_INTC_STATUS;
>> +            priv->core_isr[i] = base + LIOINTC_REG_INTC_STATUS + i*8;
>>       }
>>       for (i = 0; i < LIOINTC_NUM_PARENT; i++) {
> 

Thank you for your review!
