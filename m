Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C8D8854723A
	for <lists+linux-kernel@lfdr.de>; Sat, 11 Jun 2022 07:28:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350442AbiFKF2K (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 11 Jun 2022 01:28:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39756 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345965AbiFKF2C (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 11 Jun 2022 01:28:02 -0400
Received: from mail-yw1-x1136.google.com (mail-yw1-x1136.google.com [IPv6:2607:f8b0:4864:20::1136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 611DF6A00E
        for <linux-kernel@vger.kernel.org>; Fri, 10 Jun 2022 22:28:01 -0700 (PDT)
Received: by mail-yw1-x1136.google.com with SMTP id 00721157ae682-31336535373so9566117b3.2
        for <linux-kernel@vger.kernel.org>; Fri, 10 Jun 2022 22:28:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=KtaWcoAGVUWpa8COeQVX5nOZg3KfNhRwqB48xxrgvYY=;
        b=lTjzkKBXOx0+KKjlsLj+QplfboxQxEe3XZQuDoi5tV/FpHjCUrIbJSBO8l9PkmHhiG
         u9cFmCHQsKGXLtS0MxtR1WthkdKnqIH5mrkLCbadThYDrAQeruLTyqmvpM/ynjwH4GAr
         0TBgR/NHdatZOB2WU5iD+zkGEKMS5E333yjsEPkTQ8Bcow5TiKB+XkEob1o49e9yDpc0
         3r3aRwglLopYhREBMoJKbQkYjgg6MQlue5kZUZE3K492FrWyuI8Avq7yD3u6xWa7tzqZ
         /rL24lAWwC0mdxIvmcF9wbCVlJOr/BJyp+y1tWhL0o4KZ9viG9R3s8Ty0sn5puFhwdQb
         jWSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=KtaWcoAGVUWpa8COeQVX5nOZg3KfNhRwqB48xxrgvYY=;
        b=X3NNl5Mm5+3PVN7TPMQEcmjexV9bCKquSyKZRyI6B+5YARJOdV6U0Y0uastubIOckF
         pmd4zIPbs2bV3d0wSaWO4kAW3Uw45yLyDCzugItqAnW6b1mYPTtUOy777KxC+M5XbB9Y
         3fpBgAj0KYERWbTtUwtzER0oj1swIqgoyrQ7mj2kGmCIBHHvTxXZabp9CaIhB7u37MP0
         SECOLpvuwg3F2Nj/lvsUHk3t6fImJmL9R3YwEDZfCFGQ9aQox7LTZrVfU3852HUpFaUo
         bj7QZ03C7hTo6RVj4pn0GQaTg+H7w8rHCQ1v4HSXInWI3UqaY3hwQ3KLxblos2T2ev5I
         hnTg==
X-Gm-Message-State: AOAM5326KYlZ69cGTUOBqE5kTTiO+yYqkqPCEhNX90klpP59ZwXOZlGy
        9OTKNEpgjkaVOTY65sgirh34w/JIdX2KoEC+Gzc5Qg==
X-Google-Smtp-Source: ABdhPJwLTZP6Fi253xeMCxYftfDPlNh/MGW5n7fQpLNMCzv2G/kL2ZcE78GOBiNU6b72I/yYsP+YG47yBoeUFjxJHtE=
X-Received: by 2002:a81:9b0c:0:b0:2f4:c522:7d3c with SMTP id
 s12-20020a819b0c000000b002f4c5227d3cmr52513063ywg.316.1654925279564; Fri, 10
 Jun 2022 22:27:59 -0700 (PDT)
MIME-Version: 1.0
References: <20220316200633.28974-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
In-Reply-To: <20220316200633.28974-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
From:   Yongqin Liu <yongqin.liu@linaro.org>
Date:   Sat, 11 Jun 2022 13:27:48 +0800
Message-ID: <CAMSo37US03pKhPR=a1sJnWMF6L+WDvhWz469G=+0XY2WX-p=bg@mail.gmail.com>
Subject: Re: [RFC PATCH] of/platform: Drop static setup of IRQ resource from
 DT core
To:     Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Cc:     Rob Herring <robh+dt@kernel.org>, Marc Zyngier <maz@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Prabhakar <prabhakar.csengg@gmail.com>,
        linux-renesas-soc@vger.kernel.org,
        Biju Das <biju.das.jz@bp.renesas.com>
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

Hi, Lad

# sorry for the confusion if you have received it before with the
non-plain-text mode

In this change you said "all the DT drivers have switched to
platform_get_irq()",
could you please help share with me one example about the above change
as reference?
We have one hikey960 android build with some out of tree changes,
which could not boot
successfully with some errors on surfaceflinger(I am not sure it's a
problem with the gpu or display),
but could boot if I have this change reverted.

I guess it needs some changes on the gpu/display dts or driver side to
have it work
with this change, not sure if you could give some suggestions on the fix.

And here are two out of tree changes might be related listed here just
for reference in case:
https://android-review.linaro.org/c/kernel/common/+/21680
https://android-review.linaro.org/c/kernel/common/+/21682

Thanks in advance!

On Thu, 17 Mar 2022 at 04:07, Lad Prabhakar
<prabhakar.mahadev-lad.rj@bp.renesas.com> wrote:
>
> Now that all the DT drivers have switched to platform_get_irq() we can now
> safely drop the static setup of IRQ resource from DT core code.
>
> With the above change hierarchical setup of irq domains is no longer
> bypassed and thus allowing hierarchical interrupt domains to describe
> interrupts using "interrupts" DT property.
>
> Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
> ---
> Hi All,
>
> Sending this as RFC as couple of more drivers need to hit -rc yet with
> the platform_get_irq() change while that is in progress I wanted to get
> some feedback on this patch.
>
> Cheers,
> Prabhakar
> ---
>  drivers/of/platform.c | 14 +++++---------
>  1 file changed, 5 insertions(+), 9 deletions(-)
>
> diff --git a/drivers/of/platform.c b/drivers/of/platform.c
> index 793350028906..6890f7fe556f 100644
> --- a/drivers/of/platform.c
> +++ b/drivers/of/platform.c
> @@ -114,35 +114,31 @@ struct platform_device *of_device_alloc(struct device_node *np,
>                                   struct device *parent)
>  {
>         struct platform_device *dev;
> -       int rc, i, num_reg = 0, num_irq;
> +       int rc, i, num_reg = 0;
>         struct resource *res, temp_res;
>
>         dev = platform_device_alloc("", PLATFORM_DEVID_NONE);
>         if (!dev)
>                 return NULL;
>
> -       /* count the io and irq resources */
> +       /* count the io resources */
>         while (of_address_to_resource(np, num_reg, &temp_res) == 0)
>                 num_reg++;
> -       num_irq = of_irq_count(np);
>
>         /* Populate the resource table */
> -       if (num_irq || num_reg) {
> -               res = kcalloc(num_irq + num_reg, sizeof(*res), GFP_KERNEL);
> +       if (num_reg) {
> +               res = kcalloc(num_reg, sizeof(*res), GFP_KERNEL);
>                 if (!res) {
>                         platform_device_put(dev);
>                         return NULL;
>                 }
>
> -               dev->num_resources = num_reg + num_irq;
> +               dev->num_resources = num_reg;
>                 dev->resource = res;
>                 for (i = 0; i < num_reg; i++, res++) {
>                         rc = of_address_to_resource(np, i, res);
>                         WARN_ON(rc);
>                 }
> -               if (of_irq_to_resource_table(np, res, num_irq) != num_irq)
> -                       pr_debug("not all legacy IRQ resources mapped for %pOFn\n",
> -                                np);
>         }
>
>         dev->dev.of_node = of_node_get(np);
> --
> 2.17.1
>


-- 
Best Regards,
Yongqin Liu
---------------------------------------------------------------
#mailing list
linaro-android@lists.linaro.org
http://lists.linaro.org/mailman/listinfo/linaro-android
