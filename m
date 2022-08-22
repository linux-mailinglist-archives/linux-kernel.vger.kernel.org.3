Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0A1A859B80B
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Aug 2022 05:40:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232353AbiHVDji (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 21 Aug 2022 23:39:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51762 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231994AbiHVDjc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 21 Aug 2022 23:39:32 -0400
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C4AE1248C3;
        Sun, 21 Aug 2022 20:39:31 -0700 (PDT)
Received: from canpemm500009.china.huawei.com (unknown [172.30.72.53])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4M9yj51spzznTbv;
        Mon, 22 Aug 2022 11:37:13 +0800 (CST)
Received: from [10.174.178.165] (10.174.178.165) by
 canpemm500009.china.huawei.com (7.192.105.203) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Mon, 22 Aug 2022 11:39:29 +0800
Subject: Re: [PATCH -next] gpio: mockup: remove gpio debugfs when remove
 device
To:     Bartosz Golaszewski <brgl@bgdev.pl>
CC:     Bamvor Jian Zhang <bamv2005@gmail.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <20220816145225.84283-1-weiyongjun1@huawei.com>
 <CAMRc=McG5Pf4b5HymV1iaFAGqMMEtyYSQi23z9LmjvzmbF4rYg@mail.gmail.com>
From:   "weiyongjun (A)" <weiyongjun1@huawei.com>
Message-ID: <fe049f3e-6924-342b-a5ba-f460ddce436c@huawei.com>
Date:   Mon, 22 Aug 2022 11:39:29 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <CAMRc=McG5Pf4b5HymV1iaFAGqMMEtyYSQi23z9LmjvzmbF4rYg@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.174.178.165]
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 canpemm500009.china.huawei.com (7.192.105.203)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 2022/8/19 20:49, Bartosz Golaszewski wrote:
> On Tue, Aug 16, 2022 at 4:34 PM Wei Yongjun <weiyongjun1@huawei.com> wrote:
>> GPIO mockup debugfs is created in gpio_mockup_probe() but
>> forgot to remove when remove device. This patch add a devm
>> managed callback for removing them.
>>
> The tag -next is for patches that address issues that are in next but
> not yet in master.


Got it. Thanks.


>
>> Signed-off-by: Wei Yongjun <weiyongjun1@huawei.com>
>> ---
>>   drivers/gpio/gpio-mockup.c | 11 +++++++++++
>>   1 file changed, 11 insertions(+)
>>
>> diff --git a/drivers/gpio/gpio-mockup.c b/drivers/gpio/gpio-mockup.c
>> index 8943cea92764..1fdc444b093b 100644
>> --- a/drivers/gpio/gpio-mockup.c
>> +++ b/drivers/gpio/gpio-mockup.c
>> @@ -373,6 +373,13 @@ static void gpio_mockup_debugfs_setup(struct device *dev,
>>          }
>>   }
>>
>> +static void gpio_mockup_debugfs_cleanup(void *data)
>> +{
>> +       struct gpio_mockup_chip *chip = data;
>> +
>> +       debugfs_remove_recursive(chip->dbg_dir);
>> +}
>> +
>>   static void gpio_mockup_dispose_mappings(void *data)
>>   {
>>          struct gpio_mockup_chip *chip = data;
>> @@ -455,6 +462,10 @@ static int gpio_mockup_probe(struct platform_device *pdev)
>>
>>          gpio_mockup_debugfs_setup(dev, chip);
>>
>> +       rv = devm_add_action_or_reset(dev, gpio_mockup_debugfs_cleanup, chip);
>> +       if (rv)
>> +               return rv;
>> +
> Please return that function directly.


Will fix it.


>
>>          return 0;
>>   }
>>
>> --
>> 2.34.1
>>
> This isn't very relevant as the module needs to be unloaded anyway in
> order to reconfigure the simulated device but I'll apply it as it's
> technically correct. Did you see we have a new one - gpio-sim - that
> uses configfs?
>

gpio-mockup is used for testing other drivers with overlay dts, and 
triggered

this issue. I though gpio-sim not work with dts, but it should works well.

I will have a try to using the new gpio-sim module.


