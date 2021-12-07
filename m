Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1DE6E46C746
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Dec 2021 23:11:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237463AbhLGWO7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Dec 2021 17:14:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43738 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231497AbhLGWO6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Dec 2021 17:14:58 -0500
Received: from mail-qv1-xf35.google.com (mail-qv1-xf35.google.com [IPv6:2607:f8b0:4864:20::f35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C01AC061746;
        Tue,  7 Dec 2021 14:11:27 -0800 (PST)
Received: by mail-qv1-xf35.google.com with SMTP id j9so656847qvm.10;
        Tue, 07 Dec 2021 14:11:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=YeqMcRL24uU8L8jSYtK9oZvCSTZuod3lCl978cM0i7k=;
        b=LNgGhSb/djRR9C9Jc5srWNfenVVSycx4zZRLZ2tUWReIZzwpSibNv3yH2WfKu4PuLK
         l+G1V0xSlLQmgpOEHYU/FgA5Djd4IX6dZnO6fcOf4oPu8NsMoF/joDo9ExNnZKjAkcvq
         H5DGoPWJX6udP5lMBVa/56Z5K+37akhI3mAiKvV+pUEoQXRN622A0svI8RpUV5p2NoeA
         OLhNNj0ktyKoWtOitqOO48fd5vBgWnirM6FuUbBBCbhsb5tJ/2R6FEgx7G6Yt5tYGJRo
         GGfUkcjZkJxUfwJzBdffK17zsImLk4/e3Dc6z3MUgrcULBtwa/+8mBvgP6W2si79+/Za
         PO1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=YeqMcRL24uU8L8jSYtK9oZvCSTZuod3lCl978cM0i7k=;
        b=QZ4jnyLqoCWcLVaiEO8JpMwSLV5Z9Pv19vlUldoXNtPQOu6meUJnDDJlgvFB6Xqcw8
         0GdDJJ9AV4kF/ranOGh/Jewt6YISBNcjW4EuFF8XcGy8IdvbJONQEF9xo/DuwVoHakd4
         yvrulP2DbYP9hU1UENKCeiYobtxbz/NagO01VaHM5VhQpmntyxMUIqDQ0IXzfRbu6o3Z
         ICrDnRBZGoYSDQ7m110ZOpCnCKIFyLRw391P79Xx3I9oj/4cVK/I3f9G2JOUAQS4MSpO
         pSfXjUopYgBGMqzmlUIcvqn7OYPOxyfBNeuQLEyJvTRlHzrlsAIYrGXqa2Y/dpSNGdCH
         N6XQ==
X-Gm-Message-State: AOAM532nNggKkPk44Qi48XX/cTCX5fzQtucuq87EcwvWePpkoGhxS5go
        4MLh6cuVW+6GeG4FAlvm27k=
X-Google-Smtp-Source: ABdhPJyqKFe5Q47dThDEhsq7dALEbqeNtCZlIrkjFouZd/hQz0goq4RmikUEva4dav6PZqtnEWX47w==
X-Received: by 2002:a0c:e84b:: with SMTP id l11mr2643533qvo.25.1638915086163;
        Tue, 07 Dec 2021 14:11:26 -0800 (PST)
Received: from errol.ini.cmu.edu (pool-108-39-235-221.pitbpa.fios.verizon.net. [108.39.235.221])
        by smtp.gmail.com with ESMTPSA id d23sm462958qkl.70.2021.12.07.14.11.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Dec 2021 14:11:25 -0800 (PST)
Date:   Tue, 7 Dec 2021 17:11:23 -0500
From:   "Gabriel L. Somlo" <gsomlo@gmail.com>
To:     Joel Stanley <joel@jms.id.au>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
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
        Geert Uytterhoeven <geert@linux-m68k.org>,
        david.abdurachmanov@sifive.com,
        Florent Kermarrec <florent@enjoy-digital.fr>,
        Randy Dunlap <rdunlap@infradead.org>
Subject: Re: [PATCH v2 1/3] MAINTAINERS: co-maintain LiteX platform
Message-ID: <Ya/cC+8ewBa7HG9J@errol.ini.cmu.edu>
References: <20211204204121.2367127-1-gsomlo@gmail.com>
 <20211204204121.2367127-2-gsomlo@gmail.com>
 <CACPK8XcNHwGanjyxeRxQU55FXQCv6aizOa33qbD93G7-GizVmw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CACPK8XcNHwGanjyxeRxQU55FXQCv6aizOa33qbD93G7-GizVmw@mail.gmail.com>
X-Clacks-Overhead: GNU Terry Pratchett
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 06, 2021 at 11:59:47PM +0000, Joel Stanley wrote:
> On Sat, 4 Dec 2021 at 20:41, Gabriel Somlo <gsomlo@gmail.com> wrote:
> >
> > Add the litex_mmc (LiteSDCard) driver to the list of files maintained
> > under LiteX, and add myself as co-maintainer. I've helped develop some
> > of the existing drivers, and am currently curating the out-of-tree
> > drivers as they are tested and prepared for upstream submission.
> >
> > Cc: Karol Gugala <kgugala@antmicro.com>
> > Cc: Mateusz Holenko <mholenko@antmicro.com>
> > Signed-off-by: Gabriel Somlo <gsomlo@gmail.com>
> 
> Acked-by: Joel Stanley <joel@jms.id.au>
> 
> If this is going to be a catch all for the drivers as well as the
> platform, we're probably missing a few entries:
> 
> $ git grep -l litex
> Documentation/admin-guide/kernel-parameters.txt
> Documentation/devicetree/bindings/net/litex,liteeth.yaml
> Documentation/devicetree/bindings/serial/litex,liteuart.yaml
> Documentation/devicetree/bindings/soc/litex/litex,soc-controller.yaml
> Documentation/devicetree/bindings/vendor-prefixes.yaml
> Documentation/sphinx/kfigure.py
> MAINTAINERS
> arch/openrisc/boot/dts/or1klitex.dts
> arch/openrisc/configs/or1klitex_defconfig
> arch/powerpc/boot/dts/microwatt.dts
> drivers/net/ethernet/Kconfig
> drivers/net/ethernet/Makefile
> drivers/net/ethernet/litex/Makefile
> drivers/net/ethernet/litex/litex_liteeth.c
> drivers/soc/Kconfig
> drivers/soc/Makefile
> drivers/soc/litex/Kconfig
> drivers/soc/litex/Makefile
> drivers/soc/litex/litex_soc_ctrl.c
> drivers/tty/serial/liteuart.c
> include/linux/litex.h
> scripts/clang-tools/gen_compile_commands.py
> 
> I think we could add these entries to maintainers:
> 
> +F:     drivers/soc/litex/*
> +F:     drivers/net/ethernet/litex/*
> +N:     litex

Done.
 
> I would also add my name there.

Added you as proposed co-maintainer, will publish soon as part
of [PATCH v3] series.

Thanks much,
--Gabriel
 
> > ---
> >  MAINTAINERS | 2 ++
> >  1 file changed, 2 insertions(+)
> >
> > diff --git a/MAINTAINERS b/MAINTAINERS
> > index faa9c34d837d..5fc65d4c4969 100644
> > --- a/MAINTAINERS
> > +++ b/MAINTAINERS
> > @@ -11012,12 +11012,14 @@ F:    lib/list-test.c
> >  LITEX PLATFORM
> >  M:     Karol Gugala <kgugala@antmicro.com>
> >  M:     Mateusz Holenko <mholenko@antmicro.com>
> > +M:     Gabriel Somlo <gsomlo@gmail.com>
> >  S:     Maintained
> >  F:     Documentation/devicetree/bindings/*/litex,*.yaml
> >  F:     arch/openrisc/boot/dts/or1klitex.dts
> >  F:     drivers/soc/litex/litex_soc_ctrl.c
> >  F:     drivers/tty/serial/liteuart.c
> >  F:     include/linux/litex.h
> > +F:     drivers/mmc/host/litex_mmc.c
> >
> >  LIVE PATCHING
> >  M:     Josh Poimboeuf <jpoimboe@redhat.com>
> > --
> > 2.31.1
> >
