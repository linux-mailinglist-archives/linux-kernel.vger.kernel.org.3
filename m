Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C9C554CF27F
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Mar 2022 08:17:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235790AbiCGHSo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Mar 2022 02:18:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43544 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235784AbiCGHSk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Mar 2022 02:18:40 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E692E5FFB;
        Sun,  6 Mar 2022 23:17:46 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id F351C6006F;
        Mon,  7 Mar 2022 07:17:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3C3AEC340EF;
        Mon,  7 Mar 2022 07:17:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1646637465;
        bh=TkHkM64a9L8Z2y7tGG61/lkDEv6OkN2dyJrok5MXSIY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ReMT9ZScMy6S16biad+kyX70EkPfO5keb1jA05y/SLl7+zmMweTh64m7Kk12+F8d0
         G/26iR/nAdkqySXi2a8cyfwYAGwNKg41ciZ2X1wP8WAwLGE/gRj2e7VeDcevDipoZ8
         8eNEfrPWhBodwdnjtxpP6rqJr/9zqV31N6DEXQOsBsPz4FEDBQQdo8VDAglt8+Wyt8
         rXMSu5+btoWv7YI7hjztUmVMF4QDX9/AvSF1z4kcmRWtYKqdHXA4iLR6o/EqJhy6wC
         stRQQKpdydFWDMvlcMUgkm/grjLXBuJbVIISt58rgKTT3kFLbdOP/Lbt2EglOk0pwd
         yMhr0M8o8nKFQ==
Date:   Mon, 7 Mar 2022 12:47:39 +0530
From:   Manivannan Sadhasivam <mani@kernel.org>
To:     Yang Li <yang.lee@linux.alibaba.com>
Cc:     hemantk@codeaurora.org, mhi@lists.linux.dev,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Abaci Robot <abaci@linux.alibaba.com>
Subject: Re: [PATCH -next] bus: mhi: ep: Fix an ignored error return from
 ida_alloc()
Message-ID: <20220307071739.GM12451@workstation>
References: <20220304001139.95082-1-yang.lee@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220304001139.95082-1-yang.lee@linux.alibaba.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Spam-Status: No, score=-7.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 04, 2022 at 08:11:39AM +0800, Yang Li wrote:
> The return from the call to ida_alloc() is int, it can be a negative
> error code, however this is being assigned to an unsigned int variable
> 'mhi_cntrl->index', so assign the value to 'ret' concurrently to solve
> this problem without affecting other functions.
> 
> Eliminate the following coccicheck warning:
> ./drivers/bus/mhi/ep/main.c:1422:5-21: WARNING: Unsigned expression
> compared with zero: mhi_cntrl -> index < 0
> 
> Reported-by: Abaci Robot <abaci@linux.alibaba.com>
> Signed-off-by: Yang Li <yang.lee@linux.alibaba.com>

Thanks for the fix. Since the MHI EP series is under development, I've
squashed this patch with the original patch that added the offending code.

I'll make a note about this in changelog.

> ---
>  drivers/bus/mhi/ep/main.c | 6 ++----
>  1 file changed, 2 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/bus/mhi/ep/main.c b/drivers/bus/mhi/ep/main.c
> index 3e98107f08c4..b27e90d97029 100644
> --- a/drivers/bus/mhi/ep/main.c
> +++ b/drivers/bus/mhi/ep/main.c
> @@ -1418,11 +1418,9 @@ int mhi_ep_register_controller(struct mhi_ep_cntrl *mhi_cntrl,
>  	mhi_ep_mmio_set_env(mhi_cntrl, MHI_EE_AMSS);
>  
>  	/* Set controller index */
> -	mhi_cntrl->index = ida_alloc(&mhi_ep_cntrl_ida, GFP_KERNEL);
> -	if (mhi_cntrl->index < 0) {
> -		ret = mhi_cntrl->index;
> +	mhi_cntrl->index = ret = ida_alloc(&mhi_ep_cntrl_ida, GFP_KERNEL);
> +	if (ret < 0)
>  		goto err_destroy_wq;
> -	}

I've just used "ret" for catching the ida_alloc() and assigned it to
index after success.

Thanks,
Mani
>  
>  	irq_set_status_flags(mhi_cntrl->irq, IRQ_NOAUTOEN);
>  	ret = request_irq(mhi_cntrl->irq, mhi_ep_irq, IRQF_TRIGGER_HIGH,
> -- 
> 2.20.1.7.g153144c
> 
