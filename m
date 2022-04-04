Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8CBF14F2044
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Apr 2022 01:31:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230479AbiDDXdO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Apr 2022 19:33:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33058 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229587AbiDDXdJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Apr 2022 19:33:09 -0400
Received: from gateway33.websitewelcome.com (gateway33.websitewelcome.com [192.185.145.4])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 096034CD66
        for <linux-kernel@vger.kernel.org>; Mon,  4 Apr 2022 16:31:11 -0700 (PDT)
Received: from cm14.websitewelcome.com (cm14.websitewelcome.com [100.42.49.7])
        by gateway33.websitewelcome.com (Postfix) with ESMTP id D8A597C8B
        for <linux-kernel@vger.kernel.org>; Mon,  4 Apr 2022 18:31:10 -0500 (CDT)
Received: from 162-215-252-75.unifiedlayer.com ([208.91.199.152])
        by cmsmtp with SMTP
        id bWAAnqaksHnotbWAAnancr; Mon, 04 Apr 2022 18:31:10 -0500
X-Authority-Reason: nr=8
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=roeck-us.net; s=default; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:Subject:From:References:Cc:To:MIME-Version:Date:Message-ID:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=8UTMkSC4goCDN7Y9zQLqzJ9tlrWrth6oiQN3zX1i1fU=; b=Vtj+RqYCDZ1ROYBVFh560i4AvW
        55/Vbuq3lesotnKaAm6/JgviZLubeg+f+8omGiDgOyk6QeO/FuBwTJasFPBDhMp35veMfAeIthY75
        TGc863m5PcZi4QaGLugOSdHAb750m9uMtbYkqAOcLtG0j1WE37Qlb2h3yzmePJ0iDuMiyXwF1rduH
        aDSEojU7QizKBnBfNYUbcSiaRI1hjpoQ7NToYMbBzgcyZwhooCKitMTrt7oGGmzzMrVRi6rzIeQnc
        hK9i8NG86rAhsh9bs56eZatpJI3BMoyvklzz8x5G5yVsaf3ltN1JU6Ghk6x8eMfiPZzpPrSx7/FR0
        bR+5Uiug==;
Received: from 108-223-40-66.lightspeed.sntcca.sbcglobal.net ([108.223.40.66]:54726)
        by bh-25.webhostbox.net with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <linux@roeck-us.net>)
        id 1nbWAA-002NJf-5z; Mon, 04 Apr 2022 23:31:10 +0000
Message-ID: <25517c15-30f6-fbc5-5731-44c41ef904c7@roeck-us.net>
Date:   Mon, 4 Apr 2022 16:31:08 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Content-Language: en-US
To:     Tom Rix <trix@redhat.com>, Michael Walle <michael@walle.cc>,
        Xu Yilun <yilun.xu@intel.com>,
        Jean Delvare <jdelvare@suse.com>, Andrew Lunn <andrew@lunn.ch>,
        Heiner Kallweit <hkallweit1@gmail.com>,
        Russell King <linux@armlinux.org.uk>,
        "David S . Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>
Cc:     linux-hwmon@vger.kernel.org, linux-kernel@vger.kernel.org,
        netdev@vger.kernel.org, David Laight <David.Laight@ACULAB.COM>
References: <20220404184340.3973329-1-michael@walle.cc>
 <20220404184340.3973329-2-michael@walle.cc>
 <428c28e4-87cc-50a4-ef13-41ae36702a84@redhat.com>
