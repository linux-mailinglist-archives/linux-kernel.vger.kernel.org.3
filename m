Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B7B804B0A70
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Feb 2022 11:18:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239509AbiBJKSu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Feb 2022 05:18:50 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:38666 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237520AbiBJKSt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Feb 2022 05:18:49 -0500
Received: from out28-125.mail.aliyun.com (out28-125.mail.aliyun.com [115.124.28.125])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 50BC11C2;
        Thu, 10 Feb 2022 02:18:49 -0800 (PST)
X-Alimail-AntiSpam: AC=CONTINUE;BC=0.1530151|-1;CH=green;DM=|CONTINUE|false|;DS=CONTINUE|ham_regular_dialog|0.00618255-0.00198199-0.991836;FP=0|0|0|0|0|-1|-1|-1;HT=ay29a033018047212;MF=zhouyanjie@wanyeetech.com;NM=1;PH=DS;RN=6;RT=6;SR=0;TI=SMTPD_---.MnxRg3g_1644488326;
Received: from 192.168.88.129(mailfrom:zhouyanjie@wanyeetech.com fp:SMTPD_---.MnxRg3g_1644488326)
          by smtp.aliyun-inc.com(10.147.44.145);
          Thu, 10 Feb 2022 18:18:46 +0800
Subject: Re: [PATCH] pinctrl: ingenic: Fix regmap on X series SoCs
To:     Aidan MacDonald <aidanmacdonald.0x0@gmail.com>,
        paul@crapouillou.net, linus.walleij@linaro.org
Cc:     linux-mips@vger.kernel.org, linux-gpio@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20220209230452.19535-1-aidanmacdonald.0x0@gmail.com>
From:   Zhou Yanjie <zhouyanjie@wanyeetech.com>
Message-ID: <ad12e876-e3d2-dc6e-e89e-819686fe9eff@wanyeetech.com>
Date:   Thu, 10 Feb 2022 18:18:45 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20220209230452.19535-1-aidanmacdonald.0x0@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Aidan,

On 2022/2/10 上午7:04, Aidan MacDonald wrote:
> The X series Ingenic SoCs have a shadow GPIO group which
> is at a higher offset than the other groups, and is used
> for all GPIO configuration. The regmap did not take this
> offset into account and set max_register too low. Writes
> to the shadow group registers were blocked, which made it
> impossible to change any pin configuration.
>
> Fix this by pretending there are at least 8 chips on any
> 'X' SoC for the purposes of calculating max_register. This
> ensures the shadow group is accessible.
>
> Signed-off-by: Aidan MacDonald <aidanmacdonald.0x0@gmail.com>
> ---
>   drivers/pinctrl/pinctrl-ingenic.c | 5 ++++-
>   1 file changed, 4 insertions(+), 1 deletion(-)


The M200 SoC (once planned to be called JZ4785) has a different shadow 
register offset address,

if it needs to be supported in the future, then we need to deal with it 
further, but fortunately pinctrl-ingenic.c

does not involve M200 support yet, so:


Reviewed-by: 周琰杰 (Zhou Yanjie) <zhouyanjie@wanyeetech.com>


Thanks and best regards!


>
> diff --git a/drivers/pinctrl/pinctrl-ingenic.c b/drivers/pinctrl/pinctrl-ingenic.c
> index 2712f51eb238..9d2bccda50f1 100644
> --- a/drivers/pinctrl/pinctrl-ingenic.c
> +++ b/drivers/pinctrl/pinctrl-ingenic.c
> @@ -4168,7 +4168,10 @@ static int __init ingenic_pinctrl_probe(struct platform_device *pdev)
>   		return PTR_ERR(base);
>   
>   	regmap_config = ingenic_pinctrl_regmap_config;
> -	regmap_config.max_register = chip_info->num_chips * chip_info->reg_offset;
> +	if (chip_info->version >= ID_X1000)
> +		regmap_config.max_register = MIN(8, chip_info->num_chips) * chip_info->reg_offset;
> +	else
> +		regmap_config.max_register = chip_info->num_chips * chip_info->reg_offset;
>   
>   	jzpc->map = devm_regmap_init_mmio(dev, base, &regmap_config);
>   	if (IS_ERR(jzpc->map)) {
