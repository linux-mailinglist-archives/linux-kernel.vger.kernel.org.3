Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9729048E2D7
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jan 2022 04:07:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239000AbiANDHV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Jan 2022 22:07:21 -0500
Received: from mail-sz.amlogic.com ([211.162.65.117]:6168 "EHLO
        mail-sz.amlogic.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236150AbiANDHT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Jan 2022 22:07:19 -0500
Received: from [10.28.39.106] (10.28.39.106) by mail-sz.amlogic.com
 (10.28.11.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2176.2; Fri, 14 Jan
 2022 11:07:17 +0800
Message-ID: <98619eef-8b51-c138-e98d-39fdbe4c9ebb@amlogic.com>
Date:   Fri, 14 Jan 2022 11:07:17 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 6.1; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH v9 1/4] clk: meson: add one based divider support for sclk
Content-Language: en-US
To:     Stephen Boyd <sboyd@kernel.org>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Kevin Hilman <khilman@baylibre.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Rob Herring <robh+dt@kernel.org>, <linux-clk@vger.kernel.org>
CC:     Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        Jianxin Pan <jianxin.pan@amlogic.com>,
        Victor Wan <victor.wan@amlogic.com>,
        XianWei Zhao <xianwei.zhao@amlogic.com>,
        Kelvin Zhang <kelvin.zhang@amlogic.com>,
        BiChao Zheng <bichao.zheng@amlogic.com>,
        YongHui Yu <yonghui.yu@amlogic.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-amlogic@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>
References: <20220113115745.45826-1-liang.yang@amlogic.com>
 <20220113115745.45826-2-liang.yang@amlogic.com>
 <20220113212801.E88BFC36AE3@smtp.kernel.org>
From:   Liang Yang <liang.yang@amlogic.com>
In-Reply-To: <20220113212801.E88BFC36AE3@smtp.kernel.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.28.39.106]
X-ClientProxiedBy: mail-sz.amlogic.com (10.28.11.5) To mail-sz.amlogic.com
 (10.28.11.5)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Stephen,

On 2022/1/14 5:28, Stephen Boyd wrote:
> [ EXTERNAL EMAIL ]
> 
> Quoting Liang Yang (2022-01-13 03:57:42)
>> diff --git a/drivers/clk/meson/sclk-div.c b/drivers/clk/meson/sclk-div.c
>> index 76d31c0a3342..79c9efd28115 100644
>> --- a/drivers/clk/meson/sclk-div.c
>> +++ b/drivers/clk/meson/sclk-div.c
>> @@ -28,22 +29,39 @@ meson_sclk_div_data(struct clk_regmap *clk)
>>          return (struct meson_sclk_div_data *)clk->data;
>>   }
>>   
>> -static int sclk_div_maxval(struct meson_sclk_div_data *sclk)
>> +static inline int sclk_get_reg(int val, unsigned char flag)
>>   {
>> -       return (1 << sclk->div.width) - 1;
>> +       if ((flag & MESON_SCLK_ONE_BASED) || !val)
>> +               return val;
>> +       else
>> +               return val - 1;
> 
> Please drop the else
ok
> 
>> +}
>> +
>> +static inline int sclk_get_divider(int reg, unsigned char flag)
>> +{
>> +       if (flag & MESON_SCLK_ONE_BASED)
>> +               return reg;
>> +       else
> 
> Please drop the else
ok
> 
>> +               return reg + 1;
>>   }
>>   
>>   static int sclk_div_maxdiv(struct meson_sclk_div_data *sclk)
>>   {
>> -       return sclk_div_maxval(sclk) + 1;
> 
> .
