Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7B296468DC4
	for <lists+linux-kernel@lfdr.de>; Sun,  5 Dec 2021 23:55:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240234AbhLEW7W (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 5 Dec 2021 17:59:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60880 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233708AbhLEW7U (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 5 Dec 2021 17:59:20 -0500
Received: from mail-qv1-xf31.google.com (mail-qv1-xf31.google.com [IPv6:2607:f8b0:4864:20::f31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE36EC061714;
        Sun,  5 Dec 2021 14:55:52 -0800 (PST)
Received: by mail-qv1-xf31.google.com with SMTP id jo22so8320256qvb.13;
        Sun, 05 Dec 2021 14:55:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=x4BE/2ekMYZncqKSBdfcsZ2Xml1sT0MJ8EFaPHNt/Xk=;
        b=c739cMCkAJmcW5ABq1xT3zL19Gh7kqa7wga+MF7zbLUUwUw3vj84sTNq/DneGJvgrc
         9ITQ7CasqKrtNWgtOZM/ZHo+A/cfvZXjV82KuN8bW7Pn+a842+ptquEJEeDGlRK4sIGr
         jVMvfHOpjt/on7BKaHBd2y2gKphTd9K5xcLkIbjxVQZ+rfWbD9aPGnhgiL9/HRsqTHB0
         RiL/4OQrfSl5yTZLwEW3uH020nhMACkMdvxJOuPFx3WVSRDp/gQAM2DaT5J7x7kyUGQF
         3tPlYS4rbrvXUpOlyi+TUAV1cEsExkcknj3fBr6YpdSUTWhrC7hkN5eoUTi0gHOhJIls
         mvPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=x4BE/2ekMYZncqKSBdfcsZ2Xml1sT0MJ8EFaPHNt/Xk=;
        b=J01LWnlRKawKxa3elTLYNCfDFFWeVX0dEbbLLAB5ofg21D7nTx5qloyd9IhIz5CDhE
         6td4itp3ZVEEm7waAe9kglfVp/VgawHAter35tzsbtuReKsg9c7dalmvE4sxxAN6Kg+r
         hbsNMoVXnUfEq0Bl/hLKR9taNOBJzXAhrPZIO1fzcvXTcCKD6DnJQ0IqGSwzbtptsVhi
         7gR7HlXOA6t3mNUncvOLHJB81vTkIkJ2xrIL9LL1q+ooC/a4XerpGIBYdfdsys1g5uQe
         rPE6+Wr/q6+jcK/IwP0R8UFkdbvFDdiAHuSFvIWltBJcT6nGgLCPaZFdB1E4BRNa1x71
         GN3Q==
X-Gm-Message-State: AOAM530wx0Qj4JWHQH6Mn69P4pI6YATCa6FzmwgV+iGnxVLk21xT5U16
        +K/g6MtFrlJz0k9O0WhSC4ONib9oyOOF3Q==
X-Google-Smtp-Source: ABdhPJxh2fGPGLOLAhv93R5egBnpM05S+E930g0u7W4OByJZLCcStSF4sQ1KwvoqFwHO1MtwVj3APg==
X-Received: by 2002:a05:6214:f6c:: with SMTP id iy12mr33231903qvb.29.1638744951768;
        Sun, 05 Dec 2021 14:55:51 -0800 (PST)
Received: from errol.ini.cmu.edu (pool-108-39-235-221.pitbpa.fios.verizon.net. [108.39.235.221])
        by smtp.gmail.com with ESMTPSA id j126sm5641242qke.103.2021.12.05.14.55.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 05 Dec 2021 14:55:51 -0800 (PST)
Date:   Sun, 5 Dec 2021 17:55:49 -0500
From:   "Gabriel L. Somlo" <gsomlo@gmail.com>
To:     Stafford Horne <shorne@gmail.com>
Cc:     linux-kernel@vger.kernel.org, robh+dt@kernel.org,
        devicetree@vger.kernel.org, ulf.hansson@linaro.org,
        linux-mmc@vger.kernel.org, kgugala@antmicro.com,
        mholenko@antmicro.com, krakoczy@antmicro.com,
        mdudek@internships.antmicro.com, paulus@ozlabs.org, joel@jms.id.au,
        geert@linux-m68k.org, david.abdurachmanov@sifive.com,
        florent@enjoy-digital.fr
Subject: Re: [PATCH v1 3/3] mmc: Add driver for LiteX's LiteSDCard interface
Message-ID: <Ya1Ddbe6+Ch2ZeFL@errol.ini.cmu.edu>
References: <20211203234155.2319803-1-gsomlo@gmail.com>
 <20211203234155.2319803-4-gsomlo@gmail.com>
 <Ya0xmCTrp7BJmiBs@antec>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Ya0xmCTrp7BJmiBs@antec>
X-Clacks-Overhead: GNU Terry Pratchett
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 06, 2021 at 06:39:36AM +0900, Stafford Horne wrote:
> On Fri, Dec 03, 2021 at 06:41:55PM -0500, Gabriel Somlo wrote:
> > LiteX (https://github.com/enjoy-digital/litex) is a SoC framework
> > that targets FPGAs. LiteSDCard is a small footprint, configurable
> > SDCard core commonly used in LiteX designs.
> > 
> > The driver was first written in May 2020 and has been maintained
> > cooperatively by the LiteX community. Thanks to all contributors!
> > 
> > Co-developed-by: Kamil Rakoczy <krakoczy@antmicro.com>
> > Signed-off-by: Kamil Rakoczy <krakoczy@antmicro.com>
> > Co-developed-by: Maciej Dudek <mdudek@internships.antmicro.com>
> > Signed-off-by: Maciej Dudek <mdudek@internships.antmicro.com>
> > Co-developed-by: Paul Mackerras <paulus@ozlabs.org>
> > Signed-off-by: Paul Mackerras <paulus@ozlabs.org>
> > Signed-off-by: Gabriel Somlo <gsomlo@gmail.com>
> > Cc: Mateusz Holenko <mholenko@antmicro.com>
> > Cc: Karol Gugala <kgugala@antmicro.com>
> > Cc: Joel Stanley <joel@jms.id.au>
> > Cc: Stafford Horne <shorne@gmail.com>
> > Cc: Geert Uytterhoeven <geert@linux-m68k.org>
> > Cc: David Abdurachmanov <david.abdurachmanov@sifive.com>
> > Cc: Florent Kermarrec <florent@enjoy-digital.fr>
> > ---
> >  drivers/mmc/host/Kconfig     |   6 +
> >  drivers/mmc/host/Makefile    |   1 +
> >  drivers/mmc/host/litex_mmc.c | 677 +++++++++++++++++++++++++++++++++++
> >  3 files changed, 684 insertions(+)
> >  create mode 100644 drivers/mmc/host/litex_mmc.c
> > 
> > diff --git a/drivers/mmc/host/Kconfig b/drivers/mmc/host/Kconfig
> > index 5af8494c31b5..84c64e72195d 100644
> > --- a/drivers/mmc/host/Kconfig
> > +++ b/drivers/mmc/host/Kconfig
> > @@ -1093,3 +1093,9 @@ config MMC_OWL
> >  
> >  config MMC_SDHCI_EXTERNAL_DMA
> >  	bool
> > +
> > +config MMC_LITEX
> > +	tristate "Support for the MMC Controller in LiteX SOCs"
> > +	depends on OF && LITEX
> > +	help
> > +	  Generic MCC driver for LiteX
> 
> I just noticed this while configuring the kernel.  This doesn't really follow
> the pattern of other drivers, we should think of putting "Litex" near the
> beginning of the line. It makes it easier to spot in menuconfig.
> 
> For example:
> 
> LiteX MMC Controller support
> 
> This selects support for the MMC Host Controller found in LiteX SOCs.
> 
> It unsure, say N.

Done, and also lined up for v3. Thanks!
--Gabriel
