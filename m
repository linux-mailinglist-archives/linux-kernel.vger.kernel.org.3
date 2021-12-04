Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A3A8E4684EB
	for <lists+linux-kernel@lfdr.de>; Sat,  4 Dec 2021 14:02:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1384977AbhLDNGF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 4 Dec 2021 08:06:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43010 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233028AbhLDNGF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 4 Dec 2021 08:06:05 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F8DFC061751;
        Sat,  4 Dec 2021 05:02:39 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 9A52460E65;
        Sat,  4 Dec 2021 13:02:38 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8815EC341C2;
        Sat,  4 Dec 2021 13:02:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1638622958;
        bh=/x1aa856JFb/fOGEdAlpjcExNViaTRki3QeCUAm3jMQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=aP0mo6G21LcfeajXQ1Rv05WLLaHScjFsH1wclF6USqjCQU8ki3rF8FTCvmew/8ehE
         riePcBi3Aje00YVswEg301ABrlE22xTB/VjWrRn+sTFOxdMCbR784zxFuu9Tt7RR6Y
         +TNZznHLHqu1VJL1Cz/mWEKyHO6nHXqgETPphgz9gKtez4C2+s6sZQNn2OdwcZ/JH/
         GQU/NrJ+yJXzxuMOcgYNeQ2BKIosHwBvDoAJqtvThEhV8pD6hFx5VFF3giAxulHTsl
         gEQQJEY/GIrRATrlXoFJjEz4vvKjl9xOwynpLmQVxY1g3bmnM2IxPGo5EHybGwZO/T
         u7HSLflPn/CZw==
Date:   Sat, 4 Dec 2021 21:02:32 +0800
From:   Peter Chen <peter.chen@kernel.org>
To:     Jiasheng Jiang <jiasheng@iscas.ac.cn>
Cc:     gregkh@linuxfoundation.org, p.zabel@pengutronix.de,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] usb: chipidea: msm: Handle error codes
Message-ID: <20211204130232.GA8231@Peter>
References: <20211203080106.1559983-1-jiasheng@iscas.ac.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211203080106.1559983-1-jiasheng@iscas.ac.cn>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 21-12-03 16:01:06, Jiasheng Jiang wrote:
> The return value of of_get_next_available_child() and
> of_device_is_compatible() is not always 0.
> To catch the exception in case of the failure.
> 
> Fixes: 47654a162081 ("usb: chipidea: msm: Restore wrapper settings after reset")
> Signed-off-by: Jiasheng Jiang <jiasheng@iscas.ac.cn>
> ---
>  drivers/usb/chipidea/ci_hdrc_msm.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/drivers/usb/chipidea/ci_hdrc_msm.c b/drivers/usb/chipidea/ci_hdrc_msm.c
> index 46105457e1ca..13218f0a2bed 100644
> --- a/drivers/usb/chipidea/ci_hdrc_msm.c
> +++ b/drivers/usb/chipidea/ci_hdrc_msm.c
> @@ -246,6 +246,8 @@ static int ci_hdrc_msm_probe(struct platform_device *pdev)
>  	if (ulpi_node) {
>  		phy_node = of_get_next_available_child(ulpi_node, NULL);
>  		ci->hsic = of_device_is_compatible(phy_node, "qcom,usb-hsic-phy");
> +		if (!phy_node || !ci->hsic)
> +			goto err_mux;

I afraid I could not understand your change with your patch description,
no matter phy_node is NULL or ci->hsic is NULL, the code should be OK,
right?

>  		of_node_put(phy_node);
>  	}
>  	of_node_put(ulpi_node);
> -- 
> 2.25.1
> 

-- 

Thanks,
Peter Chen

