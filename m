Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 76AC247E525
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Dec 2021 15:52:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239748AbhLWOwT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Dec 2021 09:52:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51344 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236473AbhLWOwS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Dec 2021 09:52:18 -0500
Received: from mail-pl1-x62c.google.com (mail-pl1-x62c.google.com [IPv6:2607:f8b0:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 96CE1C061756
        for <linux-kernel@vger.kernel.org>; Thu, 23 Dec 2021 06:52:18 -0800 (PST)
Received: by mail-pl1-x62c.google.com with SMTP id x15so4549563plg.1
        for <linux-kernel@vger.kernel.org>; Thu, 23 Dec 2021 06:52:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=CugRxVCOm+9iRZokknJxYJHgL5jpmQMZdVEfQBT3ih0=;
        b=azASY7fooyhQwm0kP2LA7PXxfvet31Lg+pCCnSZ/MzmYitl6uAWKbr5bUpGIsylhQL
         mpt3vCHPk2sWO9IiSzqqheoBPwLf3j/MBl1LrcKvAkBugwW/LoP1X+l7vAFMmJfzuS4Y
         6670miVH+970PYWSFW1rOkT5+NAYEIA9oYuRY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=CugRxVCOm+9iRZokknJxYJHgL5jpmQMZdVEfQBT3ih0=;
        b=E6iXwQ6J+M+JMsdf4zSFREpNhNAmB6e3jSbTFt4/Noe4enRrfS/nAh7ewVhv6j88HZ
         0GLeyCnc4H8JYGcmUy7ybME8TTz1rxC2j1n74hx5TpWN+nRAEA51DmjVjZqEAwH/I28K
         0wE02oeVz7lfh2PdzkgXEe78EFMiihw185zV5iCRnc4t0qiiQPPDvmGrU8RucQnpja7g
         iB0dz6mwPYzrspSiSCjO5mhJx/UdRvOUnZUcLadKn+/46FwkDBGWYZVGooQb9IyFhNaF
         IoTm/6aKOPhnrOYMk/mWNnyNU44rh2go17d3aGIPM6iVZMFjqjU3nsjnLg8DLkhOyl6C
         wzRw==
X-Gm-Message-State: AOAM533ejIGyBUW+sKq4go+QRUs/rk/PRfmtT7C0+B3npeHXIbdi7rnp
        DQPzhK0jfQYADN654a1nA4EwJId2ShyEAA==
X-Google-Smtp-Source: ABdhPJyfLxyAXYp9QiVqz2zUGDKewLjq4d4yM6owaB+h09ApXc0/BFgKN3Y4X6+jokx/Nuk4iT/Guw==
X-Received: by 2002:a17:903:22cb:b0:149:208f:d5dd with SMTP id y11-20020a17090322cb00b00149208fd5ddmr2492863plg.60.1640271138001;
        Thu, 23 Dec 2021 06:52:18 -0800 (PST)
Received: from localhost ([2620:15c:202:201:bc36:6516:dfc5:c35c])
        by smtp.gmail.com with UTF8SMTPSA id h191sm5313697pge.55.2021.12.23.06.52.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 23 Dec 2021 06:52:17 -0800 (PST)
Date:   Thu, 23 Dec 2021 06:52:16 -0800
From:   Matthias Kaehlcke <mka@chromium.org>
To:     Manaf Meethalavalappu Pallikunhi <quic_manafm@quicinc.com>
Cc:     "Rafael J . Wysocki" <rafael@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Amit Kucheria <amitk@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>,
        Thara Gopinath <thara.gopinath@linaro.org>,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] thermal/core: Clear all mitigation when thermal zone is
 disabled
Message-ID: <YcSNIJVnCQvx6ttg@google.com>
References: <1640083318-19277-1-git-send-email-quic_manafm@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1640083318-19277-1-git-send-email-quic_manafm@quicinc.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 21, 2021 at 04:11:58PM +0530, Manaf Meethalavalappu Pallikunhi wrote:
> Whenever a thermal zone is in trip violated state, there is a chance
> that the same thermal zone mode can be disabled either via thermal
> core API or via thermal zone sysfs. Once it is disabled, the framework
> bails out any re-evaluation of thermal zone. It leads to a case where
> if it is already in mitigation state, it will stay the same state
> until it is re-enabled.
> 
> To avoid above mentioned issue, on thermal zone disable request
> reset thermal zone and clear mitigation for each trip explicitly.
> 
> Signed-off-by: Manaf Meethalavalappu Pallikunhi <quic_manafm@quicinc.com>
> ---
>  drivers/thermal/thermal_core.c | 9 ++++++++-
>  1 file changed, 8 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/thermal/thermal_core.c b/drivers/thermal/thermal_core.c
> index 51374f4..a8ae340 100644
> --- a/drivers/thermal/thermal_core.c
> +++ b/drivers/thermal/thermal_core.c
> @@ -427,6 +427,7 @@ static int thermal_zone_device_set_mode(struct thermal_zone_device *tz,
>  					enum thermal_device_mode mode)
>  {
>  	int ret = 0;
> +	int count;
>  
>  	mutex_lock(&tz->lock);
>  
> @@ -449,8 +450,14 @@ static int thermal_zone_device_set_mode(struct thermal_zone_device *tz,
>  
>  	if (mode == THERMAL_DEVICE_ENABLED)
>  		thermal_notify_tz_enable(tz->id);
> -	else
> +	else {
> +		/* make sure all previous throttlings are cleared */
> +		thermal_zone_device_init(tz);
> +		for (count = 0; count < tz->trips; count++)
> +			handle_thermal_trip(tz, count);

nit: s/count/trip/
