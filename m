Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 232BD46580A
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Dec 2021 21:57:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353595AbhLAVAE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Dec 2021 16:00:04 -0500
Received: from ams.source.kernel.org ([145.40.68.75]:40178 "EHLO
        ams.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1353234AbhLAUza (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Dec 2021 15:55:30 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 639D6B81F44;
        Wed,  1 Dec 2021 20:52:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BD5AFC53FD3;
        Wed,  1 Dec 2021 20:52:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1638391926;
        bh=x7ZVGMw+VgKVg5dtycMRFZUdSfrIqgQObn/shIpb9pc=;
        h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
        b=BwnDkL79LT4WRUikUBuJMiZSKyrYSK+K/Qrid/GsnaSkPGbw6BZZT84NFAME9CDog
         80C/42w7wLq1o0i4CPp1xnzZfdzMVGRPq6K1OvrbY0EIJolHS7otbQZcU7TFBuJ5y+
         nj6Xd4Xdsatk2OwR1j8FZtdUym34RD6PVLZPWU7U9nCcAbq8uy8YlVFrUlHaTV+sef
         reehq/4d6Q0ITlijkdEs2/6/zpADCZmLdlG3xonEojRJ/DBibn4bEKELbtAfaHb0zY
         dS0vxhGWTwqqvTpgvgzfznZ8FKIonmBxtWFKozqQm+B2axFnF+ioLgo992N89xZOW1
         ejdn8Gt604vZg==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <CAEG3pNCxuPNwqvRWnMuFNMmiV0nZRwC+1M69jVC=uMyS5Jie6Q@mail.gmail.com>
References: <20211013172042.10884-1-semen.protsenko@linaro.org> <CAOMZO5CT+5=py=TBUMOZKRDsacNnGWV2TPBE7RtnZ3ocBBVReA@mail.gmail.com> <CAPLW+4ne9xDxDW=RCzjXURujGCwbCU5mOrfPJ6bn2wY41jstiw@mail.gmail.com> <CAPLW+4kp6G8QeMUggEhMLyB6gfbNpiyp1hn_+O76C_iVoAj53g@mail.gmail.com> <CAEG3pNCxuPNwqvRWnMuFNMmiV0nZRwC+1M69jVC=uMyS5Jie6Q@mail.gmail.com>
Subject: Re: [PATCH v6] clk: Add write operation for clk_parent debugfs node
From:   Stephen Boyd <sboyd@kernel.org>
Cc:     Russell King <linux@armlinux.org.uk>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Sylwester Nawrocki <s.nawrocki@samsung.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        Mike Tipton <mdtipton@codeaurora.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Andy Shevchenko <andy@kernel.org>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        linux-clk <linux-clk@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Fabio Estevam <festevam@gmail.com>
To:     Michael Turquette <mturquette@baylibre.com>,
        Sam Protsenko <semen.protsenko@linaro.org>
Date:   Wed, 01 Dec 2021 12:52:05 -0800
User-Agent: alot/0.9.1
Message-Id: <20211201205206.BD5AFC53FD3@smtp.kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Michael Turquette (2021-11-23 09:43:55)
> On Mon, Nov 22, 2021 at 10:03 AM Sam Protsenko
> <semen.protsenko@linaro.org> wrote:
> >
> > On Tue, 19 Oct 2021 at 16:32, Sam Protsenko <semen.protsenko@linaro.org=
> wrote:
> > >
> > > On Wed, 13 Oct 2021 at 21:04, Fabio Estevam <festevam@gmail.com> wrot=
e:
> > > >
> > > > Hi Sam,
> > > >
> > > > On Wed, Oct 13, 2021 at 2:20 PM Sam Protsenko
> > > > <semen.protsenko@linaro.org> wrote:
> > > > >
> > > > > Useful for testing mux clocks. One can write the index of the par=
ent to
> > > > > be set into clk_parent node, starting from 0. Example
> > > > >
> > > > >     # cd /sys/kernel/debug/clk/mout_peri_bus
> > > > >     # cat clk_possible_parents
> > > > >       dout_shared0_div4 dout_shared1_div4
> > > > >     # cat clk_parent
> > > > >       dout_shared0_div4
> > > > >     # echo 1 > clk_parent
> > > > >     # cat clk_parent
> > > > >       dout_shared1_div4
> > > > >
> > > > > CLOCK_ALLOW_WRITE_DEBUGFS has to be defined in drivers/clk/clk.c =
in
> > > > > order to use this feature.
> > > > >
> > > > > Signed-off-by: Sam Protsenko <semen.protsenko@linaro.org>
> > > > > Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>
> > > > > Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
> > > >
> > > > This is useful, thanks:
> > > >
> > > > Reviewed-by: Fabio Estevam <festevam@gmail.com>
> > >
> > > Hi Michael, Stephen,
> > >
> > > If there are no outstanding comments, can you please take this one?
> > >
> >
> > Bump.
>=20
> Looks good to me.
>=20
> Acked-by: Michael Turquette <mturquette@baylibre.com>
>=20
> Stephen, can you take it into your tree?

Sure thing.
