Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7DC6357F08A
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Jul 2022 19:06:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236201AbiGWRG2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 23 Jul 2022 13:06:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59072 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230005AbiGWRG0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 23 Jul 2022 13:06:26 -0400
Received: from out28-1.mail.aliyun.com (out28-1.mail.aliyun.com [115.124.28.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D27A1AF2E;
        Sat, 23 Jul 2022 10:06:23 -0700 (PDT)
X-Alimail-AntiSpam: AC=CONTINUE;BC=0.07462738|-1;CH=green;DM=|CONTINUE|false|;DS=CONTINUE|ham_regular_dialog|0.0428046-0.00500691-0.952188;FP=0|0|0|0|0|-1|-1|-1;HT=ay29a033018047190;MF=zhouyanjie@wanyeetech.com;NM=1;PH=DS;RN=23;RT=23;SR=0;TI=SMTPD_---.Obm0Iun_1658595976;
Received: from 192.168.10.152(mailfrom:zhouyanjie@wanyeetech.com fp:SMTPD_---.Obm0Iun_1658595976)
          by smtp.aliyun-inc.com;
          Sun, 24 Jul 2022 01:06:18 +0800
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
From:   Zhou Yanjie <zhouyanjie@wanyeetech.com>
Message-ID: <89d22457-8c62-e441-3bf4-2734ec2a45e1@wanyeetech.com>
Date:   Sun, 24 Jul 2022 01:06:16 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <YtrukeLk9fInqQIL@sirena.org.uk>
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

On 2022/7/23 上午2:38, Mark Brown wrote:
> On Sat, Jul 23, 2022 at 12:48:30AM +0800, 周琰杰 (Zhou Yanjie) wrote:
>
> This looks mostly good, a few small issues though:
>
>> +++ b/drivers/spi/spi-ingenic-sfc.c
>> @@ -0,0 +1,662 @@
>> +// SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
>> +/*
>> + * Ingenic SoCs SPI Flash Controller Driver
> Please make the entire comment a C++ one so things look more
> intentional.


I'm sorry, I didn't understand well what you meant :(
Could you please explain a little more detail?


>
>> +static irqreturn_t ingenic_sfc_irq_handler(int irq, void *data)
>> +{
>> +	struct ingenic_sfc *sfc = data;
>> +
>> +	writel(0x1f, sfc->base + SFC_REG_INTC);
>> +
>> +	complete(&sfc->completion);
>> +
>> +	return IRQ_HANDLED;
>> +}
> This doesn't pay any attention to any status registers in the chip so
> won't work if the interrupt is shared and won't notice any error reports
> from the device...


This interrupt is exclusively owned by SFC, do we still
need to perform the operation you said? I haven't done
these operations before because I want to minimize the
overhead and avoid affecting performance.


>
>> +static int ingenic_sfc_setup(struct spi_device *spi)
>> +{
>> +	struct ingenic_sfc *sfc = spi_controller_get_devdata(spi->master);
>> +	unsigned long rate;
>> +	int ret, val;
>> +
>> +	if (!spi->max_speed_hz)
>> +		return -EINVAL;
>> +
>> +	ret = clk_set_rate(sfc->clk, spi->max_speed_hz * 2);
>> +	if (ret)
>> +		return -EINVAL;
> The setup() operation should be safe for use on one device while another
> device is active.  It's not going to be a problem until there's a
> version of the IP with more than one chip select, but that could happen
> some time (and someone might decide to make a board using GPIO chip
> selects...) but this should really go into the data path.


Sure, I will change it in the next version.


>> +	ret = clk_prepare_enable(sfc->clk);
>> +	if (ret)
>> +		goto err_put_master;
> Nothing ever disables this clock.  It might also be nice to enable the
> clock only when the controller is in use, that bit is not super
> important though.


Sure, will add it.


>
>> +	ret = devm_request_irq(&pdev->dev, sfc->irq, ingenic_sfc_irq_handler, 0,
>> +			dev_name(&pdev->dev), sfc);
>> +	if (ret) {
>> +		dev_err(&pdev->dev, "Failed to request irq%d, ret = %d\n", sfc->irq, ret);
>> +		goto err_put_master;
>> +	}
> It's not safe to use devm here...


Sure, will fix it in the next version.


>
>> +	ret = devm_spi_register_controller(&pdev->dev, ctlr);
>> +	if (ret)
>> +		goto err_put_master;
> ...unregistering the controller may free the driver data structure and
> the interrupt handler uses it so we could attempt to use freed data in
> the window between the controller being unregistered and the interrupt
> being freed.


Sure.


Thanks and best regards!


