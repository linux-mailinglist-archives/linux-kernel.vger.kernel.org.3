Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 862494DBEF3
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Mar 2022 07:06:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229962AbiCQGHf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Mar 2022 02:07:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59668 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229890AbiCQGH0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Mar 2022 02:07:26 -0400
Received: from 189.cn (ptr.189.cn [183.61.185.101])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 7F04CB6E47;
        Wed, 16 Mar 2022 22:41:23 -0700 (PDT)
HMM_SOURCE_IP: 10.64.8.43:39192.685640236
HMM_ATTACHE_NUM: 0000
HMM_SOURCE_TYPE: SMTP
Received: from clientip-123.150.8.42 (unknown [10.64.8.43])
        by 189.cn (HERMES) with SMTP id 014241002CF;
        Thu, 17 Mar 2022 13:41:18 +0800 (CST)
Received: from  ([123.150.8.42])
        by gateway-153622-dep-749df8664c-nmrf6 with ESMTP id c89674fb2fe849118869f28b5b311751 for u.kleine-koenig@pengutronix.de;
        Thu, 17 Mar 2022 13:41:22 CST
X-Transaction-ID: c89674fb2fe849118869f28b5b311751
X-Real-From: chensong_2000@189.cn
X-Receive-IP: 123.150.8.42
X-MEDUSA-Status: 0
Sender: chensong_2000@189.cn
Message-ID: <52c083c0-2545-d048-85fa-138a51e433f6@189.cn>
Date:   Thu, 17 Mar 2022 13:41:15 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [greybus-dev] Re: [PATCH v5] staging: greybus: introduce
 pwm_ops::apply
Content-Language: en-US
To:     =?UTF-8?Q?Uwe_Kleine-K=c3=b6nig?= <u.kleine-koenig@pengutronix.de>,
        Alex Elder <elder@linaro.org>
Cc:     Alex Elder <elder@ieee.org>, johan@kernel.org, elder@kernel.org,
        thierry.reding@gmail.com, lee.jones@linaro.org,
        greybus-dev@lists.linaro.org, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org, linux-pwm@vger.kernel.org
References: <1647397285-30061-1-git-send-email-chensong_2000@189.cn>
 <49f18070-0215-8475-907b-487d1e01c15c@ieee.org>
 <20220316162903.kwkfefyznvopvr5g@pengutronix.de>
 <a1074d55-c5ee-ced5-b9f7-0e1d023e1fea@linaro.org>
 <20220316200533.yuduet3gluvrmgcb@pengutronix.de>
From:   Song Chen <chensong_2000@189.cn>
In-Reply-To: <20220316200533.yuduet3gluvrmgcb@pengutronix.de>
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

hi Alex & Uwe,

Thanks for the advices and clarifications.

