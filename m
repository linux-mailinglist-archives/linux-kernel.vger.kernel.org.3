Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F0FE74A76CE
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Feb 2022 18:26:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346275AbiBBR0E (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Feb 2022 12:26:04 -0500
Received: from mga07.intel.com ([134.134.136.100]:50299 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1346259AbiBBR0B (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Feb 2022 12:26:01 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1643822761; x=1675358761;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=ZSVrtiNlhnHwl+57H5e1XiLgphJAEdCHPegl0Qq59wA=;
  b=NFtDcT21noqurcpZwrZFmwua30UllGVfG7zTvLLaO+b4qifTlkCovPl7
   boxEd4qpx02johPUm/ZTzhRHrebr44lt9gUZTs9g/IvBJkT1JJtyeZBtU
   tK9awh8rtqa0e2ceUgu3aGp697pnUz1otKr86kZBgkGQlJ1bdkvQCsmsV
   RSoQ4pKt4dAERwOczJal7JWN50WVXYNWFcFaiMzPoXHQXOnPYjYwPDxEs
   vSJkTkFq5Bm4tStkWDkcfbXwrWfEnrwFaLERHX4r7QCQPYNNolKru7ROC
   /VvVnTcql1qjKY5+mlYAX+BV9y6cGBaHl88kRA2oU7X2dH6/0c1j9chWf
   w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10246"; a="311283404"
X-IronPort-AV: E=Sophos;i="5.88,337,1635231600"; 
   d="scan'208";a="311283404"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Feb 2022 09:20:18 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,337,1635231600"; 
   d="scan'208";a="480183492"
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga003.jf.intel.com with ESMTP; 02 Feb 2022 09:20:12 -0800
Received: by black.fi.intel.com (Postfix, from userid 1000)
        id 123C23B7; Wed,  2 Feb 2022 19:20:26 +0200 (EET)
Date:   Wed, 2 Feb 2022 20:20:26 +0300
From:   "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     mingo@redhat.com, bp@alien8.de, dave.hansen@intel.com,
        luto@kernel.org, peterz@infradead.org,
        sathyanarayanan.kuppuswamy@linux.intel.com, aarcange@redhat.com,
        ak@linux.intel.com, dan.j.williams@intel.com, david@redhat.com,
        hpa@zytor.com, jgross@suse.com, jmattson@google.com,
        joro@8bytes.org, jpoimboe@redhat.com, knsathya@kernel.org,
        pbonzini@redhat.com, sdeep@vmware.com, seanjc@google.com,
        tony.luck@intel.com, vkuznets@redhat.com, wanpengli@tencent.com,
        x86@kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCHv2 11/29] x86/boot: Allow to hook up alternative port I/O
 helpers
Message-ID: <20220202172026.ukebjmavzvahi556@black.fi.intel.com>
References: <20220124150215.36893-1-kirill.shutemov@linux.intel.com>
 <20220124150215.36893-12-kirill.shutemov@linux.intel.com>
 <87k0eexlde.ffs@tglx>
 <87ee4mxkpj.ffs@tglx>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87ee4mxkpj.ffs@tglx>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 01, 2022 at 11:53:28PM +0100, Thomas Gleixner wrote:
> On Tue, Feb 01 2022 at 23:39, Thomas Gleixner wrote:
> 
> > On Mon, Jan 24 2022 at 18:01, Kirill A. Shutemov wrote:
> >
> >> Port I/O instructions trigger #VE in the TDX environment. In response to
> >> the exception, kernel emulates these instructions using hypercalls.
> >>
> >> But during early boot, on the decompression stage, it is cumbersome to
> >> deal with #VE. It is cleaner to go to hypercalls directly, bypassing #VE
> >> handling.
> >>
> >> Add a way to hook up alternative port I/O helpers in the boot stub.
> >> All port I/O operations are routed via 'pio_ops'. By default 'pio_ops'
> >> initialized with native port I/O implementations.
> >>
> >> This is a preparation patch. The next patch will override 'pio_ops' if
> >> the kernel booted in the TDX environment.
> >>
> >> Signed-off-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
> >
> > Aside of Borislav's comments:
> >
> > Reviewed-by: Thomas Gleixner <tglx@linutronix.de>
> 
> Second thoughts.
> 
> > +#include <asm/shared/io.h>
> > +
> > +struct port_io_ops {
> > +	unsigned char (*inb)(int port);
> > +	unsigned short (*inw)(int port);
> > +	unsigned int (*inl)(int port);
> > +	void (*outb)(unsigned char v, int port);
> > +	void (*outw)(unsigned short v, int port);
> > +	void (*outl)(unsigned int v, int port);
> > +};
> 
> Can we please make that u8, u16, u32 instead of unsigned char,short,int?
> 
> That's the kernel convention for hardware related functions for many
> years now.

I inherited these prototypes from the main kernel I/O helpers. See patch
10/29.

Do you want 10/29 to be changed to use u8/16/32?

Maybe a separate patch to convert main kernel to u8/16/32 before
consolidation with boot stub?

-- 
 Kirill A. Shutemov
