Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8A94157152E
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Jul 2022 10:56:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232596AbiGLI4n (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Jul 2022 04:56:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55976 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229780AbiGLI4k (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Jul 2022 04:56:40 -0400
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A1B88A9E44;
        Tue, 12 Jul 2022 01:56:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1657616199; x=1689152199;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=BAj2BVRnVHVx4BIVLBA7qJLUD2eGU+U6NgPxuH9MK6w=;
  b=CXn1ALiGUpqKSWxID864AJr6C1DSgZLl8XuNELr2l1G/vqLp98vCpaXG
   76DHBvXartoseZJ1pF1XwvNBXVR6daJ/f6yXhID5rUgOFM5MtR1jB6zFx
   rn2lHkgXKR9Et0nwnRNfjx/PEfjsBuH+QWPxL1126cEHnJBX8TWqFX9A4
   pMPw0QkOzO8G/A4RA347wmzl7WwgxqgqbzLuFGXIjqq0d2Alz016vJdFb
   p9H9VAt9VR70k9jOop65sFHwtLAJPyfTSMGoJONEnszuVe6xvBq9Nhnf9
   xircbxGARfroy/q6LuDFRhIpYomY8qCvBTAN9o7e1eryOhrph2KRW6G6+
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10405"; a="286008335"
X-IronPort-AV: E=Sophos;i="5.92,265,1650956400"; 
   d="scan'208";a="286008335"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Jul 2022 01:56:39 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.92,265,1650956400"; 
   d="scan'208";a="737408607"
Received: from kuha.fi.intel.com ([10.237.72.185])
  by fmsmga001.fm.intel.com with SMTP; 12 Jul 2022 01:56:35 -0700
Received: by kuha.fi.intel.com (sSMTP sendmail emulation); Tue, 12 Jul 2022 11:56:34 +0300
Date:   Tue, 12 Jul 2022 11:56:34 +0300
From:   Heikki Krogerus <heikki.krogerus@linux.intel.com>
To:     Fabrice Gasnier <fabrice.gasnier@foss.st.com>
Cc:     krzysztof.kozlowski+dt@linaro.org, robh+dt@kernel.org,
        gregkh@linuxfoundation.org, christophe.jaillet@wanadoo.fr,
        devicetree@vger.kernel.org, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com,
        amelie.delaunay@foss.st.com, alexandre.torgue@foss.st.com
Subject: Re: [PATCH v2 4/4] usb: typec: ucsi: stm32g0: add support for power
 management
Message-ID: <Ys03QgD0aIF1Zl9R@kuha.fi.intel.com>
References: <20220711120122.25804-1-fabrice.gasnier@foss.st.com>
 <20220711120122.25804-5-fabrice.gasnier@foss.st.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220711120122.25804-5-fabrice.gasnier@foss.st.com>
X-Spam-Status: No, score=-4.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Mon, Jul 11, 2022 at 02:01:22PM +0200, Fabrice Gasnier kirjoitti:
> Type-C connector can be used as a wakeup source (typically to detect
> changes on the port, attach or detach...).
> Add suspend / resume routines to enable wake irqs, and signal a wakeup
> event in case the IRQ has fired while in suspend.
> The i2c core is doing the necessary initialization when the "wakeup-source"
> flag is provided.
> Note: the interrupt handler shouldn't be called before the i2c bus resumes.
> So, the interrupts are disabled during suspend period, and re-enabled
> upon resume, to avoid i2c transfer while suspended, from the irq handler.
> 
> Signed-off-by: Fabrice Gasnier <fabrice.gasnier@foss.st.com>

Does this really need a separate patch? Does the support depend on the
second patch somehow?

If not, then just merge this into the first patch. That
g0->in_bootloader check you can add in the second patch.

Acked-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>

> ---
>  drivers/usb/typec/ucsi/ucsi_stm32g0.c | 52 +++++++++++++++++++++++++++
>  1 file changed, 52 insertions(+)
> 
> diff --git a/drivers/usb/typec/ucsi/ucsi_stm32g0.c b/drivers/usb/typec/ucsi/ucsi_stm32g0.c
> index b1d891c9a92c0..061551d464f12 100644
> --- a/drivers/usb/typec/ucsi/ucsi_stm32g0.c
> +++ b/drivers/usb/typec/ucsi/ucsi_stm32g0.c
> @@ -66,6 +66,8 @@ struct ucsi_stm32g0 {
>  	unsigned long flags;
>  	const char *fw_name;
>  	struct ucsi *ucsi;
> +	bool suspended;
> +	bool wakeup_event;
>  };
>  
>  /*
> @@ -416,6 +418,9 @@ static irqreturn_t ucsi_stm32g0_irq_handler(int irq, void *data)
>  	u32 cci;
>  	int ret;
>  
> +	if (g0->suspended)
> +		g0->wakeup_event = true;
> +
>  	ret = ucsi_stm32g0_read(g0->ucsi, UCSI_CCI, &cci, sizeof(cci));
>  	if (ret)
>  		return IRQ_NONE;
> @@ -696,6 +701,52 @@ static int ucsi_stm32g0_remove(struct i2c_client *client)
>  	return 0;
>  }
>  
> +static int ucsi_stm32g0_suspend(struct device *dev)
> +{
> +	struct ucsi_stm32g0 *g0 = dev_get_drvdata(dev);
> +	struct i2c_client *client = g0->client;
> +
> +	if (g0->in_bootloader)
> +		return 0;
> +
> +	/* Keep the interrupt disabled until the i2c bus has been resumed */
> +	disable_irq(client->irq);
> +
> +	g0->suspended = true;
> +	g0->wakeup_event = false;
> +
> +	if (device_may_wakeup(dev) || device_wakeup_path(dev))
> +		enable_irq_wake(client->irq);
> +
> +	return 0;
> +}
> +
> +static int ucsi_stm32g0_resume(struct device *dev)
> +{
> +	struct ucsi_stm32g0 *g0 = dev_get_drvdata(dev);
> +	struct i2c_client *client = g0->client;
> +
> +	if (g0->in_bootloader)
> +		return 0;
> +
> +	if (device_may_wakeup(dev) || device_wakeup_path(dev))
> +		disable_irq_wake(client->irq);
> +
> +	enable_irq(client->irq);
> +
> +	/* Enforce any pending handler gets called to signal a wakeup_event */
> +	synchronize_irq(client->irq);
> +
> +	if (g0->wakeup_event)
> +		pm_wakeup_event(g0->dev, 0);
> +
> +	g0->suspended = false;
> +
> +	return 0;
> +}
> +
> +static DEFINE_SIMPLE_DEV_PM_OPS(ucsi_stm32g0_pm_ops, ucsi_stm32g0_suspend, ucsi_stm32g0_resume);
> +
>  static const struct of_device_id __maybe_unused ucsi_stm32g0_typec_of_match[] = {
>  	{ .compatible = "st,stm32g0-typec" },
>  	{},
> @@ -712,6 +763,7 @@ static struct i2c_driver ucsi_stm32g0_i2c_driver = {
>  	.driver = {
>  		.name = "ucsi-stm32g0-i2c",
>  		.of_match_table = of_match_ptr(ucsi_stm32g0_typec_of_match),
> +		.pm = pm_sleep_ptr(&ucsi_stm32g0_pm_ops),
>  	},
>  	.probe = ucsi_stm32g0_probe,
>  	.remove = ucsi_stm32g0_remove,
> -- 
> 2.25.1

-- 
heikki
