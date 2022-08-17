Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5C3DC596773
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Aug 2022 04:32:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238178AbiHQCbr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 Aug 2022 22:31:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37828 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231140AbiHQCbo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Aug 2022 22:31:44 -0400
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D958A9A947;
        Tue, 16 Aug 2022 19:31:42 -0700 (PDT)
Received: from dggpemm500023.china.huawei.com (unknown [172.30.72.57])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4M6sRF4G77zmVpd;
        Wed, 17 Aug 2022 10:29:29 +0800 (CST)
Received: from dggpemm500001.china.huawei.com (7.185.36.107) by
 dggpemm500023.china.huawei.com (7.185.36.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Wed, 17 Aug 2022 10:31:40 +0800
Received: from [10.67.111.195] (10.67.111.195) by
 dggpemm500001.china.huawei.com (7.185.36.107) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Wed, 17 Aug 2022 10:31:40 +0800
Subject: Re: [PATCH] power: supply: ab8500: remove unused static local
 variable
From:   chenlifu <chenlifu@huawei.com>
To:     Tom Rix <trix@redhat.com>, <linus.walleij@linaro.org>,
        <sre@kernel.org>
CC:     <linux-pm@vger.kernel.org>, <linux-kernel@vger.kernel.org>
References: <20220719022743.305189-1-trix@redhat.com>
 <7b42a25a-806f-f3b2-b42f-ac3fdb6627b4@huawei.com>
Message-ID: <a0822c1f-6652-a4ef-b482-f54944deb094@huawei.com>
Date:   Wed, 17 Aug 2022 10:31:29 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.9.0
MIME-Version: 1.0
In-Reply-To: <7b42a25a-806f-f3b2-b42f-ac3fdb6627b4@huawei.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.67.111.195]
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 dggpemm500001.china.huawei.com (7.185.36.107)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

在 2022/8/17 9:57, chenlifu 写道:
> 在 2022/7/19 10:27, Tom Rix 写道:
>> cpp_check reports
>> [drivers/power/supply/ab8500_chargalg.c:493]: (style) Variable 
>> 'ab8500_chargalg_ex_ac_enable_toggle' is assigned a value that is 
>> never used.
>>
>>> From inspection, this variable is never used. So remove it.
>>
>> Fixes: 6c50a08d9dd3 ("power: supply: ab8500: Drop external charger 
>> leftovers")
>> Signed-off-by: Tom Rix <trix@redhat.com>
>> ---
>>   drivers/power/supply/ab8500_chargalg.c | 2 --
>>   1 file changed, 2 deletions(-)
>>
>> diff --git a/drivers/power/supply/ab8500_chargalg.c 
>> b/drivers/power/supply/ab8500_chargalg.c
>> index ae4be553f424..05146d436a6a 100644
>> --- a/drivers/power/supply/ab8500_chargalg.c
>> +++ b/drivers/power/supply/ab8500_chargalg.c
>> @@ -490,8 +490,6 @@ static int ab8500_chargalg_kick_watchdog(struct 
>> ab8500_chargalg *di)
>>   static int ab8500_chargalg_ac_en(struct ab8500_chargalg *di, int 
>> enable,
>>       int vset_uv, int iset_ua)
>>   {
>> -    static int ab8500_chargalg_ex_ac_enable_toggle;
>> -
>>       if (!di->ac_chg || !di->ac_chg->ops.enable)
>>           return -ENXIO;
>>
> 
> Reviewed-by: Chen Lifu <chenlifu@huawei.com>
> 
> 
> I can still observe this build error with ARCH=arm, 
> defconfig=allyesconfig in linux-next next-200816:
> 
> drivers/power/supply/ab8500_chargalg.c: In function 
> ‘ab8500_chargalg_ac_en’:
> drivers/power/supply/ab8500_chargalg.c:493:13: error: unused variable 
> ‘ab8500_chargalg_ex_ac_enable_toggle’ [-Werror=unused-variable]
>   static int ab8500_chargalg_ex_ac_enable_toggle;
>              ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> .

Reviewed-by: Chen Lifu <chenlifu@huawei.com>

fixed the tag: next-200816 --> next-20220816

I can still observe this build error with ARCH=arm, 
defconfig=allyesconfig in linux-next next-20220816:

drivers/power/supply/ab8500_chargalg.c: In function ‘ab8500_chargalg_ac_en’:
drivers/power/supply/ab8500_chargalg.c:493:13: error: unused variable 
‘ab8500_chargalg_ex_ac_enable_toggle’ [-Werror=unused-variable]
  static int ab8500_chargalg_ex_ac_enable_toggle;
             ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
