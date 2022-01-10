Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 50C4D48A3D4
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jan 2022 00:41:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345713AbiAJXlb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Jan 2022 18:41:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49924 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242645AbiAJXl3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Jan 2022 18:41:29 -0500
Received: from mail-pj1-x102c.google.com (mail-pj1-x102c.google.com [IPv6:2607:f8b0:4864:20::102c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F371C06173F;
        Mon, 10 Jan 2022 15:41:29 -0800 (PST)
Received: by mail-pj1-x102c.google.com with SMTP id g11-20020a17090a7d0b00b001b2c12c7273so667928pjl.0;
        Mon, 10 Jan 2022 15:41:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=b7rF/+7zNEi6PfcE9UdoT64bvFiZXuAW5zsuDsfPwMw=;
        b=LuUtRw5yJpt/krw5bEDY+gsyWKSiiWxF+QJ6h1ggw9X7zAgXfRqoORbS3TWI/PyiZE
         LqmynqrYWSb4T2V0gnYQHo84m4YTUt3oFFiT7uI9UdrBD5eRROmFzQ0rN8kfXBMdUjt+
         U+3pa5LN9x+c90l7OPcxOXN9/TLjCm959JVMZUpBdtUuFsSu1bRHnvOz6G+mZY6nwCBh
         VOrQsIisAZhpP7iRkdm6CDSxxnn56siqOLHw9tYvf80TuWHLR8SjbBZbsSBog63eBLs3
         ZYfmOIk5NAqQ9+v6t1QJgvSetoCa/dGCpkjiHm38x7zCxykP7X+xhsDwXHp0NqIF4Z9e
         Kkbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=b7rF/+7zNEi6PfcE9UdoT64bvFiZXuAW5zsuDsfPwMw=;
        b=cUZPFV4IbQ47L9GzVtB8uX8deBYgCi8jyjdmy+4XfefatXPiOcnSGXU50BEha7GpV3
         eb5uxqWAxZGQRM/cfGKrFEpk7zvQZg9hUJucvGMYp4i5pCzEnUvfI3CMbPhs4KUaSAIv
         5mm/YhhMibenJwHFckF1nmNmkSkKeDsXF5tAMA3QJqcYuB/vDUsScgAaQBtv+LwLlgGB
         JWvAkjDF2lat++TpCEEAlljbj9U9U73DMqWyvg3kL7bv2WEo+4+gKWD3XvtbQPU89cr2
         HfdGk9uRN0cqxspKGdmxOsMrWkNhZoCkeMMlixr4vXg/PCFlGzxbm4abx0LtVVGx7B/b
         6qtA==
X-Gm-Message-State: AOAM531ffrEiNo9txR74G4CuLBwz/HuSv6DC+Q6NEQbgXNWX6iT4oKWZ
        pAmlw4BeJ5ORxFoE4fkIhFE=
X-Google-Smtp-Source: ABdhPJybys/dSkECYSOhCUzYQMxDSVohMnWvXs9u6q9JVsqRzOVaeK+Ywrdj4OL8Lu20UVT4znlMxw==
X-Received: by 2002:a17:902:c215:b0:148:af14:6e96 with SMTP id 21-20020a170902c21500b00148af146e96mr1764021pll.80.1641858089003;
        Mon, 10 Jan 2022 15:41:29 -0800 (PST)
Received: from localhost ([2409:10:24a0:4700:e8ad:216a:2a9d:6d0c])
        by smtp.gmail.com with ESMTPSA id kt19sm124551pjb.50.2022.01.10.15.41.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Jan 2022 15:41:27 -0800 (PST)
Date:   Tue, 11 Jan 2022 08:41:26 +0900
From:   Stafford Horne <shorne@gmail.com>
To:     "Gabriel L. Somlo" <gsomlo@gmail.com>
Cc:     linux-kernel@vger.kernel.org, robh+dt@kernel.org,
        devicetree@vger.kernel.org, ulf.hansson@linaro.org,
        linux-mmc@vger.kernel.org, kgugala@antmicro.com,
        mholenko@antmicro.com, krakoczy@antmicro.com,
        mdudek@internships.antmicro.com, paulus@ozlabs.org, joel@jms.id.au,
        geert@linux-m68k.org, david.abdurachmanov@sifive.com,
        florent@enjoy-digital.fr, rdunlap@infradead.org,
        andy.shevchenko@gmail.com, hdanton@sina.com
Subject: Re: [PATCH v11 3/3] mmc: Add driver for LiteX's LiteSDCard interface
Message-ID: <YdzEJijn2JbSFzxF@antec>
References: <20220109232003.2573924-1-gsomlo@gmail.com>
 <20220109232003.2573924-4-gsomlo@gmail.com>
 <YdywDhEbYyzm7Rri@antec>
 <Ydy1qCc3CXOWKv/O@errol.ini.cmu.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Ydy1qCc3CXOWKv/O@errol.ini.cmu.edu>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 10, 2022 at 05:39:36PM -0500, Gabriel L. Somlo wrote:
> On Tue, Jan 11, 2022 at 07:15:42AM +0900, Stafford Horne wrote:
> > On Sun, Jan 09, 2022 at 06:20:03PM -0500, Gabriel Somlo wrote:
> > > LiteX (https://github.com/enjoy-digital/litex) is a SoC framework
> > > that targets FPGAs. LiteSDCard is a small footprint, configurable
> > > SDCard core commonly used in LiteX designs.
> > > 
> > > The driver was first written in May 2020 and has been maintained
> > > cooperatively by the LiteX community. Thanks to all contributors!
> > > 
> > > Co-developed-by: Kamil Rakoczy <krakoczy@antmicro.com>
> > > Signed-off-by: Kamil Rakoczy <krakoczy@antmicro.com>
> > > Co-developed-by: Maciej Dudek <mdudek@internships.antmicro.com>
> > > Signed-off-by: Maciej Dudek <mdudek@internships.antmicro.com>
> > > Co-developed-by: Paul Mackerras <paulus@ozlabs.org>
> > > Signed-off-by: Paul Mackerras <paulus@ozlabs.org>
> > > Signed-off-by: Gabriel Somlo <gsomlo@gmail.com>
> > > Reviewed-by: Joel Stanley <joel@jms.id.au>
> > > Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>
> > > ---
> > > 
> > ...
> > > +static int litex_mmc_probe(struct platform_device *pdev)
> > > +{
> > > +	struct device *dev = &pdev->dev;
> > > +	struct litex_mmc_host *host;
> > > +	struct mmc_host *mmc;
> > > +	struct clk *clk;
> > > +	int ret;
> > > +
> > > +	/*
> > > +	 * NOTE: defaults to max_[req,seg]_size=PAGE_SIZE, max_blk_size=512,
> > > +	 * and max_blk_count accordingly set to 8;
> > > +	 * If for some reason we need to modify max_blk_count, we must also
> > > +	 * re-calculate `max_[req,seg]_size = max_blk_size * max_blk_count;`
> > > +	 */
> > > +	mmc = mmc_alloc_host(sizeof(struct litex_mmc_host), dev);
> > > +	if (!mmc)
> > > +		return -ENOMEM;
> > > +
> > > +	ret = devm_add_action_or_reset(dev, litex_mmc_free_host_wrapper, mmc);
> > > +	if (ret)
> > > +		return dev_err_probe(dev, ret,
> > > +				     "Can't register mmc_free_host action\n");
> > > +
> > > +	host = mmc_priv(mmc);
> > > +	host->mmc = mmc;
> > > +
> > > +	/* Initialize clock source */
> > > +	clk = devm_clk_get(dev, NULL);
> > > +	if (IS_ERR(clk))
> > > +		return dev_err_probe(dev, PTR_ERR(clk), "can't get clock\n");
> > > +	host->ref_clk = clk_get_rate(clk);
> > > +	host->sd_clk = 0;
> > > +
> > > +	/*
> > > +	 * LiteSDCard only supports 4-bit bus width; therefore, we MUST inject
> > > +	 * a SET_BUS_WIDTH (acmd6) before the very first data transfer, earlier
> > > +	 * than when the mmc subsystem would normally get around to it!
> > > +	 */
> > > +	host->is_bus_width_set = false;
> > > +	host->app_cmd = false;
> > > +
> > > +	/* LiteSDCard can support 64-bit DMA addressing */
> > > +	ret = dma_set_mask_and_coherent(dev, DMA_BIT_MASK(64));
> > > +	if (ret)
> > > +		return ret;
> > > +
> > > +	host->buf_size = mmc->max_req_size * 2;
> > > +	host->buffer = dmam_alloc_coherent(dev, host->buf_size,
> > > +					   &host->dma, GFP_KERNEL);
> > > +	if (host->buffer == NULL)
> > > +		return -ENOMEM;
> > > +
> > > +	host->sdphy = devm_platform_ioremap_resource_byname(pdev, "phy");
> > > +	if (IS_ERR(host->sdphy))
> > > +		return PTR_ERR(host->sdphy);
> > > +
> > > +	host->sdcore = devm_platform_ioremap_resource_byname(pdev, "core");
> > > +	if (IS_ERR(host->sdcore))
> > > +		return PTR_ERR(host->sdcore);
> > > +
> > > +	host->sdreader = devm_platform_ioremap_resource_byname(pdev, "reader");
> > > +	if (IS_ERR(host->sdreader))
> > > +		return PTR_ERR(host->sdreader);
> > > +
> > > +	host->sdwriter = devm_platform_ioremap_resource_byname(pdev, "writer");
> > > +	if (IS_ERR(host->sdwriter))
> > > +		return PTR_ERR(host->sdwriter);
> > > +
> > > +	/* Ensure DMA bus masters are disabled */
> > > +	litex_write8(host->sdreader + LITEX_BLK2MEM_ENA, 0);
> > > +	litex_write8(host->sdwriter + LITEX_MEM2BLK_ENA, 0);
> > > +
> > > +	init_completion(&host->cmd_done);
> > > +	ret = litex_mmc_irq_init(pdev, host);
> > > +	if (ret)
> > > +		return ret;
> > > +
> > > +	/* Allow full generic 2.7-3.6V range; no software tuning available */
> > > +	mmc->ocr_avail = LITEX_MMC_OCR;
> > > +
> > > +	mmc->ops = &litex_mmc_ops;
> > > +
> > > +	/*
> > > +	 * Set default sd_clk frequency range based on empirical observations
> > > +	 * of LiteSDCard gateware behavior on typical SDCard media
> > > +	 */
> > > +	mmc->f_min = 12.5e6;
> > > +	mmc->f_max = 50e6;
> > > +
> > > +	ret = mmc_of_parse(mmc);
> > > +	if (ret)
> > > +		return ret;
> > > +
> > > +	/* Force 4-bit bus_width (only width supported by hardware) */
> > > +	mmc->caps &= ~MMC_CAP_8_BIT_DATA;
> > > +	mmc->caps |= MMC_CAP_4_BIT_DATA;
> > > +
> > > +	/* Set default capabilities */
> > > +	mmc->caps |= MMC_CAP_WAIT_WHILE_BUSY |
> > > +		     MMC_CAP_DRIVER_TYPE_D |
> > > +		     MMC_CAP_CMD23;
> > > +	mmc->caps2 |= MMC_CAP2_NO_WRITE_PROTECT |
> > > +		      MMC_CAP2_NO_SDIO |
> > > +		      MMC_CAP2_NO_MMC;
> > > +
> > > +	platform_set_drvdata(pdev, host);
> > 
> > One more thing here. Or somewhere, should we add:
> > 
> > 	dev_info(dev, "Litex MMC controller initialized");
> > 
> > I was having a hard time debugging probing of this and having no printk's made
> > it a bit difficult.
> > 
> > Though I was able to get most of the debug statements I needed using:
> > 
> > 	"debug initcall_debug dyndbg=\"file drivers/* +p\" loglevel=8"
> > 
> > -Stafford
> > 
> > > +	return mmc_add_host(mmc);
> 
> I'd prefer to declare victory *after* calling mmc_add_host(), so if
> there are no objections I'd prefer to do the following in v12:
> 
>         ... 
>         platform_set_drvdata(pdev, host);
>  
> -       return mmc_add_host(mmc);
> +       ret = mmc_add_host(mmc);
> +       if (ret)
> +               return dev_err_probe(dev, ret, "LiteX MMC probe failed!\n");
> +
> +       dev_info(dev, "LiteX MMC controller initialized.\n");
> +
> +       return 0;
>  }

Yes, that is what I was thinking too.

-Stafford
