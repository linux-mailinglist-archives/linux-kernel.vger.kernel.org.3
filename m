Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C55DD49FB09
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jan 2022 14:47:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242655AbiA1NrZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Jan 2022 08:47:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33396 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234242AbiA1NrU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Jan 2022 08:47:20 -0500
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com [IPv6:2a00:1450:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 81B55C061714;
        Fri, 28 Jan 2022 05:47:19 -0800 (PST)
Received: by mail-ej1-x629.google.com with SMTP id o12so16125279eju.13;
        Fri, 28 Jan 2022 05:47:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=kC5o2fNLt6ygrhXBorsw5Jbr7rYM1p4JZsABmYPmJrA=;
        b=eTKsnP/JHqCfDd19XPQdmmxRphUFecDk1mzHJ9/Vcyhx5Gh7sysyZgR43BDJPcphYA
         ra03ixyetH7qYRDfmfgQlhr8QC+sG1XPMci+8lfU33boBieCQzv+uKphLCcdUcee8c/n
         yiUAeMDsQ0P66Hz1u6YRikXSGoHpAq5RPNxkjhEdbPH3wRDTlBzyAnc7GzDJEefx+rxt
         6jXJsPXuj1r6lAqQbzTgr5MApt6Qqcnj9lelN2laHFj4+ykOpy8onyQfohADpE0YLDr5
         RcaB9gFXrEnoVbcFE+EIJw1lrfb6jj4UQZ+uBOi7d3oRwLg4VkLUTkZFeUQKgOeeqdpx
         TW8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=kC5o2fNLt6ygrhXBorsw5Jbr7rYM1p4JZsABmYPmJrA=;
        b=OyxzrO/lpEh+roRTnmsp3X71AkZ3wD4FT4mMl7mVQkrEhkeglONX1y9rD917OSU9mF
         XnfppszVRmWTDHeVxCJawxNW49pmwxEaz2cMuT5xW1qq5Jb/x6fktea6B411eMosoQ6m
         h96GDa/9Cj9nEIe7g2twG3JlL/842oGjB/K8nGxa+3kezsKC5iJ6sSkM3km68Y7GBaxt
         lW9qayEoGP50eS7urBtX96QhCjzhhZCNolgJs0YATzU1lOtRqbYCYFpDvKHPtqhDIjhy
         3FhYztDURfPjbW4DecapBBquo3Nx4xzdm+SnRBTC/Ci74BZcoOXXe6IaP9cMVCl++oZv
         ckbQ==
X-Gm-Message-State: AOAM533l+/jAfji04Zsd/kcvE7zV9ShdyygT28XNBgA0kZRgpw+AzqyQ
        OuiWqO7lErjqN2069FqOIouVwzlx8qZjrgAwEWs=
X-Google-Smtp-Source: ABdhPJzLW6Dz5jckH3hcEqbdz8uz9Y3Mwk4ir9/MbzB6WF6CfSQQn8d61hI/Vm2s9Xd7Xo+PHjcDHvDMqB+A8YgnEj8=
X-Received: by 2002:a17:907:3f99:: with SMTP id hr25mr6889917ejc.588.1643377637845;
 Fri, 28 Jan 2022 05:47:17 -0800 (PST)
MIME-Version: 1.0
References: <20220124165206.55059-1-zhou1615@umn.edu> <YfPCdPuoB3RYgzL8@kroah.com>
In-Reply-To: <YfPCdPuoB3RYgzL8@kroah.com>
From:   Adam Ford <aford173@gmail.com>
Date:   Fri, 28 Jan 2022 07:47:06 -0600
Message-ID: <CAHCN7x+bvC70Y18j8tvSVZNjwipYu3xTvFo=AjKvYnmaucBiGg@mail.gmail.com>
Subject: Re: [PATCH] clk: imx: Fix a NULL pointer dereference in imx_register_uart_clocks()
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     Zhou Qingyang <zhou1615@umn.edu>, kjlu@umn.edu,
        Abel Vesa <abel.vesa@nxp.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        linux-clk <linux-clk@vger.kernel.org>,
        arm-soc <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 28, 2022 at 4:16 AM Greg KH <gregkh@linuxfoundation.org> wrote:
>
> On Tue, Jan 25, 2022 at 12:52:06AM +0800, Zhou Qingyang wrote:
> > In imx_register_uart_clocks(), the global variable imx_uart_clocks is
> > assigned by kcalloc() and there is a dereference of in the next for loop,
> > which could introduce a NULL pointer dereference on failure of kcalloc().
> >
> > Fix this by adding a NULL check of imx_uart_clocks.
> >
> > This bug was found by a static analyzer.
> >
> > Builds with 'make allyesconfig' show no new warnings,
> > and our static analyzer no longer warns about this code.
> >
> > Fixes: 379c9a24cc23 ("clk: imx: Fix reparenting of UARTs not associated with stdout")
> > Signed-off-by: Zhou Qingyang <zhou1615@umn.edu>
> > ---
> > The analysis employs differential checking to identify inconsistent
> > security operations (e.g., checks or kfrees) between two code paths
> > and confirms that the inconsistent operations are not recovered in the
> > current function or the callers, so they constitute bugs.
> >
> > Note that, as a bug found by static analysis, it can be a false
> > positive or hard to trigger. Multiple researchers have cross-reviewed
> > the bug.
> >
> >  drivers/clk/imx/clk.c | 2 ++
> >  1 file changed, 2 insertions(+)
> >
> > diff --git a/drivers/clk/imx/clk.c b/drivers/clk/imx/clk.c
> > index 7cc669934253..99249ab361d2 100644
> > --- a/drivers/clk/imx/clk.c
> > +++ b/drivers/clk/imx/clk.c
> > @@ -173,6 +173,8 @@ void imx_register_uart_clocks(unsigned int clk_count)
> >               int i;
> >
> >               imx_uart_clocks = kcalloc(clk_count, sizeof(struct clk *), GFP_KERNEL);
> > +             if (!imx_uart_clocks)
> > +                     return;
> >
> >               if (!of_stdout)
> >                       return;
> > --
> > 2.25.1
> >
>
> As stated before, umn.edu is still not allowed to contribute to the
> Linux kernel.  Please work with your administration to resolve this
> issue.

Greg,

In the interest of safety, I believe this patch is reasonable.  I
wrote the original patch that is being fixed by this.  Would it be
acceptable if I submitted the same patch with "suggested-by"
associated with Zhou @ umn.edu?  I want to give credit where credit is
due while still maintaining the rule that patches are not actually
being accepted by umn.edu.

adam
