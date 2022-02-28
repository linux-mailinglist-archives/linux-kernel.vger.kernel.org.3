Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 957B64C6625
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Feb 2022 10:53:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234545AbiB1Jx6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Feb 2022 04:53:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50382 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232079AbiB1Jx5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Feb 2022 04:53:57 -0500
Received: from mail-qk1-x735.google.com (mail-qk1-x735.google.com [IPv6:2607:f8b0:4864:20::735])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 445FB25F9;
        Mon, 28 Feb 2022 01:53:19 -0800 (PST)
Received: by mail-qk1-x735.google.com with SMTP id c7so9871135qka.7;
        Mon, 28 Feb 2022 01:53:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=jms.id.au; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=pc2xTazJcGjIwl7ZnhXxuCZmmMzULOqgCvZj3IlaMMY=;
        b=LNzfZAX5hieB9FG9FLsPTrIanGwIyMKmJnXN/c610bQayVeDntvgfS92u1OMqT5EPE
         y9Kx3Kd2H9XDu5uKrY/5hzx9MjcZUfKRWf/cDhEiK1rfoH6DQ6RTrSk0yxkASPnHujy9
         L7f2UJFZ/hIrFNXgGWbU5ySh13EaWvCsdP0wY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=pc2xTazJcGjIwl7ZnhXxuCZmmMzULOqgCvZj3IlaMMY=;
        b=PzZAr/UEP0GBCKoLAKgPr8F7jZKdVDaE2Kh52hu8c1nh3dVNlMH51ZlWU1Jy9UywhV
         DOkKqGtSMUPwCd/I4KuH7Sto6OnivMhkJHDabn7iSkbtLGEEXGb4I//ZehtJ67CRj54d
         QBHP8Iw0ROjbMna5u9rGIzZA/Alf93jpHHRbv8sObmycGksNzXka1tDpDmsLLln3gY2k
         7RbJJF1UkGU91OJrIk/GLU6mhQiBgW8y1Lo6kX+ZbBw7jMDWAI+ojpD0mnOtv22Geh/e
         s+/8WMos7scGzpGJVkl61SDG5orrALJC2/pi4ynQjinCVW8JyNtCzdjk5agg0kq9nm2V
         yCvA==
X-Gm-Message-State: AOAM532R6iTmsU0BrDqeNAg46C9QvrJMfkUmpqRbz++uP3Vmrmujt6l6
        4T7LCM/OyM9VYeM7+69IcXP2yM1X/Ik1kERaBRm5scfZbKpbJg==
X-Google-Smtp-Source: ABdhPJzMUyYueL8jtRtjblWTAghUCWnWt1dd02X0kcufstS2QoUPX8Pj046KPyailSEuY0MJAUQBLTTjgurg5sosZGs=
X-Received: by 2002:ae9:e841:0:b0:508:1f6e:f020 with SMTP id
 a62-20020ae9e841000000b005081f6ef020mr10495084qkg.243.1646041998337; Mon, 28
 Feb 2022 01:53:18 -0800 (PST)
MIME-Version: 1.0
References: <20211208013337.13806-1-tommy_huang@aspeedtech.com>
In-Reply-To: <20211208013337.13806-1-tommy_huang@aspeedtech.com>
From:   Joel Stanley <joel@jms.id.au>
Date:   Mon, 28 Feb 2022 09:53:06 +0000
Message-ID: <CACPK8XcTDUt8q+5s44nnFFK1XiisXw=PBoGaNZowGS7M-j=Phg@mail.gmail.com>
Subject: Re: [PATCH v5 0/7] Add Aspeed AST2600 soc display support
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

Hi Tommy,

On Wed, 8 Dec 2021 at 01:34, Tommy Haung <tommy_huang@aspeedtech.com> wrote:
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

Sorry for the long delay. I have tested your patches on an ast2600a3
evb and they worked. I have some questions about the reset lines that
I couldn't answer by reading the datasheet, so once they are cleared
up we can go ahead with merging your patches.

When you re-send, you will need to fix your git configuration so your
name appears correctly:

git config --global user.name "Tommy Haung"

And then for each patch, do this to fix up the authorship and the s-o-b line:

git commit --amend --reset-author -s

Cheers,

Joel



>
> v3:
>   Refine the patch for clear separate purpose.
>   Skip to send devicetree patch
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
> Tommy Haung (1):
>   dt-bindings:ast2600-clock Add CRT reset define
>
> tommy-huang (4):
>   drm/aspeed: Update INTR_STS handling
>   drm/aspeed: Add AST2600 chip support
>   drm/aspeed: Add reset and clock for AST2600
>   arm:boot:dts:aspeed-g6 Add more gfx reset control
>
>  arch/arm/boot/dts/aspeed-ast2600-evb.dts  | 18 +++++++
>  arch/arm/boot/dts/aspeed-g6.dtsi          | 13 +++++
>  drivers/gpu/drm/aspeed/aspeed_gfx.h       | 17 +++++-
>  drivers/gpu/drm/aspeed/aspeed_gfx_crtc.c  | 16 ++++++
>  drivers/gpu/drm/aspeed/aspeed_gfx_drv.c   | 65 +++++++++++++++++++++--
>  include/dt-bindings/clock/ast2600-clock.h |  1 +
>  6 files changed, 124 insertions(+), 6 deletions(-)
>
> --
> 2.17.1
>
