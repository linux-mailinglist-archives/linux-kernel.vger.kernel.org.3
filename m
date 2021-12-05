Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 05A2A468D7A
	for <lists+linux-kernel@lfdr.de>; Sun,  5 Dec 2021 22:39:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239429AbhLEVnJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 5 Dec 2021 16:43:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44384 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232165AbhLEVnH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 5 Dec 2021 16:43:07 -0500
Received: from mail-pj1-x1035.google.com (mail-pj1-x1035.google.com [IPv6:2607:f8b0:4864:20::1035])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 28F9EC061714;
        Sun,  5 Dec 2021 13:39:40 -0800 (PST)
Received: by mail-pj1-x1035.google.com with SMTP id x7so6296112pjn.0;
        Sun, 05 Dec 2021 13:39:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=nJ+Pla7ZGvHQEHUB3DSoauogXISC+UwH9TH03jV2caw=;
        b=Qu1A6lJOOwziop+bTtc3cOXfWdWTDsa3dc9dlGvErHl24bKZY0yUOGeJX3GEfdOLg7
         R8z/DLAZFKXvHQsvZOsHzy/aBqYotqU8B2g5jAi+/7TBUG37f85ZR8H93ZUdU/E7rJqu
         XTuxzVFk5Do3MtQ4XO5VG73SWtYhhkFO4lXGrDKBTWumxIYLS+bJgUj8ehJe0o4DlOol
         6snfjGiaC5tYFMw2+jUKMwlW/w0Hikok4dPOZIsZtMdPAASV35LJZj2i+1r6O4d/bLI4
         Dxv1u80vSeTPlgmW/sKK+qd7h4mnIJnn6bfMwn4ZWJzeOATv2KpJuQcK6gfWtO/deV6t
         c3bg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=nJ+Pla7ZGvHQEHUB3DSoauogXISC+UwH9TH03jV2caw=;
        b=TUPJSvGDS4/GsyWkPUWqIBEHObK2sWMNIcQNaIS25Wy5/thCStjYFn74g/U+Ljfr3t
         rbeYf1N4NbLN3S0auYAAC/jgeefeIA45kuRDLK7Tw+UbLMpUgT4tnCmgFx2zfBDlVQue
         TdSHZl3VWh02zvInN96WdzugvNd1ZMM//mquSly3z0lL1iAEmBx8kSFyqKogpOyS1DPc
         VEEEdbOfAkPYbMJyuqFLP4Ab56HhU2H11L93sgDvjFYNrvLJkhlHaMq7qJ2Jj+gmDhkv
         sR1rddPsgyoRGMi2x1cMhOzm7/UX5hnryvTReDWhnbrTTfRAHTo1AbVBm8wwSMpq1bfF
         diMQ==
X-Gm-Message-State: AOAM531/yBuA1G+vIGOf8TC0jKNpUDtlajxNrDpcUiTqihU6sKtLLTiU
        EhPk4ikbRXpflDl/C4KI5Gc=
X-Google-Smtp-Source: ABdhPJywN0CepSJUH0wjIwIrZ3rw8E0BK/gq2Ajuc86GPVBeZ7JkGYLHgMeH+DFvYhicvdNwkCM7gw==
X-Received: by 2002:a17:90b:4c02:: with SMTP id na2mr32444046pjb.94.1638740379199;
        Sun, 05 Dec 2021 13:39:39 -0800 (PST)
Received: from localhost ([2409:10:24a0:4700:e8ad:216a:2a9d:6d0c])
        by smtp.gmail.com with ESMTPSA id il7sm8365725pjb.54.2021.12.05.13.39.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 05 Dec 2021 13:39:38 -0800 (PST)
Date:   Mon, 6 Dec 2021 06:39:36 +0900
From:   Stafford Horne <shorne@gmail.com>
To:     Gabriel Somlo <gsomlo@gmail.com>
Cc:     linux-kernel@vger.kernel.org, robh+dt@kernel.org,
        devicetree@vger.kernel.org, ulf.hansson@linaro.org,
        linux-mmc@vger.kernel.org, kgugala@antmicro.com,
        mholenko@antmicro.com, krakoczy@antmicro.com,
        mdudek@internships.antmicro.com, paulus@ozlabs.org, joel@jms.id.au,
        geert@linux-m68k.org, david.abdurachmanov@sifive.com,
        florent@enjoy-digital.fr
Subject: Re: [PATCH v1 3/3] mmc: Add driver for LiteX's LiteSDCard interface
Message-ID: <Ya0xmCTrp7BJmiBs@antec>
References: <20211203234155.2319803-1-gsomlo@gmail.com>
 <20211203234155.2319803-4-gsomlo@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211203234155.2319803-4-gsomlo@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 03, 2021 at 06:41:55PM -0500, Gabriel Somlo wrote:
> LiteX (https://github.com/enjoy-digital/litex) is a SoC framework
> that targets FPGAs. LiteSDCard is a small footprint, configurable
> SDCard core commonly used in LiteX designs.
> 
> The driver was first written in May 2020 and has been maintained
> cooperatively by the LiteX community. Thanks to all contributors!
> 
> Co-developed-by: Kamil Rakoczy <krakoczy@antmicro.com>
> Signed-off-by: Kamil Rakoczy <krakoczy@antmicro.com>
> Co-developed-by: Maciej Dudek <mdudek@internships.antmicro.com>
> Signed-off-by: Maciej Dudek <mdudek@internships.antmicro.com>
> Co-developed-by: Paul Mackerras <paulus@ozlabs.org>
> Signed-off-by: Paul Mackerras <paulus@ozlabs.org>
> Signed-off-by: Gabriel Somlo <gsomlo@gmail.com>
> Cc: Mateusz Holenko <mholenko@antmicro.com>
> Cc: Karol Gugala <kgugala@antmicro.com>
> Cc: Joel Stanley <joel@jms.id.au>
> Cc: Stafford Horne <shorne@gmail.com>
> Cc: Geert Uytterhoeven <geert@linux-m68k.org>
> Cc: David Abdurachmanov <david.abdurachmanov@sifive.com>
> Cc: Florent Kermarrec <florent@enjoy-digital.fr>
> ---
>  drivers/mmc/host/Kconfig     |   6 +
>  drivers/mmc/host/Makefile    |   1 +
>  drivers/mmc/host/litex_mmc.c | 677 +++++++++++++++++++++++++++++++++++
>  3 files changed, 684 insertions(+)
>  create mode 100644 drivers/mmc/host/litex_mmc.c
> 
> diff --git a/drivers/mmc/host/Kconfig b/drivers/mmc/host/Kconfig
> index 5af8494c31b5..84c64e72195d 100644
> --- a/drivers/mmc/host/Kconfig
> +++ b/drivers/mmc/host/Kconfig
> @@ -1093,3 +1093,9 @@ config MMC_OWL
>  
>  config MMC_SDHCI_EXTERNAL_DMA
>  	bool
> +
> +config MMC_LITEX
> +	tristate "Support for the MMC Controller in LiteX SOCs"
> +	depends on OF && LITEX
> +	help
> +	  Generic MCC driver for LiteX

I just noticed this while configuring the kernel.  This doesn't really follow
the pattern of other drivers, we should think of putting "Litex" near the
beginning of the line. It makes it easier to spot in menuconfig.

For example:

LiteX MMC Controller support

This selects support for the MMC Host Controller found in LiteX SOCs.

It unsure, say N.

-Stafford
