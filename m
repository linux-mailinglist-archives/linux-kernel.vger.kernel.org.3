Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7D7044DC043
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Mar 2022 08:39:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230359AbiCQHkN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Mar 2022 03:40:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51252 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229727AbiCQHkL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Mar 2022 03:40:11 -0400
Received: from mail-qt1-f178.google.com (mail-qt1-f178.google.com [209.85.160.178])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9389AA27C3;
        Thu, 17 Mar 2022 00:38:55 -0700 (PDT)
Received: by mail-qt1-f178.google.com with SMTP id v14so3756041qta.2;
        Thu, 17 Mar 2022 00:38:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=m1V3fNiTEOwXPOKxaeq5HgKINKdqwd4xqVIZu/TZBMc=;
        b=uIFmswG3Om3948F1UaJHnoGYqDcxzgP3CzuxauyPTY8RDmmJKC+csotYKddbdzNGhG
         evAZ3oPuQhTHZcy1qBqGHdhznCR9mPr9mwJ2a6/qBC/F9ecUR8krnpz71OFd/Pd2Hwok
         5E+CsqHqOIR4Bj3vIG2uLTQ3821qBnZZXrxhLHk88RInsIlodu9/1YqOJ+LuAAVUJxbm
         e+jq+ieXkglgG+9nJQ6DGTcGdLt91v6MLowLjeFFTPICUVVzaCwCviIU8hkBfH8/jInl
         HJE1vMEaxrCTJA35tpZolE6qpWVxgK80GFLb7XrcVUdWh0cs/jS0Kpr+f0+w6z+cNIEv
         4zrg==
X-Gm-Message-State: AOAM531JmhkYainbud/rKXVlU34ofaJKLD34YtIriy9uAupmKgg5VEva
        Tp8LyXIuYiNscIyPcmyhzwTjdPY2zT+lUg==
X-Google-Smtp-Source: ABdhPJwNqtxhIyGXOe3B+dXkP8Iu9eXOvnfCIT9oVzRSP/lbAKRGwY7HlgDXq7YYUHjuD+LK/Elj0g==
X-Received: by 2002:ac8:5d86:0:b0:2e1:b9fd:ec24 with SMTP id d6-20020ac85d86000000b002e1b9fdec24mr2661289qtx.290.1647502733948;
        Thu, 17 Mar 2022 00:38:53 -0700 (PDT)
Received: from mail-yw1-f175.google.com (mail-yw1-f175.google.com. [209.85.128.175])
        by smtp.gmail.com with ESMTPSA id s81-20020a374554000000b0067e46c09859sm140639qka.21.2022.03.17.00.38.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 17 Mar 2022 00:38:52 -0700 (PDT)
Received: by mail-yw1-f175.google.com with SMTP id 00721157ae682-2dbd97f9bfcso48428637b3.9;
        Thu, 17 Mar 2022 00:38:52 -0700 (PDT)
X-Received: by 2002:a81:6dd1:0:b0:2dc:56d1:1dae with SMTP id
 i200-20020a816dd1000000b002dc56d11daemr4224334ywc.479.1647502731804; Thu, 17
 Mar 2022 00:38:51 -0700 (PDT)
MIME-Version: 1.0
References: <20220316211315.2819835-1-arnd@kernel.org>
In-Reply-To: <20220316211315.2819835-1-arnd@kernel.org>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Thu, 17 Mar 2022 08:38:40 +0100
X-Gmail-Original-Message-ID: <CAMuHMdX-Spi=M_0MiCunNE0boEeXH7sYr7pe1VBJkmg466vKrA@mail.gmail.com>
Message-ID: <CAMuHMdX-Spi=M_0MiCunNE0boEeXH7sYr7pe1VBJkmg466vKrA@mail.gmail.com>
Subject: Re: [PATCH 1/2] ARM: remove support for NOMMU ARMv4/v5
To:     Arnd Bergmann <arnd@kernel.org>
Cc:     Russell King <linux@armlinux.org.uk>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Ray Jui <rjui@broadcom.com>,
        Scott Branden <sbranden@broadcom.com>,
        bcm-kernel-feedback-list <bcm-kernel-feedback-list@broadcom.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Andrew Lunn <andrew@lunn.ch>,
        Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>,
        Gregory Clement <gregory.clement@bootlin.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Magnus Damm <magnus.damm@gmail.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Vladimir Murzin <vladimir.murzin@arm.com>,
        Ard Biesheuvel <ardb@kernel.org>,
        "Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>,
        Mark Rutland <mark.rutland@arm.com>,
        Anshuman Khandual <anshuman.khandual@arm.com>,
        John Crispin <john@phrozen.org>,
        Lukas Bulwahn <lukas.bulwahn@gmail.com>,
        Marc Zyngier <maz@kernel.org>, Jean Delvare <jdelvare@suse.de>,
        Stephen Boyd <sboyd@kernel.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux-Renesas <linux-renesas-soc@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Arnd,

On Wed, Mar 16, 2022 at 10:13 PM Arnd Bergmann <arnd@kernel.org> wrote:
> From: Arnd Bergmann <arnd@arndb.de>
>
> It is possible to build MMU-less kernels for Cortex-M base
> microcrontrollers as well as a couple of older platforms that
> have not been converted to CONFIG_ARCH_MULTIPLATFORM,
> specifically ep93xx, footbridge, dove, sa1100 and s3c24xx.
>
> It seems unlikely that anybody has tested those configurations
> in recent years, as even building them is frequently broken.
> A patch I submitted caused another build time regression
> in this configuration. I sent a patch for that, but it seems
> better to also remove the option entirely, leaving ARMv7-M
> as the only supported Arm NOMMU target for simplicity.
>
> A couple of platforms have dependencies on CONFIG_MMU, those
> can all be removed now. Notably, mach-integrator tries to
> support MMU-less CPU cores, but those have not actually been
> selectable for a long time.
>
> This addresses several build failures in randconfig builds that
> have accumulated over the years.
>
> Cc: Vladimir Murzin <vladimir.murzin@arm.com>
> Cc: Russell King <linux@armlinux.org.uk>
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>

Thanks for your patch!

Always feeling sad when seeing a feature is removed...

>  arch/arm/mach-shmobile/Kconfig                |  2 +-

Acked-by: Geert Uytterhoeven <geert+renesas@glider.be>

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
