Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 887C956716B
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Jul 2022 16:46:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230449AbiGEOqQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Jul 2022 10:46:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41364 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229710AbiGEOqO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Jul 2022 10:46:14 -0400
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B9473E02B
        for <linux-kernel@vger.kernel.org>; Tue,  5 Jul 2022 07:46:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1657032372; x=1688568372;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=M/L99HgahfyNcfrwfI4x4soJM3zmpnAzKt5aLIhYXUc=;
  b=BXevqm91FfUzAVXrwTidnkd7lCmeiXfnJoJKAPm0zWdewvT+H+hxc5Yh
   My7EhD1PLp21h1zRRH0elITO1WCMPqWytRSkogQDpdYa340iTgJyFC3R2
   oIIpLQN38s36w4qcMKjEv4MPUAUeZgQihCuXObCKONy54PLs7xVcOCcfd
   P3L6dAc7s8dGTqa5b0BqlMM+LNSYFZbOipzAzKvkibWW5MiPXwbWSvmgV
   SUQe+B0dstzAUZzbqpa0rNoPII0dO5FMYuHXl3wZeyFTqJaypXqaw7tIo
   HJCpadmcsB2vJnDc9U5dy39wDCfB28EwWNw0m8x/5i8FCXRLSDb/h+Nc/
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10398"; a="284104417"
X-IronPort-AV: E=Sophos;i="5.92,247,1650956400"; 
   d="scan'208";a="284104417"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Jul 2022 07:46:12 -0700
X-IronPort-AV: E=Sophos;i="5.92,247,1650956400"; 
   d="scan'208";a="619857497"
Received: from achaudh2-mobl.amr.corp.intel.com (HELO [10.213.177.126]) ([10.213.177.126])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Jul 2022 07:46:10 -0700
Message-ID: <38cf149a-6238-241c-8ddd-4e4d10ca1f73@linux.intel.com>
Date:   Tue, 5 Jul 2022 09:42:46 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Firefox/91.0 Thunderbird/91.10.0
Subject: Re: [PATCH v1 1/1] ASoC: SOF: Intel: bdw: remove duplicating driver
 data retrieval
Content-Language: en-US
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Mark Brown <broonie@kernel.org>,
        Peter Ujfalusi <peter.ujfalusi@linux.intel.com>,
        sound-open-firmware@alsa-project.org, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org
Cc:     Liam Girdwood <lgirdwood@gmail.com>,
        Bard Liao <yung-chuan.liao@linux.intel.com>,
        Ranjani Sridharan <ranjani.sridharan@linux.intel.com>,
        Kai Vehmanen <kai.vehmanen@linux.intel.com>,
        Daniel Baluta <daniel.baluta@nxp.com>,
        Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>
References: <20220703143533.62173-1-andriy.shevchenko@linux.intel.com>
From:   Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
In-Reply-To: <20220703143533.62173-1-andriy.shevchenko@linux.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 7/3/22 09:35, Andy Shevchenko wrote:
> device_get_match_data() in ACPI case calls similar to acpi_match_device().
> Hence there is no need to duplicate the call. Just assign what is in
> the id->driver_data.
> 
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> ---
>  sound/soc/sof/intel/bdw.c | 7 ++-----
>  1 file changed, 2 insertions(+), 5 deletions(-)
> 
> diff --git a/sound/soc/sof/intel/bdw.c b/sound/soc/sof/intel/bdw.c
> index 26df780c702e..346813aa3768 100644
> --- a/sound/soc/sof/intel/bdw.c
> +++ b/sound/soc/sof/intel/bdw.c
> @@ -674,6 +674,7 @@ static int sof_broadwell_probe(struct platform_device *pdev)
>  	id = acpi_match_device(dev->driver->acpi_match_table, dev);
>  	if (!id)
>  		return -ENODEV;
> +	desc = (const struct sof_dev_desc *)id->driver_data;
>  
>  	ret = snd_intel_acpi_dsp_driver_probe(dev, id->id);
>  	if (ret != SND_INTEL_DSP_DRIVER_ANY && ret != SND_INTEL_DSP_DRIVER_SOF) {
> @@ -681,11 +682,7 @@ static int sof_broadwell_probe(struct platform_device *pdev)
>  		return -ENODEV;
>  	}
>  
> -	desc = device_get_match_data(dev);
> -	if (!desc)
> -		return -ENODEV;
> -
> -	return sof_acpi_probe(pdev, device_get_match_data(dev));
> +	return sof_acpi_probe(pdev, desc);

Thanks Andy, we have the same code pattern in sound/soc/sof/intel/byt.c,
can we change it as part of the series to keep the two files aligned?

>  }
>  
>  /* acpi_driver definition */
