Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C95044FF3AC
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Apr 2022 11:36:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234513AbiDMJix (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Apr 2022 05:38:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53258 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230140AbiDMJiu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Apr 2022 05:38:50 -0400
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3439E541B0;
        Wed, 13 Apr 2022 02:36:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1649842589; x=1681378589;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=sFkwTjYPsZTYIArW/zDQp2kcJ0QgVfA1Zo0sUjhJ8rA=;
  b=BnGOv2T74+I2OYECMy98kkroUOAuLS6Bew6vg7HXCvG4ajWODZNaCdLy
   hchOmmUa3pAGyUdxw0Y5eNM+MX/LYuugGFSIrjUZ6VnZ/T3AcxQKa0NUi
   RTGYvdy8dkkDsa+i+Dvwu/Vtr/5uli1Z1f1HEfYJcO+n4bECRoxqur9vg
   HiHYK88IayW6GXgyntAlt7JjuVqaF56Vr1avCCwBar6yor4Lh2sTg/3YY
   dRcCmpmagDEk3yKhibWXkw2UoPCfwbaXPBrL7YvxW2k2N3gHetiQbh0MA
   mPKrGv42eFq3IrTC53tF2EKRjXzvn/i6sgceIufEgzt7QeEGIAEoLESlP
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10315"; a="323067643"
X-IronPort-AV: E=Sophos;i="5.90,256,1643702400"; 
   d="scan'208";a="323067643"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Apr 2022 02:34:31 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,256,1643702400"; 
   d="scan'208";a="700182471"
Received: from kuha.fi.intel.com ([10.237.72.185])
  by fmsmga001.fm.intel.com with SMTP; 13 Apr 2022 02:34:27 -0700
Received: by kuha.fi.intel.com (sSMTP sendmail emulation); Wed, 13 Apr 2022 12:34:26 +0300
Date:   Wed, 13 Apr 2022 12:34:26 +0300
From:   Heikki Krogerus <heikki.krogerus@linux.intel.com>
To:     Aswath Govindraju <a-govindraju@ti.com>
Cc:     Vignesh Raghavendra <vigneshr@ti.com>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Roger Quadros <rogerq@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Sven Peter <sven@svenpeter.dev>,
        Alyssa Rosenzweig <alyssa@rosenzweig.io>,
        Hector Martin <marcan@marcan.st>,
        Saranya Gopal <saranya.gopal@intel.com>,
        Jens Axboe <axboe@kernel.dk>, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH RFC] usb: typec: tipd: Add support for polling interrupts
 status when interrupt line is not connected
Message-ID: <YlaZIual4Fa/a81I@kuha.fi.intel.com>
References: <20220412145059.4717-1-a-govindraju@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220412145059.4717-1-a-govindraju@ti.com>
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Aswath,

On Tue, Apr 12, 2022 at 08:20:58PM +0530, Aswath Govindraju wrote:
> In some cases the interrupt line from the pd controller may not be
> connected. In these cases, poll the status of various events.

Well, if the alert/interrupt line is not connected anywhere, then
polling is the only way to go. I'm fine with that, but the driver
really should be told that there is no interrupt. Using polling
whenever request_threaded_irq() returns -EINVAL is wrong. We really
should not even attempt to request the interrupt if there is no
interrupt for the device.

Isn't there any way you can get that information from DT? Or how is
the device enumerated in your case?

