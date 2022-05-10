Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B64BC521DDE
	for <lists+linux-kernel@lfdr.de>; Tue, 10 May 2022 17:13:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345442AbiEJPR0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 May 2022 11:17:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59494 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345289AbiEJPPv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 May 2022 11:15:51 -0400
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 410018B09C
        for <linux-kernel@vger.kernel.org>; Tue, 10 May 2022 07:51:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1652194268; x=1683730268;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=JXls05y2gUu5gia6y474ntis4yRroQ2OlH/j4C/LJS4=;
  b=bH0o6kf681587jNcMCns/2iYDDpDbg/pY+/u2EvFQbFEi+/rOueOdI+k
   ZiWf6p6vKo1/hDPd632PDidTGq1Hua1NUem2u4PwFYJNkOdANh2h7JtFS
   /u1NDuXbA78nGLFYoxv/jS1cOCHZAQdwf8NsLdbcqlOAfgRMpf0sxCPRc
   OPRNo3arSqkmgsIJiM/Nng6HMeQygTGFQHVMqi/Fr7HVLRRtAHvi45Pje
   igAj5VWj4NWJkekuXH4BblL7ciLgUzhMebKXMV2yAa5+asHDamw6YUukq
   BwaERsv+rKXo1vE0N1eezHlaLN3yowZkFCG/hS/YZmMgrKmDTC0+2DXy8
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10342"; a="269332707"
X-IronPort-AV: E=Sophos;i="5.91,214,1647327600"; 
   d="scan'208";a="269332707"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 May 2022 07:51:07 -0700
X-IronPort-AV: E=Sophos;i="5.91,214,1647327600"; 
   d="scan'208";a="519786590"
Received: from agupta51-mobl.amr.corp.intel.com (HELO [10.212.253.67]) ([10.212.253.67])
  by orsmga003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 May 2022 07:51:06 -0700
Message-ID: <190c9add-7fa4-8e76-bfcb-43d30f22f8d9@linux.intel.com>
Date:   Tue, 10 May 2022 09:40:34 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Firefox/91.0 Thunderbird/91.5.0
Subject: Re: [PATCH] [v2] ASoC: Intel: sof_cs42l42: adding support for ADL
 configuration and BT offload audio
Content-Language: en-US
To:     Terry Chen <terry_chen@wistron.corp-partner.google.com>,
        alsa-devel@alsa-project.org
Cc:     cezary.rojewski@intel.com, liam.r.girdwood@linux.intel.com,
        yang.jie@linux.intel.com, broonie@kernel.org, perex@perex.cz,
        tiwai@suse.com, brent.lu@intel.com, cujomalainey@chromium.org,
        seanpaul@chromium.org, casey.g.bowman@intel.com,
        mark_hsieh@wistron.corp-partner.google.com,
        vamshi.krishna.gopal@intel.com, mac.chiang@intel.com,
        kai.vehmanen@linux.intel.com, linux-kernel@vger.kernel.org
References: <20220510104829.1466968-1-terry_chen@wistron.corp-partner.google.com>
From:   Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
In-Reply-To: <20220510104829.1466968-1-terry_chen@wistron.corp-partner.google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org




