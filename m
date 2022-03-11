Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 56BF94D68A6
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Mar 2022 19:47:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351041AbiCKSsZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Mar 2022 13:48:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39482 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350993AbiCKSsV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Mar 2022 13:48:21 -0500
Received: from mail-oi1-x230.google.com (mail-oi1-x230.google.com [IPv6:2607:f8b0:4864:20::230])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 770291D3ADB
        for <linux-kernel@vger.kernel.org>; Fri, 11 Mar 2022 10:47:17 -0800 (PST)
Received: by mail-oi1-x230.google.com with SMTP id v75so1492389oie.1
        for <linux-kernel@vger.kernel.org>; Fri, 11 Mar 2022 10:47:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=8O/g/66xli2mGCsue3R7/uS8wbuUW3P+q7HMYxcp6M8=;
        b=HmmbCVRC6P2RC7Al7oAXcCqsy2j/w2L8fW0oshaSTBjjErwTm/47vB6+nuMOR5jHQF
         C2FBBpzRqRb17uCg8dKsKCt9CYfAufe07qu2EnC65cuSfwnci2Rz3+GA4TSqXMOrFvXJ
         w1VPvUhZe9YQT+th0VA4b9c1kC9q1Bamy7ChXtETLXUNX4fBr9NyLhMeMf7uFd6C7eD0
         2LzS1A0HaWdnVHEf1H8IhG/W1TLah+GO0keKTnPx9u10hoE36PCZTS3CA5a3vhD/YxW/
         i28Y1R36jvT5QbPgrMuP/MyzzAUVOIb71aK/EbnVwFN7frjdhYeun2oLBcaD50diZwfG
         BHKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=8O/g/66xli2mGCsue3R7/uS8wbuUW3P+q7HMYxcp6M8=;
        b=HGQByiL4hWU9Bgau5fLQh+0LV/rTNsk1Qx9q+WjCljrkmLCg3NlUud8Hd4gjIursma
         Iu9Tq30vuu7jMlzKlGsjV3QupSqVL6iUCfJXdCwUV/seqdaOLn4gT4zj9Btc9yRNfC5v
         TqXNS5FMLe8D1oSVlQzAMfV50T7giCkQ9wxMa962U7fia3arg4ab2EY/P8QB8Q83oKbu
         94M/YoNwL9GOmVSwDIrrJiP04qx2txF+0Dmo45CrY5XmO7rQ601TkvBWPsa84oC2b6eu
         p+Tzbh2GtFznXoN5A6m0Iq5bVVwmGvY5CawD4ilbUUJZ4RJlbSaCm5HM6FtJJ1JVGDOn
         QOdQ==
X-Gm-Message-State: AOAM532uTqSfPf+fSpU/MO+WA1e4WgC7qckMbff8ETqQTcwWqrtKuuk7
        P9SbzEAL4gqxellKfYJIk8keoQ==
X-Google-Smtp-Source: ABdhPJwlmW7vGA7F35Qq2Q5sLfG8j8oX9gh8cu7t5xIIBUwq2c8dbi4mWYe2T3PZI6TIj0A1aEBP+Q==
X-Received: by 2002:a05:6808:142:b0:2ec:aa67:e479 with SMTP id h2-20020a056808014200b002ecaa67e479mr896099oie.282.1647024436821;
        Fri, 11 Mar 2022 10:47:16 -0800 (PST)
Received: from builder.lan ([2600:1700:a0:3dc8:3697:f6ff:fe85:aac9])
        by smtp.gmail.com with ESMTPSA id 60-20020a9d0f42000000b005ad59a0fe01sm4001435ott.35.2022.03.11.10.47.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Mar 2022 10:47:16 -0800 (PST)
Date:   Fri, 11 Mar 2022 12:47:14 -0600
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
Cc:     mathieu.poirier@linaro.org, arnaud.pouliquen@foss.st.com,
        linux-remoteproc@vger.kernel.org, linux-kernel@vger.kernel.org,
        peng.fan@nxp.com
Subject: Re: [PATCH V2 2/2] remoteproc: support attach recovery after rproc
 crash
Message-ID: <YiuZMpTZ2eGebAxz@builder.lan>
References: <20220308064821.2154-1-peng.fan@oss.nxp.com>
 <20220308064821.2154-2-peng.fan@oss.nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220308064821.2154-2-peng.fan@oss.nxp.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue 08 Mar 00:48 CST 2022, Peng Fan (OSS) wrote:

> From: Peng Fan <peng.fan@nxp.com>
> 
> Current logic only support main processor to stop/start the remote
> processor after rproc crash. However to SoC, such as i.MX8QM/QXP, the
> remote processor could do attach recovery after crash and trigger watchdog

