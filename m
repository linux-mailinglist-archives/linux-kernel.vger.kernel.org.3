Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 86EB048BF43
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jan 2022 08:50:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348719AbiALHuw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Jan 2022 02:50:52 -0500
Received: from mga07.intel.com ([134.134.136.100]:49119 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S237906AbiALHut (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Jan 2022 02:50:49 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1641973849; x=1673509849;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=w/A8QwlNj0/nYgZRCUL0YzBzpWcnv1BTGNu1Z96AcjI=;
  b=COWawAmnlfZJ0ujdZDCkfSeroNHIkUykT2JORJ60cbFip6MxTOruwfN2
   xoNjLH1sOrXIfl3Vt6P3eStTwJG0ZOzkKVy7PKbYI4tGSeVcXjHiv53x7
   bLvCk8OTCHG3Nh1IBbEWL/RRdSCKP9KZQA1kizikqY/oSEsYSQHwwMlxu
   emuKBilRUwlPKrWLdAy5jlGdrChUeQLSisWPgWmHWcNwEL2zyQZGiTXJV
   ebd4E0dl/5v4GZJ5qWLU1L1WxmC8rw2CtdaAegFrZ+ASL0JBIL/MePJqX
   zmTZBOFRB1UtxXlogc6R6b3ixw45DFBb6Z81pizO4lbogQI6SvIv1PN8O
   w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10224"; a="307032297"
X-IronPort-AV: E=Sophos;i="5.88,282,1635231600"; 
   d="scan'208";a="307032297"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Jan 2022 23:50:49 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,282,1635231600"; 
   d="scan'208";a="670072590"
Received: from kuha.fi.intel.com ([10.237.72.185])
  by fmsmga001.fm.intel.com with SMTP; 11 Jan 2022 23:50:46 -0800
Received: by kuha.fi.intel.com (sSMTP sendmail emulation); Wed, 12 Jan 2022 09:50:45 +0200
Date:   Wed, 12 Jan 2022 09:50:45 +0200
From:   Heikki Krogerus <heikki.krogerus@linux.intel.com>
To:     Wayne Chang <waynec@nvidia.com>
Cc:     gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org,
        linux-usb@vger.kernel.org, singhanc@nvidia.com
Subject: Re: [PATCH v4 1/1] ucsi_ccg: Check DEV_INT bit only when starting
 CCG4
Message-ID: <Yd6IVb5hsc2jpXqn@kuha.fi.intel.com>
References: <20220112054950.615341-1-waynec@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220112054950.615341-1-waynec@nvidia.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Wed, Jan 12, 2022 at 01:49:50PM +0800, Wayne Chang wrote:
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
> Fixes: 247c554a14aa ("usb: typec: ucsi: add support for Cypress CCGx")

So... no need to take this to the stable kernel releases?

> Signed-off-by: Sing-Han Chen <singhanc@nvidia.com>
> Signed-off-by: Wayne Chang <waynec@nvidia.com>
> ---

What has changed since v3 (and v2) - there is no patch changelog here?

In case this is new to you, you list those changes under that '---'
line so they don't become part of the permanent changelog:

https://docs.kernel.org/process/submitting-patches.html#the-canonical-patch-format

>  drivers/usb/typec/ucsi/ucsi_ccg.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/usb/typec/ucsi/ucsi_ccg.c b/drivers/usb/typec/ucsi/ucsi_ccg.c
> index bff96d64dddf..6db7c8ddd51c 100644
> --- a/drivers/usb/typec/ucsi/ucsi_ccg.c
> +++ b/drivers/usb/typec/ucsi/ucsi_ccg.c
> @@ -325,7 +325,7 @@ static int ucsi_ccg_init(struct ucsi_ccg *uc)
>  		if (status < 0)
>  			return status;
>  
> -		if (!data)
> +		if (!(data & DEV_INT))
>  			return 0;
>  
>  		status = ccg_write(uc, CCGX_RAB_INTR_REG, &data, sizeof(data));

thanks,

-- 
heikki
