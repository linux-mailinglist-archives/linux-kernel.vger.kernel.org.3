Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2367C4C71CD
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Feb 2022 17:37:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235115AbiB1Qhp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Feb 2022 11:37:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44650 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229788AbiB1Qhm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Feb 2022 11:37:42 -0500
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E5A264706D
        for <linux-kernel@vger.kernel.org>; Mon, 28 Feb 2022 08:37:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1646066222; x=1677602222;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=9FeEydnMapu+ZhBBImuOhTDsk/PcwUc5kO2GwFXbvzY=;
  b=N2tu3U0EwCL2PgZvngkgzBtXhAbo5If4R2qaKG90N7AT022HWB/EnThI
   c58JXB1v6e5DXSiolsqxkhQkuYQGNT+O+j2ajNZetbyZNJbIoXgwCaaDz
   +eVbfTx2P+LN3TGuCAlYuPgdZ5tKhxr3OuWSOvoHdc/prQWpEfZhyt7DO
   tfiYy+KTqg9RGJth9rraAECDA6ao/8vZ6OZ7XUpZjNodAC4JTZNHiACn4
   YGlJvBtoO0dBDi3Qg6U2pEjM0eZFqh7jrcBjd9V18BfxH4h3C7jajNyvN
   1FUO/AiD8Oj0LW/AwZ21TeVL+moajJCImy7HCWQyTq/G3K8Cm6BGCcTLO
   A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10272"; a="240333921"
X-IronPort-AV: E=Sophos;i="5.90,142,1643702400"; 
   d="scan'208";a="240333921"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Feb 2022 08:37:02 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,142,1643702400"; 
   d="scan'208";a="640938471"
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga004.jf.intel.com with ESMTP; 28 Feb 2022 08:36:56 -0800
Received: by black.fi.intel.com (Postfix, from userid 1000)
        id 7052B142; Mon, 28 Feb 2022 18:37:13 +0200 (EET)
Date:   Mon, 28 Feb 2022 19:37:13 +0300
From:   "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
To:     Dan Williams <dan.j.williams@intel.com>
Cc:     Josh Poimboeuf <jpoimboe@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@intel.com>,
        Andy Lutomirski <luto@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Kuppuswamy Sathyanarayanan 
        <sathyanarayanan.kuppuswamy@linux.intel.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Andi Kleen <ak@linux.intel.com>,
        David Hildenbrand <david@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>, Juergen Gross <jgross@suse.com>,
        Jim Mattson <jmattson@google.com>,
        Joerg Roedel <joro@8bytes.org>,
        Kuppuswamy Sathyanarayanan <knsathya@kernel.org>,
        Paolo Bonzini <pbonzini@redhat.com>, sdeep@vmware.com,
        Sean Christopherson <seanjc@google.com>,
        "Luck, Tony" <tony.luck@intel.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        Brijesh Singh <brijesh.singh@amd.com>, X86 ML <x86@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCHv4 29/30] ACPICA: Avoid cache flush on TDX guest
Message-ID: <20220228163713.5eewdwcqhmulsp4z@black.fi.intel.com>
References: <20220224155630.52734-1-kirill.shutemov@linux.intel.com>
 <20220224155630.52734-30-kirill.shutemov@linux.intel.com>
 <20220227220526.3rrmy3u7j2xpelcn@treble>
 <CAPcyv4jqHQDhpSE24-Y6amC9Y-z4vVnXy6Lvo1j2hdCvzPACvQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAPcyv4jqHQDhpSE24-Y6amC9Y-z4vVnXy6Lvo1j2hdCvzPACvQ@mail.gmail.com>
X-Spam-Status: No, score=-4.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Feb 27, 2022 at 05:34:45PM -0800, Dan Williams wrote:
> On Sun, Feb 27, 2022 at 2:05 PM Josh Poimboeuf <jpoimboe@redhat.com> wrote:
> >
> > On Thu, Feb 24, 2022 at 06:56:29PM +0300, Kirill A. Shutemov wrote:
> > > +/*
> > > + * ACPI_FLUSH_CPU_CACHE() flushes caches on entering sleep states.
> > > + * It is required to prevent data loss.
> > > + *
> > > + * While running inside TDX guest, the kernel can bypass cache flushing.
> > > + * Changing sleep state in a virtual machine doesn't affect the host system
> > > + * sleep state and cannot lead to data loss.
> > > + *
> > > + * TODO: Is it safe to generalize this from TDX guests to all guest kernels?
> > > + */
> > > +#define ACPI_FLUSH_CPU_CACHE()                                       \
> > > +do {                                                         \
> > > +     if (!cpu_feature_enabled(X86_FEATURE_TDX_GUEST))        \
> > > +             wbinvd();                                       \
> > > +} while (0)
> >
> > If it's safe, why not do it for all VMs?  Is there something specific
> > about TDX which makes this more obviously known to be safe than for
> > regular VMs?
> >
> > The patch description and the above comment make it sound like "we're
> > not really sure this is safe, so we'll just use TDX as a testing ground
> > for the idea." Which doesn't really inspire a lot of confidence in the
> > stability of TD sleep states.
> 
> Agree, why is this marked as "TODO"? The cache flushes associated with
> ACPI sleep states are to flush cache before bare metal power loss to
> CPU caches and bare metal transition of DDR in self-refresh mode. If a
> cache flush is required it is the responsibility of the hypervisor.
> Either it is safe for all guests or it is unsafe for all guests, not
> TD specific.

Do we have "any VM" check? I can't find it right away.

-- 
 Kirill A. Shutemov
