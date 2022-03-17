Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D0B444DCF27
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Mar 2022 21:10:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229551AbiCQUMF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Mar 2022 16:12:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34658 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229463AbiCQUMD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Mar 2022 16:12:03 -0400
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B888C2A044D
        for <linux-kernel@vger.kernel.org>; Thu, 17 Mar 2022 13:10:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1647547841; x=1679083841;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=PO7rZQUpiHjE1PK4XgExvh2CrqN1VHuGONGC/9p0COM=;
  b=P/kVrZbjZVz/K0UXxeU7DtJuzUzz1laPQVuAQyb/a7XxFKoQSEJpN8Nm
   AOU2/9fX+yODMI6hksb5hCt0zkAfVZ2xiHi2ZoCxshcJQIm02HxlTinwH
   DO1jVSUX18Z7FfRml9ILq7OA/UWVRDHbZSnYihiBSOvN2RV8sij+I8mMG
   pcV1ftoG34gek52Hrf27pUxPFSwCpbkPSXfgolR601e+Ed9LWWfIZ7Zer
   ++sfL7bFSL4Hv5cFJTMc5E3obc4PWdPmYobvNf6bCxqKUmw0AvArQekCh
   RmpBRTw/MruZCFI/PFaptt3XEqkcDJ7cpbnTgaygU73LEzNUaQqk0em3Y
   g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10289"; a="257160489"
X-IronPort-AV: E=Sophos;i="5.90,190,1643702400"; 
   d="scan'208";a="257160489"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Mar 2022 13:10:41 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,190,1643702400"; 
   d="scan'208";a="614118363"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga004.fm.intel.com with ESMTP; 17 Mar 2022 13:10:35 -0700
Received: by black.fi.intel.com (Postfix, from userid 1000)
        id E4A58107; Thu, 17 Mar 2022 22:10:54 +0200 (EET)
Date:   Thu, 17 Mar 2022 23:10:54 +0300
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
        thomas.lendacky@amd.com, brijesh.singh@amd.com, x86@kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCHv6 15/30] x86/boot: Port I/O: allow to hook up alternative
 helpers
Message-ID: <20220317201054.5wdykfru5hhvukvd@black.fi.intel.com>
References: <20220316020856.24435-1-kirill.shutemov@linux.intel.com>
 <20220316020856.24435-16-kirill.shutemov@linux.intel.com>
 <87czik22wk.ffs@tglx>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87czik22wk.ffs@tglx>
X-Spam-Status: No, score=-8.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 17, 2022 at 01:12:59PM +0100, Thomas Gleixner wrote:
> On Wed, Mar 16 2022 at 05:08, Kirill A. Shutemov wrote:
> > +#undef inb
> > +#undef inw
> > +#undef inl
> > +#undef outb
> > +#undef outw
> > +#undef outl
> > +
> > +struct port_io_ops {
> > +	u8 (*inb)(u16 port);
> > +	u16 (*inw)(u16 port);
> > +	u32 (*inl)(u16 port);
> > +	void (*outb)(u8 v, u16 port);
> > +	void (*outw)(u16 v, u16 port);
> > +	void (*outl)(u32 v, u16 port);
> 
> 	u8	(*inb)(u16 port);
> 	void	(*outb)(u8 v, u16 port);
> 	void	(*outw)(u16 v, u16 port);
> 
> is all what's used AFAICT.

Hm. Okay. I will drop the rest.

> > +};
> > +
> > +extern struct port_io_ops pio_ops;
> > +
> > +/*
> > + * Use the normal I/O instructions by default.
> > + * TDX guests override these to use hypercalls.
> > + */
> > +static inline void init_default_io_ops(void)
> > +{
> > +	pio_ops.inb = __inb;
> > +	pio_ops.inw = __inw;
> > +	pio_ops.inl = __inl;
> > +	pio_ops.outb = __outb;
> > +	pio_ops.outw = __outw;
> > +	pio_ops.outl = __outl;
> > +}
> 
> #define DEFINE_PORT_IO_OPS()		\
> 	struct port_io_ops pio_ops = {	\
>         	.inb	= __inb,	\
>         	.outb	= __outb,	\
>         	.outw	= __outw, }
> 
> Hmm?

This kind of initializations are problematic. They generate run-time
relacations that kernel cannot handle in the boot stub. Linker complains
about this:

	ld.lld: error: Unexpected run-time relocations (.rela) detected!

I will leave it as is, unless you have better ideas.

-- 
 Kirill A. Shutemov
