Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 63DB449FD1F
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jan 2022 16:51:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349694AbiA1PvB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Jan 2022 10:51:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33742 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349686AbiA1PvA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Jan 2022 10:51:00 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D5E63C061714;
        Fri, 28 Jan 2022 07:50:59 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 9592AB80D5F;
        Fri, 28 Jan 2022 15:50:58 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9C049C340E6;
        Fri, 28 Jan 2022 15:50:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1643385057;
        bh=dHqKFVDo8/TjjOkINPkqqECV8kHJmc9ubDxhkDsKCRA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=UIgn+uYaIcZnrR3GGRYpPs9PW6Z1jWKIYs0QDXBkwYkumMfftCcyJFOPvS1SHGgY9
         TSbIG/p3kqKO1Xu80pNP/vh0TLex+Fw7YNdDY+AGe0c2DzHy2kwWTRnbZKzRJCUwCz
         KayXZKOHERpEOvHwSeSMCCTuIGIGuH3j1ATxeaOs=
Date:   Fri, 28 Jan 2022 16:50:54 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Adam Ford <aford173@gmail.com>
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
Subject: Re: [PATCH] clk: imx: Fix a NULL pointer dereference in
 imx_register_uart_clocks()
Message-ID: <YfQQ3iQhSxCiUQ2U@kroah.com>
References: <20220124165206.55059-1-zhou1615@umn.edu>
 <YfPCdPuoB3RYgzL8@kroah.com>
 <CAHCN7x+bvC70Y18j8tvSVZNjwipYu3xTvFo=AjKvYnmaucBiGg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHCN7x+bvC70Y18j8tvSVZNjwipYu3xTvFo=AjKvYnmaucBiGg@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 28, 2022 at 07:47:06AM -0600, Adam Ford wrote:
> On Fri, Jan 28, 2022 at 4:16 AM Greg KH <gregkh@linuxfoundation.org> wrote:
> >
> > On Tue, Jan 25, 2022 at 12:52:06AM +0800, Zhou Qingyang wrote:
> > > In imx_register_uart_clocks(), the global variable imx_uart_clocks is
> > > assigned by kcalloc() and there is a dereference of in the next for loop,
> > > which could introduce a NULL pointer dereference on failure of kcalloc().
> > >
> > > Fix this by adding a NULL check of imx_uart_clocks.
> > >
> > > This bug was found by a static analyzer.
> > >
> > > Builds with 'make allyesconfig' show no new warnings,
> > > and our static analyzer no longer warns about this code.
> > >
> > > Fixes: 379c9a24cc23 ("clk: imx: Fix reparenting of UARTs not associated with stdout")
> > > Signed-off-by: Zhou Qingyang <zhou1615@umn.edu>
> > > ---
> > > The analysis employs differential checking to identify inconsistent
> > > security operations (e.g., checks or kfrees) between two code paths
> > > and confirms that the inconsistent operations are not recovered in the
> > > current function or the callers, so they constitute bugs.
> > >
> > > Note that, as a bug found by static analysis, it can be a false
> > > positive or hard to trigger. Multiple researchers have cross-reviewed
> > > the bug.
> > >
> > >  drivers/clk/imx/clk.c | 2 ++
> > >  1 file changed, 2 insertions(+)
> > >
> > > diff --git a/drivers/clk/imx/clk.c b/drivers/clk/imx/clk.c
> > > index 7cc669934253..99249ab361d2 100644
> > > --- a/drivers/clk/imx/clk.c
> > > +++ b/drivers/clk/imx/clk.c
> > > @@ -173,6 +173,8 @@ void imx_register_uart_clocks(unsigned int clk_count)
> > >               int i;
> > >
> > >               imx_uart_clocks = kcalloc(clk_count, sizeof(struct clk *), GFP_KERNEL);
> > > +             if (!imx_uart_clocks)
> > > +                     return;
> > >
> > >               if (!of_stdout)
> > >                       return;
> > > --
> > > 2.25.1
> > >
> >
> > As stated before, umn.edu is still not allowed to contribute to the
> > Linux kernel.  Please work with your administration to resolve this
> > issue.
> 
> Greg,
> 
> In the interest of safety, I believe this patch is reasonable.

How can kcalloc really fail here?  Seriously, this is an impossible
thing to happen in real-world situations, you have to have special
fault-injection tooling to ever hit this in a system that is not just
frozen due to other problems.

> I
> wrote the original patch that is being fixed by this.  Would it be
> acceptable if I submitted the same patch with "suggested-by"
> associated with Zhou @ umn.edu?  I want to give credit where credit is
> due while still maintaining the rule that patches are not actually
> being accepted by umn.edu.

If you think this really is needed, then yes, feel free to rewrite it.

But rewrite it to be correct.  As it is, this is not correct.  If an
error happens because we are out of memory, actually handle that and do
not just return as if everything worked properly like this patch is
doing here.

The "suggestion" here is incorrect, which is the big problem here.
Whatever tool this group is using is wrong, and as a few people have
hinted to me offline, maybe they are just still messing around with us
and seeing how we behave.  Personally, I'm starting to get mad.

thanks,

greg k-h
