Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4D347557351
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Jun 2022 08:50:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229973AbiFWGuG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Jun 2022 02:50:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45502 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229964AbiFWGuF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Jun 2022 02:50:05 -0400
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E3FA44773
        for <linux-kernel@vger.kernel.org>; Wed, 22 Jun 2022 23:50:03 -0700 (PDT)
Received: from kwepemi500023.china.huawei.com (unknown [172.30.72.53])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4LT9lJ3PpyzSh98;
        Thu, 23 Jun 2022 14:46:36 +0800 (CST)
Received: from [10.174.176.254] (10.174.176.254) by
 kwepemi500023.china.huawei.com (7.221.188.76) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Thu, 23 Jun 2022 14:50:00 +0800
Subject: Re: [PATCH] soc: mediatek: fix missing clk_disable_unprepare() on err
 in svs_resume()
To:     Matthias Brugger <matthias.bgg@gmail.com>
CC:     <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <liwei391@huawei.com>
References: <20220621114658.10054-1-wupeng58@huawei.com>
 <f48e0cca-644a-bad7-282b-28e3e0d5d437@gmail.com>
From:   "wupeng (D)" <wupeng58@huawei.com>
Message-ID: <6b1751c2-28c9-8b1b-4273-3f3c5681151a@huawei.com>
Date:   Thu, 23 Jun 2022 14:50:00 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.0
MIME-Version: 1.0
In-Reply-To: <f48e0cca-644a-bad7-282b-28e3e0d5d437@gmail.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.174.176.254]
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 kwepemi500023.china.huawei.com (7.221.188.76)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2022/6/22 22:02, Matthias Brugger wrote:
> 
> 
> On 21/06/2022 13:46, Peng Wu wrote:
>> Fix the missing clk_disable_unprepare() before return
>> from svs_resume() in the error handling case.
>>
>> Signed-off-by: Peng Wu <wupeng58@huawei.com>
>> Reported-by: Hulk Robot <hulkci@huawei.com>
>> ---
>>   drivers/soc/mediatek/mtk-svs.c | 1 +
>>   1 file changed, 1 insertion(+)
>>
>> diff --git a/drivers/soc/mediatek/mtk-svs.c b/drivers/soc/mediatek/mtk-svs.c
>> index 606a00a2e57d..1b5c297aaec5 100644
>> --- a/drivers/soc/mediatek/mtk-svs.c
>> +++ b/drivers/soc/mediatek/mtk-svs.c
>> @@ -1525,6 +1525,7 @@ static int svs_resume(struct device *dev)
>>       ret = reset_control_deassert(svsp->rst);
>>       if (ret) {
>> +        clk_disable_unprepare(svsp->main_clk);
> 
> Same holds for the error path of svs_init02(), correct?
> 
> Regards,
> Matthias
> 
>>           dev_err(svsp->dev, "cannot deassert reset %d\n", ret);
>>           return ret;
>>       }
> .
Yes, the error path of svs_init02() requires the same operation.
I will resubmit a patch.

Regards,
Peng