From:   Guenter Roeck <linux@roeck-us.net>
Subject: Re: [PATCH v3 1/2] hwmon: introduce hwmon_sanitize_name()
In-Reply-To: <428c28e4-87cc-50a4-ef13-41ae36702a84@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - bh-25.webhostbox.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - roeck-us.net
X-BWhitelist: no
X-Source-IP: 108.223.40.66
X-Source-L: No
X-Exim-ID: 1nbWAA-002NJf-5z
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: 108-223-40-66.lightspeed.sntcca.sbcglobal.net [108.223.40.66]:54726
X-Source-Auth: linux@roeck-us.net
X-Email-Count: 3
X-Source-Cap: cm9lY2s7YWN0aXZzdG07YmgtMjUud2ViaG9zdGJveC5uZXQ=
X-Local-Domain: yes
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_PASS,SPF_SOFTFAIL,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/4/22 16:14, Tom Rix wrote:
> 
> On 4/4/22 11:43 AM, Michael Walle wrote:
>> More and more drivers will check for bad characters in the hwmon name
>> and all are using the same code snippet. Consolidate that code by adding
>> a new hwmon_sanitize_name() function.
>>
>> Signed-off-by: Michael Walle <michael@walle.cc>
>> ---
>>   Documentation/hwmon/hwmon-kernel-api.rst | 16 ++++++++
>>   drivers/hwmon/hwmon.c                    | 50 ++++++++++++++++++++++++
>>   include/linux/hwmon.h                    |  3 ++
>>   3 files changed, 69 insertions(+)
>>
>> diff --git a/Documentation/hwmon/hwmon-kernel-api.rst b/Documentation/hwmon/hwmon-kernel-api.rst
>> index c41eb6108103..e2975d5caf34 100644
>> --- a/Documentation/hwmon/hwmon-kernel-api.rst
>> +++ b/Documentation/hwmon/hwmon-kernel-api.rst
>> @@ -50,6 +50,10 @@ register/unregister functions::
>>     void devm_hwmon_device_unregister(struct device *dev);
>> +  char *hwmon_sanitize_name(const char *name);
>> +
>> +  char *devm_hwmon_sanitize_name(struct device *dev, const char *name);
>> +
>>   hwmon_device_register_with_groups registers a hardware monitoring device.
>>   The first parameter of this function is a pointer to the parent device.
>>   The name parameter is a pointer to the hwmon device name. The registration
>> @@ -95,6 +99,18 @@ All supported hwmon device registration functions only accept valid device
>>   names. Device names including invalid characters (whitespace, '*', or '-')
>>   will be rejected. The 'name' parameter is mandatory.
>> +If the driver doesn't use a static device name (for example it uses
>> +dev_name()), and therefore cannot make sure the name only contains valid
>> +characters, hwmon_sanitize_name can be used. This convenience function
>> +will duplicate the string and replace any invalid characters with an
>> +underscore. It will allocate memory for the new string and it is the
>> +responsibility of the caller to release the memory when the device is
>> +removed.
>> +
>> +devm_hwmon_sanitize_name is the resource managed version of
>> +hwmon_sanitize_name; the memory will be freed automatically on device
>> +removal.
>> +
>>   Using devm_hwmon_device_register_with_info()
>>   --------------------------------------------
>> diff --git a/drivers/hwmon/hwmon.c b/drivers/hwmon/hwmon.c
>> index 989e2c8496dd..cc4a16a466a0 100644
>> --- a/drivers/hwmon/hwmon.c
>> +++ b/drivers/hwmon/hwmon.c
>> @@ -1057,6 +1057,56 @@ void devm_hwmon_device_unregister(struct device *dev)
>>   }
>>   EXPORT_SYMBOL_GPL(devm_hwmon_device_unregister);
>> +static char *__hwmon_sanitize_name(struct device *dev, const char *old_name)
>> +{
>> +    char *name, *p;
>> +
>> +    if (dev)
>> +        name = devm_kstrdup(dev, old_name, GFP_KERNEL);
>> +    else
>> +        name = kstrdup(old_name, GFP_KERNEL);
>> +    if (!name)
>> +        return NULL;
> should return ERR_PTR(-ENOMEM)

In general this is a matter of opinion, but other hwmon functions
return  ERR_PTR(-ENOMEM), so I agree here.

>> +
>> +    for (p = name; *p; p++)
>> +        if (hwmon_is_bad_char(*p))
>> +            *p = '_';
>> +
>> +    return name;
>> +}
>> +
>> +/**
>> + * hwmon_sanitize_name - Replaces invalid characters in a hwmon name
>> + * @name: NUL-terminated name
>> + *
>> + * Allocates a new string where any invalid characters will be replaced
>> + * by an underscore. It is the responsibility of the caller to release
>> + * the memory.
>> + *
>> + * Returns newly allocated name or %NULL in case of error.
>> + */
>> +char *hwmon_sanitize_name(const char *name)
>> +{
>> +    return __hwmon_sanitize_name(NULL, name);
>> +}
>> +EXPORT_SYMBOL_GPL(hwmon_sanitize_name);
>> +
>> +/**
>> + * devm_hwmon_sanitize_name - resource managed hwmon_sanitize_name()
>> + * @dev: device to allocate memory for
>> + * @name: NUL-terminated name
>> + *
>> + * Allocates a new string where any invalid characters will be replaced
>> + * by an underscore.
>> + *
>> + * Returns newly allocated name or %NULL in case of error.
>> + */
>> +char *devm_hwmon_sanitize_name(struct device *dev, const char *name)
>> +{
>> +    return __hwmon_sanitize_name(dev, name);
> Should have a (!dev) check.

... and return ERR_PTR(-EINVAL) if it is NULL, to match
hwmon registration functions.

>> +}
>> +EXPORT_SYMBOL_GPL(devm_hwmon_sanitize_name);
>> +
>>   static void __init hwmon_pci_quirks(void)
>>   {
>>   #if defined CONFIG_X86 && defined CONFIG_PCI
>> diff --git a/include/linux/hwmon.h b/include/linux/hwmon.h
>> index eba380b76d15..4efaf06fd2b8 100644
>> --- a/include/linux/hwmon.h
>> +++ b/include/linux/hwmon.h
>> @@ -461,6 +461,9 @@ void devm_hwmon_device_unregister(struct device *dev);
>>   int hwmon_notify_event(struct device *dev, enum hwmon_sensor_types type,
>>                  u32 attr, int channel);
>> +char *hwmon_sanitize_name(const char *name);
>> +char *devm_hwmon_sanitize_name(struct device *dev, const char *name);
>> +
>>   /**
>>    * hwmon_is_bad_char - Is the char invalid in a hwmon name
> 
> This still needed in *.h ?
> 

Yes, because it is used by out-of-tree drivers. We can only move
that into hwmon.c after all users are gone.

Guenter
