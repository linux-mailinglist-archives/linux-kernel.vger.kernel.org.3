Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 392394CB57B
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Mar 2022 04:33:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229456AbiCCDdb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Mar 2022 22:33:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37506 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229436AbiCCDda (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Mar 2022 22:33:30 -0500
Received: from 189.cn (ptr.189.cn [183.61.185.103])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 5D8DC626C;
        Wed,  2 Mar 2022 19:32:44 -0800 (PST)
HMM_SOURCE_IP: 10.64.8.43:59860.1825392078
HMM_ATTACHE_NUM: 0000
HMM_SOURCE_TYPE: SMTP
Received: from clientip-39.156.73.14 (unknown [10.64.8.43])
        by 189.cn (HERMES) with SMTP id 116D7100199;
        Thu,  3 Mar 2022 11:32:17 +0800 (CST)
Received: from  ([172.27.8.53])
        by gateway-151646-dep-b7fbf7d79-vjdjk with ESMTP id 1a7c2422cd53475e97fb8c11bba2953d for u.kleine-koenig@pengutronix.de;
        Thu, 03 Mar 2022 11:32:43 CST
X-Transaction-ID: 1a7c2422cd53475e97fb8c11bba2953d
X-Real-From: chensong_2000@189.cn
X-Receive-IP: 172.27.8.53
X-MEDUSA-Status: 0
Sender: chensong_2000@189.cn
Message-ID: <bf44b184-265f-6931-20e2-42eab82f6177@189.cn>
Date:   Thu, 3 Mar 2022 11:31:26 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH v3] staging: greybus: introduce pwm_ops::apply
Content-Language: en-US
To:     =?UTF-8?Q?Uwe_Kleine-K=c3=b6nig?= <u.kleine-koenig@pengutronix.de>
Cc:     johan@kernel.org, elder@kernel.org, gregkh@linuxfoundation.org,
        thierry.reding@gmail.com, lee.jones@linaro.org,
        greybus-dev@lists.linaro.org, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org, linux-pwm@vger.kernel.org,
        elder@ieee.org
References: <1645780561-18481-1-git-send-email-chensong_2000@189.cn>
 <20220301215659.kj2wwrijkdmkmces@pengutronix.de>
From:   Song Chen <chensong_2000@189.cn>
In-Reply-To: <20220301215659.kj2wwrijkdmkmces@pengutronix.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FROM,NICE_REPLY_A,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Hello,

