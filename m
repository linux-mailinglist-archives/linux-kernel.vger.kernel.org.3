Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 63F2947CF47
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Dec 2021 10:31:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243951AbhLVJb4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Dec 2021 04:31:56 -0500
Received: from ams.source.kernel.org ([145.40.68.75]:47352 "EHLO
        ams.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243935AbhLVJb4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Dec 2021 04:31:56 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id B9FDEB81A88;
        Wed, 22 Dec 2021 09:31:54 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EB2BEC36AE8;
        Wed, 22 Dec 2021 09:31:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1640165513;
        bh=PSBzTEFohZ3a/CNUDHjTqvnSIemq56UVaT5rgaO9Q3I=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=1dutxwxqXDJYsLbDCRQsTSi+nyhNDDnwxV01dxrp9sPnVWCVP+Ii4eyLvtW2s1yhS
         ZNYTgRRdbfiStM/dDjUGNXX+WH/8ZYNiU0//sqUBFeo7BXGZW2w9GKXTM7Eb4dELYq
         R059O1i7uYLQBkJ/5k330OnP1rGZhgVlnlrDNLB8=
Date:   Wed, 22 Dec 2021 10:31:51 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Miaoqian Lin <linmq006@gmail.com>
Cc:     linmq006@gmail.com, Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Felipe Balbi <balbi@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Shawn Guo <shawn.guo@linaro.org>,
        linux-arm-msm@vger.kernel.org, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] usb: dwc3: qcom: Fix NULL vs IS_ERR checking in
 dwc3_qcom_probe
Message-ID: <YcLwh06Z/1hBG6IY@kroah.com>
References: <20211222091444.5034-1-linmq006@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211222091444.5034-1-linmq006@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[note, you got the to: line incorrect...]

On Wed, Dec 22, 2021 at 09:14:44AM +0000, Miaoqian Lin wrote:
> Since the acpi_create_platform_device() function may return error
> pointers, dwc3_qcom_create_urs_usb_platdev() function may return errors
> too. Using IS_ERR_OR_NULL() to check the return value to fix this.
> 
> Fixes: c25c210f590e("usb: dwc3: qcom: add URS Host support for sdm845 ACPI boot")

Nit, the documentation says this should be:
Fixes: c25c210f590e ("usb: dwc3: qcom: add URS Host support for sdm845 ACPI boot")


> Signed-off-by: Miaoqian Lin <linmq006@gmail.com>
> ---
>  drivers/usb/dwc3/dwc3-qcom.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/usb/dwc3/dwc3-qcom.c b/drivers/usb/dwc3/dwc3-qcom.c
> index 3cb01cdd02c2..df27d903ba98 100644
> --- a/drivers/usb/dwc3/dwc3-qcom.c
> +++ b/drivers/usb/dwc3/dwc3-qcom.c
> @@ -769,9 +769,9 @@ static int dwc3_qcom_probe(struct platform_device *pdev)
>  
>  		if (qcom->acpi_pdata->is_urs) {
>  			qcom->urs_usb = dwc3_qcom_create_urs_usb_platdev(dev);
> -			if (!qcom->urs_usb) {
> +			if (IS_ERR_OR_NULL(qcom->urs_usb)) {
>  				dev_err(dev, "failed to create URS USB platdev\n");
> -				return -ENODEV;
> +				return qcom->urs_usb ? PTR_ERR(qcom->urs_usb) : -ENODEV;

Please no ? : if at all possible.  Spell it out as a real if statement.

thanks,

greg k-h
