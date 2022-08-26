Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 87C215A31C0
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Aug 2022 00:12:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243853AbiHZWMp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 Aug 2022 18:12:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59758 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344648AbiHZWMi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Aug 2022 18:12:38 -0400
Received: from mail-lj1-x22a.google.com (mail-lj1-x22a.google.com [IPv6:2a00:1450:4864:20::22a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D10EE1177;
        Fri, 26 Aug 2022 15:12:37 -0700 (PDT)
Received: by mail-lj1-x22a.google.com with SMTP id bx38so2786496ljb.10;
        Fri, 26 Aug 2022 15:12:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc;
        bh=Pt+/cZ875kZz0E2lsEB+5Rmg0ZBd7mawodHVFJnvQkI=;
        b=XDdcCHG69p3U9NL9QXx43ltscDcROI/Uhg8WGXPqKhr4pF2KdLfETt6qa1yGfAnllC
         xNYo3LafLmy2oL8ttPQoqHy6Nod33zSEUnMuFy+E2gqzKsgBs5jTPHRUpdQdwJ35SRan
         qJXyKdkBFg7j/WCh4uaRkIFPyQilcm/EJ16YleM3QBwOf8SPURTcBSD3/dnPzMCEjHRN
         JR30V/AmCsOKQ955U1NS6KRWsvFF80NeM95mDN6myWJ/QxsX6PNohxzkKh5APRBcpIQQ
         TPypD41DZwNZMwvbSO6mQqviS8+UY/KbdTUUI+N1qGjC/y7YHqgvJYuaGhDX21W3aW/g
         bTnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc;
        bh=Pt+/cZ875kZz0E2lsEB+5Rmg0ZBd7mawodHVFJnvQkI=;
        b=mThQAvFszL4++oPnxNO4y0k6l5eGp0Drktyit+J9mVXyJrvSeOdzJMp3XPKaJ0lIPG
         EPD2TvikqEXGUdjGG28B99sLjlX1wDithLip6QsyadYEcwpj5/6RFLUc6SGL/MmEgBYH
         XvisslfnsYdLKSgSgWd5XBkanH2vooUmmR/fyh/gMiHCAzC/lgDDi4LLE4JlTWLgY+8/
         kU8yfCczEVgMs8lamTxkhRs3jbCyD1c8cfBjFuV/O30ChEwwUGVlUOYVAzyp7FzE3XPP
         hvtLc2SRyM+HFv7aPPRzdOKvJu7RJ2pCwD9mgG1Xu4vCEBqohv1JcBNzNEuYhzcs9a+B
         /BcA==
X-Gm-Message-State: ACgBeo24NbM7rH5zFCGJHZ/vjBw8nbYrY11BbVQrEv6VcqnschnXM0Mo
        a4EtpaJQeT0LuVGtWxoQBk0=
X-Google-Smtp-Source: AA6agR44cnr91IYZlU5ikFp1HIJBz6SO4fMjKlBnUrxf168BjnNZF7bxSpdLLmhnJLF+42BaH2WMOg==
X-Received: by 2002:a2e:5cc2:0:b0:261:e2b3:e628 with SMTP id q185-20020a2e5cc2000000b00261e2b3e628mr2685434ljb.181.1661551955829;
        Fri, 26 Aug 2022 15:12:35 -0700 (PDT)
Received: from mobilestation ([95.79.140.178])
        by smtp.gmail.com with ESMTPSA id x1-20020a056512078100b00492d8c53692sm479702lfr.222.2022.08.26.15.12.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Aug 2022 15:12:35 -0700 (PDT)
Date:   Sat, 27 Aug 2022 01:12:33 +0300
From:   Serge Semin <fancer.lancer@gmail.com>
To:     Sudip Mukherjee <sudip.mukherjee@sifive.com>
Cc:     Serge Semin <Sergey.Semin@baikalelectronics.ru>,
        Mark Brown <broonie@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        greentime.hu@sifive.com, jude.onyenegecha@sifive.com,
        william.salmon@sifive.com, adnan.chowdhury@sifive.com,
        ben.dooks@sifive.com, linux-spi@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        jeegar.lakhani@sifive.com
Subject: Re: [PATCH 04/11] spi: dw: use TMOD_RO to read in enhanced spi modes
Message-ID: <20220826221233.3czezp7rcvk4ya6u@mobilestation>
References: <20220802175755.6530-1-sudip.mukherjee@sifive.com>
 <20220802175755.6530-5-sudip.mukherjee@sifive.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220802175755.6530-5-sudip.mukherjee@sifive.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 02, 2022 at 06:57:48PM +0100, Sudip Mukherjee wrote:
> When we are using the enhanced spi modes we can not use EEPROM Read.
> The Synopsys datasheet mentions EEPROM Read is not applicable in
> enhanced SPI modes. We will need to use Receive only mode.
> 
> Signed-off-by: Sudip Mukherjee <sudip.mukherjee@sifive.com>
> ---
>  drivers/spi/spi-dw-core.c | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/spi/spi-dw-core.c b/drivers/spi/spi-dw-core.c
> index 8c84a2e991b5..8e624620864f 100644
> --- a/drivers/spi/spi-dw-core.c
> +++ b/drivers/spi/spi-dw-core.c
> @@ -727,7 +727,10 @@ static int dw_spi_exec_mem_op(struct spi_mem *mem, const struct spi_mem_op *op)
>  	cfg.dfs = 8;
>  	cfg.freq = clamp(mem->spi->max_speed_hz, 0U, dws->max_mem_freq);
>  	if (op->data.dir == SPI_MEM_DATA_IN) {
> -		cfg.tmode = DW_SPI_CTRLR0_TMOD_EPROMREAD;

> +		if (enhanced_spi)
> +			cfg.tmode = DW_SPI_CTRLR0_TMOD_RO;
> +		else
> +			cfg.tmode = DW_SPI_CTRLR0_TMOD_EPROMREAD;

Just drop this modification and initialize the dw_spi_cfg structure
from scratch in the Enhanced SPI-specific method:
dw_spi_exec_enh_mem_op().

-Sergey

>  		cfg.ndf = op->data.nbytes;
>  	} else {
>  		cfg.tmode = DW_SPI_CTRLR0_TMOD_TO;
> -- 
> 2.30.2
> 
