Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B61E8510A1B
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Apr 2022 22:16:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354566AbiDZUSt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Apr 2022 16:18:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53848 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354433AbiDZUSp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Apr 2022 16:18:45 -0400
Received: from mail-oa1-x29.google.com (mail-oa1-x29.google.com [IPv6:2001:4860:4864:20::29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 59A17A1A2;
        Tue, 26 Apr 2022 13:15:13 -0700 (PDT)
Received: by mail-oa1-x29.google.com with SMTP id 586e51a60fabf-d6e29fb3d7so20576388fac.7;
        Tue, 26 Apr 2022 13:15:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=mszjJcEh9386KaxLAalpyivXjgdVDMZ4ZhAQwFI1JQA=;
        b=KirBJW9BaM6fxTuPrlcgIQbPenawrKUARiUOj2dX18BBWJQd6j6wxZCiJn0sPjNR7W
         97BwqsjNb32/w5Krs0ll3wBRLzxxnQ9jSdAbqqvTDprRED+kG9Ox5CiFvyx/7xWLs3qg
         nrllrEW+DJz7TqKEjBerLlTg8oATzQ1UQAPjPpdWql2CDmvSCUnnBX/uwZtabnpXWbHf
         858hdUmF1Ho13dDRpWgBBAYwjuF1BDHTICkmbA3C5W8UDluZWF0PhrMUXC9A7tyFrqFr
         tIGabSXBEeJHmmYJMp1+3fJFhzXteVDOdXoBzItnYm+Rdde6eYK9RzDQWA4NdNXiuYTz
         GOPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=mszjJcEh9386KaxLAalpyivXjgdVDMZ4ZhAQwFI1JQA=;
        b=jXwwu18hj/cVVo6oBy6l1VOsvhGUam3E7GQ1RSEHW00AX03ej37fjPbKZHENaYhfgW
         ESLBTTOEpUrVQLeWstiMFbxcMq0gNjj+7FX0wWDuArctrSIQc9zSGnGPVJLDHfWxYI1s
         hADfWcI/R+4fvTwfBihEuFPTSMGm+1/M+F8zpy5xALzJbBRNZWY/oFXsiNsLzT6kTaIC
         z4Y71RVa6ehMq0PYvdTlbPVzL+qBIP8UP56DoEk47WWPXK2ckocl2ZJu4h5ts6iTIBYr
         PGGHxXeP+wZwnFoxzvC+dLKuEmmAGhO0O7CEhBSCc9ebsH0eW2aR/nUfRryp0+29JeLU
         OaGQ==
X-Gm-Message-State: AOAM531O+vMupPJW9YDVIoDpvK4iBhkbTWHK9kGfrvemswcLC0t3UuJ0
        uPkUZKfCd9OTutjRLyVr2CCwjHGMQM4=
X-Google-Smtp-Source: ABdhPJxE4uNLp6cveVevK5sQVGer8eawxyiIT08u9kHghpsD343qbD/72pdeIdE+/6SJZa3IUdYBYQ==
X-Received: by 2002:a05:6871:206:b0:e9:1f61:af76 with SMTP id t6-20020a056871020600b000e91f61af76mr6992184oad.238.1651004112600;
        Tue, 26 Apr 2022 13:15:12 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id p15-20020a4adfcf000000b0033a48bce3afsm5900233ood.18.2022.04.26.13.15.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Apr 2022 13:15:11 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date:   Tue, 26 Apr 2022 13:15:10 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     Liu Xinpeng <liuxp11@chinatelecom.cn>
Cc:     wim@linux-watchdog.org, tzungbi@kernel.org,
        linux-watchdog@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v8 1/3] watchdog: wdat_wdt: Using the existing function
 to check parameter timeout
Message-ID: <20220426201510.GK4093517@roeck-us.net>
References: <1650984810-6247-1-git-send-email-liuxp11@chinatelecom.cn>
 <1650984810-6247-2-git-send-email-liuxp11@chinatelecom.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1650984810-6247-2-git-send-email-liuxp11@chinatelecom.cn>
X-Spam-Status: No, score=-1.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 26, 2022 at 10:53:28PM +0800, Liu Xinpeng wrote:
> If max_hw_heartbeat_ms is provided, the configured maximum timeout is not
> limited by it. The limit check in this driver therefore doesn't make much
> sense. Similar, the watchdog core ensures that minimum timeout limits are
> met if min_hw_heartbeat_ms is set. Using watchdog_timeout_invalid() makes
> more sense because it takes this into account.
> 
> Signed-off-by: Liu Xinpeng <liuxp11@chinatelecom.cn>

Reviewed-by: Guenter Roeck <linux@roeck-us.net>

> ---
>  drivers/watchdog/wdat_wdt.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/watchdog/wdat_wdt.c b/drivers/watchdog/wdat_wdt.c
> index 195c8c004b69..df0865a61a70 100644
> --- a/drivers/watchdog/wdat_wdt.c
> +++ b/drivers/watchdog/wdat_wdt.c
> @@ -344,6 +344,7 @@ static int wdat_wdt_probe(struct platform_device *pdev)
>  	wdat->period = tbl->timer_period;
>  	wdat->wdd.min_hw_heartbeat_ms = wdat->period * tbl->min_count;
>  	wdat->wdd.max_hw_heartbeat_ms = wdat->period * tbl->max_count;
> +	wdat->wdd.min_timeout = 1;
>  	wdat->stopped_in_sleep = tbl->flags & ACPI_WDAT_STOPPED;
>  	wdat->wdd.info = &wdat_wdt_info;
>  	wdat->wdd.ops = &wdat_wdt_ops;
> @@ -450,8 +451,7 @@ static int wdat_wdt_probe(struct platform_device *pdev)
>  	 * watchdog properly after it has opened the device. In some cases
>  	 * the BIOS default is too short and causes immediate reboot.
>  	 */
> -	if (timeout * 1000 < wdat->wdd.min_hw_heartbeat_ms ||
> -	    timeout * 1000 > wdat->wdd.max_hw_heartbeat_ms) {
> +	if (watchdog_timeout_invalid(&wdat->wdd, timeout)) {
>  		dev_warn(dev, "Invalid timeout %d given, using %d\n",
>  			 timeout, WDAT_DEFAULT_TIMEOUT);
>  		timeout = WDAT_DEFAULT_TIMEOUT;
> -- 
> 2.23.0
> 
