Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4EBCD4E6798
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Mar 2022 18:15:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352185AbiCXRQy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Mar 2022 13:16:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41988 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240788AbiCXRQx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Mar 2022 13:16:53 -0400
Received: from mail-pj1-x102b.google.com (mail-pj1-x102b.google.com [IPv6:2607:f8b0:4864:20::102b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C3FE7B188F
        for <linux-kernel@vger.kernel.org>; Thu, 24 Mar 2022 10:15:20 -0700 (PDT)
Received: by mail-pj1-x102b.google.com with SMTP id l4-20020a17090a49c400b001c6840df4a3so5758093pjm.0
        for <linux-kernel@vger.kernel.org>; Thu, 24 Mar 2022 10:15:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=XWV/NU9KBDK+6NrxZTVbhSQcmAs/2MmqDrZDpchQ340=;
        b=ixCpJFtXz7n5lU0fj9BgLDP7UC3OMn8q9JBDP5g98XPWInsmFxPmbvXze0gWL3kvos
         1QGYzP3u5O2ZU7ozLqiD6gvXMsg2XfWPmV9asM48DF0qw2h4qMbHKcDEaK8vTKLa6v88
         J9FWnRtsNBe8ch/pOmydHp6kZAuUlo2luEiTZNWEAFJR/dUEbjs79SbkCWcWQy84Qd5j
         OBHBjavgjpBh6LSWKsxkWL2GiKYHQRD6QB6h1jUXlvh1YZcLGfxxdHX6YPcBzlZFCOqY
         un6peG8v7y5K4x3J105drZE5rLKBikz356aElBa7RFteeRAOAcAbbj8YChKdlhQd3ESv
         qUHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=XWV/NU9KBDK+6NrxZTVbhSQcmAs/2MmqDrZDpchQ340=;
        b=kDE9dQzixsfSOxWHY4AI0G0uj294dBD4d8uHDu4PX+X9BDRqoCdrE+LWOvuvhrwvJv
         zacWajq5AimfTSqulPdTIXmGUNHtPfrECufkaI+94rJKFTy9Hbj2MzSqD0m3BxMKGyMP
         SePOWTf5gb6B2ixYMk4VVerN0crWP45wF1BKyiQccAnmR2vILeT+izMu1k0zTI+7H2rG
         c6wxiIKYYHjZlFAzazMaa8TauXYInzI9Qf5r7S67HX2z/7b9w82O2N+PMvykRo4eLqVa
         VHNrC5bL5skYHudiTNqTZVCFyOV+kGpH5zoyyfdaUtVd+bCO2xiSBnikQBQLHrEhkUBQ
         UDDw==
X-Gm-Message-State: AOAM531nIOKz8Hst/6J51+YqiBrSjpPV5nymbq8gDXpqEcMCpc8SaOB4
        yuofDQ7bijPVUbnFKg9jincV
X-Google-Smtp-Source: ABdhPJx3paZ+Kg390H0v1ZUeHXIdxQXx4drh90s6/ujRUve2+kXpx5NrwOSnlaSW3pdBF9MN3log9g==
X-Received: by 2002:a17:90a:168f:b0:1b9:453a:fe79 with SMTP id o15-20020a17090a168f00b001b9453afe79mr19700814pja.107.1648142120256;
        Thu, 24 Mar 2022 10:15:20 -0700 (PDT)
Received: from thinkpad ([27.111.75.218])
        by smtp.gmail.com with ESMTPSA id h6-20020a636c06000000b00363a2533b17sm3063524pgc.8.2022.03.24.10.15.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Mar 2022 10:15:19 -0700 (PDT)
Date:   Thu, 24 Mar 2022 22:45:12 +0530
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     Serge Semin <Sergey.Semin@baikalelectronics.ru>
Cc:     Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
        Vinod Koul <vkoul@kernel.org>,
        Jingoo Han <jingoohan1@gmail.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Frank Li <Frank.Li@nxp.com>,
        Serge Semin <fancer.lancer@gmail.com>,
        Alexey Malahov <Alexey.Malahov@baikalelectronics.ru>,
        Pavel Parkhomenko <Pavel.Parkhomenko@baikalelectronics.ru>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Rob Herring <robh@kernel.org>,
        Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
        linux-pci@vger.kernel.org, dmaengine@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 07/25] dmaengine: dw-edma: Don't permit non-inc
 interleaved xfers
Message-ID: <20220324171512.GQ2854@thinkpad>
References: <20220324014836.19149-1-Sergey.Semin@baikalelectronics.ru>
 <20220324014836.19149-8-Sergey.Semin@baikalelectronics.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220324014836.19149-8-Sergey.Semin@baikalelectronics.ru>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 24, 2022 at 04:48:18AM +0300, Serge Semin wrote:
> DW eDMA controller always increments both source and destination
> addresses. Permitting DMA interleaved transfers with no src_inc/dst_inc
> flags set may lead to unexpected behaviour for the device users. Let's fix
> that by terminating the interleaved transfers if at least one of the
> dma_interleaved_template.{src_inc,dst_inc} flag is initialized with false
> value. Note in addition to that we need we need to increase the source and
> destination addresses accordingly after each iteration.
> 

Can you please point me where this gets documented in databook?

Thanks,
Mani

> Fixes: 85e7518f42c8 ("dmaengine: dw-edma: Add device_prep_interleave_dma() support")
> Signed-off-by: Serge Semin <Sergey.Semin@baikalelectronics.ru>
> ---
>  drivers/dma/dw-edma/dw-edma-core.c | 12 ++++++------
>  1 file changed, 6 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/dma/dw-edma/dw-edma-core.c b/drivers/dma/dw-edma/dw-edma-core.c
> index 2010d7f8191f..f41bde27795c 100644
> --- a/drivers/dma/dw-edma/dw-edma-core.c
> +++ b/drivers/dma/dw-edma/dw-edma-core.c
> @@ -386,6 +386,8 @@ dw_edma_device_transfer(struct dw_edma_transfer *xfer)
>  			return NULL;
>  		if (xfer->xfer.il->numf > 0 && xfer->xfer.il->frame_size > 0)
>  			return NULL;
> +		if (!xfer->xfer.il->src_inc || !xfer->xfer.il->dst_inc)
> +			return NULL;
>  	} else {
>  		return NULL;
>  	}
> @@ -485,15 +487,13 @@ dw_edma_device_transfer(struct dw_edma_transfer *xfer)
>  			struct dma_interleaved_template *il = xfer->xfer.il;
>  			struct data_chunk *dc = &il->sgl[i];
>  
> -			if (il->src_sgl) {
> -				src_addr += burst->sz;
> +			src_addr += burst->sz;
> +			if (il->src_sgl)
>  				src_addr += dmaengine_get_src_icg(il, dc);
> -			}
>  
> -			if (il->dst_sgl) {
> -				dst_addr += burst->sz;
> +			dst_addr += burst->sz;
> +			if (il->dst_sgl)
>  				dst_addr += dmaengine_get_dst_icg(il, dc);
> -			}
>  		}
>  	}
>  
> -- 
> 2.35.1
> 
