Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 00306563633
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Jul 2022 16:53:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233855AbiGAOwW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Jul 2022 10:52:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48524 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233726AbiGAOwL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Jul 2022 10:52:11 -0400
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B3173BA46
        for <linux-kernel@vger.kernel.org>; Fri,  1 Jul 2022 07:52:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1656687129; x=1688223129;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=+0IW1UANJAvSztKc823tMAh+F6Z/wI9gBYC999IMRsE=;
  b=aah4sJsAdZg1XWRmMsoJ34ta0SRygZWEOb7tc+gFhi9gF+9FDNL4YxYw
   6bMe/t8dQnmDyugHEbx4HYcYwdxPqduXVIXptRTusHsxESPYMJkeYJE7c
   ddrMATsew/tctbP71sfLD5PcNQMVew7mdNHfPNZ4P70UiWb3DFJnWDA//
   K81VGuGOn8hnfOYWKdq2yIN0zu+IafYzgPnCGOuBeheP4ckDmgiECuQAS
   FTLxpWv78hqMffA9wdGU4Ny96gtKqLImYLq8ocGxSDtQxVaHwI/tLYSjp
   8lxbkxjTzkvBtsjd7CUG5YmxIhI/2U1yAtJrswPqyFuLJcuFhiKngLg6I
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10394"; a="308183763"
X-IronPort-AV: E=Sophos;i="5.92,237,1650956400"; 
   d="scan'208";a="308183763"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Jul 2022 07:52:08 -0700
X-IronPort-AV: E=Sophos;i="5.92,237,1650956400"; 
   d="scan'208";a="541758296"
Received: from swathigo-mobl3.amr.corp.intel.com (HELO [10.209.128.76]) ([10.209.128.76])
  by orsmga003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Jul 2022 07:52:07 -0700
Message-ID: <65a5e374-ff3a-ec2d-af70-c042c22decdb@linux.intel.com>
Date:   Fri, 1 Jul 2022 08:53:35 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Firefox/91.0 Thunderbird/91.10.0
Subject: Re: [PATCH] ASoC: Intel: sof_rt5682: fix out-of-bounds array access
Content-Language: en-US
To:     Brent Lu <brent.lu@intel.com>, alsa-devel@alsa-project.org
Cc:     Cezary Rojewski <cezary.rojewski@intel.com>,
        Liam Girdwood <liam.r.girdwood@linux.intel.com>,
        Peter Ujfalusi <peter.ujfalusi@linux.intel.com>,
        Bard Liao <yung-chuan.liao@linux.intel.com>,
        Ranjani Sridharan <ranjani.sridharan@linux.intel.com>,
        Kai Vehmanen <kai.vehmanen@linux.intel.com>,
        Mark Brown <broonie@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>, Yong Zhi <yong.zhi@intel.com>,
        Mac Chiang <mac.chiang@intel.com>,
        Ajye Huang <ajye.huang@gmail.com>, linux-kernel@vger.kernel.org
References: <20220701081908.248239-1-brent.lu@intel.com>
From:   Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
In-Reply-To: <20220701081908.248239-1-brent.lu@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_HI,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 7/1/22 03:19, Brent Lu wrote:
> Starting from ADL platform we have four HDMI PCM devices which exceeds
> the size of sof_hdmi array. Since each sof_hdmi_pcm structure
> represents one HDMI PCM device, we remove the sof_hdmi array and add a
> new member hdmi_jack to the snd_soc_jack structure to fix the
> out-of-bounds problem.

Valid fix aligned with other machine drivers, but the commit message is
incorrect: the 4th HDMI link was added in TGL, not ADL.

See e.g. 'Google Volteer', this quirk is already enabled:
SOF_RT5682_NUM_HDMIDEV(4)),

I guess existing topologies for Volteer never used the 4th link?

Wondering how we didn't this problem sooner - and if this needs to be
added to -stable, or if this is only needed for newer platforms.

> Signed-off-by: Brent Lu <brent.lu@intel.com>
> ---
>  sound/soc/intel/boards/sof_rt5682.c | 10 +++-------
>  1 file changed, 3 insertions(+), 7 deletions(-)
> 
> diff --git a/sound/soc/intel/boards/sof_rt5682.c b/sound/soc/intel/boards/sof_rt5682.c
> index a24fb71d5ff3..1384716c6360 100644
> --- a/sound/soc/intel/boards/sof_rt5682.c
> +++ b/sound/soc/intel/boards/sof_rt5682.c
> @@ -69,11 +69,10 @@ static unsigned long sof_rt5682_quirk = SOF_RT5682_MCLK_EN |
>  
>  static int is_legacy_cpu;
>  
> -static struct snd_soc_jack sof_hdmi[3];
> -
>  struct sof_hdmi_pcm {
>  	struct list_head head;
>  	struct snd_soc_dai *codec_dai;
> +	struct snd_soc_jack hdmi_jack;
>  	int device;
>  };
>  
> @@ -447,7 +446,6 @@ static int sof_card_late_probe(struct snd_soc_card *card)
>  	char jack_name[NAME_SIZE];
>  	struct sof_hdmi_pcm *pcm;
>  	int err;
> -	int i = 0;
>  
>  	/* HDMI is not supported by SOF on Baytrail/CherryTrail */
>  	if (is_legacy_cpu || !ctx->idisp_codec)
> @@ -468,17 +466,15 @@ static int sof_card_late_probe(struct snd_soc_card *card)
>  		snprintf(jack_name, sizeof(jack_name),
>  			 "HDMI/DP, pcm=%d Jack", pcm->device);
>  		err = snd_soc_card_jack_new(card, jack_name,
> -					    SND_JACK_AVOUT, &sof_hdmi[i]);
> +					    SND_JACK_AVOUT, &pcm->hdmi_jack);
>  
>  		if (err)
>  			return err;
>  
>  		err = hdac_hdmi_jack_init(pcm->codec_dai, pcm->device,
> -					  &sof_hdmi[i]);
> +					  &pcm->hdmi_jack);
>  		if (err < 0)
>  			return err;
> -
> -		i++;
>  	}
>  
>  	if (sof_rt5682_quirk & SOF_MAX98373_SPEAKER_AMP_PRESENT) {
