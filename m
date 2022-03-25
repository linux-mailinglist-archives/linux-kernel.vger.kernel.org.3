Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9AB014E7D85
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Mar 2022 01:22:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231237AbiCYTlA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Mar 2022 15:41:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52218 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233356AbiCYTjx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Mar 2022 15:39:53 -0400
Received: from mail-qv1-xf30.google.com (mail-qv1-xf30.google.com [IPv6:2607:f8b0:4864:20::f30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 18AD525A48F
        for <linux-kernel@vger.kernel.org>; Fri, 25 Mar 2022 12:12:21 -0700 (PDT)
Received: by mail-qv1-xf30.google.com with SMTP id f3so6963782qvz.10
        for <linux-kernel@vger.kernel.org>; Fri, 25 Mar 2022 12:12:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=9q8qzRGX/I6ULeWXUH1e7URpHS7xgWEpM1Dcqq2f2Xg=;
        b=VIV6EOoGovRECd7Q8Je2FHkHsxmfxfcDtmMxPiDEasKoLYO96QTKdfBLwUgp4vZCNZ
         2SwHSNRvJ8kCbAb8QKH2mdUGcl8pmxq6nJe3NtKvRP1XtIBVd9I+vzOFlWHlMTDzexZs
         LHTZEy8FMgc/LTFQG6+yzNPO7/dTk4b6tEMy2tUaYYpvbfKVyozycGNF14F458ciO/qA
         Hudl/qVK/l+/4P+MuE06vNQPOew6KZHRy2ftPiWVgbCx06l0nPLFNpXrKkM6yB52h/G4
         FzEW45C6V2FPjEzULfGPQeAOihyjCLvEd8wB05ntr660JJyqTjERwUpgDwQogNUEvHho
         ICTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=9q8qzRGX/I6ULeWXUH1e7URpHS7xgWEpM1Dcqq2f2Xg=;
        b=YTP1hroKPvL3zzm4MJGjgiOvn9K+81EMWm0AeOs5t1wiGumLcEGIaGxVpnwkybumNa
         GAtwoASAprT3gY95ZWCY+Zp0EjC+kdqkUqPueHrLgXLtQ/hQixNu4bdhxOPxfj9IytDw
         zM/XUxB9cA3nk3lqNoACtWYwqvYL6StSschHBXTpsR96+lKNMvQJgCl95Zh81KQlVIqa
         dPFi5dcYA49GqaDw0FyA5J+AxiV2ZlAYXPOk8LihNLijruNSehov1fkWG8aUbajd82Ou
         rBzjdTw81kNzLcGfSoNvDlhzqcHrSxOuLp703lHdTFgnVQ7FZbMwhu4O/gZoeNMoydOe
         ZmLA==
X-Gm-Message-State: AOAM5334I1Eux2jkIck/Kq6G0vTXcWrWWmAyas6HnDz5sFM+/lIUXtG3
        DUd26+hqFfMcrOHZgv7EbRKk/90BACjK
X-Google-Smtp-Source: ABdhPJyjChuXch/nm5TN/atOUvcKrkFix1U4yQq6fMXElZzZXO0h/H5Tjb6RR0rnZEKwEglcxb4Jhg==
X-Received: by 2002:a17:902:ea04:b0:154:54f0:172b with SMTP id s4-20020a170902ea0400b0015454f0172bmr13097636plg.149.1648232110725;
        Fri, 25 Mar 2022 11:15:10 -0700 (PDT)
Received: from thinkpad ([117.193.209.11])
        by smtp.gmail.com with ESMTPSA id v8-20020a056a00148800b004fa9bd7ddc9sm7674093pfu.113.2022.03.25.11.15.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Mar 2022 11:15:10 -0700 (PDT)
Date:   Fri, 25 Mar 2022 23:45:03 +0530
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
Subject: Re: [PATCH 24/25] dmaengine: dw-edma: Skip cleanup procedure if no
 private data found
Message-ID: <20220325181503.GB12218@thinkpad>
References: <20220324014836.19149-1-Sergey.Semin@baikalelectronics.ru>
 <20220324014836.19149-25-Sergey.Semin@baikalelectronics.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220324014836.19149-25-Sergey.Semin@baikalelectronics.ru>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 24, 2022 at 04:48:35AM +0300, Serge Semin wrote:
> DW eDMA driver private data is preserved in the passed DW eDMA chip info
> structure. If either probe procedure failed or for some reason the passed
> info object doesn't have private data pointer initialized we need to halt
> the DMA device cleanup procedure in order to prevent possible system
> crashes.
> 

How come remove() could happen when probe() failed? If you hit this issue then
something else is utterly going wrong.

Thanks,
Mani

> Signed-off-by: Serge Semin <Sergey.Semin@baikalelectronics.ru>
> ---
>  drivers/dma/dw-edma/dw-edma-core.c | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/drivers/dma/dw-edma/dw-edma-core.c b/drivers/dma/dw-edma/dw-edma-core.c
> index ca5cd7c99571..b932682a8ba8 100644
> --- a/drivers/dma/dw-edma/dw-edma-core.c
> +++ b/drivers/dma/dw-edma/dw-edma-core.c
> @@ -1030,6 +1030,10 @@ int dw_edma_remove(struct dw_edma_chip *chip)
>  	struct dw_edma *dw = chip->dw;
>  	int i;
>  
> +	/* Skip removal if no private data found */
> +	if (!dw)
> +		return -ENODEV;
> +
>  	/* Disable eDMA */
>  	dw_edma_v0_core_off(dw);
>  
> -- 
> 2.35.1
> 
