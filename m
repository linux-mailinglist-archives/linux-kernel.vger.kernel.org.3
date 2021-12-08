Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 19E0346D99D
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Dec 2021 18:27:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237801AbhLHRan (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Dec 2021 12:30:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55294 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229531AbhLHRam (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Dec 2021 12:30:42 -0500
Received: from mail-pl1-x62d.google.com (mail-pl1-x62d.google.com [IPv6:2607:f8b0:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF44CC0617A1
        for <linux-kernel@vger.kernel.org>; Wed,  8 Dec 2021 09:27:10 -0800 (PST)
Received: by mail-pl1-x62d.google.com with SMTP id n8so1980595plf.4
        for <linux-kernel@vger.kernel.org>; Wed, 08 Dec 2021 09:27:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=m8VpMd4QQt4Wgj7pyIRFiqXG6HSsK0frykwiCUZYPoE=;
        b=JaLaINinRsMmtnSF2KBDAcNmbP2oYmHFn0f7RfloS4CbaAXYj18vgZ2O/+lQ8QKj7y
         76dFhKZKkg15t25eSZu0aobxxt4lcXy2Ad29GMxTO+h4JkQYzzOL+7Zxb4xx2Fi0d0iE
         YnqSm7MFlb+tZLEjG4CrkvqAeZxWvjWLKUFXyBfQx85Dqu75oO/6VZVAyVoJBIswK90E
         LXP/ttWqRihx82SqtI3BqYGfmePYWAUE0f0X/tU5Li6Jqbvu8CplYhmoZL4NMOTPjC0d
         x+0YnExbCw+36g1KFi9xXRQqr8xVwUR2HSzPtz/K/3eUWvMorfhCbnhvc6sw3599MAyt
         XfoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=m8VpMd4QQt4Wgj7pyIRFiqXG6HSsK0frykwiCUZYPoE=;
        b=HXV+/627p0+3RRrnumoAhOS320+/ELhh6Jyk/VNgesUWzU/Z2MeGtj6Y3ecFtZNTaV
         DH6TsocgWH56fm23wrqxThEvBzIBYSwli8lpTkhUkGD4RPBXPHypcuoNFUVnOboFlSD+
         K8JXFNSFUqUP0wEB2BV/pvoXLADXK3amljWYxqC1+P7PxWBiBL3S66rU/DxKyLUdTVR1
         de+am6wIeZh4S3Dnmwhp4IOVaLRhRy7xRRy66iuEAhblmZkY41chwQPKBUNVIkJ3cujV
         xu0BziKt4uWt96MK4aDNJgr+hhM7zu+wTSfZxv9BGftRHDI2MdMSzuqD1zdhzCFpmpaM
         fUfA==
X-Gm-Message-State: AOAM532J759XVOjS7J2gd3QX/AZgJvgk2teySOMe4c8+tJcluN7QFmnJ
        28uL46daQENXVjK6TurTQWF57w==
X-Google-Smtp-Source: ABdhPJyaN+OyXY6UATU6r9jVTHsuum3aXZi5+UaSOv8+1kBsGUDZzxcsazbrHVbedPScGMFsPHBz8w==
X-Received: by 2002:a17:903:285:b0:142:21ba:2191 with SMTP id j5-20020a170903028500b0014221ba2191mr60809773plr.28.1638984430273;
        Wed, 08 Dec 2021 09:27:10 -0800 (PST)
Received: from p14s (S0106889e681aac74.cg.shawcable.net. [68.147.0.187])
        by smtp.gmail.com with ESMTPSA id on5sm3714725pjb.23.2021.12.08.09.27.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Dec 2021 09:27:08 -0800 (PST)
Date:   Wed, 8 Dec 2021 10:27:06 -0700
From:   Mathieu Poirier <mathieu.poirier@linaro.org>
To:     Arnaud Pouliquen <arnaud.pouliquen@foss.st.com>
Cc:     Bjorn Andersson <bjorn.andersson@linaro.org>,
        linux-remoteproc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com
Subject: Re: [PATCH] rpmsg: core: Clean up resources on announce_create
 failure.
Message-ID: <20211208172706.GA1138949@p14s>
References: <20211206190758.10004-1-arnaud.pouliquen@foss.st.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211206190758.10004-1-arnaud.pouliquen@foss.st.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 06, 2021 at 08:07:58PM +0100, Arnaud Pouliquen wrote:
> During the rpmsg_dev_probe, if rpdev->ops->announce_create returns an
> error, the rpmsg device and default endpoint should be freed before
> exiting the function.
> 
> Fixes: 5e619b48677c ("rpmsg: Split rpmsg core and virtio backend")
> Suggested-by: Bjorn Andersson <bjorn.andersson@linaro.org>
> Signed-off-by: Arnaud Pouliquen <arnaud.pouliquen@foss.st.com>
> ---
>  drivers/rpmsg/rpmsg_core.c | 20 ++++++++++++++++----
>  1 file changed, 16 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/rpmsg/rpmsg_core.c b/drivers/rpmsg/rpmsg_core.c
> index 27aad6baf7c5..12d7b7c6e5f9 100644
> --- a/drivers/rpmsg/rpmsg_core.c
> +++ b/drivers/rpmsg/rpmsg_core.c
> @@ -612,13 +612,25 @@ static int rpmsg_dev_probe(struct device *dev)
>  	err = rpdrv->probe(rpdev);
>  	if (err) {
>  		dev_err(dev, "%s: failed: %d\n", __func__, err);
> -		if (ept)
> -			rpmsg_destroy_ept(ept);
> -		goto out;
> +		goto destroy_ept;
>  	}
>  
> -	if (ept && rpdev->ops->announce_create)
> +	if (ept && rpdev->ops->announce_create) {
>  		err = rpdev->ops->announce_create(rpdev);
> +		if (err) {
> +			dev_err(dev, "failed to announce creation\n");
> +			goto remove_rpdev;
> +		}
> +	}
> +
> +	return 0;
> +
> +remove_rpdev:
> +	if (rpdrv->remove)
> +		rpdrv->remove(rpdev);
> +destroy_ept:
> +	if (ept)
> +		rpmsg_destroy_ept(ept);
>  out:
>  	return err;

Applied.

Thanks,
Mathieu

>  }
> -- 
> 2.17.1
> 
