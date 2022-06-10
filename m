Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8D65C546A93
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Jun 2022 18:37:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346588AbiFJQgz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Jun 2022 12:36:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42662 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245530AbiFJQgv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Jun 2022 12:36:51 -0400
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E30B656FB1
        for <linux-kernel@vger.kernel.org>; Fri, 10 Jun 2022 09:36:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1654879007; x=1686415007;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=qhb3ue3jkx0OzNd+SAkFQAItwZgBg+sANmqWbb2tG7A=;
  b=OIoKsXBRkqhODBGZURW1VSU+WWYjvGdVy2KjM/UwwWW2KJKjAwhBo7qm
   FJtVEEt1ofIklMR9DwsrGdUpHf9JbrXxk9FsHoPcH5Zrle28HtR50kid9
   SmIbiqLiq0T3ocs6aehIFUUV4lk5Q2Zdkg2YL4ffuGIrcfCGIdq6Ga6Jv
   4jxEHqRXiFMGNVXbMRfvSq8KGmmApMt+wUbm8CVdhI45fFxKOp9Grwhta
   XePzalWM4PgQ9hLZhAwpn12DNnHja/c6ll0B0gLwjXwWzA10xflJ2ZatU
   xrIKdYBvjj4MhJvknfE78nvTW83bSjiapJ+RcpD6cecqZN2bUmg/oFSbF
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10374"; a="341737251"
X-IronPort-AV: E=Sophos;i="5.91,290,1647327600"; 
   d="scan'208";a="341737251"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Jun 2022 09:36:47 -0700
X-IronPort-AV: E=Sophos;i="5.91,290,1647327600"; 
   d="scan'208";a="725032963"
Received: from pljackso-mobl.amr.corp.intel.com (HELO [10.213.190.122]) ([10.213.190.122])
  by fmsmga001-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Jun 2022 09:36:46 -0700
Message-ID: <b86e6cbd-3488-a239-d765-cf01bf0d4f70@linux.intel.com>
Date:   Fri, 10 Jun 2022 10:06:58 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Firefox/91.0 Thunderbird/91.9.1
Subject: Re: [PATCH 1/2] soundwire: intel: uniquify debug message
Content-Language: en-US
To:     Greg KH <gregkh@linuxfoundation.org>,
        Bard Liao <yung-chuan.liao@linux.intel.com>
Cc:     alsa-devel@alsa-project.org, vkoul@kernel.org,
        vinod.koul@linaro.org, linux-kernel@vger.kernel.org, tiwai@suse.de,
        broonie@kernel.org, srinivas.kandagatla@linaro.org,
        sanyog.r.kale@intel.com, bard.liao@intel.com
References: <20220610023537.27223-1-yung-chuan.liao@linux.intel.com>
 <20220610023537.27223-2-yung-chuan.liao@linux.intel.com>
 <YqLVwqx9/Pos8T06@kroah.com>
From:   Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
In-Reply-To: <YqLVwqx9/Pos8T06@kroah.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-6.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 6/10/22 00:25, Greg KH wrote:
> On Fri, Jun 10, 2022 at 10:35:36AM +0800, Bard Liao wrote:
>> From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
>>
>> The same debug message is replicated multiple time, add __func__ to
>> figure out what link is ignored.
>>
>> Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
>> Reviewed-by: Ranjani Sridharan <ranjani.sridharan@linux.intel.com>
>> Reviewed-by: Péter Ujfalusi <peter.ujfalusi@linux.intel.com>
>> Signed-off-by: Bard Liao <yung-chuan.liao@linux.intel.com>
>> ---
>>  drivers/soundwire/intel.c | 28 ++++++++++++++--------------
>>  1 file changed, 14 insertions(+), 14 deletions(-)
>>
>> diff --git a/drivers/soundwire/intel.c b/drivers/soundwire/intel.c
>> index 505c5ef061e3..808e2f320052 100644
>> --- a/drivers/soundwire/intel.c
>> +++ b/drivers/soundwire/intel.c
>> @@ -1328,8 +1328,8 @@ int intel_link_startup(struct auxiliary_device *auxdev)
>>  
>>  	if (bus->prop.hw_disabled) {
>>  		dev_info(dev,
>> -			 "SoundWire master %d is disabled, ignoring\n",
>> -			 sdw->instance);
>> +			 "%s: SoundWire master %d is disabled, ignoring\n",
>> +			 __func__, sdw->instance);
> 
> This is not a debug message, please make it such if you want to have
> __func__  And even then, it's not needed as you can get that from the
> kernel automatically.

Sorry, I don't understand the feedback at all.

This message was added precisely to figure out why the expected
programming sequence was not followed, only to discover that we have
devices with spurious PCI wakes handled below. Without this added
difference with __func__, we wouldn't know if the issue happened during
the expected/regular programming sequence or not.

> 
>>  		return 0;
>>  	}
>>  
>> @@ -1489,8 +1489,8 @@ int intel_link_process_wakeen_event(struct auxiliary_device *auxdev)
>>  	bus = &sdw->cdns.bus;
>>  
>>  	if (bus->prop.hw_disabled || !sdw->startup_done) {
>> -		dev_dbg(dev, "SoundWire master %d is disabled or not-started, ignoring\n",
>> -			bus->link_id);
>> +		dev_dbg(dev, "%s: SoundWire master %d is disabled or not-started, ignoring\n",
>> +			__func__, bus->link_id);
>>  		return 0;
>>  	}
>>  
>> @@ -1549,8 +1549,8 @@ static int __maybe_unused intel_pm_prepare(struct device *dev)
>>  	int ret;
>>  
>>  	if (bus->prop.hw_disabled || !sdw->startup_done) {
>> -		dev_dbg(dev, "SoundWire master %d is disabled or not-started, ignoring\n",
>> -			bus->link_id);
>> +		dev_dbg(dev, "%s: SoundWire master %d is disabled or not-started, ignoring\n",
>> +			__func__, bus->link_id);
> 
> Not needed, it is provided automatically if you ask the kernel for this.
> Same for all other instances in this patch.

provided how? Your comment is a bit cryptic here.
