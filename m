Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A3C9058531A
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Jul 2022 17:52:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236918AbiG2Pwc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Jul 2022 11:52:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53910 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230040AbiG2Pwa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Jul 2022 11:52:30 -0400
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EAF731F2FD
        for <linux-kernel@vger.kernel.org>; Fri, 29 Jul 2022 08:52:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1659109949; x=1690645949;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=UAUPEMcuCVe8VZDe3qyzrxa6b7jqOvbpuUOTVLjcXf4=;
  b=HXSyP/oDkVukmoe8a7cdMSt8G6zy72133zZh08XH647nn7nVRPgot5aB
   DYY5c/0l+zJ86vbLJOHbnyWYJljTZtqLvrKeIg+tRz24BdOYTEzQyuDFr
   OeHasYq0sDaB+MLBC9BohC8QNvnCPrf5auR4+7Lw3gRyOLbvViPpj11r3
   1TCcXIkJjIViclIQcTR57tDCmUC29lWrgdvJ6RQccX5QnSOHTrFBDQAb1
   G2jGovHkEGZibL3tIwoyRoIh16ZdHQKzxiANiAV/PfuaouSZHdmtyYlgm
   umRzjTXSJ2Q2PilSOaCVAs1L6bqxyInhKJnb6z7GNfsj3iY+y4B48uhdN
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10423"; a="289562366"
X-IronPort-AV: E=Sophos;i="5.93,201,1654585200"; 
   d="scan'208";a="289562366"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Jul 2022 08:52:29 -0700
X-IronPort-AV: E=Sophos;i="5.93,201,1654585200"; 
   d="scan'208";a="605001231"
Received: from kaholo-mobl.amr.corp.intel.com (HELO [10.212.97.86]) ([10.212.97.86])
  by fmsmga007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Jul 2022 08:52:28 -0700
Message-ID: <5caffe2a-f5a6-e312-a564-5fe29c4e2323@linux.intel.com>
Date:   Fri, 29 Jul 2022 10:52:28 -0500
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
 <cfacb124-a9ff-0a93-8f92-93d164b15966@linux.intel.com>
 <YuP2pjhyKTTfpXQq@kroah.com>
From:   Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
In-Reply-To: <YuP2pjhyKTTfpXQq@kroah.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


>>>>> diff --git a/drivers/soundwire/sysfs_slave.c b/drivers/soundwire/sysfs_slave.c
>>>>> index 83e3f6cc3250..3723333a5c2b 100644
>>>>> --- a/drivers/soundwire/sysfs_slave.c
>>>>> +++ b/drivers/soundwire/sysfs_slave.c
>>>>> @@ -174,6 +174,16 @@ static ssize_t words_show(struct device *dev,
>>>>>  }
>>>>>  static DEVICE_ATTR_RO(words);
>>>>>  
>>>>> +static umode_t dp0_is_visible(struct kobject *kobj, struct attribute *attr,
>>>>> +			      int n)
>>>>> +{
>>>>> +	struct sdw_slave *slave = dev_to_sdw_dev(kobj_to_dev(kobj));
>>>>> +
>>>>> +	if (slave->prop.dp0_prop)
>>>>> +		return attr->mode;
>>>>> +	return 0;
>>>>> +}
>>>>
>>>> This changes the results slightly by creating an empty 'dp0' directory
>>>> with no attributes inside.
>>>>
>>>> Before:
>>>>
>>>> [root@fedora ~]# cd /sys/bus/soundwire/devices/sdw:3:025d:0714:01
>>>> [root@fedora sdw:3:025d:0714:01]# ls dp0
>>>> ls: cannot access 'dp0': No such file or directory
>>>>
>>>> After:
>>>> [root@fedora sdw:3:025d:0714:01]# ls dp0
>>>
>>> That should be fine, tools should just be looking for the attributes,
>>> not the existance of a directory, right?
>>
>> The idea what that we would only expose ports that actually exist.
>> That's helpful information anyone with a basic knowledge of the
>> SoundWire specification would understand.
> 
> Is "dp0" a port?  If so, why isn't it a real device?

The SoundWire spec defines the concept of 'data port'. The valid ranges
are 1..14, but in all existing devices the number of data ports is way
smaller, typically 2 to 4. Data ports (DPn) are source or sink, and
there's no firm rule that data ports needs to be contiguous.

DP0 is a 'special case' where the data transport is used for control
information, e.g. programming large set of registers or firmware
download. DP0 is completely optional in hardware, and not handled in
Linux for now.

DP0 and DPn expose low-level transport registers, which define how the
contents of a FIFO will be written or read from the bus. Think of it as
a generalization of the concept of TDM slots, where instead of having a
fixed slot per frame the slot position/repetition/runlength can be
programmed.

The data ports could be as simple as 1-bit PDM, or support 8ch PCM
24-bits. That's the sort of information reported in attributes.

>> The attributes are really details that few people/applications would
>> understand, and unfortunately the information reported in DSDT is more
>> often than not complete garbage.
> 
> I don't understand what DSDT is, or how it is relevant here :(

Platform firmware typically exposes the presence of ports and the
details since there are no descriptors in hardware. The DSDT in ACPI
exposes _DSD properties under the SoundWire device scope, which are
compatible with DT properties. In other words, what the driver exposes
in sysfs is just a mirror of what was reported by platform firmware -
unless it was overridden by a driver.
