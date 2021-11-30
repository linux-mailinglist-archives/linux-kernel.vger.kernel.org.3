Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D04DD463158
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Nov 2021 11:43:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235534AbhK3Kqi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Nov 2021 05:46:38 -0500
Received: from bhuna.collabora.co.uk ([46.235.227.227]:51716 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235408AbhK3KqT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Nov 2021 05:46:19 -0500
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: andrzej.p)
        with ESMTPSA id 7D4131F41ACB
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=collabora.com; s=mail;
        t=1638268979; bh=bt/LR2VtIbVnsC+RvQt24STBUKA1tZH4+bQbyFyrYfI=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=otBHZjseqfl5oMG/tE+COQ/aLb44rsX6s36RICOPAPw5dIr5/Yb3RuW7UpymihyDG
         yFasrSgkPp4Hgo1Xf0lbokikcb7zFOQX98KjdZ/MBAhmzhVLjZde7twhcCyvjpqILb
         NGB2nl59oEDMz58n2ZFtFl/MQnDnLZ9hsgQs9vojMW1EVjkfAn8X+yv6l2N/1MbiRs
         Ek9LiGsOdN1wfdV/7hKbSckgK7Ofq1vmvWm4TszWIWjtpJ/qbyRwjRZ/tQfZh1Cqaq
         h1a35L8Dt5dxGdegsBW1zbydTWADD957x6VueUE9yoB8Ki/MpgZBtCg9j+d4d4zSyP
         KxE694ixt+L+A==
Subject: Re: [PATCH v2 2/9] media: hantro: add support for reset lines
To:     Jernej Skrabec <jernej.skrabec@gmail.com>,
        linux-media@vger.kernel.org
Cc:     ezequiel@vanguardiasur.com.ar, nicolas.dufresne@collabora.com,
        mchehab@kernel.org, robh+dt@kernel.org, mripard@kernel.org,
        wens@csie.org, p.zabel@pengutronix.de, gregkh@linuxfoundation.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-sunxi@lists.linux.dev, linux-kernel@vger.kernel.org,
        linux-staging@lists.linux.dev
References: <20211129182633.480021-1-jernej.skrabec@gmail.com>
 <20211129182633.480021-3-jernej.skrabec@gmail.com>
From:   Andrzej Pietrasiewicz <andrzej.p@collabora.com>
Message-ID: <f04d8f57-f246-110b-8cbc-4a589eff76a5@collabora.com>
Date:   Tue, 30 Nov 2021 11:42:55 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <20211129182633.480021-3-jernej.skrabec@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jernej,

W dniu 29.11.2021 o 19:26, Jernej Skrabec pisze:
> Some SoCs like Allwinner H6 use reset lines for resetting Hantro G2. Add
> support for them.
> 
> Signed-off-by: Jernej Skrabec <jernej.skrabec@gmail.com>

Reviewed-by: Andrzej Pietrasiewicz <andrzej.p@collabora.com>

> ---
>   drivers/staging/media/hantro/hantro.h     |  3 +++
>   drivers/staging/media/hantro/hantro_drv.c | 15 ++++++++++++++-
>   2 files changed, 17 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/staging/media/hantro/hantro.h b/drivers/staging/media/hantro/hantro.h
> index 7da23f7f207a..33eb3e092cc1 100644
> --- a/drivers/staging/media/hantro/hantro.h
> +++ b/drivers/staging/media/hantro/hantro.h
> @@ -16,6 +16,7 @@
>   #include <linux/videodev2.h>
>   #include <linux/wait.h>
>   #include <linux/clk.h>
> +#include <linux/reset.h>
>   
>   #include <media/v4l2-ctrls.h>
>   #include <media/v4l2-device.h>
> @@ -171,6 +172,7 @@ hantro_vdev_to_func(struct video_device *vdev)
>    * @dev:		Pointer to device for convenient logging using
>    *			dev_ macros.
>    * @clocks:		Array of clock handles.
> + * @resets:		Array of reset handles.
>    * @reg_bases:		Mapped addresses of VPU registers.
>    * @enc_base:		Mapped address of VPU encoder register for convenience.
>    * @dec_base:		Mapped address of VPU decoder register for convenience.
> @@ -190,6 +192,7 @@ struct hantro_dev {
>   	struct platform_device *pdev;
>   	struct device *dev;
>   	struct clk_bulk_data *clocks;
> +	struct reset_control *resets;
>   	void __iomem **reg_bases;
>   	void __iomem *enc_base;
>   	void __iomem *dec_base;
> diff --git a/drivers/staging/media/hantro/hantro_drv.c b/drivers/staging/media/hantro/hantro_drv.c
> index 3d3107a39dae..770f4ce71d29 100644
> --- a/drivers/staging/media/hantro/hantro_drv.c
> +++ b/drivers/staging/media/hantro/hantro_drv.c
> @@ -905,6 +905,10 @@ static int hantro_probe(struct platform_device *pdev)
>   			return PTR_ERR(vpu->clocks[0].clk);
>   	}
>   
> +	vpu->resets = devm_reset_control_array_get(&pdev->dev, false, true);
> +	if (IS_ERR(vpu->resets))
> +		return PTR_ERR(vpu->resets);
> +
>   	num_bases = vpu->variant->num_regs ?: 1;
>   	vpu->reg_bases = devm_kcalloc(&pdev->dev, num_bases,
>   				      sizeof(*vpu->reg_bases), GFP_KERNEL);
> @@ -978,10 +982,16 @@ static int hantro_probe(struct platform_device *pdev)
>   	pm_runtime_use_autosuspend(vpu->dev);
>   	pm_runtime_enable(vpu->dev);
>   
> +	ret = reset_control_deassert(vpu->resets);
> +	if (ret) {
> +		dev_err(&pdev->dev, "Failed to deassert resets\n");
> +		goto err_pm_disable;
> +	}
> +
>   	ret = clk_bulk_prepare(vpu->variant->num_clocks, vpu->clocks);
>   	if (ret) {
>   		dev_err(&pdev->dev, "Failed to prepare clocks\n");
> -		goto err_pm_disable;
> +		goto err_rst_assert;
>   	}
>   
>   	ret = v4l2_device_register(&pdev->dev, &vpu->v4l2_dev);
> @@ -1037,6 +1047,8 @@ static int hantro_probe(struct platform_device *pdev)
>   	v4l2_device_unregister(&vpu->v4l2_dev);
>   err_clk_unprepare:
>   	clk_bulk_unprepare(vpu->variant->num_clocks, vpu->clocks);
> +err_rst_assert:
> +	reset_control_assert(vpu->resets);
>   err_pm_disable:
>   	pm_runtime_dont_use_autosuspend(vpu->dev);
>   	pm_runtime_disable(vpu->dev);
> @@ -1056,6 +1068,7 @@ static int hantro_remove(struct platform_device *pdev)
>   	v4l2_m2m_release(vpu->m2m_dev);
>   	v4l2_device_unregister(&vpu->v4l2_dev);
>   	clk_bulk_unprepare(vpu->variant->num_clocks, vpu->clocks);
> +	reset_control_assert(vpu->resets);
>   	pm_runtime_dont_use_autosuspend(vpu->dev);
>   	pm_runtime_disable(vpu->dev);
>   	return 0;
> 

