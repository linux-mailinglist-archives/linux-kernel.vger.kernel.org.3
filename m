Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 117CE4AA325
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Feb 2022 23:32:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349689AbiBDWbr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Feb 2022 17:31:47 -0500
Received: from mga12.intel.com ([192.55.52.136]:28519 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S241600AbiBDWbp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Feb 2022 17:31:45 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1644013905; x=1675549905;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=HGBjV5jPwhewVnssfuBOuLFDiuJhz7IMd4YevOhryaY=;
  b=QRsHYaxNkFRZ6wYImVFXGpb3FlWO7hw3MVWTf3/DDAKCYVDMh6FNG7Yo
   blN6/HiOWrmdWjgcMGSYUeXvxE6ag+vzkirMyzuxrwK2wHTG5MYbcJKd9
   lRJNcRxC8Qz7sx6PO+Z2HlhCPRDyfCCsiQFEadIgPUOHPVOpvMDEbA513
   MUE1RBrfuDoYgTCUV8Xj1ntPjhfmjA1PCC9m74E6dwGdF7JOx8vvM9NUb
   WKCG4U80tukXxmAzswP38vgURd2bQIy33EIpU849ATRAbeexg8macfVcT
   6mMXmC1kQzuEbdVpdK0Z9SH8U91oujlsGNgdSFnLdvjFpDKz1ombkieEy
   Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10248"; a="228425287"
X-IronPort-AV: E=Sophos;i="5.88,344,1635231600"; 
   d="scan'208";a="228425287"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Feb 2022 14:31:45 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,344,1635231600"; 
   d="scan'208";a="483755642"
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga006.jf.intel.com with ESMTP; 04 Feb 2022 14:31:39 -0800
Received: by black.fi.intel.com (Postfix, from userid 1000)
        id 74E0B176; Sat,  5 Feb 2022 00:31:53 +0200 (EET)
Date:   Sat, 5 Feb 2022 01:31:53 +0300
From:   "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
To:     Thomas Gleixner <tglx@linutronix.de>,
        Tom Lendacky <thomas.lendacky@amd.com>
Cc:     mingo@redhat.com, bp@alien8.de, dave.hansen@intel.com,
        luto@kernel.org, peterz@infradead.org,
        sathyanarayanan.kuppuswamy@linux.intel.com, aarcange@redhat.com,
        ak@linux.intel.com, dan.j.williams@intel.com, david@redhat.com,
        hpa@zytor.com, jgross@suse.com, jmattson@google.com,
        joro@8bytes.org, jpoimboe@redhat.com, knsathya@kernel.org,
        pbonzini@redhat.com, sdeep@vmware.com, seanjc@google.com,
        tony.luck@intel.com, vkuznets@redhat.com, wanpengli@tencent.com,
        x86@kernel.org, linux-kernel@vger.kernel.org,
        Isaku Yamahata <isaku.yamahata@intel.com>
Subject: Re: [PATCHv2 26/29] x86/tdx: ioapic: Add shared bit for IOAPIC base
 address
Message-ID: <20220204223153.l2g3lpm4hxknwsof@black.fi.intel.com>
References: <20220124150215.36893-1-kirill.shutemov@linux.intel.com>
 <20220124150215.36893-27-kirill.shutemov@linux.intel.com>
 <871r0mvyqr.ffs@tglx>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <871r0mvyqr.ffs@tglx>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 02, 2022 at 02:33:16AM +0100, Thomas Gleixner wrote:
> On Mon, Jan 24 2022 at 18:02, Kirill A. Shutemov wrote:
> > ioremap()-created mappings such as virtio will be marked as
> > shared. However, the IOAPIC code does not use ioremap() and instead
> > uses the fixmap mechanism.
> >
> > Introduce a special fixmap helper just for the IOAPIC code.  Ensure
> > that it marks IOAPIC pages as "shared".  This replaces
> > set_fixmap_nocache() with __set_fixmap() since __set_fixmap()
> > allows custom 'prot' values.
> 
> Why is this a TDX only issue and SEV does not suffer from that?

Hm. Good question.

I think it is because FIXMAP_PAGE_NOCACHE does not have __ENC bit set so
the mapping is accessible to host. With TDX the logic is oposit:
everything is private if the bit is not set.

Tom, does it sound right?

BTW, I will drop 'if (cc_platform_has(CC_ATTR_GUEST_TDX))'.
pgprot_decrypted() is nop on AMD in this case.

-- 
 Kirill A. Shutemov
