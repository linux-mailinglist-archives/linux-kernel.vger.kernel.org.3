Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 93BE54D154D
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Mar 2022 11:58:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346061AbiCHK7Y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Mar 2022 05:59:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48316 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245311AbiCHK7V (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Mar 2022 05:59:21 -0500
Received: from mail-lf1-x135.google.com (mail-lf1-x135.google.com [IPv6:2a00:1450:4864:20::135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9798821E1B
        for <linux-kernel@vger.kernel.org>; Tue,  8 Mar 2022 02:58:24 -0800 (PST)
Received: by mail-lf1-x135.google.com with SMTP id g17so7993729lfh.2
        for <linux-kernel@vger.kernel.org>; Tue, 08 Mar 2022 02:58:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=4MO/RRuWikHJmBYuiJ+R2IrUU7oSQM4tuZv70kuUbRI=;
        b=k3G503hqW26oHasEdtGWNmqrChEPSR064D0K46cqUj1wayPtOGD/xufqe5xAva/q2z
         Ffqx6+329fNYW9gSOuqz2AAXgGMHll/goOEg9fZEiNOXJXN8f8TRAfB8+UO0rvWEEp4U
         Rada8pn/BfE4qTuiNtbOiPIZ98UZ1PeaMGHmCpvaIGNVHsTrVX7eRs+r2Fdwhj1flLyK
         PCNHcxe7N27lE1Ji7giCwvePKEoMIlX4Opu0W6g/YgQw1tx/OpyFKDMvY0b0lAhyiXHp
         Qi2hTE7F3assUB0/w+hogn/mpzP4x+Wd4/vMzE+ib2IsK9gr64AAZp2LZS6s1kvowSL3
         22sg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=4MO/RRuWikHJmBYuiJ+R2IrUU7oSQM4tuZv70kuUbRI=;
        b=BVj4Katp9Bq/mlDulduS615KUdtBG3bglcd8vM1jGdXD+fXT7FqMO6F1zZX7DLMvTU
         l6p6wxwrPvMzudlEkao5avv2LTa4LHn01auQMUgJ6AZaB+9qVWWt3QrUWkyGUJE0/61d
         nIRN4ox+PpG4b/LHcud32OV4Dl90l28ag2TO3F2HNsoKTeyS3bgzpst4+/SujD8vDVET
         oTyBvJBXJRWCWfDiQwNQ/FW1lVlGlW2q9c8xEUFiAnipRE3dFuDuhQzHbbUsWfxVj63h
         TZBxuGFOH7zC1lOoUL9fJ6YA5zSvg90eAPzGk/gXT15CISH6qiqy1lUGcuEEjn9BqclM
         WqSA==
X-Gm-Message-State: AOAM533e2GeAZqhINiIoPoZ8AwyZYY8a6ztfbjNwHjteiN9OyJ58t+sp
        brrZEHgXSHo8we/cpAp73dml6SXQ6GrkQTVZOF+k9Q==
X-Google-Smtp-Source: ABdhPJw0ckIBbPI+QJkJYQsR/aHyPcFqI/Cbo2S1aK5o3fb6YXZSOQqQEvVnX9hlK1NxMKgitnE8GWNY+dSwqtFAvpc=
X-Received: by 2002:a05:6512:3e0c:b0:448:3480:1fe5 with SMTP id
 i12-20020a0565123e0c00b0044834801fe5mr4512406lfv.358.1646737102778; Tue, 08
 Mar 2022 02:58:22 -0800 (PST)
MIME-Version: 1.0
References: <20220304135134.47827-1-yann.gautier@foss.st.com> <20220304135134.47827-2-yann.gautier@foss.st.com>
In-Reply-To: <20220304135134.47827-2-yann.gautier@foss.st.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Tue, 8 Mar 2022 11:57:46 +0100
Message-ID: <CAPDyKFq_TsBLjW2WxC-Fvu6qDs9MJ1=QPo9gOLRykJ5p2pJbGw@mail.gmail.com>
Subject: Re: [PATCH 1/3] dt-bindings: mmc: mmci: add a property to disable DMA LLI
To:     Yann Gautier <yann.gautier@foss.st.com>
Cc:     Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-mmc@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Christophe Kerello <christophe.kerello@foss.st.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Ludovic Barre <ludovic.barre@foss.st.com>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Russell King <linux@armlinux.org.uk>,
        Marek Vasut <marex@denx.de>, kernel@dh-electronics.com,
        Manivannan Sadhasivam <mani@kernel.org>,
        Grzegorz Szymaszek <gszymaszek@short.pl>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Yann,

On Fri, 4 Mar 2022 at 14:52, Yann Gautier <yann.gautier@foss.st.com> wrote:
>
> On STMicroelectronics variant of PL18x, the DMA Linked Lists are supported
> starting from revision v2 of the peripheral. But it has limitations,
> as all the buffers should be aligned on block size (except the last one).
> But this cannot be guaranteed with SDIO. We should then have a property
> to disable the support of LLI.

Indeed, the buffer handling with SDIO is somewhat special, which also
has been discussed several times on LKML before. In principle, we need
the SDIO func drivers to respect buffer limitations that should be
specified by the mmc host drivers. Quite similar to what we already
have for block devices, like ->max_seg_size, ->max_seg, etc, that is
set per mmc host.

I realize that implementing something like the above requires bigger
changes, which is why mmc host drivers instead validates the sglists
and the elements. In some cases that means returning an error code and
in others it could mean falling back to a non-DMA based I/O mode.

For the stm32_sdmmc variant, it looks like the sglist validation is
being managed in sdmmc_idma_validate_data() already. Can it be
extended to cover this case too, rather than using a DT property?

Kind regards
Uffe

>
> Signed-off-by: Yann Gautier <yann.gautier@foss.st.com>
> ---
>  Documentation/devicetree/bindings/mmc/arm,pl18x.yaml | 5 +++++
>  1 file changed, 5 insertions(+)
>
> diff --git a/Documentation/devicetree/bindings/mmc/arm,pl18x.yaml b/Documentation/devicetree/bindings/mmc/arm,pl18x.yaml
> index 1e69a5a42439..309a2c0426e5 100644
> --- a/Documentation/devicetree/bindings/mmc/arm,pl18x.yaml
> +++ b/Documentation/devicetree/bindings/mmc/arm,pl18x.yaml
> @@ -145,6 +145,11 @@ properties:
>        driver to sample the receive data (for example with a voltage switch
>        transceiver).
>
> +  st,disable-dma-lli:
> +    $ref: /schemas/types.yaml#/definitions/flag
> +    description: ST Micro-specific property, disable DMA linked lists.
> +      It is used for SDIO.
> +
>    st,cmd-gpios:
>      maxItems: 1
>      description:
> --
> 2.25.1
>
