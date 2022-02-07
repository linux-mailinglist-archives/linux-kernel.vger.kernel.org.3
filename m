Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7D9CA4AB6D8
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Feb 2022 09:46:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245037AbiBGIoi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Feb 2022 03:44:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35256 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241038AbiBGIkQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Feb 2022 03:40:16 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1FAB4C043181;
        Mon,  7 Feb 2022 00:40:15 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A6DD361137;
        Mon,  7 Feb 2022 08:40:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F3CDEC004E1;
        Mon,  7 Feb 2022 08:40:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1644223214;
        bh=OXu4ePF9KnYMXzbzhryuJjA+Qn2NlR5TcqjF8HO8C1k=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=XOKg1tHXXyriKEFLh5p1wdnUqD8okrg/yiG277ztoueOy+HUbu3BTM7esXttteLqc
         /xEpc3ZVmxG3JaAk0YypUx3Pae73MsXwEcPVrMTXmf8KaXTmg8DvrgufdWwbPI0/6d
         kmdEPaM+CvRH3dwveMFzmYwKmqiGsmhHK/rq+fqqKM2X0iZ7PMOVxP5h8A2q0DGp5W
         vtMqrcgzYMs9vzmmdInh/Ql7ogC56Upl9kbg8UN7v2pNcozbJnLmi+L4aVHlSxb6sI
         maSOv4KaBsdo32ETV936V5isjB1Kr7SIMN+XH6gKwLyPAf4dCs/tYI3xiTpeH+xME1
         qrTu2tpCBCZkw==
Date:   Mon, 7 Feb 2022 14:10:07 +0530
From:   Manivannan Sadhasivam <mani@kernel.org>
To:     Yonglin Tan <yonglin.tan@outlook.com>
Cc:     hemantk@codeaurora.org, mhi@lists.linux.dev,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] bus: mhi: Add mru_default for Quectel EM1xx series
 modules.
Message-ID: <20220207084007.GE1905@thinkpad>
References: <MEYP282MB2374C10BC162393B39D78294FD229@MEYP282MB2374.AUSP282.PROD.OUTLOOK.COM>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <MEYP282MB2374C10BC162393B39D78294FD229@MEYP282MB2374.AUSP282.PROD.OUTLOOK.COM>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 28, 2022 at 01:24:04PM +0800, Yonglin Tan wrote:
> For default mechanism, the driver uses default MRU 3500 if mru_default
> is not initialized. The Qualcomm configured the MRU size to 32768 in the
> WWAN device FW. So, we align the driver setting with Qualcomm FW setting.
> 
> Signed-off-by: Yonglin Tan <yonglin.tan@outlook.com>

Please add the Fixes tag for commit ac4bf60bbaa0 and CC stable list.

Also the subject should be:
"bus: mhi: pci_generic: Add mru_default for Quectel EM1xx series"

With that,
Reviewed-by: Manivannan Sadhasivam <mani@kernel.org>

Thanks,
Mani

> ---
>  drivers/bus/mhi/pci_generic.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/bus/mhi/pci_generic.c b/drivers/bus/mhi/pci_generic.c
> index b798958..9527b7d 100644
> --- a/drivers/bus/mhi/pci_generic.c
> +++ b/drivers/bus/mhi/pci_generic.c
> @@ -327,6 +327,7 @@ static const struct mhi_pci_dev_info mhi_quectel_em1xx_info = {
>  	.config = &modem_quectel_em1xx_config,
>  	.bar_num = MHI_PCI_DEFAULT_BAR_NUM,
>  	.dma_data_width = 32,
> +	.mru_default = 32768,
>  	.sideband_wake = true,
>  };
>  
> -- 
> 2.7.4
> 
