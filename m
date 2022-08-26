Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5EC6B5A323B
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Aug 2022 00:50:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345403AbiHZWuT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 Aug 2022 18:50:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39308 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234440AbiHZWuP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Aug 2022 18:50:15 -0400
Received: from mail-lj1-x22f.google.com (mail-lj1-x22f.google.com [IPv6:2a00:1450:4864:20::22f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 17CFD2C666;
        Fri, 26 Aug 2022 15:50:14 -0700 (PDT)
Received: by mail-lj1-x22f.google.com with SMTP id s8so2866046ljj.5;
        Fri, 26 Aug 2022 15:50:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc;
        bh=4pc2oAidrj6yhUG2VXLcLsOrtbTR1Oyi+VKlwu+INl8=;
        b=R529Deg9qrsUPKylDTBFVydt0KHPodA86KNyWEzwMKDPI0qc7f8w4pm5lEpo2djUnp
         Fmhv5RzkZ80cSkMNsf2aAgLGYoRxFPKOYW0VCqGEXtMQh7B0zzzg5kKJvHn11yLqp1er
         HMZlhJhpY+Z8GBYcNZ1kQOHGFYPoc//n7QtnYPaa94PhR6mthEtO82rr3XSRgdC7NvQ1
         xk64BAK3JYFyYuL28T4zOkL5YsbI9UtrYlzQYoJEgC6dWsUFlhnXnapfh7S2ZZXKgUid
         j8BPCWa1TSwEWj384je/p1aK4Xag8JJwb3lDyJq++HkAKePjxme00RUvS/vXGGzAR3Cv
         NITw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc;
        bh=4pc2oAidrj6yhUG2VXLcLsOrtbTR1Oyi+VKlwu+INl8=;
        b=U7yGL+3ilKMHcnt27aq4mjXIERupcLdm2OeRq/csFCWWeds33NPQKnP+ZT5e7JNt9H
         dTon7cXR9AJ3EmQcLkyvp1DOTPOWjN/IkijLPrbZejyvOeu2rQrMSHQ7fdpAD7IPka7Y
         7zpSi5WdNF6Ci7lXaWHSRansmdt4K+6x43zpOgiVwrz5j1WQjh8kkKtM2aLjPmPHh3qQ
         gL4Jwu/FnCxbHnn+WkQo1XiWZSDbwRNby1rl7di0Y79i8HWy/tbgpctAJgZvtXASGpoU
         fLGTBWhzU9DEY1/RE4woJwtk2jOUf2TjFaTaHj57vEmrFThg4ovy8N/55TpJ72ho+aDc
         LoFA==
X-Gm-Message-State: ACgBeo1TpKFAOcJElB84mhftvXOdLote+jaKZI0PplZXft9qbtqkN9rM
        JsYX1gCDXW/nm1QVVb1jrRvLT0yK1S1DRw==
X-Google-Smtp-Source: AA6agR74p1nHA8uH4eqONhVaJ6eot9xw+yA5nFlIlGeCu5x42hB1AkobVbtU+oDATjJ6jQoQZqdEqg==
X-Received: by 2002:a05:651c:10b0:b0:261:ca24:def5 with SMTP id k16-20020a05651c10b000b00261ca24def5mr2778197ljn.169.1661554212465;
        Fri, 26 Aug 2022 15:50:12 -0700 (PDT)
Received: from mobilestation ([95.79.140.178])
        by smtp.gmail.com with ESMTPSA id t14-20020a2e8e6e000000b0025e1ec74e25sm589154ljk.43.2022.08.26.15.50.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Aug 2022 15:50:11 -0700 (PDT)
Date:   Sat, 27 Aug 2022 01:50:09 +0300
From:   Serge Semin <fancer.lancer@gmail.com>
To:     Sudip Mukherjee <sudip.mukherjee@sifive.com>
Cc:     Mark Brown <broonie@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        greentime.hu@sifive.com, jude.onyenegecha@sifive.com,
        william.salmon@sifive.com, adnan.chowdhury@sifive.com,
        ben.dooks@sifive.com, linux-spi@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        jeegar.lakhani@sifive.com
Subject: Re: [PATCH 06/11] spi: dw: update SPI_CTRLR0 register
Message-ID: <20220826225009.hipxcffq2ddpiv4s@mobilestation>
References: <20220802175755.6530-1-sudip.mukherjee@sifive.com>
 <20220802175755.6530-7-sudip.mukherjee@sifive.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220802175755.6530-7-sudip.mukherjee@sifive.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 02, 2022 at 06:57:50PM +0100, Sudip Mukherjee wrote:
> If the controller supports enhanced SPI modes then update the register
> or reset the register if the transfer is not using dual/quad/octal mode.
> 
> Signed-off-by: Sudip Mukherjee <sudip.mukherjee@sifive.com>
> ---
>  drivers/spi/spi-dw-core.c | 29 +++++++++++++++++++++++++++++
>  1 file changed, 29 insertions(+)
> 
> diff --git a/drivers/spi/spi-dw-core.c b/drivers/spi/spi-dw-core.c
> index 8e624620864f..9d499bdf2ce6 100644
> --- a/drivers/spi/spi-dw-core.c
> +++ b/drivers/spi/spi-dw-core.c
> @@ -676,6 +676,32 @@ static void dw_spi_stop_mem_op(struct dw_spi *dws, struct spi_device *spi)
>  	dw_spi_enable_chip(dws, 1);
>  }
>  
> +static void update_spi_ctrl0(struct dw_spi *dws, const struct spi_mem_op *op, bool enable)
> +{
> +	u32 spi_ctrlr0;
> +
> +	spi_ctrlr0 = dw_readl(dws, DW_HSSI_SPI_CTRLR0);
> +	if (enable) {
> +		spi_ctrlr0 |= FIELD_PREP(DW_HSSI_SPI_CTRLR0_WAIT_CYCLE_MASK,

> +					 op->dummy.nbytes * BITS_PER_BYTE);
> +		/* 8 bit instruction length */
> +		spi_ctrlr0 |= FIELD_PREP(DW_HSSI_SPI_CTRLR0_INST_L_MASK,
> +					 DW_HSSI_SPI_CTRLR0_INST_L8);
> +		/* 32 bit address length */
> +		spi_ctrlr0 |= FIELD_PREP(DW_HSSI_SPI_CTRLR0_ADDR_L_MASK,
> +					 DW_HSSI_SPI_CTRLR0_ADDR_L32);

Just add new fields dw_spi_cfg.{trans_t,inst_l,addr_l,wait_c},
initialize them with the values taken from the spi_mem_op (trans_t -
based on the bus widths, inst_l - cmd.nbytes, addr_l - addr.nbytes,
wait_c - dummy.nbytes / dummy.buswidth) and use them to accordingly
update the SPI_CTRLR0 CSR in the dw_spi_update_config() method. Update
the CSR if spi_frf has value other than STD_SPI_FRF, otherwise
according to the HW manual the SPI_CTRLR0 register isn't relevant so
don't touch it.

> +		/* Enable clock stretching */
> +		spi_ctrlr0 |= DW_HSSI_SPI_CTRLR0_CLK_STRETCH_EN;
> +	} else {
> +		spi_ctrlr0 &= ~DW_HSSI_SPI_CTRLR0_WAIT_CYCLE_MASK;
> +		spi_ctrlr0 &= ~DW_HSSI_SPI_CTRLR0_INST_L_MASK;
> +		spi_ctrlr0 &= ~DW_HSSI_SPI_CTRLR0_ADDR_L_MASK;
> +		spi_ctrlr0 &= ~DW_HSSI_SPI_CTRLR0_CLK_STRETCH_EN;
> +	}
> +
> +	dw_writel(dws, DW_HSSI_SPI_CTRLR0, spi_ctrlr0);
> +}
> +
>  /*
>   * The SPI memory operation implementation below is the best choice for the
>   * devices, which are selected by the native chip-select lane. It's
> @@ -738,6 +764,9 @@ static int dw_spi_exec_mem_op(struct spi_mem *mem, const struct spi_mem_op *op)
>  
>  	dw_spi_enable_chip(dws, 0);
>  

> +	if (dws->caps & DW_SPI_CAP_EXT_SPI)
> +		update_spi_ctrl0(dws, op, enhanced_spi);
> +

This won't be needed as long as you do as I suggested above.

-Sergey

>  	dw_spi_update_config(dws, mem->spi, &cfg);
>  
>  	dw_spi_mask_intr(dws, 0xff);
> -- 
> 2.30.2
> 
