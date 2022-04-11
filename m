Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D91CA4FBC51
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Apr 2022 14:41:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235615AbiDKMoC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Apr 2022 08:44:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32780 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346187AbiDKMnp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Apr 2022 08:43:45 -0400
Received: from out29-196.mail.aliyun.com (out29-196.mail.aliyun.com [115.124.29.196])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 305254132C;
        Mon, 11 Apr 2022 05:41:30 -0700 (PDT)
X-Alimail-AntiSpam: AC=CONTINUE;BC=0.08153398|-1;BR=01201311R771S34rulernew998_84748_2000303;CH=blue;DM=|CONTINUE|false|;DS=CONTINUE|ham_regular_dialog|0.0990518-0.001919-0.899029;FP=0|0|0|0|0|-1|-1|-1;HT=ay29a033018047207;MF=zhouyu@wanyeetech.com;NM=1;PH=DS;RN=7;RT=7;SR=0;TI=SMTPD_---.NOW40yE_1649680886;
Received: from 192.168.30.128(mailfrom:zhouyu@wanyeetech.com fp:SMTPD_---.NOW40yE_1649680886)
          by smtp.aliyun-inc.com(33.40.85.40);
          Mon, 11 Apr 2022 20:41:27 +0800
Subject: Re: [PATCH] mips: dts: ingenic: x1000: Add PWM device tree node
To:     Aidan MacDonald <aidanmacdonald.0x0@gmail.com>, robh+dt@kernel.org,
        krzk+dt@kernel.org
Cc:     paul@crapouillou.net, linux-mips@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20220411100139.15672-1-aidanmacdonald.0x0@gmail.com>
From:   Zhou Yanjie <zhouyu@wanyeetech.com>
Message-ID: <8a3f88d8-3e94-1388-b1c6-b0f71d59f34c@wanyeetech.com>
Date:   Mon, 11 Apr 2022 20:41:26 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20220411100139.15672-1-aidanmacdonald.0x0@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-Spam-Status: No, score=-3.5 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        UNPARSEABLE_RELAY autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Aidan,

On 2022/4/11 下午6:01, Aidan MacDonald wrote:
> Copied from the jz4740 devicetree and trimmed to 5 timers, which
> is what the hardware supports.
>
> Signed-off-by: Aidan MacDonald <aidanmacdonald.0x0@gmail.com>
> ---
>   arch/mips/boot/dts/ingenic/x1000.dtsi | 13 +++++++++++++
>   1 file changed, 13 insertions(+)
>
> diff --git a/arch/mips/boot/dts/ingenic/x1000.dtsi b/arch/mips/boot/dts/ingenic/x1000.dtsi
> index 8bd27edef216..0dcf37527c8e 100644
> --- a/arch/mips/boot/dts/ingenic/x1000.dtsi
> +++ b/arch/mips/boot/dts/ingenic/x1000.dtsi
> @@ -127,6 +127,19 @@ wdt: watchdog@0 {
>   			clocks = <&tcu TCU_CLK_WDT>;
>   			clock-names = "wdt";
>   		};
> +
> +		pwm: pwm@40 {
> +			compatible = "ingenic,x1000-pwm";
> +			reg = <0x40 0x80>;


It seems more reasonable to use "reg = <0x40 0x80>" since the
X1000 has only 5 PWM channels.


> +
> +			#pwm-cells = <3>;
> +
> +			clocks = <&tcu TCU_CLK_TIMER0>, <&tcu TCU_CLK_TIMER1>,
> +				 <&tcu TCU_CLK_TIMER2>, <&tcu TCU_CLK_TIMER3>,
> +				 <&tcu TCU_CLK_TIMER4>;
> +			clock-names = "timer0", "timer1", "timer2",
> +				      "timer3", "timer4";


One line is now allowed to hold at most 100 characters,
so it is possible to use only one line like:

         clock-names = "timer0", "timer1", "timer2", "timer3", "timer4";

to reduce the number of lines in the dtsi file.


Thanks and best regards!


> +		};
>   	};
>   
>   	rtc: rtc@10003000 {
