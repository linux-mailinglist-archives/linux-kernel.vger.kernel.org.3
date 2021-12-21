Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 75D9647C634
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Dec 2021 19:17:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241127AbhLUSRJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Dec 2021 13:17:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43654 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241118AbhLUSRI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Dec 2021 13:17:08 -0500
Received: from mail-oi1-x235.google.com (mail-oi1-x235.google.com [IPv6:2607:f8b0:4864:20::235])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A5926C061574;
        Tue, 21 Dec 2021 10:17:07 -0800 (PST)
Received: by mail-oi1-x235.google.com with SMTP id j124so745770oih.12;
        Tue, 21 Dec 2021 10:17:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:to:cc:references:from:subject:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=wYb/gvyC6xUW4UwiSTV6/Lkd+rMWVTOP0ujZ+LU7gVo=;
        b=PlThvNOfWd5q7/Tz/NEvEyjRVbbMrbTLrvRCZfkGlnYOpz/ksYrsDR+X4CgHYLOYfr
         Jg73Kg4TIkfMtzubVjj9fKJ20yPbYLbwuzCrfDOb/2h4OSoccxuRq8qZsqXmetpXj6Ci
         U9cM4s0v1irL9MUAkV2dQf1+TdfylczV/vkV90WhYsHQM4XIDJvCVrUdv13WV5tUo9Ij
         ymi9lbWRCNvHYhbJb6z3PKPTHIr7YIYvbp+cwFDI/7AHoGNT2LuGwtcF4s66ByYSXlx9
         b6mVto71lf16qP8VPfQr4A5fNwOug+BFcYChpBv7KfDr6t0td+TzdbAbng0Tqp/ybaQr
         VUYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:to:cc:references:from:subject:message-id
         :date:user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=wYb/gvyC6xUW4UwiSTV6/Lkd+rMWVTOP0ujZ+LU7gVo=;
        b=UaKGc8SI7rYxiJowfuFuMbUc5Y0so7uN40HIbYOzhgYzYx5rcTSjmepWiqy/N7fpX3
         OR9ulq7O0BcDnZgsqJSYo5ax6F6Tn+75UtfUaTWefzKE4eJz+iLPovAkctY15y3xBMNT
         idoXfaTMzqVGUTTx9LHpNq52uNlkxelVxFFAfIs0dQQeWwYKG3hxH+uu0ZnbAXdGyfMt
         0yZOuWN0hxCgUpNFUMBK4c7r6GoBxLHZw2G8kQLlBA9NjMDO13TcZO4lp2ifOsCiewru
         +CMmKJtkwV9KYL71CNGTI/sMLyQXMoU5FKBFEi5UGQvCDvYmX85BySyDLi0tXBiiTZuK
         cExg==
X-Gm-Message-State: AOAM5324fsr2YkC/0a19ouVfwdCVHKfUKkfyC7xWp9CgJpR23Lby96aJ
        rCMuaUVjIDnUHJM3km46VV0Kj/eIcDE=
X-Google-Smtp-Source: ABdhPJxNrwpxMo7bh7XFGcf0W+Cpt7uyR+XY6AWtDjLH4pQdSMr51guxzy1qypIjO6QuMnpijT488Q==
X-Received: by 2002:aca:a993:: with SMTP id s141mr1039853oie.87.1640110627001;
        Tue, 21 Dec 2021 10:17:07 -0800 (PST)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id z8sm3605223oot.7.2021.12.21.10.17.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 21 Dec 2021 10:17:05 -0800 (PST)
Sender: Guenter Roeck <groeck7@gmail.com>
To:     Paul Cercueil <paul@crapouillou.net>,
        Jean Delvare <jdelvare@suse.com>,
        Rob Herring <robh+dt@kernel.org>
Cc:     linux-hwmon@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Cosmin Tanislav <cosmin.tanislav@analog.com>
References: <20211221175029.144906-1-paul@crapouillou.net>
 <20211221175029.144906-3-paul@crapouillou.net>
From:   Guenter Roeck <linux@roeck-us.net>
Subject: Re: [PATCH 2/2] hwmon: Add "label" attribute
Message-ID: <78620358-737e-368e-e5f5-82a673adf26a@roeck-us.net>
Date:   Tue, 21 Dec 2021 10:17:03 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <20211221175029.144906-3-paul@crapouillou.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/21/21 9:50 AM, Paul Cercueil wrote:
> If a label is defined in the device tree for this device add that
> to the device specific attributes. This is useful for userspace to
> be able to identify an individual device when multiple identical
> chips are present in the system.
> 

This is an ABI change which needs to be documented in
Documentation/hwmon/sysfs-interface.rst.

> Signed-off-by: Paul Cercueil <paul@crapouillou.net>
> Tested-by: Cosmin Tanislav <cosmin.tanislav@analog.com>
> ---
>   drivers/hwmon/hwmon.c | 22 +++++++++++++++++++++-
>   1 file changed, 21 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/hwmon/hwmon.c b/drivers/hwmon/hwmon.c
> index 3501a3ead4ba..15826260a463 100644
> --- a/drivers/hwmon/hwmon.c
> +++ b/drivers/hwmon/hwmon.c
> @@ -71,8 +71,23 @@ name_show(struct device *dev, struct device_attribute *attr, char *buf)
>   }
>   static DEVICE_ATTR_RO(name);
>   
> +static ssize_t
> +label_show(struct device *dev, struct device_attribute *attr, char *buf)
> +{
> +	const char *label;
> +	int ret;
> +
> +	ret = device_property_read_string(dev, "label", &label);

Requires "#include <linux/property.h>". Also, reading and verifying the label
each time it is read is excessive. More on that see below.

> +	if (ret < 0)
> +		return ret;
> +
> +	return sysfs_emit(buf, "%s\n", label);
> +}
> +static DEVICE_ATTR_RO(label);
> +
>   static struct attribute *hwmon_dev_attrs[] = {
>   	&dev_attr_name.attr,
> +	&dev_attr_label.attr,
>   	NULL
>   };
>   
> @@ -81,7 +96,12 @@ static umode_t hwmon_dev_name_is_visible(struct kobject *kobj,

That function name is no longer appropriate and should be changed to
something like hwmon_dev_attr_is_visible.

>   {
>   	struct device *dev = kobj_to_dev(kobj);
>   
> -	if (to_hwmon_device(dev)->name == NULL)
> +	if (attr == &dev_attr_name.attr &&
> +	    to_hwmon_device(dev)->name == NULL)

Unnecessary continuation line.

> +		return 0;
> +
> +	if (attr == &dev_attr_label.attr &&
> +	    !device_property_present(dev, "label"))

If the property is present but not a string, each read of "label" would
return a runtime error. I don't like that. I would suggest to store
a pointer to the label in struct hwmon_device, set it during registration
(eg by using devm_strdup() if it is defined), and use

	if (attr == &dev_attr_label.attr && to_hwmon_device(dev)->label == NULL)
		return 0;

to check if it is present.

>   		return 0;
>   
>   	return attr->mode;
> 

