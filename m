Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D6FEA59ED50
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Aug 2022 22:31:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229907AbiHWUbe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 Aug 2022 16:31:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40140 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230121AbiHWUbP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Aug 2022 16:31:15 -0400
Received: from mail-pj1-x1031.google.com (mail-pj1-x1031.google.com [IPv6:2607:f8b0:4864:20::1031])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F35D7B1ED
        for <linux-kernel@vger.kernel.org>; Tue, 23 Aug 2022 13:06:48 -0700 (PDT)
Received: by mail-pj1-x1031.google.com with SMTP id e19so13767692pju.1
        for <linux-kernel@vger.kernel.org>; Tue, 23 Aug 2022 13:06:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc;
        bh=CbkIBCLoHbH9nNnU/J2Hb+7ZqJOjL/seN2XSe7TVevU=;
        b=LyQZ8mpGnO62wtqueQ9ShrFp+nlxifSg/kxiyCwFOBEtJNosbOZLvblQHuIE6N2hjt
         V/oQePAHGmvEulJfpi7dcrOIYh/b9yyhDrE2XuKRqv8E0nfyTkN1+ziMmIjvW9Y/K2Dm
         gpTm9CNd1Wa+6RHT/+oUNI98z9jaJkAAVSirYcJZ3o3eK8zT4E3clJxiu5DdGcfxgW+Y
         lM3TMLUTtYTY1/CQPIfgl4ghw4+cy8bi6wQ79Zf9HfOm/onkXJ3UYQ4B8AerTI/HwaMu
         qAmBr35p0DqTJ+wFeG8lzBa+vgTnVmmOBu0a5bFySbiwtvL/ObBHWeWo0dUXpa5Nz96r
         gPng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc;
        bh=CbkIBCLoHbH9nNnU/J2Hb+7ZqJOjL/seN2XSe7TVevU=;
        b=mqIoBK+hWQsJBPUIjQmTTc+jv2g0+KMFiGqLSzsjxFbzMoDdVLtrkM6+cI92LExRAJ
         81bPTNmlN4PfmU9B4Ly7IHiKkAqxQeYlga7jsCfF0L643QxNTNsFaddHhQUacIEmitiD
         jKsmU8c92mKWu+PEVy3bBkbPZPEoIaC8WhnEpBXwSzmqEn+ha0WID3Ma56nfWdDzasIO
         NAyV6RtZ7t7QFKCSsOYE1PGMgrFh9Xzj52kV8UED+sDau1GmCtbjsbWloSRb47e+nO23
         xRqD8hk88E4n7fgQGy+9SgQPZOg0xTxVxhJ7eieFmugw94yUgqqXmL7NG0eMQrh7SZ6M
         0Xug==
X-Gm-Message-State: ACgBeo2aLvm8YuUUvwhqd1wToyPz6c45KAyEFvjBd3pqBjSvlOU61Jx5
        C1ZvJpjH4tA82i07HuZ0OkY7Sw==
X-Google-Smtp-Source: AA6agR5p/BTbRDFoEOMWG8yU+S+cOrL/qtvtS7f5dviOX2iNU2ka8UU1HiT4GwoLDdpIYoSb0zf/pw==
X-Received: by 2002:a17:902:cec7:b0:172:5b09:161c with SMTP id d7-20020a170902cec700b001725b09161cmr25181780plg.60.1661285207566;
        Tue, 23 Aug 2022 13:06:47 -0700 (PDT)
Received: from p14s (S0106889e681aac74.cg.shawcable.net. [68.147.0.187])
        by smtp.gmail.com with ESMTPSA id t127-20020a625f85000000b005362baf16e4sm8574434pfb.141.2022.08.23.13.06.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Aug 2022 13:06:46 -0700 (PDT)
Date:   Tue, 23 Aug 2022 14:06:44 -0600
From:   Mathieu Poirier <mathieu.poirier@linaro.org>
To:     Shengjiu Wang <shengjiu.wang@nxp.com>
Cc:     bjorn.andersson@linaro.org, shawnguo@kernel.org,
        s.hauer@pengutronix.de, kernel@pengutronix.de, festevam@gmail.com,
        linux-imx@nxp.com, linux-remoteproc@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] remoteproc: imx_dsp_rproc: fix argument 2 of
 rproc_mem_entry_init
Message-ID: <20220823200644.GC1781852@p14s>
References: <1660567398-24495-1-git-send-email-shengjiu.wang@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1660567398-24495-1-git-send-email-shengjiu.wang@nxp.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 15, 2022 at 08:43:18PM +0800, Shengjiu Wang wrote:
> There are sparse warning:
> drivers/remoteproc/imx_dsp_rproc.c:602:49: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void *va @@     got void [noderef] __iomem *[assigned] cpu_addr @@
> drivers/remoteproc/imx_dsp_rproc.c:602:49: sparse:     expected void *va
> drivers/remoteproc/imx_dsp_rproc.c:602:49: sparse:     got void [noderef] __iomem *[assigned] cpu_addr
> drivers/remoteproc/imx_dsp_rproc.c:638:49: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void *va @@     got void [noderef] __iomem *[assigned] cpu_addr @@
> drivers/remoteproc/imx_dsp_rproc.c:638:49: sparse:     expected void *va
> drivers/remoteproc/imx_dsp_rproc.c:638:49: sparse:     got void [noderef] __iomem *[assigned] cpu_addr
> 
> Fixes: ec0e5549f358 ("remoteproc: imx_dsp_rproc: Add remoteproc driver for DSP on i.MX")
> Reported-by: kernel test robot <lkp@intel.com>
> Signed-off-by: Shengjiu Wang <shengjiu.wang@nxp.com>
> ---
>  drivers/remoteproc/imx_dsp_rproc.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/remoteproc/imx_dsp_rproc.c b/drivers/remoteproc/imx_dsp_rproc.c
> index ca0817f8e41e..899aa8dd12f0 100644
> --- a/drivers/remoteproc/imx_dsp_rproc.c
> +++ b/drivers/remoteproc/imx_dsp_rproc.c
> @@ -599,7 +599,7 @@ static int imx_dsp_rproc_add_carveout(struct imx_dsp_rproc *priv)
>  		}
>  
>  		/* Register memory region */
> -		mem = rproc_mem_entry_init(dev, cpu_addr, (dma_addr_t)att->sa,
> +		mem = rproc_mem_entry_init(dev, (void __force *)cpu_addr, (dma_addr_t)att->sa,
>  					   att->size, da, NULL, NULL, "dsp_mem");
>  
>  		if (mem)
> @@ -635,7 +635,7 @@ static int imx_dsp_rproc_add_carveout(struct imx_dsp_rproc *priv)
>  		}
>  
>  		/* Register memory region */
> -		mem = rproc_mem_entry_init(dev, cpu_addr, (dma_addr_t)rmem->base,
> +		mem = rproc_mem_entry_init(dev, (void __force *)cpu_addr, (dma_addr_t)rmem->base,
>  					   rmem->size, da, NULL, NULL, it.node->name);

Applied.

Thanks,
Mathieu

>  
>  		if (mem)
> -- 
> 2.34.1
> 
