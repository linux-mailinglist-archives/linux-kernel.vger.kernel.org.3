Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 027804F7421
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Apr 2022 05:36:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240561AbiDGDij (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Apr 2022 23:38:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52236 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240650AbiDGDi1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Apr 2022 23:38:27 -0400
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A96ED241B69
        for <linux-kernel@vger.kernel.org>; Wed,  6 Apr 2022 20:36:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1649302588; x=1680838588;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=fNARzUYWCWEFMOy3OrUny7NCKu8gMH3rlx8PZw5PQfw=;
  b=k2IVZEd2vhg8Xv8MmNuAksOEEBYynZm8ar2m/YzHiJ8pT8MufuwtryOC
   8X3nfFgpHS7hVZU+1u0GzMJ7odEQPXNvdp8x1egCgudE2ZSNjXD439XZW
   oeL+1tDcqUGFby1VXzdHrbGPMVi2tWueexsbCt4gbxNtbfYnArOx73yq0
   FbcSMjHrmphpynhH1dn9HSye6241cHy9vZiyS8wWClC8o9KnX9kxZ5cZm
   UGnHxjlif71f0ahbfuXPiGGrfey7c1ZnQnWcHVlM8Ivz3DjM4F1nO59jV
   dcslLNxEdpXFWphS7CaGz1AIfotqluzWjXl6N8KKop5g/7akiPvk8QdTA
   A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10309"; a="241811321"
X-IronPort-AV: E=Sophos;i="5.90,241,1643702400"; 
   d="scan'208";a="241811321"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Apr 2022 20:36:28 -0700
X-IronPort-AV: E=Sophos;i="5.90,241,1643702400"; 
   d="scan'208";a="505987677"
Received: from arkadee1-mobl.amr.corp.intel.com (HELO [10.209.98.109]) ([10.209.98.109])
  by orsmga003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Apr 2022 20:36:27 -0700
Message-ID: <0dac70ef-1355-3379-ef41-eec6467886b1@linux.intel.com>
Date:   Wed, 6 Apr 2022 22:08:53 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Firefox/91.0 Thunderbird/91.5.0
Subject: Re: [PATCH v4 3/4] ASoC: Intel: sof_es8336: add a quirk for headset
 at mic1 port
Content-Language: en-US
To:     Mauro Carvalho Chehab <mchehab@kernel.org>,
        alsa-devel@alsa-project.org
Cc:     Hans de Goede <hdegoede@redhat.com>,
        =?UTF-8?Q?P=c3=a9ter_Ujfalusi?= <peter.ujfalusi@linux.intel.com>,
        Bard Liao <yung-chuan.liao@linux.intel.com>,
        Cezary Rojewski <cezary.rojewski@intel.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Jie Yang <yang.jie@linux.intel.com>,
        Liam Girdwood <liam.r.girdwood@linux.intel.com>,
        Mark Brown <broonie@kernel.org>, Takashi Iwai <tiwai@suse.com>,
        linux-kernel@vger.kernel.org
References: <cover.1649275618.git.mchehab@kernel.org>
 <baf412bc431650fc7f3a157c6ab96d08120940fc.1649275618.git.mchehab@kernel.org>
From:   Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
In-Reply-To: <baf412bc431650fc7f3a157c6ab96d08120940fc.1649275618.git.mchehab@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


>   static int sof_es8316_speaker_power_event(struct snd_soc_dapm_widget *w,
> @@ -145,13 +148,23 @@ static const struct snd_soc_dapm_route sof_es8316_audio_map[] = {
>   	{"Speaker", NULL, "HPOL"},
>   	{"Speaker", NULL, "HPOR"},
>   	{"Speaker", NULL, "Speaker Power"},
> +
> +	{"Differential Mux", "lin1-rin1", "MIC1"},
> +	{"Differential Mux", "lin2-rin2", "MIC2"},
> +	{"Differential Mux", "lin1-rin1 with 20db Boost", "MIC1"},
> +	{"Differential Mux", "lin2-rin2 with 20db Boost", "MIC2"},

this is surprising, shouldn't this be part of the codec driver?

The part that should be machine-specific is really how MIC1 or MIC2 are 
connected (as done below), but the routes above seem machine-independent?

Or is this a work-around for a miss in the codec driver?

Confused...

>   };
>   
> -static const struct snd_soc_dapm_route sof_es8316_intmic_in1_map[] = {
> +static const struct snd_soc_dapm_route sof_es8316_headset_mic2_map[] = {
>   	{"MIC1", NULL, "Internal Mic"},
>   	{"MIC2", NULL, "Headset Mic"},
>   };
>   
> +static const struct snd_soc_dapm_route sof_es8316_headset_mic1_map[] = {
> +	{"MIC2", NULL, "Internal Mic"},
> +	{"MIC1", NULL, "Headset Mic"},
> +};
> +

