Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2A4FF4755AE
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Dec 2021 11:02:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236180AbhLOKCK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Dec 2021 05:02:10 -0500
Received: from dfw.source.kernel.org ([139.178.84.217]:53722 "EHLO
        dfw.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241453AbhLOKCH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Dec 2021 05:02:07 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 2795361871;
        Wed, 15 Dec 2021 10:02:07 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 38D8AC34605;
        Wed, 15 Dec 2021 10:02:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1639562526;
        bh=wPPt3YTgM3V3tQ8DUiilyDYIEOG7frejMbA+g84XeoY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=pSW/EOewQq8NtDeouDd7kv07T9fgxYMFWUhdfv6fm7dngWYi/rr8jbyxly9RxgKsj
         itWM0dTjMymYT4SF+rHspon+RSB7pmFHCuMdk42DiCJXttz6IFUDMoHw51MTg5Xsin
         uwZ0w7lpW1rGQsDpYNsvobb2b4J9YYeRddwooHuKJ6bfsz2dCzNteq3aYARA38au1v
         7Q3BOAlE/xHo/DPr1g3ks7ODi3MRf06Ki8R2XvqaP0NDNseFMxsSRzKYUo4/atANgX
         Ya0WIeuDUkD52RkwZKRbd9im67e+HeutG5aT6qDuV4nn5Xeldtw2YiIbtacgWJb3a0
         s/255UjdrVHJw==
Date:   Wed, 15 Dec 2021 12:01:59 +0200
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
Message-ID: <Ybm9F5AdCSGz6IwN@kernel.org>
References: <20211215072011.496998-1-swboyd@chromium.org>
 <Ybm6KQiS7B28QOSW@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Ybm6KQiS7B28QOSW@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 15, 2021 at 11:49:37AM +0200, Mike Rapoport wrote:
> 
> On Tue, Dec 14, 2021 at 11:20:11PM -0800, Stephen Boyd wrote:
> > @@ -482,9 +482,11 @@ static int __init early_init_dt_reserve_memory_arch(phys_addr_t base,
> >  	if (nomap) {
> >  		/*
> >  		 * If the memory is already reserved (by another region), we
> > -		 * should not allow it to be marked nomap.
> > +		 * should not allow it to be marked nomap, but don't worry
> > +		 * if the region isn't memory as it won't be mapped.
> >  		 */
> > -		if (memblock_is_region_reserved(base, size))
> > +		if (memblock_overlaps_region(&memblock.memory, base, size) &&
> > +		    memblock_is_region_reserved(base, size))

One more small thing. Maybe add pr_warn() here?

> >  			return -EBUSY;
> >  
> >  		return memblock_mark_nomap(base, size);

-- 
Sincerely yours,
Mike.
