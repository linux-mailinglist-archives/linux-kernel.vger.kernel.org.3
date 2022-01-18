Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9BD8B49283A
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jan 2022 15:20:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244861AbiAROUR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Jan 2022 09:20:17 -0500
Received: from smtp2.axis.com ([195.60.68.18]:65353 "EHLO smtp2.axis.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S244543AbiAROUP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Jan 2022 09:20:15 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=axis.com; q=dns/txt; s=axis-central1; t=1642515615;
  x=1674051615;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=7HEsqUOVIqJxWzG7yXKFcL4CIP6bJXoVqpmVdtkc+xk=;
  b=CEJ622vrIARQkJY+wIfSE8GUjjBZ7pqiQVRlWS7y2p+uju3JLmbEqvKd
   FqXb21PaPW8bo1qLOrzzaFKgbU/UpSZOedgh7G6Lt981mDUrI9m6mF5xi
   hV5281r3boHEtsaC2xFO/KW8gCesUWejI/AhUThc8IcTKtEq3ofGq5Mtj
   atO7/2TPFQ+SITZbpK4LOWoDezMi2f1/kLqAsRJVFuTYg92J4KuX/q5PM
   hCWuZUXpCKVb1kMBXeUnGvENlCcCxCe35iMbeTud5Vn42QHeA7y9x0fTK
   4G7GodLmqIddQXYUXbFCFuV1fj8BQe1X4a/NscH6iqBfS628eOr/GxlU1
   w==;
Date:   Tue, 18 Jan 2022 15:20:13 +0100
From:   Vincent Whitchurch <vincent.whitchurch@axis.com>
To:     Rob Herring <robh@kernel.org>
CC:     "jdike@addtoit.com" <jdike@addtoit.com>,
        "richard@nod.at" <richard@nod.at>,
        "anton.ivanov@cambridgegreys.com" <anton.ivanov@cambridgegreys.com>,
        kernel <kernel@axis.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-um@lists.infradead.org" <linux-um@lists.infradead.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>
Subject: Re: [PATCH 2/2] um: Add devicetree support
Message-ID: <20220118142013.GA556@axis.com>
References: <20211208151123.29313-1-vincent.whitchurch@axis.com>
 <20211208151123.29313-3-vincent.whitchurch@axis.com>
 <YeF/Vbxo6fAt0WLp@robh.at.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <YeF/Vbxo6fAt0WLp@robh.at.kernel.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 14, 2022 at 02:49:09PM +0100, Rob Herring wrote:
> On Wed, Dec 08, 2021 at 04:11:23PM +0100, Vincent Whitchurch wrote:
> > --- /dev/null
> > +++ b/arch/um/kernel/dtb.c
> > @@ -0,0 +1,41 @@
> > +// SPDX-License-Identifier: GPL-2.0-only
> > +
> > +#include <linux/init.h>
> > +#include <linux/of_fdt.h>
> > +#include <linux/printk.h>
> > +#include <linux/memblock.h>
> > +#include <init.h>
> > +
> > +#include "um_arch.h"
> > +
> > +static char *dtb __initdata;
> > +
> > +void uml_dtb_init(void)
> > +{
> > +	long long size;
> > +	void *area;
> > +
> > +	area = uml_load_file(dtb, &size);
> > +	if (!area)
> > +		return;
> > +
> > +	if (!early_init_dt_scan(area)) {
> > +		pr_err("invalid DTB %s\n", dtb);
> > +		memblock_free(area, size);
> > +		return;
> > +	}
> > +
> > +	unflatten_device_tree();
> > +	early_init_fdt_scan_reserved_mem();
> 
> These should be reversed. early_init_fdt_scan_reserved_mem() works on 
> the flat tree. Reserved memory needs to be reserved before 
> unflatten_device_tree() starts allocating memory. Though I imagine that 
> doesn't really matter for UML.

I only tested dynamic allocation of reserved memory, and that,
unsuprisingly, works regardless of the order.  But I'll send a patch to
change it.

> Also, does the dtb end up in permanently allocated memory (i.e. not 
> init)? It needs to be if not.

The dtb is allocated with memblock_alloc() in arch/um/kernel/load_file.c
and is never freed (except on an error from early_init_dt_scan() as in
the above hunk), so I think this is already taken care of.
