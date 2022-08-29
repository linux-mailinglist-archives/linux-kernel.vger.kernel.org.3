Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CDEAB5A56E1
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Aug 2022 00:14:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229513AbiH2WOc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 Aug 2022 18:14:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45436 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229652AbiH2WO2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Aug 2022 18:14:28 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA7167D78B;
        Mon, 29 Aug 2022 15:14:27 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 66645B81367;
        Mon, 29 Aug 2022 22:14:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0F268C433D6;
        Mon, 29 Aug 2022 22:14:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1661811264;
        bh=8fGWeIEbosM0ZpO4CDThvrfbX/Zbz5F0j11WCl890LQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=UmyCqVS675PXHgBitXiDAzQJnM4VdZZXNrUoX3KQpOxlhGDpD4iSbCbJ3pdpbyggL
         7r/BJrBEyI0rSuXQtgIZCzXGHalTK7xyHZU2cnbsqCbk20nmxvEorNqb2qWAKjKTw4
         8JNkhThs7W7HSYbiQY5BBdHP7jQ9Id1Lap2mJDegKv/A7EPPUTaw7O+HSQKtXZ9Jbd
         ugRe0FM0QEMns4oA4FtzS2adm2JAgvaVKIOXYKg3v6aQKfXRQQCUVkw13eqF8zHLUR
         OkkgBf12AuJLJi7trx4K0zPTSnRT1A1WGGnKxTJQDX80jPsgsI50rwP52ojL7YLvDD
         GKLAng9Zvtxpw==
Date:   Mon, 29 Aug 2022 17:14:22 -0500
From:   Bjorn Andersson <andersson@kernel.org>
To:     Bhupesh Sharma <bhupesh.sharma@linaro.org>
Cc:     linux-pm@vger.kernel.org, bhupesh.linux@gmail.com,
        linux-kernel@vger.kernel.org, bjorn.andersson@linaro.org,
        konrad.dybcio@somainline.org, linux-arm-msm@vger.kernel.org,
        daniel.lezcano@linaro.org, robh+dt@kernel.org, rafael@kernel.org,
        Amit Kucheria <amitk@kernel.org>,
        Thara Gopinath <thara.gopinath@gmail.com>
Subject: Re: [PATCH v3 3/4] thermal: qcom: tsens: Add driver support for
 re-initialization quirk
Message-ID: <20220829221422.2r6axgaica67lbpv@builder.lan>
References: <20220804054638.3197294-1-bhupesh.sharma@linaro.org>
 <20220804054638.3197294-4-bhupesh.sharma@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220804054638.3197294-4-bhupesh.sharma@linaro.org>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 04, 2022 at 11:16:37AM +0530, Bhupesh Sharma wrote:
> Since for some Qualcomm tsens controllers, its suggested to
> monitor the controller health periodically and in case an
> issue is detected, to re-initialize the tsens controller
> via trustzone, add the support for the same in the
> qcom tsens driver.
> 
> Note that once the tsens controller is reset using scm call,
> all SROT and TM region registers will enter the reset mode.
> 
> While all the SROT registers will be re-programmed and
> re-enabled in trustzone prior to the scm call exit, the TM
> region registers will not re-initialized in trustzone and thus
> need to be handled by the tsens driver.
> 
> Cc: Bjorn Andersson <bjorn.andersson@linaro.org>
> Cc: Amit Kucheria <amitk@kernel.org>
> Cc: Thara Gopinath <thara.gopinath@gmail.com>
> Cc: linux-pm@vger.kernel.org
> Cc: linux-arm-msm@vger.kernel.org
> Signed-off-by: Bhupesh Sharma <bhupesh.sharma@linaro.org>
> ---
>  drivers/thermal/qcom/tsens-v2.c |   3 +
>  drivers/thermal/qcom/tsens.c    | 197 ++++++++++++++++++++++++++++++++
>  drivers/thermal/qcom/tsens.h    |  12 ++
>  3 files changed, 212 insertions(+)
> 
> diff --git a/drivers/thermal/qcom/tsens-v2.c b/drivers/thermal/qcom/tsens-v2.c
> index b293ed32174b..f521e4479cc5 100644
> --- a/drivers/thermal/qcom/tsens-v2.c
> +++ b/drivers/thermal/qcom/tsens-v2.c
> @@ -88,6 +88,9 @@ static const struct reg_field tsens_v2_regfields[MAX_REGFIELDS] = {
>  
>  	/* TRDY: 1=ready, 0=in progress */
>  	[TRDY] = REG_FIELD(TM_TRDY_OFF, 0, 0),
> +
> +	/* FIRST_ROUND_COMPLETE: 1=complete, 0=not complete */
> +	[FIRST_ROUND_COMPLETE] = REG_FIELD(TM_TRDY_OFF, 3, 3),
>  };
>  
>  static const struct tsens_ops ops_generic_v2 = {
> diff --git a/drivers/thermal/qcom/tsens.c b/drivers/thermal/qcom/tsens.c
> index e49f58e83513..c2d085fb5447 100644
> --- a/drivers/thermal/qcom/tsens.c
> +++ b/drivers/thermal/qcom/tsens.c
> @@ -7,6 +7,7 @@
>  #include <linux/debugfs.h>
>  #include <linux/err.h>
>  #include <linux/io.h>
> +#include <linux/qcom_scm.h>
>  #include <linux/module.h>
>  #include <linux/nvmem-consumer.h>
>  #include <linux/of.h>
> @@ -594,6 +595,113 @@ static void tsens_disable_irq(struct tsens_priv *priv)
>  	regmap_field_write(priv->rf[INT_EN], 0);
>  }
>  
> +static int tsens_reenable_hw_after_scm(struct tsens_priv *priv)

