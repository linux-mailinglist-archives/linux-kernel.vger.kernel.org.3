Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 07306489F0C
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jan 2022 19:19:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239037AbiAJSSv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Jan 2022 13:18:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58972 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239025AbiAJSSu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Jan 2022 13:18:50 -0500
Received: from mail-oi1-x22f.google.com (mail-oi1-x22f.google.com [IPv6:2607:f8b0:4864:20::22f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 70C99C061751
        for <linux-kernel@vger.kernel.org>; Mon, 10 Jan 2022 10:18:50 -0800 (PST)
Received: by mail-oi1-x22f.google.com with SMTP id w200so4509457oiw.3
        for <linux-kernel@vger.kernel.org>; Mon, 10 Jan 2022 10:18:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=yeS6b6rE7TTabMlDBEHORbc2GRl2X5reLCMeMToRChE=;
        b=gfnXPEext3G6JAXMA4bPcpKkGq6DIMoHPYnHoeL33yP36Y4eFVXArQ2+Ud7h7isQBU
         PCWeRMazBka6QoeDatqG9QS7dbkEy1tHuXPptb2sJYBWDSGJSKfWHWrRF5P6iC5CatnR
         CacEEofLduBiFi3dYTybEpXoxHVcFs+uwz7aL8ltlcY+Z/B8+jazRl4e9n5Fbr7tcM1h
         lj25QYnuAt9NT6qIz+h+BPEi3Q8Eoj0mQYgFkuUwneq+SHRfqCCw7g09HtPOGw2rfqHG
         R6XxSrxxpHFAVop/RvO/PxyKJi+Duob/j/F9NYKCjRNLduQhmeWO8i33e6X5N13NmT/U
         nGuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=yeS6b6rE7TTabMlDBEHORbc2GRl2X5reLCMeMToRChE=;
        b=HGfTRiGMsUX8ecAYVIqJGOPAWu0B6TahQqiD6PVzu0VcpDvoeVohywLQq8Tz2W/vP4
         nJglNmZMlW0sm2SR7S3SCVyd6vCCdHiS6QwlE+BUhzzzoA5hMrfHq36/Y25ju9VoTqrC
         iDrzzvXN6bLTqZRNhdnj0OwyCWG4sta6lrfvMJs78xeTYsNK8Rr2FAZrVMMYdECl8p3V
         nqqSzRdNaFtAt4ppqsoAzTallA9XnjSQvGL5/de7t5DvsZKhxag+IxPE/Y606mwjdZw7
         6uSR+LVmWHdIxJuC9UUJkwiOEj4z9uqsAUl9lhSqHBFkiJOi919EQ6vWrW/PK4hYs8cE
         syNw==
X-Gm-Message-State: AOAM530iTxN4/NglzFq3WqNRqsVp0yVfUZ3uBFXH1jcG0hkO2J4gDHA+
        hQK6eQSFFiM+3/sFGQFv3Qwv1w==
X-Google-Smtp-Source: ABdhPJy6ncjVcjib8+V31cbxf1kwhYxdJQhjtDUUPjqYLuf4nR7+7iwJK8EW2d1lCo/29cORQKF8IA==
X-Received: by 2002:a05:6808:1119:: with SMTP id e25mr527068oih.30.1641838729792;
        Mon, 10 Jan 2022 10:18:49 -0800 (PST)
Received: from ripper (104-57-184-186.lightspeed.austtx.sbcglobal.net. [104.57.184.186])
        by smtp.gmail.com with ESMTPSA id t66sm1269562oie.39.2022.01.10.10.18.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Jan 2022 10:18:49 -0800 (PST)
Date:   Mon, 10 Jan 2022 10:19:32 -0800
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Matthias Kaehlcke <mka@chromium.org>
Cc:     Andy Gross <agross@kernel.org>, Ohad Ben-Cohen <ohad@wizery.com>,
        linux-kernel@vger.kernel.org, Sibi Sankar <sibis@codeaurora.org>,
        Sujit Kautkar <sujitka@chromium.org>,
        Stephen Boyd <swboyd@chromium.org>,
        linux-remoteproc@vger.kernel.org,
        Mathieu Poirier <mathieu.poirier@linaro.org>
Subject: Re: [PATCH v5 2/2] rpmsg: char: Fix race between the release of
 rpmsg_eptdev and cdev
Message-ID: <Ydx4tAHSfVyz2yAX@ripper>
References: <20220110091228.v5.1.Iaac908f3e3149a89190ce006ba166e2d3fd247a3@changeid>
 <20220110091228.v5.2.Idde68b05b88d4a2e6e54766c653f3a6d9e419ce6@changeid>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220110091228.v5.2.Idde68b05b88d4a2e6e54766c653f3a6d9e419ce6@changeid>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon 10 Jan 09:12 PST 2022, Matthias Kaehlcke wrote:

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

There's a cdev_del() in rpmsg_eptdev_release_device() that I think needs
to go as well, in line with patch 1.

Regards,
Bjorn

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
>  free_ept_ida:
> -- 
> 2.34.1.575.g55b058a8bb-goog
> 
