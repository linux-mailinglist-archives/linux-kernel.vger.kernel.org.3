Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9DDD1477415
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Dec 2021 15:12:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237832AbhLPOMe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Dec 2021 09:12:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39400 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237816AbhLPOMM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Dec 2021 09:12:12 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 46F0BC061401;
        Thu, 16 Dec 2021 06:12:12 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id DBFB661E17;
        Thu, 16 Dec 2021 14:12:11 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A67A8C36AE0;
        Thu, 16 Dec 2021 14:12:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1639663931;
        bh=CV8c399RTrExelFrEwbgFJTuCfFII5DqSO6iqus7l4I=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=p0EOzlO6VbOwU7cfmNloVeMYrCu2ylYD4KKycrGkc8FIsOGsa6wIgaH7mJQYiS43d
         pHdmPLkKH30pxLJitVVjDqkGmOh0DvV5x9q6qG2hV6IU3SR07DAlYAcvDfRDloNCoi
         4f8YmUnSr/BWjm3ieZFvQbd6p8dzIZibAoKfVLzQJNvSdVc30b85Ps10ILfNRAfJ76
         uXc+iyrGNMG+M/1WScP87U5rdjAoHaD+4qmdvhN8CltTs2C8G/U/a4CMXJ/16zxcZb
         7njIMDLdtpK7MIJfmCffLQJO3yHTWoAcCiXLq5T3RfLk5FhmckesdjVV1imdOq5Y5w
         IbDHeUM8LxYdA==
Date:   Thu, 16 Dec 2021 22:12:03 +0800
From:   Peter Chen <peter.chen@kernel.org>
To:     Rob Herring <robh@kernel.org>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] usb: chipidea: Set the DT node on the child device
Message-ID: <20211216141203.GA6025@Peter>
References: <20211215225646.1997946-1-robh@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211215225646.1997946-1-robh@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 21-12-15 16:56:46, Rob Herring wrote:
> The ChipIdea glue drivers just copy the glue resources to the "ci_hdrc"
> child device. Instead, set the child device's DT node pointer to the
> parent device's node so that platform_get_irq() can find the IRQ
> resources in the DT. This removes the need for statically populating the
> IRQ resources from the DT which has been deprecated for some time.
> 
> Signed-off-by: Rob Herring <robh@kernel.org>

Acked-by: Peter Chen <peter.chen@kernel.org>

> ---
>  drivers/usb/chipidea/core.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/usb/chipidea/core.c b/drivers/usb/chipidea/core.c
> index a56f06368d14..5359b2a2e4d2 100644
> --- a/drivers/usb/chipidea/core.c
> +++ b/drivers/usb/chipidea/core.c
> @@ -864,6 +864,7 @@ struct platform_device *ci_hdrc_add_device(struct device *dev,
>  	}
>  
>  	pdev->dev.parent = dev;
> +	device_set_of_node_from_dev(&pdev->dev, dev);
>  
>  	ret = platform_device_add_resources(pdev, res, nres);
>  	if (ret)
> -- 
> 2.32.0
> 

-- 

Thanks,
Peter Chen