在 2022/3/17 04:05, Uwe Kleine-König 写道:
> On Wed, Mar 16, 2022 at 12:20:11PM -0500, Alex Elder wrote:
>> On 3/16/22 11:29 AM, Uwe Kleine-König wrote:
>>> On Wed, Mar 16, 2022 at 10:14:30AM -0500, Alex Elder wrote:
>>>> On 3/15/22 9:21 PM, Song Chen wrote:
>>>>> diff --git a/drivers/staging/greybus/pwm.c b/drivers/staging/greybus/pwm.c
>>>>> index 891a6a672378..3add3032678b 100644
>>>>> --- a/drivers/staging/greybus/pwm.c
>>>>> +++ b/drivers/staging/greybus/pwm.c
>>>>> @@ -204,43 +204,54 @@ static void gb_pwm_free(struct pwm_chip *chip, struct pwm_device *pwm)
>>>>>     	gb_pwm_deactivate_operation(pwmc, pwm->hwpwm);
>>>>>     }
>>>>> -static int gb_pwm_config(struct pwm_chip *chip, struct pwm_device *pwm,
>>>>> -			 int duty_ns, int period_ns)
>>>>> +static int gb_pwm_apply(struct pwm_chip *chip, struct pwm_device *pwm,
>>>>> +			const struct pwm_state *state)
>>>>>     {
>>>>> +	int err;
>>>>> +	bool enabled = pwm->state.enabled;
>>>>> +	u64 period = state->period;
>>>>> +	u64 duty_cycle = state->duty_cycle;
>>>>
>>>> The use of local variables here is inconsistent, and that
>>>> can be confusing.  Specifically, the "enabled" variable
>>>> represents the *current* state, while the "period" and
>>>> "duty_cycle" variables represent the *desired* state.  To
>>>> avoid confusion, if you're going to use local variables
>>>> like that, they should all represent *either* the current
>>>> state *or* the new state.  Please update your patch to
>>>> do one or the other.
>>>
>>> IMHO that it overly picky. I'm ok with the usage as is.
>>
>> I see the "enabled" flag is used in a way that I didn't
>> notice before.  Changing its name to "disabled" (to mean
>> "we have disabled the device within this function already")
>> would allow it to be used in the same way, but would make
>> it more obvious it's not just a copy of "old" device state.

Some of drivers in driver/pwn use pwm->state.enabled directly in their 
apply and others name it "enabled", see pwm-tiecap.c, pwm-berlin.c, 
pwm-vt8500.c and pwm-stm32.c.

I prefer keeping consist with those drivers, "disabled" confuses me.

>>
>>>>>     	struct gb_pwm_chip *pwmc = pwm_chip_to_gb_pwm_chip(chip);
>>>>> -	return gb_pwm_config_operation(pwmc, pwm->hwpwm, duty_ns, period_ns);
>>>>> -};
>>>>> +	/* set polarity */
>>>>> +	if (state->polarity != pwm->state.polarity) {
>>>>> +		if (enabled) {
>>>>> +			gb_pwm_disable_operation(pwmc, pwm->hwpwm);
>>>>> +			enabled = false;
>>>>> +		}
>>>>> +		err = gb_pwm_set_polarity_operation(pwmc, pwm->hwpwm, state->polarity);
>>>>> +		if (err)
>>>>> +			return err;
>>>>> +	}
>>>>> -static int gb_pwm_set_polarity(struct pwm_chip *chip, struct pwm_device *pwm,
>>>>> -			       enum pwm_polarity polarity)
>>>>> -{
>>>>> -	struct gb_pwm_chip *pwmc = pwm_chip_to_gb_pwm_chip(chip);
>>>>> +	if (!state->enabled) {
>>>>> +		if (enabled)
>>>>> +			gb_pwm_disable_operation(pwmc, pwm->hwpwm);
>>>>> +		return 0;
>>>>
>>>> If you are disabling the device, you return without updating the
>>>> period and duty cycle.  But you *do* set polarity.  Is that
>>>> required by the PWM API?  (I don't actually know.)  Or can the
>>>> polarity setting be simply ignored as well if the new state is
>>>> disabled?
>>>
>>> All is well here. A disabled PWM is expected to emit the inactive level.
>>> So polarity matters, duty and period don't.
>>
>> Thanks for clarifying that.  I did not know what was expected.
>>
>>>> Also, if the polarity changed, the device will have already been
>>>> disabled above, so there's no need to do so again (and perhaps
>>>> it might be a bad thing to do twice?).
>>>
>>> That won't happen, because if the device was disabled for the polarity
>>> change, enabled = false. In fact that is the purpose of the local
>>> variable.
>>
>> Now I see, yes, the local variable gets changed when the
>> disable occurred above.
>>
>>>>> +	}
>>>>> -	return gb_pwm_set_polarity_operation(pwmc, pwm->hwpwm, polarity);
>>>>> -};
>>>>
>>>> Since you're clamping the values to 32 bits here, your comment
>>>> should explain why (because Greybus uses 32-bit values here,
>>>> while the API supports 64 bit values).  That would be a much
>>>> more useful piece of information than "set period and duty cycle".
>>>>

done, thanks.

>>>>> +	/* set period and duty cycle*/
>>>>
>>>> Include a space before "*/" in your comments.
>>>
>>> ack
>>>

done, thanks.

>>>>> +	if (period > U32_MAX)
>>>>> +		period = U32_MAX;
>>>>> -static int gb_pwm_enable(struct pwm_chip *chip, struct pwm_device *pwm)
>>>>> -{
>>>>> -	struct gb_pwm_chip *pwmc = pwm_chip_to_gb_pwm_chip(chip);
>>>>> +	if (duty_cycle > period)
>>>>> +		duty_cycle = period;
>>>>> -	return gb_pwm_enable_operation(pwmc, pwm->hwpwm);
>>>>> -};
>>>>> +	err = gb_pwm_config_operation(pwmc, pwm->hwpwm, duty_cycle, period);
>>>>> +	if (err)
>>>>> +		return err;
>>>>
>>>> What if the new state set usage_power to true?  It would
>>>> be ignored here.  Is it OK to silently ignore it?  Even
>>>> if it is, a comment about that would be good to see, so
>>>> we know it's intentional.
>>>
>>> ignoring usage_power is OK. All but a single driver do it that way.
>>
>> I don't actually see anything that sets usage_power to true,
>> although "pwm-pca9685.c" tests its value.
>>
>> I guess it's an advisory parameter that's passed to the apply
>> callback function.  It's described as optional, but--not being
>> a "PWM person"--this isn't obvious to me.  Maybe the comments
>> describing the field or the apply callback could define the
>> semantics a little better at some point.
> 
> One of the problems I see with usage_power is that it's not well
> defined. The idea is that when usage_power is true, the driver is free
> to implement any setting that just matches the relative duty_cycle of
> the request. So if you call pwm_apply with
> 
> 	.duty_cycle = 2000
> 	.period = 10000
> 	.usage_power = true
> 	.polarity = PWM_POLARITY_NORMAL
> 
> you can program the hardware to implement
> 
> 	.duty_cycle = 200
> 	.period = 1000
> 	.polarity = PWM_POLARITY_NORMAL
> 
> or
> 
> 	.duty_cycle = 8000000
> 	.period = 10000000
> 	.polarity = PWM_POLARITY_INVERTED
> 
> The expectation is however to only deviate in a sensible manner from the
> request, whatever that might mean.
> 
> I don't see much value in that field, there is only one implementing
> driver and no mainline user. If you're interested you can reread the
> discussions about it in the archives.
> 
> Best regards
> Uwe
> 

what's more, "like" in commit message, removed.

Thanks

BR

Song
