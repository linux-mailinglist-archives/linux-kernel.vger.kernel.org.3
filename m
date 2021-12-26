Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9A1CC47F965
	for <lists+linux-kernel@lfdr.de>; Sun, 26 Dec 2021 23:38:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234778AbhLZWiR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 26 Dec 2021 17:38:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40612 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234756AbhLZWiO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 26 Dec 2021 17:38:14 -0500
Received: from mail-qt1-x82a.google.com (mail-qt1-x82a.google.com [IPv6:2607:f8b0:4864:20::82a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 212D9C06173E;
        Sun, 26 Dec 2021 14:38:14 -0800 (PST)
Received: by mail-qt1-x82a.google.com with SMTP id q14so12170838qtx.10;
        Sun, 26 Dec 2021 14:38:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=Dla9HZIWln/w38OHK9SyCVvQ87bxB06+YbK7BEZQNuk=;
        b=kD1AOoMph9bR4Z7V3dI87abKcVvDIFzS+XuKaZcQdnAOsbbAQfdbILdUiEkHEtn/+B
         5vS8Gj6VGr6wLvhGRf371UNx8k0SvqhX4uIeZOqaC3BNLL9lTwcm3/tNEJ5XNOW/miNt
         TeLQyAdmvSlYsv12qc8NmaXfgys4OwBwe2KQrz4uhG/derqnYDIoqRbjWtBlojH/O5uE
         OKZKTUBzcErGjinsjZy1i/tMaBYXI4VWY9jRMt1oKpgvOAb8ILObb7804MZkXnHVmPyT
         87S0EKQ8jpT1ZCcKf9GFdvA69omVIse4YcqfemBKyJf3B4haZDb/ZnNvNmuuDETx4+0g
         kWmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=Dla9HZIWln/w38OHK9SyCVvQ87bxB06+YbK7BEZQNuk=;
        b=zWbLu81lrek4lLP8/tUljglUhYVs6cIQV2W54++8e4G7aqnrnuGfNNyVDeTdbKll1a
         zj6gre8UUwOlVlxaeZ0UtCJ/0GKb9Dx8cr6VJBUoozg506467cm9XKvWySw3yb5YwUW1
         wbTN1qHsmPWyApEj24FY0Pc/srlCGKNRzf3SJ6eejXhfRrRpILHRld1wskjst9+1FGHy
         sOHAfurLXoKp56bOCCCxjbe04MbvTFqvvC6Uqidg1OiI0Z4q6ShaGP9pbIkCN1l20fMd
         DYSxd6xVkkESuQNSap9nKJ8yAAffbJUQt2Z1OGGk2VhHayZumZZTB3il5sXomvi5wg0k
         CdOA==
X-Gm-Message-State: AOAM532zojs6mS6jTGI6WGDb9yEbYMwReQIe/i8AaNO3ZhdYo+kag7tT
        +uxkeqSMMZY3Ihcq9kHIzgYU0PxSpgnhTw==
X-Google-Smtp-Source: ABdhPJwIsWw5ueE5lr7FkHtsAXfzHMh7+pQ3ABzL4F/Id97HBHx1LHi9MVbrHbfJ8iV+UCeLPpcX9w==
X-Received: by 2002:ac8:1e1b:: with SMTP id n27mr12640728qtl.618.1640558293006;
        Sun, 26 Dec 2021 14:38:13 -0800 (PST)
Received: from glsvmlin.ini.cmu.edu (GLSVMLIN.INI.CMU.EDU. [128.2.16.9])
        by smtp.gmail.com with ESMTPSA id o17sm11863763qtv.87.2021.12.26.14.38.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 26 Dec 2021 14:38:12 -0800 (PST)
Date:   Sun, 26 Dec 2021 17:37:54 -0500
From:   "Gabriel L. Somlo" <gsomlo@gmail.com>
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        devicetree <devicetree@vger.kernel.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        linux-mmc <linux-mmc@vger.kernel.org>,
        Karol Gugala <kgugala@antmicro.com>,
        Mateusz Holenko <mholenko@antmicro.com>, krakoczy@antmicro.com,
        mdudek@internships.antmicro.com, paulus@ozlabs.org,
        Joel Stanley <joel@jms.id.au>,
        Stafford Horne <shorne@gmail.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        david.abdurachmanov@sifive.com, florent@enjoy-digital.fr,
        Randy Dunlap <rdunlap@infradead.org>
Subject: Re: [PATCH v5 3/3] mmc: Add driver for LiteX's LiteSDCard interface
Message-ID: <Ycjuwqgj9UV//dxd@glsvmlin.ini.cmu.edu>
References: <20211215130711.111186-1-gsomlo@gmail.com>
 <20211215130711.111186-4-gsomlo@gmail.com>
 <CAHp75Vf7ktdoBoOHVE72LO19vxZiQ82eBg9_xP2ywB6c4yqXWQ@mail.gmail.com>
 <YchV5UvIq7xgkbF6@glsvmlin.ini.cmu.edu>
 <CAHp75VfDq+QM30tmCy2Wg+fj+mqervh2=1LVD5BwyVmbm1PYgQ@mail.gmail.com>
 <Ychv7z6ggZGRY08l@glsvmlin.ini.cmu.edu>
 <CAHp75VcTZzqvOLEOs50PD48P55f_EnBHjDiNBS-LPfSXhMxRAQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHp75VcTZzqvOLEOs50PD48P55f_EnBHjDiNBS-LPfSXhMxRAQ@mail.gmail.com>
X-Clacks-Overhead: GNU Terry Pratchett
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Dec 26, 2021 at 04:01:03PM +0200, Andy Shevchenko wrote:
> On Sun, Dec 26, 2021 at 3:36 PM Gabriel L. Somlo <gsomlo@gmail.com> wrote:
> > On Sun, Dec 26, 2021 at 03:13:21PM +0200, Andy Shevchenko wrote:
> > > On Sun, Dec 26, 2021 at 1:45 PM Gabriel L. Somlo <gsomlo@gmail.com> wrote:
> > > > On Sat, Dec 25, 2021 at 06:43:22PM +0200, Andy Shevchenko wrote:
> > > > > On Wed, Dec 15, 2021 at 10:00 PM Gabriel Somlo <gsomlo@gmail.com> wrote:
> 
> ...
> 
> > > > > > +#ifdef CONFIG_ARCH_DMA_ADDR_T_64BIT
> > > > >
> > > > > Why under ifdeffery?
> > > >
> > > > Because I only want to do it on 64-bit capable architectures.
> > > >
> > > > The alternative would be to call
> > > >
> > > >   dma_set_mask_and_coherent(&pdev->dev, DMA_BIT_MASK(64));
> > > >
> > > > on *all* architectures, but ignore the returned error (-EIO,
> > > > presumably on architetures that only support 32-bit DMA).
> > >
> > > I don't understand why you are supposed to ignore errors and why you
> > > expect to get such.
> >
> > If I call `dma_set_mask_and_coherent(&pdev->dev, DMA_BIT_MASK(64));`
> > on a machine where `CONFIG_ARCH_DMA_ADDR_T_64BIT` is *not* set, I
> > expect an error. The implicit default
> > (per Documentation/core-api/dma-api-howto.rst), is DMA_BIT_MASK(32).
> > I'm working under the impression that on machines with
> > CONFIG_ARCH_DMA_ADDR_T_64BIT I should increase that to DMA_BIT_MASK(64).
> >
> > So if I don't #ifdef it, that call will fail on machines supporting
> > only 32-bits.
> >
> > What am I missing?
> 
> This thread: https://lkml.org/lkml/2021/6/7/398 ?

OK, so just call `dma_set_mask_and_coherent(&pdev->dev, DMA_BIT_MASK(64));`
regardless of 32- or 64-bit dma capability, *do* check the return value,
and it should *not* fail on 32-bit systems.

I'll do that in v6 (should go out in early January '22, since I'm traveling
with only occasional email access at the moment).

Thanks,
--Gabriel
