Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 26CCF59B656
	for <lists+linux-kernel@lfdr.de>; Sun, 21 Aug 2022 22:37:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231734AbiHUUh0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 21 Aug 2022 16:37:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54940 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229541AbiHUUhY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 21 Aug 2022 16:37:24 -0400
Received: from mail-lf1-x136.google.com (mail-lf1-x136.google.com [IPv6:2a00:1450:4864:20::136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B258F1F60D;
        Sun, 21 Aug 2022 13:37:23 -0700 (PDT)
Received: by mail-lf1-x136.google.com with SMTP id s1so9941174lfp.6;
        Sun, 21 Aug 2022 13:37:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc;
        bh=Kyxqc5rAoGnqJE9WElx6EBMV8xqTT9IMMo5wUGHftok=;
        b=Dh0wHSuPepRN05VF69M8apwh8NLGTSQ0rj+C/rKBVw0IFpwC/l6DdaykrHcU/GFVK3
         j65op7R8+6uvo6xt6Hm+hLsbYWROiF69cK9jmg3p8MmDiL8Blk+0EdT8RbEyggVeOzBc
         E2QsKkaKWDt1JPAsZ0gGBXgaqegBUQGrfiZMgTjVaVZOhhFaDQb3++pDcQlEvl7am52g
         8E6BWjV+Gw0ldKKbOgvYlTmuD9T1/4Ci/JB85yxkUXh/xufOFYBgrBSHT/oyyeXslpji
         F8UqfqqExfmA69cRW0nQRkii+2MeQCh28QX7vRrFow1xOw4ZvwWwfp9pNniBFtlAYFBl
         s8zA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc;
        bh=Kyxqc5rAoGnqJE9WElx6EBMV8xqTT9IMMo5wUGHftok=;
        b=s2sjVdoDWpCIur57YRum23vVBmCg3fzHvGVuPrJ2fitS0nDcg82dCzj23mB6EsoslP
         N0ftrc9SKaYm19uME2Hiq/Y1gvkqRUZ91vVmGv53WT/vOs6Gfwc6H+7U5hQ0/MTfB/qL
         BPG4JtWo33LbmxG8mudboTXlAzGGx1p1tUT821VmCHqdJC0VinI0pFZyLIgcknjzn9US
         lN0ck9bG9eTNauc5FjihPhYxbhGS63+8FUrPkCQKhwkU2PX4dloMNmTu08fhGJgMjY5N
         eG/T/d0Eu1yx1jn/erV1KL7Foc30UW4wffgKBV+HKtijberAZR0XTHrVWJiwNAKegDfw
         xPxA==
X-Gm-Message-State: ACgBeo1zt3CAxZEooxEcPTQWANn5zu0uadfgXTZcF8qLJ51NI6DYx3Ue
        ZeMsCvU76rZQqTKUx45Eai9qmffLdtLK1w==
X-Google-Smtp-Source: AA6agR5VwSaYfHoh8jG3iAVAoEI5L/BpK4p7fvqv4IoaMtYGPgIHW0+SlQrUQ568FJAEHINaPrh7ZQ==
X-Received: by 2002:ac2:50cf:0:b0:48a:f4ef:788b with SMTP id h15-20020ac250cf000000b0048af4ef788bmr5731853lfm.527.1661114241945;
        Sun, 21 Aug 2022 13:37:21 -0700 (PDT)
Received: from mobilestation ([95.79.140.178])
        by smtp.gmail.com with ESMTPSA id x2-20020ac25dc2000000b0047dace7c7e5sm1606422lfq.212.2022.08.21.13.37.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 21 Aug 2022 13:37:21 -0700 (PDT)
Date:   Sun, 21 Aug 2022 23:37:19 +0300
From:   Serge Semin <fancer.lancer@gmail.com>
To:     Sudip Mukherjee <sudip.mukherjee@sifive.com>
Cc:     Mark Brown <broonie@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        greentime.hu@sifive.com, jude.onyenegecha@sifive.com,
        william.salmon@sifive.com, adnan.chowdhury@sifive.com,
        ben.dooks@sifive.com, linux-spi@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        jeegar.lakhani@sifive.com
Subject: Re: [PATCH 00/11] Add support for enhanced SPI for Designware SPI
 controllers
Message-ID: <20220821203719.gxjxo24stzcf3a2x@mobilestation>
References: <20220802175755.6530-1-sudip.mukherjee@sifive.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220802175755.6530-1-sudip.mukherjee@sifive.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Sudip

On Tue, Aug 02, 2022 at 06:57:44PM +0100, Sudip Mukherjee wrote:
> Some Synopsys SSI controllers support enhanced SPI which includes
> Dual mode, Quad mode and Octal mode. DWC_ssi includes clock stretching
> feature in enhanced SPI modes which can be used to prevent FIFO underflow
> and overflow conditions while transmitting or receiving the data respectively.
> This is only tested on controller version 1.03a.
> 
> Ben Dooks (1):
>   spi: dw-apb-ssi: add generic 1.03a version
> 
> Sudip Mukherjee (10):
>   spi: dw: define capability for enhanced spi
>   spi: dw: add check for support of dual/quad/octal
>   spi: dw: define spi_frf for dual/quad/octal modes
>   spi: dw: use TMOD_RO to read in enhanced spi modes
>   spi: dw: define SPI_CTRLR0 register and its fields
>   spi: dw: update SPI_CTRLR0 register
>   spi: dw: update NDF while writing in enhanced spi mode
>   spi: dw: update buffer for enhanced spi mode
>   spi: dw: prepare the transfer routine for enhanced mode
>   spi: dw: initialize dwc-ssi-1.03a controller

Thanks for the very useful series. I've started reviewing it and will
share all my comments tomorrow.

-Sergey

> 
>  .../bindings/spi/snps,dw-apb-ssi.yaml         |   1 +
>  drivers/spi/spi-dw-core.c                     | 288 ++++++++++++++++--
>  drivers/spi/spi-dw-mmio.c                     |  10 +
>  drivers/spi/spi-dw.h                          |  19 ++
>  4 files changed, 291 insertions(+), 27 deletions(-)
> 
> -- 
> 2.30.2
> 
