Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A91B54869B2
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jan 2022 19:23:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242685AbiAFSXD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Jan 2022 13:23:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53958 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240698AbiAFSXC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Jan 2022 13:23:02 -0500
Received: from mail-pg1-x52a.google.com (mail-pg1-x52a.google.com [IPv6:2607:f8b0:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CAD48C061245
        for <linux-kernel@vger.kernel.org>; Thu,  6 Jan 2022 10:23:01 -0800 (PST)
Received: by mail-pg1-x52a.google.com with SMTP id 8so3289581pgc.10
        for <linux-kernel@vger.kernel.org>; Thu, 06 Jan 2022 10:23:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=I6+gV85PzROEGlYJM3N+KOto4KJj2e4PqdsLK48TsUs=;
        b=qvHLaU3I3YHDRWNvqsGcro4TTgHFq2pBWDkhh+5jgB4eOqgbpj5ZCHLIQ0V7nJil/u
         BD5adDExOHzqInisF7KA4q8Tz7Cx5KPp3CZ1a5IgJm1Gon01ol41Ls1ekUgfhNeH4Q6g
         AcDFmuyhPhazBpQv/9E3VnzrPp9DhAmW6LGIL+dXfICMpOLUYv9Sleqyc5fvTo8cJfql
         Qo5HXw15lB60EWDFs6KPA4Yk2B7keLcBFBd+rUzQOEaznukkXCTIcByhnz1pOXswuD44
         JSXRCJwuqN9ISpUcHUY2LcMe9riJaB+pCbsAcUpi33/HnQIJMojMK60TS1knUVuChIwL
         Mxhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=I6+gV85PzROEGlYJM3N+KOto4KJj2e4PqdsLK48TsUs=;
        b=ijC4Qm3CCFiQiCC47/rt4TRPxPFMA5SblznLmCZyTPAHsMblyPGfhiBILna7ITwHbf
         BOWQABy46GaBt6rbmSLWB95atD56G86N0pvqygNNnrWvgo52dj65dPA0FxIJPKu2rTBW
         zbwlngMzWHDW9G+FD3ILFkiqqsZZZVHtNEObejdsXw/Sbncx5PDxUkmDPsQsI7pPidUs
         TY4ot8MfaDnd7k+3EE7NDfzWBfJ6SZPHmG48UsT8ThiSS1/bsIDe0CIW9q8jOCI1+1Yd
         eUAlp50PPoVZC4eBPEYBsHXs/XWE4L9l9Nw5KXqI6v8ezgDw3aeemwWdaffZDDslyhJg
         58xw==
X-Gm-Message-State: AOAM530aj86jgSOuK1Gn0ZcxFdh5rMON/uUjJDuanVAWS0Wja3SrHihl
        XFyYV4sK5iZGGqrjgGp9ktPObPIKr7i5vg==
X-Google-Smtp-Source: ABdhPJweRsimwQSAjoYAJsBtwWD4QinEfZXmqu0x7zDDpGDGjuPdd9wgT90Qo4sNJ3RXACOsdEu6vQ==
X-Received: by 2002:a05:6a00:1509:b0:4ba:f004:e3af with SMTP id q9-20020a056a00150900b004baf004e3afmr61701114pfu.32.1641493381292;
        Thu, 06 Jan 2022 10:23:01 -0800 (PST)
Received: from p14s (S0106889e681aac74.cg.shawcable.net. [68.147.0.187])
        by smtp.gmail.com with ESMTPSA id z23sm3173944pfr.189.2022.01.06.10.22.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Jan 2022 10:23:00 -0800 (PST)
Date:   Thu, 6 Jan 2022 11:22:58 -0700
From:   Mathieu Poirier <mathieu.poirier@linaro.org>
To:     Arnaud Pouliquen <arnaud.pouliquen@foss.st.com>
Cc:     Bjorn Andersson <bjorn.andersson@linaro.org>,
        linux-remoteproc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com
Subject: Re: [RFC PATCH v2 5/6] remoteproc: virtio: Add helper to create
 platform device
Message-ID: <20220106182258.GA642186@p14s>
References: <20211222082349.30378-1-arnaud.pouliquen@foss.st.com>
 <20211222082349.30378-6-arnaud.pouliquen@foss.st.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211222082349.30378-6-arnaud.pouliquen@foss.st.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Arnaud,

On Wed, Dec 22, 2021 at 09:23:48AM +0100, Arnaud Pouliquen wrote:
> Add capability to create platform device for the rproc virtio.
> This is a step to move forward the management of the rproc virtio
> as an independent device.
> 
> Signed-off-by: Arnaud Pouliquen <arnaud.pouliquen@foss.st.com>
> ---
>  drivers/remoteproc/remoteproc_internal.h |  3 ++
>  drivers/remoteproc/remoteproc_virtio.c   | 36 ++++++++++++++++++++++++
>  2 files changed, 39 insertions(+)
> 
> diff --git a/drivers/remoteproc/remoteproc_internal.h b/drivers/remoteproc/remoteproc_internal.h
> index 6f511c50a15d..3007d29a26e1 100644
> --- a/drivers/remoteproc/remoteproc_internal.h
> +++ b/drivers/remoteproc/remoteproc_internal.h
> @@ -37,6 +37,9 @@ int rproc_of_parse_firmware(struct device *dev, int index,
>  
>  /* from remoteproc_virtio.c */
>  int rproc_rvdev_add_device(struct rproc_vdev *rvdev);
> +struct platform_device *
> +rproc_virtio_register_device(struct rproc *rproc, struct rproc_vdev_pdata *vdev_data);
> +void rproc_virtio_unregister_device(struct rproc_vdev *rvdev);
>  irqreturn_t rproc_vq_interrupt(struct rproc *rproc, int vq_id);
>  void rproc_vdev_release(struct kref *ref);
>  
> diff --git a/drivers/remoteproc/remoteproc_virtio.c b/drivers/remoteproc/remoteproc_virtio.c
> index 5f8005caeb6e..5eef679cc520 100644
> --- a/drivers/remoteproc/remoteproc_virtio.c
> +++ b/drivers/remoteproc/remoteproc_virtio.c
> @@ -578,6 +578,42 @@ void rproc_vdev_release(struct kref *ref)
>  	rproc_rvdev_remove_device(rvdev);
>  }
>  
> +/**
> + * rproc_virtio_register_device() - register a remoteproc virtio device
> + * @rproc: rproc handle to add the remoteproc virtio device to
> + * @vdev_data: platform device data
> + *
> + * Return: 0 on success, and an appropriate error value otherwise
> + */
> +struct platform_device *
> +rproc_virtio_register_device(struct rproc *rproc, struct rproc_vdev_pdata *vdev_data)
> +{
> +	struct device *dev = &rproc->dev;
> +	struct platform_device *pdev;
> +
> +	pdev = platform_device_register_data(dev, "rproc-virtio", vdev_data->index, vdev_data,
> +					     sizeof(*vdev_data));
> +	if (PTR_ERR_OR_ZERO(pdev)) {

Can you expand on the reason to use PTR_ERR_OR_ZERO() rather than IS_ERR()?
Looking at the documentation for platform_device_register_data(), it should not
return 0...

> +		dev_err(rproc->dev.parent,
> +			"failed to create rproc-virtio device\n");
> +	}
> +
> +	return  pdev;
> +}
> +EXPORT_SYMBOL(rproc_virtio_register_device);
> +
> +/**
> + * rproc_virtio_unregister_device() - unregister a remoteproc virtio device
> + * @rvdev: remote proc virtio handle to unregister
> + *
> + */
> +void rproc_virtio_unregister_device(struct rproc_vdev *rvdev)
> +{
> +	if (rvdev->pdev)
> +		platform_device_unregister(rvdev->pdev);
> +}
> +EXPORT_SYMBOL(rproc_virtio_unregister_device);
> +
>  static int rproc_virtio_probe(struct platform_device *pdev)
>  {
>  	struct device *dev = &pdev->dev;
> -- 
> 2.17.1
> 
