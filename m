Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ED47A5A2964
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Aug 2022 16:26:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343948AbiHZOZs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 Aug 2022 10:25:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42106 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244406AbiHZOZo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Aug 2022 10:25:44 -0400
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C4133055A
        for <linux-kernel@vger.kernel.org>; Fri, 26 Aug 2022 07:25:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1661523944; x=1693059944;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=EagHLuYyy/D4ZjO0QalG/OMeTF32exa9+75PSttsxWg=;
  b=foW7JUZelAQ0S/5IWuq8I2tO8yJ9B9Wx/WvGB007rke4AmzievbNGM76
   eesESv8uKt/lNpTlObeUKK2137Il4kkSjq4EivfC1cUUQa0KMv9Hg5IPb
   T9R82nV5NC7uENdH1U9ifQQkwCBNmtJJ2XK15ECJXRB0BjBWFOh95M+Xa
   dAU610d1g0pHbXig95IerFAs5zVjuc5vrvEcXrctwjILjUlQ/SsamuWBx
   ZfK0eqM4LnNtqK1rx9imr8/EGhmV5wrEjJOtbhANDIbfxOheZqguzudbd
   eE4u/e/QCzUTOjSFtOlClln46yPZnA82+zfIxLtCvtyIF3TnAKYLigTkn
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10451"; a="358482914"
X-IronPort-AV: E=Sophos;i="5.93,265,1654585200"; 
   d="scan'208";a="358482914"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Aug 2022 07:25:42 -0700
X-IronPort-AV: E=Sophos;i="5.93,265,1654585200"; 
   d="scan'208";a="610579760"
Received: from plecluse-mobl2.ger.corp.intel.com (HELO [10.252.52.28]) ([10.252.52.28])
  by orsmga002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Aug 2022 07:25:40 -0700
Message-ID: <01e03c55-1fcf-1e33-78e8-398a50b622ce@linux.intel.com>
Date:   Fri, 26 Aug 2022 10:06:46 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Firefox/91.0 Thunderbird/91.11.0
Subject: Re: [PATCH 3/3] soundwire: bus: Fix lost UNATTACH when re-enumerating
Content-Language: en-US
To:     Richard Fitzgerald <rf@opensource.cirrus.com>, vkoul@kernel.org,
        yung-chuan.liao@linux.intel.com, sanyog.r.kale@intel.com
Cc:     patches@opensource.cirrus.com, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org
References: <20220825122241.273090-1-rf@opensource.cirrus.com>
 <20220825122241.273090-4-rf@opensource.cirrus.com>
 <adfdf06a-e1a3-e47c-a71f-5e5dccef6fd0@linux.intel.com>
 <e9deb2fb-458a-8136-5ba7-a9e2b0f2d174@opensource.cirrus.com>
From:   Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
In-Reply-To: <e9deb2fb-458a-8136-5ba7-a9e2b0f2d174@opensource.cirrus.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DATE_IN_PAST_06_12,
        DKIMWL_WL_HIGH,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



>> On 8/25/22 14:22, Richard Fitzgerald wrote:
>>> Rearrange sdw_handle_slave_status() so that any peripherals
>>> on device #0 that are given a device ID are reported as
>>> unattached. The ensures that UNATTACH status is not lost.
>>>
>>> Handle unenumerated devices first and update the
>>> sdw_slave_status array to indicate IDs that must have become
>>> UNATTACHED.
>>>
>>> Look for UNATTACHED devices after this so we can pick up
>>> peripherals that were UNATTACHED in the original PING status
>>> and those that were still ATTACHED at the time of the PING but
>>> then reverted to unenumerated and were found by
>>> sdw_program_device_num().
>>
>> Are those two cases really lost completely? It's a bit surprising, I do
>> recall that we added a recheck on the status, see the 'update_status'
>> label in cdns_update_slave_status_work
>>
> 
> Yes they are. We see this happen extremely frequently (like, almost
> every time) when we reset out peripherals after a firmware change.
> 
> I saw that "try again" stuff in cdns_update_slave_status_work() but
> it's not fixing the problem. Maybe because it's looking for devices
> still on #0 but that isn't the problem.
> 
> The cdns_update_slave_status_work() is running in one workqueue thread,
> child drivers in other threads. So for example:
> 
> 1. Child driver #1 resets #1
> 2. PING: #1 has reverted to #0, #2 still ATTACHED
> 3. cdns_update_slave_status() snapshots the status. #2 is ATTACHED
> 4. #1 has gone so mark it UNATTACHED
> 5. Child driver #2 gets some CPU time and reset #2
> 5. PING: #2 has reset, both now on #0 but we are handling the previous
> PING
> 6. sdw_handle_slave_status() - snapshot PING (from step 3) says #2 is
> attached
> 7. Device on #0 so call sdw_program_device_num()
> 8. sdw_program_device_num() loops until no devices on #0, #1 and #2
> are both reprogrammed, return from sdw_handle_slave_status()
> 10. PING: #1 and #2 both attached
> 11. cdns_update_slave_status() -> sdw_handle_slave_status()
> 12. #1 has changed UNATTACHED->ATTACHED, but we never got a PING with
>     #2 unattached so its slave->status==ATTACHED, "it hasn't changed"
>     (wrong!)
> 
> Now, at step 10 the Cadence IP may have accumlated both UNATTACH and
> ATTACH flags, and perhaps it should be smarter about deciding what
> to report if there are multiple states. HOWEVER.... that's the behaviour
> of Cadence IP, other IP may be different so it's probably unwise to
> assume that the IP has "remembered" the UNATTACH state before it was
> reprogrammed.
> 
> If we reprogrammed it, it was definitely UNATTACHED so let's say that.

Thanks for the detailed answer, this sequence of events will certainly
defeat the Cadence IP and the way sticky bits were handled.

The UNATTACHED case was assumed to be a really rare case of losing sync,
i.e. a SOFT_RESET in SoundWire parlance.

If you explicitly do a device reset, that would be a new scenario that
was not considered before on any of the existing SoundWire commercial
devices. It's however something we need to support, and your work here
is much appreciated.

I still think we should re-check the actual status from a PING frame, in
order to work with more current data than the sticky bits taken at an
earlier time, but that would only be a minor improvement.

I also have a vague feeling that additional work is needed to make sure
the DAIs are not used before that second enumeration and all firmware
download complete. I did a couple of tests last year where I used the
debugfs interface to issue a device reset command while streaming audio,
and the detach/reattach was not handled at the ASoC level.

I really don't see any logical flaws in your patch as is, so

Reviewed-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>

