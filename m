Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 797D546C328
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Dec 2021 19:51:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240762AbhLGSzA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Dec 2021 13:55:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51808 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236052AbhLGSy7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Dec 2021 13:54:59 -0500
Received: from mail-qk1-x72b.google.com (mail-qk1-x72b.google.com [IPv6:2607:f8b0:4864:20::72b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B03A5C061574;
        Tue,  7 Dec 2021 10:51:28 -0800 (PST)
Received: by mail-qk1-x72b.google.com with SMTP id t83so15641075qke.8;
        Tue, 07 Dec 2021 10:51:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=cSWJVy3Qek8jdmG8QIzpHbMKdFfl7J7QDZ7fULdlY1s=;
        b=fcUqtoJRKONoB+Rm6NeF8NLsI0tPZUiFdDizKcNmF2+08E42HOAUTfZR0K8N2BMZ9l
         9kXuRIQeX1VV/N+OsYN8vvnl6P5N3uoHWCxeBoL2xvS20aY1wDdxicwdYH7ZqToAcvIx
         IX45xtQEQN9X+HaqaXI3CtIrlwLh7IdM+5VIYTge4JkZGCFmgL8WwjztYNCw7odzVgCJ
         vBpm9EfQEgIMKnC5EnDbsNhvoh15kxHPjD+RZu4S5GbnymUfibChfskPfyMu5zTu4QTa
         qhJzpZoUxpncjiunB5ep2vTRtxKxMRcEjrBVXJuPqakQUlh1BxGotGC6kiJAUObhgpys
         eFXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=cSWJVy3Qek8jdmG8QIzpHbMKdFfl7J7QDZ7fULdlY1s=;
        b=jxSLmqD/SlzDLijYRpPPaZgth1njZ64uZ2KGOIfX6g5xg4ENitK35TUlKD8yo80XDx
         eLEKYuY3OJ3uqAQmzoHF4YsC2hvTiElG4NzEL7XWNEOzrHvyZVCxRB4eP0kUlQzzQm/A
         K1EMuJP57hTHlNoeKW2peG1ygG+Pjz8nBQjfNTxW95liktICKfFB0pBLl6SunX9xV8NX
         FyHVH/ZWGuBGSpYvxj1BZ1dcTOv4X/gCjPYKUz3yFMevVz/B2wwfLQijkNPRhPfT0YjL
         S0S/hWI1KoLYQ198ozY6rZs5ThBJp0U9A7X3K60cU3SYeVV/1ItIsRfrehSc96QuYjFi
         Byhg==
X-Gm-Message-State: AOAM530zL9IQsbZorPrlOQvzfYjj+gYk1t08mdu4ZTTnK69znLKWBLbG
        yF/zSPAztwfywj7g9Sr6txo=
X-Google-Smtp-Source: ABdhPJyFCG4ijT/B741AVvwG7qx4iLLq2KBtdAH45c1K3ulMd2Ov6nrSILSk0YC7oh0fcpIJ1ne/+Q==
X-Received: by 2002:a37:502:: with SMTP id 2mr1156992qkf.701.1638903087896;
        Tue, 07 Dec 2021 10:51:27 -0800 (PST)
Received: from errol.ini.cmu.edu (pool-108-39-235-221.pitbpa.fios.verizon.net. [108.39.235.221])
        by smtp.gmail.com with ESMTPSA id t6sm249736qkj.33.2021.12.07.10.51.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Dec 2021 10:51:27 -0800 (PST)
Date:   Tue, 7 Dec 2021 13:51:25 -0500
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
        Florent Kermarrec <florent@enjoy-digital.fr>
Subject: Re: [PATCH v1 3/3] mmc: Add driver for LiteX's LiteSDCard interface
Message-ID: <Ya+tLfsaPd/EFppJ@errol.ini.cmu.edu>
References: <20211203234155.2319803-1-gsomlo@gmail.com>
 <20211203234155.2319803-4-gsomlo@gmail.com>
 <CACPK8XfO_8=vgedmZddz1YmWbyxiM1-azF_j88wEBHzXnP6y_g@mail.gmail.com>
 <Ya63gv21Dmhi6J0s@errol.ini.cmu.edu>
 <CACPK8Xeg2UoAqp55R+UrRLFJqerc1Kqrubh3BiEpSon+Q6bGyQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CACPK8Xeg2UoAqp55R+UrRLFJqerc1Kqrubh3BiEpSon+Q6bGyQ@mail.gmail.com>
X-Clacks-Overhead: GNU Terry Pratchett
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Joel,

On Tue, Dec 07, 2021 at 02:46:03AM +0000, Joel Stanley wrote:
> On Tue, 7 Dec 2021 at 01:23, Gabriel L. Somlo <gsomlo@gmail.com> wrote:
> > > > [...]
> > > > +
> > > > +       ret = dma_set_mask(&pdev->dev, DMA_BIT_MASK(32));
> > >
> > > Is this going to be true on all platforms? How do we handle those
> > > where it's not true?
> >
> > I'll need to do a bit of digging here, unless anyone has ideas ready
> > to go...
> 
> I'm not an expert either, so let's consult the docs:
> 
> Documentation/core-api/dma-api-howto.rst
> 
> This suggests we should be using dma_set_mask_and_coherent?
> 
> But we're setting the mask to 32, which is the default, so perhaps we
> don't need this call at all?
> 
> (I was thinking of the microwatt soc, which is a 64 bit soc but the
> peripherals are on a 32 bit bus, and some of the devices are behind a
> smaller bus again. But I think we're ok, as the DMA wishbone is
> 32-bit).
 
So I did a bit of digging, and as it turns out the LiteX DMA base
registers are 64-bit wide, which I think means that they can
essentially do `xlen` bits of DMA addressing, at least when used
as part of a LiteX SoC (no idea what additional quirks occur if/when
LiteSDCard, or any other 64-bit-DMA-capable LiteX IP block would be
used as a standalone component in a different system).

Does this mean that, depending on maybe CONFIG_ARCH_DMA_ADDR_T_64BIT
or something similar, we should actually set DMA_BIT_MASK(64)? Maybe
something like:

#ifdef CONFIG_ARCH_DMA_ADDR_T_64BIT
	ret = dma_set_mask_and_coherent(&pdev->dev, DMA_BIT_MASK(64));
	if (ret)
		goto err;
#endif

Leave it to the default 32 unless we're on a 64-bit-DMA capable
system, in which case it's safe to assume we need the above setting?

What do you think, does that make sense?

Thanks,
--Gabriel
