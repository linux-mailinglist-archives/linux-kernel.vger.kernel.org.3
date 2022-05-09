Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5A9CC51FE9F
	for <lists+linux-kernel@lfdr.de>; Mon,  9 May 2022 15:46:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236532AbiEINrK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 May 2022 09:47:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38638 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236461AbiEINq7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 May 2022 09:46:59 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D99AF26A71A
        for <linux-kernel@vger.kernel.org>; Mon,  9 May 2022 06:42:41 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 96C7DB8161D
        for <linux-kernel@vger.kernel.org>; Mon,  9 May 2022 13:42:40 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AC9D4C385A8;
        Mon,  9 May 2022 13:42:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1652103759;
        bh=mM+F759D5ZWo2I+asLHaLWX2EZXN28v7krIQk+1XxP8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=XlkYVUWCMQBwoTy+SdrSBR3NETefmo7ANRdDxSSK8Gc4fGKzGoGkScKZ5yNyFEGbi
         lKoYW8xYo2Ixt4Q+fkSCXmjBPBo/M5kefc4m0CKq8XyYvU51Ys6RrdEgPXfEwCfsZr
         4AfTcgaSr/jTvuXVgHnqsAvhaIvyo8d+n42eTmzI=
Date:   Mon, 9 May 2022 15:42:36 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Cc:     linux-kernel@vger.kernel.org, Yang Li <yang.lee@linux.alibaba.com>,
        Abaci Robot <abaci@linux.alibaba.com>
Subject: Re: [PATCH 2/2] slimbus: qcom: Remove unnecessary print function
 dev_err()
Message-ID: <YnkaTOk3SzcyFJyP@kroah.com>
References: <20220429165051.6187-1-srinivas.kandagatla@linaro.org>
 <20220429165051.6187-3-srinivas.kandagatla@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220429165051.6187-3-srinivas.kandagatla@linaro.org>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 29, 2022 at 05:50:51PM +0100, Srinivas Kandagatla wrote:
> From: Yang Li <yang.lee@linux.alibaba.com>
> 
> The print function dev_err() is redundant because
> platform_get_irq_byname() already prints an error.
> 
> Eliminate the follow coccicheck warning:
> ./drivers/slimbus/qcom-ctrl.c:514:2-9: line 514 is redundant because
> platform_get_irq() already prints an error
> 
> Reported-by: Abaci Robot <abaci@linux.alibaba.com>
> Signed-off-by: Yang Li <yang.lee@linux.alibaba.com>
> Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
> ---
>  drivers/slimbus/qcom-ctrl.c | 4 +---
>  1 file changed, 1 insertion(+), 3 deletions(-)
> 
> diff --git a/drivers/slimbus/qcom-ctrl.c b/drivers/slimbus/qcom-ctrl.c
> index ec58091fc948..c0c4f895d76e 100644
> --- a/drivers/slimbus/qcom-ctrl.c
> +++ b/drivers/slimbus/qcom-ctrl.c
> @@ -510,10 +510,8 @@ static int qcom_slim_probe(struct platform_device *pdev)
>  	}
>  
>  	ctrl->irq = platform_get_irq(pdev, 0);
> -	if (ctrl->irq < 0) {
> -		dev_err(&pdev->dev, "no slimbus IRQ\n");
> +	if (ctrl->irq < 0)
>  		return ctrl->irq;
> -	}
>  
>  	sctrl = &ctrl->ctrl;
>  	sctrl->dev = &pdev->dev;
> -- 
> 2.21.0
> 

Does not apply to my tree :(


