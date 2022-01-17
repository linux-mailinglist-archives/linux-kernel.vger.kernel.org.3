Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 663CE490332
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jan 2022 08:53:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237729AbiAQHxd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Jan 2022 02:53:33 -0500
Received: from ams.source.kernel.org ([145.40.68.75]:35104 "EHLO
        ams.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235240AbiAQHxb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jan 2022 02:53:31 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id BD0C3B80C85;
        Mon, 17 Jan 2022 07:53:30 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8AD0CC36AE7;
        Mon, 17 Jan 2022 07:53:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1642406009;
        bh=iu1k0J2dstX5JKGc9BAbgYSZ/hfzhsGK1TRakxtPmbo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=uNG43bgSCih6ZoUxi1NyQQ39SYJMf1hNUs5vv+t5QwhrKKuD7vEwGnOwRI1hgYCn7
         hL5E+bZTlpir47fVeNHPzyVd1w7tlHttEpWwtsf8PEuDN5/QgQ63848yedIGrlfMcL
         4bcrNZVP9w6JUww+IKlSQYY0b9Y7t2nBOyedWLcUT5HdT554Il5tSAPPJdkUoO5wZH
         8VtI0F5w3/9tsimhUSFw5hLm0Yf/ejLmufrbAwv9VdwiiRdiECVr0mLdTN9XAIcQSc
         gzrsopNOf4TWWyI1ScLIoMERmtPFxxxOyxWFdcYOKSkVS5MwAcj+GQb1nadoz1oxti
         Suunu/WyqkVig==
Date:   Mon, 17 Jan 2022 13:23:23 +0530
From:   Manivannan Sadhasivam <mani@kernel.org>
To:     Slark Xiao <slark_xiao@163.com>
Cc:     hemantk@codeaurora.org, mhi@lists.linux.dev,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net] bus: mhi: Add mru_default for Foxconn SDX55
Message-ID: <20220117075323.GA4209@thinkpad>
References: <20220115103912.3775-1-slark_xiao@163.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220115103912.3775-1-slark_xiao@163.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jan 15, 2022 at 06:39:12PM +0800, Slark Xiao wrote:
> For default mechanism, product would use default MRU 3500 if
> they didn't define it. But for Foxconn SDX55, there is a known
> issue which MRU 3500 would lead to data connection lost.
> So we align it with Qualcomm default MRU settings.
> 
> Signed-off-by: Slark Xiao <slark_xiao@163.com>

Reviewed-by: Manivannan Sadhasivam <mani@kernel.org>

You need to add Fixes tag so that I can queue this patch for v5.17 RCs.

Thanks,
Mani

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
