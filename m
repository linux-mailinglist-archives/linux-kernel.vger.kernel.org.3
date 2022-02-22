Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5366E4BF9C8
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Feb 2022 14:49:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232545AbiBVNtk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Feb 2022 08:49:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48986 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231425AbiBVNti (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Feb 2022 08:49:38 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 404B67C14B;
        Tue, 22 Feb 2022 05:49:13 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id D35D3613E9;
        Tue, 22 Feb 2022 13:49:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A4B6AC340E8;
        Tue, 22 Feb 2022 13:49:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1645537752;
        bh=RY1Pj4yRviD2iNjc7s7MN8RAJDDF8HNww4stT8x6NfQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=UDi7oTbsXRuHSeD4Njur0qrttrKG7lo6Xoqug3/he3ylfJTfhSirEYVX8gPiBORd/
         uyIG7nY+4p3QPgv9v1R73c90DeAarJaRJdl7wL7VjyaAqKDzOSZXj3Xk5PphHXoMRv
         ghKON4ppsGeQjiuPrKId3rAJ/TxWQSrvl9jVOznU=
Date:   Tue, 22 Feb 2022 14:49:09 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Song Chen <chensong_2000@189.cn>
Cc:     johan@kernel.org, elder@kernel.org, thierry.reding@gmail.com,
        u.kleine-koenig@pengutronix.de, lee.jones@linaro.org,
        greybus-dev@lists.linaro.org, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org, linux-pwm@vger.kernel.org
Subject: Re: [PATCH v2] staging: greybus: introduce pwm_ops::apply
Message-ID: <YhTp1RAXDZrA5QKK@kroah.com>
References: <1644580947-8529-1-git-send-email-chensong_2000@189.cn>
 <YhPGqg2BydlAFiM1@kroah.com>
 <ccbddd00-a2d6-c613-bc7b-e08d7fa2306b@189.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ccbddd00-a2d6-c613-bc7b-e08d7fa2306b@189.cn>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 22, 2022 at 02:19:12PM +0800, Song Chen wrote:
> Hi Greg,
> 
> 在 2022/2/22 01:06, Greg KH 写道:
> > On Fri, Feb 11, 2022 at 08:02:27PM +0800, Song Chen wrote:
> > > Introduce apply in pwm_ops to replace legacy operations,
> > > like enable, disable, config and set_polarity.
> > > 
> > > Signed-off-by: Song Chen <chensong_2000@189.cn>
> > > 
> > > ---
> > > V2:
> > > 1, define duty_cycle and period as u64 in gb_pwm_config_operation.
> > > 2, define duty and period as u64 in gb_pwm_config_request.
> > > 3, disable before configuring duty and period if the eventual goal
> > >     is a disabled state.
> > > ---
> > >   drivers/staging/greybus/pwm.c             | 61 ++++++++++++-----------
> > >   include/linux/greybus/greybus_protocols.h |  4 +-
> > >   2 files changed, 34 insertions(+), 31 deletions(-)
> > > 
> > > diff --git a/drivers/staging/greybus/pwm.c b/drivers/staging/greybus/pwm.c
> > > index 891a6a672378..03c69db5b9be 100644
> > > --- a/drivers/staging/greybus/pwm.c
> > > +++ b/drivers/staging/greybus/pwm.c
> > > @@ -89,7 +89,7 @@ static int gb_pwm_deactivate_operation(struct gb_pwm_chip *pwmc,
> > >   }
> > >   static int gb_pwm_config_operation(struct gb_pwm_chip *pwmc,
> > > -				   u8 which, u32 duty, u32 period)
> > > +				   u8 which, u64 duty, u64 period)
> > >   {
> > >   	struct gb_pwm_config_request request;
> > >   	struct gbphy_device *gbphy_dev;
> > > @@ -99,8 +99,8 @@ static int gb_pwm_config_operation(struct gb_pwm_chip *pwmc,
> > >   		return -EINVAL;
> > >   	request.which = which;
> > > -	request.duty = cpu_to_le32(duty);
> > > -	request.period = cpu_to_le32(period);
> > > +	request.duty = duty;
> > > +	request.period = period;
> > >   	gbphy_dev = to_gbphy_dev(pwmc->chip.dev);
> > >   	ret = gbphy_runtime_get_sync(gbphy_dev);
> > > @@ -204,43 +204,46 @@ static void gb_pwm_free(struct pwm_chip *chip, struct pwm_device *pwm)
> > >   	gb_pwm_deactivate_operation(pwmc, pwm->hwpwm);
> > >   }
> > > -static int gb_pwm_config(struct pwm_chip *chip, struct pwm_device *pwm,
> > > -			 int duty_ns, int period_ns)
> > > +static int gb_pwm_apply(struct pwm_chip *chip, struct pwm_device *pwm,
> > > +			const struct pwm_state *state)
> > >   {
> > > +	int err;
> > > +	bool enabled = pwm->state.enabled;
> > >   	struct gb_pwm_chip *pwmc = pwm_chip_to_gb_pwm_chip(chip);
> > > -	return gb_pwm_config_operation(pwmc, pwm->hwpwm, duty_ns, period_ns);
> > > -};
> > > -
> > > -static int gb_pwm_set_polarity(struct pwm_chip *chip, struct pwm_device *pwm,
> > > -			       enum pwm_polarity polarity)
> > > -{
> > > -	struct gb_pwm_chip *pwmc = pwm_chip_to_gb_pwm_chip(chip);
> > > -
> > > -	return gb_pwm_set_polarity_operation(pwmc, pwm->hwpwm, polarity);
> > > -};
> > > +	/* set polarity */
> > > +	if (state->polarity != pwm->state.polarity) {
> > > +		if (enabled) {
> > > +			gb_pwm_disable_operation(pwmc, pwm->hwpwm);
> > > +			enabled = false;
> > > +		}
> > > +		err = gb_pwm_set_polarity_operation(pwmc, pwm->hwpwm, state->polarity);
> > > +		if (err)
> > > +			return err;
> > > +	}
> > > -static int gb_pwm_enable(struct pwm_chip *chip, struct pwm_device *pwm)
> > > -{
> > > -	struct gb_pwm_chip *pwmc = pwm_chip_to_gb_pwm_chip(chip);
> > > +	if (!state->enabled) {
> > > +		if (enabled)
> > > +			gb_pwm_disable_operation(pwmc, pwm->hwpwm);
> > > +		return 0;
> > > +	}
> > > -	return gb_pwm_enable_operation(pwmc, pwm->hwpwm);
> > > -};
> > > +	/* set period and duty cycle*/
> > > +	err = gb_pwm_config_operation(pwmc, pwm->hwpwm, state->duty_cycle, state->period);
> > > +	if (err)
> > > +		return err;
> > > -static void gb_pwm_disable(struct pwm_chip *chip, struct pwm_device *pwm)
> > > -{
> > > -	struct gb_pwm_chip *pwmc = pwm_chip_to_gb_pwm_chip(chip);
> > > +	/* enable/disable */
> > > +	if (!enabled)
> > > +		return gb_pwm_enable_operation(pwmc, pwm->hwpwm);
> > > -	gb_pwm_disable_operation(pwmc, pwm->hwpwm);
> > > -};
> > > +	return 0;
> > > +}
> > >   static const struct pwm_ops gb_pwm_ops = {
> > >   	.request = gb_pwm_request,
> > >   	.free = gb_pwm_free,
> > > -	.config = gb_pwm_config,
> > > -	.set_polarity = gb_pwm_set_polarity,
> > > -	.enable = gb_pwm_enable,
> > > -	.disable = gb_pwm_disable,
> > > +	.apply = gb_pwm_apply,
> > >   	.owner = THIS_MODULE,
> > >   };
> > > diff --git a/include/linux/greybus/greybus_protocols.h b/include/linux/greybus/greybus_protocols.h
> > > index aeb8f9243545..81a6f16de098 100644
> > > --- a/include/linux/greybus/greybus_protocols.h
> > > +++ b/include/linux/greybus/greybus_protocols.h
> > > @@ -812,8 +812,8 @@ struct gb_pwm_deactivate_request {
> > >   struct gb_pwm_config_request {
> > >   	__u8	which;
> > > -	__le32	duty;
> > > -	__le32	period;
> > > +	__u64	duty;
> > > +	__u64	period;
> > >   } __packed;
> > 
> > Did you just change a greybus protocol message that is sent over the
> > wire?  Why?  And why drop the endian marking of it?
> 
> I discussed with Uwe about losing bit and found there is no perfect way to
> avoid, even in Uwe's patch[1], as a result, we decided to widen duty and
> period in gb_pwm_config_request, the other side of the wire is supposed to
> change accordingly to support 64bit duty and period too(this will introduce
> compatibility problem and there is no variable like version to address it),
> similar with ktime_t in y2038, below is the detail [2]

Where are you changing the "other side of the wire" here?  That wire is
in firmware, how are you going to coordinate that change?

This is a hardware API, you can not change it without a lot of very
careful work, and I still do not understand why it is needed.  What
"problem" is this solving that requires the protocol to change?

thanks,

greg k-h
