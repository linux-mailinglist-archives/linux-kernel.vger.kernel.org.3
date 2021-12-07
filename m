Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8580346AF7C
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Dec 2021 01:53:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378843AbhLGA4t (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Dec 2021 19:56:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53678 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233971AbhLGA4s (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Dec 2021 19:56:48 -0500
Received: from mail-qk1-x730.google.com (mail-qk1-x730.google.com [IPv6:2607:f8b0:4864:20::730])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 83F1EC061746;
        Mon,  6 Dec 2021 16:53:19 -0800 (PST)
Received: by mail-qk1-x730.google.com with SMTP id 193so13035471qkh.10;
        Mon, 06 Dec 2021 16:53:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=Z1q2/3rib5uzRhPpLfMtQIk1fNI3yt29/dY5pBavfIU=;
        b=PFaIc7ofJK6M47ZFm/IlVSwE5OaYDmpHxknxg9DpnDkyIJ1vrRPjWw+FIycOO5oW1f
         goAvTcwfTScAr92mULOpYI05BqcZT4ELckOTKHQ+YR4+8ggkBLjzxBn+MLfeiNR7uBu1
         Unn0Z+/dGwhNqBLy6OgV5ffEuuRjQIWsNhqmQLmvzEzl4vlRPY+e1IH5KDZyjjaKNkVR
         ltDbf0i9myEt9Ulv+/e332gPkZ9ZB80Ns+wQNTlL6Pk1wxg60iZAY0SiS89cCLdM5zm5
         Cc0rzyrIWMsPb3UB/AJjTyIKrm1r3XmXZNLCn4IWD1t53rbtHtPYxle3uk6jzUigDj1r
         ic3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=Z1q2/3rib5uzRhPpLfMtQIk1fNI3yt29/dY5pBavfIU=;
        b=dwCGnQYOQxjlpqA40ec6Jy/NB/yDTvCTPFDmkUd2Y9ggPVVxmrzrXelYyBgmIThHRi
         ty7zxsGY9kg19FybqkUIliWudMAnGkUSNngbV3k5co7AGkcGLjfrmzieo3Ubv25enR2H
         VphHSuziQY7viUSGdt35xZ71INsZff1v00ZqBS3vQi4TiuZ0UHAILwLvyPtgb6yQQv4+
         occc/aydRmhlJgg9RrN5fgjz3nyQ34wkzCbOXvXRodtboByGTzR3S5Ne0e8ISe5Bnqpf
         NggH6poQNyh/BALmOeZ2kpQFXKNnjuhcLnb65b1amWDj0wA/uXJ7YHbjqcr27bWzZfJx
         iTlQ==
X-Gm-Message-State: AOAM532wb4Vv9qrOD90oZH7D7ZkReGkHvwJ9lqN9qpRVwKCSnc+5m8Bs
        P3sSNYtHPFVix7QzzHFglZo=
X-Google-Smtp-Source: ABdhPJwflO/MvFpOBrMourZpNEWwPQaz7F2yHFCuNh2CYOw4xjzDenD+GKaVJKt9DATGMoJbosSz0g==
X-Received: by 2002:a37:a5d3:: with SMTP id o202mr37520355qke.384.1638838398623;
        Mon, 06 Dec 2021 16:53:18 -0800 (PST)
Received: from errol.ini.cmu.edu (pool-108-39-235-221.pitbpa.fios.verizon.net. [108.39.235.221])
        by smtp.gmail.com with ESMTPSA id j14sm7355288qkp.28.2021.12.06.16.53.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Dec 2021 16:53:18 -0800 (PST)
Date:   Mon, 6 Dec 2021 19:53:16 -0500
From:   "Gabriel L. Somlo" <gsomlo@gmail.com>
To:     Joel Stanley <joel@jms.id.au>
Cc:     Geert Uytterhoeven <geert@linux-m68k.org>,
        Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        devicetree <devicetree@vger.kernel.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        linux-mmc <linux-mmc@vger.kernel.org>,
        Karol Gugala <kgugala@antmicro.com>,
        Mateusz Holenko <mholenko@antmicro.com>,
        Kamil Rakoczy <krakoczy@antmicro.com>,
        mdudek@internships.antmicro.com,
        Paul Mackerras <paulus@ozlabs.org>,
        Stafford Horne <shorne@gmail.com>,
        david.abdurachmanov@sifive.com,
        Florent Kermarrec <florent@enjoy-digital.fr>
Subject: Re: [PATCH v1 3/3] mmc: Add driver for LiteX's LiteSDCard interface
Message-ID: <Ya6wfKLohLYs+aNc@errol.ini.cmu.edu>
References: <20211203234155.2319803-1-gsomlo@gmail.com>
 <20211203234155.2319803-4-gsomlo@gmail.com>
 <CACPK8XfO_8=vgedmZddz1YmWbyxiM1-azF_j88wEBHzXnP6y_g@mail.gmail.com>
 <CAMuHMdXxO-CP0Ao8q8r4Gw5e5FzCznhSxt2JWz13zbnt2tnzVQ@mail.gmail.com>
 <CACPK8XdF6WQDj9X1Nr0Hf6EzPkQtXBo75dj_WPsFq6nzfWPUrA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CACPK8XdF6WQDj9X1Nr0Hf6EzPkQtXBo75dj_WPsFq6nzfWPUrA@mail.gmail.com>
X-Clacks-Overhead: GNU Terry Pratchett
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 06, 2021 at 11:51:22PM +0000, Joel Stanley wrote:
> On Mon, 6 Dec 2021 at 12:16, Geert Uytterhoeven <geert@linux-m68k.org> wrote:
> 
> > > > +       depends on OF && LITEX
> > >
> > > I don't like having litex drivers depend on the LITEX kconfig. The
> > > symbol is not user visible, and to enable it we need to build in the
> > > litex controller driver, which platforms may or may not have.
> > >
> > > The microwatt platform is an example of a SoC that embeds some LITEX
> > > IP, but may or may not be a litex SoC.
> >
> > I do like the LITEX dependency, as it allows us to gate off a bunch of
> > related drivers, and avoid annoying users with questions about them,
> > using a single symbol.
> 
> I appreciate your concern.
> 
> We could do this:
> 
>         depends on PPC_MICROWATT || LITEX || COMPILE_TEST

What about the current OF dependency? Is that covered by COMPILE_TEST,
or do we need an additional `depends on` line for it?

Thanks,
--G

> It's unfortunate that kconfig doesn't let us describe the difference
> between "this driver requires this symbol" as it won't build and "this
> driver is only useful when this symbol is enabled". Traditionally I
> write kconfig to represent only the former, whereas you prefer both.
> 
> > Originally, people told me the system controller is always present,
> > hence the current logic to have LITEX_SOC_CONTROLLER visible, and
> > an invisible LITEX (which is shorter to type) for individual drivers
> > to depend on.
> 
> That's another option. I think LITEX either needs to become visible,
> become selected by microwatt, or we adopt the proposal I made above
> for the litex drivers that the microwatt soc uses.
