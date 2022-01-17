Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 70FF7490A21
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jan 2022 15:15:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238829AbiAQOOr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Jan 2022 09:14:47 -0500
Received: from mga09.intel.com ([134.134.136.24]:55398 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232040AbiAQOOb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jan 2022 09:14:31 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1642428871; x=1673964871;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=dpdDCUgIFGr2FuwMabXwCtN6FdEIwM7gKE2hLUmGplQ=;
  b=I96sjmSgw4oe3wkv++h1RNQ9mKPLYX7q5I0SYBHqXU32XBhKecQKohLE
   ipyANRe8K0C6FVAbSyDbdGHI5nZbJR8MyWId9SJHP8jNHM9edFEf1iXoi
   NWDYUVIErlLyxvQaXxe72C6RzRZvGRwgqLIUZBdGA48vdpunxDDyTw0N9
   8HoPVoT/wP+lz75mX8lfmlwzDBUWv1kWqb/yQXmAxBqCvw5D9R4KZwrmZ
   rlnJXe1hYqsWHJEebo1nhYmCSAe/UUjv74caqBUR/VmG+gKgzw57ksJVp
   bsQrmL77qOENiphhcy3U230ngljFMgsRkCu22+Q4/SHhKNgJyQX5eLMXu
   A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10229"; a="244429786"
X-IronPort-AV: E=Sophos;i="5.88,295,1635231600"; 
   d="scan'208";a="244429786"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Jan 2022 06:10:55 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,295,1635231600"; 
   d="scan'208";a="671568402"
Received: from kuha.fi.intel.com ([10.237.72.185])
  by fmsmga001.fm.intel.com with SMTP; 17 Jan 2022 06:10:52 -0800
Received: by kuha.fi.intel.com (sSMTP sendmail emulation); Mon, 17 Jan 2022 16:10:51 +0200
Date:   Mon, 17 Jan 2022 16:10:51 +0200
From:   Heikki Krogerus <heikki.krogerus@linux.intel.com>
To:     Jon Hunter <jonathanh@nvidia.com>
Cc:     Stephan Gerhold <stephan@gerhold.net>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-tegra@vger.kernel.org
Subject: Re: [PATCH] usb: common: ulpi: Fix crash in ulpi_match()
Message-ID: <YeV466hTEyDwvmyL@kuha.fi.intel.com>
References: <20220114100217.59541-1-jonathanh@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220114100217.59541-1-jonathanh@nvidia.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jon,

On Fri, Jan 14, 2022 at 10:02:17AM +0000, Jon Hunter wrote:
> Commit 7495af930835 ("ARM: multi_v7_defconfig: Enable drivers for
> DragonBoard 410c") enables the CONFIG_PHY_QCOM_USB_HS for the ARM
> multi_v7_defconfig. Enabling this Kconfig is causing the kernel to crash
> on the Tegra20 Ventana platform in the ulpi_match() function.
> 
> The Qualcomm USB HS PHY driver that is enabled by CONFIG_PHY_QCOM_USB_HS,
> registers a ulpi_driver but this driver does not provide an 'id_table',
> so when ulpi_match() is called on the Tegra20 Ventana platform, it
> crashes when attempting to deference the id_table pointer which is not
> valid. The Qualcomm USB HS PHY driver uses device-tree for matching the
> ULPI driver with the device and so fix this crash by using device-tree
> for matching if the id_table is not valid.
> 
> Signed-off-by: Jon Hunter <jonathanh@nvidia.com>

So is this fixing commit 7495af930835, or perhaps commit ef6a7bcfb01c
("usb: ulpi: Support device discovery via DT")?

I would assume ef6a7bcfb01c ("usb: ulpi: Support device discovery via
DT"). Please include the appropriate Fixes tag.

> ---
>  drivers/usb/common/ulpi.c | 7 +++++--
>  1 file changed, 5 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/usb/common/ulpi.c b/drivers/usb/common/ulpi.c
> index 4169cf40a03b..8f8405b0d608 100644
> --- a/drivers/usb/common/ulpi.c
> +++ b/drivers/usb/common/ulpi.c
> @@ -39,8 +39,11 @@ static int ulpi_match(struct device *dev, struct device_driver *driver)
>  	struct ulpi *ulpi = to_ulpi_dev(dev);
>  	const struct ulpi_device_id *id;
>  
> -	/* Some ULPI devices don't have a vendor id so rely on OF match */
> -	if (ulpi->id.vendor == 0)
> +	/*
> +	 * Some ULPI devices don't have a vendor id
> +	 * or provide an id_table so rely on OF match.
> +	 */
> +	if (ulpi->id.vendor == 0 || !drv->id_table)
>  		return of_driver_match_device(dev, driver);
>  
>  	for (id = drv->id_table; id->vendor; id++)
> -- 
> 2.25.1

thanks,

-- 
heikki
