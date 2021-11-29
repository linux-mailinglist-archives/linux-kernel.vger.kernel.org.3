Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B999E461BCC
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Nov 2021 17:34:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344888AbhK2Qhk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 Nov 2021 11:37:40 -0500
Received: from mga14.intel.com ([192.55.52.115]:63233 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230142AbhK2Qfj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Nov 2021 11:35:39 -0500
X-IronPort-AV: E=McAfee;i="6200,9189,10183"; a="236235546"
X-IronPort-AV: E=Sophos;i="5.87,273,1631602800"; 
   d="scan'208";a="236235546"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Nov 2021 08:32:12 -0800
X-IronPort-AV: E=Sophos;i="5.87,273,1631602800"; 
   d="scan'208";a="676418536"
Received: from ticela-nm-11.amr.corp.intel.com (HELO [10.212.98.225]) ([10.212.98.225])
  by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Nov 2021 08:32:10 -0800
Subject: Re: [PATCH] ASoC: Intel: atom: Remove redundant check to simplify the
 code
To:     Tang Bin <tangbin@cmss.chinamobile.com>, broonie@kernel.org,
        cezary.rojewski@intel.com, liam.r.girdwood@linux.intel.com,
        yang.jie@linux.intel.com, perex@perex.cz, tiwai@suse.com,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
References: <20211125075028.8500-1-tangbin@cmss.chinamobile.com>
From:   Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Message-ID: <3ca07ce3-6d5c-20cc-8992-4700490ea472@linux.intel.com>
Date:   Mon, 29 Nov 2021 10:22:41 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Firefox/78.0 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <20211125075028.8500-1-tangbin@cmss.chinamobile.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 11/25/21 1:50 AM, Tang Bin wrote:
> In the function sst_platform_get_resources(), if platform_get_irq()
> failed, the return should not be zero, as the example in
> platform.c is
>   * int irq = platform_get_irq(pdev, 0)
>   * if (irq < 0)
>   * return irq;
> So remove the redundant check to simplify the code.

Humm, it's a bit of a gray area.

the comments for platform_get_irq and platform_get_irq_optional say:

* Return: non-zero IRQ number on success, negative error number on failure.

but if you look at platform_get_irq_optional, there are two references
to zero being a possible return value:

	if (num == 0 && has_acpi_companion(&dev->dev)) {
		ret = acpi_dev_gpio_irq_get(ACPI_COMPANION(&dev->dev), num);
		/* Our callers expect -ENXIO for missing IRQs. */
		if (ret >= 0 || ret == -EPROBE_DEFER)
			goto out;

out_not_found:
	ret = -ENXIO;
out:
	WARN(ret == 0, "0 is an invalid IRQ number\n");
	return ret;

https://elixir.bootlin.com/linux/latest/source/drivers/base/platform.c#L234

I am not sure if there's any merit in removing the test for the zero
return value. It may be on the paranoid side but it's aligned with a
possible code path in the platform code.

Or it could be that the platform code is wrong, and the label used
should have been

/* Our callers expect -ENXIO for missing IRQs. */
if (ret >= 0 || ret == -EPROBE_DEFER)
	goto out_not_found;

Adding Andy Shevchenko for advice.

> 
> Signed-off-by: Tang Bin <tangbin@cmss.chinamobile.com>
> ---
>  sound/soc/intel/atom/sst/sst_acpi.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/sound/soc/intel/atom/sst/sst_acpi.c b/sound/soc/intel/atom/sst/sst_acpi.c
> index 3be64430c..696d547c5 100644
> --- a/sound/soc/intel/atom/sst/sst_acpi.c
> +++ b/sound/soc/intel/atom/sst/sst_acpi.c
> @@ -226,8 +226,8 @@ static int sst_platform_get_resources(struct intel_sst_drv *ctx)
>  	/* Find the IRQ */
>  	ctx->irq_num = platform_get_irq(pdev,
>  				ctx->pdata->res_info->acpi_ipc_irq_index);
> -	if (ctx->irq_num <= 0)
> -		return ctx->irq_num < 0 ? ctx->irq_num : -EIO;
> +	if (ctx->irq_num < 0)
> +		return ctx->irq_num;
>  
>  	return 0;
>  }
> 
