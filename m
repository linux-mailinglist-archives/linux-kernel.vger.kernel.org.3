Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AE3C84A78B1
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Feb 2022 20:27:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240099AbiBBT1E (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Feb 2022 14:27:04 -0500
Received: from mga05.intel.com ([192.55.52.43]:30049 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235908AbiBBT1D (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Feb 2022 14:27:03 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1643830023; x=1675366023;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=OUNxb+dsMQzkYohtFuYtyeG+odtGDuE51GNKzPIL6xU=;
  b=kpx2rU7xho5/d48JgXLiVHbiRXaarpm0h7im87HyeL/GWoe/iq0/FAPk
   ECJm/UHq3R2nFuivR0Jx8/klTmJDRcb3lZugH0/VlrrvKSQ4kVJ0YFZMr
   EtUQsZBka4094/oteUiNJhTxrKpDbnL8PyNThE7x75oqeqoNhl5d5s3h4
   8C53M6sUbWyy0SAh2fGmfFFA9juF/5IkXgbxEnqkSgHIniXKhmS+gIVDU
   heqyxl3zEfTvloJD4ciNv7YNfd0luq5P4JlqU3efRb9/8+8GLetdsV9R+
   kGACsZ5bI2Qo1fYfRRMk6lrVbYYwJ/4DEKecQgVYV539cBL6hwYwLu/Mi
   A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10246"; a="334362721"
X-IronPort-AV: E=Sophos;i="5.88,337,1635231600"; 
   d="scan'208";a="334362721"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Feb 2022 11:27:02 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,337,1635231600"; 
   d="scan'208";a="566134932"
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga001.jf.intel.com with ESMTP; 02 Feb 2022 11:26:56 -0800
Received: by black.fi.intel.com (Postfix, from userid 1000)
        id AAFD03B7; Wed,  2 Feb 2022 21:27:10 +0200 (EET)
Date:   Wed, 2 Feb 2022 22:27:10 +0300
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
Subject: Re: [PATCHv2 22/29] x86/tdx: Make pages shared in ioremap()
Message-ID: <20220202192710.d7k4pgqczpyrkers@black.fi.intel.com>
References: <20220124150215.36893-1-kirill.shutemov@linux.intel.com>
 <20220124150215.36893-23-kirill.shutemov@linux.intel.com>
 <87bkzqw1vr.ffs@tglx>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87bkzqw1vr.ffs@tglx>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 02, 2022 at 01:25:28AM +0100, Thomas Gleixner wrote:
> On Mon, Jan 24 2022 at 18:02, Kirill A. Shutemov wrote:
> 
> > In TDX guests, guest memory is protected from host access. If a guest
> > performs I/O, it needs to explicitly share the I/O memory with the host.
> >
> > Make all ioremap()ed pages that are not backed by normal memory
> > (IORES_DESC_NONE or IORES_DESC_RESERVED) mapped as shared.
> >
> > Since TDX memory encryption support is similar to AMD SEV architecture,
> > reuse the infrastructure from AMD SEV code.
> >
> > Add tdx_shared_mask() interface to get the TDX guest shared bitmask.
> >
> > pgprot_decrypted() is used by drivers (i915, virtio_gpu, vfio). Export
> > both pgprot_encrypted() and pgprot_decrypted().
> 
> How so?
> 
> # git grep pgprot_encrypted
> arch/x86/include/asm/pgtable.h:#define pgprot_encrypted(prot)   __pgprot(__sme_set(pgprot_val(prot)))
> arch/x86/mm/ioremap.c:          prot = pgprot_encrypted(prot);
> arch/x86/mm/ioremap.c:  return encrypted_prot ? pgprot_encrypted(prot)
> arch/x86/mm/mem_encrypt_amd.c:          protection_map[i] = pgprot_encrypted(protection_map[i]);
> arch/x86/mm/pat/set_memory.c:           cpa.mask_clr = pgprot_encrypted(cpa.mask_clr);
> arch/x86/platform/efi/quirks.c:                           pgprot_val(pgprot_encrypted(FIXMAP_PAGE_NORMAL)));
> fs/proc/vmcore.c:       prot = pgprot_encrypted(prot);
> include/linux/pgtable.h:#ifndef pgprot_encrypted
> include/linux/pgtable.h:#define pgprot_encrypted(prot)  (prot)
> 
> I cannot find any of the above mentioned subsystems in this grep
> output. Neither does this patch add any users which require those
> exports.

Try to grep pgprot_decrypted().

I guess we can get away not exporting pgprot_encrypted(), but this
asymmetry bothers me :)

-- 
 Kirill A. Shutemov
