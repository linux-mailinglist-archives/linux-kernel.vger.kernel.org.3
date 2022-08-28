Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 832955A3AD7
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Aug 2022 04:09:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230437AbiH1CHq convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Sat, 27 Aug 2022 22:07:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49582 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229458AbiH1CHm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 27 Aug 2022 22:07:42 -0400
Received: from relay.hostedemail.com (smtprelay0016.hostedemail.com [216.40.44.16])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B2D454DB46
        for <linux-kernel@vger.kernel.org>; Sat, 27 Aug 2022 19:07:41 -0700 (PDT)
Received: from omf19.hostedemail.com (a10.router.float.18 [10.200.18.1])
        by unirelay09.hostedemail.com (Postfix) with ESMTP id A4A2E808B3;
        Sun, 28 Aug 2022 02:07:40 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: joe@perches.com) by omf19.hostedemail.com (Postfix) with ESMTPA id 765B420027;
        Sun, 28 Aug 2022 02:07:39 +0000 (UTC)
Message-ID: <5ba98dbd91dc981ec7384484b2a498805abef6b0.camel@perches.com>
Subject: Re: [PATCH v2 4/4] pwm: sysfs: Utilize an array for polarity strings
From:   Joe Perches <joe@perches.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        linux-pwm@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Thierry Reding <thierry.reding@gmail.com>,
        Uwe =?ISO-8859-1?Q?Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>
Date:   Sat, 27 Aug 2022 22:07:38 -0400
In-Reply-To: <20220826170716.6886-4-andriy.shevchenko@linux.intel.com>
References: <20220826170716.6886-1-andriy.shevchenko@linux.intel.com>
         <20220826170716.6886-4-andriy.shevchenko@linux.intel.com>
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 8BIT
User-Agent: Evolution 3.44.4 (3.44.4-1.fc36) 
MIME-Version: 1.0
X-Rspamd-Queue-Id: 765B420027
X-Spam-Status: No, score=-0.9 required=5.0 tests=BAYES_00,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE,
        UNPARSEABLE_RELAY autolearn=no autolearn_force=no version=3.4.6
X-Stat-Signature: hed4q761cpj4ekwmpa1xwd89x111ebwk
X-Rspamd-Server: rspamout05
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Session-ID: U2FsdGVkX18e8tZ+l4e9sZ6+USwDYNFsrhKxx8WnSpk=
X-HE-Tag: 1661652459-664208
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2022-08-26 at 20:07 +0300, Andy Shevchenko wrote:
> Code is smaller and looks nicer if we combine polarity strings
> into an array.

It's less robust though as PWM_POLARITY_NORMAL and _INVERSED
are now required to be 0 and 1.  As the only 2 values in
an enum they are, but that's not really guaranteed unless
you read the enum definition.

> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> ---
> v2: added pwm_ prefix to the variable (Uwe), adjusted intendation (Uwe)
>  drivers/pwm/sysfs.c | 32 ++++++++++++--------------------
>  1 file changed, 12 insertions(+), 20 deletions(-)
> 
> diff --git a/drivers/pwm/sysfs.c b/drivers/pwm/sysfs.c
> index 767c4b19afb1..502167e44a3d 100644
> --- a/drivers/pwm/sysfs.c
> +++ b/drivers/pwm/sysfs.c
> @@ -151,27 +151,23 @@ static ssize_t enable_store(struct device *child,
>  	return ret ? : size;
>  }
>  
> +static const char * const pwm_polarity_strings[] = {
> +	[PWM_POLARITY_NORMAL] = "normal",
> +	[PWM_POLARITY_INVERSED] = "inversed",
> +};
> +
>  static ssize_t polarity_show(struct device *child,
>  			     struct device_attribute *attr,
>  			     char *buf)
>  {
>  	const struct pwm_device *pwm = child_to_pwm_device(child);
> -	const char *polarity = "unknown";
>  	struct pwm_state state;
>  
>  	pwm_get_state(pwm, &state);
> +	if (state.polarity < 0 || state.polarity >= ARRAY_SIZE(pwm_polarity_strings))
> +		return sysfs_emit(buf, "unknown\n");
>  
> -	switch (state.polarity) {
> -	case PWM_POLARITY_NORMAL:
> -		polarity = "normal";
> -		break;
> -
> -	case PWM_POLARITY_INVERSED:
> -		polarity = "inversed";
> -		break;
> -	}
> -
> -	return sysfs_emit(buf, "%s\n", polarity);
> +	return sysfs_emit(buf, "%s\n", pwm_polarity_strings[state.polarity]);
>  }
>  
>  static ssize_t polarity_store(struct device *child,
> @@ -180,20 +176,16 @@ static ssize_t polarity_store(struct device *child,
>  {
>  	struct pwm_export *export = child_to_pwm_export(child);
>  	struct pwm_device *pwm = export->pwm;
> -	enum pwm_polarity polarity;
>  	struct pwm_state state;
>  	int ret;
>  
> -	if (sysfs_streq(buf, "normal"))
> -		polarity = PWM_POLARITY_NORMAL;
> -	else if (sysfs_streq(buf, "inversed"))
> -		polarity = PWM_POLARITY_INVERSED;
> -	else
> -		return -EINVAL;
> +	ret = sysfs_match_string(pwm_polarity_strings, buf);
> +	if (ret < 0)
> +		return ret;
>  
>  	mutex_lock(&export->lock);
>  	pwm_get_state(pwm, &state);
> -	state.polarity = polarity;
> +	state.polarity = ret;
>  	ret = pwm_apply_state(pwm, &state);
>  	mutex_unlock(&export->lock);
>  

