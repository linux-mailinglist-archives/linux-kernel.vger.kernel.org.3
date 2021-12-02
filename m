Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ED05C46604C
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Dec 2021 10:25:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356404AbhLBJ2y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Dec 2021 04:28:54 -0500
Received: from foss.arm.com ([217.140.110.172]:59952 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1356342AbhLBJ2w (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Dec 2021 04:28:52 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 543BE139F;
        Thu,  2 Dec 2021 01:25:29 -0800 (PST)
Received: from FVFF77S0Q05N (unknown [10.57.65.131])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 364903F7D7;
        Thu,  2 Dec 2021 01:25:28 -0800 (PST)
Date:   Thu, 2 Dec 2021 09:25:20 +0000
From:   Mark Rutland <mark.rutland@arm.com>
To:     Rob Herring <robh@kernel.org>
Cc:     Calvin Zhang <calvinzhang.cool@gmail.com>,
        Frank Rowand <frowand.list@gmail.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH] of: unmap memory regions in /memreserve node
Message-ID: <YaiRAD40xCK7u3Hl@FVFF77S0Q05N>
References: <20211124133347.3861391-1-calvinzhang.cool@gmail.com>
 <YaapE8oys5zQEdD5@robh.at.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YaapE8oys5zQEdD5@robh.at.kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 30, 2021 at 04:43:31PM -0600, Rob Herring wrote:
> +linuxppc-dev
> 
> On Wed, Nov 24, 2021 at 09:33:47PM +0800, Calvin Zhang wrote:
> > Reserved memory regions in /memreserve node aren't and shouldn't
> > be referenced elsewhere. So mark them no-map to skip direct mapping
> > for them.
> 
> I suspect this has a high chance of breaking some platform. There's no 
> rule a region can't be accessed.

The subtlety is that the region shouldn't be explicitly accessed (e.g.
modified), but the OS is permitted to have the region mapped. In ePAPR this is
described as:

   This requirement is necessary because the client program is permitted to map
   memory with storage attributes specified as not Write Through Required, not
   Caching Inhibited, and Memory Coherence Required (i.e., WIMG = 0b001x), and
   VLE=0 where supported. The client program may use large virtual pages that
   contain reserved memory. However, the client program may not modify reserved
   memory, so the boot program may perform accesses to reserved memory as Write
   Through Required where conflicting values for this storage attribute are
   architecturally permissible.

Historically arm64 relied upon this for spin-table to work, and I *think* we
might not need that any more I agree that there's a high chance this will break
something (especially on 16K or 64K page size kernels), so I'd prefer to leave
it as-is.

If someone requires no-map behaviour, they should use a /reserved-memory entry
with a no-map property, which will work today and document their requirement
explicitly.

Thanks,
Mark.

> > Signed-off-by: Calvin Zhang <calvinzhang.cool@gmail.com>
> > ---
> >  drivers/of/fdt.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > diff --git a/drivers/of/fdt.c b/drivers/of/fdt.c
> > index bdca35284ceb..9e88cc8445f6 100644
> > --- a/drivers/of/fdt.c
> > +++ b/drivers/of/fdt.c
> > @@ -638,7 +638,7 @@ void __init early_init_fdt_scan_reserved_mem(void)
> >  		fdt_get_mem_rsv(initial_boot_params, n, &base, &size);
> >  		if (!size)
> >  			break;
> > -		early_init_dt_reserve_memory_arch(base, size, false);
> > +		early_init_dt_reserve_memory_arch(base, size, true);
> >  	}
> >  
> >  	fdt_scan_reserved_mem();
> > -- 
> > 2.30.2
> > 
> > 
