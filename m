Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 967B3564EAF
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Jul 2022 09:31:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233396AbiGDHbM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Jul 2022 03:31:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54046 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230344AbiGDHbI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Jul 2022 03:31:08 -0400
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C2DF65F3
        for <linux-kernel@vger.kernel.org>; Mon,  4 Jul 2022 00:31:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1656919866; x=1688455866;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=Ir0YeIg1QD17HDbXae1ShnLiqr2IQnnOCfkowLLq25M=;
  b=VmoUuO1Bh0j+UDh9Bd7GpwZ69/JV2SrRyQpFZaEIgCYpxbJ8nsSniVsM
   tx2k3+x8K5ZyG5D0TGi7xN6Bbc78YBxEMYpZvkaCHo5NWja1TMcn1jpPq
   JUPXPpZr7aBf5jMgP60Pr0Qmpsv0lkghqZZLJEFwg3xwHxrk+5vnTgIkL
   T1UmFXxphmLu8Qkm4Y3Qrm5trhNGvOHvclU81uF2CtnktbZKFEMyF3dW+
   FGHPe42otRkNhxcO1W0tjZ7Znf8ewEseHt+me5SL4Wt75ZFCaEKIkB4Nw
   +ZcCIP0XaAPd6L8am+c3gLah3+nOIK6VGYPymSnovDYbXTkQKy1I+GiVi
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10397"; a="271830130"
X-IronPort-AV: E=Sophos;i="5.92,243,1650956400"; 
   d="scan'208";a="271830130"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Jul 2022 00:31:06 -0700
X-IronPort-AV: E=Sophos;i="5.92,243,1650956400"; 
   d="scan'208";a="567075003"
Received: from rogerior-mobl1.ger.corp.intel.com (HELO [10.249.254.21]) ([10.249.254.21])
  by orsmga006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Jul 2022 00:31:02 -0700
Message-ID: <91f156ba-5d93-63d6-5fa0-86614bc370d3@linux.intel.com>
Date:   Mon, 4 Jul 2022 10:31:48 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Firefox/91.0 Thunderbird/91.10.0
Subject: Re: [PATCH v1 1/1] ASoC: SOF: Intel: bdw: remove duplicating driver
 data retrieval
Content-Language: en-US
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Mark Brown <broonie@kernel.org>,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        sound-open-firmware@alsa-project.org, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org
Cc:     Liam Girdwood <lgirdwood@gmail.com>,
        Bard Liao <yung-chuan.liao@linux.intel.com>,
        Ranjani Sridharan <ranjani.sridharan@linux.intel.com>,
        Kai Vehmanen <kai.vehmanen@linux.intel.com>,
        Daniel Baluta <daniel.baluta@nxp.com>,
        Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>
References: <20220703143533.62173-1-andriy.shevchenko@linux.intel.com>
From:   =?UTF-8?Q?P=c3=a9ter_Ujfalusi?= <peter.ujfalusi@linux.intel.com>
In-Reply-To: <20220703143533.62173-1-andriy.shevchenko@linux.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 03/07/2022 17:35, Andy Shevchenko wrote:
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
>  }

Would it not be simpler to just:

diff --git a/sound/soc/sof/intel/bdw.c b/sound/soc/sof/intel/bdw.c
index 26df780c702e..2ee22c2772ba 100644
--- a/sound/soc/sof/intel/bdw.c
+++ b/sound/soc/sof/intel/bdw.c
@@ -668,7 +668,6 @@ static int sof_broadwell_probe(struct platform_device *pdev)
 {
 	struct device *dev = &pdev->dev;
 	const struct acpi_device_id *id;
-	const struct sof_dev_desc *desc;
 	int ret;
 
 	id = acpi_match_device(dev->driver->acpi_match_table, dev);
@@ -681,11 +680,7 @@ static int sof_broadwell_probe(struct platform_device *pdev)
 		return -ENODEV;
 	}
 
-	desc = device_get_match_data(dev);
-	if (!desc)
-		return -ENODEV;
-
-	return sof_acpi_probe(pdev, device_get_match_data(dev));
+	return sof_acpi_probe(pdev, (const struct sof_dev_desc *)id->driver_data);
 }
 
 /* acpi_driver definition */
---
We don't use the desc in sof_broadwell_probe(), so we can just pass the id->driver_data

-- 
Péter
