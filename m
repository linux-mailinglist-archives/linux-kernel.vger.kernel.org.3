Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E4F804DDA08
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Mar 2022 13:58:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236458AbiCRM7i (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Mar 2022 08:59:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37754 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234085AbiCRM7i (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Mar 2022 08:59:38 -0400
Received: from 189.cn (ptr.189.cn [183.61.185.101])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 971C82AA879;
        Fri, 18 Mar 2022 05:58:17 -0700 (PDT)
HMM_SOURCE_IP: 10.64.8.31:34786.918040143
HMM_ATTACHE_NUM: 0000
HMM_SOURCE_TYPE: SMTP
Received: from clientip-117.13.170.79 (unknown [10.64.8.31])
        by 189.cn (HERMES) with SMTP id E2DA4100132;
        Fri, 18 Mar 2022 20:58:12 +0800 (CST)
Received: from  ([117.13.170.79])
        by gateway-151646-dep-b7fbf7d79-bwdqx with ESMTP id 42c959ff59a34243a620c7ace1295b92 for elder@ieee.org;
        Fri, 18 Mar 2022 20:58:13 CST
X-Transaction-ID: 42c959ff59a34243a620c7ace1295b92
X-Real-From: chensong_2000@189.cn
X-Receive-IP: 117.13.170.79
X-MEDUSA-Status: 0
Sender: chensong_2000@189.cn
Subject: Re: [PATCH v6] staging: greybus: introduce pwm_ops::apply
To:     Alex Elder <elder@linaro.org>, johan@kernel.org, elder@kernel.org,
        gregkh@linuxfoundation.org, thierry.reding@gmail.com,
        u.kleine-koenig@pengutronix.de, lee.jones@linaro.org,
        greybus-dev@lists.linaro.org, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org, linux-pwm@vger.kernel.org,
        elder@ieee.org
References: <1647597432-27586-1-git-send-email-chensong_2000@189.cn>
 <a4b3ad02-f1c7-c13b-7740-d5b9982bd7c7@linaro.org>
From:   chensong <chensong_2000@189.cn>
Message-ID: <a8b8def4-dbf0-cfd0-d456-265ab4fc8d7f@189.cn>
Date:   Fri, 18 Mar 2022 20:58:12 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <a4b3ad02-f1c7-c13b-7740-d5b9982bd7c7@linaro.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
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

hi Alex,

On 2022/3/18 下午8:15, Alex Elder wrote:
> On 3/18/22 4:57 AM, Song Chen wrote:
>> Introduce newer .apply function in pwm_ops to replace legacy operations
>> including enable, disable, config and set_polarity.
>>
>> This guarantees atomic changes of the pwm controller configuration.
>>
>> Signed-off-by: Song Chen <chensong_2000@189.cn>
> 
> I had another comment suggestion but you've been through enough.
> Thanks for working this to completion.

sorry about that, i probably missed it somehow. Thanks for the 
understanding.

Song

> 
> Reviewed-by: Alex Elder <elder@linaro.org>
> 
>>
>> ---
>> v2:
>> 1, define duty_cycle and period as u64 in gb_pwm_config_operation.
>> 2, define duty and period as u64 in gb_pwm_config_request.
>> 3, disable before configuring duty and period if the eventual goal
>>     is a disabled state.
>>
>> v3:
>> Regarding duty_cycle and period, I read more discussion in this thread,
>> min, warn or -EINVAL, seems no perfect way acceptable for everyone.
>> How about we limit their value to INT_MAX and throw a warning at the
>> same time when they are wrong?
>>
>> v4:
>> 1, explain why legacy operations are replaced.
>> 2, cap the value of period and duty to U32_MAX.
>>
>> v5:
>> 1, revise commit message.
>>
>> v6:
>> 1, revise commit message.
>> 2, explain why capping the value of period and duty to U32_MAX in
>>     comment.
>> ---
>>   drivers/staging/greybus/pwm.c | 64 ++++++++++++++++++++++-------------
>>   1 file changed, 40 insertions(+), 24 deletions(-)
>>
>> diff --git a/drivers/staging/greybus/pwm.c 
>> b/drivers/staging/greybus/pwm.c
>> index 891a6a672378..ad20ec24031e 100644
>> --- a/drivers/staging/greybus/pwm.c
>> +++ b/drivers/staging/greybus/pwm.c
>> @@ -204,43 +204,59 @@ static void gb_pwm_free(struct pwm_chip *chip, 
>> struct pwm_device *pwm)
>>       gb_pwm_deactivate_operation(pwmc, pwm->hwpwm);
>>   }
>> -static int gb_pwm_config(struct pwm_chip *chip, struct pwm_device *pwm,
>> -             int duty_ns, int period_ns)
>> +static int gb_pwm_apply(struct pwm_chip *chip, struct pwm_device *pwm,
>> +            const struct pwm_state *state)
>>   {
>> +    int err;
>> +    bool enabled = pwm->state.enabled;
>> +    u64 period = state->period;
>> +    u64 duty_cycle = state->duty_cycle;
>>       struct gb_pwm_chip *pwmc = pwm_chip_to_gb_pwm_chip(chip);
>> -    return gb_pwm_config_operation(pwmc, pwm->hwpwm, duty_ns, 
>> period_ns);
>> -};
>> +    /* Set polarity */
>> +    if (state->polarity != pwm->state.polarity) {
>> +        if (enabled) {
>> +            gb_pwm_disable_operation(pwmc, pwm->hwpwm);
>> +            enabled = false;
>> +        }
>> +        err = gb_pwm_set_polarity_operation(pwmc, pwm->hwpwm, 
>> state->polarity);
>> +        if (err)
>> +            return err;
>> +    }
>> -static int gb_pwm_set_polarity(struct pwm_chip *chip, struct 
>> pwm_device *pwm,
>> -                   enum pwm_polarity polarity)
>> -{
>> -    struct gb_pwm_chip *pwmc = pwm_chip_to_gb_pwm_chip(chip);
>> +    if (!state->enabled) {
>> +        if (enabled)
>> +            gb_pwm_disable_operation(pwmc, pwm->hwpwm);
>> +        return 0;
>> +    }
>> -    return gb_pwm_set_polarity_operation(pwmc, pwm->hwpwm, polarity);
>> -};
>> +    /*
>> +     * Set period and duty cycle
>> +     *
>> +     * PWM privodes 64-bit period and duty_cycle, but greybus only 
>> accepts
>> +     * 32-bit, so their values have to be limited to U32_MAX.
>> +     */
>> +    if (period > U32_MAX)
>> +        period = U32_MAX;
>> -static int gb_pwm_enable(struct pwm_chip *chip, struct pwm_device *pwm)
>> -{
>> -    struct gb_pwm_chip *pwmc = pwm_chip_to_gb_pwm_chip(chip);
>> +    if (duty_cycle > period)
>> +        duty_cycle = period;
>> -    return gb_pwm_enable_operation(pwmc, pwm->hwpwm);
>> -};
>> +    err = gb_pwm_config_operation(pwmc, pwm->hwpwm, duty_cycle, period);
>> +    if (err)
>> +        return err;
>> -static void gb_pwm_disable(struct pwm_chip *chip, struct pwm_device 
>> *pwm)
>> -{
>> -    struct gb_pwm_chip *pwmc = pwm_chip_to_gb_pwm_chip(chip);
>> +    /* enable/disable */
>> +    if (!enabled)
>> +        return gb_pwm_enable_operation(pwmc, pwm->hwpwm);
>> -    gb_pwm_disable_operation(pwmc, pwm->hwpwm);
>> -};
>> +    return 0;
>> +}
>>   static const struct pwm_ops gb_pwm_ops = {
>>       .request = gb_pwm_request,
>>       .free = gb_pwm_free,
>> -    .config = gb_pwm_config,
>> -    .set_polarity = gb_pwm_set_polarity,
>> -    .enable = gb_pwm_enable,
>> -    .disable = gb_pwm_disable,
>> +    .apply = gb_pwm_apply,
>>       .owner = THIS_MODULE,
>>   };
> 
> 
