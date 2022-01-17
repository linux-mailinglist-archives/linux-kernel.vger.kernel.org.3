Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9739E490438
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jan 2022 09:45:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233218AbiAQIol (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Jan 2022 03:44:41 -0500
Received: from dfw.source.kernel.org ([139.178.84.217]:48352 "EHLO
        dfw.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238403AbiAQIoj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jan 2022 03:44:39 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id CBF93610A6;
        Mon, 17 Jan 2022 08:44:38 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 12DBEC36AE3;
        Mon, 17 Jan 2022 08:44:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1642409078;
        bh=A02iP63Nmhf+3fXS2zK3Hw4hWrnpdgDC7O7PJe9+bSc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=eDYim3PbCga1SLXLbcyS52cgzi0eAxuU5juCBja1qJEycc1H/1toDFBccvko7W4oT
         TsrUTOrIcqhcxp3wcjgEIcp+REw54EpyNVdGXpjNfjY5tlTT6auwAJqwUXO+5xgI/X
         Q32u1jf9rImMH2AYbbimk37tqQjS7yJDSl95cLTrSAOPFabdPOQDFenDtqKgsIwcW7
         zm9sPa+LbbmlX1BcAFuzJC6EYdWsYhKoAHaId0tTcHoDXyDK3FlKvyyXoNCrOLirmX
         RhNuanhlXVLvwH8mGTCeN0WdyL+DCgQrBC8MX3BaqWOt5HbiQurHMjZ0zt+5pDU7Ek
         DzVQKeTkiIDxg==
Date:   Mon, 17 Jan 2022 14:14:32 +0530
From:   Manivannan Sadhasivam <mani@kernel.org>
To:     Slark Xiao <slark_xiao@163.com>
Cc:     hemantk@codeaurora.org, mhi@lists.linux.dev,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net v2] For default mechanism, product would use default
 MRU 3500 if they didn't define it. But for Foxconn SDX55, there is a known
 issue which MRU 3500 would lead to data connection lost. So we align it with
 Qualcomm default MRU settings.
Message-ID: <20220117084432.GB4209@thinkpad>
References: <20220117081644.21121-1-slark_xiao@163.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220117081644.21121-1-slark_xiao@163.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 17, 2022 at 04:16:44PM +0800, Slark Xiao wrote:
> Fixes: 5c2c85315948 ("bus: mhi: pci-generic: configurable network interface MRU")

You have messed up the patch subject, please fix it. Also, the correct fixes tag
should be the one added the Foxconn modem support, precisely "aac426562f56".

One more thing, please make sure this MRU value works well for other Foxconn
modems supported by this config.

> Signed-off-by: Slark Xiao <slark_xiao@163.com>

You should have added my Reviewed-by tag too...

Thanks,
Mani

> 
> ---
> v2: Add Fixes tag
> ---
>  drivers/bus/mhi/pci_generic.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/bus/mhi/pci_generic.c b/drivers/bus/mhi/pci_generic.c
> index 3a258a677df8..74e8fc342cfd 100644
> --- a/drivers/bus/mhi/pci_generic.c
> +++ b/drivers/bus/mhi/pci_generic.c
> @@ -366,6 +366,7 @@ static const struct mhi_pci_dev_info mhi_foxconn_sdx55_info = {
>  	.config = &modem_foxconn_sdx55_config,
>  	.bar_num = MHI_PCI_DEFAULT_BAR_NUM,
>  	.dma_data_width = 32,
> +	.mru_default = 32768,
>  	.sideband_wake = false,
>  };
>  
> -- 
> 2.25.1
> 
