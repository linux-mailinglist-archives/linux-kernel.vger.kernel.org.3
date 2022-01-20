Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B596B494755
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jan 2022 07:33:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1358755AbiATGcG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Jan 2022 01:32:06 -0500
Received: from mailgw01.mediatek.com ([60.244.123.138]:37972 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1358734AbiATGcA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Jan 2022 01:32:00 -0500
X-UUID: 3d966be7bc2f400a8fac4100e6b395ce-20220120
X-UUID: 3d966be7bc2f400a8fac4100e6b395ce-20220120
Received: from mtkmbs10n2.mediatek.inc [(172.21.101.183)] by mailgw01.mediatek.com
        (envelope-from <chunfeng.yun@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 1493656480; Thu, 20 Jan 2022 14:31:57 +0800
Received: from mtkcas11.mediatek.inc (172.21.101.40) by
 mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.2.792.15; Thu, 20 Jan 2022 14:31:56 +0800
Received: from mhfsdcap04 (10.17.3.154) by mtkcas11.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Thu, 20 Jan 2022 14:31:55 +0800
Message-ID: <b7d0e7572ce7f7958f579ac564d25cbfee497cdc.camel@mediatek.com>
Subject: Re: [PATCH][next] usb: xhci-mtk: Use struct_size() helper in
 create_sch_ep()
From:   Chunfeng Yun <chunfeng.yun@mediatek.com>
To:     "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        Mathias Nyman <mathias.nyman@intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Matthias Brugger <matthias.bgg@gmail.com>
CC:     <linux-usb@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <linux-hardening@vger.kernel.org>
Date:   Thu, 20 Jan 2022 14:31:55 +0800
In-Reply-To: <20220120015546.GA75917@embeddedor>
References: <20220120015546.GA75917@embeddedor>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5-0ubuntu0.18.04.2 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-MTK:  N
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2022-01-19 at 19:55 -0600, Gustavo A. R. Silva wrote:
> Make use of the struct_size() helper instead of an open-coded
> version,
> in order to avoid any potential type mistakes or integer overflows
> that,
> in the worst scenario, could lead to heap overflows.
> 
> Also, address the following sparse warnings:
> drivers/usb/host/xhci-mtk-sch.c:265:20: warning: using sizeof on a
> flexible structure
> 
> Link: https://github.com/KSPP/linux/issues/160
> Link: https://github.com/KSPP/linux/issues/174
> Signed-off-by: Gustavo A. R. Silva <gustavoars@kernel.org>
> ---
>  drivers/usb/host/xhci-mtk-sch.c | 7 +++----
>  1 file changed, 3 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/usb/host/xhci-mtk-sch.c b/drivers/usb/host/xhci-
> mtk-sch.c
> index edbfa82c6565..f3139ce7b0a9 100644
> --- a/drivers/usb/host/xhci-mtk-sch.c
> +++ b/drivers/usb/host/xhci-mtk-sch.c
> @@ -248,7 +248,6 @@ create_sch_ep(struct xhci_hcd_mtk *mtk, struct
> usb_device *udev,
>  	struct mu3h_sch_bw_info *bw_info;
>  	struct mu3h_sch_tt *tt = NULL;
>  	u32 len_bw_budget_table;
> -	size_t mem_size;
>  
>  	bw_info = get_bw_info(mtk, udev, ep);
>  	if (!bw_info)
> @@ -262,9 +261,9 @@ create_sch_ep(struct xhci_hcd_mtk *mtk, struct
> usb_device *udev,
>  	else
>  		len_bw_budget_table = 1;
>  
> -	mem_size = sizeof(struct mu3h_sch_ep_info) +
> -			len_bw_budget_table * sizeof(u32);
> -	sch_ep = kzalloc(mem_size, GFP_KERNEL);
> +	sch_ep = kzalloc(struct_size(sch_ep, bw_budget_table,
> +				     len_bw_budget_table),
> +			 GFP_KERNEL);
>  	if (!sch_ep)
>  		return ERR_PTR(-ENOMEM);
Acked-by: Chunfeng Yun <chunfeng.yun@mediatek.com>

Thanks a lot

>  

