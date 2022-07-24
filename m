Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A599757F27A
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Jul 2022 03:24:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239268AbiGXBYx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 23 Jul 2022 21:24:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55272 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239077AbiGXBYv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 23 Jul 2022 21:24:51 -0400
Received: from out28-51.mail.aliyun.com (out28-51.mail.aliyun.com [115.124.28.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D88B3186D0;
        Sat, 23 Jul 2022 18:24:49 -0700 (PDT)
X-Alimail-AntiSpam: AC=CONTINUE;BC=0.09999388|-1;CH=green;DM=|CONTINUE|false|;DS=CONTINUE|ham_regular_dialog|0.0805319-0.0018128-0.917655;FP=0|0|0|0|0|-1|-1|-1;HT=ay29a033018047194;MF=zhouyanjie@wanyeetech.com;NM=1;PH=DS;RN=23;RT=23;SR=0;TI=SMTPD_---.Oc.heif_1658625883;
Received: from 192.168.10.152(mailfrom:zhouyanjie@wanyeetech.com fp:SMTPD_---.Oc.heif_1658625883)
          by smtp.aliyun-inc.com;
          Sun, 24 Jul 2022 09:24:45 +0800
Subject: Re: [PATCH 3/3] SPI: Ingenic: Add SFC support for Ingenic SoCs.
To:     Mark Brown <broonie@kernel.org>
Cc:     tudor.ambarus@microchip.com, p.yadav@ti.com, michael@walle.cc,
        miquel.raynal@bootlin.com, richard@nod.at, vigneshr@ti.com,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        linux-mtd@lists.infradead.org, linux-spi@vger.kernel.org,
        linux-mips@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, aidanmacdonald.0x0@gmail.com,
        tmn505@gmail.com, paul@crapouillou.net, dongsheng.qiu@ingenic.com,
        aric.pzqi@ingenic.com, rick.tyliu@ingenic.com,
        jinghui.liu@ingenic.com, sernia.zhou@foxmail.com,
        reimu@sudomaker.com
References: <1658508510-15400-1-git-send-email-zhouyanjie@wanyeetech.com>
 <1658508510-15400-4-git-send-email-zhouyanjie@wanyeetech.com>
 <YtrukeLk9fInqQIL@sirena.org.uk>
 <89d22457-8c62-e441-3bf4-2734ec2a45e1@wanyeetech.com>
 <YtxMwyRghFKS/vu5@sirena.org.uk>
From:   Zhou Yanjie <zhouyanjie@wanyeetech.com>
Message-ID: <1404dd8d-475e-b3b6-a3da-4eeddca3070b@wanyeetech.com>
Date:   Sun, 24 Jul 2022 09:24:43 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <YtxMwyRghFKS/vu5@sirena.org.uk>
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

Hi Mark,

On 2022/7/24 上午3:32, Mark Brown wrote:
> On Sun, Jul 24, 2022 at 01:06:16AM +0800, Zhou Yanjie wrote:
>> On 2022/7/23 上午2:38, Mark Brown wrote:
>>>> +++ b/drivers/spi/spi-ingenic-sfc.c
>>>> @@ -0,0 +1,662 @@
>>>> +// SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
>>>> +/*
>>>> + * Ingenic SoCs SPI Flash Controller Driver
>>> Please make the entire comment a C++ one so things look more
>>> intentional.
>> I'm sorry, I didn't understand well what you meant :(
>> Could you please explain a little more detail?
> The above comment block uses both C /* */ and C++ // style comments,
> please make it just use the C++ style.


Sure, will do in the next version.


>>>> +static irqreturn_t ingenic_sfc_irq_handler(int irq, void *data)
>>>> +{
>>>> +	struct ingenic_sfc *sfc = data;
>>>> +
>>>> +	writel(0x1f, sfc->base + SFC_REG_INTC);
>>>> +
>>>> +	complete(&sfc->completion);
>>>> +
>>>> +	return IRQ_HANDLED;
>>>> +}
>>> This doesn't pay any attention to any status registers in the chip so
>>> won't work if the interrupt is shared and won't notice any error reports
>>> from the device...
>> This interrupt is exclusively owned by SFC, do we still
>> need to perform the operation you said? I haven't done
>> these operations before because I want to minimize the
>> overhead and avoid affecting performance.
> Even if the device is not shared is there no possibility that the
> device can report an unexpected interrupt status?  It's not just
> the sharing case, it's also the fact that it looks like there's a
> status being reported but we're not checking it so if anything
> goes wrong then we're less likely to notice.  I'd worry about
> data corruption.


Sure, I will change this in the next version.


Thanks and best regards!


