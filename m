Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C83A34E62FE
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Mar 2022 13:13:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349974AbiCXMOt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Mar 2022 08:14:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40352 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239286AbiCXMOp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Mar 2022 08:14:45 -0400
Received: from mail-pl1-x632.google.com (mail-pl1-x632.google.com [IPv6:2607:f8b0:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8FAE3BE3B
        for <linux-kernel@vger.kernel.org>; Thu, 24 Mar 2022 05:13:12 -0700 (PDT)
Received: by mail-pl1-x632.google.com with SMTP id g3so4503635plo.6
        for <linux-kernel@vger.kernel.org>; Thu, 24 Mar 2022 05:13:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=Xl1mC6PbzMnFsI+v5sBw1bmmFK2u7TIp7uztHSDF11M=;
        b=Z7gkDEgEwX2MFq1RXHTDWu9NynVhi4kMvsYLWy2TNRnDG7A23UGQkCRpjZNwM40xM7
         H/XLg2fTjDV4DDLXNcwnOdQe/v86CJ34bwkZOmCuISgLuJlkB0ti0fPjz6UYsKUtWSWD
         +LsgzMmfLQwB3huXSfLGeUQQyiO1agsOHpSmoEUEAStvNYFO4SQssXEquP4rFtwaj1iH
         9+mawBfax7PzalW1m86UcIknYojN4ncAjRiIJbzXfjUFxCCqftqzvyN9BkFA6XTStF46
         4/Z1xDQf/BxpHaZ/rfImYiTcxxJZXeZO7aEL/Lou1WDrDVVDh3A1CZUOR2Bwp5QC6sqZ
         FkLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=Xl1mC6PbzMnFsI+v5sBw1bmmFK2u7TIp7uztHSDF11M=;
        b=WNopQoCyANqq4KcwW1Duh6dyOdxI9Xh9iJl9YM6DB8cCIHfhy2DhB5H1fILP4ivGD6
         C3nlFGP4B4zyCGL8w0DHXFrzSeBkgfjyM7eH8kQiI6L4HIjkc0A23UYOIKrON+6HsH1v
         LE4nXVt79xXLO2Scg8APfYZNp5EF9WINwpfzywtXj01H3yqg5oMHqbciCCp923T6I/sz
         nMcztuHMbdF583KVnXTPjP5F+cElYV4+0MaE9CUTRyXkdHEVO3OTuWtLALFrIa5ewJnp
         yRZFhAtGSatcs9PA4KSqzPU1l4xtHE25ayzjvIgh08rg/UbsOnCIGmRiqYDE4ztLP4Hx
         iCZw==
X-Gm-Message-State: AOAM531bbJ0e9GaTMsKU8vZ0MAEUUwSbQ2I3XtPJmnrBbnbtLcJTakzj
        49Yt7C3cv0yHCuvdkSPDMrai
X-Google-Smtp-Source: ABdhPJw3jkLtYM5wwwr1LLr6SoNvdyRBVfqxxlm1uh8eEUB4AHguTpOzun2ZSPO/98jTVzBcX7DNhg==
X-Received: by 2002:a17:90b:4d82:b0:1c7:438d:241f with SMTP id oj2-20020a17090b4d8200b001c7438d241fmr18386615pjb.161.1648123992005;
        Thu, 24 Mar 2022 05:13:12 -0700 (PDT)
Received: from thinkpad ([220.158.158.107])
        by smtp.gmail.com with ESMTPSA id t26-20020a056a00139a00b004faa13ba384sm3561816pfg.162.2022.03.24.05.13.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Mar 2022 05:13:11 -0700 (PDT)
Date:   Thu, 24 Mar 2022 17:43:06 +0530
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     Serge Semin <Sergey.Semin@baikalelectronics.ru>
Cc:     Jingoo Han <jingoohan1@gmail.com>,
        Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Rob Herring <robh@kernel.org>,
        Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
        Serge Semin <fancer.lancer@gmail.com>,
        Alexey Malahov <Alexey.Malahov@baikalelectronics.ru>,
        Pavel Parkhomenko <Pavel.Parkhomenko@baikalelectronics.ru>,
        Frank Li <Frank.Li@nxp.com>, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 06/12] PCI: dwc: Add braces to the multi-line if-else
 statements
Message-ID: <20220324121306.GF2854@thinkpad>
References: <20220324012524.16784-1-Sergey.Semin@baikalelectronics.ru>
 <20220324012524.16784-7-Sergey.Semin@baikalelectronics.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220324012524.16784-7-Sergey.Semin@baikalelectronics.ru>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 24, 2022 at 04:25:17AM +0300, Serge Semin wrote:
> In accordance with [1] if there is at least one multi-line if-else
> clause in the statement, then each clause will need to be surrounded by
> the braces. The driver code violates that coding style rule in a few
> places. Let's fix it.
> 
> [1] Documentation/process/coding-style.rst
> 
> Signed-off-by: Serge Semin <Sergey.Semin@baikalelectronics.ru>

Reviewed-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>

Thanks,
Mani

> ---
>  drivers/pci/controller/dwc/pcie-designware-ep.c | 4 ++--
>  drivers/pci/controller/dwc/pcie-designware.c    | 3 ++-
>  2 files changed, 4 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/pci/controller/dwc/pcie-designware-ep.c b/drivers/pci/controller/dwc/pcie-designware-ep.c
> index 0eda8236c125..7c9315fffe24 100644
> --- a/drivers/pci/controller/dwc/pcie-designware-ep.c
> +++ b/drivers/pci/controller/dwc/pcie-designware-ep.c
> @@ -699,9 +699,9 @@ int dw_pcie_ep_init(struct dw_pcie_ep *ep)
>  
>  	if (!pci->dbi_base2) {
>  		res = platform_get_resource_byname(pdev, IORESOURCE_MEM, "dbi2");
> -		if (!res)
> +		if (!res) {
>  			pci->dbi_base2 = pci->dbi_base + SZ_4K;
> -		else {
> +		} else {
>  			pci->dbi_base2 = devm_pci_remap_cfg_resource(dev, res);
>  			if (IS_ERR(pci->dbi_base2))
>  				return PTR_ERR(pci->dbi_base2);
> diff --git a/drivers/pci/controller/dwc/pcie-designware.c b/drivers/pci/controller/dwc/pcie-designware.c
> index d737af058903..9f4d2b44612b 100644
> --- a/drivers/pci/controller/dwc/pcie-designware.c
> +++ b/drivers/pci/controller/dwc/pcie-designware.c
> @@ -699,8 +699,9 @@ void dw_pcie_iatu_detect(struct dw_pcie *pci)
>  			pci->atu_size = SZ_4K;
>  
>  		dw_pcie_iatu_detect_regions_unroll(pci);
> -	} else
> +	} else {
>  		dw_pcie_iatu_detect_regions(pci);
> +	}
>  
>  	dev_info(pci->dev, "iATU unroll: %s\n", pci->iatu_unroll_enabled ?
>  		"enabled" : "disabled");
> -- 
> 2.35.1
> 
