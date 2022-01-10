Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A0581489ED1
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jan 2022 19:09:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238782AbiAJSJv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Jan 2022 13:09:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56852 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238765AbiAJSJu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Jan 2022 13:09:50 -0500
Received: from mail-pl1-x62a.google.com (mail-pl1-x62a.google.com [IPv6:2607:f8b0:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D483C06173F
        for <linux-kernel@vger.kernel.org>; Mon, 10 Jan 2022 10:09:50 -0800 (PST)
Received: by mail-pl1-x62a.google.com with SMTP id x15so13137149plg.1
        for <linux-kernel@vger.kernel.org>; Mon, 10 Jan 2022 10:09:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=0BeqSS/jUFd+XACdCqBV33u9hZMZkRJ0bexug2XuqLo=;
        b=ZU/VzWQIobJlaTVdLCUDmf2fmlct7dMn2iLkmN8n0kfglONC4lpXoTJtNFt4mioxMz
         ayGcreaivY5KYg/it8c4Y+c3qJiqFJZfDZgg/ltR58bgnXHF32DHa56RdPkMBijrpxN9
         Idq7ZzIoUmY6SL44C3KzrDXYfw+fNPZ3T7LzmLp9UrJXQsbFl5dHHHpOOH20jeKkgikl
         G1ZtNMSojAZyDdR3SdmMc1MV45ecPAdQgrzdsGCHlDVQDw4XTK1VJozVVzxL2Z7Gt9oB
         /LIuNc3+SXbQte3XAjyAEXrhCVoUow6iXyhmJiXbk8KciwD/t5Xk8lmw3Dtqwb1kh2Ds
         vwCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=0BeqSS/jUFd+XACdCqBV33u9hZMZkRJ0bexug2XuqLo=;
        b=FbYtwsh3puR5QlZ2Tukl21MKXaJQAZkHE00c74jr0cVzw/M8YxncR88o/QfJNKQkUp
         oEP2LMotw1PepMGV6IfbEC7cEDgCQHD47RE0aaCxZDquCqyBuGnXu97lVaCPrHRysjDm
         EVGmtujPr9FQwS2rAopH8qw60yEU1D7TaLsUxJokcsqptWyGqowUkk8oLemPdLP+glzS
         kyBM/QJcqeVQFEta/3Egybg8/rFbnkYMoVe75MVtlbB9IVKX5TM4l907uFWbOA9mijLF
         /P2JGjAcCPTf8D4jw73XX6dNBSlk8uNyS709ydioxRj05ZdjxdxXmMR5ZLutR181pyCo
         Lx4w==
X-Gm-Message-State: AOAM531mfT6Y2+KsPOYgAtCvESe5qAfE5EtaCVx9aLcmxhIk5YT/tKZv
        n+1rnKv/52ZOG3FpjTYpqoZK3g==
X-Google-Smtp-Source: ABdhPJwyuMnZ1QBnDY5vVi4BhOM1qpgzSPstzc/FkkrwrIIeW2iNcwD6TzeBcKwazlksG93VFaXByQ==
X-Received: by 2002:a17:902:8e81:b0:149:8f60:a52a with SMTP id bg1-20020a1709028e8100b001498f60a52amr525408plb.145.1641838189668;
        Mon, 10 Jan 2022 10:09:49 -0800 (PST)
Received: from p14s (S0106889e681aac74.cg.shawcable.net. [68.147.0.187])
        by smtp.gmail.com with ESMTPSA id e20sm7628429pfv.219.2022.01.10.10.09.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Jan 2022 10:09:48 -0800 (PST)
Date:   Mon, 10 Jan 2022 11:09:46 -0700
From:   Mathieu Poirier <mathieu.poirier@linaro.org>
To:     Matthias Kaehlcke <mka@chromium.org>
Cc:     Andy Gross <agross@kernel.org>, Ohad Ben-Cohen <ohad@wizery.com>,
        linux-kernel@vger.kernel.org, Sibi Sankar <sibis@codeaurora.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Sujit Kautkar <sujitka@chromium.org>,
        Stephen Boyd <swboyd@chromium.org>,
        linux-remoteproc@vger.kernel.org
Subject: Re: [PATCH v5 2/2] rpmsg: char: Fix race between the release of
 rpmsg_eptdev and cdev
Message-ID: <20220110180946.GA771134@p14s>
References: <20220110091228.v5.1.Iaac908f3e3149a89190ce006ba166e2d3fd247a3@changeid>
 <20220110091228.v5.2.Idde68b05b88d4a2e6e54766c653f3a6d9e419ce6@changeid>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220110091228.v5.2.Idde68b05b88d4a2e6e54766c653f3a6d9e419ce6@changeid>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 10, 2022 at 09:12:32AM -0800, Matthias Kaehlcke wrote:
> struct rpmsg_eptdev contains a struct cdev. The current code frees
> the rpmsg_eptdev struct in rpmsg_eptdev_destroy(), but the cdev is
> a managed object, therefore its release is not predictable and the
> rpmsg_eptdev could be freed before the cdev is entirely released.
> 
> The cdev_device_add/del() API was created to address this issue
> (see commit 233ed09d7fda), use it instead of cdev add/del().
> 
> Fixes: c0cdc19f84a4 ("rpmsg: Driver for user space endpoint interface")
> Signed-off-by: Matthias Kaehlcke <mka@chromium.org>
> ---
> 
> Changes in v5:
> - patch added to the series
> 
>  drivers/rpmsg/rpmsg_char.c | 10 ++--------
>  1 file changed, 2 insertions(+), 8 deletions(-)
> 
> diff --git a/drivers/rpmsg/rpmsg_char.c b/drivers/rpmsg/rpmsg_char.c
> index ba85f5d11960..5bc1e6017587 100644
> --- a/drivers/rpmsg/rpmsg_char.c
> +++ b/drivers/rpmsg/rpmsg_char.c
> @@ -92,7 +92,7 @@ static int rpmsg_eptdev_destroy(struct device *dev, void *data)
>  	/* wake up any blocked readers */
>  	wake_up_interruptible(&eptdev->readq);
>  
> -	device_del(&eptdev->dev);
> +	cdev_device_del(&eptdev->cdev, &eptdev->dev);
>  	put_device(&eptdev->dev);
>  
>  	return 0;
> @@ -380,19 +380,13 @@ static int rpmsg_eptdev_create(struct rpmsg_ctrldev *ctrldev,
>  	dev->id = ret;
>  	dev_set_name(dev, "rpmsg%d", ret);
>  
> -	ret = cdev_add(&eptdev->cdev, dev->devt, 1);
> +	ret = cdev_device_add(&eptdev->cdev, &eptdev->dev);
>  	if (ret)
>  		goto free_ept_ida;
>  
>  	/* We can now rely on the release function for cleanup */
>  	dev->release = rpmsg_eptdev_release_device;
>  
> -	ret = device_add(dev);
> -	if (ret) {
> -		dev_err(dev, "device_add failed: %d\n", ret);
> -		put_device(dev);
> -	}
> -
>  	return ret;
>

Reviewed-by: Mathieu Poirier <mathieu.poirier@linaro.org>

>  free_ept_ida:
> -- 
> 2.34.1.575.g55b058a8bb-goog
> 
