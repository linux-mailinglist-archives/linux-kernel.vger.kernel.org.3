Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0AC3E48CD72
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jan 2022 22:09:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232897AbiALVIw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Jan 2022 16:08:52 -0500
Received: from mga07.intel.com ([134.134.136.100]:51761 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230204AbiALVIv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Jan 2022 16:08:51 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1642021731; x=1673557731;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=cpb44JfA4XY3GrOTk1ODmib5BqJtK0tHceVZz1ByRGg=;
  b=hESgKsZFFRVxixxXcn/11kZRO00krqZXXk8SZeSCRE30juex4jmxOgc+
   vsuRGgtwlVD/Ku9vkMlqFvvU/FotYdgGbdEJlWqx8+07qH9yF80WyfOp5
   EdGO1Dv9vG/lgHr5Bb0lCap0eRkXF8VFJ9ev5W/61zsgouyva79hysmk0
   gf3VsNY1YDbep1W8ye0zaHQKVrKrGMNqdaQd/UxakhQTdw/p919+TybPj
   MybdcVjOIlzLlUG3aZGHYZ35E9xaCClX5fU5+3S5BfhajZedz8zCOTF49
   qEkD8cD3UaErKdM7p4XiMNYEATAi6PqaUQSUMOuUQLLK/tYz+rqIaTF34
   A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10225"; a="307203341"
X-IronPort-AV: E=Sophos;i="5.88,284,1635231600"; 
   d="scan'208";a="307203341"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Jan 2022 13:08:41 -0800
X-IronPort-AV: E=Sophos;i="5.88,284,1635231600"; 
   d="scan'208";a="475061669"
Received: from smile.fi.intel.com ([10.237.72.61])
  by orsmga006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Jan 2022 13:08:38 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.95)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1n7kq4-009vdf-Na;
        Wed, 12 Jan 2022 23:07:24 +0200
Date:   Wed, 12 Jan 2022 23:07:24 +0200
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Robert Hancock <robert.hancock@calian.com>
Cc:     linux-kernel@vger.kernel.org, giometti@enneenne.com,
        gregkh@linuxfoundation.org, rasm@fe.up.pt,
        jamesnuss@nanometrics.ca, akpm@linux-foundation.org
Subject: Re: [PATCH] pps: clients: gpio: Propagate return value from
 pps_gpio_probe
Message-ID: <Yd9DDJ2HmptwIITA@smile.fi.intel.com>
References: <20220112205214.2060954-1-robert.hancock@calian.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220112205214.2060954-1-robert.hancock@calian.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 12, 2022 at 02:52:14PM -0600, Robert Hancock wrote:
> If the pps-gpio driver was probed prior to the GPIO device it uses, the
> devm_gpiod_get call returned an -EPROBE_DEFER error, but pps_gpio_probe
> replaced that error code with -EINVAL, causing the pps-gpio probe to
> fail and not be retried later. Propagate the error return value so that
> deferred probe works properly.

FWIW,
Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

> Fixes: 161520451dfa (pps: new client driver using GPIO)
> Signed-off-by: Robert Hancock <robert.hancock@calian.com>
> ---
>  drivers/pps/clients/pps-gpio.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/pps/clients/pps-gpio.c b/drivers/pps/clients/pps-gpio.c
> index 35799e6401c9..2f4b11b4dfcd 100644
> --- a/drivers/pps/clients/pps-gpio.c
> +++ b/drivers/pps/clients/pps-gpio.c
> @@ -169,7 +169,7 @@ static int pps_gpio_probe(struct platform_device *pdev)
>  	/* GPIO setup */
>  	ret = pps_gpio_setup(dev);
>  	if (ret)
> -		return -EINVAL;
> +		return ret;
>  
>  	/* IRQ setup */
>  	ret = gpiod_to_irq(data->gpio_pin);
> -- 
> 2.31.1
> 

-- 
With Best Regards,
Andy Shevchenko


