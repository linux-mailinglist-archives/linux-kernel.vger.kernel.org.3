Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1A5A049BB00
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jan 2022 19:11:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230258AbiAYSLb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Jan 2022 13:11:31 -0500
Received: from mga03.intel.com ([134.134.136.65]:3493 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229462AbiAYSLQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jan 2022 13:11:16 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1643134267; x=1674670267;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=jdLQfxgAH6W2Y1TTjkAJ74N2Bxd2GuUgCsHwgxo/Rzc=;
  b=U/MvH5a8bFWavozyt4c68EBkTgdiEU1FZdlo7jSkmPUEN+EoyrUcCwkv
   JDwbO5NmQczmSPJd3NIieuebSBii45+bcXj2hQn4RRjf26/qmqlFLyYrL
   gjfxrFY1ZqLyyH0u4oz7F6ikl9dOhus3L9eXuDkTfpKv35mDpupWrpbAA
   yfPNBolmkVrUipK1dIPkNTA08pFEr89/15EuzX0d/RqfxEp+kS3NSIvIk
   sk5IsusXfprQTFF0Hinm7tC+kT9L2OqAipOry8gHL3vCHjjh7LOoWkauO
   LS5x/n1DafCTWHbmr2SEgTUxTeVYKVo+69AvVAQyAqZfnc1v56QorhAkJ
   w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10238"; a="246313823"
X-IronPort-AV: E=Sophos;i="5.88,315,1635231600"; 
   d="scan'208";a="246313823"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Jan 2022 10:11:00 -0800
X-IronPort-AV: E=Sophos;i="5.88,315,1635231600"; 
   d="scan'208";a="580837202"
Received: from smile.fi.intel.com ([10.237.72.61])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Jan 2022 10:10:57 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.95)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1nCQGM-00ELO6-FX;
        Tue, 25 Jan 2022 20:09:50 +0200
Date:   Tue, 25 Jan 2022 20:09:50 +0200
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Cc:     Tang Bin <tangbin@cmss.chinamobile.com>, broonie@kernel.org,
        cezary.rojewski@intel.com, liam.r.girdwood@linux.intel.com,
        yang.jie@linux.intel.com, perex@perex.cz, tiwai@suse.com,
        alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ASoC: Intel: atom: Remove redundant check to simplify
 the code
Message-ID: <YfA87pkRPA95aG2f@smile.fi.intel.com>
References: <20211125075028.8500-1-tangbin@cmss.chinamobile.com>
 <3ca07ce3-6d5c-20cc-8992-4700490ea472@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3ca07ce3-6d5c-20cc-8992-4700490ea472@linux.intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 29, 2021 at 10:22:41AM -0600, Pierre-Louis Bossart wrote:
> On 11/25/21 1:50 AM, Tang Bin wrote:

> > In the function sst_platform_get_resources(), if platform_get_irq()
> > failed, the return should not be zero, as the example in
> > platform.c is
> >   * int irq = platform_get_irq(pdev, 0)
> >   * if (irq < 0)
> >   * return irq;
> > So remove the redundant check to simplify the code.
> 
> Humm, it's a bit of a gray area.
> 
> the comments for platform_get_irq and platform_get_irq_optional say:
> 
> * Return: non-zero IRQ number on success, negative error number on failure.
> 
> but if you look at platform_get_irq_optional, there are two references
> to zero being a possible return value:
> 
> 	if (num == 0 && has_acpi_companion(&dev->dev)) {
> 		ret = acpi_dev_gpio_irq_get(ACPI_COMPANION(&dev->dev), num);
> 		/* Our callers expect -ENXIO for missing IRQs. */
> 		if (ret >= 0 || ret == -EPROBE_DEFER)

This is bogus == 0 check.

> 			goto out;
> 
> out_not_found:
> 	ret = -ENXIO;
> out:
> 	WARN(ret == 0, "0 is an invalid IRQ number\n");
> 	return ret;
> 
> https://elixir.bootlin.com/linux/latest/source/drivers/base/platform.c#L234
> 
> I am not sure if there's any merit in removing the test for the zero
> return value. It may be on the paranoid side but it's aligned with a
> possible code path in the platform code.
> 
> Or it could be that the platform code is wrong, and the label used
> should have been
> 
> /* Our callers expect -ENXIO for missing IRQs. */
> if (ret >= 0 || ret == -EPROBE_DEFER)
> 	goto out_not_found;

In case one wants to dive into new discussion on the topic:

https://lore.kernel.org/linux-serial/20220110195449.12448-2-s.shtylyov@omp.ru/T/#u

-- 
With Best Regards,
Andy Shevchenko


