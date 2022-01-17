Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0CFFD4901D3
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jan 2022 07:03:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234620AbiAQGD0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Jan 2022 01:03:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35090 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234597AbiAQGDW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jan 2022 01:03:22 -0500
Received: from mout-u-107.mailbox.org (mout-u-107.mailbox.org [IPv6:2001:67c:2050:1::465:107])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E30DEC06173F
        for <linux-kernel@vger.kernel.org>; Sun, 16 Jan 2022 22:03:21 -0800 (PST)
Received: from smtp202.mailbox.org (unknown [91.198.250.118])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-384) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mout-u-107.mailbox.org (Postfix) with ESMTPS id 4JchCp6LDzzQjkl;
        Mon, 17 Jan 2022 07:03:18 +0100 (CET)
X-Virus-Scanned: amavisd-new at heinlein-support.de
Message-ID: <506398f4-94a8-f2d4-999c-1c14863cd78f@denx.de>
Date:   Mon, 17 Jan 2022 07:03:14 +0100
MIME-Version: 1.0
Subject: Re: [PATCH] dmaengine: altera-msgdma: Remove useless DMA-32 fallback
 configuration
Content-Language: en-US
To:     Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        Olivier Dautricourt <olivier.dautricourt@orolia.com>,
        Vinod Koul <vkoul@kernel.org>
Cc:     linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org,
        dmaengine@vger.kernel.org
References: <01058ada3a0dea207212182ca7525060a204f1e1.1642232423.git.christophe.jaillet@wanadoo.fr>
From:   Stefan Roese <sr@denx.de>
In-Reply-To: <01058ada3a0dea207212182ca7525060a204f1e1.1642232423.git.christophe.jaillet@wanadoo.fr>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/15/22 08:40, Christophe JAILLET wrote:
> As stated in [1], dma_set_mask() with a 64-bit mask never fails if
> dev->dma_mask is non-NULL.
> So, if it fails, the 32 bits case will also fail for the same reason.
> 
> Simplify code and remove some dead code accordingly.
> 
> [1]: https://lore.kernel.org/linux-kernel/YL3vSPK5DXTNvgdx@infradead.org/#t
> 
> Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>

Reviewed-by: Stefan Roese <sr@denx.de>

Thanks,
Stefan

> ---
>   drivers/dma/altera-msgdma.c | 4 +---
>   1 file changed, 1 insertion(+), 3 deletions(-)
> 
> diff --git a/drivers/dma/altera-msgdma.c b/drivers/dma/altera-msgdma.c
> index f5b885d69cd3..6f56dfd375e3 100644
> --- a/drivers/dma/altera-msgdma.c
> +++ b/drivers/dma/altera-msgdma.c
> @@ -891,9 +891,7 @@ static int msgdma_probe(struct platform_device *pdev)
>   	ret = dma_set_mask_and_coherent(&pdev->dev, DMA_BIT_MASK(64));
>   	if (ret) {
>   		dev_warn(&pdev->dev, "unable to set coherent mask to 64");
> -		ret = dma_set_mask_and_coherent(&pdev->dev, DMA_BIT_MASK(32));
> -		if (ret)
> -			goto fail;
> +		goto fail;
>   	}
>   
>   	msgdma_reset(mdev);
> 

Viele Grüße,
Stefan Roese

-- 
DENX Software Engineering GmbH,      Managing Director: Wolfgang Denk
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany
Phone: (+49)-8142-66989-51 Fax: (+49)-8142-66989-80 Email: sr@denx.de
