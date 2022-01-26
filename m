Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C5FA149C95D
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jan 2022 13:14:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241130AbiAZMOm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Jan 2022 07:14:42 -0500
Received: from ams.source.kernel.org ([145.40.68.75]:45248 "EHLO
        ams.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233952AbiAZMOl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jan 2022 07:14:41 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 7670CB81CB4;
        Wed, 26 Jan 2022 12:14:40 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C0577C340E3;
        Wed, 26 Jan 2022 12:14:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1643199279;
        bh=9TdpfiG8asJ82uGUgUY1UeF0qecL7rx5bST9UA+eA8g=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=TqHMTDh7SfSuOuLANFV2iYwLYGrhMJUl8T/7afSUzYhWNevzMB+kXtAb1nMc0dfjN
         m0fnVF4RUrDqwYhgugg12UJ1lnZ4ix0H3b4fsHdrZqvRzhT/mj7FZt1dCIYs+W5c6S
         WqG4t4/cnSswVUXmYPupYAiacEk0+2ieuHkfYiIs=
Date:   Wed, 26 Jan 2022 13:14:36 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Sergio Paracuellos <sergio.paracuellos@gmail.com>
Cc:     "open list:COMMON CLK FRAMEWORK" <linux-clk@vger.kernel.org>,
        John Crispin <john@phrozen.org>, linux-staging@lists.linux.dev,
        NeilBrown <neil@brown.name>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Stephen Boyd <sboyd@kernel.org>
Subject: Re: [PATCH v8 0/4] clk: ralink: make system controller a reset
 provider
Message-ID: <YfE7LNFuf79i3oAQ@kroah.com>
References: <20220110114930.1406665-1-sergio.paracuellos@gmail.com>
 <YfE5MOkQRoHQV7Wf@kroah.com>
 <CAMhs-H8s0d=PswQDR86Tq-bQt634Z6rdFYHTE+DFepsthmKAYA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAMhs-H8s0d=PswQDR86Tq-bQt634Z6rdFYHTE+DFepsthmKAYA@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 26, 2022 at 01:08:52PM +0100, Sergio Paracuellos wrote:
> On Wed, Jan 26, 2022 at 1:06 PM Greg KH <gregkh@linuxfoundation.org> wrote:
> >
> > On Mon, Jan 10, 2022 at 12:49:26PM +0100, Sergio Paracuellos wrote:
> > > Hi all,
> > >
> > > This patch series add minimal change to provide mt7621 resets properly
> > > defining them in the 'mediatek,mt7621-sysc' node which is the system
> > > controller of the SoC and is already providing clocks to the rest of
> > > the world.
> > >
> > > There is shared architecture code for all ralink platforms in 'reset.c'
> > > file located in 'arch/mips/ralink' but the correct thing to do to align
> > > hardware with software seems to define and add related reset code to the
> > > already mainlined clock driver.
> > >
> > > After this changes, we can get rid of the useless reset controller node
> > > in the device tree and use system controller node instead where the property
> > > '#reset-cells' has been added. Binding documentation for this nodeq has
> > > been updated with the new property accordly.
> > >
> > > This series also provide a bindings include header where all related
> > > reset bits for the MT7621 SoC are defined.
> > >
> > > Also, please take a look to this review [0] to understand better motivation
> > > for this series.
> > >
> > > Regarding the way of merging this:
> > >  - I'd like patches 1 and 4 which are related going through staging tree.
> >
> > Patches 1 and 4 now in the staging tree, thanks.
> 
> Stephen wanted all to go through the CLK tree since PATCH 3 and 1 were
> also a dependency... Can we get all of them through the same tree,
> then? I am ok with both CLK or staging trees.

That's fine with me if they all go through the CLK tree, but there will
be a merge issue that I already fixed up in my tree.  If you want me to
drop them, just let me know.

thanks,

greg k-h
