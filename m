Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5E9EE470E6F
	for <lists+linux-kernel@lfdr.de>; Sat, 11 Dec 2021 00:12:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231503AbhLJXPs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Dec 2021 18:15:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38590 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229574AbhLJXPr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Dec 2021 18:15:47 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 05A99C061746;
        Fri, 10 Dec 2021 15:12:12 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id ADF11B82A15;
        Fri, 10 Dec 2021 23:12:10 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4E7EDC00446;
        Fri, 10 Dec 2021 23:12:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1639177929;
        bh=AQpFKURdDQ0uCduHpBvDW+QG08azMYiElBDJXQaaH5M=;
        h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
        b=oC7QfwkdIdSrkyruGn+afLgLbyfVTe6JIP2IapU1YFB0n6LEuj1n2BH1ycA7hPfm+
         UPnwEgYVyBg2+tptPSm/4/K/17ZjdiT0wAjqBwG0O+Cvl+3X0WQ+IPEpIWv9lJ6T2U
         vBgCPvO8DW0liCA0Dh7FZ7j/ENvqA+uaSvkU0ThIi0vJB142QGKhhrXkVt5Kame8TG
         TIssXI8iQiXZChCWYvuIs0BWbidenzpZoTCvASYN3WLoL/zJFgjBr/bbhG7bslTvFY
         ToxHNH059hJ+3v+/w61wYyX4UqBiKunnTACZ8JGTVIJSA0hjj+jBKcrQQGOYr1ipwF
         LWg4tHMWHP66w==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <CAMuHMdVf+EsN8n9iON186xCZETafGscOOB4AXOZpaH0Aui-2=A@mail.gmail.com>
References: <20211210014237.2130300-1-sboyd@kernel.org> <CAMuHMdVf+EsN8n9iON186xCZETafGscOOB4AXOZpaH0Aui-2=A@mail.gmail.com>
Subject: Re: [PATCH] clk: Emit a stern warning with writable debugfs enabled
From:   Stephen Boyd <sboyd@kernel.org>
Cc:     Michael Turquette <mturquette@baylibre.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-clk <linux-clk@vger.kernel.org>
To:     Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Fri, 10 Dec 2021 15:12:07 -0800
User-Agent: alot/0.9.1
Message-Id: <20211210231209.4E7EDC00446@smtp.kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Geert Uytterhoeven (2021-12-09 23:57:25)
> Hi Stephen,
>=20
> On Fri, Dec 10, 2021 at 2:42 AM Stephen Boyd <sboyd@kernel.org> wrote:
> > We don't want vendors to be enabling this part of the clk code and
> > shipping it to customers. Exposing the ability to change clk frequencies
> > and parents via debugfs is potentially damaging to the system if folks
> > don't know what they're doing. Emit a strong warning so that the message
> > is clear: don't enable this outside of development systems.
> >
> > Fixes: 37215da5553e ("clk: Add support for setting clk_rate via debugfs=
")
> > Cc: Geert Uytterhoeven <geert+renesas@glider.be>
> > Signed-off-by: Stephen Boyd <sboyd@kernel.org>
>=20
> Thanks for your patch!
>=20
> > --- a/drivers/clk/clk.c
> > +++ b/drivers/clk/clk.c
> > @@ -3383,6 +3383,24 @@ static int __init clk_debug_init(void)
> >  {
> >         struct clk_core *core;
> >
> > +#ifdef CLOCK_ALLOW_WRITE_DEBUGFS
> > +       pr_warn("\n");
> > +       pr_warn("******************************************************=
**************\n");
> > +       pr_warn("**     NOTICE NOTICE NOTICE NOTICE NOTICE NOTICE NOTIC=
E           **\n");
> > +       pr_warn("**                                                    =
            **\n");
> > +       pr_warn("**  WRITEABLE clk DebugFS SUPPORT HAS BEEN ENABLED IN =
THIS KERNEL **\n");
> > +       pr_warn("**                                                    =
            **\n");
> > +       pr_warn("** This means that this kernel is built to expose clk =
operations  **\n");
> > +       pr_warn("** such as parent or rate setting, enabling, disabling=
, etc.      **\n");
> > +       pr_warn("** to userspace, which may compromise security on your=
 system.    **\n");
> > +       pr_warn("**                                                    =
            **\n");
> > +       pr_warn("** If you see this message and you are not debugging t=
he          **\n");
> > +       pr_warn("** kernel, report this immediately to your vendor!    =
            **\n");
> > +       pr_warn("**                                                    =
            **\n");
> > +       pr_warn("**     NOTICE NOTICE NOTICE NOTICE NOTICE NOTICE NOTIC=
E           **\n");
> > +       pr_warn("******************************************************=
**************\n");
>=20
> So how many variants of such blocks do we have now in the kernel?
>=20

Quite a few!
