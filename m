Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1DC524B1CCE
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Feb 2022 04:07:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242081AbiBKDG4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Feb 2022 22:06:56 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:40156 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232948AbiBKDGl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Feb 2022 22:06:41 -0500
Received: from 189.cn (ptr.189.cn [183.61.185.101])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 1A8622647;
        Thu, 10 Feb 2022 19:06:40 -0800 (PST)
HMM_SOURCE_IP: 10.64.8.31:49220.1910361997
HMM_ATTACHE_NUM: 0000
HMM_SOURCE_TYPE: SMTP
Received: from clientip-123.150.8.42 (unknown [10.64.8.31])
        by 189.cn (HERMES) with SMTP id 99CBF1002B4;
        Fri, 11 Feb 2022 11:06:36 +0800 (CST)
Received: from  ([123.150.8.42])
        by gateway-153622-dep-749df8664c-cv9r2 with ESMTP id 4ae6a8bd32514b71bf2478f1bf333233 for u.kleine-koenig@pengutronix.de;
        Fri, 11 Feb 2022 11:06:38 CST
X-Transaction-ID: 4ae6a8bd32514b71bf2478f1bf333233
X-Real-From: chensong_2000@189.cn
X-Receive-IP: 123.150.8.42
X-MEDUSA-Status: 0
Sender: chensong_2000@189.cn
Message-ID: <6acc4f74-31a1-75b2-f7e8-610aac7b0ec8@189.cn>
Date:   Fri, 11 Feb 2022 11:06:33 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH] staging: greybus: introduce pwm_ops::apply
Content-Language: en-US
To:     =?UTF-8?Q?Uwe_Kleine-K=c3=b6nig?= <u.kleine-koenig@pengutronix.de>
Cc:     johan@kernel.org, elder@kernel.org, gregkh@linuxfoundation.org,
        thierry.reding@gmail.com, lee.jones@linaro.org,
        greybus-dev@lists.linaro.org, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org, linux-pwm@vger.kernel.org
References: <1644483902-9200-1-git-send-email-chensong_2000@189.cn>
 <20220210100342.q2t4ykgyymjzr3fj@pengutronix.de>
From:   Song Chen <chensong_2000@189.cn>
In-Reply-To: <20220210100342.q2t4ykgyymjzr3fj@pengutronix.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



在 2022/2/10 18:03, Uwe Kleine-König 写道:
> On Thu, Feb 10, 2022 at 05:05:02PM +0800, Song Chen wrote:
>> Introduce apply in pwm_ops to replace legacy operations,
>> like enable, disable, config and set_polarity.
>>
>> Signed-off-by: Song Chen <chensong_2000@189.cn>
>> ---
>>   drivers/staging/greybus/pwm.c | 46 +++++++++++++++--------------------
>>   1 file changed, 19 insertions(+), 27 deletions(-)
>>
>> diff --git a/drivers/staging/greybus/pwm.c b/drivers/staging/greybus/pwm.c
>> index 891a6a672378..e1889cf979b2 100644
>> --- a/drivers/staging/greybus/pwm.c
>> +++ b/drivers/staging/greybus/pwm.c
>> @@ -204,43 +204,35 @@ static void gb_pwm_free(struct pwm_chip *chip, struct pwm_device *pwm)
>>   	gb_pwm_deactivate_operation(pwmc, pwm->hwpwm);
>>   }
>>   
>> -static int gb_pwm_config(struct pwm_chip *chip, struct pwm_device *pwm,
>> -			 int duty_ns, int period_ns)
>> -{
>> -	struct gb_pwm_chip *pwmc = pwm_chip_to_gb_pwm_chip(chip);
>> -
>> -	return gb_pwm_config_operation(pwmc, pwm->hwpwm, duty_ns, period_ns);
>> -};
>> -
>> -static int gb_pwm_set_polarity(struct pwm_chip *chip, struct pwm_device *pwm,
>> -			       enum pwm_polarity polarity)
>> +static int gb_pwm_apply(struct pwm_chip *chip, struct pwm_device *pwm,
>> +			const struct pwm_state *state)
>>   {
>> +	int ret;
>>   	struct gb_pwm_chip *pwmc = pwm_chip_to_gb_pwm_chip(chip);
>>   
>> -	return gb_pwm_set_polarity_operation(pwmc, pwm->hwpwm, polarity);
>> -};
>> -
>> -static int gb_pwm_enable(struct pwm_chip *chip, struct pwm_device *pwm)
>> -{
>> -	struct gb_pwm_chip *pwmc = pwm_chip_to_gb_pwm_chip(chip);
>> +	/* set period and duty cycle*/
>> +	ret = gb_pwm_config_operation(pwmc, pwm->hwpwm, state->duty_cycle, state->period);
> 
> gb_pwm_config_operation's 3rd parameter is an u32, so you're loosing
> bits here as state->duty_cycle is a u64. Ditto for period.

originally, pwm_apply_state --> pwm_apply_legacy --> gb_pwm_config --> 
gb_pwm_config_operation is also loosing bits, does it mean greybus can 
live with that?

Or redefine gb_pwm_config_request, switch duty and period to __le64?

> 
> Also it would be nice if you go from
> 
> 	.duty_cycle = A, .period = B, .enabled = 1
> 
> to
> 
> 	.duty_cycle = C, .period = D, .enabled = 0
> 
> that C/D wasn't visible on the output pin. So please disable earlier
> (but keep enable at the end).

sorry, i don't quite understand this part, but is below code looking 
good to you?

static int gb_pwm_apply(struct pwm_chip *chip, struct pwm_device *pwm,
			const struct pwm_state *state)
{
	int err;
	bool enabled = pwm->state.enabled;
	struct gb_pwm_chip *pwmc = pwm_chip_to_gb_pwm_chip(chip);

	/* set polarity */
	if (state->polarity != pwm->state.polarity) {
		if (enabled) {
			gb_pwm_disable_operation(pwmc, pwm->hwpwm);
			enabled = false;
		}
		err = gb_pwm_set_polarity_operation(pwmc, pwm->hwpwm, state->polarity);
		if (err)
			return err;
	}

	if (!state->enabled) {
		if (enabled)
			gb_pwm_disable_operation(pwmc, pwm->hwpwm);
		return 0;
	}

	/* set period and duty cycle*/
	err = gb_pwm_config_operation(pwmc, pwm->hwpwm, state->duty_cycle, 
state->period);
	if (err)
		return err;

	/* enable/disable */
	if (!enabled)
		return gb_pwm_enable_operation(pwmc, pwm->hwpwm);

	return 0;
}

> 
> Best regards
> Uwe
> 
