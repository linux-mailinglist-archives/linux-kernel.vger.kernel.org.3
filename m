Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7F7AE4644EB
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Dec 2021 03:32:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241363AbhLACgG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Nov 2021 21:36:06 -0500
Received: from mga09.intel.com ([134.134.136.24]:34551 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235229AbhLACgD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Nov 2021 21:36:03 -0500
X-IronPort-AV: E=McAfee;i="6200,9189,10184"; a="236188975"
X-IronPort-AV: E=Sophos;i="5.87,277,1631602800"; 
   d="scan'208";a="236188975"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Nov 2021 18:32:43 -0800
X-IronPort-AV: E=Sophos;i="5.87,277,1631602800"; 
   d="scan'208";a="744974606"
Received: from vschult-mobl1.amr.corp.intel.com (HELO [10.212.122.173]) ([10.212.122.173])
  by fmsmga006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Nov 2021 18:32:42 -0800
Subject: Re: [PATCH] ALSA: hda: intel-dsp-config: add JasperLake support
To:     Brent Lu <brent.lu@intel.com>, alsa-devel@alsa-project.org
Cc:     Kai Vehmanen <kai.vehmanen@linux.intel.com>,
        linux-kernel@vger.kernel.org, Takashi Iwai <tiwai@suse.com>,
        Hans de Goede <hdegoede@redhat.com>,
        Bard Liao <bard.liao@intel.com>
References: <20211201004628.1153763-1-brent.lu@intel.com>
From:   Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Message-ID: <4e0ec119-2b15-644d-9cab-b2e19b5c0e48@linux.intel.com>
Date:   Tue, 30 Nov 2021 20:32:39 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Firefox/78.0 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <20211201004628.1153763-1-brent.lu@intel.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 11/30/21 6:46 PM, Brent Lu wrote:
> Add rules to select SOF driver for Jasper Lake systems if digital
> microphone is present or the system is a Chromebook.

Thanks Brent, yes this is an oversight, we should have added this a long
time ago.

I don't think however that this will apply on Takashi's for-next branch,
it'll conflict with the ALSA: intel-dsp-config: add quirk for JSL
devices based on ES8336 codec

+/* JasperLake */
+#if IS_ENABLED(CONFIG_SND_SOC_SOF_JASPERLAKE)
+	{
+		.flags = FLAG_SOF,
+		.device = 0x4dc8,
+		.codec_hid = "ESSX8336",
+	},
+#endif

Do you mind rebasing and resending the update? Let's keep the ESS stuff
last as done in other platforms, and add your changes on top of this.

Thanks!

> 
> Signed-off-by: Brent Lu <brent.lu@intel.com>
> ---
>  sound/hda/intel-dsp-config.c | 21 +++++++++++++++++++++
>  1 file changed, 21 insertions(+)
> 
> diff --git a/sound/hda/intel-dsp-config.c b/sound/hda/intel-dsp-config.c
> index b9ac9e9e45a4..be47a1ca12b6 100644
> --- a/sound/hda/intel-dsp-config.c
> +++ b/sound/hda/intel-dsp-config.c
> @@ -299,6 +299,27 @@ static const struct config_entry config_table[] = {
>  	},
>  #endif
>  
> +/* Jasper Lake */
> +#if IS_ENABLED(CONFIG_SND_SOC_SOF_JASPERLAKE)
> +	{
> +		.flags = FLAG_SOF,
> +		.device = 0x4dc8,
> +		.dmi_table = (const struct dmi_system_id []) {
> +			{
> +				.ident = "Google Chromebooks",
> +				.matches = {
> +					DMI_MATCH(DMI_SYS_VENDOR, "Google"),
> +				}
> +			},
> +			{}
> +		}
> +	},
> +	{
> +		.flags = FLAG_SOF | FLAG_SOF_ONLY_IF_DMIC,
> +		.device = 0x4dc8,
> +	},
> +#endif
> +
>  /* Tigerlake */
>  #if IS_ENABLED(CONFIG_SND_SOC_SOF_TIGERLAKE)
>  	{
> 