As written, this is a void function.

> +{
> +	/*
> +	 * Re-enable watchdog, unmask the bark and
> +	 * disable cycle completion monitoring.
> +	 */
> +	regmap_field_write(priv->rf[WDOG_BARK_CLEAR], 1);
> +	regmap_field_write(priv->rf[WDOG_BARK_CLEAR], 0);
> +	regmap_field_write(priv->rf[WDOG_BARK_MASK], 0);
> +	regmap_field_write(priv->rf[CC_MON_MASK], 1);
> +
> +	/* Re-enable interrupts */
> +	tsens_enable_irq(priv);
> +
> +	return 0;
> +}
> +
> +static int tsens_health_check_and_reinit(struct tsens_priv *priv,
> +					 int hw_id)
> +{
> +	int ret, trdy, first_round, sw_reg;
> +	unsigned long timeout;
> +
> +	/* First check if TRDY is SET */
> +	ret = regmap_field_read(priv->rf[TRDY], &trdy);
> +	if (ret)
> +		goto err;
> +
> +	if (!trdy) {

if (trdy)
	return 0;

Would save you one level of indentation.

> +		ret = regmap_field_read(priv->rf[FIRST_ROUND_COMPLETE], &first_round);
> +		if (ret)
> +			goto err;
> +
> +		if (!first_round) {

if (first_round)
	return 0;

Would save you another level of indentation.

> +			WARN_ON(!mutex_is_locked(&priv->reinit_mutex));

At least for now the function is only called within a small locked
region, so it's going to be locked here. But I'm wondering if there's
any relationship between the lock state of reinit_mutex and the values
of TRDY and FIRST_ROUND_COMPLETE.

Seems like it's possible to hit this function repeatedly and have it
exit early because of TRDY and FIRST_ROUND_COMPLETE values and then one
day if will reach here and trip.

So how about starting the function with this check, to make it more
likely to be hit in our testing?

> +
> +			/* Wait for 2 ms for tsens controller to recover */
> +			timeout = jiffies + msecs_to_jiffies(RESET_TIMEOUT_MS);
> +			do {
> +				ret = regmap_field_read(priv->rf[FIRST_ROUND_COMPLETE],
> +						&first_round);
> +				if (ret)
> +					goto err;
> +
> +				if (first_round) {
> +					dev_dbg(priv->dev, "tsens controller recovered\n");
> +					return 0; /* success */
> +				}
> +			} while (time_before(jiffies, timeout));

I see no delays in this loop, so we're presumably going to spin here
tightly for 2ms.

I think you could write this loop as:

	ret = regmap_field_read_poll_timeout(priv->rf[FIRST_ROUND_COMPLETE],
					     &first_round, first_round, 100, 2000);
	if (ret == 0) {
		dev_dbg(priv->dev, "tsens controller recovered\n");
		return 0;
	}

> +
> +			spin_lock(&priv->reinit_lock);
> +
> +			/*
> +			 * Invoke SCM call only if SW register write is
> +			 * reflecting in controller. Try it for 2 ms.
> +			 * In case that fails mark the tsens controller
> +			 * as unrecoverable.
> +			 */
> +			timeout = jiffies + msecs_to_jiffies(RESET_TIMEOUT_MS);
> +			do {
> +				ret = regmap_field_write(priv->rf[INT_EN], CRITICAL_INT_EN);
> +				if (ret)
> +					goto err;

You're holding reinit_lock here.

> +
> +				ret = regmap_field_read(priv->rf[INT_EN], &sw_reg);
> +				if (ret)
> +					goto err;

And here.

> +			} while ((sw_reg & CRITICAL_INT_EN) && (time_before(jiffies, timeout)));

And again, this is a tight loop. Please add a usleep_range(100, 1000),
perhaps inbetween the write and read?

> +
> +			if (!(sw_reg & CRITICAL_INT_EN)) {
> +				ret = -ENOTRECOVERABLE;
> +				goto err;

Again, reinit_lock is held here.

> +			}
> +
> +			/*
> +			 * tsens controller did not recover,
> +			 * proceed with SCM call to re-init it.
> +			 */
> +			ret = qcom_scm_tsens_reinit();
> +			if (ret) {
> +				dev_err(priv->dev, "tsens reinit scm call failed (%d)\n", ret);
> +				goto err;

And here.

> +			}
> +
> +			/*
> +			 * After the SCM call, we need to re-enable
> +			 * the interrupts and also set active threshold
> +			 * for each sensor.
> +			 */
> +			ret = tsens_reenable_hw_after_scm(priv);

As written tsens_reenable_hw_after_scm() doesn't return any value, so
skip the error handling.

> +			if (ret) {
> +				dev_err(priv->dev,
> +					"tsens re-enable after scm call failed (%d)\n", ret);
> +				goto err;

And here...

> +			}
> +
> +			/* Notify reinit wa worker */
> +			queue_work(system_highpri_wq, &priv->reinit_wa_notify);
> +
> +			spin_unlock(&priv->reinit_lock);
> +		}
> +	}
> +
> +err:
> +	return ret;
> +}
> +
>  int get_temp_tsens_valid(const struct tsens_sensor *s, int *temp)
>  {
>  	struct tsens_priv *priv = s->priv;
> @@ -607,6 +715,21 @@ int get_temp_tsens_valid(const struct tsens_sensor *s, int *temp)
>  	if (tsens_version(priv) == VER_0)
>  		goto get_temp;
>  
> +	/*
> +	 * For some tsens controllers, its suggested to
> +	 * monitor the controller health periodically
> +	 * and in case an issue is detected to reinit
> +	 * tsens controller via trustzone.

Please use your 80 chars.

Regards,
Bjorn
