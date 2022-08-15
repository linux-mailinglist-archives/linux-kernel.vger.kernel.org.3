Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5E9C6592865
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Aug 2022 06:08:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230302AbiHOEIT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 Aug 2022 00:08:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36774 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229668AbiHOEIR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Aug 2022 00:08:17 -0400
Received: from mail-pl1-x62b.google.com (mail-pl1-x62b.google.com [IPv6:2607:f8b0:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BAC8613F85;
        Sun, 14 Aug 2022 21:08:16 -0700 (PDT)
Received: by mail-pl1-x62b.google.com with SMTP id o3so5465460ple.5;
        Sun, 14 Aug 2022 21:08:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc;
        bh=8hntQHoZ9Gf9EapoG7OUHkjCCy7RUxfP8D6OFpiBLZE=;
        b=K0mPaT+Ne0sR56DQhZkB0bHdsZxqQQgYPtaXecGLmhyy89OMj07hkhf4ZjiHNxgMih
         2C/aj9sPPTJorIJmhN1KFwrfHO5IAmGLlaliYGD3OfwydJNc38oVL+il+TN/iNm4hevE
         3IrbI6fl4h05tlE9Vx0chJLS9IN9D5gltv/UZNERo4qsG8aj+WHDc+1fGZzthdBjoCFg
         X2b09EmknfCM4ejvoFzWn2GNl+540olVVmkE4dF1tnr16UHKVxHKgzGIDjl34Jq20g0u
         W1nsW9/EVC04ga9kSESpbx1j/9AhuFGYU+p7xsydnmJbiQ1CInBphFmwslnQX51zWBKR
         kPug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc;
        bh=8hntQHoZ9Gf9EapoG7OUHkjCCy7RUxfP8D6OFpiBLZE=;
        b=3MAL9fj/3TGBJ57bKPmGJChPyfIDyAzb6e5q4337YtwcAwa1uHJaBrc8PTejGQYp2v
         TTvsnP6gVKOTidHbPJzcH+Tq4HJvzUH8OWrV5rplTWHwEf7CPU0Wn/MXf1ompbunf3Ur
         wnepQOA2RcNcdWvjBZBcP74AE1i89SuX5cv1UKH/cuphqiGyNhGkLdSLDXPbX29yK6gM
         lIDgFpEg7MEuUQwDtogoU40K0EuLWD2gpxWuAQqSg4U/eXs3Jo6uqLzidDdstVtzsBNz
         EMIoXd9bCxE6cSEGgcZAvk2YbE864bkOIB3U5SkQoQv4mrLWkVlbLOGi7zE89TB+JJ+z
         OO0Q==
X-Gm-Message-State: ACgBeo3RJLjGal218N/M6dOLk1MGADtoh7syRuaskNtnMAdw7XmbGcZK
        EKOkDev6EXV0vQfZoEA7Pn4=
X-Google-Smtp-Source: AA6agR5ZjWehLH23fBf8T62x3uR4J1jayTxfMTMd8U2E8rJ59TUX5AIiemdUO1NZSKljU005g3Z6GA==
X-Received: by 2002:a17:902:e811:b0:170:8af3:824d with SMTP id u17-20020a170902e81100b001708af3824dmr14932403plg.26.1660536496248;
        Sun, 14 Aug 2022 21:08:16 -0700 (PDT)
Received: from [192.168.0.110] ([103.159.189.148])
        by smtp.gmail.com with ESMTPSA id f2-20020a170902ce8200b0015e8d4eb1d7sm6152838plg.33.2022.08.14.21.08.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 14 Aug 2022 21:08:15 -0700 (PDT)
Message-ID: <cc6560c3-98c2-bdb5-cfc3-b39d3675382e@gmail.com>
Date:   Mon, 15 Aug 2022 10:08:07 +0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.12.0
Subject: Re: [RFC PATCH] Soundwire: Initialize multi_link with fwnode props
Content-Language: en-US
To:     Greg KH <greg@kroah.com>
Cc:     alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        linux-acpi@vger.kernel.org,
        linux-kernel-mentees@lists.linuxfoundation.org,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        Daniel Scally <djrscally@gmail.com>,
        Vinod Koul <vkoul@kernel.org>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        Sanyog Kale <sanyog.r.kale@intel.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Bard Liao <yung-chuan.liao@linux.intel.com>,
        Len Brown <lenb@kernel.org>
References: <20220814080416.7531-1-khalid.masum.92@gmail.com>
 <YvjEIjXg7KxtTT/0@kroah.com>
From:   Khalid Masum <khalid.masum.92@gmail.com>
In-Reply-To: <YvjEIjXg7KxtTT/0@kroah.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/14/22 15:45, Greg KH wrote:
> On Sun, Aug 14, 2022 at 02:04:15PM +0600, Khalid Masum wrote:
>> According to the TODO, In sw_bus_master_add, bus->multi_link is to be
>> populated with properties from FW node props. Make this happen by
>> creating a new fwnode_handle flag FWNODE_FLAG_MULTI_LINKED and use
>> the flag to store the multi_link value from intel_link_startup. Use
>> this flag to initialize bus->multi_link.
>>
>> Signed-off-by: Khalid Masum <khalid.masum.92@gmail.com>
>> ---
>> I do not think adding a new flag for fwnode_handle is a good idea.
>> So, what would be the best way to initialize bus->multilink with
>> fwnode props?
>>
>>    -- Khalid Masum
>>
>>   drivers/soundwire/bus.c   | 4 ++--
>>   drivers/soundwire/intel.c | 1 +
>>   include/linux/fwnode.h    | 1 +
>>   3 files changed, 4 insertions(+), 2 deletions(-)
>>
>> diff --git a/drivers/soundwire/bus.c b/drivers/soundwire/bus.c
>> index a2bfb0434a67..80df1672c60b 100644
>> --- a/drivers/soundwire/bus.c
>> +++ b/drivers/soundwire/bus.c
>> @@ -74,9 +74,9 @@ int sdw_bus_master_add(struct sdw_bus *bus, struct device *parent,
>>   
>>   	/*
>>   	 * Initialize multi_link flag
>> -	 * TODO: populate this flag by reading property from FW node
>>   	 */
>> -	bus->multi_link = false;
>> +	bus->multi_link = (fwnode->flags & FWNODE_FLAG_MULTI_LINKED)
>> +		== FWNODE_FLAG_MULTI_LINKED;
>>   	if (bus->ops->read_prop) {
>>   		ret = bus->ops->read_prop(bus);
>>   		if (ret < 0) {
>> diff --git a/drivers/soundwire/intel.c b/drivers/soundwire/intel.c
>> index 505c5ef061e3..034d1c523ddf 100644
>> --- a/drivers/soundwire/intel.c
>> +++ b/drivers/soundwire/intel.c
>> @@ -1347,6 +1347,7 @@ int intel_link_startup(struct auxiliary_device *auxdev)
>>   		 */
>>   		bus->multi_link = true;
>>   		bus->hw_sync_min_links = 1;
>> +		dev->fwnode->flags |= FWNODE_FLAG_MULTI_LINKED;
>>   	}
>>   
>>   	/* Initialize shim, controller */
>> diff --git a/include/linux/fwnode.h b/include/linux/fwnode.h
>> index 9a81c4410b9f..446a52744953 100644
>> --- a/include/linux/fwnode.h
>> +++ b/include/linux/fwnode.h
>> @@ -32,6 +32,7 @@ struct device;
>>   #define FWNODE_FLAG_NOT_DEVICE			BIT(1)
>>   #define FWNODE_FLAG_INITIALIZED			BIT(2)
>>   #define FWNODE_FLAG_NEEDS_CHILD_BOUND_ON_ADD	BIT(3)
>> +#define FWNODE_FLAG_MULTI_LINKED		BIT(4)
> 
> What does this commit actually change?

The new flag will lets us save if the device has multilink in 
fwnode_handle whenever needed.
Then for soundwire/intel, save the multi_link flag into fwnode during 
startup.
Later at master_add, as written in todo, initialize the multilink flag 
with fwnode's flag property.

> 
> Did you test this on real hardware?

I did not test this on real hardware.
> 
> thanks,
> 
> greg k-h

thanks,
  -- Khalid Masum

