Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0EE6C4AA60C
	for <lists+linux-kernel@lfdr.de>; Sat,  5 Feb 2022 03:55:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378988AbiBECzv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Feb 2022 21:55:51 -0500
Received: from dfw.source.kernel.org ([139.178.84.217]:51762 "EHLO
        dfw.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229807AbiBECzt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Feb 2022 21:55:49 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 59F8160C55;
        Sat,  5 Feb 2022 02:55:49 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AA1BBC004E1;
        Sat,  5 Feb 2022 02:55:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1644029748;
        bh=BQUS4mKdVMdQIuKV+9qmm5n95QdGCKeA5gbAJQNI5a4=;
        h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
        b=uG+rJszuNbiwN9nUKvB9AHrWF0wucl97LlmgSUSQEEq5PyV981G+OfIz3c3Atba61
         djk0cQoGfBOaqu2Yn4R7sqUuHXAHGzcXFGMDgVTN1mV74Swe/unZspxgfOEhkrbMrb
         pSHzBpWHyqt1h8rPjVnyZoCLrplCSwyz9Nf8QIRSGgyRGmO1nBnsDcqthzRd/x5i9r
         kq1UijJ1KPzqINzfjJR2egFHt8gjXUrRnI+G3AHRiu+pqYK5czmRDhj9ygQa9BbLVt
         Bwz93TBtA7IthgukYw1IRXJAt5oEd1gtLimfGDo1ehJX2fZSxzSosVHqHuiCHBKbfG
         KGW9zrHXn0okg==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <CAMhs-H9c8zF=v2tu5Y1OsFRP6esOi5zrUceqS_OUiJ=MSfCvRQ@mail.gmail.com>
References: <20220110114930.1406665-1-sergio.paracuellos@gmail.com> <YfE5MOkQRoHQV7Wf@kroah.com> <CAMhs-H8s0d=PswQDR86Tq-bQt634Z6rdFYHTE+DFepsthmKAYA@mail.gmail.com> <YfE7LNFuf79i3oAQ@kroah.com> <CAMhs-H9c8zF=v2tu5Y1OsFRP6esOi5zrUceqS_OUiJ=MSfCvRQ@mail.gmail.com>
Subject: Re: [PATCH v8 0/4] clk: ralink: make system controller a reset provider
From:   Stephen Boyd <sboyd@kernel.org>
Cc:     <linux-clk@vger.kernel.org>, John Crispin <john@phrozen.org>,
        linux-staging@lists.linux.dev, NeilBrown <neil@brown.name>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        linux-kernel <linux-kernel@vger.kernel.org>
To:     Greg KH <gregkh@linuxfoundation.org>,
        Sergio Paracuellos <sergio.paracuellos@gmail.com>
Date:   Fri, 04 Feb 2022 18:55:46 -0800
User-Agent: alot/0.10
Message-Id: <20220205025548.AA1BBC004E1@smtp.kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Sergio Paracuellos (2022-01-26 04:45:31)
> On Wed, Jan 26, 2022 at 1:14 PM Greg KH <gregkh@linuxfoundation.org> wrot=
e:
> >
> > On Wed, Jan 26, 2022 at 01:08:52PM +0100, Sergio Paracuellos wrote:
> > > On Wed, Jan 26, 2022 at 1:06 PM Greg KH <gregkh@linuxfoundation.org> =
wrote:
> > > >
> > > > On Mon, Jan 10, 2022 at 12:49:26PM +0100, Sergio Paracuellos wrote:
> > > > > Hi all,
> > > > >
> > > > > This patch series add minimal change to provide mt7621 resets pro=
perly
> > > > > defining them in the 'mediatek,mt7621-sysc' node which is the sys=
tem
> > > > > controller of the SoC and is already providing clocks to the rest=
 of
> > > > > the world.
> > > > >
> > > > > There is shared architecture code for all ralink platforms in 're=
set.c'
> > > > > file located in 'arch/mips/ralink' but the correct thing to do to=
 align
> > > > > hardware with software seems to define and add related reset code=
 to the
> > > > > already mainlined clock driver.
> > > > >
> > > > > After this changes, we can get rid of the useless reset controlle=
r node
> > > > > in the device tree and use system controller node instead where t=
he property
> > > > > '#reset-cells' has been added. Binding documentation for this nod=
eq has
> > > > > been updated with the new property accordly.
> > > > >
> > > > > This series also provide a bindings include header where all rela=
ted
> > > > > reset bits for the MT7621 SoC are defined.
> > > > >
> > > > > Also, please take a look to this review [0] to understand better =
motivation
> > > > > for this series.
> > > > >
> > > > > Regarding the way of merging this:
> > > > >  - I'd like patches 1 and 4 which are related going through stagi=
ng tree.
> > > >
> > > > Patches 1 and 4 now in the staging tree, thanks.
> > >
> > > Stephen wanted all to go through the CLK tree since PATCH 3 and 1 were
> > > also a dependency... Can we get all of them through the same tree,
> > > then? I am ok with both CLK or staging trees.
> >
> > That's fine with me if they all go through the CLK tree, but there will
> > be a merge issue that I already fixed up in my tree.  If you want me to
> > drop them, just let me know.
>=20
> Stephen, what do you prefer? Is it better all going through staging-tree =
then?
>=20

Sure take them through staging tree.

Acked-by: Stephen Boyd <sboyd@kernel.org>
