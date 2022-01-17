Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 12D394911FC
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jan 2022 23:55:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243693AbiAQWz0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Jan 2022 17:55:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39898 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229842AbiAQWzY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jan 2022 17:55:24 -0500
Received: from mail-oi1-x230.google.com (mail-oi1-x230.google.com [IPv6:2607:f8b0:4864:20::230])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 24879C06161C
        for <linux-kernel@vger.kernel.org>; Mon, 17 Jan 2022 14:55:24 -0800 (PST)
Received: by mail-oi1-x230.google.com with SMTP id s127so25790102oig.2
        for <linux-kernel@vger.kernel.org>; Mon, 17 Jan 2022 14:55:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=JgHdHThslfW8cWYgVZ7DrTIIbA1uJdRWFcKirFlKvos=;
        b=MhsS8EUXaQkCE2tOPqkbsGLNOXTZAO7ApasVgwy+ZLjMTQjBRQiRCevhCsEQ5z2C3A
         JbDvrP3ZnTPkV9o+F+EZ+1UR9S3NirPjX+R1yryE5LszoaLRj3mDwhFk2nE5TNEJ+mj4
         rgs4ye7Lw1BKcgI/lesO+wW8DTEEw18UZIfB6rRiYvXHfPBJh0d0q5hDYci0KEd3nrMo
         ymaw8anHdpPEytqUGi5AsuqFD7MVJQg2grITha+UpLkPtDTRe3IZh0ozAPrwf74z6xJL
         i+NQoi23Cw6Kr6Pw8+n583FvCE5xTjE54YqA1b6zAq5a/IJqWrRKon2rvk/QjggCWPla
         BgGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=JgHdHThslfW8cWYgVZ7DrTIIbA1uJdRWFcKirFlKvos=;
        b=jeD5TIa3WOemqaL/YRpKU0n0IAg0dCvNnwNhHuHNVk335ogwVeMpoo3SFkjZQZ5y4R
         Cb21WNYy3ShEVoagdlHYDQBbgj/2EHL28jgMUF320ZKNVtXM9DmpJrDLh34rUX7aNg4E
         FQeRudjlEtJ90KGhjqHuB8OD31zdf83jhH/JGxJa9DHrVp2AIkOZcrspuYA2d4ccHIZm
         MYBNxMcqsjhlle43JUOC/fimkPNkqrPM0IVMLYYpd6KuknPkFtK6II9mvgtohsADLLdK
         FzHmpUHSl4rbvLjgyKdTDzWeBGb5RgipifIJtVWyUXcJKYX74GyymeyMzqnZiMAvUu5G
         fYpg==
X-Gm-Message-State: AOAM5339MfoXQ9TwRcNvORFevxlLkwDDSxQeVV57SU186P+7B6eEJXBT
        RMJ60w4p0FvrNv3Xj/eQwjdQ2Q==
X-Google-Smtp-Source: ABdhPJxRiubKKOWsfwr2r2Qn1nnjS9IzlDf478fuYhB8DEUNrxy2LBICJg0Ql7X+rAspt6g+C28LLg==
X-Received: by 2002:a05:6808:1148:: with SMTP id u8mr3297802oiu.19.1642460123552;
        Mon, 17 Jan 2022 14:55:23 -0800 (PST)
Received: from builder.lan (104-57-184-186.lightspeed.austtx.sbcglobal.net. [104.57.184.186])
        by smtp.gmail.com with ESMTPSA id k10sm7443332oil.36.2022.01.17.14.55.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Jan 2022 14:55:22 -0800 (PST)
Date:   Mon, 17 Jan 2022 16:55:21 -0600
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Arnaud Pouliquen <arnaud.pouliquen@foss.st.com>
Cc:     Mathieu Poirier <mathieu.poirier@linaro.org>,
        linux-remoteproc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com, julien.massot@iot.bzh
Subject: Re: [PATCH v8 03/13] rpmsg: Move the rpmsg control device from
 rpmsg_char to rpmsg_ctrl
Message-ID: <YeXz2SFqYr+eUvnw@builder.lan>
References: <20211207080843.21222-1-arnaud.pouliquen@foss.st.com>
 <20211207080843.21222-4-arnaud.pouliquen@foss.st.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211207080843.21222-4-arnaud.pouliquen@foss.st.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue 07 Dec 02:08 CST 2021, Arnaud Pouliquen wrote:
> diff --git a/drivers/rpmsg/rpmsg_char.c b/drivers/rpmsg/rpmsg_char.c
[..]
> -static void rpmsg_ctrldev_release_device(struct device *dev)
> -{
> -	struct rpmsg_ctrldev *ctrldev = dev_to_ctrldev(dev);
> -
> -	ida_simple_remove(&rpmsg_ctrl_ida, dev->id);
> -	ida_simple_remove(&rpmsg_minor_ida, MINOR(dev->devt));
> -	cdev_del(&ctrldev->cdev);
> -	kfree(ctrldev);
> -}
> -
> -static int rpmsg_chrdev_probe(struct rpmsg_device *rpdev)
> -{
> -	struct rpmsg_ctrldev *ctrldev;
> -	struct device *dev;
> -	int ret;
> -
> -	ctrldev = kzalloc(sizeof(*ctrldev), GFP_KERNEL);
> -	if (!ctrldev)
> -		return -ENOMEM;
> -
> -	ctrldev->rpdev = rpdev;
> -
> -	dev = &ctrldev->dev;
> -	device_initialize(dev);
> -	dev->parent = &rpdev->dev;
> -	dev->class = rpmsg_class;
> -
> -	cdev_init(&ctrldev->cdev, &rpmsg_ctrldev_fops);
> -	ctrldev->cdev.owner = THIS_MODULE;
> -
> -	ret = ida_simple_get(&rpmsg_minor_ida, 0, RPMSG_DEV_MAX, GFP_KERNEL);
> -	if (ret < 0)
> -		goto free_ctrldev;
> -	dev->devt = MKDEV(MAJOR(rpmsg_major), ret);
> -
> -	ret = ida_simple_get(&rpmsg_ctrl_ida, 0, 0, GFP_KERNEL);
> -	if (ret < 0)
> -		goto free_minor_ida;
> -	dev->id = ret;
> -	dev_set_name(&ctrldev->dev, "rpmsg_ctrl%d", ret);
> -
> -	ret = cdev_add(&ctrldev->cdev, dev->devt, 1);

This turns out to be incomplete and the cdev_del above is in the wrong
place. This, and the same for eptdev, is being corrected in:

https://lore.kernel.org/linux-remoteproc/164245960510.1698571.4998090450663669237.b4-ty@linaro.org/T/#t

Regards,
Bjorn
