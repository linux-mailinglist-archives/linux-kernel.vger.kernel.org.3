Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 20E75473100
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Dec 2021 16:59:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240247AbhLMP7u (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Dec 2021 10:59:50 -0500
Received: from fllv0015.ext.ti.com ([198.47.19.141]:51932 "EHLO
        fllv0015.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232987AbhLMP7t (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Dec 2021 10:59:49 -0500
Received: from fllv0035.itg.ti.com ([10.64.41.0])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 1BDFxUE3123019;
        Mon, 13 Dec 2021 09:59:30 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1639411170;
        bh=XwlN2vUIJ/kuSsvEp4gbGeljEYGLTZNc/OAIavCBqRQ=;
        h=Date:From:To:CC:Subject:References:In-Reply-To;
        b=N2Uxz4217r0eQv/YhsVhzs8JOkZm5KlA5q9pCavcJ8GemahBfIowZgiplyAK1nNrX
         86Ai8MCgiwAl/ifCXiQPTf9LBXR4N50qrg6Aoy37hXRn6KYRngB+UjB8uyBj813RNV
         YgYJDjltmbqUIwnU1DTHRHEavIUN62VJE2af9Dl4=
Received: from DFLE100.ent.ti.com (dfle100.ent.ti.com [10.64.6.21])
        by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 1BDFxUd7091219
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 13 Dec 2021 09:59:30 -0600
Received: from DFLE111.ent.ti.com (10.64.6.32) by DFLE100.ent.ti.com
 (10.64.6.21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2308.14; Mon, 13
 Dec 2021 09:59:30 -0600
Received: from lelv0326.itg.ti.com (10.180.67.84) by DFLE111.ent.ti.com
 (10.64.6.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2308.14 via
 Frontend Transport; Mon, 13 Dec 2021 09:59:30 -0600
Received: from localhost (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0326.itg.ti.com (8.15.2/8.15.2) with ESMTP id 1BDFxU81052740;
        Mon, 13 Dec 2021 09:59:30 -0600
Date:   Mon, 13 Dec 2021 09:59:30 -0600
From:   Nishanth Menon <nm@ti.com>
To:     Miaoqian Lin <linmq006@gmail.com>
CC:     Santosh Shilimkar <ssantosh@kernel.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>
Subject: Re: [PATCH] soc: ti: Fix NULL vs IS_ERR() checking in dma_init
Message-ID: <20211213155930.mcxlc5m3niqh77xi@annotate>
References: <20211212071301.3011-1-linmq006@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20211212071301.3011-1-linmq006@gmail.com>
User-Agent: NeoMutt/20171215
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 07:13-20211212, Miaoqian Lin wrote:
> Since devm_ioremap_resource() function return error pointers.
> The pktdma_get_regs() function does not return NULL, It return error
> pointers too. Using IS_ERR() to check the return value to fix this.

Thanks.. but..
> 
> Signed-off-by: Miaoqian Lin <linmq006@gmail.com>
> ---
>  drivers/soc/ti/knav_dma.c | 20 ++++++++++----------
>  1 file changed, 10 insertions(+), 10 deletions(-)
> 
> diff --git a/drivers/soc/ti/knav_dma.c b/drivers/soc/ti/knav_dma.c
> index 591d14ebcb11..9f82cf906949 100644
> --- a/drivers/soc/ti/knav_dma.c
> +++ b/drivers/soc/ti/knav_dma.c
> @@ -646,31 +646,31 @@ static int dma_init(struct device_node *cloud, struct device_node *dma_node)
>  	}

[...]

>  
>  	dma->reg_tx_chan = pktdma_get_regs(dma, node, 1, &size);
> -	if (!dma->reg_tx_chan)
> -		return -ENODEV;
> +	if (IS_ERR(dma->reg_tx_cha))
> +		return PTR_ERR(dma->reg_tx_cha);

Did you mean reg_tx_chan instead of reg_tx_cha ?


-- 
Regards,
Nishanth Menon
Key (0xDDB5849D1736249D)/Fingerprint: F8A2 8693 54EB 8232 17A3  1A34 DDB5 849D 1736 249D
