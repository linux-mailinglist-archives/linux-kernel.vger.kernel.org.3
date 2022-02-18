Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BC6204BBF07
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Feb 2022 19:08:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238955AbiBRSIA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Feb 2022 13:08:00 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:43368 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238975AbiBRSH6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Feb 2022 13:07:58 -0500
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D39EC1F05D7
        for <linux-kernel@vger.kernel.org>; Fri, 18 Feb 2022 10:07:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1645207654; x=1676743654;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=P61hqkigcCXUA+lnv8eaEqIDmAf64Sj27hqBQtZm8c0=;
  b=FGtnaMkAlIQ3HLsest8x7jHyey1C6QklKNkkg7WXo2YzARk40dGXPhrg
   wvMJJGT12tFIzWS6Wrv3Lk7EreWUsVYdhlJxCjUEdB3g99m/lpl7/S22L
   2r0tpAWju+m/e8zYlKw3HWFvb7euy0RQfPrCOROp7F49s64V0pTE19/+r
   fWL0MF/O9QTwZIdNFOLMkjtVo25SK64iTT/9diCdxbOC2wWZQx3Pb0jaO
   xLncVAbeAk1ixzEBzfvwJxDV8QQZscinULydxZY5S0Ks8VO3+SEJz5yXe
   DqDP+3DR/OacI0hrIXEZkfU9wF4oy3heVAZonQCOoNL0bacWeeFYOs3UM
   A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10262"; a="251380282"
X-IronPort-AV: E=Sophos;i="5.88,379,1635231600"; 
   d="scan'208";a="251380282"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Feb 2022 10:07:34 -0800
X-IronPort-AV: E=Sophos;i="5.88,379,1635231600"; 
   d="scan'208";a="504079848"
Received: from ryanflyn-mobl.amr.corp.intel.com (HELO [10.212.54.106]) ([10.212.54.106])
  by orsmga002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Feb 2022 10:07:32 -0800
Message-ID: <2267504d-37cc-9a6e-5c4a-6051df95773c@linux.intel.com>
Date:   Fri, 18 Feb 2022 12:07:31 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Firefox/91.0 Thunderbird/91.5.0
Subject: Re: [PATCH] ASoC: SOF: Intel: Add topology overwrite for Felwinter
Content-Language: en-US
To:     Brent Lu <brent.lu@intel.com>, alsa-devel@alsa-project.org
Cc:     Ajye Huang <ajye_huang@compal.corp-partner.google.com>,
        Kai Vehmanen <kai.vehmanen@linux.intel.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        linux-kernel@vger.kernel.org, Takashi Iwai <tiwai@suse.com>,
        Ranjani Sridharan <ranjani.sridharan@linux.intel.com>,
        Mark Brown <broonie@kernel.org>,
        Daniel Baluta <daniel.baluta@nxp.com>,
        sound-open-firmware@alsa-project.org
References: <20220218082741.1707209-1-brent.lu@intel.com>
From:   Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
In-Reply-To: <20220218082741.1707209-1-brent.lu@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2/18/22 02:27, Brent Lu wrote:
> From: Ajye Huang <ajye_huang@compal.corp-partner.google.com>
> 
> The Felwinter uses four max98360a amplifiers on corresponding CH0~CH3.
> There are four amps on the board connecting to headphone to SSP0 port,
> amp to SSP1,and the DAI format would be DSP_A,8-slots, 32 bit slot-width.
> 
> CH0: L(Woofer), CH1:R(Woofer), CH2:L(Tweeter), CH3:R(Tweeter)
> 
> Signed-off-by: Ajye Huang <ajye_huang@compal.corp-partner.google.com>
> Signed-off-by: Brent Lu <brent.lu@intel.com>

This patch is already in the SOF tree and for some reason I didn't send
it, sorry about the delay.

Here are the tags we collected during the reviews.

Reviewed-by: Curtis Malainey <cujomalainey@chromium.org>
Reviewed-by: Bard Liao <yung-chuan.liao@linux.intel.com>
Reviewed-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>

> ---
>  sound/soc/sof/sof-pci-dev.c | 8 ++++++++
>  1 file changed, 8 insertions(+)
> 
> diff --git a/sound/soc/sof/sof-pci-dev.c b/sound/soc/sof/sof-pci-dev.c
> index 20c6ca37dbc4..61f2afd54c3e 100644
> --- a/sound/soc/sof/sof-pci-dev.c
> +++ b/sound/soc/sof/sof-pci-dev.c
> @@ -67,6 +67,14 @@ static const struct dmi_system_id sof_tplg_table[] = {
>  		},
>  		.driver_data = "sof-adl-max98390-ssp2-rt5682-ssp0.tplg",
>  	},
> +	{
> +		.callback = sof_tplg_cb,
> +		.matches = {
> +			DMI_MATCH(DMI_PRODUCT_FAMILY, "Google_Brya"),
> +			DMI_MATCH(DMI_OEM_STRING, "AUDIO_AMP-MAX98360_ALC5682VS_I2S_2WAY"),
> +		},
> +		.driver_data = "sof-adl-max98360a-rt5682-2way.tplg",
> +	},
>  
>  	{}
>  };
