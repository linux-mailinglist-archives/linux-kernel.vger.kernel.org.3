Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 30BDA48442D
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jan 2022 16:05:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234668AbiADPFk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Jan 2022 10:05:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34722 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232087AbiADPFi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Jan 2022 10:05:38 -0500
Received: from mail-yb1-xb30.google.com (mail-yb1-xb30.google.com [IPv6:2607:f8b0:4864:20::b30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B1CB3C061761;
        Tue,  4 Jan 2022 07:05:38 -0800 (PST)
Received: by mail-yb1-xb30.google.com with SMTP id e202so66151004ybf.4;
        Tue, 04 Jan 2022 07:05:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=BALCb4IQm/GwztxbFONFkzBgFbeC1YxSt8jC3/n5QF8=;
        b=MBvr7j9wSDxa6r+DmF54Rv/yAt8b8hBI2IPx2tvGlSHlgD7PU5JsTUtrfdU0HPFyg9
         SRNG87Uba7dDI3z3vHTqJlxhfgVDi1MmqMP4/R5AFausKLkZjGksTywEqzw+r/5zszl2
         8jwSpD8WJajqW9JXtrcTv3vIbAjWKeZuxGCcnnsXov70QKCraWZNID3JhDqdzCm9Aeg7
         JVD0TmqAU42OqLSt9on1NGyLr48UqwZaD/Gi0DLIiW4q0KjRT/rC5kJTx6eoQrezh3j+
         XlSjiNa5aLXY38KekR+qoqxwswyugBM9jsquGXcUxn+uFH00d8yxbc93YdH+cQqOZNcE
         D8mw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=BALCb4IQm/GwztxbFONFkzBgFbeC1YxSt8jC3/n5QF8=;
        b=va95/ya5HaMxlfAKNjVc5YFR9bx0n/u+1GxFDSW7IphIwncAkNoFaw05CsiPAASEau
         plFLao5emaJJp+Vd4Ldp87rKXmAo4NDcToqNQUvi4m96BB6Dvq2Kz98hKUjGMyu+vZYY
         1+VNSorsud/k37oZie33F9N3Ob//FIYuKLrGX3bQkMDQsMIRp37B5aSYJ83rt8D0SvMu
         1b6+JlpgLu4SHaPl9c7HxURD1n5mSV1XocT65PojS4S/sy3Hs8fuBM0Tdn46/YYLx85H
         aJpY48StWbvvPT59+MsrIAJFxENHa4Ye/fhLnBQ5QirojsLZcYVboffY4f+mG/KW5B65
         iDpA==
X-Gm-Message-State: AOAM533Jg8YEDDQpwWjb1LtnldvF7doCt98byisX8703u5mUDZDApZ7M
        UT09t3m8eWk4rE2YxcUOmfh6ebqMihP8S8G+f5rCjla1CSg=
X-Google-Smtp-Source: ABdhPJxkDQuQ5UmgB51ZHBEfNedFXZU7ke8KQffBjb21iLwnDUSUnBe5hv/Xp36E/v3SfZ9GoSJfBmmElw4hIi7OPiw=
X-Received: by 2002:a5b:bc1:: with SMTP id c1mr39737268ybr.669.1641308738036;
 Tue, 04 Jan 2022 07:05:38 -0800 (PST)
MIME-Version: 1.0
References: <20220104134512.18498-1-prabhakar.mahadev-lad.rj@bp.renesas.com> <CAHp75Vcx1Ey-SHBCgBh1RM=PTBRcncGOwAx9_6PL+sDJtzezvw@mail.gmail.com>
In-Reply-To: <CAHp75Vcx1Ey-SHBCgBh1RM=PTBRcncGOwAx9_6PL+sDJtzezvw@mail.gmail.com>
From:   "Lad, Prabhakar" <prabhakar.csengg@gmail.com>
Date:   Tue, 4 Jan 2022 15:05:12 +0000
Message-ID: <CA+V-a8uduHrVr4HWAgPt3YP_g27xhi4FdsrANn9S5mY0TBSvbg@mail.gmail.com>
Subject: Re: [PATCH v4] soc: ti: smartreflex: Use platform_get_irq_optional()
 to get the interrupt
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
Cc:     Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
        Nishanth Menon <nm@ti.com>,
        Santosh Shilimkar <ssantosh@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-arm Mailing List <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 4, 2022 at 2:50 PM Andy Shevchenko
<andy.shevchenko@gmail.com> wrote:
>
> On Tue, Jan 4, 2022 at 3:45 PM Lad Prabhakar
> <prabhakar.mahadev-lad.rj@bp.renesas.com> wrote:
> >
> > platform_get_resource(pdev, IORESOURCE_IRQ, ..) relies on static
> > allocation of IRQ resources in DT core code, this causes an issue
> > when using hierarchical interrupt domains using "interrupts" property
> > in the node as this bypasses the hierarchical setup and messes up the
> > irq chaining.
> >
> > In preparation for removal of static setup of IRQ resource from DT core
> > code use platform_get_irq_optional().
> >
> > While at it return 0 instead of returning ret in the probe success path.
>
> ...
>
> > +       ret = platform_get_irq_optional(pdev, 0);
> > +       if (ret < 0 && ret != -ENXIO) {
>
> > +               dev_err_probe(&pdev->dev, ret, "%s: failed to get IRQ resource\n", __func__);
> > +               return ret;
>
> return dev_err_probe(...); ?
>
Argh my bad.

Cheers,
Prabhakar
