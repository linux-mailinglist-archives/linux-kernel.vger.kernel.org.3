Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2912252FA4A
	for <lists+linux-kernel@lfdr.de>; Sat, 21 May 2022 11:23:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241953AbiEUJW7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 21 May 2022 05:22:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46986 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230144AbiEUJWy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 21 May 2022 05:22:54 -0400
Received: from mail-lf1-x12b.google.com (mail-lf1-x12b.google.com [IPv6:2a00:1450:4864:20::12b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6BC535FF20;
        Sat, 21 May 2022 02:22:53 -0700 (PDT)
Received: by mail-lf1-x12b.google.com with SMTP id y32so17935201lfa.6;
        Sat, 21 May 2022 02:22:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=xSyipWzorTdApD5hrRaa+nfQZ/aw7gdMuxHBe7jS38A=;
        b=CzZBBjq3IOtZg3o41CjyZtHO4GWSWmOMRR8i2cL0rW279ta4tuwiVm3y09R3Mh0NSr
         9om8PIxVHWHD46udUf8GwqvPgDSFHQHT7D+3j1ExzZZzyQuR9pIe9BjWllWJoaiz6fUd
         Ufa9bl8DKAsayliGX1vkxQYZ8Q5ImmEyMv5n+2G1PHkgGmEfg58kuSxmCA/3uubQGFIS
         hpc+ge6QIiqpj/Z7/7dBUNbZgv8ym9/rBjDug4kzdBU88JnUd13CtMu1gBE1QopfA5qg
         Mb0vuWP2gdruH2xXv0fJKYUNVj8HWDdDM8S3xrUgVmjEIoEbW8iHM2t160fOUNXKQokI
         Sneg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=xSyipWzorTdApD5hrRaa+nfQZ/aw7gdMuxHBe7jS38A=;
        b=Cru7UW+QqoJ6moF0awwTh3euLtD2dAfrY8qlqE0PaVQSGBYZisCi5P+XIfsK2n7jSc
         uKpA4NzMUsQdnBxBxV2ISt6uKyyu4TJ5WxB5dTcYDRblO8gCEGnpIDNAjZCo27yqHIjs
         UxZCDjWZnzd8edQjce+MfnjXXvAhwZtD7ymVqYmzkZwv7ctn+d5brZcuRcOaKko9OlLi
         Qs2NFOFj/VwJCyqHAuzRwTdcUAJgYtCCwy6ArmXnLuZGcb+Qxno6BydmyUE4N0ZcUGZQ
         teJvbkmihg3aRbiJHM4uFMfYNBE9mXHdZODceLsUYBrgJOiiDtmPif0jns48AyEjBeDZ
         bXcA==
X-Gm-Message-State: AOAM531+UKIP0gl541Ph7gx/nGL4/Kxa5yukmc/ky0P5K0V9ckOJ9Ykp
        kB7eKoLXdRfh8VXJavczsvQ=
X-Google-Smtp-Source: ABdhPJwqzAH9mwnk7Q3kT/zCIM9JpdEx0e/aHxhgjPrkO5JLsy17sG1nmg7lfgJDNZsE2e27ZzHkgg==
X-Received: by 2002:a05:6512:3e26:b0:478:5972:54b7 with SMTP id i38-20020a0565123e2600b00478597254b7mr3674055lfv.646.1653124971545;
        Sat, 21 May 2022 02:22:51 -0700 (PDT)
Received: from mobilestation ([95.79.189.214])
        by smtp.gmail.com with ESMTPSA id c11-20020a056512104b00b00477ce466e59sm712506lfb.153.2022.05.21.02.22.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 21 May 2022 02:22:50 -0700 (PDT)
Date:   Sat, 21 May 2022 12:22:48 +0300
From:   Serge Semin <fancer.lancer@gmail.com>
To:     Rob Herring <robh@kernel.org>
Cc:     Serge Semin <Sergey.Semin@baikalelectronics.ru>,
        Damien Le Moal <damien.lemoal@opensource.wdc.com>,
        Hans de Goede <hdegoede@redhat.com>,
        Jens Axboe <axboe@kernel.dk>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Alexey Malahov <Alexey.Malahov@baikalelectronics.ru>,
        Pavel Parkhomenko <Pavel.Parkhomenko@baikalelectronics.ru>,
        linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org
Subject: Re: [PATCH v3 01/23] dt-bindings: ata: ahci-platform: Drop
 dma-coherent property declaration
Message-ID: <20220521092248.7i53lxf3gx26fmi5@mobilestation>
References: <20220511231810.4928-1-Sergey.Semin@baikalelectronics.ru>
 <20220511231810.4928-2-Sergey.Semin@baikalelectronics.ru>
 <20220517185841.GA1388602-robh@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220517185841.GA1388602-robh@kernel.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 17, 2022 at 01:58:41PM -0500, Rob Herring wrote:
> On Thu, May 12, 2022 at 02:17:48AM +0300, Serge Semin wrote:
> > It's redundant to have the 'dma-coherent' property explicitly specified in
> > the DT schema because it's a generic property described in the core
> > DT-schema by which the property is always evaluated.
> 

> It is not redundant.
> 
> The core schema defines the property (as a boolean), but this schema 
> defines it being used in this binding. Otherwise, it won't be allowed.

I thought that the generic properties like ranges, dma-ranges, etc
including the dma-coherent one due to being defined in the dt-core
schema are always evaluated. As such seeing the unevaluatedProperties
property is set to false here, they can be used in the DT-nodes with
no need to be explicitly specified in the DT node bindings. In
addition to that I tested this assumption by dropping the dma-coherent
property definition from the AHCI-common schema and executed the
DT-bindings check procedure. No error has been spotted:

> [fancer@mobilestation] kernel $ cat Documentation/devicetree/bindings/ata/snps,dwc-ahci.yaml | grep dma-coherent
>        dma-coherent;
> [fancer@mobilestation] kernel $ make -j8 DT_SCHEMA_FILES=Documentation/devicetree/bindings/ata/snps,dwc-ahci.yaml dt_binding_check
>   LINT    Documentation/devicetree/bindings
>   DTEX    Documentation/devicetree/bindings/ata/snps,dwc-ahci.example.dts
>   CHKDT   Documentation/devicetree/bindings/processed-schema.json
>   SCHEMA  Documentation/devicetree/bindings/processed-schema.json
>   DTC     Documentation/devicetree/bindings/ata/snps,dwc-ahci.example.dtb
>   CHECK   Documentation/devicetree/bindings/ata/snps,dwc-ahci.example.dtb
> [fancer@mobilestation] kernel $ cat Documentation/devicetree/bindings/ata/snps,dwc-ahci.example.dts | grep dma-coherent
>           dma-coherent;
> [fancer@mobilestation] kernel $ echo $?
> 0

Due to that here are a few backward questions:
1) Am I doing something wrong in the framework of the DT-bindings
evaluation? Really I even tried to specify unknown property in the
DT-bindings example like "bla-bla-bla;" and no evaluation error was
printed. Anyway If what you are saying was correct I would have got an
error during the DT-bindings evaluation, but as you can see there was
none.
2) Am I wrong in thinking that the unevaluatedProperties setting
concerns the generic properties defined in the DT-core schema? If it
doesn't concern the generic properties then does it work for the
$ref'ed schemas only? 


Getting back to the patch topic. We need to drop the dma-coherent
property from the schema anyway. AHCI-specification doesn't
regulate the DMA operations coherency. The dma-coherent property is
more specific to the particular controller implementation mainly
dependent on the platform settings. So I'll change the patch log, but
get to keep the patch in the series. What do you think?

-Sergey

> 
> Rob
