Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 34C0E4E6E16
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Mar 2022 07:04:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353832AbiCYGFe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Mar 2022 02:05:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35402 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237959AbiCYGFc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Mar 2022 02:05:32 -0400
Received: from mail-pj1-x102d.google.com (mail-pj1-x102d.google.com [IPv6:2607:f8b0:4864:20::102d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9992D7D01A
        for <linux-kernel@vger.kernel.org>; Thu, 24 Mar 2022 23:03:57 -0700 (PDT)
Received: by mail-pj1-x102d.google.com with SMTP id m22so6697215pja.0
        for <linux-kernel@vger.kernel.org>; Thu, 24 Mar 2022 23:03:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=LhShCTyJix25hq+Gg0P/VVyKpEibeGlZ7bcArAjiUFo=;
        b=ofHA8XTEA9/FKIJqMo631J1fRsWcscPnskTUZ5bvA4RoKhl8Td+cJEDQv5b9VyEaNQ
         8SyMQiu38zFAUZQfxsPBpyC7rej/ifJJeA/ogcfbYtAaxl8B8qUOEw/CwGsck65SDd9O
         gMoWEfVsHQLSOE/C31okXfLaVYU3mesqrJLV6ncsP15+qVGutW/idvPmA9G7OBT4NEMy
         pVoNx+hu8H6treHlsFHH80rS4DIskzq40xinSG2KO2R1LlFZl6j+udMnhRVVvMx26yHl
         3KjeXuV8FcCkkzQoYlLF23qYUKzvVmExw/a6juf9a/SwUSowPyuW2xvvqMmzeZbccKe6
         09XQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=LhShCTyJix25hq+Gg0P/VVyKpEibeGlZ7bcArAjiUFo=;
        b=d+O6Cvb0jaLH4O7l1Hap85hLPAWcDg/RGFybinw+O/vLtcyZZfWqOV68tzBNDmuOh3
         kmhu1eGQl91ERFFXVmQFAVoKwrEtDCKrRmWKO+qFUKZve64RwhGIlk/WkF90stCo0bPg
         Vu/X6GdNejdttbMC5B4guluWbU/Vuc8by5S6sATnu+sVDuaNCNc4houW5m0HU6UGVw9y
         WESV/zea9gZUo1nne68r85rD/jNVLbhcSoOJxzWZwxKB5+hXx3c59WLfi/j5HaGINhGG
         wGjBuOXEBOZel+1+aCCulV29EKY2IcGnFeNDuM5VgeCIEoZI/sDig/lN9xGXtUE6HVf5
         xXVw==
X-Gm-Message-State: AOAM531v2SJvfc/JLQ4mU7NbDUNeBigJxjm6Ld8WTE20hnOAZfoa2oAf
        3/T3s5EI9cLHqhO9Tb4eetO+
X-Google-Smtp-Source: ABdhPJwTAQR1vWgHnkgkyClvfuBdqLQ+oXGYaiggJeB9iKLzhWutBh4xCS3Xo4LIqDmuTB0gQ/tJwA==
X-Received: by 2002:a17:902:da90:b0:154:1510:acc7 with SMTP id j16-20020a170902da9000b001541510acc7mr9739603plx.103.1648188237001;
        Thu, 24 Mar 2022 23:03:57 -0700 (PDT)
Received: from thinkpad ([27.111.75.218])
        by smtp.gmail.com with ESMTPSA id pg14-20020a17090b1e0e00b001c75634df70sm11546767pjb.31.2022.03.24.23.03.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Mar 2022 23:03:56 -0700 (PDT)
Date:   Fri, 25 Mar 2022 11:33:49 +0530
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
Subject: Re: [PATCH 15/25] dmaengine: dw-edma: Convert DebugFS descs to being
 kz-allocated
Message-ID: <20220325060349.GA4675@thinkpad>
References: <20220324014836.19149-1-Sergey.Semin@baikalelectronics.ru>
 <20220324014836.19149-16-Sergey.Semin@baikalelectronics.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220324014836.19149-16-Sergey.Semin@baikalelectronics.ru>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 24, 2022 at 04:48:26AM +0300, Serge Semin wrote:
> Currently all the DW eDMA DebugFS nodes descriptors are allocated on
> stack, while the DW eDMA driver private data and CSR limits are statically
> preserved. Such design won't work for the multi-eDMA platforms.

Can you please explain why?

> As a
> preparation to adding the multi-eDMA system setups support we need to have
> each DebugFS node separately allocated and described. Afterwards we'll put
> an addition info there like Read/Write channel flag, channel ID, DW eDMA
> private data reference.
> 
> Note this conversion is mainly required due to having the legacy DW eDMA
> controllers with indirect Read/Write channels context CSRs access. If we
> didn't need to have a synchronized access to these registers the DebugFS
> code of the driver would have been much simpler.
> 

I fail to understand how this change is beneficial or the exact issue.

> Signed-off-by: Serge Semin <Sergey.Semin@baikalelectronics.ru>
> ---
>  drivers/dma/dw-edma/dw-edma-v0-debugfs.c | 15 ++++++++++++---
>  1 file changed, 12 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/dma/dw-edma/dw-edma-v0-debugfs.c b/drivers/dma/dw-edma/dw-edma-v0-debugfs.c
> index afd519d9568b..7eb0147912fa 100644
> --- a/drivers/dma/dw-edma/dw-edma-v0-debugfs.c
> +++ b/drivers/dma/dw-edma/dw-edma-v0-debugfs.c
> @@ -53,7 +53,8 @@ struct dw_edma_debugfs_entry {
>  
>  static int dw_edma_debugfs_u32_get(void *data, u64 *val)
>  {
> -	void __iomem *reg = data;
> +	struct dw_edma_debugfs_entry __iomem *entry = data;

Why the entry has to be of __iomem?

Thanks,
Mani

> +	void __iomem *reg = entry->reg;
>  
>  	if (dw->chip->mf == EDMA_MF_EDMA_LEGACY &&
>  	    reg >= (void __iomem *)&regs->type.legacy.ch) {
> @@ -94,14 +95,22 @@ static int dw_edma_debugfs_u32_get(void *data, u64 *val)
>  }
>  DEFINE_DEBUGFS_ATTRIBUTE(fops_x32, dw_edma_debugfs_u32_get, NULL, "0x%08llx\n");
>  
> -static void dw_edma_debugfs_create_x32(const struct dw_edma_debugfs_entry entries[],
> +static void dw_edma_debugfs_create_x32(const struct dw_edma_debugfs_entry ini[],
>  				       int nr_entries, struct dentry *dir)
>  {
> +	struct dw_edma_debugfs_entry *entries;
>  	int i;
>  
> +	entries = devm_kcalloc(dw->chip->dev, nr_entries, sizeof(*entries),
> +			       GFP_KERNEL);
> +	if (!entries)
> +		return;
> +
>  	for (i = 0; i < nr_entries; i++) {
> +		entries[i] = ini[i];
> +
>  		debugfs_create_file_unsafe(entries[i].name, 0444, dir,
> -					   entries[i].reg, &fops_x32);
> +					   &entries[i], &fops_x32);
>  	}
>  }
>  
> -- 
> 2.35.1
> 
