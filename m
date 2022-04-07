Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 21BFD4F87B2
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Apr 2022 21:07:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347090AbiDGTJZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Apr 2022 15:09:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33984 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347097AbiDGTJT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Apr 2022 15:09:19 -0400
Received: from out29-123.mail.aliyun.com (out29-123.mail.aliyun.com [115.124.29.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF978232115;
        Thu,  7 Apr 2022 12:07:16 -0700 (PDT)
X-Alimail-AntiSpam: AC=CONTINUE;BC=0.07436322|-1;BR=01201311R861S47rulernew998_84748_2000303;CH=blue;DM=|CONTINUE|false|;DS=CONTINUE|ham_system_inform|0.0736733-7.86418e-05-0.926248;FP=0|0|0|0|0|-1|-1|-1;HT=ay29a033018047209;MF=zhouyu@wanyeetech.com;NM=1;PH=DS;RN=6;RT=6;SR=0;TI=SMTPD_---.NM70KNl_1649358432;
Received: from 192.168.30.128(mailfrom:zhouyu@wanyeetech.com fp:SMTPD_---.NM70KNl_1649358432)
          by smtp.aliyun-inc.com(33.40.73.199);
          Fri, 08 Apr 2022 03:07:13 +0800
Subject: Re: [PATCH v2] pinctrl: Ingenic: Add missing UART2 group C for
 X1000/E
To:     Yunian Yang <reimu@sudomaker.com>, linux-mips@vger.kernel.org
Cc:     Paul Cercueil <paul@crapouillou.net>,
        Linus Walleij <linus.walleij@linaro.org>,
        linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org
References: <fd813c7d-888a-ce53-b1e5-d9b41003b58b@sudomaker.com>
From:   Zhou Yanjie <zhouyu@wanyeetech.com>
Message-ID: <b04e92b4-e7c5-c3b2-54b1-c684012d81d2@wanyeetech.com>
Date:   Fri, 8 Apr 2022 03:07:12 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <fd813c7d-888a-ce53-b1e5-d9b41003b58b@sudomaker.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-Spam-Status: No, score=-4.8 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 2022/3/24 下午9:33, Yunian Yang wrote:
> v2: Define PC31 pin only once, noted by Paul Cercueil <paul@crapouillou.net>
>      Confirmed to work on hardware. Although the Ingenic folks did this twice
>      in their 4.4 kernel fork; not sure why.
>
> X1000/E has a third UART2 pin group selection, which uses the TDI(G2) as RX
> and TDO(G1) as TX. This configuration is becoming increasingly popular in
> newer core boards, such as the Halley2 v4.1. This is done by enabling
> function 1 of a "virtual pin" PC31. See section 19.3.3 of the X1000
> Programming Manual for details.
>
> Signed-off-by: Yunian Yang <reimu@sudomaker.com>


A similar situation exists on JZ4780, except that its virtual pin is PA31.



Tested-by: 周琰杰 (Zhou Yanjie) <zhouyanjie@wanyeetech.com>


Thanks and best regards!


> ---
>   drivers/pinctrl/pinctrl-ingenic.c | 4 +++-
>   1 file changed, 3 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/pinctrl/pinctrl-ingenic.c b/drivers/pinctrl/pinctrl-ingenic.c
> index 2712f51eb238..29709059d62b 100644
> --- a/drivers/pinctrl/pinctrl-ingenic.c
> +++ b/drivers/pinctrl/pinctrl-ingenic.c
> @@ -1982,6 +1982,7 @@ static int x1000_uart1_data_a_pins[] = { 0x04, 0x05, };
>   static int x1000_uart1_data_d_pins[] = { 0x62, 0x63, };
>   static int x1000_uart1_hwflow_pins[] = { 0x64, 0x65, };
>   static int x1000_uart2_data_a_pins[] = { 0x02, 0x03, };
> +static int x1000_uart2_data_c_pins[] = { 0x5f, };
>   static int x1000_uart2_data_d_pins[] = { 0x65, 0x64, };
>   static int x1000_sfc_data_pins[] = { 0x1d, 0x1c, 0x1e, 0x1f, };
>   static int x1000_sfc_clk_pins[] = { 0x1a, };
> @@ -2058,6 +2059,7 @@ static const struct group_desc x1000_groups[] = {
>          INGENIC_PIN_GROUP("uart1-data-d", x1000_uart1_data_d, 1),
>          INGENIC_PIN_GROUP("uart1-hwflow", x1000_uart1_hwflow, 1),
>          INGENIC_PIN_GROUP("uart2-data-a", x1000_uart2_data_a, 2),
> +       INGENIC_PIN_GROUP("uart2-data-c", x1000_uart2_data_c, 1),
>          INGENIC_PIN_GROUP("uart2-data-d", x1000_uart2_data_d, 0),
>          INGENIC_PIN_GROUP("sfc-data", x1000_sfc_data, 1),
>          INGENIC_PIN_GROUP("sfc-clk", x1000_sfc_clk, 1),
> @@ -2115,7 +2117,7 @@ static const char *x1000_uart0_groups[] = { "uart0-data", "uart0-hwflow", };
>   static const char *x1000_uart1_groups[] = {
>          "uart1-data-a", "uart1-data-d", "uart1-hwflow",
>   };
> -static const char *x1000_uart2_groups[] = { "uart2-data-a", "uart2-data-d", };
> +static const char *x1000_uart2_groups[] = { "uart2-data-a", "uart2-data-c", "uart2-data-d", };
>   static const char *x1000_sfc_groups[] = { "sfc-data", "sfc-clk", "sfc-ce", };
>   static const char *x1000_ssi_groups[] = {
>          "ssi-dt-a-22", "ssi-dt-a-29", "ssi-dt-d",
