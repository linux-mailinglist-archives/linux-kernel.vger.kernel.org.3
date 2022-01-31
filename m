Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B48684A4423
	for <lists+linux-kernel@lfdr.de>; Mon, 31 Jan 2022 12:27:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1359534AbiAaL0d (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Jan 2022 06:26:33 -0500
Received: from mga18.intel.com ([134.134.136.126]:3561 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1377258AbiAaLR4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Jan 2022 06:17:56 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1643627876; x=1675163876;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=dmFtQZnXn+jCdVmYXidE6MNfkFywoIFKCcy975zz+ko=;
  b=R8KZZZMEjuEUlmA1JRzzs937mbxu5zy2HnCq1vu6KISAA/649bJbFxGH
   PDHZZzMSSbGdZRxEhLd8BvG4Y6/Zh+GSqohuoSscs6L/mT4s0pGbhRa9D
   9nT/aM5yfR5X6i6+IuoTUB0Kn6mRfy+Zta7mwVwW5/nljyy5RDdpfGnuX
   9pnk1UEV4D0Hev0H1+5q5wDOwOs3FUDpIRVG6Lt1jS8vqMCaIsscMpSoq
   xrJaMNqyN0dM7DbBJWKnCuggyHJUli9OppBlrGNCb+TllpXd1IVZV0IIK
   Z81iN50nie3EK1xCQmxjfLCczAHL4g+7oAdOfHIGHPoWAWw5w7xu/wRTp
   Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10243"; a="231011315"
X-IronPort-AV: E=Sophos;i="5.88,330,1635231600"; 
   d="scan'208";a="231011315"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Jan 2022 03:13:22 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,330,1635231600"; 
   d="scan'208";a="675695757"
Received: from kuha.fi.intel.com ([10.237.72.185])
  by fmsmga001.fm.intel.com with SMTP; 31 Jan 2022 03:13:18 -0800
Received: by kuha.fi.intel.com (sSMTP sendmail emulation); Mon, 31 Jan 2022 13:13:18 +0200
Date:   Mon, 31 Jan 2022 13:13:18 +0200
From:   Heikki Krogerus <heikki.krogerus@linux.intel.com>
To:     Prashant Malani <pmalani@chromium.org>
Cc:     linux-kernel@vger.kernel.org, Alyssa Ross <hi@alyssa.is>,
        Tzung-Bi Shih <tzungbi@google.com>,
        Benson Leung <bleung@chromium.org>,
        Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        Guenter Roeck <groeck@chromium.org>
Subject: Re: [PATCH v2] platform/chrome: cros_ec_typec: Check for EC device
Message-ID: <YffETvxepY2uU/qT@kuha.fi.intel.com>
References: <20220126190219.3095419-1-pmalani@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220126190219.3095419-1-pmalani@chromium.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 26, 2022 at 07:02:20PM +0000, Prashant Malani wrote:
> The Type C ACPI device on older Chromebooks is not generated correctly
> (since their EC firmware doesn't support the new commands required). In
> such cases, the crafted ACPI device doesn't have an EC parent, and it is
> therefore not useful (it shouldn't be generated in the first place since
> the EC firmware doesn't support any of the Type C commands).
> 
> To handle devices which use these older firmware revisions, check for
> the parent EC device handle, and fail the probe if it's not found.
> 
> Fixes: fdc6b21e2444 ("platform/chrome: Add Type C connector class driver")
> Reported-by: Alyssa Ross <hi@alyssa.is>
> Reviewed-by: Tzung-Bi Shih <tzungbi@google.com>
> Signed-off-by: Prashant Malani <pmalani@chromium.org>

FWIW:

Acked-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>

> ---
> Hi Alyssa, could you kindly test this with your existing setup? Thanks!
> 
> Changes in v2:
> - Added newlines as suggested by reviewers.
> - Added Reviewed-by tag from Tzung-Bi.
> 
>  drivers/platform/chrome/cros_ec_typec.c | 6 ++++++
>  1 file changed, 6 insertions(+)
> 
> diff --git a/drivers/platform/chrome/cros_ec_typec.c b/drivers/platform/chrome/cros_ec_typec.c
> index 5de0bfb0bc4d..952c1756f59e 100644
> --- a/drivers/platform/chrome/cros_ec_typec.c
> +++ b/drivers/platform/chrome/cros_ec_typec.c
> @@ -1075,7 +1075,13 @@ static int cros_typec_probe(struct platform_device *pdev)
>  		return -ENOMEM;
>  
>  	typec->dev = dev;
> +
>  	typec->ec = dev_get_drvdata(pdev->dev.parent);
> +	if (!typec->ec) {
> +		dev_err(dev, "couldn't find parent EC device\n");
> +		return -ENODEV;
> +	}
> +
>  	platform_set_drvdata(pdev, typec);
>  
>  	ret = cros_typec_get_cmd_version(typec);
> -- 
> 2.35.0.rc0.227.g00780c9af4-goog

-- 
heikki
