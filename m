Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4AFB647A7D7
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Dec 2021 11:44:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231356AbhLTKo0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Dec 2021 05:44:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33314 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229612AbhLTKoZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Dec 2021 05:44:25 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0EB5DC061574;
        Mon, 20 Dec 2021 02:44:25 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 9BEF060F77;
        Mon, 20 Dec 2021 10:44:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 834D4C36AE8;
        Mon, 20 Dec 2021 10:44:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1639997064;
        bh=ePsHNzZhYnoHHXDL+Vx0SzMe2c+G0azjlX3WbXHW30E=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=tqolC68YM3LwXeC/L4SU+II41TPz63VgDAoGtEeGJMrnNIhI3cjRtRaRpZISs7vQQ
         YMzcwwvAlwDm3hgsJtme69fi3bavQs0My+glEAb86At6RZf0iKkvgg8bqcs7QE353b
         wYz0QDWAH0Zcqe50nA/9so6yxRU2kDmHq0K+tNtY=
Date:   Mon, 20 Dec 2021 11:44:21 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Jiasheng Jiang <jiasheng@iscas.ac.cn>
Cc:     agross@kernel.org, bjorn.andersson@linaro.org, balbi@kernel.org,
        p.zabel@pengutronix.de, linux-arm-msm@vger.kernel.org,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] usb: dwc3: qcom: Check for null irq pointer
Message-ID: <YcBehfPqhHpd/FSK@kroah.com>
References: <20211220101520.930658-1-jiasheng@iscas.ac.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211220101520.930658-1-jiasheng@iscas.ac.cn>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 20, 2021 at 06:15:20PM +0800, Jiasheng Jiang wrote:
> The return value of platform_get_irq() needs to be checked.
> To avoid use of null pointer in case that there is no irq.
> 
> Fixes: 2bc02355f8ba ("usb: dwc3: qcom: Add support for booting with ACPI")
> Signed-off-by: Jiasheng Jiang <jiasheng@iscas.ac.cn>
> ---
>  drivers/usb/dwc3/dwc3-qcom.c | 5 +++++
>  1 file changed, 5 insertions(+)
> 
> diff --git a/drivers/usb/dwc3/dwc3-qcom.c b/drivers/usb/dwc3/dwc3-qcom.c
> index 49e6ca94486d..f04fb3f2fb85 100644
> --- a/drivers/usb/dwc3/dwc3-qcom.c
> +++ b/drivers/usb/dwc3/dwc3-qcom.c
> @@ -614,6 +614,11 @@ static int dwc3_qcom_acpi_register_core(struct platform_device *pdev)
>  		qcom->acpi_pdata->dwc3_core_base_size;
>  
>  	irq = platform_get_irq(pdev_irq, 0);
> +	if (!irq) {
> +		ret = -EINVAL;

That is NOT the proper way to check the return value of this function
call.


