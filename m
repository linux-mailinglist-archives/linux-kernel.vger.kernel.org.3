Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 20B0C4BBF13
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Feb 2022 19:12:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239003AbiBRSMV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Feb 2022 13:12:21 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:33032 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236218AbiBRSMS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Feb 2022 13:12:18 -0500
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A7A933354
        for <linux-kernel@vger.kernel.org>; Fri, 18 Feb 2022 10:12:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1645207921; x=1676743921;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=qJpUQfCMiajF+akcXvNXCP6L2CbGn7TS+KQgaql4Uhw=;
  b=ITZ3A+1DcOTJYsa73284Q6h2CuxkQjigBVkC/g0uiI2fCYwjXUg8IabN
   XDadI4vnREvujdD7tPa+rwShAcsLAXUeBhrBzvhEH7E1Q5/PdwpgonIvo
   0fy+X0eqK3aZZ/tY44pe/LfzbG3Wq553W2nRqtGQLDDrK48QdcFj4w57z
   0fFXnmq4/JkJfZfaTP8uBI5K0FCBh+w7cigGLtGohHU6o4Gpm6WIkpo0x
   K//rSMkFoSxXKQWj6RtYDGmgkLcIykK5ea3b/QmGMCANyVqjnFUFYCPvx
   tar/PPgnJSPLt0SzdDFI84WBBTMcS1tuXNo42Z/wyYGQviFCcpUSHZ1ro
   w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10262"; a="234716125"
X-IronPort-AV: E=Sophos;i="5.88,379,1635231600"; 
   d="scan'208";a="234716125"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Feb 2022 10:12:00 -0800
X-IronPort-AV: E=Sophos;i="5.88,379,1635231600"; 
   d="scan'208";a="504080860"
Received: from ryanflyn-mobl.amr.corp.intel.com (HELO [10.212.54.106]) ([10.212.54.106])
  by orsmga002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Feb 2022 10:11:59 -0800
Message-ID: <c17173cb-290c-9ecd-54e3-b74f9d4e9061@linux.intel.com>
Date:   Fri, 18 Feb 2022 12:11:59 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Firefox/91.0 Thunderbird/91.5.0
Subject: Re: [PATCH 0/1] sound: add quirk for Huawei D15
Content-Language: en-US
To:     Mark Brown <broonie@kernel.org>,
        Mauro Carvalho Chehab <mchehab@kernel.org>
Cc:     alsa-devel@alsa-project.org, Jaroslav Kysela <perex@perex.cz>,
        linux-kernel@vger.kernel.org,
        Bard Liao <yung-chuan.liao@linux.intel.com>,
        Huajun Li <huajun.li@intel.com>, tiwai@suse.de,
        Takashi Iwai <tiwai@suse.com>,
        Kai Vehmanen <kai.vehmanen@linux.intel.com>
References: <cover.1640351150.git.mchehab@kernel.org>
 <164519450743.1836505.3912962145996830275.b4-ty@kernel.org>
From:   Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
In-Reply-To: <164519450743.1836505.3912962145996830275.b4-ty@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2/18/22 08:28, Mark Brown wrote:
> On Fri, 24 Dec 2021 14:09:48 +0100, Mauro Carvalho Chehab wrote:
>> Based on my tests, Huawei D15 (Intel) uses SSP0 on es8336.
>>
>> Add a quirk for it.
>>
>> Please notice that, currently, only the internal speaker is working.
>> The topology for the internal microphone and for the headphones
>> is wrong. Enabling/disabling the other two quirks (GPIO and/or DMIC)
>> doesn't cause any audible results, nor change the devices listed
>> on pavucontrol (tested with pipewire-pulse).
>>
>> [...]
> 
> Applied to
> 
>    https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next
> 
> Thanks!
> 
> [1/1] ASoC: Intel: sof_es8336: add quirk for Huawei D15 2021
>       commit: ce6a70bfce21bb4edb7c0f29ecfb0522fa34ab71

I'll probably revert this change in my next update [1], I have a set of
changes where we can detect which SSP is used by parsing the NHTL
information in platform firmware.

I am still trying to figure out how to detect which MCLK is used, and
once this is done I'll send the patches upstream.

[1] https://github.com/thesofproject/linux/pull/3338
