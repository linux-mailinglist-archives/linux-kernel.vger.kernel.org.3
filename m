Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 43ED14897B0
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jan 2022 12:41:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244851AbiAJLky (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Jan 2022 06:40:54 -0500
Received: from mga17.intel.com ([192.55.52.151]:5453 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S244869AbiAJLkx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Jan 2022 06:40:53 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1641814853; x=1673350853;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=wThY0rX5MtaVpBXKo+mLlMvEJGYv4hVw7LUBsGb9pJg=;
  b=g31BgJXrbRiZVMqIVhYYXhzqZf0hLeEr3zev+RKyqsTG8Ruhn+SukfIs
   5C5bbv6FsTESo/uB9KKcsL4F6oeCP0NyEP5O/G/FPyh2uWpx8FDL5b/Ex
   pdBtJ3DARC5NoqcJh378ePo1jfo/upIYUHdYoLpbxOJ/X7mauvrr2JQJ+
   OESN3ONPjH9l9wRf2Szl1Vof743gLNLntVU0RYbZ+3KJSnUGOzmaHLJ2b
   OMsjs39bMDtOvvPK1lKeYkyKlnwBD/YTpQnrtPEXVjOuUwlnaLPGu3TT0
   3BPoMDqQtImk8q2MmGRFHQS7oQyhigbhnd8QWcRecG+xowXRqL1eC6IUN
   A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10222"; a="223901587"
X-IronPort-AV: E=Sophos;i="5.88,276,1635231600"; 
   d="scan'208";a="223901587"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Jan 2022 03:40:52 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,276,1635231600"; 
   d="scan'208";a="669429402"
Received: from kuha.fi.intel.com ([10.237.72.185])
  by fmsmga001.fm.intel.com with SMTP; 10 Jan 2022 03:40:50 -0800
Received: by kuha.fi.intel.com (sSMTP sendmail emulation); Mon, 10 Jan 2022 13:40:49 +0200
Date:   Mon, 10 Jan 2022 13:40:49 +0200
From:   Heikki Krogerus <heikki.krogerus@linux.intel.com>
To:     Wayne Chang <waynec@nvidia.com>
Cc:     gregkh@linuxfoundation.org, singhanc@nvidia.com,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/1] ucsi_ccg: Check DEV_INT bit only when starting CCG4
Message-ID: <YdwbQeygHoF2wAcI@kuha.fi.intel.com>
References: <20220107092455.150504-1-waynec@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220107092455.150504-1-waynec@nvidia.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Fri, Jan 07, 2022 at 05:24:55PM +0800, Wayne Chang wrote:
> From: Sing-Han Chen <singhanc@nvidia.com>
> 
> after driver sending the UCSI_START cmd, CCGx would
> clear Bit 0:Device Interrupt in the INTR_REG if CCGX
> reset successfully.
> 
> however, there might be a chance that other bits in
> INTR_REG are not cleared due to internal data queued
> in PPM and cause the driver thinks CCGx reset failed.
> 
> the commit checks bit 0 in INTR_REG and ignore other
> bits. ucsi driver would reset PPM later.
> 
> Signed-off-by: Sing-Han Chen <singhanc@nvidia.com>
> Signed-off-by: WayneChang <waynec@nvidia.com>
                 ^^^^^^^^^^
You probable should have a space there. In any case, FWIW:

Acked-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>

> ---
>  drivers/usb/typec/ucsi/ucsi_ccg.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/usb/typec/ucsi/ucsi_ccg.c b/drivers/usb/typec/ucsi/ucsi_ccg.c
> index bff96d64dddf..6db7c8ddd51c 100644
> --- a/drivers/usb/typec/ucsi/ucsi_ccg.c
> +++ b/rivers/usb/typec/ucsi/ucsi_ccg.c
> @@ -325,7 +325,7 @@ static int ucsi_ccg_init(struct ucsi_ccg *uc)
>  		if (status < 0)
>  			return status;
>  
> -		if (!data)
> +		if (!(data & DEV_INT))
>  			return 0;
>  
>  		status = ccg_write(uc, CCGX_RAB_INTR_REG, &data, sizeof(data));
> -- 
> 2.25.1

thanks,

-- 
heikki
