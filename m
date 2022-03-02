Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EDDCF4C9BCF
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Mar 2022 04:09:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239258AbiCBDJ7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Mar 2022 22:09:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50796 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233684AbiCBDJ5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Mar 2022 22:09:57 -0500
Received: from mail-qk1-x72a.google.com (mail-qk1-x72a.google.com [IPv6:2607:f8b0:4864:20::72a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F2B4E0EA;
        Tue,  1 Mar 2022 19:09:15 -0800 (PST)
Received: by mail-qk1-x72a.google.com with SMTP id bm39so325175qkb.0;
        Tue, 01 Mar 2022 19:09:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=jms.id.au; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=HT+Mtr5Nff2ageK7dbN94vU/EQesBvLqX1yuZAcRck0=;
        b=dPwC/rmwjWPNXK0t7BJJ6dux5/N4QJAp73A5BHoQ0+Jun3fMu1eTDALAhU/Kej566l
         5mmW8OoScc5wlCGRRZ0A/w+ktM2veKscRQZ+SkcbGcxf/XtnnHPEMYmXhA6kfSOXV5lw
         3lUH9hcra2VpuWd1zOOxPJuC/ZY1W9dmgH0GU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=HT+Mtr5Nff2ageK7dbN94vU/EQesBvLqX1yuZAcRck0=;
        b=ENarzyOMdljNSA4eQIJHQnFOyN/Fcp8j/SwY5bFmISSF8bPHXc28vb1Hosygk1wlMo
         n8wpQi4AMQCDyPy2C9WemjjiBvAvji/2hp4cHwtkO9Pu6Fh+tM12rN+G6rMIcOR0lNdW
         lJdpJ67HT2p30OrBzp5NCW52uW1zVzO9d7DzoZx6Qnjic6gRxmmSl7LFFF0yg6A+p5We
         LIz6jBMJ04Vb/utpAyLcgq4G30uTjvlXhYq+ZfQ6Oi/xWlnZyjz6+Z7FeuV1yNKB3HqH
         lI0K5YhMTZBcdEu/duNRAon8OQ1J6OBTF6yAr0Vgn+xWbK/VTBugT5djOA8C/wZZZJhN
         1pZQ==
X-Gm-Message-State: AOAM5332P59VWrEBFz99PgVvHzd0xpB1/0RT64VspgT9GlIqMO/kZ1Ph
        Su8/l5b32tcos29DocsOudr+job/GiX4fIZZFrg=
X-Google-Smtp-Source: ABdhPJxa0POJ5iMZchDS1hHP6nIyKRmvr9j5KH1/LsFO7CsMjnlOEqfR/0MoiiOCu3HDY273CUfvvjunpBaZrCv9ql0=
X-Received: by 2002:a37:a4d1:0:b0:508:19df:7093 with SMTP id
 n200-20020a37a4d1000000b0050819df7093mr15260167qke.346.1646190554732; Tue, 01
 Mar 2022 19:09:14 -0800 (PST)
MIME-Version: 1.0
References: <20220302024930.18758-1-tommy_huang@aspeedtech.com>
In-Reply-To: <20220302024930.18758-1-tommy_huang@aspeedtech.com>
From:   Joel Stanley <joel@jms.id.au>
Date:   Wed, 2 Mar 2022 03:09:02 +0000
Message-ID: <CACPK8XdKH5BaGC9mtgg17ndiJyOneuzzUbrLmxYZKmi6RRzzpg@mail.gmail.com>
Subject: Re: [PATCH v6 0/5] Add Aspeed AST2600 soc display support
To:     Tommy Haung <tommy_huang@aspeedtech.com>
Cc:     David Airlie <airlied@linux.ie>, Daniel Vetter <daniel@ffwll.ch>,
        Rob Herring <robh+dt@kernel.org>,
        Andrew Jeffery <andrew@aj.id.au>,
        linux-aspeed <linux-aspeed@lists.ozlabs.org>,
        "open list:DRM DRIVERS" <dri-devel@lists.freedesktop.org>,
        devicetree <devicetree@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        BMC-SW <BMC-SW@aspeedtech.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2 Mar 2022 at 02:49, Tommy Haung <tommy_huang@aspeedtech.com> wrote:
>
> v6:
>   Remove some unnecessary reset patch.
>   Refine patch format.
>   Add detail explain of SOC display reset bits.
>
> v5:
>   Add lost reset define.
>
> v4:
>   Add necessary reset control for ast2600.
>   Add chip caps for futher use.
>   These code are test on AST2500 and AST2600 by below steps.
>
>   1. Add below config to turn VT and LOGO on.
>
>         CONFIG_TTY=y
>         CONFIG_VT=y
>         CONFIG_CONSOLE_TRANSLATIONS=y
>         CONFIG_VT_CONSOLE=y
>         CONFIG_VT_CONSOLE_SLEEP=y
>         CONFIG_HW_CONSOLE=y
>         CONFIG_VT_HW_CONSOLE_BINDING=y
>         CONFIG_UNIX98_PTYS=y
>         CONFIG_LDISC_AUTOLOAD=y
>         CONFIG_DEVMEM=y
>         CONFIG_DUMMY_CONSOLE=y
>         CONFIG_FRAMEBUFFER_CONSOLE=y
>         CONFIG_FRAMEBUFFER_CONSOLE_DETECT_PRIMARY=y
>         CONFIG_LOGO=y
>         CONFIG_LOGO_LINUX_CLUT224=y
>
>   2. The Linux logo will be shown on the screen, when the BMC boot in Linux.
>
> v3:
>   Refine the patch for clear separate purpose.
>   Skip to send devicetree patch

Looks good! Thanks Tommy.

Reviewed-by: Joel Stanley <joel@jms.id.au>

I'll apply this once I've tested it on hardware.

>
> v2:
>   Remove some unnecessary patch.
>   Refine for reviwer request.
>
> v1:
>   First add patch.
>
> Joel Stanley (2):
>   ARM: dts: aspeed: Add GFX node to AST2600
>   ARM: dts: aspeed: ast2600-evb: Enable GFX device
>
> Tommy Haung (3):
>   drm/aspeed: Update INTR_STS handling
>   drm/aspeed: Add AST2600 chip support
>   ARM: dtsi: aspeed: Modified gfx reset control
>
>  arch/arm/boot/dts/aspeed-ast2600-evb.dts | 18 ++++++++++++++++++
>  arch/arm/boot/dts/aspeed-g6.dtsi         | 11 +++++++++++
>  drivers/gpu/drm/aspeed/aspeed_gfx.h      |  1 +
>  drivers/gpu/drm/aspeed/aspeed_gfx_drv.c  | 15 ++++++++++++++-
>  4 files changed, 44 insertions(+), 1 deletion(-)
>
> --
> 2.17.1
>
