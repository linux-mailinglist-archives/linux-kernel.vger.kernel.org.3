Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2085E56C777
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Jul 2022 08:08:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229503AbiGIGID (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 9 Jul 2022 02:08:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52968 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229454AbiGIGIC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 Jul 2022 02:08:02 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AEE5614099;
        Fri,  8 Jul 2022 23:08:01 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 26BF860C34;
        Sat,  9 Jul 2022 06:08:01 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 186A6C3411C;
        Sat,  9 Jul 2022 06:07:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1657346880;
        bh=vmb51TA7agNZ9Oxx2u8lZxkAmvViGJooTKdRirJS8UY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=TKPBEYO1++gFz84IcM+gPuaixDVDAksUkdSSmYOICPc6V7bEN9BgK5aMiFtsOYCaI
         h87WL0V9orAb3+Ytv9AWCE2GzxUVrD21zpGe58PeuWrg1A+cnQhN1K7g8MhD9uHIvC
         9oi+h/rCco2X5XHkELQsbW4YHzfPyAuqFBN+FCqd47+YWpgfR7Arkk5AlHLT0o7gVL
         NuRnjL6JCV8sDfihVGZr/8Z54UIipOhvn0CvGQQddarCAaG6DUYRmz33F8h+CYqDix
         WeROnQe9bXVcsEFP4LXxMUyqM3wEPkI7LMx5IKCGy5pOGwfH5GXVxeWe19qaWzaL2x
         omT4FbkLXJ+NQ==
Date:   Sat, 9 Jul 2022 11:37:49 +0530
From:   Manivannan Sadhasivam <mani@kernel.org>
To:     Bo Liu <liubo03@inspur.com>
Cc:     mani@kernel.org, quic_hemantk@quicinc.com, mhi@lists.linux.dev,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] bus: mhi: ep: Check dev_set_name() return value
Message-ID: <20220709060749.GB5063@thinkpad>
References: <20220708015948.4091-1-liubo03@inspur.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220708015948.4091-1-liubo03@inspur.com>
X-Spam-Status: No, score=-7.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 07, 2022 at 09:59:48PM -0400, Bo Liu wrote:
> It's possible that dev_set_name() returns -ENOMEM, catch and handle this.
> 
> Signed-off-by: Bo Liu <liubo03@inspur.com>

Reviewed-by: Manivannan Sadhasivam <mani@kernel.org>

Thanks,
Mani

> ---
>  drivers/bus/mhi/ep/main.c | 11 +++++++++--
>  1 file changed, 9 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/bus/mhi/ep/main.c b/drivers/bus/mhi/ep/main.c
> index 40109a79017a..1dc8a3557a46 100644
> --- a/drivers/bus/mhi/ep/main.c
> +++ b/drivers/bus/mhi/ep/main.c
> @@ -1242,9 +1242,13 @@ static int mhi_ep_create_device(struct mhi_ep_cntrl *mhi_cntrl, u32 ch_id)
>  
>  	/* Channel name is same for both UL and DL */
>  	mhi_dev->name = mhi_chan->name;
> -	dev_set_name(&mhi_dev->dev, "%s_%s",
> +	ret = dev_set_name(&mhi_dev->dev, "%s_%s",
>  		     dev_name(&mhi_cntrl->mhi_dev->dev),
>  		     mhi_dev->name);
> +	if (ret) {
> +		put_device(&mhi_dev->dev);
> +		return ret;
> +	}
>  
>  	ret = device_add(&mhi_dev->dev);
>  	if (ret)
> @@ -1408,7 +1412,10 @@ int mhi_ep_register_controller(struct mhi_ep_cntrl *mhi_cntrl,
>  		goto err_free_irq;
>  	}
>  
> -	dev_set_name(&mhi_dev->dev, "mhi_ep%u", mhi_cntrl->index);
> +	ret = dev_set_name(&mhi_dev->dev, "mhi_ep%u", mhi_cntrl->index);
> +	if (ret)
> +		goto err_put_dev;
> +
>  	mhi_dev->name = dev_name(&mhi_dev->dev);
>  	mhi_cntrl->mhi_dev = mhi_dev;
>  
> -- 
> 2.27.0
> 

-- 
மணிவண்ணன் சதாசிவம்
