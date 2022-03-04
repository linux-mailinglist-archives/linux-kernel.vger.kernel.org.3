Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3ADD84CD08A
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Mar 2022 09:55:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235225AbiCDI4I (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Mar 2022 03:56:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34714 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229789AbiCDI4E (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Mar 2022 03:56:04 -0500
Received: from mail-vk1-f169.google.com (mail-vk1-f169.google.com [209.85.221.169])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A5EC19DEB2
        for <linux-kernel@vger.kernel.org>; Fri,  4 Mar 2022 00:55:17 -0800 (PST)
Received: by mail-vk1-f169.google.com with SMTP id k9so4040790vki.4
        for <linux-kernel@vger.kernel.org>; Fri, 04 Mar 2022 00:55:17 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=L/NeTMxhGm+l5YpPOiR/XhgTXlp1h5VVk6yshpmQCRE=;
        b=CtSA4n+/rUy9LcAOcUcLDb64lEmWEJDnR/6VX/BtBqfWimtWydFLPlLu4rdpNvf6H1
         K1iGNtCTHnSvU22K0OkKHMzbfYg6sW+hcEjTaTHUUcLBRIvLa+vzz6AsgkqRMTo+GfuR
         MQsHmimijDzyA0xyaOLdX4bcx/uD3Nfe63oBwYuCVJIpJ1Xtk80zwzEJwS+Xm+KOCKz2
         3sD/0oPhyCexl7u3IOsAtNNMO0RzqVrQ6+g7dtgOQHrLosYhU65R7GBYcJNGo7InggVX
         TiCHU5Orx3S5cyaizEXdhu5p18sumbIYCMJmM1RHom7yTC4HIM7XacE3KtuDUxBivPdC
         viYw==
X-Gm-Message-State: AOAM530bA039WtKwnljZ1Efwh5VhjnaBzs3l2XrQUWkXhhFw6R2upAXc
        aLaxdRv4omOyJOaVgiK45CvCwn1KGzlCXw==
X-Google-Smtp-Source: ABdhPJzL9B+snhkuGLIoIdG6/BkYyQs+gpw4cZfSfky1Paoltfru+Q1WvkssEF1POO2u86G9PG0ufA==
X-Received: by 2002:ac5:c88f:0:b0:332:b8e:c085 with SMTP id n15-20020ac5c88f000000b003320b8ec085mr17314284vkl.6.1646384116688;
        Fri, 04 Mar 2022 00:55:16 -0800 (PST)
Received: from mail-ua1-f49.google.com (mail-ua1-f49.google.com. [209.85.222.49])
        by smtp.gmail.com with ESMTPSA id g16-20020ab00e10000000b0034a4433fe84sm699562uak.38.2022.03.04.00.55.16
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 04 Mar 2022 00:55:16 -0800 (PST)
Received: by mail-ua1-f49.google.com with SMTP id y44so3280397uac.11
        for <linux-kernel@vger.kernel.org>; Fri, 04 Mar 2022 00:55:16 -0800 (PST)
X-Received: by 2002:ab0:3da4:0:b0:306:a7f8:f28b with SMTP id
 l36-20020ab03da4000000b00306a7f8f28bmr17141959uac.47.1646384115825; Fri, 04
 Mar 2022 00:55:15 -0800 (PST)
MIME-Version: 1.0
References: <20220304033531.28667-1-rdunlap@infradead.org>
In-Reply-To: <20220304033531.28667-1-rdunlap@infradead.org>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Fri, 4 Mar 2022 09:55:04 +0100
X-Gmail-Original-Message-ID: <CAMuHMdWM_a7gmBw3gQd+BCTuFGpsHN3o9HuU=ivWnZraYXewqQ@mail.gmail.com>
Message-ID: <CAMuHMdWM_a7gmBw3gQd+BCTuFGpsHN3o9HuU=ivWnZraYXewqQ@mail.gmail.com>
Subject: Re: [PATCH] m68k: tweak coldfire/device.c for COMPILE_TEST
To:     Randy Dunlap <rdunlap@infradead.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        patches@lists.linux.dev, kernel test robot <lkp@intel.com>,
        Angelo Dureghello <angelo@sysam.it>,
        Greg Ungerer <gerg@kernel.org>,
        Greg Ungerer <gerg@linux-m68k.org>,
        linux-m68k <linux-m68k@lists.linux-m68k.org>,
        uClinux development list <uclinux-dev@uclinux.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Randy,

On Fri, Mar 4, 2022 at 4:35 AM Randy Dunlap <rdunlap@infradead.org> wrote:
> When CONFIG_MCF_EDMA is set (due to COMPILE_TEST, not due to
> CONFIG_M5441x), coldfire/device.c has compile errors due to
> missing MCFEDMA_* symbols. In the .config file that was provided,
> CONFIG_M5206=y, not CONFIG_M5441x, so <asm/m5441xsim.h> is not
> included in coldfire/device.c.
>
> Only build the MCF_EDMA code in coldfire/device.c if both MCF_EDMA
> and M5441x are enabled.
>
> Fixes these build errors:
>
> ../arch/m68k/coldfire/device.c:512:35: error: 'MCFEDMA_BASE' undeclared here (not in a function); did you mean 'MCFDMA_BASE1'?
>   512 |                 .start          = MCFEDMA_BASE,
> ../arch/m68k/coldfire/device.c:513:50: error: 'MCFEDMA_SIZE' undeclared here (not in a function)
>   513 |                 .end            = MCFEDMA_BASE + MCFEDMA_SIZE - 1,
> ../arch/m68k/coldfire/device.c:517:35: error: 'MCFEDMA_IRQ_INTR0' undeclared here (not in a function)
>   517 |                 .start          = MCFEDMA_IRQ_INTR0,
> ../arch/m68k/coldfire/device.c:523:35: error: 'MCFEDMA_IRQ_INTR16' undeclared here (not in a function)
>   523 |                 .start          = MCFEDMA_IRQ_INTR16,
> ../arch/m68k/coldfire/device.c:529:35: error: 'MCFEDMA_IRQ_INTR56' undeclared here (not in a function)
>   529 |                 .start          = MCFEDMA_IRQ_INTR56,
> ../arch/m68k/coldfire/device.c:535:35: error: 'MCFEDMA_IRQ_ERR' undeclared here (not in a function)
>   535 |                 .start          = MCFEDMA_IRQ_ERR,
>
> Fixes: d7e9d01ac292 ("m68k: add ColdFire mcf5441x eDMA platform support")
> Signed-off-by: Randy Dunlap <rdunlap@infradead.org>

Thanks for your patch!

> --- linux-next-20220303.orig/arch/m68k/coldfire/device.c
> +++ linux-next-20220303/arch/m68k/coldfire/device.c
> @@ -480,7 +480,7 @@ static struct platform_device mcf_i2c5 =
>  #endif /* MCFI2C_BASE5 */
>  #endif /* IS_ENABLED(CONFIG_I2C_IMX) */
>
> -#if IS_ENABLED(CONFIG_MCF_EDMA)
> +#if IS_ENABLED(CONFIG_MCF_EDMA) && IS_ENABLED(CONFIG_M5441x)

As this protects hardware description, I'm wondering if this and
below shouldn't just be"#ifdef CONFIG_M5441x"?

See also commit 322c512f476f07e9 ("m68knommu: include SDHC support
only when hardware has it")

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
