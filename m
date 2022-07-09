Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C28B156C77A
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Jul 2022 08:12:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229522AbiGIGL4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 9 Jul 2022 02:11:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54966 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229454AbiGIGLy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 Jul 2022 02:11:54 -0400
Received: from sin.source.kernel.org (sin.source.kernel.org [IPv6:2604:1380:40e1:4800::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8904366AEF;
        Fri,  8 Jul 2022 23:11:53 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id C224DCE2DB4;
        Sat,  9 Jul 2022 06:11:51 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B9BCFC3411C;
        Sat,  9 Jul 2022 06:11:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1657347109;
        bh=/ahQ1nH2C/pIVzBpq5RwmOzj0+TITAHKgJHk11EubCc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=JE/6zsGUH7fXG9aGUwH1LUWn3+1OMcK7wCzm2tc4+J3YpPvikEsD30RhksL2DdfuG
         DMEzqyRVMe2zbGpzrO6qalX0774p2aRojFmoplDT9jGieMdF/zkVYCN+Zs0J60T8TO
         Z/OOJW5aRTorHoC6eaQGqzoxD/PI0lb4UM3ygse9ePGFxPqBHnJWx9z/Lhu5PIvVhB
         j0pAbVsZTHDdn4g04pIRHrouGD+3wBSWCSWaOxIN2lhNDFBtl0M5Bu2YYb3f4KVWr4
         9U+/kTgzUNkkEW1do/req0shZDmNsL8hZ6i+ndj1o/xUuGORSdDxDKl9DvLr4P6kZ1
         b2doX0FvKJPnQ==
Date:   Sat, 9 Jul 2022 11:41:39 +0530
From:   Manivannan Sadhasivam <mani@kernel.org>
To:     Bo Liu <liubo03@inspur.com>
Cc:     quic_hemantk@quicinc.com, mhi@lists.linux.dev,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] bus: mhi: ep: Check dev_set_name() return value
Message-ID: <20220709061139.GE5063@thinkpad>
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

Applied to mhi-next!

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
