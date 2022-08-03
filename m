Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9E51E58927E
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Aug 2022 20:56:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237678AbiHCS4J (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 Aug 2022 14:56:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42372 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229985AbiHCS4I (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Aug 2022 14:56:08 -0400
Received: from mail-lf1-x136.google.com (mail-lf1-x136.google.com [IPv6:2a00:1450:4864:20::136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F2C346561;
        Wed,  3 Aug 2022 11:56:04 -0700 (PDT)
Received: by mail-lf1-x136.google.com with SMTP id t22so27720154lfg.1;
        Wed, 03 Aug 2022 11:56:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc;
        bh=vvNjojdBPn+fwXkIYr8yL9pwhFpjS0sM33bBznGmHz0=;
        b=UO7MFxJJxN951lcl7vOSsAuhAXRwc169OOWvjBqLHIqm0J8HudC/3CV2VkjspZFHnR
         XmOX2a+4VUYgRvqwIUNiKD0EgP458utry+puWKZdaRLd2XqaYhkSQIrDkM5oz4VMi8lh
         RKO3DMjkyJa04c8r2cVQRya3ScevMa97XwnxhIh+bmyKCAb4xezjTfImb7bTYM4FQ8Mn
         5hQg+83RwVmnY6lvQQV9S9hoq66jYiq5QcvVes2HK3qGa42i+1YXAOjqdLnyBtdU3OV9
         aZ7vdh9eZK5rl/xgHIYRsYxGex7+qIwG+UCoSct15LjDWiCsko2SxVmN/MNl6eIBVNMJ
         rghQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc;
        bh=vvNjojdBPn+fwXkIYr8yL9pwhFpjS0sM33bBznGmHz0=;
        b=jK+8HHrOuD6E6kw6ttJZVTsZcPRbFv7giZMGmoETxQ1DiOeeX3bDxl+klFehZs3LWl
         rHVSF9nWYmVcVbqVkQiFhq4c/1UmidPUxQGo47lYsoS4syRVNO7rvceUm/CcNirH8E/N
         M5H2kU6JG1F/tHznk0G/liGtVULK8zI25pcJY33NYonQmdRZHif97+VYChwkDrjr7ZUj
         5L27q8iMr0n3CtYJ2uYS0VHRyQYAii+Gv8Mo0Qp4/sCSY1Kp9dCJBh6ezws3HlxTL663
         W4I0x0ZNgm5Rtg93vjL+fmgopHsv6N2cuxBepPAxUO84tkVQ1um4SekK4/e03S4fU9zo
         YyYA==
X-Gm-Message-State: ACgBeo0RHZBrznL7Kz6eCAlm/1KEILj+6qpWFfepkdjHNGAWSBSvSQyl
        zJr1S4vtvOlud6h4zLtxk5kt/hDaxG8=
X-Google-Smtp-Source: AA6agR5eBrbuBWLrhw0tNPfqEKehGfYRW/gk2avLo/wrEuJoz9/Jl3Kr2g9V3GitM1fcAlhtxtYYtg==
X-Received: by 2002:a05:6512:218f:b0:48a:f304:6cc1 with SMTP id b15-20020a056512218f00b0048af3046cc1mr6934410lft.235.1659552963216;
        Wed, 03 Aug 2022 11:56:03 -0700 (PDT)
Received: from mobilestation ([95.79.140.178])
        by smtp.gmail.com with ESMTPSA id t28-20020a05651c205c00b0025df5f38da8sm700409ljo.119.2022.08.03.11.56.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Aug 2022 11:56:02 -0700 (PDT)
Date:   Wed, 3 Aug 2022 21:56:00 +0300
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
Message-ID: <20220803185600.76rwp4o3itb2e2dn@mobilestation>
References: <20220802175755.6530-1-sudip.mukherjee@sifive.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220802175755.6530-1-sudip.mukherjee@sifive.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
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

Thanks for the patchset. It's always welcome to have a new
functionality support. I'll have it reviewed on the next week. There
are several aspects like using version-based compatible string and new
capability flag I am the most worried about. They need to be
discussed first before proceeding with the rest of the things.

-Sergey

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
