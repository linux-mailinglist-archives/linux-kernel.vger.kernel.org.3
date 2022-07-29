Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0B6905851E2
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Jul 2022 16:58:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236837AbiG2O54 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Jul 2022 10:57:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58696 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236658AbiG2O5y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Jul 2022 10:57:54 -0400
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A0E662B279
        for <linux-kernel@vger.kernel.org>; Fri, 29 Jul 2022 07:57:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1659106673; x=1690642673;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=kpXPXDEKt8EWRIsz7zZNVRA+jmEVLhwG5JCEoBZEhYw=;
  b=TcReBE4Wt9RYjj92GDcpDbqK3WSaGsp+IhQRFBNUpwv7LFs+++3XTUrq
   stAZpwW+/Ifpgu19fqraDgzFEEIbopLOquPuG/uve/bEodGKVgmZn8Olr
   xIbgB8Qh8e3MZsRmp9Oe3Ti/B5Ra5hK4C/XEr+25RnRg+3wnLRDVyabyl
   VvPr6KCPZbFdaW/r4u7lw7kDZ/ZDtACA9/r7R6C6JeEio3tgO0ksHW0SJ
   iVPlIomji8kybSW01Bs4+k0gTsKq6KIcf5424vA5sMFJm5RExKfH1mUfH
   pGmA2ZPgtq0T6PPo1Q4irn/Es+sZW+9AabIv6EWZue+MO9K88NctJU5kt
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10423"; a="287536440"
X-IronPort-AV: E=Sophos;i="5.93,201,1654585200"; 
   d="scan'208";a="287536440"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Jul 2022 07:57:53 -0700
X-IronPort-AV: E=Sophos;i="5.93,201,1654585200"; 
   d="scan'208";a="604985399"
Received: from kaholo-mobl.amr.corp.intel.com (HELO [10.212.97.86]) ([10.212.97.86])
  by fmsmga007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Jul 2022 07:57:52 -0700
Message-ID: <cfacb124-a9ff-0a93-8f92-93d164b15966@linux.intel.com>
Date:   Fri, 29 Jul 2022 09:57:52 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Firefox/91.0 Thunderbird/91.11.0
Subject: Re: [PATCH 2/5] soundwire: sysfs: cleanup the logic for creating the
 dp0 sysfs attributes
Content-Language: en-US
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        Vinod Koul <vkoul@kernel.org>,
        Sanyog Kale <sanyog.r.kale@intel.com>,
        Bard Liao <yung-chuan.liao@linux.intel.com>
References: <20220729135041.2285908-1-gregkh@linuxfoundation.org>
 <20220729135041.2285908-2-gregkh@linuxfoundation.org>
 <9365e038-2146-98f8-f989-02827f221c34@linux.intel.com>
 <YuP0Ffs3G7ZBR0AC@kroah.com>
From:   Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
In-Reply-To: <YuP0Ffs3G7ZBR0AC@kroah.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 7/29/22 09:52, Greg Kroah-Hartman wrote:
> On Fri, Jul 29, 2022 at 09:46:26AM -0500, Pierre-Louis Bossart wrote:
>>
>>
>> On 7/29/22 08:50, Greg Kroah-Hartman wrote:
>>> There's no need to special-case the dp0 sysfs attributes, the
>>> is_visible() callback in the attribute group can handle that for us, so
>>> add that and add it to the attribute group list making the logic simpler
>>> overall.
>>>
>>> This is a step on the way to moving all of the sysfs attribute handling
>>> into the default driver core attribute group logic so that the soundwire
>>> core does not have to do any of it manually.
>>>
>>> Cc: Vinod Koul <vkoul@kernel.org>
>>> Cc: Bard Liao <yung-chuan.liao@linux.intel.com>
>>> Cc: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
>>> Cc: Sanyog Kale <sanyog.r.kale@intel.com>
>>> Cc: alsa-devel@alsa-project.org
>>> Cc: linux-kernel@vger.kernel.org
>>> Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
>>> ---
>>>  drivers/soundwire/sysfs_slave.c | 18 ++++++++++++------
>>>  1 file changed, 12 insertions(+), 6 deletions(-)
>>>
>>> diff --git a/drivers/soundwire/sysfs_slave.c b/drivers/soundwire/sysfs_slave.c
>>> index 83e3f6cc3250..3723333a5c2b 100644
>>> --- a/drivers/soundwire/sysfs_slave.c
>>> +++ b/drivers/soundwire/sysfs_slave.c
>>> @@ -174,6 +174,16 @@ static ssize_t words_show(struct device *dev,
>>>  }
>>>  static DEVICE_ATTR_RO(words);
>>>  
>>> +static umode_t dp0_is_visible(struct kobject *kobj, struct attribute *attr,
>>> +			      int n)
>>> +{
>>> +	struct sdw_slave *slave = dev_to_sdw_dev(kobj_to_dev(kobj));
>>> +
>>> +	if (slave->prop.dp0_prop)
>>> +		return attr->mode;
>>> +	return 0;
>>> +}
>>
>> This changes the results slightly by creating an empty 'dp0' directory
>> with no attributes inside.
>>
>> Before:
>>
>> [root@fedora ~]# cd /sys/bus/soundwire/devices/sdw:3:025d:0714:01
>> [root@fedora sdw:3:025d:0714:01]# ls dp0
>> ls: cannot access 'dp0': No such file or directory
>>
>> After:
>> [root@fedora sdw:3:025d:0714:01]# ls dp0
> 
> That should be fine, tools should just be looking for the attributes,
> not the existance of a directory, right?

The idea what that we would only expose ports that actually exist.
That's helpful information anyone with a basic knowledge of the
SoundWire specification would understand.

The attributes are really details that few people/applications would
understand, and unfortunately the information reported in DSDT is more
often than not complete garbage.

