Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D8E5C57B78A
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Jul 2022 15:31:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231282AbiGTNbf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Jul 2022 09:31:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57064 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229493AbiGTNbd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Jul 2022 09:31:33 -0400
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B039A22B
        for <linux-kernel@vger.kernel.org>; Wed, 20 Jul 2022 06:31:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1658323892; x=1689859892;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=97Krov47Nh6N4s4IwW10q57tVLfvL2pyX4++1iM6ROo=;
  b=GXg30PO3Ww0zNnphb4fxV016A52L/0FdqXKF9t2mcTlLtVAAefpBisVb
   FXIp43V9p6jsdMdRWZ24TWBaafhg/6pMRqLnpl/DDKv3HO5Or5IGgZw3O
   9GV1k2iS4Ux9RKqwRHnXIWZyRsMdHnpXoWNBqlXdcsNqpo0UDrxf39FPW
   ROyr5dIz4kXbwzyeOj2MrDrQ/bO26zvi1r83xdGYDiMdg9O0clC3i7dWb
   MPtMUIK3+b+6VaXNbgkTYMZhmrHSkAPCrKMlv4E7m+YmL5ssTRXnonMXo
   nPt4fYRMUf+9dSAR2xKsH6BkZajkjjn9p01qWst5dptyVs8cXuhLQyFLR
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10414"; a="266553020"
X-IronPort-AV: E=Sophos;i="5.92,286,1650956400"; 
   d="scan'208";a="266553020"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Jul 2022 06:31:20 -0700
X-IronPort-AV: E=Sophos;i="5.92,286,1650956400"; 
   d="scan'208";a="573305428"
Received: from tgeorge1-mobl.amr.corp.intel.com (HELO [10.212.79.208]) ([10.212.79.208])
  by orsmga006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Jul 2022 06:31:19 -0700
Message-ID: <514f0fda-9475-e163-fd64-0bc675dd3447@linux.intel.com>
Date:   Wed, 20 Jul 2022 08:31:18 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Firefox/91.0 Thunderbird/91.11.0
Subject: Re: [PATCH] ALSA: hda: Skip creating captures in SOF context
Content-Language: en-US
To:     Jaroslav Kysela <perex@perex.cz>,
        Kai-Heng Feng <kai.heng.feng@canonical.com>
Cc:     tiwai@suse.com, Bard Liao <yung-chuan.liao@linux.intel.com>,
        alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
References: <20220719144753.252231-1-kai.heng.feng@canonical.com>
 <bd59b06a-de49-2a1a-d2a2-351957fec6d0@perex.cz>
 <CAAd53p6ru7CJ=pJ2knCL5pgU_Y+nA=yTPscKk225zTD-fv4qQg@mail.gmail.com>
 <34bddb2f-dc57-c08c-358e-26cf7824c203@perex.cz>
From:   Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
In-Reply-To: <34bddb2f-dc57-c08c-358e-26cf7824c203@perex.cz>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 7/20/22 02:52, Jaroslav Kysela wrote:
> Dne 20. 07. 22 v 3:45 Kai-Heng Feng napsal(a):
>> On Tue, Jul 19, 2022 at 11:41 PM Jaroslav Kysela <perex@perex.cz> wrote:
>>>
>>> Dne 19. 07. 22 v 16:47 Kai-Heng Feng napsal(a):
>>>> On HP laptops that use SOF driver for DMIC, the micmute LED doesn't
>>>> light up when mic is muted after commit 9b014266ef8a ("ASoC: SOF:
>>>> topology: use new sound control LED layer").
>>>>
>>>> The micmute LED itself is still working via sysfs, but it doesn't follow
>>>> mute anymore. That's because unlike vendors like Dell and Lenovo, HP
>>>> laptops use HDA codec to control mute LEDs instead of ACPI. So on HP
>>>> laptops, both SOF and HDA create captures with
>>>> SNDRV_CTL_ELEM_ACCESS_MIC_LED access, snd_ctl_led_set_state() considers
>>>> there are two different kcontrols and one of them is not muted.
>>>
>>> It does not mean that it's a wrong behavior. When both controls are muted, the
>>> LED should be turned on. It just requires that all inputs are off (and it may
>>> be the default - probably we can set in UCM or so). If you turn the "Capture
>>> Switch" off in amixer / alsamixer, do things work as expected ?
>>
>> Yes. When all captures are muted the micmute LED is on.
>>
>>>
>>>> So skip creating captures for HDA when it's called from SOF, the
>>>> captures are already handled by SOF.
>>>
>>> The capture controls are for other inputs like external analog microphone. If
>>> it is required to suppress the MIC LED for some hardware, just skip the
>>> "spec->mic_mute_led = 1" assignment in hda_generic.c . Also, the check
>>> "codec->core.type != HDA_DEV_ASOC" is not sufficient, because you don't know,
>>> if the topology really sets the MIC LED flag.
>>
>> AFAIK the external analog microphone on DMIC laptop is driven by SOF driver too.
>> If those capture controls are indeed needed for external analog mics,
>> use UCM to mute them by default won't work either.
> 
> Could you describe this ? I though that only DMIC is handled by SOF when HDA
> codec is in the system. There is a separate analog codec for external analog
> microphone or the HDA codec is somehow connected to SOF/DSP ? If so, how ?

The HDA codec is connected in the same way in all cases, there's no
hardware/electrical/routing difference.

When used, the SOF driver will handle ALL links, be they DMIC or
HDAudio. The difference for HDaudio is that instead of a single DMA
transfer (DDR->FIFO), we have a first 'Host' DMA into the DSP SRAM, some
processing and a second 'Link' DMA from DSP SRAM to the HDaudio FIFO
(reversed flow for capture).

