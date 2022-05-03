Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BC4BA517CD4
	for <lists+linux-kernel@lfdr.de>; Tue,  3 May 2022 07:37:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231442AbiECFiz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 May 2022 01:38:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53998 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231342AbiECFiw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 May 2022 01:38:52 -0400
Received: from smtp2.axis.com (smtp2.axis.com [195.60.68.18])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 12616193EC;
        Mon,  2 May 2022 22:35:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=axis.com; q=dns/txt; s=axis-central1; t=1651556119;
  x=1683092119;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=FDNCOyDkPsbFfbn+trYTC4isEG90cns5AJa5K9K08yk=;
  b=UXLHE8LxsEW3TuBKebqA/hNGJaxSRZxHpujgAypBryPAjW4CR8nTPIVP
   SFKOH7rhZjiFiYqqjIcWA/KSC6GhuVU+rUjpC5Mz+xxT0z7Xh0S1AovcY
   lAG/3LbkvIQHthYFCkXODcO8gssnA7B7laoRNkUFfBB8iV6zG3mnQRomy
   fnv4yYe6gS3Nopmb5ucgZVymWOF3DM5MSmPzW6z9cYxsIpJfm7bnmhA7P
   kO3z/+JwxZRSlCuAebV1qjlVd4Ew9/1wvkaUGxwiCSJyCuNFoO3aySyOC
   P5nYXkMGlC/ClvkcsZS9lMjmoN4oM7cIwAb8Yqd8tE5sjLCezBI4Imrzt
   Q==;
Message-ID: <3dc9a0e3-124e-759e-8229-9088c079cecf@axis.com>
Date:   Tue, 3 May 2022 07:35:15 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.2
Subject: Re: [PATCH v2] hwmon: (tmp401) Add of_match_table
Content-Language: en-US
To:     Guenter Roeck <linux@roeck-us.net>,
        Vincent Whitchurch <Vincent.Whitchurch@axis.com>
CC:     Camel Guo <Camel.Guo@axis.com>, Jean Delvare <jdelvare@suse.com>,
        "linux-hwmon@vger.kernel.org" <linux-hwmon@vger.kernel.org>,
        kernel <kernel@axis.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <20220502091942.1083067-1-camel.guo@axis.com>
 <a2e81680-e62c-dddd-ee58-6f5aa3664d2f@roeck-us.net>
 <20220502145800.GA21695@axis.com>
 <25e2dc90-ab01-ab19-ffde-1b709dbebad4@roeck-us.net>
From:   Camel Guo <camelg@axis.com>
In-Reply-To: <25e2dc90-ab01-ab19-ffde-1b709dbebad4@roeck-us.net>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.0.5.60]
X-ClientProxiedBy: se-mail07w.axis.com (10.20.40.13) To se-mail03w.axis.com
 (10.20.40.9)
