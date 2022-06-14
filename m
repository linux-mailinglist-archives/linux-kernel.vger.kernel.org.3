Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0A99D54B526
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Jun 2022 17:56:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245143AbiFNPys (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Jun 2022 11:54:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36076 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244342AbiFNPyr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Jun 2022 11:54:47 -0400
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 45CCC1A81D
        for <linux-kernel@vger.kernel.org>; Tue, 14 Jun 2022 08:54:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1655222086; x=1686758086;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=PEw/I0GFA2u1JaLEch7NAXgwJOcld7cZ59IarRnGipA=;
  b=K6jxxBi4yAHdZUqaoRH/rpKXJwYVo1BvHER3Rah3SN3kwwY9zlalQAbW
   gyhsaEw8swVJk2TNzJEM65TyVJ4fvo903CTbISawqUgqp2aF4ThPEtiBk
   uYX4Rwk6U1GSKNMJjdCCRacgyS0fFg2uxKHMxmG9VhPRDtstvXQXxP8Ri
   u7xUbqYx1vQhk1yDwDfIJTzXmXmlpGJxs/4oaxnq/h+c5ILGPX3LqmwY2
   9JAIcExWyUHiIHnxwdwg9wnwslhEx5pyEfTLzRxNX8SWX3g+Obff9AaFE
   tqpclh7s8M1GwD8WgX323wyQxsRLghm0arhaXEpxbFqpdgR14hB19QCtC
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10378"; a="276203098"
X-IronPort-AV: E=Sophos;i="5.91,300,1647327600"; 
   d="scan'208";a="276203098"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jun 2022 08:54:46 -0700
X-IronPort-AV: E=Sophos;i="5.91,300,1647327600"; 
   d="scan'208";a="652115675"
Received: from mburny-mobl1.amr.corp.intel.com (HELO [10.213.163.91]) ([10.213.163.91])
  by fmsmga004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jun 2022 08:54:45 -0700
Message-ID: <5928a225-f355-47d7-c502-d95319ce447f@linux.intel.com>
Date:   Tue, 14 Jun 2022 10:54:44 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Firefox/91.0 Thunderbird/91.9.1
Subject: Re: [PATCH 2/2] ASoC: SOF: Intel: add trigger callback into
 sdw_callback
Content-Language: en-US
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     Bard Liao <yung-chuan.liao@linux.intel.com>,
        alsa-devel@alsa-project.org, vkoul@kernel.org,
        vinod.koul@linaro.org, linux-kernel@vger.kernel.org, tiwai@suse.de,
        broonie@kernel.org, srinivas.kandagatla@linaro.org,
        sanyog.r.kale@intel.com, bard.liao@intel.com
References: <20220614070817.2508-1-yung-chuan.liao@linux.intel.com>
 <20220614070817.2508-3-yung-chuan.liao@linux.intel.com>
 <Yqg01aSixhBq9d4+@kroah.com>
 <3fd14acb-1de9-3fd8-81ab-27fee4a42b84@linux.intel.com>
 <Yqil3UDSmoXN3E9M@kroah.com>
From:   Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
In-Reply-To: <Yqil3UDSmoXN3E9M@kroah.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-9.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org




>>>> @@ -809,6 +814,10 @@ void hda_set_dai_drv_ops(struct snd_sof_dev *sdev, struct snd_sof_dsp_ops *ops)
>>>>  		if (!hda_use_tplg_nhlt)
>>>>  			ipc4_data->nhlt = intel_nhlt_init(sdev->dev);
>>>>  
>>>> +#if IS_ENABLED(CONFIG_SND_SOC_SOF_INTEL_SOUNDWIRE)
>>>> +		sdw_callback.trigger = ipc4_be_dai_common_trigger;
>>>> +#endif
>>>
>>> #if should not be in .c files if at all possible.  Surely there's a
>>> better way here...
>>
>> we could use
>>
>> if (IS_ENABLED(CONFIG_SND_SOC_SOF_INTEL_SOUNDWIRE))
>>     sdw_callback.trigger = ipc4_be_dai_common_trigger;
>>
>> would that work?
> 
> It's more readable, right?  Also easier to maintain over time.

yes, it's more readable, and that's no problem to update.

There's another #if IS_ENABLED( that we can replace by a if (IS_ENABLED
in the same routine, that would make this routine less of an eyesore. I
am not sure why we added all these #if, we can cleanup.

 	case SOF_INTEL_IPC4:
	{
		struct sof_ipc4_fw_data *ipc4_data = sdev->private;

		for (i = 0; i < ops->num_drv; i++) {
			if (strstr(ops->drv[i].name, "DMIC")) {
				ops->drv[i].ops = &ipc4_dmic_dai_ops;
				continue;
			}
			if (strstr(ops->drv[i].name, "SSP")) {
				ops->drv[i].ops = &ipc4_ssp_dai_ops;
				continue;
			}
#if IS_ENABLED(CONFIG_SND_SOC_SOF_HDA)
			if (strstr(ops->drv[i].name, "iDisp") ||
			    strstr(ops->drv[i].name, "Analog") ||
			    strstr(ops->drv[i].name, "Digital"))
				ops->drv[i].ops = &ipc4_hda_dai_ops;
#endif
		}

		if (!hda_use_tplg_nhlt)
			ipc4_data->nhlt = intel_nhlt_init(sdev->dev);

#if IS_ENABLED(CONFIG_SND_SOC_SOF_INTEL_SOUNDWIRE)
		sdw_callback.trigger = ipc4_be_dai_common_trigger;
#endif

		break;
	}
	default:
		break;
	}
}
>> We try to keep this driver configurable, not all platforms require
>> SoundWire or HDaudio, and that 'sdw_callback' ops structure is
>> conditionally declared.
> 
> Perhaps don't conditionally declare that?  How much does it really save
> to do that?

It would force us to expose additional things that are only relevant for
SoundWire, see the large block of code in hda.c

https://elixir.bootlin.com/linux/latest/source/sound/soc/sof/intel/hda.c#L108

We've been burned in the past by having too many things in a single
configuration, so we try to allow for minimal builds that don't depend
on other modules in sound/soc/codecs/, sound/pci/hda and
drivers/soundwire - it also forces us to get the Kconfig dependencies right.

if (IS_ENABLED()) is less invasive in that case.

Thanks for your feedback
-Pierre
