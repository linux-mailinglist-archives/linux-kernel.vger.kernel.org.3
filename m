Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7752E4630F5
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Nov 2021 11:26:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232574AbhK3K31 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Nov 2021 05:29:27 -0500
Received: from bhuna.collabora.co.uk ([46.235.227.227]:51472 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231216AbhK3K30 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Nov 2021 05:29:26 -0500
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: andrzej.p)
        with ESMTPSA id 9CC921F44ED2
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=collabora.com; s=mail;
        t=1638267966; bh=IgwztHxzREh/Q/7Ezo4Hr0AinW9tnPDfs+goRZ6aFxg=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=OFVuSig5j+RJkZHYQmnnULJveo8yRJHiPHesGIv7o9QxlzuInvv0QreFAzsjN5ifJ
         pVSi1bBY8E7q0DFJZQwXWKOcM4WUi1CYsu6k0oWrhN5Q3ZHG7u1+HYop1TCjAtRQ5n
         wsgMu4ROT1RWir4kOx5UmOCmsORwtdHolV5BDJmTY6jrYhSrx6tiWsmyFf5YfaT7K6
         uhAj3RA562zWWepdkUNidXWFG3m2EnAQ7cGKQXOpHA3lFFlHn9xKiOrfb/jQ7n/gBY
         WjfboFqk94DzbW9oOnwQ+mgbNnsQvC9hqED/Sh2fHCQB0PU6aASpzjEFItpe+LYVo1
         kUnm0o2siNc6w==
Subject: Re: [PATCH v2 1/9] media: hantro: Fix probe func error path
To:     Jernej Skrabec <jernej.skrabec@gmail.com>,
        linux-media@vger.kernel.org
Cc:     ezequiel@vanguardiasur.com.ar, nicolas.dufresne@collabora.com,
        mchehab@kernel.org, robh+dt@kernel.org, mripard@kernel.org,
        wens@csie.org, p.zabel@pengutronix.de, gregkh@linuxfoundation.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-sunxi@lists.linux.dev, linux-kernel@vger.kernel.org,
        linux-staging@lists.linux.dev
References: <20211129182633.480021-1-jernej.skrabec@gmail.com>
 <20211129182633.480021-2-jernej.skrabec@gmail.com>
From:   Andrzej Pietrasiewicz <andrzej.p@collabora.com>
Message-ID: <1ab17bfc-8949-0be6-d4a4-1f17d812ef57@collabora.com>
Date:   Tue, 30 Nov 2021 11:26:02 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <20211129182633.480021-2-jernej.skrabec@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jernej,

W dniu 29.11.2021 o 19:26, Jernej Skrabec pisze:
> If clocks for some reason couldn't be enabled, probe function returns
> immediately, without disabling PM. This obviously leaves PM ref counters
> unbalanced.
> 
> Fix that by jumping to appropriate error path, so effects of PM functions
> are reversed.
> 
> Fixes: 775fec69008d ("media: add Rockchip VPU JPEG encoder driver")
> Signed-off-by: Jernej Skrabec <jernej.skrabec@gmail.com>

Acked-by: Andrzej Pietrasiewicz <andrzej.p@collabora.com>

> ---
>   drivers/staging/media/hantro/hantro_drv.c | 3 ++-
>   1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/staging/media/hantro/hantro_drv.c b/drivers/staging/media/hantro/hantro_drv.c
> index ab2467998d29..3d3107a39dae 100644
> --- a/drivers/staging/media/hantro/hantro_drv.c
> +++ b/drivers/staging/media/hantro/hantro_drv.c
> @@ -981,7 +981,7 @@ static int hantro_probe(struct platform_device *pdev)
>   	ret = clk_bulk_prepare(vpu->variant->num_clocks, vpu->clocks);
>   	if (ret) {
>   		dev_err(&pdev->dev, "Failed to prepare clocks\n");
> -		return ret;
> +		goto err_pm_disable;
>   	}
>   
>   	ret = v4l2_device_register(&pdev->dev, &vpu->v4l2_dev);
> @@ -1037,6 +1037,7 @@ static int hantro_probe(struct platform_device *pdev)
>   	v4l2_device_unregister(&vpu->v4l2_dev);
>   err_clk_unprepare:
>   	clk_bulk_unprepare(vpu->variant->num_clocks, vpu->clocks);
> +err_pm_disable:
>   	pm_runtime_dont_use_autosuspend(vpu->dev);
>   	pm_runtime_disable(vpu->dev);
>   	return ret;
> 

