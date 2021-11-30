Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0BCE8463400
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Nov 2021 13:15:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241451AbhK3MTH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Nov 2021 07:19:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52474 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240512AbhK3MTF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Nov 2021 07:19:05 -0500
Received: from mail-ua1-x92d.google.com (mail-ua1-x92d.google.com [IPv6:2607:f8b0:4864:20::92d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 495D0C061748
        for <linux-kernel@vger.kernel.org>; Tue, 30 Nov 2021 04:15:46 -0800 (PST)
Received: by mail-ua1-x92d.google.com with SMTP id r15so40901066uao.3
        for <linux-kernel@vger.kernel.org>; Tue, 30 Nov 2021 04:15:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=vanguardiasur-com-ar.20210112.gappssmtp.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=D0mw93VUXSvv9PrYmrUAaGd/pqXhij6XVGDbV+g6WIU=;
        b=wogE/Z0DZ4jA4YAj/X92JyIrHC+m1SB6igDc4ElmWJrRmGbeZB78fUwjuxI/vf8zW2
         SyCVIqcrZhVSmybJvuSnkKKjwsbiJsQ0iISbs9RpA0EdhSc926sSMLcWW0AxUADxJkdh
         9ci2MsRyNZn5wxbOh5uUyV6sYOKZRrOKhUgRQICcHoLZUyqQPhm82vSSVznUV6lv+Qfj
         xYqUhtN3pDbuMetySDbqQPSS3A+qO5XRBCAZ5noUdVzIkfkeg6eFtprA6aSwmcM9XyAu
         z0JWuSvQJWULvDr63w/RzEzMAukf4QHxBgnulG13eg5X+avdeU6YAQsuuX9IugGoNnLr
         Krmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=D0mw93VUXSvv9PrYmrUAaGd/pqXhij6XVGDbV+g6WIU=;
        b=wKHKVLbmatmNmzMxsq8ZGmg5fip5iPWCvtS2XOgQuYWJNuwPecpIPCxvaF0rYkKIhf
         Ea3fYbypZk3ot44JACSQrGHoPpIpKJ/tABVn6D7QCwIGTZF9G7gH1FRPBI1qqptP9Skf
         6W7nXneIpQY6uduDmRSo2k7TOXJxFIh2rNSCSOBDlMJoPtglkOFnoYAsgTEfkSe7lmvO
         ULxz53f7gIjqPwdBpFdhPP5O2Tl/Fqwkm85sV27qZ5HRZNo2jM+81hM0kttbYDam4khn
         yw0MmKWC23cMEKhHmmNJ1Cl2jsJtKeGIfhAmt3A2lNwqXLB9ttrCSB8Qyld1v0PhcAwo
         yNpQ==
X-Gm-Message-State: AOAM532QU4X2C98NGRwwuNz/2Ndmk021aE3dgZ6HmFC53Tmkw+LmfoEZ
        sG4bMFO/oKJxGbJF5FIhc0y/kQ==
X-Google-Smtp-Source: ABdhPJyCNxQdSY3YZruzyVJnb1BCD/Sq40KKRtki81VwF4tplQMFk7VK2k8mJuh9ajNFgAKFx10ARg==
X-Received: by 2002:a05:6102:2c6:: with SMTP id h6mr31346929vsh.13.1638274545465;
        Tue, 30 Nov 2021 04:15:45 -0800 (PST)
Received: from eze-laptop (host208.201-253-22.telecom.net.ar. [201.253.22.208])
        by smtp.gmail.com with ESMTPSA id l190sm9955863vsc.26.2021.11.30.04.15.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Nov 2021 04:15:44 -0800 (PST)
Date:   Tue, 30 Nov 2021 09:15:39 -0300
From:   Ezequiel Garcia <ezequiel@vanguardiasur.com.ar>
To:     Jernej Skrabec <jernej.skrabec@gmail.com>
Cc:     linux-media@vger.kernel.org, nicolas.dufresne@collabora.com,
        mchehab@kernel.org, robh+dt@kernel.org, mripard@kernel.org,
        wens@csie.org, p.zabel@pengutronix.de, andrzej.p@collabora.com,
        gregkh@linuxfoundation.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-sunxi@lists.linux.dev,
        linux-kernel@vger.kernel.org, linux-staging@lists.linux.dev
Subject: Re: [PATCH v2 2/9] media: hantro: add support for reset lines
Message-ID: <YaYV62lJ5A/Q5/WX@eze-laptop>
References: <20211129182633.480021-1-jernej.skrabec@gmail.com>
 <20211129182633.480021-3-jernej.skrabec@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211129182633.480021-3-jernej.skrabec@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 29, 2021 at 07:26:26PM +0100, Jernej Skrabec wrote:
> Some SoCs like Allwinner H6 use reset lines for resetting Hantro G2. Add
> support for them.
> 
> Signed-off-by: Jernej Skrabec <jernej.skrabec@gmail.com>

Reviewed-by: Ezequiel Garcia <ezequiel@vanguardiasur.com.ar>

Thanks!

> ---
>  drivers/staging/media/hantro/hantro.h     |  3 +++
>  drivers/staging/media/hantro/hantro_drv.c | 15 ++++++++++++++-
>  2 files changed, 17 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/staging/media/hantro/hantro.h b/drivers/staging/media/hantro/hantro.h
> index 7da23f7f207a..33eb3e092cc1 100644
> --- a/drivers/staging/media/hantro/hantro.h
> +++ b/drivers/staging/media/hantro/hantro.h
> @@ -16,6 +16,7 @@
>  #include <linux/videodev2.h>
>  #include <linux/wait.h>
>  #include <linux/clk.h>
> +#include <linux/reset.h>
>  
>  #include <media/v4l2-ctrls.h>
>  #include <media/v4l2-device.h>
> @@ -171,6 +172,7 @@ hantro_vdev_to_func(struct video_device *vdev)
>   * @dev:		Pointer to device for convenient logging using
>   *			dev_ macros.
>   * @clocks:		Array of clock handles.
> + * @resets:		Array of reset handles.
>   * @reg_bases:		Mapped addresses of VPU registers.
>   * @enc_base:		Mapped address of VPU encoder register for convenience.
>   * @dec_base:		Mapped address of VPU decoder register for convenience.
> @@ -190,6 +192,7 @@ struct hantro_dev {
>  	struct platform_device *pdev;
>  	struct device *dev;
>  	struct clk_bulk_data *clocks;
> +	struct reset_control *resets;
>  	void __iomem **reg_bases;
>  	void __iomem *enc_base;
>  	void __iomem *dec_base;
> diff --git a/drivers/staging/media/hantro/hantro_drv.c b/drivers/staging/media/hantro/hantro_drv.c
> index 3d3107a39dae..770f4ce71d29 100644
> --- a/drivers/staging/media/hantro/hantro_drv.c
> +++ b/drivers/staging/media/hantro/hantro_drv.c
> @@ -905,6 +905,10 @@ static int hantro_probe(struct platform_device *pdev)
>  			return PTR_ERR(vpu->clocks[0].clk);
>  	}
>  
> +	vpu->resets = devm_reset_control_array_get(&pdev->dev, false, true);
> +	if (IS_ERR(vpu->resets))
> +		return PTR_ERR(vpu->resets);
> +
>  	num_bases = vpu->variant->num_regs ?: 1;
>  	vpu->reg_bases = devm_kcalloc(&pdev->dev, num_bases,
>  				      sizeof(*vpu->reg_bases), GFP_KERNEL);
> @@ -978,10 +982,16 @@ static int hantro_probe(struct platform_device *pdev)
>  	pm_runtime_use_autosuspend(vpu->dev);
>  	pm_runtime_enable(vpu->dev);
>  
> +	ret = reset_control_deassert(vpu->resets);
> +	if (ret) {
> +		dev_err(&pdev->dev, "Failed to deassert resets\n");
> +		goto err_pm_disable;
> +	}
> +
>  	ret = clk_bulk_prepare(vpu->variant->num_clocks, vpu->clocks);
>  	if (ret) {
>  		dev_err(&pdev->dev, "Failed to prepare clocks\n");
> -		goto err_pm_disable;
> +		goto err_rst_assert;
>  	}
>  
>  	ret = v4l2_device_register(&pdev->dev, &vpu->v4l2_dev);
> @@ -1037,6 +1047,8 @@ static int hantro_probe(struct platform_device *pdev)
>  	v4l2_device_unregister(&vpu->v4l2_dev);
>  err_clk_unprepare:
>  	clk_bulk_unprepare(vpu->variant->num_clocks, vpu->clocks);
> +err_rst_assert:
> +	reset_control_assert(vpu->resets);
>  err_pm_disable:
>  	pm_runtime_dont_use_autosuspend(vpu->dev);
>  	pm_runtime_disable(vpu->dev);
> @@ -1056,6 +1068,7 @@ static int hantro_remove(struct platform_device *pdev)
>  	v4l2_m2m_release(vpu->m2m_dev);
>  	v4l2_device_unregister(&vpu->v4l2_dev);
>  	clk_bulk_unprepare(vpu->variant->num_clocks, vpu->clocks);
> +	reset_control_assert(vpu->resets);
>  	pm_runtime_dont_use_autosuspend(vpu->dev);
>  	pm_runtime_disable(vpu->dev);
>  	return 0;
> -- 
> 2.34.1
> 
