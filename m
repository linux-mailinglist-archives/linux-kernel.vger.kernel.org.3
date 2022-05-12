Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A00F6524476
	for <lists+linux-kernel@lfdr.de>; Thu, 12 May 2022 06:46:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348041AbiELEq3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 May 2022 00:46:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60496 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348598AbiELEqT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 May 2022 00:46:19 -0400
Received: from szxga03-in.huawei.com (szxga03-in.huawei.com [45.249.212.189])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C69A82180D
        for <linux-kernel@vger.kernel.org>; Wed, 11 May 2022 21:46:11 -0700 (PDT)
Received: from kwepemi100006.china.huawei.com (unknown [172.30.72.54])
        by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4KzJy860tgzCsXP;
        Thu, 12 May 2022 12:41:20 +0800 (CST)
Received: from kwepemm600005.china.huawei.com (7.193.23.191) by
 kwepemi100006.china.huawei.com (7.221.188.165) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Thu, 12 May 2022 12:46:09 +0800
Received: from [10.67.109.54] (10.67.109.54) by kwepemm600005.china.huawei.com
 (7.193.23.191) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Thu, 12 May
 2022 12:46:08 +0800
Subject: Re: [PATCH -next 1/2] ASoC: max98396: Fix build error for implicit
 function declaration
To:     Mark Brown <broonie@kernel.org>
References: <20220511012348.94288-1-tanghui20@huawei.com>
 <20220511012348.94288-2-tanghui20@huawei.com>
 <YnumrRUSkVCPONdl@sirena.org.uk>
CC:     <lgirdwood@gmail.com>, <perex@perex.cz>, <tiwai@suse.com>,
        <ryan.lee.analog@gmail.com>, <ricardw@axis.com>, <steve@sk2.org>,
        <alsa-devel@alsa-project.org>, <linux-kernel@vger.kernel.org>
From:   Hui Tang <tanghui20@huawei.com>
Message-ID: <f84cbd0a-0a9e-fd72-b319-dfca8c19ce64@huawei.com>
Date:   Thu, 12 May 2022 12:46:08 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.7.1
MIME-Version: 1.0
In-Reply-To: <YnumrRUSkVCPONdl@sirena.org.uk>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.67.109.54]
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 kwepemm600005.china.huawei.com (7.193.23.191)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.9 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2022/5/11 20:06, Mark Brown wrote:
> On Wed, May 11, 2022 at 09:23:47AM +0800, Hui Tang wrote:
>
>>                          devm_regulator_get_optional
>> sound/soc/codecs/max98396.c:1556:23: error: ‘GPIOD_OUT_HIGH’ undeclared (first use in this function); did you mean ‘GPIOF_INIT_HIGH’?
>>               "reset", GPIOD_OUT_HIGH);
>>                        ^~~~~~~~~~~~~~
>>                        GPIOF_INIT_HIGH
>> sound/soc/codecs/max98396.c:1556:23: note: each undeclared identifier is reported only once for each function it appears in
>> sound/soc/codecs/max98396.c:1565:3: error: implicit declaration of function ‘gpiod_set_value_cansleep’; did you mean ‘gpio_set_value_cansleep’? [-Werror=implicit-function-declaration]
>>    gpiod_set_value_cansleep(max98396->reset_gpio, 0);
>>    ^~~~~~~~~~~~~~~~~~~~~~~~
>>    gpio_set_value_cansleep
>> cc1: all warnings being treated as errors
>>
>> Add depend on GPIOLIB for 'config SND_SOC_MAX98396'
>
> No, these issues are missing headers not dependencies.  In general
> gpiolib stubs out so drivers can optionally use GPIO functionality.
>

Ok, I will do that

thank you
