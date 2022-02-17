Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 32E744BAAA5
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Feb 2022 21:10:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245720AbiBQUK4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Feb 2022 15:10:56 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:50334 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243775AbiBQUKz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Feb 2022 15:10:55 -0500
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [46.235.227.227])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AD0C97ED9B;
        Thu, 17 Feb 2022 12:10:40 -0800 (PST)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: shreeya)
        with ESMTPSA id 014A81F462CF
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1645128639;
        bh=Fk8wJN7pTms4IsuWl6aZhGvZXpAYl3f+43AKU7qlpMg=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=NbRb9TCyvLFZemrrZEp0rCw/Z7XV6hml0R9kzLz1UbVlNF18jf3maCkR1gvrRhhzy
         JvhO90JnR47C9FROjeGRaTOYdqJ0O4GM0Tari4BuxMJn1m7ygsTJXkqOJ8/uwelH77
         +KVhpsbw5WHJYCJ/nAc98EQ3aS/3VkEBe6fPXNDxK0lkkgGH9izwfBgsWeKDPkWbb1
         0OjOaUzUerLJ+ctQCZ6KXpU+XVUJpIWQyIW2ij1f4AJlJBEf2ikFnV/Y+jLNXo8TFA
         rQG7PQrDFcbIiYksQjhOJD3L94yUcqBLejHyBZhSKAnXTGpzO+R9jrBGUVf/aSB92K
         gh6p4H4T9vtxA==
Subject: Re: [PATCH v4] gpio: Return EPROBE_DEFER if gc->to_irq is NULL
To:     Bartosz Golaszewski <brgl@bgdev.pl>,
        Gabriel Krisman Bertazi <krisman@collabora.com>,
        Andy Shevchenko <andy.shevchenko@gmail.com>
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        wsa@kernel.org, kernel@collabora.com,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        kbuild test robot <lkp@intel.com>
References: <20211116093833.245542-1-shreeya.patel@collabora.com>
 <874k56znix.fsf@collabora.com>
 <CAMRc=MdByxO3+hJruvUkULtXAaB7aWewTd=Wv0MbWyX2vykdjA@mail.gmail.com>
From:   Shreeya Patel <shreeya.patel@collabora.com>
Message-ID: <8c2ef205-8e80-21e6-b8ad-f55cdb11079a@collabora.com>
Date:   Fri, 18 Feb 2022 01:40:31 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <CAMRc=MdByxO3+hJruvUkULtXAaB7aWewTd=Wv0MbWyX2vykdjA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 10/02/22 11:30 pm, Bartosz Golaszewski wrote:
> On Thu, Feb 10, 2022 at 5:36 PM Gabriel Krisman Bertazi
> <krisman@collabora.com> wrote:
>> Shreeya Patel <shreeya.patel@collabora.com> writes:
>>
>>> We are racing the registering of .to_irq when probing the
>>> i2c driver. This results in random failure of touchscreen
>>> devices.
>>>
>>> Following errors could be seen in dmesg logs when gc->to_irq is NULL
>>>
>>> [2.101857] i2c_hid i2c-FTS3528:00: HID over i2c has not been provided an Int IRQ
>>> [2.101953] i2c_hid: probe of i2c-FTS3528:00 failed with error -22
>>>
>>> To avoid this situation, defer probing until to_irq is registered.
>>>
>>> This issue has been reported many times in past and people have been
>>> using workarounds like changing the pinctrl_amd to built-in instead
>>> of loading it as a module or by adding a softdep for pinctrl_amd into
>>> the config file.
>>>
>>> BugLink: https://bugzilla.kernel.org/show_bug.cgi?id=209413
>>> Reviewed-by: Linus Walleij <linus.walleij@linaro.org>
>>> Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>
>>> Reported-by: kernel test robot <lkp@intel.com>
>>> Signed-off-by: Shreeya Patel <shreeya.patel@collabora.com>
>> Hi guys,
>>
>> This seems to not have reached the Linus tree on 5.17.  If I'm not
>> mistaken, it also hasn't reached linux-next as of today. Is there
>> anything I'm missing here?
>>
>> This is required to prevent spurious probe crashes of devices like this
>> FocalTech touchscreen, FT3528, when using pinctrl-amd. We've been
>> carrying it downstream for quite a while.
>>
>> Thanks,
>>
>> --
>> Gabriel Krisman Bertazi
> Hi Gabriel!
>
> My email address changed in September, that's why I didn't see the
> email you sent in November to my old one.
>
> gpiod_to_irq() can be used in context other than driver probing, I'm
> worried existing users would not know how to handle it. Also: how come
> you can get the GPIO descriptor from the provider but its interrupts
> are not yet set up?

Hi Bartosz,

We would be only changing the error code here for gpio driver race 
condition.
Anything affected by this patch would have already been broken and might 
be returning
-ENXIO. There is a theoretical chance that a driver exists which uses 
gpiod_to_irq outside of
probe and affected by race condition. The more instructions between 
gpiod_get and gpiod_to_irq
the smaller the chance of hitting the race condition though. Also 
anything hitting the race condition
is broken right now and there hasn't been any issues reported so far. In 
any case that system is not
fixed by this patch, it is still a good idea to apply this patch since 
the proper fix is a lot more
invasive and probably might not be suitable for stable backporting. This 
minimal patch does
not make things worse.

I have sent a v5 for this patch with better commit message.

Thanks,
Shreeya Patel
>
> Bart
>
