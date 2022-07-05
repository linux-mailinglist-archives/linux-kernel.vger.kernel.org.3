Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3E47E56761C
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Jul 2022 20:01:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232107AbiGESBY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Jul 2022 14:01:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46216 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231414AbiGESBX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Jul 2022 14:01:23 -0400
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE4581EACF
        for <linux-kernel@vger.kernel.org>; Tue,  5 Jul 2022 11:01:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1657044082; x=1688580082;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=Pfm/RYAueDuO2Oi8EfsfQLxSrg3TUplLuLB+vxlNeh0=;
  b=ClfPpeiF+key4AYh7O11HzlIPDKs+x5MK5jemtTEMPC4AoBAskg6j/jf
   uCjWLEz5T4shE2iEUAFDIuRllTyQ0WFoqB4yx0szaLZHfHbRB9JPCHMO7
   9V41UMfjIOvWYX8D9EdQ0SRD96RallUT6wO0BjCVniIja+6ocSbUJg5zl
   3uXnnnOwPHKMNmmu3wMrSL0pqrwnVSWr5BcmWEzNY3ORGXc8S7a5bY+bw
   BHlGkXBGA5Vbn5UpyFPWfGVeLOsrEwKWQFyMUfaggvssqnOvQgkpIB2I8
   3ULqjn/Q+kKp3tYnWkP+sDbn/VvQIHw9wSoBMXx3LgrgZmX9k3TY0pruC
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10399"; a="282184037"
X-IronPort-AV: E=Sophos;i="5.92,247,1650956400"; 
   d="scan'208";a="282184037"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Jul 2022 10:53:54 -0700
X-IronPort-AV: E=Sophos;i="5.92,247,1650956400"; 
   d="scan'208";a="682608856"
Received: from wxu3-mobl1.amr.corp.intel.com (HELO [10.212.54.191]) ([10.212.54.191])
  by fmsmga003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Jul 2022 10:53:53 -0700
Message-ID: <377f2c4a-562b-9384-adfc-8180964c2b42@linux.intel.com>
Date:   Tue, 5 Jul 2022 11:57:37 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Firefox/91.0 Thunderbird/91.10.0
Subject: Re: [PATCH v2 2/2] ASoC: SOF: Intel: byt: remove duplicating driver
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
References: <20220705161102.76250-1-andriy.shevchenko@linux.intel.com>
 <20220705161102.76250-2-andriy.shevchenko@linux.intel.com>
From:   Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
In-Reply-To: <20220705161102.76250-2-andriy.shevchenko@linux.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 7/5/22 11:11, Andy Shevchenko wrote:
> device_get_match_data() in ACPI case calls similar to acpi_match_device().
> Hence there is no need to duplicate the call. Just assign what is in
> the id->driver_data.
> 
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

Acked-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>

Thanks Andy!

> ---
> v2: new patch (Pierre)
>  sound/soc/sof/intel/byt.c | 5 +----
>  1 file changed, 1 insertion(+), 4 deletions(-)
> 
> diff --git a/sound/soc/sof/intel/byt.c b/sound/soc/sof/intel/byt.c
> index 4ed8381eceda..e6dc4ff531c3 100644
> --- a/sound/soc/sof/intel/byt.c
> +++ b/sound/soc/sof/intel/byt.c
> @@ -465,10 +465,7 @@ static int sof_baytrail_probe(struct platform_device *pdev)
>  		return -ENODEV;
>  	}
>  
> -	desc = device_get_match_data(&pdev->dev);
> -	if (!desc)
> -		return -ENODEV;
> -
> +	desc = (const struct sof_dev_desc *)id->driver_data;
>  	if (desc == &sof_acpi_baytrail_desc && soc_intel_is_byt_cr(pdev))
>  		desc = &sof_acpi_baytrailcr_desc;
>  