在 2022/3/2 05:56, Uwe Kleine-König 写道:
> Hello,
> 
> On Fri, Feb 25, 2022 at 05:16:01PM +0800, Song Chen wrote:
>> Introduce apply in pwm_ops to replace legacy operations,
>> like enable, disable, config and set_polarity.
>>
>> Signed-off-by: Song Chen <chensong_2000@189.cn>
>>
>> ---
>> v2:
>> 1, define duty_cycle and period as u64 in gb_pwm_config_operation.
>> 2, define duty and period as u64 in gb_pwm_config_request.
>> 3, disable before configuring duty and period if the eventual goal
>>     is a disabled state.
>>
>> v3:
>> Regarding duty_cycle and period, I read more discussion in this thread,
>> min, warn or -EINVAL, seems no perfect way acceptable for everyone.
>> How about we limit their value to INT_MAX and throw a warning at the
>> same time when they are wrong?
> 
> My position is that the driver should implement the biggest possible
> period not bigger than the requested period. That's how all new drivers
> behave since I care for reviewing PWM stuff. So capping to U32_MAX as is
> (nearly) done below is good in my book.
> 
>> ---
>>   drivers/staging/greybus/pwm.c | 66 +++++++++++++++++++++--------------
>>   1 file changed, 40 insertions(+), 26 deletions(-)
>>
>> diff --git a/drivers/staging/greybus/pwm.c b/drivers/staging/greybus/pwm.c
>> index 891a6a672378..3ec5bc54d616 100644
>> --- a/drivers/staging/greybus/pwm.c
>> +++ b/drivers/staging/greybus/pwm.c
>> @@ -204,43 +204,57 @@ static void gb_pwm_free(struct pwm_chip *chip, struct pwm_device *pwm)
>>   	gb_pwm_deactivate_operation(pwmc, pwm->hwpwm);
>>   }
>>   
>> -static int gb_pwm_config(struct pwm_chip *chip, struct pwm_device *pwm,
>> -			 int duty_ns, int period_ns)
>> +static int gb_pwm_apply(struct pwm_chip *chip, struct pwm_device *pwm,
>> +			const struct pwm_state *state)
>>   {
>> +	int err;
>> +	bool enabled = pwm->state.enabled;
>> +	u64 period = state->period;
>> +	u64 duty_cycle = state->duty_cycle;
>>   	struct gb_pwm_chip *pwmc = pwm_chip_to_gb_pwm_chip(chip);
>>   
>> -	return gb_pwm_config_operation(pwmc, pwm->hwpwm, duty_ns, period_ns);
>> -};
>> -
>> -static int gb_pwm_set_polarity(struct pwm_chip *chip, struct pwm_device *pwm,
>> -			       enum pwm_polarity polarity)
>> -{
>> -	struct gb_pwm_chip *pwmc = pwm_chip_to_gb_pwm_chip(chip);
>> -
>> -	return gb_pwm_set_polarity_operation(pwmc, pwm->hwpwm, polarity);
>> -};
>> +	/* set polarity */
>> +	if (state->polarity != pwm->state.polarity) {
>> +		if (enabled) {
>> +			gb_pwm_disable_operation(pwmc, pwm->hwpwm);
> 
> So polarity can only be switched with the PWM off?

I have no devices in my hand to get it tested, but i think it's 
reasonable to turn off PWM before switching off its polarity.

What's more, it follows the implementation of pwm_apply_legacy, which is 
the way how it works now.

> 
>> +			enabled = false;
>> +		}
>> +		err = gb_pwm_set_polarity_operation(pwmc, pwm->hwpwm, state->polarity);
>> +		if (err)
>> +			return err;
>> +	}
>>   
>> -static int gb_pwm_enable(struct pwm_chip *chip, struct pwm_device *pwm)
>> -{
>> -	struct gb_pwm_chip *pwmc = pwm_chip_to_gb_pwm_chip(chip);
>> +	if (!state->enabled) {
>> +		if (enabled)
>> +			gb_pwm_disable_operation(pwmc, pwm->hwpwm);
>> +		return 0;
>> +	}
>>   
>> -	return gb_pwm_enable_operation(pwmc, pwm->hwpwm);
>> -};
>> +	/* set period and duty cycle*/
>> +	if (period > INT_MAX) {
> 
> Given that in gb_pwm_config_operation the parameters are u32, I suggest
> to use U32_MAX here instead of INT_MAX.
> 

will do.

>> +		period = INT_MAX;
>> +		dev_warn(chip->dev, "period is %llu ns, out of range\n", state->period);
> 
> Please drop this warning. That's a bad one because it can be triggered
> from userspace.

will do

> 
>> +	}
>> +	if (duty_cycle > INT_MAX) {
>> +		duty_cycle = INT_MAX;
>> +		dev_warn(chip->dev,
>> +			 "duty cycle is %llu ns, out of range\n", state->duty_cycle);
>> +	}
>> +	err = gb_pwm_config_operation(pwmc, pwm->hwpwm, duty_cycle, period);
> 
> Is it clear how gb_pwm_config_operation rounds? If yes, please document
> this. I also wonder if you could implement (in a separate change)
> .get_state().

Not clear about gb_pwm_config_operation rounds.
For get_state, i will look into it.

> 
>> +	if (err)
>> +		return err;
>>   
>> -static void gb_pwm_disable(struct pwm_chip *chip, struct pwm_device *pwm)
>> -{
>> -	struct gb_pwm_chip *pwmc = pwm_chip_to_gb_pwm_chip(chip);
>> +	/* enable/disable */
>> +	if (!enabled)
>> +		return gb_pwm_enable_operation(pwmc, pwm->hwpwm);
>>   
>> -	gb_pwm_disable_operation(pwmc, pwm->hwpwm);
>> -};
>> +	return 0;
>> +}
>>   
>>   static const struct pwm_ops gb_pwm_ops = {
>>   	.request = gb_pwm_request,
>>   	.free = gb_pwm_free,
>> -	.config = gb_pwm_config,
>> -	.set_polarity = gb_pwm_set_polarity,
>> -	.enable = gb_pwm_enable,
>> -	.disable = gb_pwm_disable,
>> +	.apply = gb_pwm_apply,
>>   	.owner = THIS_MODULE,
> 
> Best regards
> Uwe
> 

Best regards

Song
