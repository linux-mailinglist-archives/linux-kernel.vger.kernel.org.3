Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EE1E253F9F9
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Jun 2022 11:37:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239795AbiFGJho (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Jun 2022 05:37:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39864 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239794AbiFGJhg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Jun 2022 05:37:36 -0400
Received: from mail-sz.amlogic.com (mail-sz.amlogic.com [211.162.65.117])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C64042A404
        for <linux-kernel@vger.kernel.org>; Tue,  7 Jun 2022 02:37:34 -0700 (PDT)
Received: from [10.28.39.121] (10.28.39.121) by mail-sz.amlogic.com
 (10.28.11.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2176.2; Tue, 7 Jun 2022
 17:37:32 +0800
Message-ID: <e06acb65-50fe-46e6-a302-0238c902d1a2@amlogic.com>
Date:   Tue, 7 Jun 2022 17:37:31 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 6.1; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [PATCH v6 5/5] mtd: rawnand: meson: not support legacy clock
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
References: <20220607064731.13367-1-liang.yang@amlogic.com>
 <20220607064731.13367-6-liang.yang@amlogic.com>
 <791b3e4e-7348-997a-0ead-136739ec10bf@baylibre.com>
From:   Liang Yang <liang.yang@amlogic.com>
In-Reply-To: <791b3e4e-7348-997a-0ead-136739ec10bf@baylibre.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.28.39.121]
X-ClientProxiedBy: mail-sz.amlogic.com (10.28.11.5) To mail-sz.amlogic.com
 (10.28.11.5)
X-Spam-Status: No, score=-3.1 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Neil,

On 2022/6/7 15:12, Neil Armstrong wrote:
> [ EXTERNAL EMAIL ]
> 
> Hi,
> 
> On 07/06/2022 08:47, Liang Yang wrote:
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
>> index 67b7cb67c030..5169412a4af4 100644
>> --- a/drivers/mtd/nand/raw/Kconfig
>> +++ b/drivers/mtd/nand/raw/Kconfig
>> @@ -395,7 +395,7 @@ config MTD_NAND_STM32_FMC2
>>   config MTD_NAND_MESON
>>       tristate "Support for NAND controller on Amlogic's Meson SoCs"
>> -    depends on ARCH_MESON || COMPILE_TEST
>> +    depends on ARCH_MESON || COMPILE_TEST || !HAVE_LEGACY_CLK
> 
> I think depending on CCF would be better than excluding legacy clock.
>
indeed. i will use COMMON_CLK later. thanks.

>>       select MFD_SYSCON
>>       help
>>         Enables support for NAND controller on Amlogic's Meson SoCs.
> 
> Neil
> 
> .
