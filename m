Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DFBAF552498
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Jun 2022 21:31:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244421AbiFTTay (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Jun 2022 15:30:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46868 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243168AbiFTTaw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Jun 2022 15:30:52 -0400
Received: from mail-lj1-x231.google.com (mail-lj1-x231.google.com [IPv6:2a00:1450:4864:20::231])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6133A1C121;
        Mon, 20 Jun 2022 12:30:50 -0700 (PDT)
Received: by mail-lj1-x231.google.com with SMTP id s10so12970159ljh.12;
        Mon, 20 Jun 2022 12:30:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=pQBAy3w43Lsg1Vd55OFU1l1n6Hjjm+3nJdTmhocMlC0=;
        b=lWlqRHF8cx0AdzUfpICgX2Sgfl+CphKetV+4r1YgFWLDRmcNuqFvrLAeMZcIfAOM6o
         nwjQsMa/M+KdVmMnMTRtHCWjQhhjJ5z8FwEuOLWt4TC4Q9zMI+fwpkD5moHe2WHv0neR
         RL2b/0o0x0GGT9kAdzTGyfpp4QHf2KIPAebdLQ1vvLL5fKS4oRO2YSRx2SuiCmNuCkgq
         n5hOTOafIBqM8s+yHFTtJ6xd505t0HL4Kgm/wPNPlwhh03C4YPJtbpPR/6koLq6ZxXmu
         2VbkjZhrW3BaMku1CZkAwTls5TsxdmMc8U2XDljV0wnadA+fX87WJNLyrPUjMG1HhUA4
         A9qw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=pQBAy3w43Lsg1Vd55OFU1l1n6Hjjm+3nJdTmhocMlC0=;
        b=f6r743d9nv9HiHPyUTijWTWZoeo2H/OGf8YE63y/mnZjKjCucoo2VqY2MrBKjEuh4s
         SMa6VZyRpV+2KQ3PeuhNyIrhcheTA4VH18rxgkvP+5UmAbO6jEFMew4txA4XKMfW1cmJ
         OsrQp72wc+YDSlRhtUK+zVgTwSkuSR8FDLW5HfGafkK8BrFdNuzFI691vonmjCN3uEF8
         Gqo0AU3EYpkDLSW2RMhfVZmeM93wRq3jEEhE4BvNR78EnKjhLzxnj7TlZTgnd4X5zypa
         v0mC6P7VJpELk2wfo9+4xNNZEfWrBBozL6HE0jEnhAXiFeaDEvklrzpA2dDGOo7BoD0d
         bkjg==
X-Gm-Message-State: AJIora8tMxqrnVEDv43g3xhJ+bNtQ1WhmRs8WrJwo808OprZ5OUm+ub8
        EPx+9fSzOVPsohI4/DnbXM8=
X-Google-Smtp-Source: AGRyM1u4WB/BMB0XCaSjIDbEA5ChWo+kYbNK8lsHacRuwUZdaSPgiCKHsGnONKh3eAgjggGcpABW2w==
X-Received: by 2002:a2e:8396:0:b0:25a:6dcd:e86 with SMTP id x22-20020a2e8396000000b0025a6dcd0e86mr3852006ljg.227.1655753448421;
        Mon, 20 Jun 2022 12:30:48 -0700 (PDT)
Received: from mobilestation ([95.79.189.214])
        by smtp.gmail.com with ESMTPSA id 2-20020ac25f42000000b0047f774bb512sm284068lfz.306.2022.06.20.12.30.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Jun 2022 12:30:47 -0700 (PDT)
Date:   Mon, 20 Jun 2022 22:30:44 +0300
From:   Serge Semin <fancer.lancer@gmail.com>
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
        robh+dt@kernel.org, samuel@sholland.org,
        suravee.suthikulpanit@amd.com, thomas.lendacky@amd.com,
        ulf.hansson@linaro.org, will@kernel.org, devicetree@vger.kernel.org
Subject: Re: [PATCH v5 04/15] dt-bindings: spi: dw: Add AMD Pensando Elba SoC
 SPI Controller bindings
Message-ID: <20220620193044.ihxfn6kddif7j5la@mobilestation>
References: <20220613195658.5607-1-brad@pensando.io>
 <20220613195658.5607-5-brad@pensando.io>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220613195658.5607-5-brad@pensando.io>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 13, 2022 at 12:56:47PM -0700, Brad Larson wrote:
> From: Brad Larson <blarson@amd.com>
> 
> The AMD Pensando Elba SoC has integrated the DW APB SPI Controller
> 
> Signed-off-by: Brad Larson <blarson@amd.com>
> ---
>  Documentation/devicetree/bindings/spi/snps,dw-apb-ssi.yaml | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/spi/snps,dw-apb-ssi.yaml b/Documentation/devicetree/bindings/spi/snps,dw-apb-ssi.yaml
> index e25d44c218f2..2a55b947cffc 100644
> --- a/Documentation/devicetree/bindings/spi/snps,dw-apb-ssi.yaml
> +++ b/Documentation/devicetree/bindings/spi/snps,dw-apb-ssi.yaml
> @@ -73,6 +73,8 @@ properties:
>                - renesas,r9a06g032-spi # RZ/N1D
>                - renesas,r9a06g033-spi # RZ/N1S
>            - const: renesas,rzn1-spi   # RZ/N1

> +      - description: AMD Pensando Elba SoC SPI Controller
> +        const: amd,pensando-elba-spi

Not enough. The driver requires to have a phandle reference to the
Pensando System Controller. So the property like
"amd,pensando-elba-syscon" is also needed to be added to the DT schema
otherwise should the dt-schema tool correctly handle the
"unevaluatedProperties: false" setting (Rob says it isn't fully
supported at the moment), the dtbs_check procedure will fail on your
dts evaluation.

-Sergey

>  
>    reg:
>      minItems: 1
> -- 
> 2.17.1
> 
