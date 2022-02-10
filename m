Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B55D44B091D
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Feb 2022 10:06:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238210AbiBJJGJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Feb 2022 04:06:09 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:39272 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238178AbiBJJGH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Feb 2022 04:06:07 -0500
Received: from out28-169.mail.aliyun.com (out28-169.mail.aliyun.com [115.124.28.169])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 10E8CD94;
        Thu, 10 Feb 2022 01:06:07 -0800 (PST)
X-Alimail-AntiSpam: AC=CONTINUE;BC=0.08102882|-1;CH=green;DM=|CONTINUE|false|;DS=CONTINUE|ham_system_inform|0.0347225-0.00185173-0.963426;FP=0|0|0|0|0|-1|-1|-1;HT=ay29a033018047192;MF=zhouyanjie@wanyeetech.com;NM=1;PH=DS;RN=9;RT=9;SR=0;TI=SMTPD_---.MnwwXYD_1644483964;
Received: from 192.168.88.129(mailfrom:zhouyanjie@wanyeetech.com fp:SMTPD_---.MnwwXYD_1644483964)
          by smtp.aliyun-inc.com(10.147.40.233);
          Thu, 10 Feb 2022 17:06:05 +0800
Subject: Re: [PATCH] clk: ingenic-tcu: Fix missing TCU clock for X1000 SoC
To:     Aidan MacDonald <aidanmacdonald.0x0@gmail.com>,
        paul@crapouillou.net, robh+dt@kernel.org, mturquette@baylibre.com,
        sboyd@kernel.org
Cc:     linux-mips@vger.kernel.org, devicetree@vger.kernel.org,
        linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20220209230145.18943-1-aidanmacdonald.0x0@gmail.com>
From:   Zhou Yanjie <zhouyanjie@wanyeetech.com>
Message-ID: <edc5bd05-45c3-2284-8655-6c1f3ef20f3b@wanyeetech.com>
Date:   Thu, 10 Feb 2022 17:06:04 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20220209230145.18943-1-aidanmacdonald.0x0@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        UNPARSEABLE_RELAY autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Aidan,

On 2022/2/10 上午7:01, Aidan MacDonald wrote:
> The X1000 does have a TCU clock gate, so pass it to the driver.
> Without this the TCU can be gated automatically, which prevents
> timers from running and stops register writes from taking effect.
>
> Signed-off-by: Aidan MacDonald <aidanmacdonald.0x0@gmail.com>
> ---
>   arch/mips/boot/dts/ingenic/x1000.dtsi | 5 +++--
>   drivers/clk/ingenic/tcu.c             | 2 +-
>   2 files changed, 4 insertions(+), 3 deletions(-)


Thank you for fixing the problem that I didn't realize at first.

Reviewed-by: 周琰杰 (Zhou Yanjie) <zhouyanjie@wanyeetech.com>


>
> diff --git a/arch/mips/boot/dts/ingenic/x1000.dtsi b/arch/mips/boot/dts/ingenic/x1000.dtsi
> index 8bd27edef216..c69df8eb158e 100644
> --- a/arch/mips/boot/dts/ingenic/x1000.dtsi
> +++ b/arch/mips/boot/dts/ingenic/x1000.dtsi
> @@ -111,8 +111,9 @@ tcu: timer@10002000 {
>   
>   		clocks = <&cgu X1000_CLK_RTCLK>,
>   			 <&cgu X1000_CLK_EXCLK>,
> -			 <&cgu X1000_CLK_PCLK>;
> -		clock-names = "rtc", "ext", "pclk";
> +			 <&cgu X1000_CLK_PCLK>,
> +			 <&cgu X1000_CLK_TCU>;
> +		clock-names = "rtc", "ext", "pclk", "tcu";
>   
>   		interrupt-controller;
>   		#interrupt-cells = <1>;
> diff --git a/drivers/clk/ingenic/tcu.c b/drivers/clk/ingenic/tcu.c
> index 77acfbeb4830..9c86043f673a 100644
> --- a/drivers/clk/ingenic/tcu.c
> +++ b/drivers/clk/ingenic/tcu.c
> @@ -320,7 +320,7 @@ static const struct ingenic_soc_info jz4770_soc_info = {
>   static const struct ingenic_soc_info x1000_soc_info = {
>   	.num_channels = 8,
>   	.has_ost = false, /* X1000 has OST, but it not belong TCU */
> -	.has_tcu_clk = false,
> +	.has_tcu_clk = true,
>   };
>   
>   static const struct of_device_id __maybe_unused ingenic_tcu_of_match[] __initconst = {
