Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 59A294F164A
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Apr 2022 15:43:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346734AbiDDNos (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Apr 2022 09:44:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35232 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1358925AbiDDNog (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Apr 2022 09:44:36 -0400
Received: from mga06.intel.com (mga06.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D74713EB9A;
        Mon,  4 Apr 2022 06:42:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1649079747; x=1680615747;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=Y1C6dwVLfka4/1H121Kb4RhxCgFVKIXeh7NYY9C6XAI=;
  b=FsgfYlGEn7sEbHG5d1UgpzPq5JNdvMJytCcoE829cMlLf7ey+gh0yG0g
   PVoKZb5dEvO+shgWXPyC5Qv2ZNnz9JwhaC++Wuo9zMa+3jJ2Pji4qaokg
   PABzje9ktAiHNQB7mVzAc8h8bVb7EdbeEFWBdihwuClxY5kNMPvTRG5FB
   L30S5rlPPwdvFYV9kmpnI5VnNMIkRTPP5NkFE2swRVGy0fUu/oyWnvCbY
   ehOjmzgFEUiHS/Odp59gnrzSLpKudnu1+9xs3Vr7ZIyx4ZtH/ux02eFuN
   v25GC+NSXJV/4QNwBSrTM8LgKA17QGJCNTxL7l/6uSFG5poQgyvMGuLkp
   Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10306"; a="321210837"
X-IronPort-AV: E=Sophos;i="5.90,234,1643702400"; 
   d="scan'208";a="321210837"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Apr 2022 06:42:27 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,234,1643702400"; 
   d="scan'208";a="696572673"
Received: from kuha.fi.intel.com ([10.237.72.185])
  by fmsmga001.fm.intel.com with SMTP; 04 Apr 2022 06:42:23 -0700
Received: by kuha.fi.intel.com (sSMTP sendmail emulation); Mon, 04 Apr 2022 16:42:22 +0300
Date:   Mon, 4 Apr 2022 16:42:22 +0300
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
Subject: Re: [PATCH 3/7] usb: typec: tipd: Add trace event for SINK PD
 contract
Message-ID: <Ykr1vop9m2GyQ02m@kuha.fi.intel.com>
References: <20220317154518.4082046-1-sebastian.krzyszkowiak@puri.sm>
 <20220317154518.4082046-4-sebastian.krzyszkowiak@puri.sm>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220317154518.4082046-4-sebastian.krzyszkowiak@puri.sm>
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 17, 2022 at 04:45:14PM +0100, Sebastian Krzyszkowiak wrote:
> From: Angus Ainslie <angus@akkea.ca>
> 
> This allows to trace the negotiated contract as sink. It's
> only updated when the contract is actually established.

With the PDOs (and also RDO) I think we'll rely on the sysfs interface
that I mentioned once it's ready, but since this is only trace stuff, I
guess it's okay to take this in the mean time.

I in any case noticed one issue below...

> Co-developed-by: Guido Günther <agx@sigxcpu.org>
> Signed-off-by: Guido Günther <agx@sigxcpu.org>
> Signed-off-by: Angus Ainslie <angus@akkea.ca>
> Signed-off-by: Sebastian Krzyszkowiak <sebastian.krzyszkowiak@puri.sm>
> ---
>  drivers/usb/typec/tipd/core.c     | 63 ++++++++++++++++++++++++++++++-
>  drivers/usb/typec/tipd/tps6598x.h | 30 +++++++++++++++
>  drivers/usb/typec/tipd/trace.h    | 38 +++++++++++++++++++
>  3 files changed, 129 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/usb/typec/tipd/core.c b/drivers/usb/typec/tipd/core.c
> index f387786ff95e..80b4a9870caf 100644
> --- a/drivers/usb/typec/tipd/core.c
> +++ b/drivers/usb/typec/tipd/core.c
> @@ -34,6 +34,7 @@
>  #define TPS_REG_STATUS			0x1a
>  #define TPS_REG_SYSTEM_CONF		0x28
>  #define TPS_REG_CTRL_CONF		0x29
> +#define TPS_REG_ACTIVE_CONTRACT		0x34
>  #define TPS_REG_POWER_STATUS		0x3f
>  #define TPS_REG_RX_IDENTITY_SOP		0x48
>  #define TPS_REG_DATA_STATUS		0x5f
> @@ -93,6 +94,7 @@ struct tps6598x {
>  	struct power_supply *psy;
>  	struct power_supply_desc psy_desc;
>  	enum power_supply_usb_type usb_type;
> +	struct tps6598x_pdo terms;
>  
>  	u32 data_status;
>  	u16 pwr_status;
> @@ -528,6 +530,47 @@ static irqreturn_t cd321x_interrupt(int irq, void *data)
>  	return IRQ_NONE;
>  }
>  
> +static int tps6598x_get_active_pd_contract(struct tps6598x *tps)
> +{
> +	u64 contract;
> +	int type;
> +	int max_power;
> +	int ret = 0;
> +
> +	ret = tps6598x_block_read(tps, TPS_REG_ACTIVE_CONTRACT, &contract, 6);
> +	if (ret)
> +		return ret;
> +
> +	contract &= 0xFFFFFFFFFFFF;
> +	type = TPS_PDO_CONTRACT_TYPE(contract);
> +	memset(&tps->terms, 0, sizeof(struct tps6598x_pdo));
> +
> +	/* If there's no PD it decodes to all 0 */
> +	switch (type) {
> +	case TPS_PDO_CONTRACT_FIXED:
> +		tps->terms.max_voltage = TPS_PDO_FIXED_CONTRACT_VOLTAGE(contract);
> +		tps->terms.max_current = TPS_PDO_FIXED_CONTRACT_MAX_CURRENT(contract);
> +		break;
> +	case TPS_PDO_CONTRACT_BATTERY:
> +		tps->terms.max_voltage = TPS_PDO_BAT_CONTRACT_MAX_VOLTAGE(contract);
> +		max_power = TPS_PDO_BAT_CONTRACT_MAX_POWER(contract);
> +		tps->terms.max_current = 1000 * 1000 * max_power / tps->terms.max_voltage;
> +		break;
> +	case TPS_PDO_CONTRACT_VARIABLE:
> +		tps->terms.max_voltage = TPS_PDO_VAR_CONTRACT_MAX_VOLTAGE(contract);
> +		tps->terms.max_current = TPS_PDO_VAR_CONTRACT_MAX_CURRENT(contract);
> +		break;
> +	default:
> +		dev_warn(tps->dev, "Unknown contract type: %d\n", type);
> +		return -EINVAL;
> +	}
> +
> +	tps->terms.pdo = contract;
> +	trace_tps6598x_pdo(&tps->terms);
> +
> +	return 0;
> +}
> +
>  static irqreturn_t tps6598x_interrupt(int irq, void *data)
>  {
>  	struct tps6598x *tps = data;
> @@ -563,6 +606,14 @@ static irqreturn_t tps6598x_interrupt(int irq, void *data)
>  		tps6598x_update_data_status(tps, status);
>  	}
>  
> +	if ((event1 | event2) & TPS_REG_INT_NEW_CONTRACT_AS_CONSUMER) {
> +		ret = tps6598x_get_active_pd_contract(tps);
> +		if (ret) {
> +			dev_err(tps->dev, "failed to read pd contract: %d\n", ret);
> +			goto err_clear_ints;
> +		}
> +	}
> +
>  	/* Handle plug insert or removal */
>  	if ((event1 | event2) & TPS_REG_INT_PLUG_EVENT)
>  		tps6598x_handle_plug_event(tps, status);
> @@ -751,10 +802,11 @@ static int tps6598x_probe(struct i2c_client *client)
>  
>  		irq_handler = cd321x_interrupt;
>  	} else {
> -		/* Enable power status, data status and plug event interrupts */
> +		/* Enable interrupts used by this driver */
>  		mask1 = TPS_REG_INT_POWER_STATUS_UPDATE |
>  			TPS_REG_INT_DATA_STATUS_UPDATE |
> -			TPS_REG_INT_PLUG_EVENT;
> +			TPS_REG_INT_PLUG_EVENT |
> +			TPS_REG_INT_NEW_CONTRACT_AS_CONSUMER;
>  	}
>  
>  	/* Make sure the controller has application firmware running */
> @@ -847,6 +899,13 @@ static int tps6598x_probe(struct i2c_client *client)
>  		ret = tps6598x_connect(tps, status);
>  		if (ret)
>  			dev_err(&client->dev, "failed to register partner\n");
> +
> +		if ((TPS_POWER_STATUS_PWROPMODE(tps->pwr_status) == TYPEC_PWR_MODE_PD) &&
> +		    (!(status & TPS_STATUS_PORTROLE))) {
> +			ret = tps6598x_get_active_pd_contract(tps);
> +			if (ret)
> +				dev_err(tps->dev, "failed to read pd contract: %d\n", ret);
> +		}
>  	}
>  
>  	ret = devm_request_threaded_irq(&client->dev, client->irq, NULL,
> diff --git a/drivers/usb/typec/tipd/tps6598x.h b/drivers/usb/typec/tipd/tps6598x.h
> index 527857549d69..546cd4881f1f 100644
> --- a/drivers/usb/typec/tipd/tps6598x.h
> +++ b/drivers/usb/typec/tipd/tps6598x.h
> @@ -199,4 +199,34 @@
>  #define TPS_DATA_STATUS_DP_SPEC_PIN_ASSIGNMENT_A    BIT(2)
>  #define TPS_DATA_STATUS_DP_SPEC_PIN_ASSIGNMENT_B    (BIT(2) | BIT(1))
>  
> +
> +/* PDO decoding as in https://www.ti.com/lit/an/slva842/slva842.pdf */
> +#define TPS_PDO_CONTRACT_TYPE(x)	FIELD_GET(GENMASK(31, 30), x)
> +#define TPS_PDO_CONTRACT_FIXED	0
> +#define TPS_PDO_CONTRACT_BATTERY	1
> +#define TPS_PDO_CONTRACT_VARIABLE	2
> +
> +#define TPS_PDO_FIXED_CONTRACT_DETAILS		GENMASK(29, 25)
> +#define TPS_PDO_FIXED_CONTRACT_DR_POWER		BIT(29)
> +#define TPS_PDO_FIXED_CONTRACT_USB_SUSPEND	BIT(28)
> +#define TPS_PDO_FIXED_CONTRACT_EXTERNAL_PWR	BIT(27)
> +#define TPS_PDO_FIXED_CONTRACT_USB_COMMS	BIT(26)
> +#define TPS_PDO_FIXED_CONTRACT_DR_DATA		BIT(25)

Those are already defined in include/linux/usb/pd.h

> +#define TPS_PDO_FIXED_CONTRACT_VOLTAGE(x)	(FIELD_GET(GENMASK(19, 10), x) * 50000)
> +#define TPS_PDO_FIXED_CONTRACT_MAX_CURRENT(x)	(FIELD_GET(GENMASK(9, 0), x) * 10000)
> +#define TPS_PDO_VAR_CONTRACT_MAX_VOLTAGE(x)	(FIELD_GET(GENMASK(29, 20), x) * 50000)
> +#define TPS_PDO_VAR_CONTRACT_MIN_VOLTAGE(x)	(FIELD_GET(GENMASK(19, 10), x) * 50000)
> +#define TPS_PDO_VAR_CONTRACT_MAX_CURRENT(x)	(FIELD_GET(GENMASK(9, 0), x) * 10000)
> +#define TPS_PDO_BAT_CONTRACT_MAX_VOLTAGE(x)	(FIELD_GET(GENMASK(29, 20), x) * 50000)
> +#define TPS_PDO_BAT_CONTRACT_MIN_VOLTAGE(x)	(FIELD_GET(GENMASK(19, 10), x) * 50000)
> +#define TPS_PDO_BAT_CONTRACT_MAX_POWER(x)	(FIELD_GET(GENMASK(9, 0), x) * 250000)

And I believe the same with these too.

> +struct tps6598x_pdo {
> +	u32 pdo;
> +	int max_voltage; /* uV */
> +	int max_current; /* uA */
> +	int max_power;   /* uW */
> +};
> +
>  #endif /* __TPS6598X_H__ */
> diff --git a/drivers/usb/typec/tipd/trace.h b/drivers/usb/typec/tipd/trace.h
> index 12cad1bde7cc..148e2ef3157b 100644
> --- a/drivers/usb/typec/tipd/trace.h
> +++ b/drivers/usb/typec/tipd/trace.h
> @@ -194,6 +194,20 @@
>  	(data_status & TPS_DATA_STATUS_DP_CONNECTION ? \
>  	 show_data_status_dp_pin_assignment(data_status) : "")
>  
> +#define show_pdo_contract_type(pdo) \
> +	__print_symbolic(TPS_PDO_CONTRACT_TYPE(pdo), \
> +		{ TPS_PDO_CONTRACT_FIXED, "fixed" }, \
> +		{ TPS_PDO_CONTRACT_BATTERY, "battery" }, \
> +		{ TPS_PDO_CONTRACT_VARIABLE, "variable" })
> +
> +#define show_pdo_contract_details(pdo) \
> +	__print_flags(pdo & TPS_PDO_FIXED_CONTRACT_DETAILS, "|", \
> +		{ TPS_PDO_FIXED_CONTRACT_DR_POWER, "dr-power" }, \
> +		{ TPS_PDO_FIXED_CONTRACT_USB_SUSPEND, "usb-suspend" }, \
> +		{ TPS_PDO_FIXED_CONTRACT_EXTERNAL_PWR, "ext-power" }, \
> +		{ TPS_PDO_FIXED_CONTRACT_USB_COMMS, "usb-comms" }, \
> +		{ TPS_PDO_FIXED_CONTRACT_DR_DATA, "dr-data" })
> +
>  TRACE_EVENT(tps6598x_irq,
>  	    TP_PROTO(u64 event1,
>  		     u64 event2),
> @@ -296,6 +310,30 @@ TRACE_EVENT(tps6598x_data_status,
>  		    )
>  );
>  
> +TRACE_EVENT(tps6598x_pdo,
> +	    TP_PROTO(struct tps6598x_pdo *pdo),
> +	    TP_ARGS(pdo),
> +
> +	    TP_STRUCT__entry(
> +			     __field(u32, pdo)
> +			     __field(int, max_current)
> +			     __field(int, max_voltage)
> +			     ),
> +
> +	    TP_fast_assign(
> +			   __entry->pdo = pdo->pdo;
> +			   __entry->max_current = pdo->max_current;
> +			   __entry->max_voltage = pdo->max_voltage;
> +			   ),
> +
> +	    TP_printk("%s supply, max %duA, %duV, details: %s",
> +		      show_pdo_contract_type(__entry->pdo),
> +		      __entry->max_current,
> +		      __entry->max_voltage,
> +		      show_pdo_contract_details(__entry->pdo)
> +		    )
> +);
> +
>  #endif /* _TPS6598X_TRACE_H_ */
>  
>  /* This part must be outside protection */

thanks,

-- 
heikki
