Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2E2EA47D37E
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Dec 2021 15:18:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245654AbhLVOS4 convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Wed, 22 Dec 2021 09:18:56 -0500
Received: from aposti.net ([89.234.176.197]:44230 "EHLO aposti.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S245647AbhLVOSz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Dec 2021 09:18:55 -0500
Date:   Wed, 22 Dec 2021 14:18:46 +0000
From:   Paul Cercueil <paul@crapouillou.net>
Subject: Re: [PATCH 2/2] hwmon: Add "label" attribute
To:     Guenter Roeck <linux@roeck-us.net>
Cc:     Jean Delvare <jdelvare@suse.com>, Rob Herring <robh+dt@kernel.org>,
        linux-hwmon@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Cosmin Tanislav <cosmin.tanislav@analog.com>
Message-Id: <A3TI4R.0KWPRNVE7E7M3@crapouillou.net>
In-Reply-To: <78620358-737e-368e-e5f5-82a673adf26a@roeck-us.net>
References: <20211221175029.144906-1-paul@crapouillou.net>
        <20211221175029.144906-3-paul@crapouillou.net>
        <78620358-737e-368e-e5f5-82a673adf26a@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1; format=flowed
Content-Transfer-Encoding: 8BIT
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Guenter,

Comments noted, thanks. I'll send a V2 later today.

Cheers,
-Paul


Le mar., déc. 21 2021 at 10:17:03 -0800, Guenter Roeck 
<linux@roeck-us.net> a écrit :
> On 12/21/21 9:50 AM, Paul Cercueil wrote:
>> If a label is defined in the device tree for this device add that
>> to the device specific attributes. This is useful for userspace to
>> be able to identify an individual device when multiple identical
>> chips are present in the system.
>> 
> 
> This is an ABI change which needs to be documented in
> Documentation/hwmon/sysfs-interface.rst.
> 
>> Signed-off-by: Paul Cercueil <paul@crapouillou.net>
>> Tested-by: Cosmin Tanislav <cosmin.tanislav@analog.com>
>> ---
>>   drivers/hwmon/hwmon.c | 22 +++++++++++++++++++++-
>>   1 file changed, 21 insertions(+), 1 deletion(-)
>> 
>> diff --git a/drivers/hwmon/hwmon.c b/drivers/hwmon/hwmon.c
>> index 3501a3ead4ba..15826260a463 100644
>> --- a/drivers/hwmon/hwmon.c
>> +++ b/drivers/hwmon/hwmon.c
>> @@ -71,8 +71,23 @@ name_show(struct device *dev, struct 
>> device_attribute *attr, char *buf)
>>   }
>>   static DEVICE_ATTR_RO(name);
>>   +static ssize_t
>> +label_show(struct device *dev, struct device_attribute *attr, char 
>> *buf)
>> +{
>> +	const char *label;
>> +	int ret;
>> +
>> +	ret = device_property_read_string(dev, "label", &label);
> 
> Requires "#include <linux/property.h>". Also, reading and verifying 
> the label
> each time it is read is excessive. More on that see below.
> 
>> +	if (ret < 0)
>> +		return ret;
>> +
>> +	return sysfs_emit(buf, "%s\n", label);
>> +}
>> +static DEVICE_ATTR_RO(label);
>> +
>>   static struct attribute *hwmon_dev_attrs[] = {
>>   	&dev_attr_name.attr,
>> +	&dev_attr_label.attr,
>>   	NULL
>>   };
>>   @@ -81,7 +96,12 @@ static umode_t 
>> hwmon_dev_name_is_visible(struct kobject *kobj,
> 
> That function name is no longer appropriate and should be changed to
> something like hwmon_dev_attr_is_visible.
> 
>>   {
>>   	struct device *dev = kobj_to_dev(kobj);
>>   -	if (to_hwmon_device(dev)->name == NULL)
>> +	if (attr == &dev_attr_name.attr &&
>> +	    to_hwmon_device(dev)->name == NULL)
> 
> Unnecessary continuation line.
> 
>> +		return 0;
>> +
>> +	if (attr == &dev_attr_label.attr &&
>> +	    !device_property_present(dev, "label"))
> 
> If the property is present but not a string, each read of "label" 
> would
> return a runtime error. I don't like that. I would suggest to store
> a pointer to the label in struct hwmon_device, set it during 
> registration
> (eg by using devm_strdup() if it is defined), and use
> 
> 	if (attr == &dev_attr_label.attr && to_hwmon_device(dev)->label == 
> NULL)
> 		return 0;
> 
> to check if it is present.
> 
>>   		return 0;
>>     	return attr->mode;
>> 
> 


