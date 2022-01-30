Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 770AD4A37EE
	for <lists+linux-kernel@lfdr.de>; Sun, 30 Jan 2022 18:54:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355772AbiA3RyO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 30 Jan 2022 12:54:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43614 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1355768AbiA3RyK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 30 Jan 2022 12:54:10 -0500
Received: from viti.kaiser.cx (viti.kaiser.cx [IPv6:2a01:238:43fe:e600:cd0c:bd4a:7a3:8e9f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D45B8C061714
        for <linux-kernel@vger.kernel.org>; Sun, 30 Jan 2022 09:54:07 -0800 (PST)
Received: from ipservice-092-217-087-009.092.217.pools.vodafone-ip.de ([92.217.87.9] helo=martin-debian-2.paytec.ch)
        by viti.kaiser.cx with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <postmaster@kaiser.cx>)
        id 1nEEOn-0007xP-Bc; Sun, 30 Jan 2022 18:54:01 +0100
Received: from martin by martin-debian-2.paytec.ch with local (Exim 4.94.2)
        (envelope-from <martin@martin-debian-2.paytec.ch>)
        id 1nEEOm-002wou-Ny; Sun, 30 Jan 2022 18:54:00 +0100
Date:   Sun, 30 Jan 2022 18:54:00 +0100
From:   Martin Kaiser <martin@kaiser.cx>
To:     Muhammad Usama Anjum <usama.anjum@collabora.com>
Cc:     Larry Finger <Larry.Finger@lwfinger.net>,
        Phillip Potter <phil@philpotter.co.uk>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        kernel@collabora.com, kernel-janitors@vger.kernel.org,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] staging: rt8188eu: Remove dead code
Message-ID: <YfbQuA6SSIEXGrWu@martin-debian-1.paytec.ch>
References: <20220128111954.1028121-1-usama.anjum@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220128111954.1028121-1-usama.anjum@collabora.com>
Sender: "Martin Kaiser,,," <martin@martin-debian-2.paytec.ch>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thus wrote Muhammad Usama Anjum (usama.anjum@collabora.com):

> rtStatus is _SUCCESS when the execution reaches this if condition.
> Remove the dead code.

> Fixes: 67396d2dfef3 ("staging: r8188eu: merge ODM_ConfigBBWithHeaderFile with its callers")
> Signed-off-by: Muhammad Usama Anjum <usama.anjum@collabora.com>
> ---
>  drivers/staging/r8188eu/hal/rtl8188e_phycfg.c | 3 ---
>  1 file changed, 3 deletions(-)

> diff --git a/drivers/staging/r8188eu/hal/rtl8188e_phycfg.c b/drivers/staging/r8188eu/hal/rtl8188e_phycfg.c
> index 0b0690dfb947c..41a0d7f0d29f4 100644
> --- a/drivers/staging/r8188eu/hal/rtl8188e_phycfg.c
> +++ b/drivers/staging/r8188eu/hal/rtl8188e_phycfg.c
> @@ -504,9 +504,6 @@ static	int phy_BB8188E_Config_ParaFile(struct adapter *Adapter)
>  		ODM_ReadAndConfig_PHY_REG_PG_8188E(&pHalData->odmpriv);
>  	}

> -	if (rtStatus != _SUCCESS)
> -		goto phy_BB8190_Config_ParaFile_Fail;
> -
>  	/*  3. BB AGC table Initialization */
>  	if (HAL_STATUS_FAILURE == ODM_ReadAndConfig_AGC_TAB_1T_8188E(&pHalData->odmpriv))
>  		rtStatus = _FAIL;
> -- 
> 2.30.2

Thanks for spotting this. It makes sense to remove this duplicate check.

Acked-by: Martin Kaiser <martin@kaiser.cx>

Looking at the function again, the rest of the error handling should be
cleaned up as well. I'll send a patch for this.
