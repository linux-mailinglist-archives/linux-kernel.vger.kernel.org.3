Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 33CC755B545
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Jun 2022 04:37:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231584AbiF0ChB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 26 Jun 2022 22:37:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53218 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229867AbiF0Cg7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 26 Jun 2022 22:36:59 -0400
Received: from mail-sz.amlogic.com (mail-sz.amlogic.com [211.162.65.117])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AAAAC2DC9
        for <linux-kernel@vger.kernel.org>; Sun, 26 Jun 2022 19:36:58 -0700 (PDT)
Received: from [10.28.39.121] (10.28.39.121) by mail-sz.amlogic.com
 (10.28.11.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2176.2; Mon, 27 Jun
 2022 10:36:56 +0800
Message-ID: <af10ff7f-b9e7-7bdc-a5ba-855b891f1110@amlogic.com>
Date:   Mon, 27 Jun 2022 10:36:54 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 6.1; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [PATCH v7 5/5] mtd: rawnand: meson: not support legacy clock
Content-Language: en-US
To:     Neil Armstrong <narmstrong@baylibre.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        <linux-mtd@lists.infradead.org>
CC:     kernel test robot <lkp@intel.com>,
        Rob Herring <robh+dt@kernel.org>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        Kevin Hilman <khilman@baylibre.com>,
        Jianxin Pan <jianxin.pan@amlogic.com>,
        Victor Wan <victor.wan@amlogic.com>,
        XianWei Zhao <xianwei.zhao@amlogic.com>,
        Kelvin Zhang <kelvin.zhang@amlogic.com>,
        BiChao Zheng <bichao.zheng@amlogic.com>,
        YongHui Yu <yonghui.yu@amlogic.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-amlogic@lists.infradead.org>, <linux-kernel@vger.kernel.org>
References: <20220624131257.29906-1-liang.yang@amlogic.com>
 <20220624131257.29906-6-liang.yang@amlogic.com>
 <5f1bd986-e193-b147-8322-3a0bf14fc373@baylibre.com>
From:   Liang Yang <liang.yang@amlogic.com>
In-Reply-To: <5f1bd986-e193-b147-8322-3a0bf14fc373@baylibre.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.28.39.121]
X-ClientProxiedBy: mail-sz.amlogic.com (10.28.11.5) To mail-sz.amlogic.com
 (10.28.11.5)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Neil,

On 2022/6/24 21:27, Neil Armstrong wrote:
> [ EXTERNAL EMAIL ]
> 
> Hi,
> 
> On 24/06/2022 15:12, Liang Yang wrote:
>> meson NFC driver use common clock interfaces. so the test robot report
>> some errors once using the legacy clock with HAVE_LEGACY_CLK on.
>>
>> Reported-by: kernel test robot <lkp@intel.com>
>> Signed-off-by: Liang Yang <liang.yang@amlogic.com>
>> ---
>>   drivers/mtd/nand/raw/Kconfig | 2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/drivers/mtd/nand/raw/Kconfig b/drivers/mtd/nand/raw/Kconfig
>> index 67b7cb67c030..0ff86ca5932d 100644
>> --- a/drivers/mtd/nand/raw/Kconfig
>> +++ b/drivers/mtd/nand/raw/Kconfig
>> @@ -395,7 +395,7 @@ config MTD_NAND_STM32_FMC2
>>   config MTD_NAND_MESON
>>       tristate "Support for NAND controller on Amlogic's Meson SoCs"
>> -    depends on ARCH_MESON || COMPILE_TEST
>> +    depends on ARCH_MESON || COMPILE_TEST || COMMON_CLK
> 
> This should be :
>      depends on COMMON_CLK && (ARCH_MESON || COMPILE_TEST)

ok, i will fix it. thanks.

> 
>>       select MFD_SYSCON
>>       help
>>         Enables support for NAND controller on Amlogic's Meson SoCs.
> 
> Neil
> 
> .
