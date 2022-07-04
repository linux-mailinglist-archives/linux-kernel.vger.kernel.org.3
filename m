Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 204E4564EC5
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Jul 2022 09:36:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232593AbiGDHfx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Jul 2022 03:35:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57568 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229477AbiGDHfv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Jul 2022 03:35:51 -0400
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F3618B92
        for <linux-kernel@vger.kernel.org>; Mon,  4 Jul 2022 00:35:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1656920150; x=1688456150;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=Q0jhAfVtaXX/0rO/evIVGyVYSNPYOU8ggf+ALIBohTc=;
  b=J6+Tb43RwF7wikl+VSnIbhC6Eb/TJxHU6WmwGeraFQbOZVqOaH6CDj4p
   E5I4KiRaDoUeoANNwZOvfLpr+MLXChgcNgAVxI+zL3SdAyE8J3xWhtQf/
   BjIDCBXbVQF6z4AKgICh7DkDBW3/q4C2Iqka9daRfI/lwKOEsuOndSGGR
   0Tcy8FU1F0RKXkqb6LKTPz5YIVRPS3yDfm4/kduKn6Nf4kn0ZWOS588tR
   l9zsh8+M2Ewvdlph6zrAkdVxm6xYUiJnQlF/+5siB0JSW6y6+xJLTfoP9
   NHJy8vbYe8faRlctVDsieomCpIHOFlb0EdpEUoWp/YE3cG1YcgPEvj5wP
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10397"; a="281819204"
X-IronPort-AV: E=Sophos;i="5.92,243,1650956400"; 
   d="scan'208";a="281819204"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Jul 2022 00:35:50 -0700
X-IronPort-AV: E=Sophos;i="5.92,243,1650956400"; 
   d="scan'208";a="567076613"
Received: from rogerior-mobl1.ger.corp.intel.com (HELO [10.249.254.21]) ([10.249.254.21])
  by orsmga006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Jul 2022 00:35:47 -0700
Message-ID: <9c67d656-9990-7206-58b4-3de25d8341a0@linux.intel.com>
Date:   Mon, 4 Jul 2022 10:36:33 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Firefox/91.0 Thunderbird/91.10.0
Subject: Re: [PATCH v2 1/1] ASoC: Intel: catpt: remove duplicating driver data
 retrieval
Content-Language: en-US
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
Cc:     Cezary Rojewski <cezary.rojewski@intel.com>,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        Liam Girdwood <liam.r.girdwood@linux.intel.com>,
        Bard Liao <yung-chuan.liao@linux.intel.com>,
        Ranjani Sridharan <ranjani.sridharan@linux.intel.com>,
        Kai Vehmanen <kai.vehmanen@linux.intel.com>,
        Mark Brown <broonie@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>
References: <20220703145152.62297-1-andriy.shevchenko@linux.intel.com>
From:   =?UTF-8?Q?P=c3=a9ter_Ujfalusi?= <peter.ujfalusi@linux.intel.com>
In-Reply-To: <20220703145152.62297-1-andriy.shevchenko@linux.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 03/07/2022 17:51, Andy Shevchenko wrote:
> device_get_match_data() in ACPI case calls similar to acpi_match_device().
> Hence there is no need to duplicate the call. Just assign what is in
> the id->driver_data.
> 
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> ---
> v2: dropped device_get_match_data() and rewrote commit message
>  sound/soc/intel/catpt/device.c | 5 +----
>  1 file changed, 1 insertion(+), 4 deletions(-)
> 
> diff --git a/sound/soc/intel/catpt/device.c b/sound/soc/intel/catpt/device.c
> index 85a34e37316d..2eeaeb962532 100644
> --- a/sound/soc/intel/catpt/device.c
> +++ b/sound/soc/intel/catpt/device.c
> @@ -247,6 +247,7 @@ static int catpt_acpi_probe(struct platform_device *pdev)
>  	id = acpi_match_device(dev->driver->acpi_match_table, dev);
>  	if (!id)
>  		return -ENODEV;
> +	spec = (const struct catpt_spec *)id->driver_data;
>  
>  	ret = snd_intel_acpi_dsp_driver_probe(dev, id->id);
>  	if (ret != SND_INTEL_DSP_DRIVER_ANY && ret != SND_INTEL_DSP_DRIVER_SST) {
> @@ -254,10 +255,6 @@ static int catpt_acpi_probe(struct platform_device *pdev)
>  		return -ENODEV;
>  	}
>  
> -	spec = device_get_match_data(dev);
> -	if (!spec)
> -		return -ENODEV;
> -
>  	cdev = devm_kzalloc(dev, sizeof(*cdev), GFP_KERNEL);
>  	if (!cdev)
>  		return -ENOMEM;

We could just pass the "(const struct catpt_spec *)id->driver_data" in
place of spec to catpt_dev_init() and we can get rid of the local
temporary pointer?

If not, then I would cast out the spec before it's use:
spec = (const struct catpt_spec *)id->driver_data;
catpt_dev_init(cdev, dev, spec);

-- 
Péter
