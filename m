Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0BF77489FA8
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jan 2022 19:55:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242579AbiAJSzY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Jan 2022 13:55:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40248 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242539AbiAJSzW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Jan 2022 13:55:22 -0500
Received: from mail-ot1-x32c.google.com (mail-ot1-x32c.google.com [IPv6:2607:f8b0:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D5CF8C06173F
        for <linux-kernel@vger.kernel.org>; Mon, 10 Jan 2022 10:55:21 -0800 (PST)
Received: by mail-ot1-x32c.google.com with SMTP id o3-20020a9d4043000000b0058f31f4312fso16078411oti.1
        for <linux-kernel@vger.kernel.org>; Mon, 10 Jan 2022 10:55:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=0yATqEqAg801iBdwamF/+s3OhsWkArZgTpumgS6oyjM=;
        b=atNxkocqem5xGt1N5rnFWV7TgHucA7nXPxfH2oZNU4bf1nFU6c524/KODRG6Dvx1Ok
         kLNlRDlcc+Ta0XkTgKTnxz3wxAHPxhWUN2h3+ZTQqIpKlDv+zcqorICVn07Fbb/fTKsN
         Zohy6oM0UZsq2Vk7+js67kXHhiq+RSxBzkg6jgpl+KzoesMytXvQ/sTgdulrQbpNwdnK
         jIlSPG7DH5y9x08CWxSKTIPEklC6NsMpBR2/SoGJV8XVftquz9pdQB2/j6765Y/NDm5t
         KsgdgVVgREEtlH/aoYPwubqYqLgMI98+ECz1jwaghNcI+zjuSqpuAdYjTG4BBEqKZx3o
         hi0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=0yATqEqAg801iBdwamF/+s3OhsWkArZgTpumgS6oyjM=;
        b=7K+QkClMO11OuWgL8rokmyaj/7tsSDR3h+1k/v97BCAfvpH1HDty3lkxrh1A2vRdkl
         zGs3UXoYaaLoYJsQry+lf71/dPWs5hhHvkeWMlr9R8DFlllt/C3sQqwEvMkZcqgl2W10
         isgOlDyjespFBlNM/wB9w2nnK9GkQPi0eSJ8H9Lu9YlIIcWO5vPpLJR9KruHiKkACuHB
         E/uerYyzIhmfHiE7Tm0vRfepQ2eW5LJtU3MvIIPUPD8/pkYrz1kNplCQFk89ytYoWDiB
         RBMl4hmQ+8pMuTAYpwK7ea6ZPZhBqwxhu+8Rb4FKzEeQpCEZ55pSXhWppnyufaA0jumK
         nRSA==
X-Gm-Message-State: AOAM532ulF/tqHZ8Ai/+hFtkixhop5xha6DH54HDr6Wm/QBIkB17sfjf
        Y5S31wFWsB6JuY8FBiTcyx1lOg==
X-Google-Smtp-Source: ABdhPJy7Zig/orNr0jwi3IMD5Vm2pY1ZXhrR/Hnd1Io40o1AB5IryVbsJ57BwOQ1G3XDyNY2lyLeMw==
X-Received: by 2002:a9d:313:: with SMTP id 19mr936491otv.2.1641840921099;
        Mon, 10 Jan 2022 10:55:21 -0800 (PST)
Received: from ripper (104-57-184-186.lightspeed.austtx.sbcglobal.net. [104.57.184.186])
        by smtp.gmail.com with ESMTPSA id f7sm1609868oti.35.2022.01.10.10.55.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Jan 2022 10:55:20 -0800 (PST)
Date:   Mon, 10 Jan 2022 10:56:03 -0800
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Matthias Kaehlcke <mka@chromium.org>
Cc:     Andy Gross <agross@kernel.org>, Ohad Ben-Cohen <ohad@wizery.com>,
        Stephen Boyd <swboyd@chromium.org>,
        linux-kernel@vger.kernel.org, linux-remoteproc@vger.kernel.org,
        Sibi Sankar <sibis@codeaurora.org>,
        Sujit Kautkar <sujitka@chromium.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>
Subject: Re: [PATCH v6 2/2] rpmsg: char: Fix race between the release of
 rpmsg_eptdev and cdev
Message-ID: <YdyBQ2czzh0Aj3IO@ripper>
References: <20220110104706.v6.1.Iaac908f3e3149a89190ce006ba166e2d3fd247a3@changeid>
 <20220110104706.v6.2.Idde68b05b88d4a2e6e54766c653f3a6d9e419ce6@changeid>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220110104706.v6.2.Idde68b05b88d4a2e6e54766c653f3a6d9e419ce6@changeid>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon 10 Jan 10:47 PST 2022, Matthias Kaehlcke wrote:

> struct rpmsg_eptdev contains a struct cdev. The current code frees
> the rpmsg_eptdev struct in rpmsg_eptdev_destroy(), but the cdev is
> a managed object, therefore its release is not predictable and the
> rpmsg_eptdev could be freed before the cdev is entirely released.
> 
> The cdev_device_add/del() API was created to address this issue
> (see commit 233ed09d7fda), use it instead of cdev add/del().
> 
> Fixes: c0cdc19f84a4 ("rpmsg: Driver for user space endpoint interface")
> Suggested-by: Bjorn Andersson <bjorn.andersson@linaro.org>
> Signed-off-by: Matthias Kaehlcke <mka@chromium.org>
> Reviewed-by: Mathieu Poirier <mathieu.poirier@linaro.org>

Reviewed-by: Bjorn Andersson <bjorn.andersson@linaro.org>

Regards,
Bjorn

> ---
> 
> Changes in v6:
> - remove cdev_del() from rpmsg_eptdev_release_device()
> - added 'Reviewed-by' tag from Mathieu and 'Suggested-by' tag
> 
> Changes in v5:
> - patch added to the series
> 
>  drivers/rpmsg/rpmsg_char.c | 11 ++---------
>  1 file changed, 2 insertions(+), 9 deletions(-)
> 
> diff --git a/drivers/rpmsg/rpmsg_char.c b/drivers/rpmsg/rpmsg_char.c
> index ba85f5d11960..49dd5a200998 100644
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
> @@ -335,7 +335,6 @@ static void rpmsg_eptdev_release_device(struct device *dev)
>  
>  	ida_simple_remove(&rpmsg_ept_ida, dev->id);
>  	ida_simple_remove(&rpmsg_minor_ida, MINOR(eptdev->dev.devt));
> -	cdev_del(&eptdev->cdev);
>  	kfree(eptdev);
>  }
>  
> @@ -380,19 +379,13 @@ static int rpmsg_eptdev_create(struct rpmsg_ctrldev *ctrldev,
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
>  free_ept_ida:
> -- 
> 2.34.1.575.g55b058a8bb-goog
> 
