Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D0CC648AA38
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jan 2022 10:12:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349195AbiAKJMF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Jan 2022 04:12:05 -0500
Received: from mga07.intel.com ([134.134.136.100]:25098 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1349193AbiAKJMA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Jan 2022 04:12:00 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1641892320; x=1673428320;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=hoNyLm6qh7oxT5AY3Z7rwf030++LEGWMN8XV7SoNhok=;
  b=CNNaWuZ+94aNvNjHZj7QqHDaezs5xhM2zSEPC6iH7rTa9x1Upm0Aj4f1
   uzWp+7UVTww973qRPtLMnre/Z6320DlR2BJw13NkJ4oUTAjjgbuD2pDEa
   WnJleJIjuvJWQH+x/nQFcPSgQI/eA5w9zXtWI/D0veqJ967CU4unynWoE
   1F44AfTGmnhLfaBRh0jVNmVRJNP1UANdryTMgOvvjwj6Pl34kWRTKxHJu
   r+NAmrB4F+3ZTb/CpcW+KAvav5a1wA53tZKsehJ97tJWIUF7M0wuW9bSh
   +NMwROjgIq6ditkGYrhuANsz5UFq385YE7wkOwUwgIjQ2/HFdpsbE/Dto
   Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10223"; a="306794079"
X-IronPort-AV: E=Sophos;i="5.88,279,1635231600"; 
   d="scan'208";a="306794079"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Jan 2022 01:11:59 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,279,1635231600"; 
   d="scan'208";a="669756233"
Received: from kuha.fi.intel.com ([10.237.72.185])
  by fmsmga001.fm.intel.com with SMTP; 11 Jan 2022 01:11:56 -0800
Received: by kuha.fi.intel.com (sSMTP sendmail emulation); Tue, 11 Jan 2022 11:11:55 +0200
Date:   Tue, 11 Jan 2022 11:11:55 +0200
From:   Heikki Krogerus <heikki.krogerus@linux.intel.com>
To:     Martin Kepplinger <martin.kepplinger@puri.sm>
Cc:     gregkh@linuxfoundation.org, sven@svenpeter.dev,
        hdegoede@redhat.com, marcan@marcan.st, kernel@puri.sm,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1] usb: typec: tipd: keep default interrupts enabled
 during probe()
Message-ID: <Yd1J2w0RCOOaG4Ku@kuha.fi.intel.com>
References: <20220110163559.711404-1-martin.kepplinger@puri.sm>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220110163559.711404-1-martin.kepplinger@puri.sm>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Martin,

On Mon, Jan 10, 2022 at 05:35:59PM +0100, Martin Kepplinger wrote:
> Commit 9990f2f6264c ("usb: typec: tipd: Enable event interrupts by default")
> writes a fixed set of interrupts to TPS_REG_INT_MASK1. In case interrupts
> had been enabled by the firmware by default, these get disabled now
> which can break use cases. Only append to what is already enabled instead.

No, we have to know what are the interrupts that are actually needed.
Commmit 9990f2f6264c fixed an interrupt flood issue that was seen on
some platforms where the firmware I guess enabled absolutely
everything. This would just revert that.

So only enable the interrupts that you know you need.

> Fixes: 9990f2f6264c ("usb: typec: tipd: Enable event interrupts by default")

What is this fixing? What are the use cases you are talking about?

> Signed-off-by: Martin Kepplinger <martin.kepplinger@puri.sm>
> ---
>  drivers/usb/typec/tipd/core.c | 10 +++++++---
>  1 file changed, 7 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/usb/typec/tipd/core.c b/drivers/usb/typec/tipd/core.c
> index 6d27a5b5e3ca..365ee5494c15 100644
> --- a/drivers/usb/typec/tipd/core.c
> +++ b/drivers/usb/typec/tipd/core.c
> @@ -744,10 +744,14 @@ static int tps6598x_probe(struct i2c_client *client)
>  
>  		irq_handler = cd321x_interrupt;
>  	} else {
> +		ret = tps6598x_read64(tps, TPS_REG_INT_MASK1, &mask1);
> +		if (ret)
> +			return ret;
> +
>  		/* Enable power status, data status and plug event interrupts */
> -		mask1 = TPS_REG_INT_POWER_STATUS_UPDATE |
> -			TPS_REG_INT_DATA_STATUS_UPDATE |
> -			TPS_REG_INT_PLUG_EVENT;
> +		mask1 |= TPS_REG_INT_POWER_STATUS_UPDATE |
> +			 TPS_REG_INT_DATA_STATUS_UPDATE |
> +			 TPS_REG_INT_PLUG_EVENT;
>  	}
>  
>  	/* Make sure the controller has application firmware running */

thanks,

-- 
heikki
