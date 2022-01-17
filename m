Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AF896490C11
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jan 2022 17:07:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237623AbiAQQHM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Jan 2022 11:07:12 -0500
Received: from dfw.source.kernel.org ([139.178.84.217]:49994 "EHLO
        dfw.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235180AbiAQQHM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jan 2022 11:07:12 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 8AA4161034;
        Mon, 17 Jan 2022 16:07:11 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3CD6EC36AE3;
        Mon, 17 Jan 2022 16:07:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1642435631;
        bh=savEbw0Fq5jjf0eRzSMg5CUeza/UcrBnw+kG0Zx0SQA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=qAGiC9WQQQRyt4g9rn98cyXAzcF1q1Xg9AGoWlQE+ukoM49QGVXM/MCvPNt+T6Ily
         AIBHiC9Ft8zm7rNCfuWmXK5ND4/YGdCCe2GM6UvCXPt+0ff3xwvAjffpyWOAc1P2px
         5nmcNhoKVfAZo7+Kn1P5LLY8mFjvcoNNvSFHSAyHtWz4RC79cNerjR/msPFwQw6lWB
         1RRRkzo8waubeN9xphJUEJ75CodbF7hIrSZ9lyYVkuxEXoMf0vOMpt1cZqA/i0EdpU
         3W48TMw8uO54uuaCEfwkRK3yrJWIN3jQtzjN3k6dYU83CH6pLAWhgruEpWuYtJk5ib
         CJhcQP/xSYUeg==
Date:   Mon, 17 Jan 2022 21:37:05 +0530
From:   Manivannan Sadhasivam <mani@kernel.org>
To:     Slark Xiao <slark_xiao@163.com>
Cc:     hemantk@codeaurora.org, mhi@lists.linux.dev,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: Re: [PATCH net v2] For default mechanism, product would use
 default MRU 3500 if they didn't define it. But for Foxconn SDX55, there is a
 known issue which MRU 3500 would lead to data connection lost. So we align
 it with Qualcomm default MRU settings.
Message-ID: <20220117160705.GC4209@thinkpad>
References: <20220117081644.21121-1-slark_xiao@163.com>
 <20220117084432.GB4209@thinkpad>
 <50e92997.386b.17e6775c20b.Coremail.slark_xiao@163.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <50e92997.386b.17e6775c20b.Coremail.slark_xiao@163.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 17, 2022 at 05:54:37PM +0800, Slark Xiao wrote:
> 
> 
> 
> 
> 
> 
> At 2022-01-17 16:44:32, "Manivannan Sadhasivam" <mani@kernel.org> wrote:
> >On Mon, Jan 17, 2022 at 04:16:44PM +0800, Slark Xiao wrote:
> >> Fixes: 5c2c85315948 ("bus: mhi: pci-generic: configurable network interface MRU")
> >
> >You have messed up the patch subject, please fix it. Also, the correct fixes tag
> >should be the one added the Foxconn modem support, precisely "aac426562f56".
> >
> Yes, sorry for this mistake. 
> >One more thing, please make sure this MRU value works well for other Foxconn
> >modems supported by this config.
> >
> I am sure this would work for all  our device. BTW, I want to add this mru_default to 
> cinterion-mv31 PRODUCT. Shall I use v3 or create a new version for that? It's confirmed 
> that this change could help fix issue on that product.

Please submit individual patches with Fixes tag each.

> >> Signed-off-by: Slark Xiao <slark_xiao@163.com>
> >
> >You should have added my Reviewed-by tag too...
> Shall I add reviewd-by tag if I add changes on MV31 product?
> >

No, only to this patch since I haven't reviewed the MV31 patch.

Thanks,
Mani

> >Thanks,
> >Mani
> >
> >> 
> >> ---
> >> v2: Add Fixes tag
> >> ---
> >>  drivers/bus/mhi/pci_generic.c | 1 +
> >>  1 file changed, 1 insertion(+)
> >> 
> >> diff --git a/drivers/bus/mhi/pci_generic.c b/drivers/bus/mhi/pci_generic.c
> >> index 3a258a677df8..74e8fc342cfd 100644
> >> --- a/drivers/bus/mhi/pci_generic.c
> >> +++ b/drivers/bus/mhi/pci_generic.c
> >> @@ -366,6 +366,7 @@ static const struct mhi_pci_dev_info mhi_foxconn_sdx55_info = {
> >>  	.config = &modem_foxconn_sdx55_config,
> >>  	.bar_num = MHI_PCI_DEFAULT_BAR_NUM,
> >>  	.dma_data_width = 32,
> >> +	.mru_default = 32768,
> >>  	.sideband_wake = false,
> >>  };
> >>  
> >> -- 
> >> 2.25.1
> >> 
