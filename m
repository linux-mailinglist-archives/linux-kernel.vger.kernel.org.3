Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 030D34F446E
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Apr 2022 00:24:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352519AbiDEUDG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Apr 2022 16:03:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51088 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1444536AbiDEPlj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Apr 2022 11:41:39 -0400
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9FC6D31364
        for <linux-kernel@vger.kernel.org>; Tue,  5 Apr 2022 07:05:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1649167536; x=1680703536;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=RykHeuHfrYKWlYaQCFedGFkCWMVDu/x+vCVK9n5m7R8=;
  b=M4RloeLrrM5SkpbzfepVSNIEBF6QX/8VSL3ca39daXwf0I3+rKbe96og
   CU0OsodiSpTIdql5eUpnktzNHMGIFzCt2tCI4t0bJbmijcsIBGvdu7iRv
   Qq/bJSsDsDrwNpb9PknwhiYdxQqPQ56fgV35o5Va1YN0fPLc1J1PArpza
   WY/ildP/2/+b9xwEYcaaEUgQV6snf+LPA3+uAV35fX6yoqaZtnXYuGTQE
   9n/IITSUOjhkzqOPRFIoyMGkgUEl+qndbIwUgaR2Xg5dXrvzD/3YDCtUT
   woQssGG98c8fy/U3eNpeqxmm5I2ZYZHZkUiWSQ8aqb7MgFua9nGGHSRsa
   Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10307"; a="259586402"
X-IronPort-AV: E=Sophos;i="5.90,236,1643702400"; 
   d="scan'208";a="259586402"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Apr 2022 07:05:36 -0700
X-IronPort-AV: E=Sophos;i="5.90,236,1643702400"; 
   d="scan'208";a="651903446"
Received: from ctveazey-mobl2.amr.corp.intel.com (HELO [10.255.230.126]) ([10.255.230.126])
  by fmsmga002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Apr 2022 07:05:32 -0700
Message-ID: <a312c7ea-9ae3-689d-5a23-4d16400bbbf1@linux.intel.com>
Date:   Mon, 4 Apr 2022 10:58:08 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Firefox/91.0 Thunderbird/91.5.0
Subject: Re: [PATCH v1] ASoC: Intel: sof_rt5682: Add support for max98360a
 speaker amp on SSP2
Content-Language: en-US
To:     Ajye Huang <ajye.huang@gmail.com>, linux-kernel@vger.kernel.org
Cc:     Cezary Rojewski <cezary.rojewski@intel.com>,
        Liam Girdwood <liam.r.girdwood@linux.intel.com>,
        Jie Yang <yang.jie@linux.intel.com>,
        Mark Brown <broonie@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Ranjani Sridharan <ranjani.sridharan@linux.intel.com>,
        Kai Vehmanen <kai.vehmanen@linux.intel.com>,
        Daniel Baluta <daniel.baluta@nxp.com>,
        Brent Lu <brent.lu@intel.com>,
        Bard Liao <yung-chuan.liao@linux.intel.com>,
        Yong Zhi <yong.zhi@intel.com>,
        Ajye Huang <ajye_huang@compal.corp-partner.google.com>,
        Mac Chiang <mac.chiang@intel.com>,
        Vamshi Krishna Gopal <vamshi.krishna.gopal@intel.com>,
        alsa-devel@alsa-project.org, sound-open-firmware@alsa-project.org
References: <20220324084708.2009375-1-ajye_huang@compal.corp-partner.google.com>
From:   Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
In-Reply-To: <20220324084708.2009375-1-ajye_huang@compal.corp-partner.google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.9 required=5.0 tests=BAYES_00,DATE_IN_PAST_12_24,
        DKIMWL_WL_HIGH,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 3/24/22 03:47, Ajye Huang wrote:
> Follow Intel's design to replace max98360a amp SSP2 reather than SSP1
> by judging DMI_OEM_STRING in sof_rt5682_quirk_table struct.
> And reusing max98357's topology since DAI setting could be leveraged.
> 
> Signed-off-by: Ajye Huang <ajye_huang@compal.corp-partner.google.com>

Acked-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>

> ---
>   sound/soc/intel/boards/sof_rt5682.c | 13 +++++++++++++
>   sound/soc/sof/sof-pci-dev.c         |  9 ++++++++-
>   2 files changed, 21 insertions(+), 1 deletion(-)
> 
> diff --git a/sound/soc/intel/boards/sof_rt5682.c b/sound/soc/intel/boards/sof_rt5682.c
> index ebec4d15edaa..7126fcb63d90 100644
> --- a/sound/soc/intel/boards/sof_rt5682.c
> +++ b/sound/soc/intel/boards/sof_rt5682.c
> @@ -212,6 +212,19 @@ static const struct dmi_system_id sof_rt5682_quirk_table[] = {
>   					SOF_SSP_BT_OFFLOAD_PRESENT),
>   
>   	},
> +	{
> +		.callback = sof_rt5682_quirk_cb,
> +		.matches = {
> +			DMI_MATCH(DMI_PRODUCT_FAMILY, "Google_Brya"),
> +			DMI_MATCH(DMI_OEM_STRING, "AUDIO-MAX98360_ALC5682I_I2S_AMP_SSP2"),
> +		},
> +		.driver_data = (void *)(SOF_RT5682_MCLK_EN |
> +					SOF_RT5682_SSP_CODEC(0) |
> +					SOF_SPEAKER_AMP_PRESENT |
> +					SOF_MAX98360A_SPEAKER_AMP_PRESENT |
> +					SOF_RT5682_SSP_AMP(2) |
> +					SOF_RT5682_NUM_HDMIDEV(4)),
> +	},
>   	{}
>   };
>   
> diff --git a/sound/soc/sof/sof-pci-dev.c b/sound/soc/sof/sof-pci-dev.c
> index 4c9596742844..12f5cff22448 100644
> --- a/sound/soc/sof/sof-pci-dev.c
> +++ b/sound/soc/sof/sof-pci-dev.c
> @@ -83,7 +83,14 @@ static const struct dmi_system_id sof_tplg_table[] = {
>   		},
>   		.driver_data = "sof-adl-max98357a-rt5682-2way.tplg",
>   	},
> -
> +	{
> +		.callback = sof_tplg_cb,
> +		.matches = {
> +			DMI_MATCH(DMI_PRODUCT_FAMILY, "Google_Brya"),
> +			DMI_MATCH(DMI_OEM_STRING, "AUDIO-MAX98360_ALC5682I_I2S_AMP_SSP2"),
> +		},
> +		.driver_data = "sof-adl-max98357a-rt5682.tplg",
> +	},
>   	{}
>   };
>   
