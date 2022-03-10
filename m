Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6D12D4D4A21
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Mar 2022 15:53:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243521AbiCJOXA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Mar 2022 09:23:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40422 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244237AbiCJOTD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Mar 2022 09:19:03 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B4CE816EAA5;
        Thu, 10 Mar 2022 06:15:48 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id D52D961C99;
        Thu, 10 Mar 2022 14:15:02 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 47E1CC340E8;
        Thu, 10 Mar 2022 14:15:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1646921702;
        bh=yo5cNZOSv/J/WvklnDG16ry9Bw3elHchQ9q/vBCqvbQ=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=maGHS2m9LDj84cxFFYKfEByaP+07rvv+owPqT7QN/rWpqfNcEJIgelSZsi89z4YEO
         eQ1qFs24G5TKKZ37vfsaWUuoahmWC2QwUDpYhUJOWTcA5ftlnYtglXuIm3C+NzvXVX
         gBXYfhzm3t7ZnwmCGQflz+r+w3644ExZdU582Wf+q3jK8KdwigqrOzzNj+ZaARW29C
         7hn4UDgR975l1tpTzDFBwdz4PbSL/O4tpE2aHK4RWiwc0aMs1RoAbAgXX3XjuS86s3
         HePHW4K+4ISCDz6AYjeZei8oxFadEePkK2O4JH54dDvQ9xfKcmwPJoy+iQaWP2GBHv
         67tYi9URG2iMw==
Received: by mail-ed1-f51.google.com with SMTP id w4so7136387edc.7;
        Thu, 10 Mar 2022 06:15:02 -0800 (PST)
X-Gm-Message-State: AOAM533sFQ6Hbbpfbrv8YOLkfiPhbxZKL1SafpwCxR7e05ac5nwXrzTk
        mQQIcSGNUYNUX0PJA3TAFi6msy0GoFfApICOQg==
X-Google-Smtp-Source: ABdhPJxTKjB6jCuITpAJueLD1jR/nypmp0A/gmHHrMEnwEcpJdUe3bQ2Gx3VCz4Rpb6k9VX70aM1nvGlH0UAjjLTElI=
X-Received: by 2002:a05:6402:5256:b0:416:97d1:a6a2 with SMTP id
 t22-20020a056402525600b0041697d1a6a2mr4571157edd.280.1646921700547; Thu, 10
 Mar 2022 06:15:00 -0800 (PST)
MIME-Version: 1.0
References: <20211224161334.31123-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <20211224161334.31123-3-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <c5ea7235-8642-6a89-f4ce-bd0861b6e4aa@linaro.org> <CA+V-a8tkhERx+8zDae5aWkNQ9Oxd1AamRL=i4TDC2X8RGgAo0w@mail.gmail.com>
 <5e13c1ba-0bf5-e360-c350-e7a1a1402350@linaro.org>
In-Reply-To: <5e13c1ba-0bf5-e360-c350-e7a1a1402350@linaro.org>
From:   Rob Herring <robh+dt@kernel.org>
Date:   Thu, 10 Mar 2022 08:14:48 -0600
X-Gmail-Original-Message-ID: <CAL_Jsq+CWKvkHMNhAa3o_rSLy_+AoHi6wkB3MRM8O3jJ5sG_Wg@mail.gmail.com>
Message-ID: <CAL_Jsq+CWKvkHMNhAa3o_rSLy_+AoHi6wkB3MRM8O3jJ5sG_Wg@mail.gmail.com>
Subject: Re: [PATCH] slimbus: qcom-ngd-ctrl: Use platform_get_irq() to get the interrupt
To:     Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Cc:     "Lad, Prabhakar" <prabhakar.csengg@gmail.com>,
        Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        alsa-devel <alsa-devel@alsa-project.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-7.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 10, 2022 at 4:42 AM Srinivas Kandagatla
<srinivas.kandagatla@linaro.org> wrote:
>
>
>
> On 10/03/2022 10:23, Lad, Prabhakar wrote:
> > On Thu, Mar 10, 2022 at 10:16 AM Srinivas Kandagatla
> > <srinivas.kandagatla@linaro.org> wrote:
> >>
> >>
> >>
> >> On 24/12/2021 16:13, Lad Prabhakar wrote:
> >>> platform_get_resource(pdev, IORESOURCE_IRQ, ..) relies on static
> >>> allocation of IRQ resources in DT core code, this causes an issue
> >>
> >> Are you saying that we should not be using platform_get_resource(pdev,
> >> IORESOURCE_IRQ, ...) on drivers that support DT?

We should be using platform_get_irq(). (period, on all platform drivers)

> >>> when using hierarchical interrupt domains using "interrupts" property
> >>> in the node as this bypasses the hierarchical setup and messes up the
> >>> irq chaining.
> >>
> >> Should this not be fixed in the DT core itself?
> >>
> > Yes the plan is to fix in the DT core itself (refer [0]).
> >
> > [0] https://patchwork.kernel.org/project/linux-renesas-soc/patch/20211209001056.29774-1-prabhakar.mahadev-lad.rj@bp.renesas.com/
> >
> >>>
> >>> In preparation for removal of static setup of IRQ resource from DT core
> >>> code use platform_get_irq().
> >>
> >> I would prefer this patch to be part of the series that removes IRQ
> >> resource handling from DT core.
> >>
> > Since there are too many users (which are in different subsystems)
> > getting this all in single series would be a pain. As a result it is
> > split up into individual subsystems.
> Am happy for this to be included in that series,
> TBH, this patch make more sense along with that series than by itself.

No it doesn't. This is no different than converting to devm_* variants
or other cleanups to match current preferred styles.

Treewide cross subsystem clean-ups are a huge pain to merge. Why would
you ask for that when it is clearly not necessary?

Rob
