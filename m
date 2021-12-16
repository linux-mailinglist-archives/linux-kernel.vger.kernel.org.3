Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6DF61477984
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Dec 2021 17:43:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239408AbhLPQnT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Dec 2021 11:43:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48644 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233222AbhLPQnR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Dec 2021 11:43:17 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 598B1C061574;
        Thu, 16 Dec 2021 08:43:17 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 20687B8251E;
        Thu, 16 Dec 2021 16:43:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7AAC8C36AE4;
        Thu, 16 Dec 2021 16:43:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1639672994;
        bh=LgQTlyAW4xfYuZMMNxVyYRwWbOjdmK4p7vB7JpGRETU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=CACEOvM4mp01nosNquGoSIS6E9hbSx4DeaZK+wYpaWo/Dw5GRLaStNNVmzrgm3oJs
         qlNaVem1UpBMg5AwG2jMRzEYZile36ja1GQZjOolUj+yOCIGzIUKNVdrlqpfHQ1osM
         /kXSVPDa9BHUML3kRRJLt3x7jAUXBR5CBhpxwZnZtZCu5q4oEFYsDBA/bvvcTINb5d
         F9vcErBHYfRoh4hMvDTEV5GX4lwWhH0ExTRq4KNVi1OCQxEiY3wuVbgdRwdwVupAAi
         Mr/x9Ch4/m8qa/S8lpTSsKQfHZdgTT5u8U+KWcDhWQhI+bparTIAI32pK0C0GySaic
         h6GKU37tS2ENw==
Date:   Thu, 16 Dec 2021 18:43:07 +0200
From:   Mike Rapoport <rppt@kernel.org>
To:     Stephen Boyd <swboyd@chromium.org>
Cc:     Rob Herring <robh+dt@kernel.org>, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org,
        Douglas Anderson <dianders@chromium.org>,
        Nicolas Boichat <drinkcat@chromium.org>,
        Quentin Perret <qperret@google.com>,
        Jan Kiszka <jan.kiszka@siemens.com>
Subject: Re: [PATCH v2] of/fdt: Don't worry about non-memory region overlap
 for no-map
Message-ID: <Ybtsm084H0g+cIOd@kernel.org>
References: <20211215072011.496998-1-swboyd@chromium.org>
 <Ybm6KQiS7B28QOSW@kernel.org>
 <CAE-0n53sMjF7-STAyn=snT5NSAMYSXhkBXJ4ay_fPiB_DbV_gg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAE-0n53sMjF7-STAyn=snT5NSAMYSXhkBXJ4ay_fPiB_DbV_gg@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 15, 2021 at 11:28:14AM -0800, Stephen Boyd wrote:
> Quoting Mike Rapoport (2021-12-15 01:49:29)
> > Hi,
> >
> > On Tue, Dec 14, 2021 at 11:20:11PM -0800, Stephen Boyd wrote:
> > > In commit 8a5a75e5e9e5 ("of/fdt: Make sure no-map does not remove
> > > already reserved regions") we returned -EBUSY when trying to mark
> > > regions as no-map when they're in the reserved memory node. This if
> > > condition will still trigger though if the DT has a /memreserve/ that
> > > completely subsumes the no-map memory carveouts in the reserved memory
> > > node. Let's only consider this to be a problem if we're trying to mark a
> > > region as no-map and it is actually memory. If it isn't memory,
> > > presumably it was removed from the memory map via /memreserve/ and thus
> > > can't be mapped anyway.
> >
> > I have no objections for this patch, but I afraid that this is a never
> > ending story of reservation vs nomap ordering and this won't be the last
> > fix in the area.
> 
> Ugh ok
> 
> >
> > I was toying with the idea to use flags in memblock.reserved to have
> > clearer view of how the reserved memory was used and then we won't need
> > to guess firmware intentions.
> > Thoughts?
> 
> My understanding of the commit being fixed was that it tried to detect
> bad DT where two reserved regions overlapped and different reserved
> memory regions stomped on each other. It certainly seems like that could
> be improved by recording what reserved memory region it belongs to, but
> within memblock I don't know if it cares. I thought memblock just cared
> to find out what is memory and what is supposed to be mapped into the
> page tables.

Except the creation of page tables, data in memblock is used to populate
the memory map and the free lists, so it's important to know where there is
memory, where there are holes and what memory is in use.

For now, any used memory will be listed in memblock.reserved, no matter if
it's used by firwmare, marked reserved in DT, occupied by the kernel code
or allocated early during boot before "real" mm is setup.

If we track the types of the memory reservations in memblock.reserved we'll
know which regions are /memreserve/, which are nomap and which are used by
kernel itself and so we'll have more deterministic view on what can be
allowed and what not. E.g it's ok to set nomap for a region that is already
reserved by firmware, but we cannot set nomap on memory used by the kernel.

For now this is a theory, I haven't even got to experiment with this.

> > > This silences a warning seen at boot on sc7180-trogdor.dtsi boards that
> > > have /memreserve/ populated by the bootloader where those reserved
> > > regions overlap with the reserved-memory carveouts that we have in DT
> > > for other purposes like communicating with remote processors.
> >
> > Do you mind adding the relevant pats of the device tree to the changelog?
> 
> Sure. Let me add the reserved memory snippet.

-- 
Sincerely yours,
Mike.
