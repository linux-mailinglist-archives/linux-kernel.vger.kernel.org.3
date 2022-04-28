Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5384C512E17
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Apr 2022 10:19:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344048AbiD1IV4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Apr 2022 04:21:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48398 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344022AbiD1IVv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Apr 2022 04:21:51 -0400
Received: from theia.8bytes.org (8bytes.org [81.169.241.247])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1EFD298F7C
        for <linux-kernel@vger.kernel.org>; Thu, 28 Apr 2022 01:18:31 -0700 (PDT)
Received: by theia.8bytes.org (Postfix, from userid 1000)
        id B9DF42FB; Thu, 28 Apr 2022 10:18:30 +0200 (CEST)
Date:   Thu, 28 Apr 2022 10:18:29 +0200
From:   Joerg Roedel <joro@8bytes.org>
To:     cgel.zte@gmail.com
Cc:     will@kernel.org, iommu@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org, Lv Ruyi <lv.ruyi@zte.com.cn>,
        Zeal Robot <zealci@zte.com.cn>
Subject: Re: [PATCH] iommu: add null pointer check
Message-ID: <YmpN1ZVZMrU9ZJ3e@8bytes.org>
References: <20220329055322.2375563-1-lv.ruyi@zte.com.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220329055322.2375563-1-lv.ruyi@zte.com.cn>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_PASS,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 29, 2022 at 05:53:22AM +0000, cgel.zte@gmail.com wrote:
> From: Lv Ruyi <lv.ruyi@zte.com.cn>
> 
> kmem_cache_zalloc is a memory allocation function which can return NULL
> when some internal memory errors happen. Add null pointer check to avoid
> dereferencing null pointer.
> 
> Reported-by: Zeal Robot <zealci@zte.com.cn>
> Signed-off-by: Lv Ruyi <lv.ruyi@zte.com.cn>
> ---
>  drivers/iommu/fsl_pamu_domain.c | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/drivers/iommu/fsl_pamu_domain.c b/drivers/iommu/fsl_pamu_domain.c
> index 69a4a62dc3b9..43849c027298 100644
> --- a/drivers/iommu/fsl_pamu_domain.c
> +++ b/drivers/iommu/fsl_pamu_domain.c
> @@ -152,6 +152,10 @@ static void attach_device(struct fsl_dma_domain *dma_domain, int liodn, struct d
>  	}
>  
>  	info = kmem_cache_zalloc(iommu_devinfo_cache, GFP_ATOMIC);
> +	if (!info) {
> +		spin_unlock_irqrestore(&device_domain_lock, flags);
> +		return;
> +	}

Such errors need to be propagated.

