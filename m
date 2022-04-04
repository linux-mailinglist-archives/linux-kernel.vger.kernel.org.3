Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 63AB44F16A1
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Apr 2022 15:58:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376693AbiDDOAF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Apr 2022 10:00:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41662 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1376684AbiDDOAA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Apr 2022 10:00:00 -0400
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B6833EB9E;
        Mon,  4 Apr 2022 06:58:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1649080684; x=1680616684;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=SUtCU4D4WXKPWU41uhxxCOv92kwnxuWo+UfyL97LUHc=;
  b=BAdq5lKwff3Pqx5pFtDwsWTsHtQvDcidKiQsizZjb/OzEjLjQ9cSo5kC
   DgYKlkk+0DGV4xRCxY9X1CfCl4pO56+R6E8chUdxeArr5qO7vMFIFiuAb
   L+7fEPgv5YSGyVzETL5mK54kfiKBqrTvy2tcaDuEW65EONqNUrqCICyVA
   9hOh9MuFpJukdX0pVzhI3unV2bpCgthqZYWpD+MNpHMxYdxlBEuGrq50k
   RSmk2ly79Vg1KEV0ke+Y/MJoUvRQW89n5tfyzvJcrHsRnaVbEWesaSPVN
   q11VFvcP9l1PdcNLbIbzsX0W/iki897LmWKEM4gttOAfC0XJQhMIJpTF0
   A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10306"; a="260696387"
X-IronPort-AV: E=Sophos;i="5.90,234,1643702400"; 
   d="scan'208";a="260696387"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Apr 2022 06:58:04 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,234,1643702400"; 
   d="scan'208";a="696575693"
Received: from kuha.fi.intel.com ([10.237.72.185])
  by fmsmga001.fm.intel.com with SMTP; 04 Apr 2022 06:58:00 -0700
Received: by kuha.fi.intel.com (sSMTP sendmail emulation); Mon, 04 Apr 2022 16:57:59 +0300
Date:   Mon, 4 Apr 2022 16:57:59 +0300
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
Subject: Re: [PATCH 4/7] usb: typec: tipd: Provide
 POWER_SUPPLY_PROP_{CURRENT,VOLTAGE}_MAX
Message-ID: <Ykr5Z1t9pi++KIce@kuha.fi.intel.com>
References: <20220317154518.4082046-1-sebastian.krzyszkowiak@puri.sm>
 <20220317154518.4082046-5-sebastian.krzyszkowiak@puri.sm>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220317154518.4082046-5-sebastian.krzyszkowiak@puri.sm>
