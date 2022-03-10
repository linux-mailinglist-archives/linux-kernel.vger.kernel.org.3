Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D1F184D3EF0
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Mar 2022 02:49:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234493AbiCJBt5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Mar 2022 20:49:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50724 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230310AbiCJBt4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Mar 2022 20:49:56 -0500
Received: from mail-yb1-xb2a.google.com (mail-yb1-xb2a.google.com [IPv6:2607:f8b0:4864:20::b2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 374951168F7;
        Wed,  9 Mar 2022 17:48:56 -0800 (PST)
Received: by mail-yb1-xb2a.google.com with SMTP id e186so8062044ybc.7;
        Wed, 09 Mar 2022 17:48:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=1bLFaEO8mOotUe50ZxcYVhyRYpxUpsrpzjYVsiD2crY=;
        b=okRt2sjdarUbFOvYxqa+MiC6FqIGlYjtkYgvjUGqx0oUvh9zbaVJlod0YPIMc1NOho
         sUGY4zrOxfYezQN/KNemtXHsN7oS1GE0kcWIS2uFpH7ueLnflcPEVrV1WtolKcBUOX0e
         W34A4KJj0SodBs1o2DTWwJJq0yn7stTDNRwmNLQs+ITs4jQg02py36luWd6NVlG7oAPw
         w3ZUUvzWlpRxig7MyGQrAAIniItOSCT6MWKgN97bJr4IXVfxmfXytRDvWqk3LdVZr34A
         GJzMQV+otuRvyUvpx/H/cNyqV7xJnpgWVgJvefbtrdvK16Ripp2nmgUzeMxKvMfSvUSn
         j9Yw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=1bLFaEO8mOotUe50ZxcYVhyRYpxUpsrpzjYVsiD2crY=;
        b=RqI3lwrWlofT2GS2ICYYOZ/MG2mnVP7zIx6l9Uxj2pIojHqVabpa4XyHfCGC3BR0Xu
         SxHDv4JG5J5D6Z+ZVbT/g83PCp7mSznObEbRMHFYU56ZrXa3bJWe7v2cVUPMu53XngEv
         KB3hJr4WN8Gm5VNk5JcIYdOqdWWtGp8SBvUiEOjLPyzXdjq+pjv7hwYHrsUCHR+zXITV
         KHTalINtho0XRqTGL7Pw4KvpAR2abJvqOGLcbbHgZsjaauntlHsAVRSMMYZnWZeHMht/
         APDOVDtiFwVW4beoLDKnc2QAnFJ67n6Ym039MllzlEIluM4s+C+O9t/Sj19r3vOt4TIV
         GxoA==
X-Gm-Message-State: AOAM530Wn7rEr9K5/7fSnMMQgYGm+4l/QNdHV7xaPGp7zJLkhZ2Ts6h7
        BVYqIMpd1rJ7fMVU1hGPu0IW4eyaQkC08f5vWzg=
X-Google-Smtp-Source: ABdhPJxIdVI2E/S4Q3a5l3PHvoEWzspgq0xDfqimguAi8hOWMxPm06Tq6J2Cxxa0VKkWSwOghbFdX5nVmjuGUe8H2eU=
X-Received: by 2002:a25:8289:0:b0:623:dc4d:28e5 with SMTP id
 r9-20020a258289000000b00623dc4d28e5mr2137425ybk.182.1646876935381; Wed, 09
 Mar 2022 17:48:55 -0800 (PST)
MIME-Version: 1.0
References: <20211224161334.31123-1-prabhakar.mahadev-lad.rj@bp.renesas.com> <20211224161334.31123-3-prabhakar.mahadev-lad.rj@bp.renesas.com>
In-Reply-To: <20211224161334.31123-3-prabhakar.mahadev-lad.rj@bp.renesas.com>
From:   "Lad, Prabhakar" <prabhakar.csengg@gmail.com>
Date:   Thu, 10 Mar 2022 01:48:29 +0000
Message-ID: <CA+V-a8t4gpiSM2uF59wHA=eF+yDcss90OzL=2CiBNSq6A2FwJw@mail.gmail.com>
Subject: Re: [PATCH] slimbus: qcom-ngd-ctrl: Use platform_get_irq() to get the interrupt
To:     Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Cc:     Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        linux-arm-msm@vger.kernel.org,
        alsa-devel <alsa-devel@alsa-project.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Srinivas,

On Fri, Dec 24, 2021 at 4:13 PM Lad Prabhakar
<prabhakar.mahadev-lad.rj@bp.renesas.com> wrote:
>
> platform_get_resource(pdev, IORESOURCE_IRQ, ..) relies on static
> allocation of IRQ resources in DT core code, this causes an issue
> when using hierarchical interrupt domains using "interrupts" property
> in the node as this bypasses the hierarchical setup and messes up the
> irq chaining.
>
> In preparation for removal of static setup of IRQ resource from DT core
> code use platform_get_irq().
>
> Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
> ---
> Hi,
>
> Dropping usage of platform_get_resource() was agreed based on
> the discussion [0].
>
> [0] https://patchwork.kernel.org/project/linux-renesas-soc/
> patch/20211209001056.29774-1-prabhakar.mahadev-lad.rj@bp.renesas.com/
>
> Cheers,
> Prabhakar
> ---
>  drivers/slimbus/qcom-ngd-ctrl.c | 10 ++++------
>  1 file changed, 4 insertions(+), 6 deletions(-)
>
This patch is not in -next yet. When do you plan to merge this patch?

Cheers,
Prabhakar

> diff --git a/drivers/slimbus/qcom-ngd-ctrl.c b/drivers/slimbus/qcom-ngd-ctrl.c
> index 7040293c2ee8..0f29a08b4c09 100644
> --- a/drivers/slimbus/qcom-ngd-ctrl.c
> +++ b/drivers/slimbus/qcom-ngd-ctrl.c
> @@ -1526,13 +1526,11 @@ static int qcom_slim_ngd_ctrl_probe(struct platform_device *pdev)
>         if (IS_ERR(ctrl->base))
>                 return PTR_ERR(ctrl->base);
>
> -       res = platform_get_resource(pdev, IORESOURCE_IRQ, 0);
> -       if (!res) {
> -               dev_err(&pdev->dev, "no slimbus IRQ resource\n");
> -               return -ENODEV;
> -       }
> +       ret = platform_get_irq(pdev, 0);
> +       if (ret < 0)
> +               return ret;
>
> -       ret = devm_request_irq(dev, res->start, qcom_slim_ngd_interrupt,
> +       ret = devm_request_irq(dev, ret, qcom_slim_ngd_interrupt,
>                                IRQF_TRIGGER_HIGH, "slim-ngd", ctrl);
>         if (ret) {
>                 dev_err(&pdev->dev, "request IRQ failed\n");
> --
> 2.17.1
>
