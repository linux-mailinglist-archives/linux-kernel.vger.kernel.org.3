Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6756A492DA0
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jan 2022 19:45:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347934AbiARSo6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Jan 2022 13:44:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60030 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232540AbiARSo5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Jan 2022 13:44:57 -0500
Received: from mail-pl1-x62a.google.com (mail-pl1-x62a.google.com [IPv6:2607:f8b0:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A864C061574
        for <linux-kernel@vger.kernel.org>; Tue, 18 Jan 2022 10:44:57 -0800 (PST)
Received: by mail-pl1-x62a.google.com with SMTP id d7so3849991plr.12
        for <linux-kernel@vger.kernel.org>; Tue, 18 Jan 2022 10:44:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=CFAGt0ERR1Sk6nuaQG2sLvBNcFGlpdl228B5ZY5KMow=;
        b=kZmt7JdvOF1OPX5p/UrhTGMxIsooM/o0xchNaDvgnWMOc7CNXok+0cSEDWJfj4czu4
         Lv4X8jfIxEssR+o5At+z7Klo3W3lHPKYEwbhDzDb2XeT5ClvrRy2W+Ypli8ZI+WksCmU
         Gp+gVRr/pwpeoXv/UtXFJviBVo8HxUeE7N3UsiV0RYFostNnx1PIVedak6NysECiCGBH
         TUZJ6It+e+r/iR5Jww1ALITHon3eMit82XIvewozx20hFUun67Da/+mx69FPwEhf+Z/n
         pWXS8pdWn5tNyfzDOAnFFb46m7cR/+scow6Y0PZQE9kqtw/uYw+4ULZewnhFTOJ214E9
         m+zg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=CFAGt0ERR1Sk6nuaQG2sLvBNcFGlpdl228B5ZY5KMow=;
        b=qh5AxcRDuOikFPDYTKZx686q5x0w/sSBKQwQQoPL6pCF1X2dN0gl1jN/fUVvqfZq3Q
         6EQFNX/Oh0KYDgKfZlFF4COQSt5FRLJfbIVzUWr6g0j7QalCJhuYWk7xsg4BkYxUFsiQ
         g7WCIqpcaUBgKuc+fXC0Ra6feQTHh5FU2BBKRMoQqMFuwCFexyPyto4/1MlkuCQIo33m
         N9HsQJTVSbEc978CoJnuORETwK6iwB5VY1pxH1a+XLhFAe01NZqt7qb24gbvcgA23Vk+
         +utqj+lOJ06dD0EHGRhwiPvf3I26q04OLCdXEF+5i8dfYfbgvEFxJlwNG30/v0p89dys
         Ywzw==
X-Gm-Message-State: AOAM532C59u1TZLCKFqnKz7lXRFKAUoKLJ9UodsbxVT7+q5GSODp1vat
        FeoJRNgFusNFlTXQ9Yk0PCYadE/K3wmZhQ==
X-Google-Smtp-Source: ABdhPJyrYs0lWDrmhcEKD5qUemt3E88iynSRMIa+6rd90dKiwB9AuRND3goyKzc3uoNLasFPdMmluQ==
X-Received: by 2002:a17:90b:4a45:: with SMTP id lb5mr23096488pjb.67.1642531496991;
        Tue, 18 Jan 2022 10:44:56 -0800 (PST)
Received: from p14s (S0106889e681aac74.cg.shawcable.net. [68.147.0.187])
        by smtp.gmail.com with ESMTPSA id i13sm15563936pgl.81.2022.01.18.10.44.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Jan 2022 10:44:55 -0800 (PST)
Date:   Tue, 18 Jan 2022 11:44:53 -0700
From:   Mathieu Poirier <mathieu.poirier@linaro.org>
To:     "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
Cc:     bjorn.andersson@linaro.org, shawnguo@kernel.org,
        s.hauer@pengutronix.de, kernel@pengutronix.de, festevam@gmail.com,
        linux-imx@nxp.com, linux-remoteproc@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Peng Fan <peng.fan@nxp.com>
Subject: Re: [PATCH 3/9] remoteproc: support self recovery after rproc crash
Message-ID: <20220118184453.GE1119324@p14s>
References: <20220111033333.403448-1-peng.fan@oss.nxp.com>
 <20220111033333.403448-6-peng.fan@oss.nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220111033333.403448-6-peng.fan@oss.nxp.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 11, 2022 at 11:33:27AM +0800, Peng Fan (OSS) wrote:
> From: Peng Fan <peng.fan@nxp.com>
> 
> Current logic only support main processor to stop/start the remote
> processor after rproc crash. However to SoC, such as i.MX8QM/QXP, the
> remote processor could do self recovery after crash and trigger watchdog
> reboot. It does not need main processor to load image, stop/start M4
> core.
> 
> This patch add a new flag to indicate whether the SoC has self recovery
> capability. And introduce two functions: rproc_self_recovery,
> rproc_assisted_recovery for the two cases. Assisted recovery is as
> before, let main processor to help recovery, while self recovery is
> recover itself withou help. To self recovery, we only do detach and
> attach.
> 
> Signed-off-by: Peng Fan <peng.fan@nxp.com>
> ---
>  drivers/remoteproc/remoteproc_core.c | 66 ++++++++++++++++++++--------
>  include/linux/remoteproc.h           |  2 +
>  2 files changed, 49 insertions(+), 19 deletions(-)
> 
> diff --git a/drivers/remoteproc/remoteproc_core.c b/drivers/remoteproc/remoteproc_core.c
> index 69f51acf235e..4bd5544dab8f 100644
> --- a/drivers/remoteproc/remoteproc_core.c
> +++ b/drivers/remoteproc/remoteproc_core.c
> @@ -1887,6 +1887,49 @@ static int __rproc_detach(struct rproc *rproc)
>  	return 0;
>  }
>  
> +static int rproc_self_recovery(struct rproc *rproc)
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
> +		return 0;
> +	return rproc_attach(rproc);
> +}
> +
> +static int rproc_assisted_recovery(struct rproc *rproc)
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
> @@ -1901,7 +1944,6 @@ static int __rproc_detach(struct rproc *rproc)
>   */
>  int rproc_trigger_recovery(struct rproc *rproc)
>  {
> -	const struct firmware *firmware_p;
>  	struct device *dev = &rproc->dev;
>  	int ret;
>  
> @@ -1915,24 +1957,10 @@ int rproc_trigger_recovery(struct rproc *rproc)
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
> +	if (rproc->self_recovery)
> +		ret = rproc_self_recovery(rproc);
> +	else
> +		ret = rproc_assisted_recovery(rproc);

The problem of how to handle crash recoveries for processors that have been
attached to is difficult.  Finding a solution for that should be on a patchset
of its own so that people can provide input.

>  
>  unlock_mutex:
>  	mutex_unlock(&rproc->lock);
> diff --git a/include/linux/remoteproc.h b/include/linux/remoteproc.h
> index e0600e1e5c17..b32ef46f8aa4 100644
> --- a/include/linux/remoteproc.h
> +++ b/include/linux/remoteproc.h
> @@ -529,6 +529,7 @@ struct rproc_dump_segment {
>   * @elf_machine: firmware ELF machine
>   * @cdev: character device of the rproc
>   * @cdev_put_on_release: flag to indicate if remoteproc should be shutdown on @char_dev release
> + * @self_recovery: flag to indicate if remoteproc support self recovery
>   */
>  struct rproc {
>  	struct list_head node;
> @@ -568,6 +569,7 @@ struct rproc {
>  	u16 elf_machine;
>  	struct cdev cdev;
>  	bool cdev_put_on_release;
> +	bool self_recovery;
>  };
>  
>  /**
> -- 
> 2.25.1
> 
