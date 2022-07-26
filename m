Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C22D958161B
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Jul 2022 17:08:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238826AbiGZPIp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Jul 2022 11:08:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42966 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233844AbiGZPIn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Jul 2022 11:08:43 -0400
Received: from mail-lj1-x22b.google.com (mail-lj1-x22b.google.com [IPv6:2a00:1450:4864:20::22b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0FCE42ED79
        for <linux-kernel@vger.kernel.org>; Tue, 26 Jul 2022 08:08:42 -0700 (PDT)
Received: by mail-lj1-x22b.google.com with SMTP id p21so9181598ljh.12
        for <linux-kernel@vger.kernel.org>; Tue, 26 Jul 2022 08:08:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=zYxlO4qUEsJsTyo7qlyDijTEk/pzFLiwn3btcavQ1D0=;
        b=uuhHrIG6mqSq2NDpyxxWcAyvFfrfVFtOOHZKG2EWZ7K/XYXOltg3ag96J1R6NvFd8H
         NmrC2x6kfY6Da6UP06qsiBdDcpuhzSirWgF8kyxIV+dlIvV4CL/IB/yGrw5Co3S1AV44
         otfO7qj75+8vMwnCPysQmfZxIrkNyst0reNkHAIWQURn5GVIbp7QibZ38i0T4LTZwpxj
         JNHvSIS+FchHzNAV5XYxcBVm58uSOa3UufR6PNfTWmWWxd1KYFKdd5l+2TvfGg2YRl88
         XE5c1srEsmlMsGXlgrbn6AqIB87URnXhqWpswcu7LqTwgGiBD2DrS/9ef32bhh5XEe0M
         zUSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=zYxlO4qUEsJsTyo7qlyDijTEk/pzFLiwn3btcavQ1D0=;
        b=v79fKWnp8QE3oC6TeusTm0r7x1P+VtsBDRKNHooUWxz6RZDi6lmQhObxJNq3Fp3bTA
         oYKR/02s28SYu3DfIDw901qWsnAKddbldaQGp4TEGpA54p5Zat5jW4argp0eWlFT10yH
         xmiSqrhDiZiQpABvuPlTToKUk0YGWWbYPPmc7bcShivtLh6nqzal7AIhWaFSH49GktJ5
         dRXJgDb7ZRPEODe4rAXNukElONo+Fb7gohnS91ZF4vcJ/5Qdyukxn67oLlBNewHKJxKh
         sZNTwMj7ETUO3doWqK7rQe/J0PHTk63LVeIFXaUy6PK8iM5HxyCjtAqIg/1zcSIWj/Hi
         TP7g==
X-Gm-Message-State: AJIora+QhGMWAgbDbwkXCMrLHDiY5RO7SclMXyjlc6hJPW8sRe/28xEX
        mnVBcJkNF++hA65NtesUbW+EIcjQJUIVPYNq0++OLg==
X-Google-Smtp-Source: AGRyM1vnhd9AgeMqMzIkST0+/MXJDtwSb3YqzIyqyTqvlFcJcyaQaABNFhj6gPv8lwbSPKqYYTbIGbtjlIYJJDUyOMU=
X-Received: by 2002:a2e:900e:0:b0:25e:9fe:f8d4 with SMTP id
 h14-20020a2e900e000000b0025e09fef8d4mr3038980ljg.273.1658848120400; Tue, 26
 Jul 2022 08:08:40 -0700 (PDT)
MIME-Version: 1.0
References: <20220726083257.1730630-1-martin.kepplinger@puri.sm> <20220726083257.1730630-3-martin.kepplinger@puri.sm>
In-Reply-To: <20220726083257.1730630-3-martin.kepplinger@puri.sm>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Tue, 26 Jul 2022 17:08:03 +0200
Message-ID: <CAPDyKFrJjxm3Ljh0-oTGhOHRyg1+8xNkjDKE7+NE7mb_8C9dXQ@mail.gmail.com>
Subject: Re: [PATCH v6 2/2] soc: imx: gpcv2: fix suspend/resume by setting GENPD_FLAG_IRQ_ON
To:     Martin Kepplinger <martin.kepplinger@puri.sm>
Cc:     rafael@kernel.org, khilman@kernel.org, robh@kernel.org,
        krzysztof.kozlowski@linaro.org, shawnguo@kernel.org,
        s.hauer@pengutronix.de, festevam@gmail.com, pavel@ucw.cz,
        kernel@puri.sm, linux-imx@nxp.com, broonie@kernel.org,
        l.stach@pengutronix.de, aford173@gmail.com,
        linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 26 Jul 2022 at 10:33, Martin Kepplinger
<martin.kepplinger@puri.sm> wrote:
>
> For boards that use power-domains' power-supplies that need interrupts
> to work (like regulator over i2c), set GENPD_FLAG_IRQ_ON.
> This will tell genpd to adjust accordingly. Currently it "only" sets the
> correct suspend/resume callbacks.
>
> This fixes suspend/resume on imx8mq-librem5 boards (tested) and
> imx8mq-evk (by looking at dts) and possibly more.
>
> Signed-off-by: Martin Kepplinger <martin.kepplinger@puri.sm>

Reviewed-by: Ulf Hansson <ulf.hansson@linaro.org>

Kind regards
Uffe

> ---
>  drivers/soc/imx/gpcv2.c | 3 +++
>  1 file changed, 3 insertions(+)
>
> diff --git a/drivers/soc/imx/gpcv2.c b/drivers/soc/imx/gpcv2.c
> index 6383a4edc360..199a621d8186 100644
> --- a/drivers/soc/imx/gpcv2.c
> +++ b/drivers/soc/imx/gpcv2.c
> @@ -1337,6 +1337,9 @@ static int imx_pgc_domain_probe(struct platform_device *pdev)
>                 regmap_update_bits(domain->regmap, domain->regs->map,
>                                    domain->bits.map, domain->bits.map);
>
> +       if (of_property_read_bool(domain->dev->of_node, "power-supply"))
> +               domain->genpd.flags |= GENPD_FLAG_IRQ_ON;
> +
>         ret = pm_genpd_init(&domain->genpd, NULL, true);
>         if (ret) {
>                 dev_err(domain->dev, "Failed to init power domain\n");
> --
> 2.30.2
>
