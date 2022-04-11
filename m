Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 222034FC460
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Apr 2022 20:50:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349258AbiDKSwj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Apr 2022 14:52:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36926 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231283AbiDKSwf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Apr 2022 14:52:35 -0400
Received: from out28-220.mail.aliyun.com (out28-220.mail.aliyun.com [115.124.28.220])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A85D0A1B7;
        Mon, 11 Apr 2022 11:50:17 -0700 (PDT)
X-Alimail-AntiSpam: AC=CONTINUE;BC=0.08682281|-1;CH=green;DM=|CONTINUE|false|;DS=CONTINUE|ham_regular_dialog|0.033697-0.000638791-0.965664;FP=0|0|0|0|0|-1|-1|-1;HT=ay29a033018047190;MF=zhouyanjie@wanyeetech.com;NM=1;PH=DS;RN=7;RT=7;SR=0;TI=SMTPD_---.NOg3L5G_1649703014;
Received: from 192.168.30.128(mailfrom:zhouyanjie@wanyeetech.com fp:SMTPD_---.NOg3L5G_1649703014)
          by smtp.aliyun-inc.com(33.40.23.6);
          Tue, 12 Apr 2022 02:50:15 +0800
Subject: Re: [PATCH v2] mips: dts: ingenic: x1000: Add PWM device tree node
To:     Aidan MacDonald <aidanmacdonald.0x0@gmail.com>, robh+dt@kernel.org,
        krzk+dt@kernel.org
Cc:     paul@crapouillou.net, linux-mips@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20220411155315.51769-1-aidanmacdonald.0x0@gmail.com>
From:   Zhou Yanjie <zhouyanjie@wanyeetech.com>
Message-ID: <3ff9ad6b-1437-3789-c180-f7f1c0ab4eab@wanyeetech.com>
Date:   Tue, 12 Apr 2022 02:50:13 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20220411155315.51769-1-aidanmacdonald.0x0@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-Spam-Status: No, score=-3.5 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Aidan,

On 2022/4/11 下午11:53, Aidan MacDonald wrote:
> Copied from the jz4740 devicetree and trimmed to 5 timers, which
> is what the hardware supports.
>
> Signed-off-by: Aidan MacDonald <aidanmacdonald.0x0@gmail.com>


Tested-by: 周琰杰 (Zhou Yanjie) <zhouyanjie@wanyeetech.com>


> ---
> v2: Reduce regmap length since only the first 5 timers need to be accessed,
>      and don't wrap the clock-names at 80 columns.
>
>   arch/mips/boot/dts/ingenic/x1000.dtsi | 12 ++++++++++++
>   1 file changed, 12 insertions(+)
>
> diff --git a/arch/mips/boot/dts/ingenic/x1000.dtsi b/arch/mips/boot/dts/ingenic/x1000.dtsi
> index 8bd27edef216..c2cdbf947264 100644
> --- a/arch/mips/boot/dts/ingenic/x1000.dtsi
> +++ b/arch/mips/boot/dts/ingenic/x1000.dtsi
> @@ -127,6 +127,18 @@ wdt: watchdog@0 {
>   			clocks = <&tcu TCU_CLK_WDT>;
>   			clock-names = "wdt";
>   		};
> +
> +		pwm: pwm@40 {
> +			compatible = "ingenic,x1000-pwm";
> +			reg = <0x40 0x50>;
> +
> +			#pwm-cells = <3>;
> +
> +			clocks = <&tcu TCU_CLK_TIMER0>, <&tcu TCU_CLK_TIMER1>,
> +				 <&tcu TCU_CLK_TIMER2>, <&tcu TCU_CLK_TIMER3>,
> +				 <&tcu TCU_CLK_TIMER4>;
> +			clock-names = "timer0", "timer1", "timer2", "timer3", "timer4";
> +		};
>   	};
>   
>   	rtc: rtc@10003000 {