X-Spam-Status: No, score=-7.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Thu, Mar 17, 2022 at 04:45:15PM +0100, Sebastian Krzyszkowiak wrote:
> From: Angus Ainslie <angus@akkea.ca>
> 
> This helps downstream supplies to adjust their input limits.
> 
> Signed-off-by: Angus Ainslie <angus@akkea.ca>
> Signed-off-by: Guido Günther <agx@sigxcpu.org>
> Signed-off-by: Sebastian Krzyszkowiak <sebastian.krzyszkowiak@puri.sm>
> ---
>  drivers/usb/typec/tipd/core.c | 76 ++++++++++++++++++++++++++++++++++-
>  1 file changed, 74 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/usb/typec/tipd/core.c b/drivers/usb/typec/tipd/core.c
> index 80b4a9870caf..f3e8f1183f5b 100644
> --- a/drivers/usb/typec/tipd/core.c
> +++ b/drivers/usb/typec/tipd/core.c
> @@ -39,6 +39,11 @@
>  #define TPS_REG_RX_IDENTITY_SOP		0x48
>  #define TPS_REG_DATA_STATUS		0x5f
>  
> +#define TPS_USB_500mA	  500000
> +#define TPS_TYPEC_1500mA 1500000
> +#define TPS_TYPEC_3000mA 3000000
> +#define TPS_USB_5V	 5000000
> +
>  /* TPS_REG_SYSTEM_CONF bits */
>  #define TPS_SYSCONF_PORTINFO(c)		((c) & 7)
>  
> @@ -103,6 +108,8 @@ struct tps6598x {
>  static enum power_supply_property tps6598x_psy_props[] = {
>  	POWER_SUPPLY_PROP_USB_TYPE,
>  	POWER_SUPPLY_PROP_ONLINE,
> +	POWER_SUPPLY_PROP_CURRENT_MAX,
> +	POWER_SUPPLY_PROP_VOLTAGE_MAX,
>  };
>  
>  static enum power_supply_usb_type tps6598x_psy_usb_types[] = {
> @@ -294,6 +301,8 @@ static void tps6598x_disconnect(struct tps6598x *tps, u32 status)
>  	typec_set_orientation(tps->port, TYPEC_ORIENTATION_NONE);
>  	tps6598x_set_data_role(tps, TPS_STATUS_TO_TYPEC_DATAROLE(status), false);
>  
> +	memset(&tps->terms, 0, sizeof(struct tps6598x_pdo));
> +
>  	power_supply_changed(tps->psy);
>  }
>  
> @@ -577,6 +586,7 @@ static irqreturn_t tps6598x_interrupt(int irq, void *data)
>  	u64 event1;
>  	u64 event2;
>  	u32 status;
> +	bool psy_changed = false;
>  	int ret;
>  
>  	mutex_lock(&tps->lock);
> @@ -595,10 +605,13 @@ static irqreturn_t tps6598x_interrupt(int irq, void *data)
>  	if (!tps6598x_read_status(tps, &status))
>  		goto err_clear_ints;
>  
> -	if ((event1 | event2) & TPS_REG_INT_POWER_STATUS_UPDATE)
> +	if ((event1 | event2) & TPS_REG_INT_POWER_STATUS_UPDATE) {
>  		if (!tps6598x_read_power_status(tps))
>  			goto err_clear_ints;
>  
> +		psy_changed = true;
> +	}
> +
>  	if ((event1 | event2) & TPS_REG_INT_DATA_STATUS_UPDATE) {
>  		if (!tps6598x_read_data_status(tps))
>  			goto err_clear_ints;
> @@ -612,12 +625,18 @@ static irqreturn_t tps6598x_interrupt(int irq, void *data)
>  			dev_err(tps->dev, "failed to read pd contract: %d\n", ret);
>  			goto err_clear_ints;
>  		}
> +		psy_changed = true;

Can data status change alone really indicate that the contract has
changed?

>  	}
>  
>  	/* Handle plug insert or removal */
>  	if ((event1 | event2) & TPS_REG_INT_PLUG_EVENT)
>  		tps6598x_handle_plug_event(tps, status);
>  
> +	if ((event1 | event2) & TPS_REG_INT_HARD_RESET) {
> +		memset(&tps->terms, 0, sizeof(struct tps6598x_pdo));
> +		psy_changed = true;
> +	}
> +
>  err_clear_ints:
>  	tps6598x_write64(tps, TPS_REG_INT_CLEAR1, event1);
>  	tps6598x_write64(tps, TPS_REG_INT_CLEAR2, event2);
> @@ -625,6 +644,9 @@ static irqreturn_t tps6598x_interrupt(int irq, void *data)
>  err_unlock:
>  	mutex_unlock(&tps->lock);
>  
> +	if (psy_changed)
> +		power_supply_changed(tps->psy);
> +
>  	if (event1 | event2)
>  		return IRQ_HANDLED;
>  	return IRQ_NONE;
> @@ -671,6 +693,49 @@ static int tps6598x_psy_get_online(struct tps6598x *tps,
>  	} else {
>  		val->intval = 0;
>  	}
> +
> +	return 0;
> +}
> +
> +static int tps6598x_psy_get_max_current(struct tps6598x *tps,
> +					union power_supply_propval *val)
> +{
> +	enum typec_pwr_opmode mode;
> +
> +	mode = TPS_POWER_STATUS_PWROPMODE(tps->pwr_status);
> +	switch (mode) {
> +	case TYPEC_PWR_MODE_1_5A:
> +		val->intval = TPS_TYPEC_1500mA;
> +		break;
> +	case TYPEC_PWR_MODE_3_0A:
> +		val->intval = TPS_TYPEC_3000mA;
> +		break;
> +	case TYPEC_PWR_MODE_PD:
> +		val->intval = tps->terms.max_current ?: TPS_USB_500mA;
> +		break;
> +	default:
> +	case TYPEC_PWR_MODE_USB:
> +		val->intval = TPS_USB_500mA;
> +	}
> +	return 0;
> +}
> +
> +static int tps6598x_psy_get_max_voltage(struct tps6598x *tps,
> +					union power_supply_propval *val)
> +{
> +	enum typec_pwr_opmode mode;
> +
> +	mode = TPS_POWER_STATUS_PWROPMODE(tps->pwr_status);
> +	switch (mode) {
> +	case TYPEC_PWR_MODE_PD:
> +		val->intval = tps->terms.max_voltage ?: TPS_USB_5V;
> +		break;
> +	default:
> +	case TYPEC_PWR_MODE_1_5A:
> +	case TYPEC_PWR_MODE_3_0A:
> +	case TYPEC_PWR_MODE_USB:
> +		val->intval = TPS_USB_5V;
> +	}
>  	return 0;
>  }
>  
> @@ -691,6 +756,12 @@ static int tps6598x_psy_get_prop(struct power_supply *psy,
>  	case POWER_SUPPLY_PROP_ONLINE:
>  		ret = tps6598x_psy_get_online(tps, val);
>  		break;
> +	case POWER_SUPPLY_PROP_CURRENT_MAX:
> +		ret = tps6598x_psy_get_max_current(tps, val);
> +		break;
> +	case POWER_SUPPLY_PROP_VOLTAGE_MAX:
> +		ret = tps6598x_psy_get_max_voltage(tps, val);
> +		break;
>  	default:
>  		ret = -EINVAL;
>  		break;
> @@ -806,7 +877,8 @@ static int tps6598x_probe(struct i2c_client *client)
>  		mask1 = TPS_REG_INT_POWER_STATUS_UPDATE |
>  			TPS_REG_INT_DATA_STATUS_UPDATE |
>  			TPS_REG_INT_PLUG_EVENT |
> -			TPS_REG_INT_NEW_CONTRACT_AS_CONSUMER;
> +			TPS_REG_INT_NEW_CONTRACT_AS_CONSUMER |
> +			TPS_REG_INT_HARD_RESET;
>  	}
>  
>  	/* Make sure the controller has application firmware running */
> -- 
> 2.35.1

thanks,

-- 
heikki
