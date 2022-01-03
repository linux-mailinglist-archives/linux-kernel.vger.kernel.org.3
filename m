Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 097C148308A
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Jan 2022 12:30:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233010AbiACLaz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Jan 2022 06:30:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56066 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231569AbiACLax (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Jan 2022 06:30:53 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C2D9C061761;
        Mon,  3 Jan 2022 03:30:52 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 2E1936100C;
        Mon,  3 Jan 2022 11:30:52 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9187DC36AE9;
        Mon,  3 Jan 2022 11:30:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1641209451;
        bh=s4JR2PKBLO1tVWx+rPlFLK422umKNpRjMW7+1y8GNn0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=LnnZdglzh9rExOE4k8iZARSAnYynEFCHg8uVWFLsd/NG01vIDtibA5RhIq2LM8f3J
         mUrZIf6QOpgTbXufPqlxMHdKCm2Mgg0TKwVxhytz6Es6ZLDrPlsnbdOuRk/GrKsuq/
         nTf/+ru9WLam0rmr52ElCcVlL3XxDP5ezSqHlu59y7sIrbaCkRxCF6sH6Ncsb1AKAe
         5TTri0W35Z5d8ZjlFRtE73IAfhfD7r27RLPsOHAjTQZAplxVSNQlPBH4r1DNU6rlZC
         vAIIxwAIPcijBpO8/E4xHKIcBJmfPmPIFHVmx8LprDVGBEkOtM7RQGcdKxr9Mor1tB
         QNn3yjSMuKZdw==
Date:   Mon, 3 Jan 2022 19:30:44 +0800
From:   Shawn Guo <shawnguo@kernel.org>
To:     Marc Zyngier <maz@kernel.org>
Cc:     Vladimir Oltean <vladimir.oltean@nxp.com>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Leo Li <leoyang.li@nxp.com>, Biwen Li <biwen.li@nxp.com>,
        "Z.Q. Hou" <zhiqiang.hou@nxp.com>,
        Kurt Kanzenbach <kurt@linutronix.de>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>
Subject: Re: [PATCH v2 devicetree] Revert "arm64: dts: freescale: Fix
 'interrupt-map' parent address cells"
Message-ID: <20220103113043.GA14690@dragon>
References: <20211214135852.2934670-1-vladimir.oltean@nxp.com>
 <20211231181350.qwfnrwvdfnfssdjt@skbuf>
 <c5b9cec617100b891b7fceaee8655ba8@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c5b9cec617100b891b7fceaee8655ba8@kernel.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jan 02, 2022 at 01:08:28PM +0000, Marc Zyngier wrote:
> On 2021-12-31 18:13, Vladimir Oltean wrote:
> > Hello,
> > 
> > On Tue, Dec 14, 2021 at 03:58:52PM +0200, Vladimir Oltean wrote:
> > > This reverts commit 869f0ec048dc8fd88c0b2003373bd985795179fb. That
> > > updated the expected device tree binding format for the ls-extirq
> > > driver, without also updating the parsing code (ls_extirq_parse_map)
> > > to the new format.
> > > 
> > > The context is that the ls-extirq driver uses the standard
> > > "interrupt-map" OF property in a non-standard way, as suggested by
> > > Rob Herring during review:
> > > https://lore.kernel.org/lkml/20190927161118.GA19333@bogus/
> > > 
> > > This has turned out to be problematic, as Marc Zyngier discovered
> > > through commit 041284181226 ("of/irq: Allow matching of an
> > > interrupt-map
> > > local to an interrupt controller"), later fixed through commit
> > > de4adddcbcc2 ("of/irq: Add a quirk for controllers with their own
> > > definition of interrupt-map"). Marc's position, expressed on multiple
> > > opportunities, is that:
> > > 
> > > (a) [ making private use of the reserved "interrupt-map" name in a
> > >     driver ] "is wrong, by the very letter of what an interrupt-map
> > >     means. If the interrupt map points to an interrupt controller,
> > >     that's the target for the interrupt."
> > > https://lore.kernel.org/lkml/87k0g8jlmg.wl-maz@kernel.org/
> > > 
> > > (b) [ updating the driver's bindings to accept a non-reserved name for
> > >     this property, as an alternative, is ] "is totally pointless.
> > > These
> > >     machines have been in the wild for years, and existing DTs will be
> > >     there *forever*."
> > > https://lore.kernel.org/lkml/87ilvrk1r0.wl-maz@kernel.org/
> > > 
> > > Considering the above, the Linux kernel has quirks in place to deal
> > > with
> > > the ls-extirq's non-standard use of the "interrupt-map". These quirks
> > > may be needed in other operating systems that consume this device
> > > tree,
> > > yet this is seen as the only viable solution.
> > > 
> > > Therefore, the premise of the patch being reverted here is invalid.
> > > It doesn't matter whether the driver, in its non-standard use of the
> > > property, complies to the standard format or not, since this property
> > > isn't expected to be used for interrupt translation by the core.
> > > 
> > > This change restores LS1088A, LS2088A/LS2085A and LX2160A to their
> > > previous bindings, which allows these systems to continue to use
> > > external interrupt lines with the correct polarity.
> > > 
> > > Fixes: 869f0ec048dc ("arm64: dts: freescale: Fix 'interrupt-map'
> > > parent address cells")
> > > Signed-off-by: Vladimir Oltean <vladimir.oltean@nxp.com>
> > > ---
> > > v1->v2: remove the other 9 patches that rename "interrupt-map" to
> > >         "fsl,extirq-map", at Marc's suggestion.
> > 
> > Could this patch be considered for merging in v5.16? The problem is
> > going to be quite a bit more severe and tricky to fix otherwise. Thanks.
> 
> FWIW:
> 
> Acked-by: Marc Zyngier <maz@kernel.org>
> 
> Rob, Shawn, can you please queue this as an urgent fix for 5.16?

I would rather leave this to Rob, as I haven't heard anything from him
on this reverting (on his commit).

Shawn
