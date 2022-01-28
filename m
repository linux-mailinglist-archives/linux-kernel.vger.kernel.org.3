Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A160F49FE8A
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jan 2022 17:59:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350369AbiA1Q7t (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Jan 2022 11:59:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49986 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245576AbiA1Q7s (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Jan 2022 11:59:48 -0500
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e3e3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1CD50C061714;
        Fri, 28 Jan 2022 08:59:48 -0800 (PST)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: usama.anjum)
        with ESMTPSA id 660761F46376
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1643389187;
        bh=zsFOqNJXl1POjN770OSH/AQ4HY1FlkWlk167Y5ylJlI=;
        h=Date:Cc:Subject:To:References:From:In-Reply-To:From;
        b=LgxMYS1GnF1HKHlWvC7pamz/kp8UyaHru3kXZzji+FL/DZ06HizwWldfi/lB17xts
         3yDjqhn/H5jxjTl3Rs+Kv6dn2ohhqI0y65vTA0rDy1HbUtY8UEYXi9dTJ0KnTPTtt4
         kzwUQZBbbg1bwb7j1apphwPTQzJyg7TYQEjSioqC2NKGBS+Q7R/HjuJiVDySyRewJM
         g/JdAPTaqDbXaTcl+krXqhlGrSThU/YYsnwHCTLzoqgffkswZmAVIjHFMPOFBI1Gvr
         lxKSOf+PmopiNVbRiQYQrU5v4dFcraIEbSV5iJkVO5yefYHsyGVE/SsF810kafr0QD
         tAwajJvnaBvPg==
Message-ID: <d7686623-c5ab-ce2a-386c-f35ec167ca81@collabora.com>
Date:   Fri, 28 Jan 2022 21:59:39 +0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Cc:     usama.anjum@collabora.com, kernel@collabora.com,
        kernel-janitors@vger.kernel.org, linux-hwmon@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] hwmon: Remove checks for validity of dev
Content-Language: en-US
To:     Guenter Roeck <linux@roeck-us.net>,
        Jean Delvare <jdelvare@suse.com>
References: <20220128125913.1291533-1-usama.anjum@collabora.com>
 <6c0335ca-eb16-b4de-1f2c-8bdc82219b57@roeck-us.net>
From:   Muhammad Usama Anjum <usama.anjum@collabora.com>
In-Reply-To: <6c0335ca-eb16-b4de-1f2c-8bdc82219b57@roeck-us.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/28/22 8:05 PM, Guenter Roeck wrote:
> On 1/28/22 04:59, Muhammad Usama Anjum wrote:
>> dev is being dereferenced in device_property_present() which means that
>> it is valid. Don't check its validity again and simplify the code.
>>
>> Signed-off-by: Muhammad Usama Anjum <usama.anjum@collabora.com>
>> ---
>>   drivers/hwmon/hwmon.c | 4 ++--
>>   1 file changed, 2 insertions(+), 2 deletions(-)
>>
>> diff --git a/drivers/hwmon/hwmon.c b/drivers/hwmon/hwmon.c
>> index e36ea82da1474..aec32abd0a89f 100644
>> --- a/drivers/hwmon/hwmon.c
>> +++ b/drivers/hwmon/hwmon.c
>> @@ -822,7 +822,7 @@ __hwmon_device_register(struct device *dev, const
>> char *name, void *drvdata,
>>       hwdev->name = name;
>>       hdev->class = &hwmon_class;
>>       hdev->parent = dev;
>> -    hdev->of_node = dev ? dev->of_node : NULL;
>> +    hdev->of_node = dev->of_node;
>>       hwdev->chip = chip;
>>       dev_set_drvdata(hdev, drvdata);
>>       dev_set_name(hdev, HWMON_ID_FORMAT, id);
>> @@ -834,7 +834,7 @@ __hwmon_device_register(struct device *dev, const
>> char *name, void *drvdata,
>>         INIT_LIST_HEAD(&hwdev->tzdata);
>>   -    if (dev && dev->of_node && chip && chip->ops->read &&
>> +    if (dev->of_node && chip && chip->ops->read &&
>>           chip->info[0]->type == hwmon_chip &&
>>           (chip->info[0]->config[0] & HWMON_C_REGISTER_TZ)) {
>>           err = hwmon_thermal_register_sensors(hdev);
> 
> Wrong fix, sorry. While I would love to make dev mandatory, the function
> is called with dev == NULL from at least one place, and the check is
> (still)
> needed. Even if/when it is removed we would have to add an early check
> and return -EINVAL if it is NULL.
> 
Thank you for the reply. I've looked at the code again. You are correct.

> Guenter