Does it really do something called "attach recovery and trigger watchdog
reboot"? Doesn't it just reboot itself and Linux needs to detach and
reattach to get something (what?) reset?

> reboot. It does not need main processor to load image, or stop/start M4
> core.
> 
> Introduce two functions: rproc_attach_recovery, rproc_firmware_recovery
> for the two cases. Firmware recovery is as before, let main processor to
> help recovery, while attach recovery is recover itself withou help.
> To attach recovery, we only do detach and attach.
> 
> Signed-off-by: Peng Fan <peng.fan@nxp.com>
> ---
> 
> V2:
>  use rproc_has_feature in patch 1/2
> 
>  drivers/remoteproc/remoteproc_core.c | 67 ++++++++++++++++++++--------
>  1 file changed, 48 insertions(+), 19 deletions(-)
> 
> diff --git a/drivers/remoteproc/remoteproc_core.c b/drivers/remoteproc/remoteproc_core.c
> index 69f51acf235e..366fad475898 100644
> --- a/drivers/remoteproc/remoteproc_core.c
> +++ b/drivers/remoteproc/remoteproc_core.c
> @@ -1887,6 +1887,50 @@ static int __rproc_detach(struct rproc *rproc)
>  	return 0;
>  }
>  
> +static int rproc_attach_recovery(struct rproc *rproc)
> +{
> +	int ret;
> +
> +	mutex_unlock(&rproc->lock);
> +	ret = rproc_detach(rproc);
> +	mutex_lock(&rproc->lock);
> +	if (ret)
> +		return ret;
> +
> +	if (atomic_inc_return(&rproc->power) > 1)

In the stop/coredump/start path the code _will_ attempt to recover the
remote processor. With rproc_detach() and rproc_attach() fiddling with
the rproc->power refcount this might do something, or it might not do
something. And with the mutex_unlock() it's likely that you're opening
of up for various race conditions inbetween.


PS. Does anyone actually use this refcount, or are we just all holding
our breath for it never going beyond 1?

Regards,
Bjorn

> +		return 0;
> +
> +	return rproc_attach(rproc);
> +}
> +
> +static int rproc_firmware_recovery(struct rproc *rproc)
> +{
> +	const struct firmware *firmware_p;
> +	struct device *dev = &rproc->dev;
> +	int ret;
> +
> +	ret = rproc_stop(rproc, true);
> +	if (ret)
> +		return ret;
> +
> +	/* generate coredump */
> +	rproc->ops->coredump(rproc);
> +
> +	/* load firmware */
> +	ret = request_firmware(&firmware_p, rproc->firmware, dev);
> +	if (ret < 0) {
> +		dev_err(dev, "request_firmware failed: %d\n", ret);
> +		return ret;
> +	}
> +
> +	/* boot the remote processor up again */
> +	ret = rproc_start(rproc, firmware_p);
> +
> +	release_firmware(firmware_p);
> +
> +	return ret;
> +}
> +
>  /**
>   * rproc_trigger_recovery() - recover a remoteproc
>   * @rproc: the remote processor
> @@ -1901,7 +1945,6 @@ static int __rproc_detach(struct rproc *rproc)
>   */
>  int rproc_trigger_recovery(struct rproc *rproc)
>  {
> -	const struct firmware *firmware_p;
>  	struct device *dev = &rproc->dev;
>  	int ret;
>  
> @@ -1915,24 +1958,10 @@ int rproc_trigger_recovery(struct rproc *rproc)
>  
>  	dev_err(dev, "recovering %s\n", rproc->name);
>  
> -	ret = rproc_stop(rproc, true);
> -	if (ret)
> -		goto unlock_mutex;
> -
> -	/* generate coredump */
> -	rproc->ops->coredump(rproc);
> -
> -	/* load firmware */
> -	ret = request_firmware(&firmware_p, rproc->firmware, dev);
> -	if (ret < 0) {
> -		dev_err(dev, "request_firmware failed: %d\n", ret);
> -		goto unlock_mutex;
> -	}
> -
> -	/* boot the remote processor up again */
> -	ret = rproc_start(rproc, firmware_p);
> -
> -	release_firmware(firmware_p);
> +	if (rproc_has_feature(rproc, RPROC_FEAT_ATTACH_RECOVERY))
> +		ret = rproc_attach_recovery(rproc);
> +	else
> +		ret = rproc_firmware_recovery(rproc);
>  
>  unlock_mutex:
>  	mutex_unlock(&rproc->lock);
> -- 
> 2.30.0
> 
