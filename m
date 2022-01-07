Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8E450487030
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jan 2022 03:10:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345299AbiAGCKh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Jan 2022 21:10:37 -0500
Received: from ams.source.kernel.org ([145.40.68.75]:34352 "EHLO
        ams.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229618AbiAGCKd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Jan 2022 21:10:33 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 32C2DB82490;
        Fri,  7 Jan 2022 02:10:32 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E932AC36AE3;
        Fri,  7 Jan 2022 02:10:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1641521431;
        bh=djRrn1BCkoZjoqC6mQjBa9SC3D/NEGTiHMDRuQlCKRk=;
        h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
        b=etWMUzXnVxiYjPMEZD1rJeLbDG2/xTA6oE5Jze6qz75s112D0bqXjTjYk8sw0kgda
         LrSe5d1bAlKWBvDKFF59iSjN4mwhe6sphKZvQ7pXZJ/NvUgl47W1NlgfOx5qqAk56E
         Pu0fBhVY+ihWCKvNM0jI2Fa8nPII/aKoxkCkh/YAyFo5tTZO4qKOfVXyPNvfC0pRrt
         /3uWAywDRGvwSN7Y9GX5ajatwd9Y/FQOYNYXiPBBP9sH9BsPAWo/fqWWAIgkEASaLk
         Krj1sSgly5EBzjOjdrOQ8XjbNPBxfy2eb79OvEYLy69K9Io1dTtqsKHvvSw2G3F4RH
         to/lAQ88f+CAw==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <CAMhs-H81xnaFqgTJT3jiNy_BBCuHhrA-t0A+0wMnp5Y0kFjGUQ@mail.gmail.com>
References: <20211107074200.18911-1-sergio.paracuellos@gmail.com> <CAMhs-H81xnaFqgTJT3jiNy_BBCuHhrA-t0A+0wMnp5Y0kFjGUQ@mail.gmail.com>
Subject: Re: [PATCH v5 0/4] clk: ralink: make system controller a reset provider
From:   Stephen Boyd <sboyd@kernel.org>
Cc:     linux-kernel <linux-kernel@vger.kernel.org>,
        John Crispin <john@phrozen.org>, linux-staging@lists.linux.dev,
        Greg KH <gregkh@linuxfoundation.org>,
        NeilBrown <neil@brown.name>,
        Philipp Zabel <p.zabel@pengutronix.de>
To:     COMMON CLK FRAMEWORK <linux-clk@vger.kernel.org>,
        Sergio Paracuellos <sergio.paracuellos@gmail.com>
Date:   Thu, 06 Jan 2022 18:10:29 -0800
User-Agent: alot/0.9.1
Message-Id: <20220107021030.E932AC36AE3@smtp.kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Sergio Paracuellos (2021-12-13 04:00:17)
> Hi Stephen,
>=20
> On Sun, Nov 7, 2021 at 8:42 AM Sergio Paracuellos
> <sergio.paracuellos@gmail.com> wrote:
> >
> > Hi all,
> >
> > This patch series add minimal change to provide mt7621 resets properly
> > defining them in the 'mediatek,mt7621-sysc' node which is the system
> > controller of the SoC and is already providing clocks to the rest of
> > the world.
> >
> > There is shared architecture code for all ralink platforms in 'reset.c'
> > file located in 'arch/mips/ralink' but the correct thing to do to align
> > hardware with software seems to define and add related reset code to the
> > already mainlined clock driver.
> >
> > After this changes, we can get rid of the useless reset controller node
> > in the device tree and use system controller node instead where the pro=
perty
> > '#reset-cells' has been added. Binding documentation for this nodeq has
> > been updated with the new property accordly.
> >
> > This series also provide a bindings include header where all related
> > reset bits for the MT7621 SoC are defined.
> >
> > Also, please take a look to this review [0] to understand better motiva=
tion

Is [0] a link?

> > for this series.
> >
> > Regarding the way of merging this:
> >  - I'd like patches 1 and 4 which are related going through staging tre=
e.
> >  - The other two (patches 2 and 3) can perfectly go through the clock t=
ree.
> >
> > Thanks in advance for your feedback.
> >
> > Changes in v5:
> >  - Move platform driver init process into 'arch_initcall' to be sure the
> >    rest of the world can get the resets available when needed (since PC=
Ie
> >    controller driver has been moved from staging into 'drivers/pci/cont=
roller'
> >    is probed earlier and reset was not available so it was returning
> >    -EPROBE_DEFER on firt try. Moving into 'arch_initcall' avoids the 'a=
 bit
> >    anoying' PCI first failed log trace.
>=20
> Gentle ping on this series.
>=20

It looks to largely be a reset controller patch series. Can you get
review from the reset maintainer?

RESET CONTROLLER FRAMEWORK
M:	Philipp Zabel <p.zabel@pengutronix.de>
S:	Maintained
