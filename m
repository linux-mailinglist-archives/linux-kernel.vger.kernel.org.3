Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 04A7648C455
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jan 2022 14:02:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353332AbiALNCN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Jan 2022 08:02:13 -0500
Received: from dfw.source.kernel.org ([139.178.84.217]:38740 "EHLO
        dfw.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240808AbiALNCM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Jan 2022 08:02:12 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 576BF618E1;
        Wed, 12 Jan 2022 13:02:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 98B28C36AE5;
        Wed, 12 Jan 2022 13:02:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1641992531;
        bh=xN5mlnqY+gMJl+hSFiJTZNLp9TBF3n2tNpwlX20k2dM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=LMMQOzvvcu6s4IKCCdOArgzNwkao3ZXzLabfbL6zox3A+GNZY+3BZPJU/wg55oio8
         JtPVFCck2FIumjGnbrPuUgHloRegHEDdKiwo31fkXGPQQHXFbI4Qxy+YQzYudhnoQi
         +P0Yt07rn74HWzxUFIVDa4tZXsWsVxtBmBFsErVqRlhArDH1c8tGdfZ0j7mIj5alta
         G6Ots8ktOmW8ZZhQeGHxHYkfwoyRSUI5BxPDztxMITZZQL2HnAnq9OFt9bAIJnVIzX
         +NtCRy85VPlbrr+WbZXBb6oCE7iYVfMDx1hA8q26Q8vw+oLOPokq3QyxbhHuk/vTJ6
         +GxuKqTSQNJ8A==
Date:   Wed, 12 Jan 2022 21:02:01 +0800
From:   Peter Chen <peter.chen@kernel.org>
To:     Pawel Laszczak <pawell@cadence.com>
Cc:     gregkh@linuxfoundation.org, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] usb: cdnsp: remove not used temp_64 variables
Message-ID: <20220112130201.GE3796@Peter>
References: <20220111114449.44402-1-pawell@gli-login.cadence.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220111114449.44402-1-pawell@gli-login.cadence.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 22-01-11 12:44:49, Pawel Laszczak wrote:
> From: Pawel Laszczak <pawell@cadence.com>
> 
> Patch removes initialized but not used variables temp_64
> from cdnsp_run function.
> 
> Reported-by: kernel test robot <lkp@intel.com>
> Signed-off-by: Pawel Laszczak <pawell@cadence.com>

Reviewed-by: Peter Chen <peter.chen@kernel.org>

> ---
>  drivers/usb/cdns3/cdnsp-gadget.c | 3 ---
>  1 file changed, 3 deletions(-)
> 
> diff --git a/drivers/usb/cdns3/cdnsp-gadget.c b/drivers/usb/cdns3/cdnsp-gadget.c
> index 27df0c697897..ec8a0dc792bc 100644
> --- a/drivers/usb/cdns3/cdnsp-gadget.c
> +++ b/drivers/usb/cdns3/cdnsp-gadget.c
> @@ -1243,12 +1243,9 @@ static int cdnsp_run(struct cdnsp_device *pdev,
>  		     enum usb_device_speed speed)
>  {
>  	u32 fs_speed = 0;
> -	u64 temp_64;
>  	u32 temp;
>  	int ret;
>  
> -	temp_64 = cdnsp_read_64(&pdev->ir_set->erst_dequeue);
> -	temp_64 &= ~ERST_PTR_MASK;
>  	temp = readl(&pdev->ir_set->irq_control);
>  	temp &= ~IMOD_INTERVAL_MASK;
>  	temp |= ((IMOD_DEFAULT_INTERVAL / 250) & IMOD_INTERVAL_MASK);
> -- 
> 2.25.1
> 

-- 

Thanks,
Peter Chen