X-Spam-Status: No, score=-6.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/2/22 18:16, Guenter Roeck wrote:
> On 5/2/22 07:58, Vincent Whitchurch wrote:
>> On Mon, May 02, 2022 at 03:57:50PM +0200, Guenter Roeck wrote:
>>> On 5/2/22 02:19, Camel Guo wrote:
>>>> When tmp401 is built as kernel module, it won't be automatically loaded
>>>> even through there is a device node in the devicetree. e.g:
>>>>       i2c {
>>>>         #address-cells = <1>;
>>>>         #size-cells = <0>;
>>>>
>>>>         sensor@4c {
>>>>           compatible = "ti,tmp401";
>>>>           reg = <0x4c>;
>>>>         };
>>>>       };
>>>> In order to make sure it is loaded automatically, this commit adds
>>>> of_match_table for tmp401.
>>>>
>>>
>>> As mentioned before, historically i2c devices would instantiate based
>>> on the i2c match table. You are claiming that this is no longer the case.
>> 
>> Note that while the commit message in the first version of the patch did
>> wrongly claim that probe would not work without the of_match_table, this
>> corrected description in v2 does mention the actual problem: that the
>> module will not be automatically loaded without the of_match_table.  (If
>> the module is loaded manually or the driver is built-in to the kernel,
>> there is no problem.)
>> 
> 
> No, it doesn't. None of the information you provided below is mentioned
> in the description, but is essential to understand your patch and the
> reason for it.
> 
>> See commit 72fc64c68decf119466 ("hwmon: (tmp103) Add OF device ID
>> table") or commit 98b16a09861aa85d6 ("hwmon: (max31785) Add OF device ID
>> table") for similar changes to other hwmon drivers.
>> 
> 
> Those commits provide a valid and acceptable explanation.

Now, I just copied this commit message.

> 
>> The potential future change mentioned in the commit messages of
>> 72fc64c68decf119466 and 98b16a09861aa85d6 happened in commit
>> af503716ac1444db61d80 ("i2c: core: report OF style module alias for
>> devices registered via OF").  The commit message of
>> af503716ac1444db61d80 has a lot of details about the change being made,
>> and while it says that all in-tree drivers had been converted, it looks
>> like some of them, like tmp401, were missed.
>> 
> 
> And this is the missing link. If you provide that information
> in the commit log I have no problems. Please also provide a Fixes:
> tag.
> 
> Fixes: af503716ac14 ("i2c: core: report OF style module alias for 
> devices registered via OF")

It is added in v3

> 
> Thanks,
> Guenter
> 
>>> The above is no evidence; that would require a log output on an affected
>>> system showing that the sensors are not or no longer longer instantiated.
>> 
>> A log would simply show nothing happening so that's probably not going
>> to be that useful, but here is what the modaliases look like.  As you
>> can see, the modalias of the device in sysfs does not match any of the
>> alias patterns of the module without this patch:
>> 
>> $ cat /sys/bus/i2c/devices/4-004c/modalias
>> of:Ntemperature-sensorT<NULL>Cti,tmp431
>> 
>> modinfo without this patch:
>> 
>> $ modinfo ./modules/lib/modules/5.18.0-rc1/kernel/drivers/hwmon/tmp401.ko
>> filename:       /storage2/femfyra/linux-2.6/.roadtest/./modules/lib/modules/5.18.0-rc1/kernel/drivers/hwmon/tmp401.ko
>> license:        GPL
>> description:    Texas Instruments TMP401 temperature sensor driver
>> author:         Hans de Goede <hdegoede@redhat.com>
>> alias:          i2c:tmp435
>> alias:          i2c:tmp432
>> alias:          i2c:tmp431
>> alias:          i2c:tmp411
>> alias:          i2c:tmp401
>> depends:
>> intree:         Y
>> name:           tmp401
>> vermagic:       5.18.0-rc1 mod_unload
>> 
>> modinfo after this patch:
>> 
>> $ modinfo ./modules/lib/modules/5.18.0-rc1/kernel/drivers/hwmon/tmp401.ko
>> filename:       /storage2/femfyra/linux-2.6/./.roadtest/modules/lib/modules/5.18.0-rc1/kernel/drivers/hwmon/tmp401.ko
>> license:        GPL
>> description:    Texas Instruments TMP401 temperature sensor driver
>> author:         Hans de Goede <hdegoede@redhat.com>
>> alias:          i2c:tmp435
>> alias:          i2c:tmp432
>> alias:          i2c:tmp431
>> alias:          i2c:tmp411
>> alias:          i2c:tmp401
>> alias:          of:N*T*Cti,tmp435C*
>> alias:          of:N*T*Cti,tmp435
>> alias:          of:N*T*Cti,tmp432C*
>> alias:          of:N*T*Cti,tmp432
>> alias:          of:N*T*Cti,tmp431C*
>> alias:          of:N*T*Cti,tmp431
>> alias:          of:N*T*Cti,tmp411C*
>> alias:          of:N*T*Cti,tmp411
>> alias:          of:N*T*Cti,tmp401C*
>> alias:          of:N*T*Cti,tmp401
>> depends:
>> intree:         Y
>> name:           tmp401
>> vermagic:       5.18.0-rc1 mod_unload
> 

All commits have been fixed in v3, please review that one instead.
