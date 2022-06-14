Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A639E54BCDB
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Jun 2022 23:34:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1357927AbiFNVej (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Jun 2022 17:34:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60538 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1357627AbiFNVee (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Jun 2022 17:34:34 -0400
Received: from mail-il1-f177.google.com (mail-il1-f177.google.com [209.85.166.177])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E4DB515A4;
        Tue, 14 Jun 2022 14:34:32 -0700 (PDT)
Received: by mail-il1-f177.google.com with SMTP id d6so7549600ilm.4;
        Tue, 14 Jun 2022 14:34:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=Lw4KopkplTrYRscEG3rSLSQpHs9JVXnvbLHMj0LfULw=;
        b=q4bIfxFBPG7WXjR3Anmb8NbKAI4xJgQOXW5+vGMp/a0NbTkSg0Krktuz6rtD5rTfMs
         X6Yz1+mHknYgUBm+tPDFHxX89BqghI0bbeF9MYPWR5YNHVKiCh9Q3B/T7iDc1qcWjT8S
         9f2vGocUmBYWvUpUhqK9+SMwzp9MHXQn7Z6XyesjFK8ubvyJ3DZszTfQJ0I2MOjCo9ou
         a4KImic5ffHWtO9ZqCU5ZqtM4UU455/yVkAuFkE4kT6g0hwonWVA6knO8n1CHcCGbQIq
         sTwZCXRCYno4ptqJsIweYDmQs9VZbzGMuok0K7ksuQ6pimhq9EWFuJQFUxfAmBMTxerW
         y07A==
X-Gm-Message-State: AJIora9MqtyXgDHwU+PeaXIeU3/IwxaZeuPo9rYs6zIue/fOPV877EZ5
        rz4FzbFoPMhUc+f6dvPD/A==
X-Google-Smtp-Source: AGRyM1sYmRDfslvd2yjDtZY4AFUFvI4YgrlR4n7PSncRNqJQrdg1VxfmuGZMQYQbFywTUA/imP7UGg==
X-Received: by 2002:a05:6e02:1d91:b0:2d3:bef3:a073 with SMTP id h17-20020a056e021d9100b002d3bef3a073mr4460072ila.60.1655242471610;
        Tue, 14 Jun 2022 14:34:31 -0700 (PDT)
Received: from robh.at.kernel.org ([64.188.179.251])
        by smtp.gmail.com with ESMTPSA id l44-20020a02666c000000b0032b3a781767sm5326612jaf.43.2022.06.14.14.34.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Jun 2022 14:34:31 -0700 (PDT)
Received: (nullmailer pid 2692703 invoked by uid 1000);
        Tue, 14 Jun 2022 21:34:28 -0000
Date:   Tue, 14 Jun 2022 15:34:28 -0600
From:   Rob Herring <robh@kernel.org>
To:     Brad Larson <brad@pensando.io>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-mmc@vger.kernel.org, adrian.hunter@intel.com,
        alcooperx@gmail.com, andy.shevchenko@gmail.com, arnd@arndb.de,
        blarson@amd.com, brijeshkumar.singh@amd.com,
        catalin.marinas@arm.com, gsomlo@gmail.com, gerg@linux-m68k.org,
        krzk@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        lee.jones@linaro.org, broonie@kernel.org,
        yamada.masahiro@socionext.com, p.zabel@pengutronix.de,
        piotrs@cadence.com, p.yadav@ti.com, rdunlap@infradead.org,
        samuel@sholland.org, fancer.lancer@gmail.com,
        suravee.suthikulpanit@amd.com, thomas.lendacky@amd.com,
        ulf.hansson@linaro.org, will@kernel.org, devicetree@vger.kernel.org
Subject: Re: [PATCH v5 15/15] reset: elbasr: Add AMD Pensando Elba SR Reset
 Controller
Message-ID: <20220614213428.GA2684278-robh@kernel.org>
References: <20220613195658.5607-1-brad@pensando.io>
 <20220613195658.5607-16-brad@pensando.io>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220613195658.5607-16-brad@pensando.io>
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 13, 2022 at 12:56:58PM -0700, Brad Larson wrote:
> From: Brad Larson <blarson@amd.com>
> 
> This patch adds the reset controller functionality for the
> AMD Pensando Elba System Resource Chip.
> 
> Signed-off-by: Brad Larson <blarson@amd.com>
> ---
>  drivers/reset/Kconfig                         |  9 ++
>  drivers/reset/Makefile                        |  1 +
>  drivers/reset/reset-elbasr.c                  | 94 +++++++++++++++++++
>  .../reset/amd,pensando-elba-reset.h           | 11 +++

This goes with the binding patch

>  4 files changed, 115 insertions(+)
>  create mode 100644 drivers/reset/reset-elbasr.c
>  create mode 100644 include/dt-bindings/reset/amd,pensando-elba-reset.h
> 
> diff --git a/drivers/reset/Kconfig b/drivers/reset/Kconfig
> index 93c8d07ee328..13f5a8ca0f03 100644
> --- a/drivers/reset/Kconfig
> +++ b/drivers/reset/Kconfig
> @@ -66,6 +66,15 @@ config RESET_BRCMSTB_RESCAL
>  	  This enables the RESCAL reset controller for SATA, PCIe0, or PCIe1 on
>  	  BCM7216.
>  
> +config RESET_ELBASR
> +	tristate "Pensando Elba System Resource reset controller"
> +	depends on MFD_PENSANDO_ELBASR || COMPILE_TEST
> +	help
> +	  This option enables support for the external reset functions
> +	  on the Pensando Elba System Resource Chip.  Reset control
> +	  of peripherals is accessed over SPI to the system resource
> +	  chip device registers using CS0.
> +
>  config RESET_HSDK
>  	bool "Synopsys HSDK Reset Driver"
>  	depends on HAS_IOMEM
> diff --git a/drivers/reset/Makefile b/drivers/reset/Makefile
> index a80a9c4008a7..c0fe12b9950e 100644
> --- a/drivers/reset/Makefile
> +++ b/drivers/reset/Makefile
> @@ -10,6 +10,7 @@ obj-$(CONFIG_RESET_BCM6345) += reset-bcm6345.o
>  obj-$(CONFIG_RESET_BERLIN) += reset-berlin.o
>  obj-$(CONFIG_RESET_BRCMSTB) += reset-brcmstb.o
>  obj-$(CONFIG_RESET_BRCMSTB_RESCAL) += reset-brcmstb-rescal.o
> +obj-$(CONFIG_RESET_ELBASR) += reset-elbasr.o
>  obj-$(CONFIG_RESET_HSDK) += reset-hsdk.o
>  obj-$(CONFIG_RESET_IMX7) += reset-imx7.o
>  obj-$(CONFIG_RESET_INTEL_GW) += reset-intel-gw.o
> diff --git a/drivers/reset/reset-elbasr.c b/drivers/reset/reset-elbasr.c
> new file mode 100644
> index 000000000000..6e429cb11466
> --- /dev/null
> +++ b/drivers/reset/reset-elbasr.c
> @@ -0,0 +1,94 @@
> +// SPDX-License-Identifier: (GPL-2.0+ OR MIT)

Kernel code is GPL-2.0-only generally.
