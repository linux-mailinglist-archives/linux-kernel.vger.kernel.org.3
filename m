Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B1B58555252
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Jun 2022 19:25:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376848AbiFVRZh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Jun 2022 13:25:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33966 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1376400AbiFVRZf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Jun 2022 13:25:35 -0400
Received: from mail-pf1-x431.google.com (mail-pf1-x431.google.com [IPv6:2607:f8b0:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 152D025C51
        for <linux-kernel@vger.kernel.org>; Wed, 22 Jun 2022 10:25:34 -0700 (PDT)
Received: by mail-pf1-x431.google.com with SMTP id s37so16697022pfg.11
        for <linux-kernel@vger.kernel.org>; Wed, 22 Jun 2022 10:25:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=F1h7Ij/RTr4Zg7zLZzpgB2ElBs7s3zrp84VdRnTR+Xc=;
        b=laefo6G9MLDmi0wKtkaq0i7nGZ1aSPyQWj2RnlF/s1kuk2xAk3KSr6lXYrJVRXzD9Y
         r6LIV49fQ9Ya7irW0bTDRDbWuPauJImCAIsyH2G6DiJpdD5ccwJ4ygcetLgg68ZRRROR
         5Jl0BHaNSyrm4PkhMHPt/0yREML0hEExZypPwNmBdg4z28xhlFETMIbCXRmbtnp5fma9
         AKSsv2Z2GjfXQBXK2X1EMRvoUAqdgDk9On16yr16I5aNpNyp0FdpcyLwHHf3zODIUuFS
         p4CYF2tJFlHLkAnMFbKEv71zmir+GvJVdVaUfhORIsyjxIkuzEf/eLNuRLFQVMFCE4Z1
         2KNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=F1h7Ij/RTr4Zg7zLZzpgB2ElBs7s3zrp84VdRnTR+Xc=;
        b=BnYxFCI2SDkXR9SYKGNeFQt2ByE8nkBz+OKlD6jZCeejMHG0ChCiLL527C2Y6bE9f4
         kIoh137U6RYB4Itxlk1QdHKBUb1ChQbPyOewjhzPDwKbMPO0tXNJi3yqCKCkpkyrusDp
         8CemOM6tNVhgCPqBk5zoNrztbe9elWMOMIT4iAGtqwDdxyeuhia7rUuP7De4+aWnxe7T
         XUKd509QvT8RtIZmWkU/mPw+7FeftI2SWkUdmcrFOyBwz5NIe7aIb/Rf0qCqxygMJI2d
         ri8gtNxXhIzCwFkBkHfq8LWxUUHCSjFPTvSQ0oC3nxJOH0FbV3IbXBLTQoK2H08etPPF
         S5qA==
X-Gm-Message-State: AJIora+jKE+4P1b7zIq9gg6J22mIAdc2krNraknd9ecMMy9ZGIKxM0yJ
        M4GoETeLbqHjYCtN2jaQg4IOdA==
X-Google-Smtp-Source: AGRyM1vInwevu3tlVu6C5YUKTeIb1PSpcZfZEAyjD+A/y+J2jdqOYiiuX0FyQv9M7m4TkjDxkCSDvw==
X-Received: by 2002:a63:c63:0:b0:3fe:e14b:b5a0 with SMTP id 35-20020a630c63000000b003fee14bb5a0mr3848548pgm.428.1655918733500;
        Wed, 22 Jun 2022 10:25:33 -0700 (PDT)
Received: from p14s (S0106889e681aac74.cg.shawcable.net. [68.147.0.187])
        by smtp.gmail.com with ESMTPSA id x15-20020a63b34f000000b0040d027e1f0fsm3434521pgt.25.2022.06.22.10.25.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Jun 2022 10:25:32 -0700 (PDT)
Date:   Wed, 22 Jun 2022 11:25:29 -0600
From:   Mathieu Poirier <mathieu.poirier@linaro.org>
To:     "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
Cc:     bjorn.andersson@linaro.org, linux-remoteproc@vger.kernel.org,
        linux-kernel@vger.kernel.org, Peng Fan <peng.fan@nxp.com>
Subject: Re: [PATCH V5 2/2] remoteproc: support attach recovery after rproc
 crash
Message-ID: <20220622172529.GC1606016@p14s>
References: <20220615032048.465486-1-peng.fan@oss.nxp.com>
 <20220615032048.465486-3-peng.fan@oss.nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220615032048.465486-3-peng.fan@oss.nxp.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 15, 2022 at 11:20:48AM +0800, Peng Fan (OSS) wrote:
> From: Peng Fan <peng.fan@nxp.com>
> 
> Current logic only support main processor to stop/start the remote
> processor after rproc crash. However to SoC, such as i.MX8QM/QXP, the
> remote processor could do attach recovery after crash and trigger watchdog
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
>  drivers/remoteproc/remoteproc_core.c | 64 +++++++++++++++++++---------
>  1 file changed, 45 insertions(+), 19 deletions(-)
> 
> diff --git a/drivers/remoteproc/remoteproc_core.c b/drivers/remoteproc/remoteproc_core.c
> index 02a04ab34a23..1c1c90176aff 100644
> --- a/drivers/remoteproc/remoteproc_core.c
> +++ b/drivers/remoteproc/remoteproc_core.c
> @@ -1883,6 +1883,47 @@ static int __rproc_detach(struct rproc *rproc)
>  	return 0;
>  }
>  
> +static int rproc_attach_recovery(struct rproc *rproc)
> +{
> +	int ret;
> +
> +	mutex_unlock(&rproc->lock);
> +	ret = __rproc_detach(rproc);
> +	mutex_lock(&rproc->lock);
> +	if (ret)
> +		return ret;
> +
> +	return __rproc_attach(rproc);
> +}
> +
> +static int rproc_firmware_recovery(struct rproc *rproc)

s/rproc_firmware_recovery/rproc_boot_recovery

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
> @@ -1897,7 +1938,6 @@ static int __rproc_detach(struct rproc *rproc)
>   */
>  int rproc_trigger_recovery(struct rproc *rproc)
>  {
> -	const struct firmware *firmware_p;
>  	struct device *dev = &rproc->dev;
>  	int ret;
>  
> @@ -1911,24 +1951,10 @@ int rproc_trigger_recovery(struct rproc *rproc)
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
> +	if (rproc_has_feature(rproc, RPROC_FEAT_ATTACH_ON_RECOVERY))
> +		ret = rproc_attach_recovery(rproc);
> +	else
> +		ret = rproc_firmware_recovery(rproc);

This patch contains a serious flaw related to locking that should have been
obvious when it was put together.  Please go back and carefully review the code you are submitting.  

I will not consider another revision of this set until July 15th.

Thanks,
Mathieu

>  
>  unlock_mutex:
>  	mutex_unlock(&rproc->lock);
> -- 
> 2.25.1
> 
