Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A6C9054B3F9
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Jun 2022 16:56:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343664AbiFNOzw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Jun 2022 10:55:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52754 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343588AbiFNOzt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Jun 2022 10:55:49 -0400
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BBCFB396A6
        for <linux-kernel@vger.kernel.org>; Tue, 14 Jun 2022 07:55:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1655218548; x=1686754548;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=xHTGtaLw2DcnGzwyP7TMGez2Dljy9WLjCHMsdYusOy4=;
  b=RLh+JC4GJRixbkY+M13mT7h8dZTr105V4coLjFLlYeUvihq/NvEARmSO
   215wFxAiXWpO05knyCTtlnaJIzoJgu1XxPQ4twGeVrjbEb+/qTOZoKo0n
   2ho/VlMhC3gIF6fNMRqOaDMHTCqKungI6O0UIEuegV3wJUIjLQrywAyq4
   bszRhgPq9uxumy+tBDzdoUSJlr3tF/OpaSOoPC25upEs5PcAYVLojsMRu
   Y2LEs5FOOp+HOZyBgRh+O4scHWxwcNMvp+PhUVGhozv5cqJJy1P6pqb1g
   bu8bVCFqI609NwAg8flDALBbwPw1+HovZes8pjJXD2i3g0N3+Onks4wmg
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10378"; a="364979886"
X-IronPort-AV: E=Sophos;i="5.91,300,1647327600"; 
   d="scan'208";a="364979886"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jun 2022 07:55:48 -0700
X-IronPort-AV: E=Sophos;i="5.91,300,1647327600"; 
   d="scan'208";a="652081167"
Received: from mburny-mobl1.amr.corp.intel.com (HELO [10.213.163.91]) ([10.213.163.91])
  by fmsmga004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jun 2022 07:55:43 -0700
Message-ID: <3fd14acb-1de9-3fd8-81ab-27fee4a42b84@linux.intel.com>
Date:   Tue, 14 Jun 2022 09:55:41 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Firefox/91.0 Thunderbird/91.9.1
Subject: Re: [PATCH 2/2] ASoC: SOF: Intel: add trigger callback into
 sdw_callback
Content-Language: en-US
To:     Greg KH <gregkh@linuxfoundation.org>,
        Bard Liao <yung-chuan.liao@linux.intel.com>
Cc:     alsa-devel@alsa-project.org, vkoul@kernel.org,
        vinod.koul@linaro.org, linux-kernel@vger.kernel.org, tiwai@suse.de,
        broonie@kernel.org, srinivas.kandagatla@linaro.org,
        sanyog.r.kale@intel.com, bard.liao@intel.com
References: <20220614070817.2508-1-yung-chuan.liao@linux.intel.com>
 <20220614070817.2508-3-yung-chuan.liao@linux.intel.com>
 <Yqg01aSixhBq9d4+@kroah.com>
From:   Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
In-Reply-To: <Yqg01aSixhBq9d4+@kroah.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


>> @@ -809,6 +814,10 @@ void hda_set_dai_drv_ops(struct snd_sof_dev *sdev, struct snd_sof_dsp_ops *ops)
>>  		if (!hda_use_tplg_nhlt)
>>  			ipc4_data->nhlt = intel_nhlt_init(sdev->dev);
>>  
>> +#if IS_ENABLED(CONFIG_SND_SOC_SOF_INTEL_SOUNDWIRE)
>> +		sdw_callback.trigger = ipc4_be_dai_common_trigger;
>> +#endif
> 
> #if should not be in .c files if at all possible.  Surely there's a
> better way here...

we could use

if (IS_ENABLED(CONFIG_SND_SOC_SOF_INTEL_SOUNDWIRE))
    sdw_callback.trigger = ipc4_be_dai_common_trigger;

would that work?

We try to keep this driver configurable, not all platforms require
SoundWire or HDaudio, and that 'sdw_callback' ops structure is
conditionally declared.
