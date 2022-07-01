Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 353EC563207
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Jul 2022 12:58:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236870AbiGAK6U (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Jul 2022 06:58:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55734 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233676AbiGAK6Q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Jul 2022 06:58:16 -0400
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 73116BC04
        for <linux-kernel@vger.kernel.org>; Fri,  1 Jul 2022 03:58:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1656673093; x=1688209093;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=DIRi+6ZaJOFr1zg33DBZQTKB2FcrepdEc5EYUaGlRTI=;
  b=UIaTQQWqMJNWgCikwVAdoBipqd+41/ZcRKeVzfZ73FDcTzcurY2rsVdj
   A9N0MLIOH1ZW2ICOQXKReBjKPmSyHjLFLhrS0+VQjKq6h9It5HWtdfuCd
   Dq7pk0/2/Hu5iEhznUQVtBk4vOeiFLFkbtwuHL5HFB2Mq2cyzpy/oNNOl
   9Hp3v2QNdXgoDqbGE+iY4R8eqDFpRR4nC2gE0UEMWmT5BjUmi2b5ne2om
   LRpzjF/99PJOmxS2DaGv/3z+mC8Q0lFZZuidFiPggUeWLs5miwcHWxOFr
   PzFlfF0aCVgaulyrskyC3DsbdnuibfH8P99JkGELmCb6CF8oJGIraH1mp
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10394"; a="281388415"
X-IronPort-AV: E=Sophos;i="5.92,236,1650956400"; 
   d="scan'208";a="281388415"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Jul 2022 03:58:13 -0700
X-IronPort-AV: E=Sophos;i="5.92,236,1650956400"; 
   d="scan'208";a="596219335"
Received: from kerva-mobl2.ger.corp.intel.com (HELO [10.249.254.11]) ([10.249.254.11])
  by fmsmga007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Jul 2022 03:58:09 -0700
Message-ID: <b38b3159-2d77-f4fd-f269-d708eb1a90a5@linux.intel.com>
Date:   Fri, 1 Jul 2022 13:58:53 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Firefox/91.0 Thunderbird/91.10.0
Subject: Re: [PATCH] ASoC: Intel: sof_rt5682: fix out-of-bounds array access
Content-Language: en-US
To:     Brent Lu <brent.lu@intel.com>, alsa-devel@alsa-project.org
Cc:     Cezary Rojewski <cezary.rojewski@intel.com>,
        Kai Vehmanen <kai.vehmanen@linux.intel.com>,
        Takashi Iwai <tiwai@suse.com>,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        Ranjani Sridharan <ranjani.sridharan@linux.intel.com>,
        Liam Girdwood <liam.r.girdwood@linux.intel.com>,
        Mac Chiang <mac.chiang@intel.com>,
        Mark Brown <broonie@kernel.org>,
        Ajye Huang <ajye.huang@gmail.com>,
        Bard Liao <yung-chuan.liao@linux.intel.com>,
        linux-kernel@vger.kernel.org, Yong Zhi <yong.zhi@intel.com>
References: <20220701081908.248239-1-brent.lu@intel.com>
From:   =?UTF-8?Q?P=c3=a9ter_Ujfalusi?= <peter.ujfalusi@linux.intel.com>
In-Reply-To: <20220701081908.248239-1-brent.lu@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 01/07/2022 11:19, Brent Lu wrote:
> Starting from ADL platform we have four HDMI PCM devices which exceeds
> the size of sof_hdmi array. Since each sof_hdmi_pcm structure
> represents one HDMI PCM device, we remove the sof_hdmi array and add a
> new member hdmi_jack to the snd_soc_jack structure to fix the

"new member hdmi_jack to the sof_hdmi_pcm structure to fix the"

> out-of-bounds problem.

Other than that:
Reviewed-by: Peter Ujfalusi <peter.ujfalusi@linux.intel.com>

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

-- 
Péter
