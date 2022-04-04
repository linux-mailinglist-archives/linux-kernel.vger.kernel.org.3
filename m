Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D2D5B4F15E0
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Apr 2022 15:30:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352289AbiDDNbz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Apr 2022 09:31:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38192 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229890AbiDDNbw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Apr 2022 09:31:52 -0400
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0AAD41E3D3;
        Mon,  4 Apr 2022 06:29:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1649078996; x=1680614996;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=tTRFUipbpnIlHJtdlEwVC9gitLBlF0HbvPqEEMPBF44=;
  b=GKcX9o0k5FCH/+R59ffFm37X4EVkM4505/tIlp6apHvlyPyY8CxImVq+
   KBhci4hi3ZtQzJTsoAZOaU419yKQnFoE1VnOWNfOIjPgyZIkPtICF/pxJ
   O68UJiDbZULuk/92IoEeShUx0vnJV4ejnGNyuFWOveiqdkGB1LyGH8oSh
   jFp38OYgT/L31RfjES+/7x9tps6UDMr1/YN5wp1krQBnOdRLzNIHXek5m
   sZqk8x/I7fL4Im5eRGtyOSdwrQdq/ttl+z/QdqtuJqxiBpBVgYEL3YQ1s
   JqRYqWJc+aDQF/qO67k7kKYwin4z2v12FVQwP45jUav85nYgb8VHR3tXt
   Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10306"; a="258094515"
X-IronPort-AV: E=Sophos;i="5.90,234,1643702400"; 
   d="scan'208";a="258094515"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Apr 2022 06:29:55 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,234,1643702400"; 
   d="scan'208";a="696569602"
Received: from kuha.fi.intel.com ([10.237.72.185])
  by fmsmga001.fm.intel.com with SMTP; 04 Apr 2022 06:29:52 -0700
Received: by kuha.fi.intel.com (sSMTP sendmail emulation); Mon, 04 Apr 2022 16:29:51 +0300
Date:   Mon, 4 Apr 2022 16:29:51 +0300
From:   Heikki Krogerus <heikki.krogerus@linux.intel.com>
To:     Sebastian Krzyszkowiak <sebastian.krzyszkowiak@puri.sm>
Cc:     linux-usb@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Sven Peter <sven@svenpeter.dev>,
        Guido =?iso-8859-1?Q?G=FCnther?= <agx@sigxcpu.org>,
        Angus Ainslie <angus@akkea.ca>,
        Hector Martin <marcan@marcan.st>,
        Bryan O'Donoghue <bryan.odonoghue@linaro.org>,
        linux-kernel@vger.kernel.org, kernel@puri.sm
Subject: Re: [PATCH 2/7] usb: typec: tipd: set the data role on tps IRQ
Message-ID: <Ykryz2go6WJXkJ/5@kuha.fi.intel.com>
References: <20220317154518.4082046-1-sebastian.krzyszkowiak@puri.sm>
 <20220317154518.4082046-3-sebastian.krzyszkowiak@puri.sm>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220317154518.4082046-3-sebastian.krzyszkowiak@puri.sm>
X-Spam-Status: No, score=-7.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 17, 2022 at 04:45:13PM +0100, Sebastian Krzyszkowiak wrote:
> From: Angus Ainslie <angus@akkea.ca>
> 
> Don't immediately set the data role, only set it in response to the
> negotiated value notification from the tps6589x. Otherwise data role
> switch fails for DRP.
> 
> We only use values cached from the IRQ instead of poking I2C all
> the time.
> 
> The update is moved in a function that will become more useful in later
> commits.
> 
> Fixes: 18a6c866bb19 ("usb: typec: tps6598x: Add USB role switching logic")
> Signed-off-by: Angus Ainslie <angus@akkea.ca>
> Signed-off-by: Sebastian Krzyszkowiak <sebastian.krzyszkowiak@puri.sm>

Fixes tag but but no Cc: stable... tag?

Is there some reason why you don't have the stable tag, i.e. why
shouldn't this be added to the stable kernels?

> ---
>  drivers/usb/typec/tipd/core.c | 23 +++++++++++++++++++----
>  1 file changed, 19 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/usb/typec/tipd/core.c b/drivers/usb/typec/tipd/core.c
> index dfbba5ae9487..f387786ff95e 100644
> --- a/drivers/usb/typec/tipd/core.c
> +++ b/drivers/usb/typec/tipd/core.c
> @@ -94,6 +94,7 @@ struct tps6598x {
>  	struct power_supply_desc psy_desc;
>  	enum power_supply_usb_type usb_type;
>  
> +	u32 data_status;
>  	u16 pwr_status;
>  };
>  
> @@ -271,6 +272,15 @@ static int tps6598x_connect(struct tps6598x *tps, u32 status)
>  	return 0;
>  }
>  
> +static int
> +tps6598x_update_data_status(struct tps6598x *tps, u32 status)
> +{
> +	tps6598x_set_data_role(tps, TPS_STATUS_TO_TYPEC_DATAROLE(status),
> +			       !!(tps->data_status & TPS_DATA_STATUS_DATA_CONNECTION));
> +	trace_tps6598x_data_status(tps->data_status);
> +	return 0;
> +}
> +
>  static void tps6598x_disconnect(struct tps6598x *tps, u32 status)
>  {
>  	if (!IS_ERR(tps->partner))
> @@ -370,8 +380,6 @@ static int tps6598x_dr_set(struct typec_port *port, enum typec_data_role role)
>  		goto out_unlock;
>  	}
>  
> -	tps6598x_set_data_role(tps, role, true);
> -
>  out_unlock:
>  	mutex_unlock(&tps->lock);
>  
> @@ -437,6 +445,7 @@ static bool tps6598x_read_data_status(struct tps6598x *tps)
>  		dev_err(tps->dev, "failed to read data status: %d\n", ret);
>  		return false;
>  	}
> +	tps->data_status = data_status;
>  	trace_tps6598x_data_status(data_status);
>  
>  	return true;
> @@ -497,10 +506,13 @@ static irqreturn_t cd321x_interrupt(int irq, void *data)
>  		if (!tps6598x_read_power_status(tps))
>  			goto err_clear_ints;
>  
> -	if (event & APPLE_CD_REG_INT_DATA_STATUS_UPDATE)
> +	if (event & APPLE_CD_REG_INT_DATA_STATUS_UPDATE) {
>  		if (!tps6598x_read_data_status(tps))
>  			goto err_clear_ints;
>  
> +		tps6598x_update_data_status(tps, status);
> +	}
> +
>  	/* Handle plug insert or removal */
>  	if (event & APPLE_CD_REG_INT_PLUG_EVENT)
>  		tps6598x_handle_plug_event(tps, status);
> @@ -544,10 +556,13 @@ static irqreturn_t tps6598x_interrupt(int irq, void *data)
>  		if (!tps6598x_read_power_status(tps))
>  			goto err_clear_ints;
>  
> -	if ((event1 | event2) & TPS_REG_INT_DATA_STATUS_UPDATE)
> +	if ((event1 | event2) & TPS_REG_INT_DATA_STATUS_UPDATE) {
>  		if (!tps6598x_read_data_status(tps))
>  			goto err_clear_ints;
>  
> +		tps6598x_update_data_status(tps, status);
> +	}
> +
>  	/* Handle plug insert or removal */
>  	if ((event1 | event2) & TPS_REG_INT_PLUG_EVENT)
>  		tps6598x_handle_plug_event(tps, status);
> -- 
> 2.35.1

-- 
heikki