> Suggested-by: Roger Quadros <rogerq@kernel.org>
> Signed-off-by: Aswath Govindraju <a-govindraju@ti.com>
> ---
>  drivers/usb/typec/tipd/core.c | 90 ++++++++++++++++++++++++++++++++---
>  1 file changed, 83 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/usb/typec/tipd/core.c b/drivers/usb/typec/tipd/core.c
> index 16b4560216ba..fa52d2067d6d 100644
> --- a/drivers/usb/typec/tipd/core.c
> +++ b/drivers/usb/typec/tipd/core.c
> @@ -15,6 +15,8 @@
>  #include <linux/interrupt.h>
>  #include <linux/usb/typec.h>
>  #include <linux/usb/role.h>
> +#include <linux/workqueue.h>
> +#include <linux/devm-helpers.h>
>  
>  #include "tps6598x.h"
>  #include "trace.h"
> @@ -93,6 +95,8 @@ struct tps6598x {
>  	struct power_supply *psy;
>  	struct power_supply_desc psy_desc;
>  	enum power_supply_usb_type usb_type;
> +
> +	struct delayed_work wq_poll;
>  };
>  
>  static enum power_supply_property tps6598x_psy_props[] = {
> @@ -473,9 +477,8 @@ static void tps6598x_handle_plug_event(struct tps6598x *tps, u32 status)
>  	}
>  }
>  
> -static irqreturn_t cd321x_interrupt(int irq, void *data)
> +static int cd321x_handle_interrupt_status(struct tps6598x *tps)
>  {
> -	struct tps6598x *tps = data;
>  	u64 event;
>  	u32 status;
>  	int ret;
> @@ -513,14 +516,45 @@ static irqreturn_t cd321x_interrupt(int irq, void *data)
>  err_unlock:
>  	mutex_unlock(&tps->lock);
>  
> +	if (ret)
> +		return ret;
> +
>  	if (event)
> -		return IRQ_HANDLED;
> -	return IRQ_NONE;
> +		return 0;
> +	return 1;
>  }
>  
> -static irqreturn_t tps6598x_interrupt(int irq, void *data)
> +static irqreturn_t cd321x_interrupt(int irq, void *data)
>  {
>  	struct tps6598x *tps = data;
> +	int ret;
> +
> +	ret = cd321x_handle_interrupt_status(tps);
> +	if (ret)
> +		return IRQ_NONE;
> +	return IRQ_HANDLED;
> +}
> +
> +/* Time interval for Polling */
> +#define POLL_INTERVAL   500 /* msecs */
> +static void cd321x_poll_work(struct work_struct *work)
> +{
> +	struct tps6598x *tps = container_of(to_delayed_work(work),
> +					    struct tps6598x, wq_poll);
> +	int ret;
> +
> +	ret = cd321x_handle_interrupt_status(tps);
> +	/*
> +	 * If there is an error while reading the interrupt registers
> +	 * then stop polling else, schedule another poll work item
> +	 */
> +	if (!(ret < 0))
> +		queue_delayed_work(system_power_efficient_wq,
> +				   &tps->wq_poll, msecs_to_jiffies(POLL_INTERVAL));
> +}
> +
> +static int tps6598x_handle_interrupt_status(struct tps6598x *tps)
> +{
>  	u64 event1;
>  	u64 event2;
>  	u32 status;
> @@ -561,9 +595,39 @@ static irqreturn_t tps6598x_interrupt(int irq, void *data)
>  err_unlock:
>  	mutex_unlock(&tps->lock);
>  
> +	if (ret)
> +		return ret;
> +
>  	if (event1 | event2)
> -		return IRQ_HANDLED;
> -	return IRQ_NONE;
> +		return 0;
> +	return 1;
> +}
> +
> +static irqreturn_t tps6598x_interrupt(int irq, void *data)
> +{
> +	struct tps6598x *tps = data;
> +	int ret;
> +
> +	ret = tps6598x_handle_interrupt_status(tps);
> +	if (ret)
> +		return IRQ_NONE;
> +	return IRQ_HANDLED;
> +}
> +
> +static void tps6598x_poll_work(struct work_struct *work)
> +{
> +	struct tps6598x *tps = container_of(to_delayed_work(work),
> +					    struct tps6598x, wq_poll);
> +	int ret;
> +
> +	ret = tps6598x_handle_interrupt_status(tps);
> +	/*
> +	 * If there is an error while reading the interrupt registers
> +	 * then stop polling else, schedule another poll work item
> +	 */
> +	if (!(ret < 0))
> +		queue_delayed_work(system_power_efficient_wq,
> +				   &tps->wq_poll, msecs_to_jiffies(POLL_INTERVAL));
>  }
>  
>  static int tps6598x_check_mode(struct tps6598x *tps)
> @@ -704,6 +768,7 @@ static int devm_tps6598_psy_register(struct tps6598x *tps)
>  static int tps6598x_probe(struct i2c_client *client)
>  {
>  	irq_handler_t irq_handler = tps6598x_interrupt;
> +	work_func_t work_poll_handler = tps6598x_poll_work;
>  	struct device_node *np = client->dev.of_node;
>  	struct typec_capability typec_cap = { };
>  	struct tps6598x *tps;
> @@ -748,6 +813,7 @@ static int tps6598x_probe(struct i2c_client *client)
>  			APPLE_CD_REG_INT_PLUG_EVENT;
>  
>  		irq_handler = cd321x_interrupt;
> +		work_poll_handler = cd321x_poll_work;
>  	} else {
>  		/* Enable power status, data status and plug event interrupts */
>  		mask1 = TPS_REG_INT_POWER_STATUS_UPDATE |
> @@ -846,6 +912,16 @@ static int tps6598x_probe(struct i2c_client *client)
>  					irq_handler,
>  					IRQF_SHARED | IRQF_ONESHOT,
>  					dev_name(&client->dev), tps);
> +	if (ret == -EINVAL) {
> +		dev_warn(&client->dev, "Unable to find the interrupt, switching to polling\n");
> +		ret = devm_delayed_work_autocancel(tps->dev, &tps->wq_poll, work_poll_handler);
> +		if (ret)
> +			dev_err(&client->dev, "error while initializing workqueue\n");
> +		else
> +			queue_delayed_work(system_power_efficient_wq, &tps->wq_poll,
> +					   msecs_to_jiffies(POLL_INTERVAL));
> +	}
> +
>  	if (ret) {
>  		tps6598x_disconnect(tps, 0);
>  		typec_unregister_port(tps->port);

thanks,

-- 
heikki
