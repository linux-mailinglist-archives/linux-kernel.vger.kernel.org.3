Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 18C02598AB0
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Aug 2022 19:49:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345113AbiHRRs0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 Aug 2022 13:48:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47958 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240100AbiHRRsV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Aug 2022 13:48:21 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D26DDF4B;
        Thu, 18 Aug 2022 10:48:19 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id EBEDC6172F;
        Thu, 18 Aug 2022 17:48:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F1F13C433C1;
        Thu, 18 Aug 2022 17:48:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1660844898;
        bh=udomEyyFxdEYeJSomBe9t/Lqt0I7Cxz89UK62m0Wvw8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Br7DMj0OTnbMu5MA/Vo9QfrhjNhiI0219bY6t+oWXGFdvlEO1qE6Rd21K2bWtYkAL
         EBzjFObkmkG/Mn2pM0Gmhq1BtKqr2SfCJtaGvB58WWUZAQy/Rw9P00tJvWmEK4PY4B
         kFLHI2g77BvnlRezTbo9dVrWsqjiiq+WuVHYFCVs=
Date:   Thu, 18 Aug 2022 19:48:15 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Chunfeng Yun <chunfeng.yun@mediatek.com>
Cc:     Mathias Nyman <mathias.nyman@intel.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Ikjoon Jang <ikjn@chromium.org>, linux-usb@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
        Eddie Hung <eddie.hung@mediatek.com>
Subject: Re: [PATCH v2 1/2] usb: xhci-mtk: relax TT periodic bandwidth
 allocation
Message-ID: <Yv57X37JcYCBhabS@kroah.com>
References: <20220805060328.6189-1-chunfeng.yun@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220805060328.6189-1-chunfeng.yun@mediatek.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 05, 2022 at 02:03:27PM +0800, Chunfeng Yun wrote:
> Currently uses the worst case byte budgets on FS/LS bus bandwidth,
> for example, for an isochronos IN endpoint with 192 bytes budget, it
> will consume the whole 5 uframes(188 * 5) while the actual FS bus
> budget should be just 192 bytes. It cause that many usb audio headsets
> with 3 interfaces (audio input, audio output, and HID) cannot be
> configured.
> To improve it, changes to use "approximate" best case budget for FS/LS
> bandwidth management. For the same endpoint from the above example,
> the approximate best case budget is now reduced to (188 * 2) bytes.
> 
> Signed-off-by: Chunfeng Yun <chunfeng.yun@mediatek.com>
> ---
> v2: change commit message
> ---
>  drivers/usb/host/xhci-mtk-sch.c | 11 ++---------
>  1 file changed, 2 insertions(+), 9 deletions(-)
> 
> diff --git a/drivers/usb/host/xhci-mtk-sch.c
>  b/drivers/usb/host/xhci-mtk-sch.c
> index 06a6b19acaae..a17bc584ee99 100644
> --- a/drivers/usb/host/xhci-mtk-sch.c
> +++ b/drivers/usb/host/xhci-mtk-sch.c
> @@ -425,7 +425,6 @@ static int check_fs_bus_bw(struct mu3h_sch_ep_info
>  *sch_ep, int offset)
>  
>  static int check_sch_tt(struct mu3h_sch_ep_info *sch_ep, u32 offset)
>  {
> -	u32 extra_cs_count;
>  	u32 start_ss, last_ss;
>  	u32 start_cs, last_cs;
>  
> @@ -461,18 +460,12 @@ static int check_sch_tt(struct mu3h_sch_ep_info
>  *sch_ep, u32 offset)
>  		if (last_cs > 7)
>  			return -ESCH_CS_OVERFLOW;
>  
> -		if (sch_ep->ep_type == ISOC_IN_EP)
> -			extra_cs_count = (last_cs == 7) ? 1 : 2;
> -		else /*  ep_type : INTR IN / INTR OUT */
> -			extra_cs_count = 1;
> -
> -		cs_count += extra_cs_count;
>  		if (cs_count > 7)
>  			cs_count = 7; /* HW limit */
>  
>  		sch_ep->cs_count = cs_count;
> -		/* one for ss, the other for idle */
> -		sch_ep->num_budget_microframes = cs_count + 2;
> +		/* ss, idle are ignored */
> +		sch_ep->num_budget_microframes = cs_count;
>  
>  		/*
>  		 * if interval=1, maxp >752, num_budge_micoframe is larger
> -- 
> 2.18.0
> 

This doesn't apply to my tree without fuzz, and when I force it, I get a
build error.  Can you please rebase against 6.0-rc1 and resend?

thanks,

greg k-h
