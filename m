Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 70FE44F15CA
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Apr 2022 15:22:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351320AbiDDNYb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Apr 2022 09:24:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54842 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241154AbiDDNY3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Apr 2022 09:24:29 -0400
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 84B433DA68;
        Mon,  4 Apr 2022 06:22:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1649078553; x=1680614553;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=Brz0s4RVmiMzt+dQ6G1J1x2m39pVMxu2cjfDv6ZP0GY=;
  b=V8uuSgVueNzgtiss+RJHWC9yRUETh8f3X8B1BGXy3dDQn0cARQUDqKf0
   OiaMBVK3CD1j5bi06k9BQCBYwyb5A+iNK5vsMUzk2YrOrLaa6+yox0j5h
   89esj7ZRGL5HXlKE8/phfGKg5SiFKN6LqOiyP1QYbbSZH0Hu0vzNP42Pt
   4wOCb22pVzjHY6GcAaNGfhBmdUdB0aKuMDqrEbn5PGYLnPgfgMPPmN3TT
   dXKJNoJldE4tPxzBmsTPXu6qKjE0ydzAVYa8dyR8UBn+LiV+Pf7dI4Isl
   nirmhReLgDEMpLKzK6W/LOmzoPtOmhbAJFUDcVThBb6eHpCkW6x6RnqYi
   w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10306"; a="285461893"
X-IronPort-AV: E=Sophos;i="5.90,234,1643702400"; 
   d="scan'208";a="285461893"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Apr 2022 06:22:32 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,234,1643702400"; 
   d="scan'208";a="696568285"
Received: from kuha.fi.intel.com ([10.237.72.185])
  by fmsmga001.fm.intel.com with SMTP; 04 Apr 2022 06:22:25 -0700
Received: by kuha.fi.intel.com (sSMTP sendmail emulation); Mon, 04 Apr 2022 16:22:25 +0300
Date:   Mon, 4 Apr 2022 16:22:25 +0300
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
Subject: Re: [PATCH 1/7] usb: typec: tipd: Only update power status on IRQ
Message-ID: <YkrxEU8nZxkY8txk@kuha.fi.intel.com>
References: <20220317154518.4082046-1-sebastian.krzyszkowiak@puri.sm>
 <20220317154518.4082046-2-sebastian.krzyszkowiak@puri.sm>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220317154518.4082046-2-sebastian.krzyszkowiak@puri.sm>
X-Spam-Status: No, score=-7.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 17, 2022 at 04:45:12PM +0100, Sebastian Krzyszkowiak wrote:
> From: Guido Günther <agx@sigxcpu.org>
> 
> Instead of refetching power status cache it and only update it when a
> change is signalled via irq. This simplifies tracing and adding more
> supply properties in follow up patches.
> 
> Signed-off-by: Guido Günther <agx@sigxcpu.org>
> Signed-off-by: Sebastian Krzyszkowiak <sebastian.krzyszkowiak@puri.sm>

Reviewed-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>

> ---
>  drivers/usb/typec/tipd/core.c | 32 ++++++++++++--------------------
>  1 file changed, 12 insertions(+), 20 deletions(-)
> 
> diff --git a/drivers/usb/typec/tipd/core.c b/drivers/usb/typec/tipd/core.c
> index 16b4560216ba..dfbba5ae9487 100644
> --- a/drivers/usb/typec/tipd/core.c
> +++ b/drivers/usb/typec/tipd/core.c
> @@ -93,6 +93,8 @@ struct tps6598x {
>  	struct power_supply *psy;
>  	struct power_supply_desc psy_desc;
>  	enum power_supply_usb_type usb_type;
> +
> +	u16 pwr_status;
>  };
>  
>  static enum power_supply_property tps6598x_psy_props[] = {
> @@ -230,17 +232,12 @@ static int tps6598x_connect(struct tps6598x *tps, u32 status)
>  {
>  	struct typec_partner_desc desc;
>  	enum typec_pwr_opmode mode;
> -	u16 pwr_status;
>  	int ret;
>  
>  	if (tps->partner)
>  		return 0;
>  
> -	ret = tps6598x_read16(tps, TPS_REG_POWER_STATUS, &pwr_status);
> -	if (ret < 0)
> -		return ret;
> -
> -	mode = TPS_POWER_STATUS_PWROPMODE(pwr_status);
> +	mode = TPS_POWER_STATUS_PWROPMODE(tps->pwr_status);
>  
>  	desc.usb_pd = mode == TYPEC_PWR_MODE_PD;
>  	desc.accessory = TYPEC_ACCESSORY_NONE; /* XXX: handle accessories */
> @@ -455,6 +452,7 @@ static bool tps6598x_read_power_status(struct tps6598x *tps)
>  		dev_err(tps->dev, "failed to read power status: %d\n", ret);
>  		return false;
>  	}
> +	tps->pwr_status = pwr_status;
>  	trace_tps6598x_power_status(pwr_status);
>  
>  	return true;
> @@ -601,15 +599,8 @@ static const struct regmap_config tps6598x_regmap_config = {
>  static int tps6598x_psy_get_online(struct tps6598x *tps,
>  				   union power_supply_propval *val)
>  {
> -	int ret;
> -	u16 pwr_status;
> -
> -	ret = tps6598x_read16(tps, TPS_REG_POWER_STATUS, &pwr_status);
> -	if (ret < 0)
> -		return ret;
> -
> -	if (TPS_POWER_STATUS_CONNECTION(pwr_status) &&
> -	    TPS_POWER_STATUS_SOURCESINK(pwr_status)) {
> +	if (TPS_POWER_STATUS_CONNECTION(tps->pwr_status) &&
> +	    TPS_POWER_STATUS_SOURCESINK(tps->pwr_status)) {
>  		val->intval = 1;
>  	} else {
>  		val->intval = 0;
> @@ -622,15 +613,11 @@ static int tps6598x_psy_get_prop(struct power_supply *psy,
>  				 union power_supply_propval *val)
>  {
>  	struct tps6598x *tps = power_supply_get_drvdata(psy);
> -	u16 pwr_status;
>  	int ret = 0;
>  
>  	switch (psp) {
>  	case POWER_SUPPLY_PROP_USB_TYPE:
> -		ret = tps6598x_read16(tps, TPS_REG_POWER_STATUS, &pwr_status);
> -		if (ret < 0)
> -			return ret;
> -		if (TPS_POWER_STATUS_PWROPMODE(pwr_status) == TYPEC_PWR_MODE_PD)
> +		if (TPS_POWER_STATUS_PWROPMODE(tps->pwr_status) == TYPEC_PWR_MODE_PD)
>  			val->intval = POWER_SUPPLY_USB_TYPE_PD;
>  		else
>  			val->intval = POWER_SUPPLY_USB_TYPE_C;
> @@ -837,6 +824,11 @@ static int tps6598x_probe(struct i2c_client *client)
>  	fwnode_handle_put(fwnode);
>  
>  	if (status & TPS_STATUS_PLUG_PRESENT) {
> +		ret = tps6598x_read16(tps, TPS_REG_POWER_STATUS, &tps->pwr_status);
> +		if (ret < 0) {
> +			dev_err(tps->dev, "failed to read power status: %d\n", ret);
> +			goto err_role_put;
> +		}
>  		ret = tps6598x_connect(tps, status);
>  		if (ret)
>  			dev_err(&client->dev, "failed to register partner\n");
> -- 
> 2.35.1

-- 
heikki
