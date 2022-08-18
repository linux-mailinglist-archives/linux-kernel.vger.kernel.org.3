Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E918C59896D
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Aug 2022 18:56:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240604AbiHRQzx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 Aug 2022 12:55:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53960 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345255AbiHRQzs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Aug 2022 12:55:48 -0400
Received: from mail-pg1-x529.google.com (mail-pg1-x529.google.com [IPv6:2607:f8b0:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A2F03C877E;
        Thu, 18 Aug 2022 09:55:47 -0700 (PDT)
Received: by mail-pg1-x529.google.com with SMTP id bh13so1740259pgb.4;
        Thu, 18 Aug 2022 09:55:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc;
        bh=n3DcIdab63hEixWcKdeH49lgr7H7ecdw8/B63sRxyM0=;
        b=LJpPH4mV20nGeOd1dfgV76NyTtCiAHqlyVXXgJHSdfI8gTVulWlwkSaHrtMItc4VOr
         1fT5iVfxWSq3sZQC1tPEsA1MriWpVHCsWXewg0cXt0z8vgoy0iiIJox8+R4Xm6s3e1js
         NIER/4gqauV2dRzOxuhgORFwA47jL7sm3dwSQqI1dXFYOt40u+EH3lHbgVlmxB7vc7EE
         zkO9Khrj5eS/M73N/K+fj8RXZWqs7yYNQKb3EbDnIKnRlO3Jr5AzWG0CpU7LLNYNY6PI
         Y1PMB3X49eNecuahYdpq9+y3BUvz/rPTe0W0cMietW7Xr4J5OFV3S8AvoRu0C+PBX1IB
         kAWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc;
        bh=n3DcIdab63hEixWcKdeH49lgr7H7ecdw8/B63sRxyM0=;
        b=7fGNDm8+jUpFc/8CmO6VjmscTwjdevBQB1DXPC1wo2KbNYf1fHQT61xa+m7iiCDz8x
         sDkpud7wQzh40B32Cv7pIRNDYpYpNR/u+URDMGil1nzZQNIXDD5J4P1gwTIruiWxGOsh
         88qazSSODTNoMvP2FgkQiRQzsRwQ1TmGK44Z0CyHZGJ1hekdIuAoQb3y3tfanREbOqXg
         U/cY+jwJCtnjefOurt4SXuXt/6yQDprTV9+5yWKuBP775mK9fRaShmjvvy6EjYXi0CIm
         xGWn6J0qNybyTSXaZgo3InMySmT6hkqPaYC6lJaV59N+m+FtV2Rno8YwwfrxsNrYH6zg
         tWww==
X-Gm-Message-State: ACgBeo1hr8nVCaZyhb6WOJo5IYwbD+kWwR6aaZr1bg1Ew8hQ3oXKw35y
        ohikIy+nQkP35UWl67ctJ4s=
X-Google-Smtp-Source: AA6agR6qUvyvvaz2qGprn+WVQccK7zEoBYMLef5B54GAD6p8IpjT9c8xodv9D6ktNeUkUoTT2wolnA==
X-Received: by 2002:a05:6a00:2a05:b0:52e:6c05:9b84 with SMTP id ce5-20020a056a002a0500b0052e6c059b84mr3695563pfb.77.1660841746706;
        Thu, 18 Aug 2022 09:55:46 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id n17-20020a170902e55100b0016dbaf3ff2esm1656408plf.22.2022.08.18.09.55.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Aug 2022 09:55:45 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date:   Thu, 18 Aug 2022 09:55:43 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     Alexey Klimov <aklimov@redhat.com>
Cc:     linux-watchdog@vger.kernel.org, wim@linux-watchdog.org,
        linux-kernel@vger.kernel.org, klimov.linux@gmail.com
Subject: Re: [PATCH REVIEW 1/2] watchdog: extend the mutex-protected section
 in watchdog_cdev_unregister()
Message-ID: <20220818165543.GA923105@roeck-us.net>
References: <20220818020624.2386475-1-aklimov@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220818020624.2386475-1-aklimov@redhat.com>
X-Spam-Status: No, score=-1.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 18, 2022 at 03:06:23AM +0100, Alexey Klimov wrote:
> watchdog_stop() should be called with wd_data->lock mutex locked.
> Updates to wdd->status also occur under this look throughout the
> watchdog_dev.c as well as functions that deal with pretimeout hrtimer
> like watchdog_hrtimer_pretimeout_stop() here.
> 

What actual problems are you fixing here ?

Guenter

> Signed-off-by: Alexey Klimov <aklimov@redhat.com>
> ---
>  drivers/watchdog/watchdog_dev.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/watchdog/watchdog_dev.c b/drivers/watchdog/watchdog_dev.c
> index 54903f3c851e..804236a094f6 100644
> --- a/drivers/watchdog/watchdog_dev.c
> +++ b/drivers/watchdog/watchdog_dev.c
> @@ -1095,6 +1095,8 @@ static void watchdog_cdev_unregister(struct watchdog_device *wdd)
>  		old_wd_data = NULL;
>  	}
>  
> +	mutex_lock(&wd_data->lock);
> +
>  	if (watchdog_active(wdd) &&
>  	    test_bit(WDOG_STOP_ON_UNREGISTER, &wdd->status)) {
>  		watchdog_stop(wdd);
> @@ -1102,7 +1104,6 @@ static void watchdog_cdev_unregister(struct watchdog_device *wdd)
>  
>  	watchdog_hrtimer_pretimeout_stop(wdd);
>  
> -	mutex_lock(&wd_data->lock);
>  	wd_data->wdd = NULL;
>  	wdd->wd_data = NULL;
>  	mutex_unlock(&wd_data->lock);
> -- 
> 2.37.2
> 
