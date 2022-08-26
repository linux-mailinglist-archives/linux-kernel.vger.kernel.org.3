Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 84EAD5A31FB
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Aug 2022 00:22:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345209AbiHZWWI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 Aug 2022 18:22:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48146 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345280AbiHZWVp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Aug 2022 18:21:45 -0400
Received: from mail-lf1-x134.google.com (mail-lf1-x134.google.com [IPv6:2a00:1450:4864:20::134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2377BE9AA8;
        Fri, 26 Aug 2022 15:19:27 -0700 (PDT)
Received: by mail-lf1-x134.google.com with SMTP id bt10so3710320lfb.1;
        Fri, 26 Aug 2022 15:19:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc;
        bh=5sZZrUpkARsk9qJWaH/yaSkJtiZE1rGXFiif4NSjNJo=;
        b=IMOOL7HySqQpLMuR8vbJ7rP49Ajs6oFtQI9upAfEOPOxhOzH/oL69lv4brlkDhF8OY
         et2ryUKQzW8sQjxL1am1LiA7GiysGxDgE5AqhDrcTwyuNAylqYjr85cIu3mEDXAusWk+
         QQAyJLGtBgOtfwOlnncQFzz7EFWgmyXk/GUG9G3+F4dlF2+HEjWANGQvPZ4otvsb5jsP
         +P2AOPJj9hahGlzbaWmtuBvbuP362IqPIWnI1mwpBZVFbvw1UXPatEmiinTCcSiuPiEw
         rscsnKvzvTkb2LiE0NfrpwpK+agsDiQChYJnjIoLp9xItoVy/2Nob+WyX4b/QsFP/174
         WJ5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc;
        bh=5sZZrUpkARsk9qJWaH/yaSkJtiZE1rGXFiif4NSjNJo=;
        b=dbLR9z0o0/g0jKYmI5WsCptZab/+0HhMQDeDx/606ZNB3bifB5XOfv+xNkP8hopo3V
         iAB7jRXuroWEEm6OUSO9JrYMqUtUauE0cIfRrZuf5CHcq1nsDaT3buBWrkTzToiMKgN2
         BM6Xwu41+ph6Y4siVCACD26ocel+Rj/OLrf5kEmS2sgUq1QRoSeUMj8jvx735MO9SOp0
         jTHutzqG1elH/sJAIZ7BFhAN100OOdomdOnYoz7Mo+b4Yj00HVBx0wZsyE3PqXblQQoF
         /vVUm7OlmN+IS1qXGKDnbFyYWcsHGWo68/X5Aytq6uSL8LA5PpgVFByOXc9FjHCvwWbU
         oiqw==
X-Gm-Message-State: ACgBeo1Y4vYHeVrvxH0DIPcQ9RKLsw0ub84DcV75sADsdO1DLTMe3ro2
        YW8lBq4fBlc22CUMAqBIKFk=
X-Google-Smtp-Source: AA6agR7RZqv8wt2ZCnP/B6H7eEnBp/a4/HrBZTEa0paTPSTDZLniXRKs8BOyaTetpbTR4Qm6Ioofow==
X-Received: by 2002:a05:6512:3982:b0:492:db4e:fe75 with SMTP id j2-20020a056512398200b00492db4efe75mr3310907lfu.482.1661552365926;
        Fri, 26 Aug 2022 15:19:25 -0700 (PDT)
Received: from mobilestation ([95.79.140.178])
        by smtp.gmail.com with ESMTPSA id t30-20020a05651c205e00b00261e50a2534sm586734ljo.33.2022.08.26.15.19.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Aug 2022 15:19:25 -0700 (PDT)
Date:   Sat, 27 Aug 2022 01:19:23 +0300
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
Subject: Re: [PATCH 05/11] spi: dw: define SPI_CTRLR0 register and its fields
Message-ID: <20220826221923.k4cwharkathma7zi@mobilestation>
References: <20220802175755.6530-1-sudip.mukherjee@sifive.com>
 <20220802175755.6530-6-sudip.mukherjee@sifive.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220802175755.6530-6-sudip.mukherjee@sifive.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 02, 2022 at 06:57:49PM +0100, Sudip Mukherjee wrote:
> Synopsys SSI controllers supporting enhanced SPI mode of operation has
> SPI Control Register at offset 0xf4 which controls the following:
> 
> CLK_STRETCH_EN: Enables clock stretching capability in SPI transfers.
> In case of write, if the FIFO becomes empty DWC_ssi will stretch the
> clock until FIFO has enough data to continue the transfer. In case of
> read, if the receive FIFO becomes full DWC_ssi will stop the clock until
> data has been read from the FIFO.
> 
> WAIT_CYCLES: Wait cycles in Dual/Quad/Octal mode between control frames
> transmit and data reception.
> 
> INST_L: Dual/Quad/Octal mode instruction length in bits.
> 
> ADDR_L: defines Length of Address to be transmitted.
> 
> For now, we are only using 32bit Address length and 8 bit Instruction
> length.
> 
> Signed-off-by: Sudip Mukherjee <sudip.mukherjee@sifive.com>
> ---
>  drivers/spi/spi-dw.h | 11 +++++++++++
>  1 file changed, 11 insertions(+)
> 
> diff --git a/drivers/spi/spi-dw.h b/drivers/spi/spi-dw.h
> index b8cc20e0deaa..a7a4637d6d32 100644
> --- a/drivers/spi/spi-dw.h
> +++ b/drivers/spi/spi-dw.h
> @@ -63,6 +63,17 @@
>  #define DW_SPI_RX_SAMPLE_DLY		0xf0
>  #define DW_SPI_CS_OVERRIDE		0xf4
>  

> +/* Register offsets (Defined in DWC SSI 1.03a) */

Drop this comment. The CSR can exist in the DW APB SSI too

> +#define DW_HSSI_SPI_CTRLR0		0xf4

#define DW_SSI_SPI_CTRLR0		0xf4

> +
> +/* Bit fields in SPI_CTRLR0 (Defined in DWC SSI 1.03a) */

Drop the IP-core ID and version from the comment. As I said the eSPI
feature can be enabled for DW APB SSI too.

> +#define DW_HSSI_SPI_CTRLR0_CLK_STRETCH_EN	BIT(30)
> +#define DW_HSSI_SPI_CTRLR0_WAIT_CYCLE_MASK	GENMASK(15, 11)
> +#define DW_HSSI_SPI_CTRLR0_INST_L_MASK		GENMASK(9, 8)
> +#define DW_HSSI_SPI_CTRLR0_INST_L8		0x2
> +#define DW_HSSI_SPI_CTRLR0_ADDR_L_MASK		GENMASK(5, 2)
> +#define DW_HSSI_SPI_CTRLR0_ADDR_L32		0x8

Move this to the tail of the CSR fields macros definition (right after
the DW_SPI_DMACR_TDMAE macros) and s/HSSI/SPI .

-Sergey

> +
>  /* Bit fields in CTRLR0 (DWC APB SSI) */
>  #define DW_PSSI_CTRLR0_DFS_MASK			GENMASK(3, 0)
>  #define DW_PSSI_CTRLR0_DFS32_MASK		GENMASK(20, 16)
> -- 
> 2.30.2
> 
