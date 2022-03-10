Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7B6B64D447B
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Mar 2022 11:25:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241232AbiCJKZh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Mar 2022 05:25:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43588 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241193AbiCJKZX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Mar 2022 05:25:23 -0500
Received: from mail-yb1-xb32.google.com (mail-yb1-xb32.google.com [IPv6:2607:f8b0:4864:20::b32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 185B113D57A;
        Thu, 10 Mar 2022 02:24:22 -0800 (PST)
Received: by mail-yb1-xb32.google.com with SMTP id v130so9871216ybe.13;
        Thu, 10 Mar 2022 02:24:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=6naJd+0sZQ29BmCLcmFwDc35DHsyxjzyXnqa9Mk7bLE=;
        b=bSUZuST0uigI2zFO4tPzF0IC7azGrfKIj/PG+/k1xdEKtZiiElVwRoCQvZfuqmeAeZ
         OVrZZGYYLEp4dDZ3LHEBQqB0JNg6h53oiyOOHsCpMC3nldgnHnjDjx+AT02qR4NQ9lEQ
         2dCaSvQ+V66ETNXQDHi+C+1pyJcUcHDqLMV35SJzQy/24nzyI805Nm1Swc3ENM29yfIu
         YHxvyM33XVMEikCfvHJAY97oDxtLUsBU4Fn8/L4AVjtoMCEDn4AE9qxy88wzqXvZHoY+
         AKgwTTxGrKVYK7bYNmsRFj5f76CvdUv0KSC0ZDGeUU+Umyq70LJgDqW6pnLIMMyuPvYY
         gARQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=6naJd+0sZQ29BmCLcmFwDc35DHsyxjzyXnqa9Mk7bLE=;
        b=SXclgPT57sSz/q/lcX2knUvgYzeMIuMovYl9nLM8Uew9rkKgY/1u/qmANLPSi4p2SX
         +iwxEyHy7e5GgsqmlLbHSymj4N/7+069Npaz0r/9++YqYFDYZKLMbg1+lz2tj9MVUFcx
         BHRIQWVdu8JYMddHFHaCanQAS2NxR9Q6DX5i0jhRVtukseIVXOYDabDQRy30vU0Yp9ro
         E14ONmqAooeAtHHz2iF5SNjL5Y4ztfJh5C5gNCkSm9mjRZLUHz02ZLQKKBkH8OPy7ryS
         rUXBXRefKw5MrzHWM5X+xMM0HE9nbfbOgIWJ4eXD52lNj7et3f4kR3h/PDywswGndHsi
         2pSg==
X-Gm-Message-State: AOAM531J6LeWf3x0ngzaQOX4HqSIJOY11xm4MMvGKbgGlRtPk1A06Ktv
        ClagK7K8pfiYUGgdFy85bTVirDrIwhA0BTUIjCI=
X-Google-Smtp-Source: ABdhPJwOa/BYCFgn16nyNygqP/E7e04kCx1eOH+kxuWtpClYMQmITCAztH4hZgVdpFrkt0U1rwRQrR4cizObCrrlTwk=
X-Received: by 2002:a5b:246:0:b0:619:5651:3907 with SMTP id
 g6-20020a5b0246000000b0061956513907mr3209140ybp.190.1646907861259; Thu, 10
 Mar 2022 02:24:21 -0800 (PST)
MIME-Version: 1.0
References: <20211224161334.31123-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <20211224161334.31123-3-prabhakar.mahadev-lad.rj@bp.renesas.com> <c5ea7235-8642-6a89-f4ce-bd0861b6e4aa@linaro.org>
In-Reply-To: <c5ea7235-8642-6a89-f4ce-bd0861b6e4aa@linaro.org>
From:   "Lad, Prabhakar" <prabhakar.csengg@gmail.com>
Date:   Thu, 10 Mar 2022 10:23:55 +0000
Message-ID: <CA+V-a8tkhERx+8zDae5aWkNQ9Oxd1AamRL=i4TDC2X8RGgAo0w@mail.gmail.com>
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

On Thu, Mar 10, 2022 at 10:16 AM Srinivas Kandagatla
<srinivas.kandagatla@linaro.org> wrote:
>
>
>
> On 24/12/2021 16:13, Lad Prabhakar wrote:
> > platform_get_resource(pdev, IORESOURCE_IRQ, ..) relies on static
> > allocation of IRQ resources in DT core code, this causes an issue
>
> Are you saying that we should not be using platform_get_resource(pdev,
> IORESOURCE_IRQ, ...) on drivers that support DT?
>
> > when using hierarchical interrupt domains using "interrupts" property
> > in the node as this bypasses the hierarchical setup and messes up the
> > irq chaining.
>
> Should this not be fixed in the DT core itself?
>
Yes the plan is to fix in the DT core itself (refer [0]).

[0] https://patchwork.kernel.org/project/linux-renesas-soc/patch/20211209001056.29774-1-prabhakar.mahadev-lad.rj@bp.renesas.com/

> >
> > In preparation for removal of static setup of IRQ resource from DT core
> > code use platform_get_irq().
>
> I would prefer this patch to be part of the series that removes IRQ
> resource handling from DT core.
>
Since there are too many users (which are in different subsystems)
getting this all in single series would be a pain. As a result it is
split up into individual subsystems.

Cheers,
Prabhakar

>
> --srini
>
> >
> > Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
> > ---
> > Hi,
> >
> > Dropping usage of platform_get_resource() was agreed based on
> > the discussion [0].
> >
> > [0] https://patchwork.kernel.org/project/linux-renesas-soc/
> > patch/20211209001056.29774-1-prabhakar.mahadev-lad.rj@bp.renesas.com/
> >
> > Cheers,
> > Prabhakar
> > ---
> >   drivers/slimbus/qcom-ngd-ctrl.c | 10 ++++------
> >   1 file changed, 4 insertions(+), 6 deletions(-)
> >
> > diff --git a/drivers/slimbus/qcom-ngd-ctrl.c b/drivers/slimbus/qcom-ngd-ctrl.c
> > index 7040293c2ee8..0f29a08b4c09 100644
> > --- a/drivers/slimbus/qcom-ngd-ctrl.c
> > +++ b/drivers/slimbus/qcom-ngd-ctrl.c
> > @@ -1526,13 +1526,11 @@ static int qcom_slim_ngd_ctrl_probe(struct platform_device *pdev)
> >       if (IS_ERR(ctrl->base))
> >               return PTR_ERR(ctrl->base);
> >
> > -     res = platform_get_resource(pdev, IORESOURCE_IRQ, 0);
> > -     if (!res) {
> > -             dev_err(&pdev->dev, "no slimbus IRQ resource\n");
> > -             return -ENODEV;
> > -     }
> > +     ret = platform_get_irq(pdev, 0);
> > +     if (ret < 0)
> > +             return ret;
> >
> > -     ret = devm_request_irq(dev, res->start, qcom_slim_ngd_interrupt,
> > +     ret = devm_request_irq(dev, ret, qcom_slim_ngd_interrupt,
> >                              IRQF_TRIGGER_HIGH, "slim-ngd", ctrl);
> >       if (ret) {
> >               dev_err(&pdev->dev, "request IRQ failed\n");
