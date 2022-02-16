Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B9CA74B8D42
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Feb 2022 17:06:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235965AbiBPQGq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Feb 2022 11:06:46 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:60006 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235944AbiBPQGn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Feb 2022 11:06:43 -0500
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [46.235.227.227])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 939024925A;
        Wed, 16 Feb 2022 08:06:27 -0800 (PST)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: kholk11)
        with ESMTPSA id A46EF1F450A4
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1645027586;
        bh=aefrMXzupsLGu5Ex9arbBV1OgQCjmS+CBwjP8HtAD84=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=cqo4f+MCDMkcgOCnLgpDF2cDT0hDDpHza/7IDHJhLT5XOWGpgB/i9ooaOOmglHiE0
         WaErsHsIw1PiM+OynCDAdzSo2fYKAvgRhAS+sb6RUiaoGMrtKktkH6mWP1Tr56h4qG
         GdzKJPC8yN7m49uYqOCrJAlNkXWcZVIPe6zPk/SYqv5qyK0OxaDfPmeTwINA8c+cZV
         221lkdkjEwWk2dMlc/XpBKJulMep5vaFWrVu0HlvpCY2Ag3bu/s9XQtcxi3mQGtU9K
         4dwcRMqLI2pLQNXphjzNhsOUfG77I/4QiHZukTz3u5qJv59xvdEiS5GBYYxkrPuIIE
         YwjpvwvjGFLuQ==
Message-ID: <b531eeca-40e8-d759-5579-59567eb5af84@collabora.com>
Date:   Wed, 16 Feb 2022 17:06:22 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.1
Subject: Re: [PATCH] rpmsg: mtk_rpmsg: Fix circular locking dependency
Content-Language: en-US
To:     bjorn.andersson@linaro.org
Cc:     mathieu.poirier@linaro.org, matthias.bgg@gmail.com,
        pihsun@chromium.org, linux-remoteproc@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
        kernel@collabora.com
References: <20220114144737.375621-1-angelogioacchino.delregno@collabora.com>
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
In-Reply-To: <20220114144737.375621-1-angelogioacchino.delregno@collabora.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Il 14/01/22 15:47, AngeloGioacchino Del Regno ha scritto:
> During execution of the worker that's used to register rpmsg devices
> we are safely locking the channels mutex but, when creating a new
> endpoint for such devices, we are registering a IPI on the SCP, which
> then makes the SCP to trigger an interrupt, lock its own mutex and in
> turn register more subdevices.
> This creates a circular locking dependency situation, as the mtk_rpmsg
> channels_lock will then depend on the SCP IPI lock.
> 
> [   18.014514]  Possible unsafe locking scenario:
> [   18.014515]        CPU0                    CPU1
> [   18.014517]        ----                    ----
> [   18.045467]   lock(&mtk_subdev->channels_lock);
> [   18.045474]                                lock(&scp->ipi_desc[i].lock);
> [   18.228399]                                lock(&mtk_subdev->channels_lock);
> [   18.228405]   lock(&scp->ipi_desc[i].lock);
> [   18.264405]
> 
> To solve this, simply unlock the channels_lock mutex before calling
> mtk_rpmsg_register_device() and relock it right after, as safety is
> still ensured by the locking mechanism that happens right after
> through SCP.
> Notably, mtk_rpmsg_register_device() does not even require locking.
> 
> Fixes: 7017996951fd ("rpmsg: add rpmsg support for mt8183 SCP.")
> Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>

Friendly ping for an important fix... :)

> ---
>   drivers/rpmsg/mtk_rpmsg.c | 2 ++
>   1 file changed, 2 insertions(+)
> 
> diff --git a/drivers/rpmsg/mtk_rpmsg.c b/drivers/rpmsg/mtk_rpmsg.c
> index 5b4404b8be4c..d1213c33da20 100644
> --- a/drivers/rpmsg/mtk_rpmsg.c
> +++ b/drivers/rpmsg/mtk_rpmsg.c
> @@ -234,7 +234,9 @@ static void mtk_register_device_work_function(struct work_struct *register_work)
>   		if (info->registered)
>   			continue;
>   
> +		mutex_unlock(&subdev->channels_lock);
>   		ret = mtk_rpmsg_register_device(subdev, &info->info);
> +		mutex_lock(&subdev->channels_lock);
>   		if (ret) {
>   			dev_err(&pdev->dev, "Can't create rpmsg_device\n");
>   			continue;


