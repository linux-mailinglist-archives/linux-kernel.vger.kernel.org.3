Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AE510497255
	for <lists+linux-kernel@lfdr.de>; Sun, 23 Jan 2022 16:05:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234239AbiAWPFq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 23 Jan 2022 10:05:46 -0500
Received: from ams.source.kernel.org ([145.40.68.75]:43426 "EHLO
        ams.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234090AbiAWPFp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 23 Jan 2022 10:05:45 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 89DD0B80CF9;
        Sun, 23 Jan 2022 15:05:44 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 884E9C340E2;
        Sun, 23 Jan 2022 15:05:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1642950343;
        bh=+I+wjm3eWa095440ujT7Z/tq8L5DuQQBmbFwtEQL3kM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=bSAhxcW5CnUopJFRWWxRe0BaTij0DiVt523067SOP8opyX4eiFioxS6TatRAhTAu7
         VVSKJe9d/ztaQ2NvOZIMPjUZi1LeliCqjrkVuCW/vBC3jAGakPnKKBB3HKl01Cv54s
         z8aqEwlmAf9O/VlDpMdEfgHRhY4PDpyUrzBlJjFJ5F45q3CnKpuqIteEB1gm1k13CU
         z72/+2pF6i2hTnno58m7tFCwDV8bOQ9AAPn6VsS4qLE4fi9aokYH4O87AqQ3eea404
         WSm5a+IetzWe8GQkZAtK5d/aGGhhDM61XmaV8blIpfK2KHVZluean+CoyIv8wKZdPx
         CMR1eK8iC3+jA==
Date:   Sun, 23 Jan 2022 20:35:35 +0530
From:   Manivannan Sadhasivam <mani@kernel.org>
To:     Slark Xiao <slark_xiao@163.com>
Cc:     hemantk@codeaurora.org, thomas.ulrich@thalesgroup.com,
        gregkh@linuxfoundation.org, mhi@lists.linux.dev,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net] bus: mhi: Add mru_default for Cinterion MV31-W
Message-ID: <20220123150535.GB11636@thinkpad>
References: <20220119102519.5342-1-slark_xiao@163.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220119102519.5342-1-slark_xiao@163.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 19, 2022 at 06:25:19PM +0800, Slark Xiao wrote:
> For default mechanism, product would use default MRU 3500 if
> they didn't define it. But for Foxconn SDX55, there is a known

s/"Foxconn SDX55"/"MV31-W (Cinterion)"/g

Will fix it while applying.

> issue which MRU 3500 would lead to data connection lost.
> So we align it with Qualcomm default MRU settings.
> We also validate it with Cinterion product and find it also
> works.
> 
> Fixes: 87693e092bd0 ("bus: mhi: pci_generic: Add Cinterion MV31-W PCIe to MHI")
> Signed-off-by: Slark Xiao <slark_xiao@163.com>

Reviewed-by: Manivannan Sadhasivam <mani@kernel.org>

Thanks,
Mani

> ---
>  drivers/bus/mhi/pci_generic.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/bus/mhi/pci_generic.c b/drivers/bus/mhi/pci_generic.c
> index 3a258a677df8..79c16b2a52c7 100644
> --- a/drivers/bus/mhi/pci_generic.c
> +++ b/drivers/bus/mhi/pci_generic.c
> @@ -401,6 +401,7 @@ static const struct mhi_pci_dev_info mhi_mv31_info = {
>  	.config = &modem_mv31_config,
>  	.bar_num = MHI_PCI_DEFAULT_BAR_NUM,
>  	.dma_data_width = 32,
> +	.mru_default = 32768,
>  };
>  
>  static const struct mhi_channel_config mhi_sierra_em919x_channels[] = {
> -- 
> 2.25.1
> 
