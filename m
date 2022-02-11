Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2CEE24B1A56
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Feb 2022 01:21:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346255AbiBKAU5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Feb 2022 19:20:57 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:53274 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346244AbiBKAUz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Feb 2022 19:20:55 -0500
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F02B5594;
        Thu, 10 Feb 2022 16:20:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1644538855; x=1676074855;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=e5IiG17cQUjJ9PQOtAwSdbXG1C8VuyC2rEhJR099Nh0=;
  b=CKOumQBxcF5ZMTqiM+NbGG2w10b7obDNAH4wV+Qv62oVb2GAExdFxbHT
   E9G5xVN37/aaf8OWhVbYFNNRwgBheYeB/GUo4j43sC11t0VbptYfSVK1Y
   jYrmmzdO0Wn/h0aYx+Z7EWuSJE2vcu9tuSQYVhr47s41otER/udhWTmQJ
   FJszQIsh+J1axg99dYqYt0JrWE9H3gFtUkUCmZMsNovYcG+5b7DDPGk4U
   BIIFRbSyskrPEo+vsAxj41EtFNGwI3VIaxmwEAhVnsVU6o89BgeTK03eh
   sIRtZQlGN1Ikvzr+iobUoTRRDkeULjEJiyDW7RGCRw5pm8xiqFJvLDeEB
   w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10254"; a="336046688"
X-IronPort-AV: E=Sophos;i="5.88,359,1635231600"; 
   d="scan'208";a="336046688"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Feb 2022 16:20:55 -0800
X-IronPort-AV: E=Sophos;i="5.88,359,1635231600"; 
   d="scan'208";a="774072606"
Received: from wlincolx-mobl.amr.corp.intel.com (HELO [10.212.86.106]) ([10.212.86.106])
  by fmsmga005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Feb 2022 16:20:54 -0800
Message-ID: <d26561a1-ddd4-aea0-792d-efce104ad44f@linux.intel.com>
Date:   Thu, 10 Feb 2022 18:20:53 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Firefox/91.0 Thunderbird/91.5.0
Subject: Re: [PATCH 3/9] ASoC: Intel: bytcr_wm5102: use GFP_KERNEL
Content-Language: en-US
To:     Julia Lawall <Julia.Lawall@inria.fr>,
        Cezary Rojewski <cezary.rojewski@intel.com>,
        Hans de Goede <hdegoede@redhat.com>
Cc:     alsa-devel@alsa-project.org, kernel-janitors@vger.kernel.org,
        Takashi Iwai <tiwai@suse.com>,
        Jie Yang <yang.jie@linux.intel.com>,
        Liam Girdwood <liam.r.girdwood@linux.intel.com>,
        Mark Brown <broonie@kernel.org>, linux-kernel@vger.kernel.org
References: <20220210204223.104181-1-Julia.Lawall@inria.fr>
 <20220210204223.104181-4-Julia.Lawall@inria.fr>
From:   Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
In-Reply-To: <20220210204223.104181-4-Julia.Lawall@inria.fr>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2/10/22 14:42, Julia Lawall wrote:
> Platform_driver probe functions aren't called with locks held
> and thus don't need GFP_ATOMIC. Use GFP_KERNEL instead.
> 
> Problem found with Coccinelle.

Thanks Julia, indeed it's the only case where GFP_ATOMIC is used for
machine drivers.

This was already present in the initial Android driver from Intel (2013)
[1] and missed in the multiple passes to get this upstream.

Acked-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>

[1]
https://github.com/lenovo-yt2-dev/android_kernel_lenovo_baytrail/blob/cm-12.1/sound/soc/intel/board/byt_bl_wm5102.c

> 
> Signed-off-by: Julia Lawall <Julia.Lawall@inria.fr>
> 
> ---
>  sound/soc/intel/boards/bytcr_wm5102.c |    2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/sound/soc/intel/boards/bytcr_wm5102.c b/sound/soc/intel/boards/bytcr_wm5102.c
> index 504ef4cab111..8d8e96e3cd2d 100644
> --- a/sound/soc/intel/boards/bytcr_wm5102.c
> +++ b/sound/soc/intel/boards/bytcr_wm5102.c
> @@ -389,7 +389,7 @@ static int snd_byt_wm5102_mc_probe(struct platform_device *pdev)
>  	bool sof_parent;
>  	int ret;
>  
> -	priv = devm_kzalloc(dev, sizeof(*priv), GFP_ATOMIC);
> +	priv = devm_kzalloc(dev, sizeof(*priv), GFP_KERNEL);
>  	if (!priv)
>  		return -ENOMEM;
>  
> 