> +static int create_bt_offload_dai_links(struct device *dev,
> +				       struct snd_soc_dai_link *links,
> +				       struct snd_soc_dai_link_component *cpus,
> +				       int *id, int ssp_bt)
> +{
> +	int ret = 0;

this variable is not used in the rest of this function, something's not
right here...

> +	/* bt offload */
> +	if (!(sof_cs42l42_quirk & SOF_BT_OFFLOAD_PRESENT))
> +		return 0;
> +
> +	links[*id].name = devm_kasprintf(dev, GFP_KERNEL, "SSP%d-BT",
> +					 ssp_bt);
> +	if (!links[*id].name)
> +		goto devm_err;

is this missing ret = -ENOMEM?

> +
> +	links[*id].id = *id;
> +	links[*id].codecs = dummy_component;
> +	links[*id].num_codecs = ARRAY_SIZE(dummy_component);
> +	links[*id].platforms = platform_component;
> +	links[*id].num_platforms = ARRAY_SIZE(platform_component);
> +
> +	links[*id].dpcm_playback = 1;
> +	links[*id].dpcm_capture = 1;
> +	links[*id].no_pcm = 1;
> +	links[*id].cpus = &cpus[*id];
> +	links[*id].num_cpus = 1;
> +
> +	links[*id].cpus->dai_name = devm_kasprintf(dev, GFP_KERNEL,
> +						   "SSP%d Pin",
> +						   ssp_bt);
> +	if (!links[*id].cpus->dai_name)
> +		goto devm_err;

same here, ret = -ENOMEM; ?

> +
> +	(*id)++;
> +
> +	return 0;
> +
> +devm_err:
> +	return ret;

or use what the existing code does for other links:

devm_err:
	return -ENOMEM;


> +}
> +
>  static struct snd_soc_dai_link *sof_card_dai_links_create(struct device *dev,
>  							  int ssp_codec,
>  							  int ssp_amp,
> +							  int ssp_bt,
>  							  int dmic_be_num,
>  							  int hdmi_num)
>  {
> @@ -522,6 +578,14 @@ static struct snd_soc_dai_link *sof_card_dai_links_create(struct device *dev,
>  				goto devm_err;
>  			}
>  			break;
> +		case LINK_BT:
> +			ret = create_bt_offload_dai_links(dev, links, cpus, &id, ssp_bt);
> +			if (ret < 0) {
> +				dev_err(dev, "fail to create bt offload dai links, ret %d\n",
> +					ret);

one line?

> +				goto devm_err;
> +			}
> +			break;
>  		case LINK_NONE:
>  			/* caught here if it's not used as terminator in macro */
>  		default:
> @@ -543,7 +607,7 @@ static int sof_audio_probe(struct platform_device *pdev)
>  	struct snd_soc_acpi_mach *mach;
>  	struct sof_card_private *ctx;
>  	int dmic_be_num, hdmi_num;
> -	int ret, ssp_amp, ssp_codec;
> +	int ret, ssp_bt, ssp_amp, ssp_codec;
>  
>  	ctx = devm_kzalloc(&pdev->dev, sizeof(*ctx), GFP_KERNEL);
>  	if (!ctx)
> @@ -568,6 +632,9 @@ static int sof_audio_probe(struct platform_device *pdev)
>  
>  	dev_dbg(&pdev->dev, "sof_cs42l42_quirk = %lx\n", sof_cs42l42_quirk);
>  
> +	ssp_bt = (sof_cs42l42_quirk & SOF_CS42L42_SSP_BT_MASK) >>
> +			SOF_CS42L42_SSP_BT_SHIFT;
> +
>  	ssp_amp = (sof_cs42l42_quirk & SOF_CS42L42_SSP_AMP_MASK) >>
>  			SOF_CS42L42_SSP_AMP_SHIFT;
>  
> @@ -578,9 +645,11 @@ static int sof_audio_probe(struct platform_device *pdev)
>  
>  	if (sof_cs42l42_quirk & SOF_SPEAKER_AMP_PRESENT)
>  		sof_audio_card_cs42l42.num_links++;
> +	if (sof_cs42l42_quirk & SOF_BT_OFFLOAD_PRESENT)
> +		sof_audio_card_cs42l42.num_links++;
>  
>  	dai_links = sof_card_dai_links_create(&pdev->dev, ssp_codec, ssp_amp,
> -					      dmic_be_num, hdmi_num);
> +					      ssp_bt, dmic_be_num, hdmi_num);
>  	if (!dai_links)
>  		return -ENOMEM;
>  
> @@ -621,6 +690,17 @@ static const struct platform_device_id board_ids[] = {
>  					SOF_CS42L42_SSP_AMP(1)) |
>  					SOF_CS42L42_DAILINK(LINK_HP, LINK_DMIC, LINK_HDMI, LINK_SPK, LINK_NONE),
>  	},
> +	{
> +		.name = "adl_mx98360a_cs4242",
> +		.driver_data = (kernel_ulong_t)(SOF_CS42L42_SSP_CODEC(0) |
> +					SOF_SPEAKER_AMP_PRESENT |
> +					SOF_MAX98360A_SPEAKER_AMP_PRESENT |
> +					SOF_CS42L42_SSP_AMP(1) |
> +					SOF_CS42L42_NUM_HDMIDEV(4) |
> +					SOF_BT_OFFLOAD_PRESENT |
> +					SOF_CS42L42_SSP_BT(2)) |
> +					SOF_CS42L42_DAILINK(LINK_HP, LINK_DMIC, LINK_HDMI, LINK_SPK, LINK_BT),
> +	},
>  	{ }
>  };
>  MODULE_DEVICE_TABLE(platform, board_ids);
> diff --git a/sound/soc/intel/common/soc-acpi-intel-adl-match.c b/sound/soc/intel/common/soc-acpi-intel-adl-match.c
> index 7c8cd00457f81..3f40519250a90 100644
> --- a/sound/soc/intel/common/soc-acpi-intel-adl-match.c
> +++ b/sound/soc/intel/common/soc-acpi-intel-adl-match.c
> @@ -384,6 +384,14 @@ struct snd_soc_acpi_mach snd_soc_acpi_intel_adl_machines[] = {
>  		.sof_fw_filename = "sof-adl.ri",
>  		.sof_tplg_filename = "sof-adl-cs35l41.tplg",
>  	},
> +	{
> +		.id = "10134242",
> +		.drv_name = "adl_mx98360a_cs4242",
> +		.machine_quirk = snd_soc_acpi_codec_list,
> +		.quirk_data = &adl_max98360a_amp,
> +		.sof_fw_filename = "sof-adl.ri",

no longer necessary, and probably will not compile. please remove this
field.

> +		.sof_tplg_filename = "sof-adl-max98360a-rt5682.tplg",

Why would you refer to a topology that uses a different codec?


